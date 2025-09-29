import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/prayer_model_bottom_sheet.dart';
import '../widgets/prayer_time_app_bar.dart';
import 'package:intl/intl.dart';
@RoutePage(name:"PrayerTimeSettingRoute")

class PrayerSettingsPage extends StatefulWidget {
  const PrayerSettingsPage({super.key});

  @override
  State<PrayerSettingsPage> createState() => _PrayerSettingsPageState();
}

class _PrayerSettingsPageState extends State<PrayerSettingsPage> {
  String selectedMethod = "Umm al-Qura University, Makkah";
  int value = 0;

  final List<String> methods = [
    "Umm al-Qura University, Makkah",
    "Islamic Society of North America (ISNA)",
    "University of Islamic Sciences, Karachi",
    "Muslim World League",
    "Egyptian General Authority of Survey",
  ];

  final Map<String, DateTime> prayerTimes = {
    'Fajr': DateTime(2025, 9, 15, 4, 13),
    'Sunrise': DateTime(2025, 9, 15, 5, 31),
    'Dhuhr': DateTime(2025, 9, 15, 11, 20),
    'Asr': DateTime(2025, 9, 15, 14, 40),
    'Maghrib': DateTime(2025, 9, 15, 17, 8),
    'Isha': DateTime(2025, 9, 15, 18, 38),
  };

  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: PrayerTimesAppBar(
              showSettings: false,
              title: 'Prayer Time Settings',
              textColor: const Color(0xFF0D3E7F),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.01),
                UiCard(
                  borderColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.015,
                  ),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) => PrayerMethodBottomSheet(
                          methods: methods,
                          onSelect: (method) {
                            setState(() {
                              selectedMethod = method;
                            });
                          },
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Method',
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiTextNew.customRubik(
                              selectedMethod,
                              fontSize: width * 0.035,
                              color: DefaultColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            Icon(Icons.keyboard_arrow_down, size: width * 0.08),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.01,
            ),
            child: Text(
              "Make the adjustment to match the prayer time in your area if there's a difference",
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.015,
            ),
            child: UiCard(
              borderColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.015,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.black54,
                    size: width * 0.05,
                  ),
                  SizedBox(width: width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HIJRI DATE",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.035,
                        ),
                      ),
                      Text(
                        "Muharram 8, 1447H",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: width * 0.030,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  Row(
                    children: [
                      IconButton(
                        onPressed: value > 0
                            ? () {
                                setState(() {
                                  value--;
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.remove_circle,
                          color: value > 0
                              ? const Color(0xFF4197CB)
                              : Colors.grey,
                          size: width * 0.07,
                        ),
                        splashRadius: width * 0.07,
                      ),
                      SizedBox(
                        width: width * 0.18,
                        child: Text(
                          '$value',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            value++;
                          });
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: const Color(0xFF4197CB),
                          size: width * 0.07,
                        ),
                        splashRadius: width * 0.07,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Divider(color: Colors.grey.shade200),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.00,
              ),
              itemCount: prayerTimes.length,
              itemBuilder: (context, index) {
                String prayer = prayerTimes.keys.elementAt(index);
                DateTime time = prayerTimes[prayer]!;
                IconData icon;

                switch (prayer) {
                  case 'Fajr':
                    icon = Icons.wb_sunny_outlined;
                    break;
                  case 'Sunrise':
                    icon = Icons.wb_sunny;
                    break;
                  case 'Dhuhr':
                    icon = Icons.light_mode;
                    break;
                  case 'Asr':
                    icon = Icons.cloud;
                    break;
                  case 'Maghrib':
                    icon = Icons.nights_stay;
                    break;
                  case 'Isha':
                    icon = Icons.dark_mode;
                    break;
                  default:
                    icon = Icons.access_time;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.003),
                  child: UiCard(
                    borderColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.008,
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: Colors.black, size: width * 0.06),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: Text(
                            prayer,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              prayerTimes[prayer] = time.subtract(
                                const Duration(minutes: 1),
                              );
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: const Color(0xFF4197CB),
                            size: width * 0.07,
                          ),
                          splashRadius: width * 0.07,
                        ),
                        SizedBox(
                          width: width * 0.18,
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                  hour: time.hour,
                                  minute: time.minute,
                                ),
                              );

                              if (picked != null) {
                                setState(() {
                                  prayerTimes[prayer] = DateTime(
                                    time.year,
                                    time.month,
                                    time.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                });
                              }
                            },
                            child: Text(
                              formatTime(time),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.035,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              prayerTimes[prayer] = time.add(
                                const Duration(minutes: 1),
                              );
                            });
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: const Color(0xFF4197CB),
                            size: width * 0.07,
                          ),
                          splashRadius: width * 0.07,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: UiCard(
              onTap: () {
                context.router.push(const PrayerNotificationsPageRoute());
              },
              cardColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.02,
              ),
              child: Row(
                children: [
                  UISvgIcon(
                    assetPath: AssetPath.icon.notificationsNewIcon,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: width * 0.03),
                  Expanded(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: width * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
