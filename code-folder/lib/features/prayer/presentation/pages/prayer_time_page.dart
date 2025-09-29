import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/prayer_time_app_bar.dart';

@RoutePage(name: "PrayerTimingsPageRoute")
class PrayerTimingsPage extends StatelessWidget {
  const PrayerTimingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double topHeight = size.height * 0.40;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: topHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.image.prayerTimeScreenBgPattern),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              PrayerTimesAppBar(
                onSettings: () {
                  context.router.push(const PrayerTimeSettingRoute());
                },
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Monday, Rabi’ al-Thani 11, 1446",
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "3:06 PM",
                style: TextStyle(
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetPath.image.prayerTimeVector,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: size.width * 0.015),
                  const Text(
                    "Next Maghrib in 2:01:42",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: size.height * 0.65, // adjust height if needed
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(size.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildPrayerRow(
                        Image.asset(
                          AssetPath.image.prayerTimefajr,
                          fit: BoxFit.contain,
                        ),
                        "Fajr",
                        "4:13 AM",
                        size,
                      ),
                      _buildPrayerRow(
                        Image.asset(
                          AssetPath.image.prayerTimeSunrise,
                          fit: BoxFit.contain,
                        ),
                        "Sunrise",
                        "5:31 AM",
                        size,
                      ),
                      _buildPrayerRow(
                        Icon(Icons.sunny),
                        "Dhuhr",
                        "11:20 AM",
                        size,
                      ),
                      _buildPrayerRow(
                        Image.asset(
                          AssetPath.image.prayerTimeAsr,
                          fit: BoxFit.contain,
                        ),
                        "Asr",
                        "2:40 PM",
                        size,
                      ),
                      _buildPrayerRow(
                        Image.asset(
                          AssetPath.image.prayerTimeVector,
                          fit: BoxFit.contain,
                          color: Colors.black,
                        ),
                        "Maghrib",
                        "5:08 PM",
                        size,
                      ),
                      _buildPrayerRow(
                        Icon(Icons.dark_mode_outlined),
                        "Isha",
                        "6:38 PM",
                        size,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      UISvgIcon(
                        assetPath: AssetPath.icon.qibla,
                        color: DefaultColors.black,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Expanded(
                        child: Text(
                          "Qibla Finder",
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: 45 * 3.1415926535 / 180,
                        child: const Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerRow(
    Widget leadingWidget,
    String name,
    String time,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.06,
            height: size.width * 0.06,
            child: leadingWidget,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
