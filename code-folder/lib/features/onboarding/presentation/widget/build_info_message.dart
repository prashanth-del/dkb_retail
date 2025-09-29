import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

Widget buildInfoMessage(String text1, String text2) {
  return Container(
    color: const Color(0xFFFEFDED),
    padding: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline,
          color: DefaultColors.white_800,
          size: 14,
        ),
        const SizedBox(width: 8), // Space between number and text
        Expanded(
          child: Wrap(
              children:[
                UiTextNew.customRubik(
                  text2,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.white_800,// Bold number with period
                ),
              ]
          ),
        ),
      ],
    ),
  );
}
