import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../db_uicomponents.dart';

class ActionButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const ActionButtonWidget({
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? DefaultColors.blue_300,
          // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: UiTextNew.customRubik(
            text,
            fontSize: 14,
            color: textColor ?? Colors.white,
          ),

        ),
      ),
    );
  }
}
