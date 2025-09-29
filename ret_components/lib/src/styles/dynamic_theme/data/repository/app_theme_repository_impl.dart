import 'package:flutter/material.dart';

import '../../domain/repository/app_theme_repository.dart';
import '../datasource/app_theme_datasource.dart';
import '../models/app_theme.dart';

class AppThemeRepositoryImpl implements AppThemeRepository {
  final AppThemeDatasource datasource;

  AppThemeRepositoryImpl(this.datasource);

  @override
  Future<AppTheme?> fetchThemeData(
      {required String themeUrl,
      required String themeAssetPath,
      String? token}) async {
    try {
      return await datasource.fetchThemeData(
          themeUrl: themeUrl, themeAssetPath: themeAssetPath, token: token);
    } catch (_) {
      debugPrint('Failed to load theme');
      return null;
    }
  }
}
