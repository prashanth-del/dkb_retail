import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import '../../../colorscheme/colorscheme.dart';
import '../../app_theme.dart';

abstract class AppThemeDatasource {
  factory AppThemeDatasource() => AppThemeDatasourceImpl();

  Future<AppThemeEx> fetchColorScheme();
}

class AppThemeDatasourceImpl implements AppThemeDatasource {
  @override
  Future<AppThemeEx> fetchColorScheme() async {
    try {
      final jsonString =
      await rootBundle.loadString('assets/responses/colorscheme.json');

      final response = await jsonDecode(jsonString);

      final lightColors = response['lightTheme'];
      final darkColors = response['darkTheme'];

      final isDarkThemePresent = darkColors.toString() != '{}';

      final lightColorScheme = AppColorScheme.fromJson(lightColors);

      await Future.delayed(const Duration(seconds: 2));

      return AppThemeEx(
        builtIn: false,
        themeName: 'Server',
        lightTheme: lightColorScheme,
        darkTheme: isDarkThemePresent
            ? AppColorScheme.fromJson(darkColors)
            : lightColorScheme,
      );
    } catch (e) {
      log('error from AppTheme Datasource: $e');
      throw Exception();
    }
  }
}
