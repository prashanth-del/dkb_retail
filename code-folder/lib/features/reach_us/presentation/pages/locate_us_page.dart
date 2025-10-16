import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/common/presentation/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/reach_us/presentation/widgets/tab_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../../domain/entities/locate_us_info_branche.dart';
import '../controller/reach_us_providers.dart';
import '../controller/state/reach_notifier.dart';
import '../widgets/card_map_item.dart';
import '../widgets/filter_sheet.dart';

@RoutePage(name: "LocateUsPageRoute")
class LocateUsPage extends ConsumerStatefulWidget {
  const LocateUsPage({super.key});

  @override
  ConsumerState<LocateUsPage> createState() => _LocateUsPageState();
}

class _LocateUsPageState extends ConsumerState<LocateUsPage> {
  late List<LocateUsInfoBranche> branches;
  late List<LocateUsInfoBranche> atms;
  late List<LocateUsInfoBranche> kiosks;
  GoogleMapController? mapController;

  int indexSelected =
      0; // 0 All, 1 Branch, 2 ATM, 3 Kiosk (keeps legacy mapping)
  int selectedIndex = -1; // highlighted list index in carousel
  int selectedBranchIndex =
      0; // filter index for branches (0=All,1=Nearest,2...branchName)
  int selectedAtmIndex =
      0; // filter index for ATMs (0=All,1=Nearest,2...feature)
  int selectedKioskIndex = 0; // filter index for kiosks (0=All,1=Nearest)
  final AutoScrollController _scrollController = AutoScrollController();

