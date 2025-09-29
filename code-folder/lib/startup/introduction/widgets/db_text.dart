import 'package:flutter/material.dart';

import 'db_colors.dart';

class DbText extends StatelessWidget {
  final String text;
  final TextAlign? textAlignment;
  final double? fontSize;
  final dynamic textDecoration;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLine;
  final TextOverflow? overflow;

  const DbText({
    super.key,
    required this.text,
    this.textAlignment = TextAlign.center,
    this.fontSize = 14,
    this.textDecoration,
    this.fontWeight = FontWeight.w500,
    this.color = DbColors.whiteColor,
    this.maxLine,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        decoration: textDecoration,
        fontSize: fontSize ?? 15,
        overflow: overflow,
        fontWeight: fontWeight,
      ),
      textAlign: textAlignment,
    );
  }
}
