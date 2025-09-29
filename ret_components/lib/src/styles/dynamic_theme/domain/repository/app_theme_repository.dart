import '../../data/models/app_theme.dart';

abstract class AppThemeRepository {
  Future<AppTheme?> fetchThemeData(
      {required String themeUrl,
      required String themeAssetPath,
      String? token});
}
