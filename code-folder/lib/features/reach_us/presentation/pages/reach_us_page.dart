import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/constants/colors.dart' show DefaultColors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../../../common/dialog/custom_sheet.dart';
import '../controller/reach_us_notifier.dart';
import '../widgets/call_us_sheet.dart';
import '../widgets/item_row_widget.dart';
import '../widgets/social_media_list.dart';

@RoutePage(name: "ReachUsPageRoute")
class ReachUsPage extends ConsumerStatefulWidget {
  const ReachUsPage({super.key});

  @override
  ConsumerState<ReachUsPage> createState() => _ReachUsPageState();
}

class _ReachUsPageState extends ConsumerState<ReachUsPage> {
  void _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@dukhanbank.com', // 👈 make configurable
      queryParameters: {
        // 'subject': '',
        'body': '',
      },
    );
    try {
      // Check if an email app can handle this
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
        // After user sends/cancels → they return back automatically
      } else {
        // No email app found
        _showInfoDialog(
          context,
          "No email application configured. Please set up your email account to use this feature",
        );
      }
    } catch (e) {
      // Any unexpected error (network, middleware, etc.)
      _showInfoDialog(
        context,
        "Something went wrong. Please try after sometime",
      );
    }
  }

  void _showInfoDialog(BuildContext context, String message, {String? code}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const UiTextNew.customRubik("Info", fontSize: 14),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // ✅ ONLY close the dialog
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // void _sendEmail() {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'support@dukhanbank.com',
  //     queryParameters: {
  //       //'subject': 'DukanBank',
  //       'body': '',
  //       // 'cc': 'dukhan@gmail.com',
  //     },
  //   );
  //   launchUrl(emailLaunchUri);
  // }

  final List<Map<String, dynamic>> locationList = [
    // Branches
    {
      "lat": 25.285447,
      "long": 51.531040,
      "type": "branch",
      "name": "Grand Hamad Street Branch",
    },
    {
      "lat": 25.292,
      "long": 51.527,
      "type": "branch",
      "name": "Al Rayyan Branch",
    },

    // ATMs
    {
      "lat": 25.278,
      "long": 51.532,
      "type": "atm",
      "name": "Doha Festival City ATM",
    },
    {"lat": 25.287, "long": 51.528, "type": "atm", "name": "City Centre ATM"},

    // Kiosks
    {
      "lat": 25.286,
      "long": 51.530,
      "type": "kiosk",
      "name": "Souq Waqif Kiosk",
    },
  ];

  Location location = Location();
  LatLng? currentLocation;
  late GoogleMapController mapController;
  final LatLng initialPosition = const LatLng(25.285447, 51.531040);
  late Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<BitmapDescriptor> getResizedMarker(String assetPath, int width) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width, // resize here
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? resizedData = await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }

  Future<void> _loadMarkers() async {
    Set<Marker> newMarkers = {};

    for (int i = 0; i < locationList.length; i++) {
      var loc = locationList[i];

      BitmapDescriptor icon;
      switch (loc["type"]) {
        case "branch":
          icon = await getResizedMarker(AssetPath.image.pin_branch, 100);
          break;
        case "atm":
          icon = await getResizedMarker(AssetPath.image.pin_atm, 100);
          break;
        case "kiosk":
          icon = await getResizedMarker(AssetPath.image.pin_kiosk, 100);
          break;
        default:
          icon = BitmapDescriptor.defaultMarker;
      }

      newMarkers.add(
        Marker(
          onTap: () {
            context.router.push(LocateUsPageRoute());
            print("llllllllllllllllllll");
          },
          markerId: MarkerId(loc["name"] ?? "marker_$i"),
          position: LatLng(
            (loc["lat"] as num).toDouble(),
            (loc["long"] as num).toDouble(),
          ),
          icon: icon,
          //  infoWindow: InfoWindow(title: loc["name"] ?? loc["type"]),
        ),
      );
    }

    setState(() {
      markers = newMarkers;
    });
  }

  bool _checkingLocation = false;
  Future<void> _checkLocationPermission() async {
    // ✅ Do NOT setState before showing permission dialog

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return; // No flicker because setState not called
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted != PermissionStatus.granted &&
        permissionGranted != PermissionStatus.grantedLimited) {
      return;
    }

    // ✅ Now that everything is resolved, show loading state briefly (if needed)
    setState(() => _checkingLocation = true);

    final locData = await location.getLocation();

    setState(() {
      currentLocation = LatLng(locData.latitude!, locData.longitude!);
      _checkingLocation = false;
    });
  }

  // Future<void> _checkLocationPermission() async {
  //   setState(() {
  //     _checkingLocation = true;
  //   });
  //
  //   bool serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       setState(() => _checkingLocation = false);
  //       return;
  //     }
  //   }
  //
  //   PermissionStatus permissionGranted = await location.hasPermission();
  //
  //   // ✅ Request ONLY foreground permission, ignore background for now
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //   }
  //
  //   // ✅ Stop here – do NOT escalate to background permission
  //   if (permissionGranted != PermissionStatus.granted &&
  //       permissionGranted != PermissionStatus.grantedLimited) {
  //     setState(() => _checkingLocation = false);
  //     return;
  //   }
  //
  //   // ✅ Foreground permission granted – continue
  //   final locData = await location.getLocation();
  //   setState(() {
  //     currentLocation = LatLng(locData.latitude!, locData.longitude!);
  //     _checkingLocation = false;
  //   });
  // }

  // Future<void> _checkLocationPermission() async {
  //   setState(() {
  //     _checkingLocation = true;
  //   });
  //
  //   bool serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       setState(() => _checkingLocation = false);
  //       return;
  //     }
  //   }
  //
  //   PermissionStatus permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted &&
  //         permissionGranted != PermissionStatus.grantedLimited) {
  //       setState(() => _checkingLocation = false);
  //       return;
  //     }
  //   }
  //
  //   if (permissionGranted == PermissionStatus.deniedForever) {
  //     setState(() => _checkingLocation = false);
  //     // Optionally show a dialog to open settings
  //     return;
  //   }
  //
  //   final locData = await location.getLocation();
  //   setState(() {
  //     currentLocation = LatLng(locData.latitude!, locData.longitude!);
  //     _checkingLocation = false;
  //   });
  // }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(getLoansDashResponseProvider);
    return Scaffold(
      appBar: UIAppBar.secondary(
        appBarColor: Colors.white,
        title: '',
        autoLeadingWidget: LeadingWidget(
          title: DefaultString.instance.reachUsTitle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.router.push(FaqScreenRoute());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: DefaultColors.blueBase),
                color: DefaultColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                child: UiTextNew.customRubik(
                  DefaultString.instance.faqsTitle,
                  fontSize: 12,
                  color: DefaultColors.blueBase,
                ),
              ),
            ),
            //Image.asset(AssetPath.image.faqImage, width: 48, height: 24),
          ),
          SizedBox(width: 8),
          Image.asset(AssetPath.image.loanImage),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 263, // the same height you were using for the map/image
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      // ---------- background (image OR map) ----------
                      GestureDetector(
                        onTap: () {
                          _checkLocationPermission();
                        },
                        child: _checkingLocation
                            ? Image.asset(
                                AssetPath.image.mapEmpty,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : currentLocation == null
                            ? Image.asset(
                                AssetPath.image.mapEmpty,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : GoogleMap(
                                onTap: (val) =>
                                    context.router.push(LocateUsPageRoute()),
                                initialCameraPosition: CameraPosition(
                                  target: initialPosition,
                                  zoom: 13,
                                ),
                                markers: markers,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                compassEnabled: false,
                                zoomControlsEnabled: false,
                                zoomGesturesEnabled: true,
                              ),
                        // currentLocation == null
                        //     ? Image.asset(
                        //         AssetPath.image.mapImageDefault,
                        //         fit: BoxFit.cover,
                        //         width: double.infinity,
                        //         height: double.infinity,
                        //       )
                        //     : GoogleMap(
                        //         onTap: (val) =>
                        //             context.router.push(LocateUsPageRoute()),
                        //         initialCameraPosition: CameraPosition(
                        //           target: initialPosition,
                        //           zoom: 13,
                        //         ),
                        //         markers: markers,
                        //         myLocationEnabled: true,
                        //         myLocationButtonEnabled: false,
                        //         compassEnabled: false,
                        //         zoomControlsEnabled: false,
                        //         zoomGesturesEnabled: true,
                        //       ),
                      ),
                      currentLocation == null
                          ? Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  Image.asset(
                                    "assets/images/locate_image/Pin.png",
                                    width: 26,
                                    height: 34,
                                    // width/height as needed
                                  ),
                                  SizedBox(height: 27),
                                  SizedBox(
                                    width: 220,
                                    child: UiTextNew.customRubik(
                                      "Please enable location to view nearest branch/atm/kiosk",
                                      fontSize: 13,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      // ---------- top center tappable (TabSwitcher) ----------
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          behavior: HitTestBehavior
                              .opaque, // ensures the tap is caught even if image is small
                          onTap: () {
                            if (currentLocation == null) {
                              _checkLocationPermission();
                            } else {
                              context.router.push(LocateUsPageRoute());
                            }
                          },
                          child: Image.asset(
                            "assets/images/TabSwitcher.png",
                            // width/height as needed
                          ),
                        ),
                      ),

                      // ---------- bottom center row overlay ----------
                      currentLocation == null
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: double
                                      .infinity, // make Row take full width so spaceBetween works
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Left side (icon + title)
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
                                            DefaultString
                                                .instance
                                                .cityCenterDohaLocation,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),

                                      // Right side (action button)
                                      GestureDetector(
                                        onTap: () {
                                          if (currentLocation == null) {
                                            _checkLocationPermission();
                                          } else {
                                            context.router.push(
                                              LocateUsPageRoute(),
                                            );
                                          }
                                        },
                                        child: Container(
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),

              UiSpace.vertical(40),

              Row(
                children: [
                  Expanded(
                    child: ItemRowWidget(
                      onTap: () {
                        context.router.push(BookAndMeetPageRoute());
                      },
                      title: DefaultString.instance.bookAndMeetTitle,
                      subTitle: DefaultString.instance.atTheBranchSubTitle,
                      icon: AssetPath.image.bookAndMeet,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ItemRowWidget(
                      onTap: () {
                        context.router.push(RequestCallbackPageRoute());
                      },
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
                        CustomSheet.show(
                          isDismissible: true,
                          context: context,
                          child: CallUsSheet(),
                        );
                      },

                      title: DefaultString.instance.callUsTitle,

                      icon: AssetPath.image.phoneImage,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ItemWidget(
                      onTap: () {
                        _sendEmail(context);
                      },
                      title: DefaultString.instance.emailUsTitle,
                      icon: AssetPath.image.mailImage,
                    ),
                  ),
                ],
              ),
              UiSpace.vertical(40),
              UiTextNew.customRubik(
                DefaultString.instance.followUsTitle,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              SocialMediaList(),
              // asyncState.when(
              //   loading: () => CircularProgressIndicator(),
              //   error: (err, _) {
              //     print(";;;;;;;;;; AccountWebSection Error ;;;;;;;;;;");
              //     print(err.toString());
              //     return SizedBox();
              //   },
              //   data: (dashboardEntity) {
              //     print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
              //     print(dashboardEntity);
              //     return Container(color: Colors.black, width: 50, height: 50);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
