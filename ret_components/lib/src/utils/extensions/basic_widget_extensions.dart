import 'package:flutter/material.dart';

extension FittedBoxX on Widget {
  Widget fittedBox(BoxFit fit) {
    return FittedBox(
      fit: fit,
      child: this,
    );
  }
}

extension PaddingX on Widget {
  Widget padding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
}

extension ExpandedX on Widget {
  Widget expanded([int? flex]) {
    return Expanded(
      flex: flex ?? 1,
      child: this,
    );
  }
}

extension DirectionalPadding on EdgeInsets {
  EdgeInsets toDirectional(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return EdgeInsets.only(
      left: isRtl ? right : left,
      right: isRtl ? left : right,
      top: top,
      bottom: bottom,
    );
  }
}

extension DirectionalExtension on Widget {
  Widget toLTRDirection() {
    return Directionality(textDirection: TextDirection.ltr, child: this);
  }

  Widget toRTLDirection() {
    return Directionality(textDirection: TextDirection.rtl, child: this);
  }

  Widget toDirectional(context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Transform.rotate(
      angle: isRtl ? 3.14 : 0, // Rotate 180 degrees for RTL
      child: this,
    );
  }
}

extension DirectionalBorderRadius on BorderRadius {
  BorderRadius toDirectional(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return BorderRadius.only(
      topLeft: isRtl ? topRight : topLeft,
      topRight: isRtl ? topLeft : topRight,
      bottomLeft: isRtl ? bottomRight : bottomLeft,
      bottomRight: isRtl ? bottomLeft : bottomRight,
    );
  }
}
