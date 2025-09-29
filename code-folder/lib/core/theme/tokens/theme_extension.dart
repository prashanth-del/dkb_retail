import 'package:flutter/material.dart';
import 'app_theme_colors.dart';

/// Tiny accessor so you can do: `context.color.brand`
extension BankTheme on BuildContext {
  ThemeData get bankTheme => Theme.of(this);
  AppThemeColors get color => AppThemeColors.of(this);
  bool get isDarkMode => bankTheme.brightness == Brightness.dark;
}
