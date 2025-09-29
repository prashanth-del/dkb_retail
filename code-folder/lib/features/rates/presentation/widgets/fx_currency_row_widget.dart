// Currency selection row
import 'package:flutter/material.dart';

Widget currencyRow(
  String flag,
  String code,
  String value,
  double w,
  double h, {
  required bool istopBox,
  bool withDropdown = false,
  Function()? dropdownTap,
}) {
  return Container(
    decoration: BoxDecoration(color: Colors.white),
    padding: EdgeInsets.only(
      left: 10,
      right: 10,
      top: istopBox ? 10 : 20,
      bottom: istopBox ? 20 : 10,
    ),
    child: Row(
      children: [
        Text(flag, style: TextStyle(fontSize: w * 0.08)),
        SizedBox(width: w * 0.03),
        Text(
          code,
          style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.bold),
        ),
        if (withDropdown)
          InkWell(
            onTap: dropdownTap,
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.black54,
              size: w * 0.07,
            ),
          ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
