import 'package:db_uicomponents/src/styles/dynamic_theme/domain/entity/theme_config.dart'
    show ThemeConfig;
import 'package:dkb_retail/core/theme/controller/state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/network_client_provider.dart';
import '../../cache/theme/cache/theme_cache.dart';
import '../data/datasource/local_theme_datasource.dart';
import '../data/datasource/remote_theme_datasource.dart';
import '../data/datasource/theme_datasource.dart';
import '../data/repository/theme_repository_impl.dart';
import '../domain/brand.dart';
import 'notifiers/app_theme_notifier.dart';

const bool kUseLocalTheme = bool.fromEnvironment(
  'USE_LOCAL_THEME',
  defaultValue: true,
);

/// DI: datasource
final themeDatasourceProvider = Provider<ThemeDatasource>((ref) {
  if (kUseLocalTheme) return const LocalThemeDatasource();
  return RemoteThemeDatasource(ref.read(networkClientProvider));
});

/// DI: repository
final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) => ThemeRepositoryImpl(
    ref.read(themeDatasourceProvider),
    ThemeCache.instance,
  ),
);

/// enum-based current brand
final brandProvider = StateProvider<Brand>((_) => Brand.regular);

/// Theme state (Freezed)
final themeStateProvider = StateNotifierProvider<AppThemeNotifier, ThemeState>(
  (ref) => AppThemeNotifier(ref),
);

/// ThemeConfig for MaterialApp (maps state → ThemeData)
final themeConfigProvider = Provider<ThemeConfig>((ref) {
  final st = ref.watch(themeStateProvider);

  return st.maybeWhen(
    data: (theme, brand, fromCache) => ThemeConfig.fromAppTheme(theme),
    orElse: () => ThemeConfig.fromAppTheme(null), // default fallback
  );
});

/// Optional: manual ThemeMode override
final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.light);
