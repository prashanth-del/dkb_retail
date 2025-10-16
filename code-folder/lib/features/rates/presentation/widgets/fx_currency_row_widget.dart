// Currency selection row
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

import 'package:flutter/services.dart';

Widget currencyRow(
    BuildContext context,
    String flag,
    String code,
    String value,
    double w,
    double h,
    FocusNode focusNode,{
      required bool istopBox,
      bool withDropdown = false,
      Function()? dropdownTap,
      TextEditingController? controller,
    }) {
  double? getDynamicFontSize(String value) {
    if (value.length <= 6) return w * 0.05;   // normal size
    if (value.length <= 10) return w * 0.045; // slightly smaller
    return w * 0.035;                          // smallest for big values
  }
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    padding: EdgeInsets.only(
      left: 10,
      right: 10,
      top: istopBox ? 10 : 20,
      bottom: istopBox ? 20 : 10,
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/images/flags/$flag',
          width: w * 0.08,
          height: w * 0.08,
          fit: BoxFit.contain,
        ),
        SizedBox(width: w * 0.03),
        Text(
          code,
          style: TextStyle(
            fontSize: w * 0.045,
            fontWeight: FontWeight.bold,
            color: DefaultColors.black,
          ),
        ),
        if (withDropdown)
          InkWell(
            onTap: dropdownTap,
            child: Icon(
              Icons.arrow_drop_down,
              color: DefaultColors.black,
              size: w * 0.07,
            ),
          ),
        const Spacer(),
        if (code == "QAR" && controller != null)
          SizedBox(
            width: w * 0.35,
            child:
            TextField(
              controller: controller,
              autofocus: false,
              focusNode: focusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final text = newValue.text;
                  final parts = text.split('.');
                  final beforeDecimal = parts[0];
                  if (beforeDecimal.length > 10) {
                    return oldValue;
                  }

                  return newValue;
                }),
              ],
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                fontSize: getDynamicFontSize(controller.text),
                fontWeight: FontWeight.w600,
                color: DefaultColors.black,
              ),
              textAlign: TextAlign.end,
            ),
          )
        else
          Text(
            value,
            style: TextStyle(
              fontSize: getDynamicFontSize(value),
              fontWeight: FontWeight.w600,
              color: DefaultColors.black,
            ),
          ),
      ],
    ),
  );
}
