import 'package:fpdart/fpdart.dart';

import '../../../../../../styles.dart';
import '../../data/repository/app_theme_repository_impl.dart';
import 'app_theme_failure.dart';

abstract class AppThemeRepository {
  factory AppThemeRepository() => AppThemeRepositoryImpl();

  Future<Either<AppThemeFailure, AppThemeEx>> getTheme();
}
