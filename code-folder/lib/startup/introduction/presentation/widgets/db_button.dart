import 'package:flutter/material.dart';

import 'db_spacer.dart';

class DbButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final LinearGradient? gradient;
  final double? btnTextSize;
  final bool? isLoad;
  final double borderRadius;
  final bool isOutlinedButton;
  final IconData? prefixIcon;
  final MainAxisAlignment buttonContentAlignment;
  final Widget? prefixWidget;
  final double padding;

  const DbButton({
    super.key,
    this.borderRadius = 50,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.isLoad = false,
    this.width,
    this.height = 46,
    this.textColor,
    this.bgColor,
    this.gradient,
    this.btnTextSize = 16,
    this.borderColor,
    this.isOutlinedButton = false,
    this.prefixIcon,
    this.buttonContentAlignment = MainAxisAlignment.center,
    this.prefixWidget,
    this.padding = 12,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          gradient: gradient,
          color:
              bgColor ?? (isOutlinedButton ? Colors.transparent : Colors.white),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor ?? Colors.white),
        ),
        child: Row(
          mainAxisAlignment: buttonContentAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon,
                color: !isOutlinedButton ? Colors.black : Colors.white,
                size: btnTextSize,
              ),
              SizedBox(width: 6),
            ],
            if (prefixWidget != null) ...[
              prefixWidget ?? SizedBox(),
              DbSpacer(type: SpacerType.horizontal),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    textColor ??
                    (!isOutlinedButton ? Colors.black : Colors.white),
                fontSize: btnTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