  Set<Marker> markers = {};
  List filtered = [];
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    final reachUs = ref.read(reachUsNotifierProvider);
    branches = reachUs.branches;
    atms = reachUs.atms;
    kiosks = reachUs.kiosks;
    // initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMarkers();
    });
  }

  Future<BitmapDescriptor> _getIcon(String type) async {
    switch (type) {
      case "Branch":
        return await getResizedMarker(AssetPath.image.pin_branch, 100);
      case "ATM":
        return await getResizedMarker(AssetPath.image.pin_atm, 100);
      case "kiosk":
        return await getResizedMarker(AssetPath.image.pin_kiosk, 100);
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  Future<BitmapDescriptor> getResizedMarker(String assetPath, int width) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? resizedData = await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }

  // Helper to get the filter title for a tab+selectedIndex (rebuilds same list as FilterSheet)
  String _filterTitleForTab(int tab, int selIndex) {
    final reachUsState = ref.read(reachUsNotifierProvider);
    if (tab == 1) {
      // Branches
      final List<String> titles = [
        DefaultString.instance.allBranchesTitle,
        DefaultString.instance.nearestTitle,
        ...reachUsState.branches.map((b) => b.fullAddress?.trim() ?? "Branch"),
      ].toList();
      if (selIndex >= 0 && selIndex < titles.length) return titles[selIndex];
      return titles.first;
    } else if (tab == 2) {
      // ATMs
      final hasCashDeposit = reachUsState.atms.any((a) => a.cashDeposit == 1);
      final hasCashOut = reachUsState.atms.any((a) => a.cashOut == 1);
      final hasCheque = reachUsState.atms.any((a) => a.chequeDeposit == 1);
      final hasSpecial = reachUsState.atms.any((a) => a.disablePeople == 1);

      final List<String> titles = [
        DefaultString.instance.allAtmsTitle,
        DefaultString.instance.nearestTitle,
        if (hasCashDeposit) DefaultString.instance.cashDepositTitle,
        if (hasCashOut) DefaultString.instance.cashWithdrawalsTitle,
        if (hasCheque) DefaultString.instance.chequeDepositTitle,
        if (hasSpecial) DefaultString.instance.specialNeedsTitle,
      ];
      if (selIndex >= 0 && selIndex < titles.length) return titles[selIndex];
      return titles.first;
    } else {
      // Kiosks
      final List<String> titles = [
        DefaultString.instance.allKiosksTitle,
        DefaultString.instance.nearestTitle,
      ];
      if (selIndex >= 0 && selIndex < titles.length) return titles[selIndex];
      return titles.first;
    }
  }

  Future<void> _loadMarkers() async {
    final reachUs = ref.read(reachUsNotifierProvider);
    final reachUsNotifier = ref.read(reachUsNotifierProvider.notifier);
    final currentLocation = reachUs.currentLocation;

    branches = reachUs.branches;
    atms = reachUs.atms;
    kiosks = reachUs.kiosks;

    // Get filtered list based on tab & filter
    filtered = _getFilteredLocations(
      tabIndex: indexSelected,
      branchIndex: selectedBranchIndex,
      atmIndex: selectedAtmIndex,
      kioskIndex: selectedKioskIndex,
      reachUsNotifier: reachUsNotifier,
      currentLocation: currentLocation,
    );

    // Build markers
    final newMarkers = <Marker>{};
    for (int i = 0; i < filtered.length; i++) {
      final loc = filtered[i];
      if (loc["lat"] == null || loc["long"] == null) continue;
      final icon = await _getIcon(loc["type"]);
      newMarkers.add(
        Marker(
          markerId: MarkerId("${loc["id"]}_${loc["type"]}_$i"),
          position: LatLng(loc["lat"], loc["long"]),
          icon: icon,
          onTap: () => _onMarkerTap(i),
        ),
      );
    }

    // Move camera to first item if available
    // Move camera to default or first marker (only first time)
    if (mapController != null) {
      if (_isFirstLoad) {
        // Only first time: move to default location
        await mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(const LatLng(25.3343230, 51.4676050), 10),
        );
        _isFirstLoad = false; // ensure it won’t happen again
      } else if (filtered.isNotEmpty) {
        // Normal behavior after first load
        final first = filtered.first;
        await mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(first["lat"], first["long"]), 10),
        );
      }
    }

    // if (filtered.isNotEmpty && mapController != null) {
    //   final first = filtered.first;
    //   await mapController!.animateCamera(
    //     CameraUpdate.newLatLngZoom(LatLng(first["lat"], first["long"]), 15),
    //     //CameraUpdate.newLatLngZoom(LatLng(25.3343230, 51.4676050), 10),
    //   );
    // }

    setState(() {
      markers = newMarkers;
      selectedIndex = -1;
    });
  }

  /// Returns a unified filtered list of Branch/ATM/Kiosk based on selected tab & filters
  List _getFilteredLocations({
    required int tabIndex,
    required int branchIndex,
    required int atmIndex,
    required int kioskIndex,
    required ReachUsNotifier reachUsNotifier,
    required LatLng? currentLocation,
  }) {
    switch (tabIndex) {
      case 0:
        // All
        return [
          ...branches.map(_mapBranch),
          ...atms.map(_mapAtm),
          ...kiosks.map(_mapKiosk),
        ].where((m) => m["lat"] != null && m["long"] != null).toList();

      case 1:
        return _filterBranches(branchIndex, reachUsNotifier, currentLocation);

      case 2:
        return _filterAtms(atmIndex, reachUsNotifier, currentLocation);

      case 3:
        return _filterKiosks(kioskIndex, reachUsNotifier, currentLocation);

      default:
        return [];
    }
  }

  /// Generic mapping helpers
  Map<String, dynamic> _mapBranch(LocateUsInfoBranche b) {
    final reachUsNotifier = ref.read(reachUsNotifierProvider.notifier);
    final reachUs = ref.read(reachUsNotifierProvider);
    final currentLocation = reachUs.currentLocation;

    bool isNearest = false;
    if (currentLocation != null) {
      final nearest = reachUsNotifier.findNearestBranch(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      isNearest = nearest!.locatorType! == b.locatorType;
    }
    return {
      "type": "Branch",
      "id": b.locatorType,
      "name": b.fullAddress ?? "",
      "lat": b.coordinates?.latitude,
      "long": b.coordinates?.longitude,
      "raw": b,
      "country": b.country,
      "address": b.address,
      "workingHours": b.workingHours,
      "isNearest": isNearest,
      "status": b.status,
    };
  }

  Map<String, dynamic> _mapAtm(LocateUsInfoBranche a) {
    final reachUsNotifier = ref.read(reachUsNotifierProvider.notifier);
    final reachUs = ref.read(reachUsNotifierProvider);
    final currentLocation = reachUs.currentLocation;

    bool isNearest = false;
    if (currentLocation != null) {
      final nearest = reachUsNotifier.findNearestBranch(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      isNearest = nearest!.locatorType == a.locatorType;
    }
    return {
      "type": "ATM",
      "id": a.locatorType,
      "name": a.fullAddress ?? "",
      "lat": a.coordinates!.latitude,
      "long": a.coordinates!.longitude,
      "raw": a,
      "country": a.country,
      "address": a.fullAddress,
      "workingHours": a.workingHours,
      "timing": a.timing,
      "isNearest": isNearest,
      "status": a.status,
    };
  }

  Map<String, dynamic> _mapKiosk(LocateUsInfoBranche k) {
    final reachUsNotifier = ref.read(reachUsNotifierProvider.notifier);
    final reachUs = ref.read(reachUsNotifierProvider);
    final currentLocation = reachUs.currentLocation;

    bool isNearest = false;
    if (currentLocation != null) {
      final nearest = reachUsNotifier.findNearestBranch(
        currentLocation.latitude,
        currentLocation.longitude!,
      );
      isNearest = nearest!.locatorType == k.locatorType;
    }
    return {
      "type": "kiosk",
      "id": k.locatorType,
      "name": k.fullAddress ?? "",
      "lat": k.coordinates?.latitude,
      "long": k.coordinates?.longitude,
      "raw": k,
      "country": k.country,
      "address": k.address,

      "workingHours": k.workingHours,
      "isNearest": isNearest,
      "status": k.status,
    };
  }

  /// Filtering helpers
  List<Map<String, dynamic>> _filterBranches(
    int selectedIndex,
    ReachUsNotifier notifier,
    LatLng? currentLocation,
  ) {
    final title = _filterTitleForTab(1, selectedIndex);
    if (title == DefaultString.instance.nearestTitle &&
        currentLocation != null) {
      final nearest = notifier.findNearestBranch(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      if (nearest != null && nearest.coordinates != null)
        return [_mapBranch(nearest)];
    } else if (title != DefaultString.instance.allBranchesTitle) {
      final match = branches.firstWhere(
        (b) => (b.fullAddress ?? "").trim() == title,
        orElse: () => branches.isNotEmpty ? branches.first : branches.first,
      );
      return [_mapBranch(match)];
    }
    return branches
        .map(_mapBranch)
        .where((m) => m["lat"] != null && m["long"] != null)
        .toList();
  }

  List<Map<String, dynamic>> _filterAtms(
    int selectedIndex,
    ReachUsNotifier notifier,
    LatLng? currentLocation,
  ) {
    final title = _filterTitleForTab(2, selectedIndex);

    List<LocateUsInfoBranche> source = [];
    if (title == DefaultString.instance.nearestTitle &&
        currentLocation != null) {
      final nearest = notifier.findNearestAtm(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      if (nearest != null) source = [nearest];
    } else if (title == DefaultString.instance.allAtmsTitle) {
      source = atms;
    } else {
      // feature filters
      switch (title) {
        case "Cash Deposit": // todo change this from i18 later
          source = atms.where((a) => a.cashDeposit == 1).toList();
          break;
        case "Cash Withdrawals":
          source = atms.where((a) => a.cashOut == 1).toList();
          break;
        case "Cheque Deposit":
          source = atms.where((a) => a.chequeDeposit == 1).toList();
          break;
        case "Special Needs":
          source = atms.where((a) => a.disablePeople == 1).toList();
          break;
        default:
          source = atms;
      }
    }
    return source
        .map(_mapAtm)
        .where((m) => m["lat"] != null && m["long"] != null)
        .toList();
  }

  List<Map<String, dynamic>> _filterKiosks(
    int selectedIndex,
    ReachUsNotifier notifier,
    LatLng? currentLocation,
  ) {
    final title = _filterTitleForTab(3, selectedIndex);
    if (title == DefaultString.instance.nearestTitle &&
        currentLocation != null) {
      final nearest = notifier.findNearestKiosk(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      if (nearest != null) return [_mapKiosk(nearest)];
    }
    return kiosks
        .map(_mapKiosk)
        .where((m) => m["lat"] != null && m["long"] != null)
        .toList();
  }

  void _onMarkerTap(int index) async {
    if (index < 0 || index >= filtered.length) return;

    await _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
    _scrollController.highlight(index);

    final loc = filtered[index];
    if (mapController != null && loc["lat"] != null && loc["long"] != null) {
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(loc["lat"], loc["long"]), zoom: 20),
        ),
      );
    }

    await _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 400),
    );

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reachUsNotifier = ref.watch(reachUsNotifierProvider.notifier);
    final tabs = reachUsNotifier.tabsList;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                // if filtered empty, fallback to Doha coords
                filtered.isNotEmpty
                    ? (filtered.first["lat"] ?? 25.286106)
                    : 25.286106,
                filtered.isNotEmpty
                    ? (filtered.first["long"] ?? 51.534817)
                    : 51.534817,
              ),
              zoom: 13,
            ),
            markers: markers,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 30),
                LeadingWidget(title: DefaultString.instance.locateUs),
                const SizedBox(height: 20),

                indexSelected == 0
                    ? TabWidget(
                        filterList: tabs,
                        isImage: false,
                        currentIndex: indexSelected,
                        indexSelected: (val) async {
                          if (val != null) {
                            setState(() {
                              indexSelected = val;
                              selectedIndex = -1;
                            });
                            await _loadMarkers();
                            if (filtered.isNotEmpty) {
                              _scrollController.scrollToIndex(
                                0,
                                preferPosition: AutoScrollPosition.begin,
                              );
                            }
                          }
                        },
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TabWidget(
                              filterList: tabs,
                              isImage: false,
                              currentIndex: indexSelected,
                              indexSelected: (val) async {
                                if (val != null) {
                                  setState(() {
                                    indexSelected = val;
                                    selectedIndex = -1;
                                  });
                                  await _loadMarkers();
                                  if (filtered.isNotEmpty) {
                                    _scrollController.scrollToIndex(
                                      0,
                                      preferPosition: AutoScrollPosition.begin,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 9),
                          GestureDetector(
                            onTap: () async {
                              // figure out which tab is active and pass correct selectedIndex
                              final currentIndex = indexSelected == 1
                                  ? selectedBranchIndex
                                  : indexSelected == 2
                                  ? selectedAtmIndex
                                  : selectedKioskIndex;

                              final result = await CustomSheet.show<int>(
                                context: context,
                                child: FilterSheet(
                                  selectedTabIndex: indexSelected,
                                  selectedIndex: currentIndex,
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  if (indexSelected == 1) {
                                    selectedBranchIndex = result;
                                  } else if (indexSelected == 2) {
                                    selectedAtmIndex = result;
                                  } else {
                                    selectedKioskIndex = result;
                                  }
                                });

                                // reapply filter
                                await _loadMarkers();

                                // scroll carousel to first
                                if (filtered.isNotEmpty) {
                                  _scrollController.scrollToIndex(
                                    0,
                                    preferPosition: AutoScrollPosition.begin,
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/locate_image/Filter.png",
                                fit: BoxFit.contain,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                Spacer(),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 123,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final loc = filtered[index];
                        final isSelected = selectedIndex == index;
                        String addressText = "";
                        // Branch = bankBranchName, ATM = fullAddress, Kiosk = name
                        return AutoScrollTag(
                          key: ValueKey(index),
                          controller: _scrollController,
                          index: index,
                          highlightColor: Colors.black.withOpacity(0.1),
                          child: GestureDetector(
                            onTap: () async {
                              mapController?.animateCamera(
                                CameraUpdate.newLatLng(
                                  LatLng(loc["lat"], loc["long"]),
                                ),
                              );
                              await _scrollController.scrollToIndex(
                                index,
                                preferPosition: AutoScrollPosition.middle,
                                duration: const Duration(milliseconds: 400),
                              );
                              setState(() => selectedIndex = index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              child: ItemListWidget(
                                isSelected: isSelected,
                                loc: loc,
                                addressText: addressText,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
