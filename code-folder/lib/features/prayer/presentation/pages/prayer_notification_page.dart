import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../widgets/prayer_time_app_bar.dart';

@RoutePage(name: "PrayerNotificationsPageRoute")
class PrayerNotificationsPage extends StatefulWidget {
  const PrayerNotificationsPage({super.key});

  @override
  State<PrayerNotificationsPage> createState() =>
      _PrayerNotificationsPageState();
}

class _PrayerNotificationsPageState extends State<PrayerNotificationsPage> {
  final Map<String, Map<String, dynamic>> prayerTimes = {
    'Fajr': {'time': '4:13 AM', 'enabled': true, 'icon': Icons.brightness_3},
    'Sunrise': {
      'time': '5:31 AM',
      'enabled': true,
      'icon': Icons.wb_sunny_outlined,
    },
    'Dhuhr': {'time': '11:20 AM', 'enabled': false, 'icon': Icons.wb_sunny},
    'Asr': {'time': '2:40 PM', 'enabled': true, 'icon': Icons.cloud},
    'Maghrib': {'time': '5:08 PM', 'enabled': true, 'icon': Icons.nights_stay},
    'Isha': {'time': '6:38 PM', 'enabled': true, 'icon': Icons.dark_mode},
  };

  String selectedAdhan = "Silent";

  final List<Map<String, dynamic>> adhanSounds = [
    {"name": "Silent", "icon": Icons.volume_off},
    {"name": "Makkah", "icon": Icons.play_circle_outline},
    {"name": "Madina", "icon": Icons.play_circle_outline},
    {"name": "Abdul Basit", "icon": Icons.play_circle_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: PrayerTimesAppBar(
              showSettings: false,
              title: 'Prayer Notifications',
              textColor: const Color(0xFF0D3E7F),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.09,
              top: size.height * 0.0,
            ),
            child: const Text(
              "Notification",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: size.height * 0.015,
              ),
              children: [
                ...prayerTimes.entries.map((entry) {
                  final prayer = entry.key;
                  final details = entry.value;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.005,
                    ),
                    child: UiCard(
                      borderColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.015,
                      ),
                      child: Row(
                        children: [
                          Icon(details['icon'], color: Colors.black),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prayer,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  details['time'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: details['enabled'],
                            onChanged: (val) {
                              setState(() {
                                details['enabled'] = val;
                              });
                            },
                            activeThumbColor: const Color(0xFF4197CB),
                            activeTrackColor: const Color(
                              0xFF4197CB,
                            ).withValues(alpha: 0.2),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Divider(color: Colors.grey.shade300),
                UiCard(
                  borderColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Adhan Sound",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),

                      ...adhanSounds.map((sound) {
                        return Row(
                          children: [
                            Icon(
                              sound["icon"],
                              color: Colors.black54,
                              size: 30,
                            ),
                            SizedBox(width: size.width * 0.03),

                            // Label
                            Expanded(
                              child: Text(
                                sound["name"],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Radio<String>(
                              value: sound["name"],
                              groupValue: selectedAdhan,
                              activeColor: const Color(0xFF4197CB),
                              onChanged: (val) {
                                setState(() {
                                  selectedAdhan = val!;
                                });
                              },
                            ),
                          ],
                        );
                      }),
                    ],
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
