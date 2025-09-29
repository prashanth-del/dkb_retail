import 'dart:io';

import 'package:flutter/material.dart';

extension BuildContextExtension<T> on BuildContext {
  double width(double percent) =>
      ((percent / 100) * MediaQuery.of(this).size.width);

  double height(double percent) =>
      ((percent / 100) * MediaQuery.of(this).size.height);

  bool get isAndroid => Platform.isAndroid ? true : false;

  bool get isIOS => Platform.isIOS ? true : false;

  bool get isLTRDirection => Directionality.of(this) == TextDirection.ltr;

  bool get isRTLDirection => Directionality.of(this) == TextDirection.rtl;
}
