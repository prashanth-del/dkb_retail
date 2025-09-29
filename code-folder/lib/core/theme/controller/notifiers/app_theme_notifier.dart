import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:db_uicomponents/src/styles/dynamic_theme/data/models/app_theme.dart';
import '../../../cache/theme/cache/theme_cache.dart';
import '../../domain/brand.dart';
import '../state/theme_state.dart';
import '../theme_providers.dart';

class AppThemeNotifier extends StateNotifier<ThemeState> {
  AppThemeNotifier(this._ref) : super(const ThemeState.idle());

  final Ref _ref;

  Future<bool> load(Brand brand) async {
    state = ThemeState.loading(brand: brand);

    final env = await _ref.read(themeRepositoryProvider).getBrandTheme(brand);
    if (env.ok && env.data != null) {
      state = ThemeState.data(theme: env.data!, brand: brand, fromCache: false);
      return true;
    }

    // Fallback: cached blob
    final cached = await ThemeCache.instance.readThemeMap();
    if (cached != null) {
      state = ThemeState.data(
        theme: AppTheme.fromJson(cached),
        brand: brand,
        fromCache: true,
      );
      return true;
    }

    state = ThemeState.error(message: 'Theme load failed', brand: brand);
    return false;
  }

  /// Optional: set directly from a known AppTheme (e.g., tests)
  void hydrate(AppTheme t, {required Brand brand, bool fromCache = false}) {
    state = ThemeState.data(theme: t, brand: brand, fromCache: fromCache);
  }
}
