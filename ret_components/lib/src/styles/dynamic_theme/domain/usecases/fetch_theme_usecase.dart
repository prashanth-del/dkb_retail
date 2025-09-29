import 'package:db_uicomponents/src/styles/dynamic_theme/controller/notifier/app_theme_notifier.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/datasource/app_theme_datasource.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/repository/app_theme_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/theme_config.dart';
import '../repository/app_theme_repository.dart';

class FetchThemeUseCase {
  final AppThemeRepository repository;

  FetchThemeUseCase(this.repository);

  Future<ThemeConfig> execute(
      {required String themeUrl,
      required String themeAssetPath,
      String? token}) async {
    final appTheme = await repository.fetchThemeData(
        themeUrl: themeUrl, themeAssetPath: themeAssetPath, token: token);
    return ThemeConfig.fromAppTheme(appTheme);
  }
}


