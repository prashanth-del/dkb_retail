import 'package:freezed_annotation/freezed_annotation.dart';
import 'font_sizes.dart';
import 'theme_data_model.dart';

part 'app_theme.freezed.dart';
part 'app_theme.g.dart';

@freezed
class AppTheme with _$AppTheme {
  const factory AppTheme({
    required ThemeDataModel lightTheme,
    required ThemeDataModel darkTheme,
    required FontSizes fontSizes,
  }) = _AppTheme;

  factory AppTheme.fromJson(Map<String, dynamic> json) =>
      _$AppThemeFromJson(json);
}