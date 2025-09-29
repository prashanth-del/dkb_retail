import 'package:db_uicomponents/src/styles/dynamic_theme/data/datasource/app_theme_datasource.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/repository/app_theme_repository_impl.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/domain/repository/app_theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/theme_config.dart';
import '../../domain/usecases/fetch_theme_usecase.dart';

class AppThemeNotifier extends StateNotifier<ThemeConfig?> {
  final FetchThemeUseCase fetchThemeUseCase;

  AppThemeNotifier(this.fetchThemeUseCase) : super(null);

  Future<void> fetchTheme(
      {required String themeUrl,
      required String themeAssetPath,
      String? token}) async {
    final theme = await fetchThemeUseCase.execute(
        themeUrl: themeUrl, themeAssetPath: themeAssetPath, token: token);
    state = theme;
  }
}
// enum AppThemeMode { system, light, dark }

// class AppThemeNotifier extends StateNotifier<ThemeConfig?> {
//   final FetchThemeUseCase fetchThemeUseCase;

//   AppThemeMode _themeMode = AppThemeMode.system;
//   AppThemeMode get themeMode => _themeMode;

//   AppThemeNotifier(this.fetchThemeUseCase) : super(null);

//   Future<void> fetchTheme({
//     required String themeUrl,
//     required String themeAssetPath,
//     String? token,
//   }) async {
//     final theme = await fetchThemeUseCase.execute(
//       themeUrl: themeUrl,
//       themeAssetPath: themeAssetPath,
//       token: token,
//     );
//     state = theme;
//   }

//   void toggleTheme() {
//     if (_themeMode == AppThemeMode.light) {
//       _themeMode = AppThemeMode.dark;
//     } else {
//       _themeMode = AppThemeMode.light;
//     }
//     // 🔥 This is important — force rebuild
//     state = state;
//   }
// }

// 1️⃣ Datasource provider (you'll implement the datasource in your app)
final appThemeDatasourceProvider = Provider<AppThemeDatasource>((ref) {
  return AppThemeDatasourceImpl(); // your concrete impl
});

// 2️⃣ Repository provider
final appThemeRepositoryProvider = Provider<AppThemeRepository>((ref) {
  final datasource = ref.watch(appThemeDatasourceProvider);
  return AppThemeRepositoryImpl(datasource);
});

// 3️⃣ UseCase provider
final fetchThemeUseCaseProvider = Provider<FetchThemeUseCase>((ref) {
  final repository = ref.watch(appThemeRepositoryProvider);
  return FetchThemeUseCase(repository);
});

// 4️⃣ StateNotifier provider for theme
final appThemeNotifierProvider =
    StateNotifierProvider<AppThemeNotifier, ThemeConfig?>((ref) {
  final useCase = ref.watch(fetchThemeUseCaseProvider);
  return AppThemeNotifier(useCase);
});
