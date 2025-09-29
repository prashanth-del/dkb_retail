import 'package:flutter/material.dart';

import '../app_theme/app_theme.dart';
import 'base_appearance.dart';

class DefaultAppearance extends BaseAppearance {
  @override
  ThemeData getThemeData(Brightness brightness, AppThemeEx appTheme) {
    final themeColors = brightness == Brightness.light
        ? appTheme.lightTheme
        : appTheme.darkTheme;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: themeColors.primary,
      onPrimary: themeColors.onPrimary,
      secondary: themeColors.secondary,
      onSecondary: themeColors.onSecondary,
      error: themeColors.error,
      onError: themeColors.onError,
      surface: themeColors.surface,
      onSurface: themeColors.onSurface,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      // fontFamily: "kBuiltInFontFamily",
      scaffoldBackgroundColor: themeColors.scaffoldBackgroundColor,
      extensions: <ThemeExtension<dynamic>>[
        UiThemeExtension(
          defaultTextColor: themeColors.defaultTextColor,
        ),
      ],

    );
  }
}
