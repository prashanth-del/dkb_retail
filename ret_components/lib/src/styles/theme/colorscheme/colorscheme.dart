import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
// import '../../../utils/color_converter.dart';
import '../../../utils/color_converter.dart';
import '../app_theme/app_theme.dart';
import 'default_colorscheme.dart';
part 'colorscheme.g.dart';

class ColorSchemeHolder {
  final AppColorScheme lightTheme;
  final AppColorScheme darkTheme;

  const ColorSchemeHolder({
    required this.lightTheme,
    required this.darkTheme,
  });
}

const Map<String, ColorSchemeHolder> themeMap = {
  BuiltInThemes.defaultTheme: ColorSchemeHolder(
    lightTheme: DefaultColorScheme.light(),
    darkTheme: DefaultColorScheme.dark(),
  ),
};

@JsonSerializable(
  converters: [
    ColorConverter(),
  ],
)
class AppColorScheme {
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Color error;
  final Color onError;
  final Color scaffoldBackgroundColor;
  final Color defaultTextColor;

  const AppColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.error,
    required this.onError,
    required this.scaffoldBackgroundColor,
    required this.defaultTextColor,
  });

  factory AppColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppColorSchemeFromJson(json);
}
