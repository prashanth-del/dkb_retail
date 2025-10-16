import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/reach_us/data/models/fetch_locate_us_info_request.dart';
import 'package:dkb_retail/features/reach_us/domain/entities/locate_us_info.dart';
import 'package:dkb_retail/features/reach_us/presentation/state/fetch_locate_us_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/router/app_router.dart';
import '../../../common/presentation/components/auth_header_wrapper.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../../common/presentation/dialog/custom_sheet.dart';
import '../../data/models/branch_atm_kiosk_response.dart';
import '../../data/models/fetch_bank_info_request.dart';
import '../controller/fetch_bank_info_notifier.dart';
import '../controller/fetch_locate_us_info_notifier.dart';
import '../controller/reach_us_providers.dart';
import '../controller/state/reach_notifier.dart';
import '../state/fetch_bank_info_state.dart';
import '../widgets/call_us_sheet.dart';
import '../widgets/faqs_action_widget.dart';
import '../widgets/item_row_widget.dart';
import '../widgets/social_media_list.dart';
import '../widgets/tab_widget.dart';

@RoutePage(name: "ReachUsPageRoute")
class ReachUsPage extends ConsumerStatefulWidget {
  const ReachUsPage({super.key});
  @override
  ConsumerState<ReachUsPage> createState() => _ReachUsPageState();
}

class _ReachUsPageState extends ConsumerState<ReachUsPage> {
  Location location = Location();
  bool _checkingLocation = false;
  GoogleMapController? _mapController;
  @override
  void initState() {
    super.initState();

    // Trigger API call after widget is initialized
    Future.microtask(() {
      final notifier = ref.read(fetchBankInfoNotifierProvider.notifier);
      notifier.fetchBankInfo(
        request: FetchBankInfoRequest(
          // Fill your request parameters
        ),
      );
      ref
          .read(fetchLocateUsInfoNotifierProvider.notifier)
          .fetchLocateUsInfo(request: FetchLocateUsInfoRequest());
    });
  }

