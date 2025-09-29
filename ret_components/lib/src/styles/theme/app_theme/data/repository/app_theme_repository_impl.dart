import 'package:fpdart/fpdart.dart';

import '../../app_theme.dart';
import '../../domain/repository/app_theme_failure.dart';

import '../../domain/repository/app_theme_repository.dart';
import '../datasource/app_theme_datasource.dart';

class AppThemeRepositoryImpl implements AppThemeRepository {
  @override
  Future<Either<AppThemeFailure, AppThemeEx>> getTheme() async {
    final datasource = AppThemeDatasource();

    try {
      final appTheme = await datasource.fetchColorScheme();
      return right(appTheme);
    } catch (e) {
      return left(const AppThemeFailure.serverFailure());
    }
  }
}
