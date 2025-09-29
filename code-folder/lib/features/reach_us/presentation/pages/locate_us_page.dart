import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/common/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/reach_us/presentation/widgets/tab_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../widgets/filter_sheet.dart';

@RoutePage(name: "LocateUsPageRoute")
class LocateUsPage extends StatefulWidget {
  const LocateUsPage({super.key});

  @override
  State<LocateUsPage> createState() => _LocateUsPageState();
}

class _LocateUsPageState extends State<LocateUsPage> {
  GoogleMapController? mapController;

  int indexSelected = 0; // tab index
  int selectedIndex = -1; // highlighted list index
  //final ScrollController _scrollController = ScrollController();
  int selectedKioskIndex = 0;
  int selectedAtmIndex = 0;
  int selectedBranchIndex = 0;
  final AutoScrollController _scrollController = AutoScrollController();

  // mock data
  final List<Map<String, dynamic>> locationList = [
    {
      "name": "City Center Branch",
      "lat": 25.286106,
      "long": 51.534817,
      "type": "Branch",
    },
    {
      "name": "Villaggio Mall ATM",
      "lat": 25.258169,
      "long": 51.445125,
      "type": "ATM",
    },
    {
      "name": "Souq Waqif Kiosk",
      "lat": 25.287250,
      "long": 51.533356,
      "type": "kiosk",
    },
  ];
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers(); // load all by default
  }

  Future<BitmapDescriptor> _getIcon(String type) async {
    switch (type) {
      case "Branch":
        return await getResizedMarker(AssetPath.image.pin_branch, 130);
      case "ATM":
        return await getResizedMarker(AssetPath.image.pin_atm, 130);
      case "kiosk":
        return await getResizedMarker(AssetPath.image.pin_kiosk, 130);
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

  List<Map<String, dynamic>> filtered = [];

  Future<void> _loadMarkers() async {
    Set<Marker> newMarkers = {};

    // filter by tab
    filtered = indexSelected == 0
        ? locationList
        : locationList
              .where(
                (loc) =>
                    (indexSelected == 1 && loc["type"] == "Branch") ||
                    (indexSelected == 2 && loc["type"] == "ATM") ||
                    (indexSelected == 3 && loc["type"] == "kiosk"),
              )
              .toList();

    for (int i = 0; i < filtered.length; i++) {
      var loc = filtered[i];
      final icon = await _getIcon(loc["type"]);

      newMarkers.add(
        Marker(
          markerId: MarkerId("${loc["name"]}_$i"),
          position: LatLng(loc["lat"], loc["long"]),
          icon: icon,
          onTap: () => _onMarkerTap(i),
        ),
      );
      if (mapController != null) {
        await mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(loc["lat"], loc["long"]),
              zoom: 20, // you can adjust zoom level here
            ),
          ),
        );
      }
    }

    setState(() {
      markers = newMarkers;
    });
  }

  void _onMarkerTap(int index) async {
    // 1. Scroll the horizontal list
    await _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
    _scrollController.highlight(index);

    // 2. Zoom in and animate to marker
    final loc = locationList[index];
    if (mapController != null) {
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(loc["lat"], loc["long"]),
            zoom: 20, // you can adjust zoom level here
          ),
        ),
      );
    }
    await _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
      duration: const Duration(milliseconds: 400),
    );

    // 3. Update selection state
    setState(() {
      selectedIndex = index; // highlight card
    });
  }

  Future<void> _openMap({double? lat, double? lng, String? query}) async {
    Uri googleUrl;

    if (lat != null && lng != null) {
      googleUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
      );
    } else if (query != null) {
      googleUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}",
      );
    } else {
      throw 'No location data provided';
    }

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                filtered.first["lat"] ?? 25.286106,
                filtered.first["long"] ?? 51.534817,
              ),
              zoom: 1,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                LeadingWidget(title: "Locate Us"),

                SizedBox(height: 20),

                indexSelected == 0
                    ? TabWidget(
                        currentIndex: indexSelected,
                        indexSelected: (val) async {
                          if (val != null) {
                            setState(() => indexSelected = val);
                            await _loadMarkers(); // reload markers by filter
                          }
                        },
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TabWidget(
                              currentIndex: indexSelected,
                              indexSelected: (val) async {
                                if (val != null) {
                                  setState(() => indexSelected = val);
                                  await _loadMarkers(); // reload markers by filter
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 9),
                          GestureDetector(
                            onTap: () async {
                              // figure out which tab is active
                              final currentIndex = indexSelected == 1
                                  ? selectedBranchIndex
                                  : indexSelected == 2
                                  ? selectedAtmIndex
                                  : selectedKioskIndex;

                              final result = await CustomSheet.show<int>(
                                context: context,
                                child: FilterSheet(
                                  selectedTabIndex: indexSelected,
                                  selectedIndex:
                                      currentIndex, // ✅ pass the right index for this tab
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  if (indexSelected == 1) {
                                    selectedBranchIndex =
                                        result; // ✅ update only branches
                                  } else if (indexSelected == 2) {
                                    selectedAtmIndex =
                                        result; // ✅ update only ATMs
                                  } else {
                                    selectedKioskIndex =
                                        result; // ✅ update only kiosks
                                  }
                                });
                              }
                            },

                            // your child widget here
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              //  color: Colors.red,
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
                    //  color: Colors.red,
                    alignment: Alignment.center,
                    height: 108,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(filtered.length, (index) {
                        final loc = filtered[index];
                        final isSelected = selectedIndex == index;
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
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                alignment: Alignment.center,
                                // margin: EdgeInsets.all(8),
                                //  width: 220,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.shade50
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    //alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              CustomSheet.show(
                                                context: context,
                                                child: ItemSearchSheet(
                                                  typeSearch:
                                                      filtered[index]["type"],
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AssetPath
                                                      .image
                                                      .branchDefaultImage,
                                                  width: 92,
                                                  height: 92,
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        UiTextNew.customRubik(
                                                          filtered[index]["type"],
                                                          color: DefaultColors
                                                              .grayBase,
                                                          fontSize: 14,
                                                        ),
                                                        UiTextNew.b15Medium(
                                                          " Open",
                                                          color: DefaultColors
                                                              .greenBase,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),
                                                    UiTextNew.customRubik(
                                                      "City Center, Doha",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 11,
                                                    ),
                                                    SizedBox(height: 4),
                                                    UiTextNew.customRubik(
                                                      "Industrial Area, Qatar",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 4),
                                                    UiTextNew.customRubik(
                                                      "Nearest",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                ";;;;;;;;;;;;;;;;;;;;;;;;;;;",
                                              );
                                              _openMap(query: "Doha, Qatar");
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  AssetPath
                                                      .image
                                                      .navigationImage,
                                                  width: 32,
                                                  height: 32,
                                                ),
                                                SizedBox(height: 2),
                                                UiTextNew.custom(
                                                  "Directions",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: DefaultColors
                                                      .blueLightBase,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
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
