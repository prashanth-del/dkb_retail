import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonNewWidget extends StatelessWidget {
  final String title;
  final void Function() onPress;
  final double? width;
  final double? height;
  final Color? titleColor;
  final Color? buttonColor;
  final double? fontSize;
  final double? radius;
  final EdgeInsets? padding;
  final Gradient? gradient;
  final Color? borderColor;
  final FontWeight? fontWeight;
  const CustomButtonNewWidget({
    super.key,
    this.fontSize,
    required this.onPress,
    required this.title,
    this.width,
    this.gradient,
    this.titleColor,
    this.buttonColor,
    this.radius,
    this.padding,
    this.borderColor,
    this.height,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.screenWidth - 14,
      height: height,
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
            borderRadius: BorderRadius.circular(radius ?? 20),
            color: buttonColor ?? DefaultColors.blueDarkBase,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(14.0),
            child: Center(
              child: UiTextNew.customRubik(
                title,
                fontSize: fontSize ?? 14,
                color: titleColor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
