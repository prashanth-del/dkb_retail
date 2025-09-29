import 'package:flutter/material.dart';

class UiSpace extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const UiSpace(
    this.width,
    this.height, {
    this.color,
    super.key,
  });

  const UiSpace.vertical(
    this.height, {
    this.color,
    super.key,
  }) : width = null;

  const UiSpace.horizontal(
    this.width, {
    this.color,
    super.key,
  }) : height = null;

  @override
  Widget build(BuildContext context) {
    if (color != null) {
      return SizedBox(
        height: height,
        width: width,
        child: ColoredBox(
          color: color!,
        ),
      );
    } else {
      return SizedBox(width: width, height: height);
    }
  }
}
