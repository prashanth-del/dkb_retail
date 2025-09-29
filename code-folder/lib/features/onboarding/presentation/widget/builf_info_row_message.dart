import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

Widget buildInfoRowMessage(String text1, String text2) {
  return Container(
    color: const Color(0xFFFEFDED),
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular(
          text1,
          color: DefaultColors.white_800,
        ),
        Expanded(
          child: Wrap(
              children:[
                UiTextNew.h5Regular(
                  text2,
                  color: DefaultColors.white_800,// Bold number with period
                ),
              ]
          ),
        ),
      ],
    ),
  );
}