  LatLng? currentLocation;
  LocationItem? nearestBranch;
  List<String>? tabs;
  ReachUsState? reachUsState;
  ReachUsNotifier? reachUsNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reachUsState = ref.watch(reachUsNotifierProvider);
    reachUsNotifier = ref.watch(reachUsNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final reachUsState = ref.watch(reachUsNotifierProvider); // todo this
    ref.listen<FetchBankInfoState>(fetchBankInfoNotifierProvider, (
      previous,
      next,
    ) {
      next.maybeWhen(
        success: (bankDetails) {
          reachUsNotifier?.fetchBankDetailsFromServer(bankDetails!);
        },
        failure: (err) {
          showErrorDialog(err, context, ref);
          reachUsNotifier?.setErrorFromServer(err);
        },
        orElse: () {},
      );
    });
    /////////////////////////////////////////////////////////////////////////////////
    ref.listen<FetchLocateUsInfoState>(fetchLocateUsInfoNotifierProvider, (
      previous,
      next,
    ) {
      next.maybeWhen(
        success: (locateUs) {
          print("succccccccccccccccccccccccccccccccccccccccccccccccccccec");
          _loadMarkersFromApi(locateUs);
        },
        failure: (err) {
          showErrorDialog(err, context, ref);
          reachUsNotifier?.failedLocateUsService(err);
        },
        orElse: () {},
      );
    });

    final currentLocation = reachUsState!.currentLocation;
    final nearestBranch = reachUsState!.nearestBranch;
    final tabs = ref.watch(reachUsNotifierProvider.notifier).tabsList;
    return Scaffold(
      body: AuthHeaderWrapper(
        suffix: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                context.router.push(FaqScreenRoute());
              },
              child: FaqsActionWidget(),
            ),
            SizedBox(width: 8),
            Image.asset(AssetPath.image.loanImage, height: 48, width: 48),
          ],
        ),
        withScroll: false,
        headerText: DefaultString.instance.reachUsTitle,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // reachUsState.locateUsEntity != null// todo
                //     ?
                SizedBox(
                  height: 263,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (reachUsState.failedLocateUsService == null) {
                          if (currentLocation == null) {
                            _checkLocationPermission();
                          } else {
                            context.router.push(LocateUsPageRoute());
                          }
                        } else {
                          showErrorDialog(
                            reachUsState!.failedLocateUsService ?? "",
                            context,
                            ref,
                          );
                        }
                        ;
                      },
                      child: Stack(
                        children: [
                          // Map or placeholder image
                          Positioned.fill(
                            child:
                                (currentLocation == null || _checkingLocation)
                                ? Image.asset(
                                    AssetPath.image.mapEmpty,
                                    fit: BoxFit.cover,
                                  )
                                : GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: nearestBranch?.coordinates != null
                                          ? LatLng(
                                              nearestBranch!
                                                  .coordinates!
                                                  .latitude!,
                                              nearestBranch!
                                                  .coordinates!
                                                  .longitude!,
                                            )
                                          : currentLocation ??
                                                const LatLng(
                                                  25.2854,
                                                  51.5310,
                                                ), // fallback to Doha
                                      zoom: nearestBranch != null ? 13 : 13,
                                    ),
                                    markers: reachUsState!.markers,
                                    myLocationEnabled: true,
                                    onMapCreated: (controller) {
                                      _mapController = controller;
                                    },
                                    myLocationButtonEnabled: false,
                                    compassEnabled: false,
                                    zoomControlsEnabled: false,
                                  ),
                          ),

                          // Overlay when location is null
                          if (currentLocation == null)
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 30),
                                  Image.asset(
                                    "assets/images/locate_image/Pin.png",
                                    width: 26,
                                    height: 34,
                                  ),
                                  const SizedBox(height: 27),
                                  SizedBox(
                                    width: 220,
                                    child: UiTextNew.customRubik(
                                      DefaultString.instance.enableLocation,
                                      fontSize: 13,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Top tab
                          (tabs != null && tabs!.isNotEmpty)
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TabWidget(
                                      filterList: tabs!,
                                      isImage: true,
                                      currentIndex: 0,
                                      indexSelected: (val) {},
                                    ),
                                  ),
                                )
                              : SizedBox(),

                          // Bottom info
                          if (currentLocation != null)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 18,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        UiTextNew.customRubik(
                                          DefaultString
                                              .instance
                                              .nearestBranchTitle,
                                          fontSize: 13,
                                        ),
                                        UiTextNew.customRubik(
                                          nearestBranch?.fullAddress ??
                                              DefaultString
                                                  .instance
                                                  .branchNameLoading,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        AssetPath.image.expand,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                //  : LoadingContainerWidget(height: 300),
                UiSpace.vertical(25),

                // reachUsState.bankDetails != null
                //     ?
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ItemRowWidget(
                            onTap: () =>
                                context.router.push(BookAndMeetPageRoute()),
                            title: DefaultString.instance.bookAndMeetTitle,
                            subTitle:
                                DefaultString.instance.atTheBranchSubTitle,
                            icon: AssetPath.image.bookAndMeet,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ItemRowWidget(
                            onTap: () =>
                                context.router.push(RequestCallbackPageRoute()),
                            subTitle: DefaultString.instance.weWillCallYouTitle,
                            title: DefaultString.instance.requestCallBackTitle,
                            icon: AssetPath.image.requestCallBack,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ItemWidget(
                            onTap: () {
                              if (reachUsState.bankDetails != null) {
                                CustomSheet.show(
                                  isDismissible: true,
                                  context: context,
                                  child: CallUsSheet(),
                                );
                              } else {
                                showErrorDialog(
                                  reachUsState!.errorFromServer ?? "",
                                  context,
                                  ref,
                                );
                              }
                            },
                            title: DefaultString.instance.callUsTitle,
                            icon: AssetPath.image.phoneImage,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ItemWidget(
                            onTap: () {
                              if (reachUsState!.bankDetails != null) {
                                _sendEmail(context);
                              } else {
                                showErrorDialog(
                                  reachUsState!.errorFromServer ?? "",
                                  context,
                                  ref,
                                );
                              }
                            },
                            title: DefaultString.instance.emailUsTitle,
                            icon: AssetPath.image.mailImage,
                          ),
                        ),
                      ],
                    ),
                    UiSpace.vertical(25),
                    reachUsState!.bankDetails != null
                        ? Column(
                            children: [
                              UiTextNew.customRubik(
                                DefaultString.instance.followUsTitle,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 15),
                              SocialMediaList(),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
                // : LoadingContainerWidget(height: 300),//todo
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMarkersFromApi(List<LocateUsInfo> locateUs) async {
    print("looooooooooooooooooooooooooooooooooooooooooooooooooocate");
    print(locateUs);

    final branches = locateUs.expand((e) => e.branches).toList();
    final atms = locateUs.expand((e) => e.atms).toList();
    final kiosks = locateUs.expand((e) => e.kiosks).toList();

    print("Branches:");
    print(branches);
    print("ATMs:");
    print(atms);
    print("Kiosks:");
    print(kiosks);

    // ✅ Store in provider
    ref.read(reachUsNotifierProvider.notifier).setBranches(branches);
    ref.read(reachUsNotifierProvider.notifier).setAtms(atms);
    ref.read(reachUsNotifierProvider.notifier).setKiosks(kiosks);

    // ✅ 3. Build markers
    Set<Marker> newMarkers = {};

    for (final branch in branches) {
      if (branch.coordinates != null) {
        final icon = await getResizedMarker(AssetPath.image.pin_branch, 100);
        newMarkers.add(
          Marker(
            markerId: MarkerId("branch_${branch.code}"),
            position: LatLng(
              branch.coordinates!.latitude!,
              branch.coordinates!.longitude!,
            ),
            icon: icon,
          ),
        );
      }
    }

    for (final atm in atms) {
      if (atm.coordinates != null) {
        final icon = await getResizedMarker(AssetPath.image.pin_atm, 100);
        newMarkers.add(
          Marker(
            markerId: MarkerId("atm_${atm.code}"),
            position: LatLng(
              atm.coordinates!.latitude!,
              atm.coordinates!.longitude!,
            ),
            icon: icon,
          ),
        );
      }
    }

    for (final kiosk in kiosks) {
      if (kiosk.coordinates != null) {
        final icon = await getResizedMarker(AssetPath.image.pin_kiosk, 100);
        newMarkers.add(
          Marker(
            markerId: MarkerId("kiosk_${kiosk.code}"),
            position: LatLng(
              kiosk.coordinates!.latitude!,
              kiosk.coordinates!.longitude!,
            ),
            icon: icon,
          ),
        );
      }
    }

    ref.read(reachUsNotifierProvider.notifier).setMarkers(newMarkers);
  }

  // Future<void> _loadMarkersFromApi() async {
  //   final locateUsResponse = await ref.read(locateUsNotifierProvider.future);
  //   if (locateUsResponse == null) {
  //     _showFetchErrorPopup(
  //       context,
  //       "Unable to load bank details at this time.",
  //     );
  //     return;
  //   }
  //   // read bank Details from service and save it
  //   // ref
  //   //     .read(reachUsNotifierProvider.notifier)
  //   //     .fetchLocateUsFromServer(locateUsResponse);
  //
  //   LocateUsEntity locateUs = locateUsResponse;
  //
  //   final branches = locateUs.data
  //       .where((s) => s.branches != null)
  //       .expand((s) => s.branches!)
  //       .toList();
  //   final atms = locateUs.data
  //       .where((s) => s.atms != null)
  //       .expand((s) => s.atms!)
  //       .toList();
  //   final kiosks = locateUs.data
  //       .where((s) => s.kiosks != null)
  //       .expand((s) => s.kiosks!)
  //       .toList();
  //
  //   ref.read(reachUsNotifierProvider.notifier).setBranches(branches);
  //   ref.read(reachUsNotifierProvider.notifier).setAtms(atms);
  //   ref.read(reachUsNotifierProvider.notifier).setKiosks(kiosks);
  //
  //   // Build markers
  //   Set<Marker> newMarkers = {};
  //
  //   for (final branch in branches) {
  //     if (branch.coordinates != null) {
  //       final icon = await getResizedMarker(AssetPath.image.pin_branch, 100);
  //       newMarkers.add(
  //         Marker(
  //           markerId: MarkerId(
  //             "branch_${branch.locatorType}_${branch.coordinates!.latitude}_${branch.coordinates!.longitude}",
  //           ),
  //
  //           position: LatLng(
  //             branch.coordinates!.latitude!,
  //             branch.coordinates!.longitude!,
  //           ),
  //           icon: icon,
  //         ),
  //       );
  //     }
  //   }
  //
  //   for (final atm in atms) {
  //     final lat = atm.coordinates!.latitude;
  //     final lng = atm.coordinates!.longitude;
  //     if (lat != null && lng != null) {
  //       final icon = await getResizedMarker(AssetPath.image.pin_atm, 100);
  //       newMarkers.add(
  //         Marker(
  //           markerId: MarkerId(
  //             "atm${atm.locatorType}_${atm.coordinates!.latitude}_${atm.coordinates!.longitude}",
  //           ),
  //
  //           position: LatLng(lat, lng),
  //           icon: icon,
  //         ),
  //       );
  //     }
  //   }
  //
  //   for (final kiosk in kiosks) {
  //     if (kiosk.coordinates != null) {
  //       final icon = await getResizedMarker(AssetPath.image.pin_kiosk, 100);
  //       newMarkers.add(
  //         Marker(
  //           markerId: MarkerId(
  //             "kiosk_${kiosk.locatorType}_${kiosk.coordinates!.latitude}_${kiosk.coordinates!.longitude}",
  //           ),
  //
  //           position: LatLng(
  //             kiosk!.coordinates!.latitude!,
  //             kiosk.coordinates!.longitude!,
  //           ),
  //           icon: icon,
  //         ),
  //       );
  //     }
  //   }
  //
  //   ref.read(reachUsNotifierProvider.notifier).setMarkers(newMarkers);
  // }

  /////////////////////////////

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted &&
        permissionGranted != PermissionStatus.grantedLimited)
      return;

    setState(() => _checkingLocation = true);

    final locData = await location.getLocation();
    final userLatLng = LatLng(locData.latitude!, locData.longitude!);

    ref.read(reachUsNotifierProvider.notifier).setCurrentLocation(userLatLng);

    final nearest = ref
        .read(reachUsNotifierProvider.notifier)
        .findNearestBranch(userLatLng.latitude, userLatLng.longitude);
    if (nearest != null) {
      ref.read(reachUsNotifierProvider.notifier).setNearestBranch(nearest);

      ref.read(reachUsNotifierProvider.notifier).setNearestBranch(nearest);

      // ✅ Animate map to the nearest branch
      if (_mapController != null && nearest.coordinates != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                nearest.coordinates!.latitude!,
                nearest.coordinates!.longitude!,
              ),
              zoom: 13,
            ),
          ),
        );
        print(nearest.coordinates!.latitude);
        print(nearest.coordinates!.longitude);
      }
    }

    setState(() => _checkingLocation = false);
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

  void _sendEmail(BuildContext context) async {
    final bankDetails = ref.read(reachUsNotifierProvider).bankDetails;
    print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmail");
    print(bankDetails!.mail);

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: bankDetails.mail,
      //  'support@dukhanbank.com',
      queryParameters: {'body': ''},
    );
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        _showInfoDialog(context, DefaultString.instance.noEmailConfigured);
      }
    } catch (e) {
      _showInfoDialog(context, DefaultString.instance.someThingError);
    }
  }

  void _showInfoDialog(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: UiTextNew.customRubik(
          DefaultString.instance.infoTitle,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              Navigator.of(context).pop();
              context.router.pop();
            },
            child: Text(DefaultString.instance.okTitle),
          ),
        ],
      ),
    );
  }

  void _showFetchErrorPopup(BuildContext context, String message) {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,

      barrierLabel: "Error",
      barrierColor: Colors.black54, // dim background
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/images/locate_image/note.svg"),
                const SizedBox(height: 16),
                UiTextNew.customRubik(
                  DefaultString.instance.infoTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    UiTextNew.customRubik(
                      "Something went wrong on the server.",
                      fontSize: 13,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.blueDarkBase,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    DefaultString.instance.okTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
