import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

Widget rashid(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: DefaultColors.white),
    ),
    padding: EdgeInsets.all(MediaQuery.of(context).size.aspectRatio * 40),
    child: Image.asset(
      "assets/gif/Dukhan Bank Chatbot Homepage GIF.gif",
      width: MediaQuery.of(context).size.aspectRatio * 80,
    ),
  );
}
