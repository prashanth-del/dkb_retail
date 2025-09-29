import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../cache/theme/cache/theme_cache.dart';
import '../../domain/brand.dart';
import '../datasource/theme_datasource.dart';

abstract class ThemeRepository {
  Future<ApiEnvelope<AppTheme>> getBrandTheme(Brand brand);
}

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDatasource ds;
  final ThemeCache cache;
  ThemeRepositoryImpl(this.ds, this.cache);

  @override
  Future<ApiEnvelope<AppTheme>> getBrandTheme(Brand brand) async {
    final env = await ds.getBrandTheme(brand);
    if (env.ok && env.data != null) {
      await cache.saveBrandEnum(brand);
      await cache.saveThemeMap(env.data!.toJson());
    }
    return env;
  }
}
