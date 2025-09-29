import 'package:flutter/material.dart';

import '../app_theme/app_theme.dart';

abstract class BaseAppearance {
  ThemeData getThemeData(Brightness brightness, AppThemeEx appTheme);
}

@immutable
class UiThemeExtension extends ThemeExtension<UiThemeExtension> {
  final Color? defaultTextColor;

  const UiThemeExtension({
    required this.defaultTextColor,
  });

  @override
  ThemeExtension<UiThemeExtension> copyWith({
    Color? defaultTextColor,
  }) {
    return UiThemeExtension(
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
    );
  }

  @override
  ThemeExtension<UiThemeExtension> lerp(
      covariant ThemeExtension<UiThemeExtension>? other, double t) {
    if (other is! UiThemeExtension) {
      return this;
    }

    return UiThemeExtension(
      defaultTextColor: Color.lerp(defaultTextColor, other.defaultTextColor, t),
    );
  }
}
