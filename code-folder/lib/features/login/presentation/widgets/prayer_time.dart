import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_strings/default_string.dart';
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetPath.svg.prayerTimeIcon),
            SizedBox(height: 5),
            Text(
              DefaultString.instance.nextPrayerTime,
              style: TextStyle(color: DefaultColors.whiteFD, fontSize: 11),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dhuhr ",
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "·", //interpunct
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "11:40 am",
                  style: TextStyle(
                    color: DefaultColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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
