import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/db_uicomponents.dart';

import '../../../../core/router/app_router.dart';

/// Static widget showing next prayer time
class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: () {
          context.router.push(const PrayerTimingsPageRoute());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wb_sunny_outlined, color: DefaultColors.white, size: 20),
            SizedBox(height: 5),
            Text(
              "Next Prayer Time",
              style: TextStyle(color: DefaultColors.whiteFD, fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dhuhr ",
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    "·",
                    style: TextStyle(
                      color: DefaultColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "11:40 am",
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
