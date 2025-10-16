import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';

Widget customizedDashboardBtn(BuildContext context, WidgetRef ref) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: DefaultColors.grey.withAlpha(100),
    ),

    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.04,
      vertical: MediaQuery.of(context).size.width * 0.03,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            UiTextNew.custom(
              DefaultString.instance.customizeDashtitle,
              fontSize: MediaQuery.of(context).size.aspectRatio * 35,
              fontWeight: FontWeight.bold,
            ),

            UiTextNew.custom(
              DefaultString.instance.customizeDashDesc,
              fontSize: MediaQuery.of(context).size.aspectRatio * 20,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            context.router.push(const CustomizeDashboardRoute());
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: SvgPicture.asset(AssetPath.icon.arrow_up_right, width: 10),
          ),
        ),
      ],
    ),
  );
}
