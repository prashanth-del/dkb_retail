import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../network/network_client_provider.dart';
import '../../cache/locale_cache.dart';
import '../data/datasource/i18n_datasource.dart';
import '../data/datasource/local_i18n_datasource.dart';
import '../data/datasource/remote_i18n_datasource.dart';
import '../data/repository/i18n_repository_impl.dart';
import '../domain/repository/i18n_repository.dart';
import '../localization.dart';

const bool kUseLocalI18n = bool.fromEnvironment('USE_LOCAL_I18N', defaultValue: true);

final i18nDatasourceProvider = Provider<I18nDatasource>((ref) {
    if (kUseLocalI18n) return const LocalI18nDatasource();
    return RemoteI18nDatasource(ref.read(networkClientProvider));
});

final i18nRepositoryProvider = Provider<I18nRepository>((ref) {
    return I18nRepositoryImpl(
        ref.read(i18nDatasourceProvider),
        LocaleCache.instance,
    );
});

enum AppLocalizationState { idle, loading, success, error }

/// Simple UI state for loaders/errors
final appLocalizationState = StateProvider<AppLocalizationState>((_) => AppLocalizationState.idle);

/// AppLocalization DI
final appLocalizationProvider = Provider<AppLocalization>((ref) => AppLocalization(ref));

/// Passive delegate (built once)
final appLocalizationDelegateProvider = Provider<LocalizationsDelegate<AppLocalization>>(
        (ref) => AppLocalizationDelegate(ref),
);
