import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';

Widget bottomMenuTab({
  required BuildContext context,
  required String svgIconPath,
  required String title,
  Function()? ontap,
}) {
  return InkWell(
    onTap: ontap,
    radius: MediaQuery.of(context).size.width * 0.1,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(svgIconPath),
          UiSpace.vertical(2),
          UiTextNew.custom(
            title,
            color: DefaultColors.white,
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
