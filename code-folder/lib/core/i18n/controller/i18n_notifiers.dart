import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/locale_cache.dart';
import '../domain/entity/i18n_asset.dart';
import 'i18n_providers.dart';

part 'i18n_notifiers.g.dart';

@Riverpod(keepAlive: true)
class LocalePod extends _$LocalePod {
  @override
  Locale build() => Locale(LocaleCache.instance.getLocaleId());

  Future<bool> changeLocale(String localeId) async {
    ref.read(appLocalizationState.notifier).state = AppLocalizationState.loading;
    await ref.read(i18nAssetNotifierProvider.notifier).load(localeId);
    final ok = ref.read(appLocalizationState) == AppLocalizationState.success;
    if (ok) {
      LocaleCache.instance.setLocaleId(localeId);
      state = Locale(localeId);
      return true;
    }
    return false;
  }
}

@Riverpod(keepAlive: true)
class I18nAssetNotifier extends _$I18nAssetNotifier {
  @override
  I18nAsset? build() {
    final cached = LocaleCache.instance.getLocaleAsset();
    if (cached != null) {
      return I18nAsset(Map<String, dynamic>.from(cached));
    }
    return null;
  }

  // KEEP your existing load() for user-triggered locale changes.
  Future<void> load(String localeId) async {
    ref.read(appLocalizationState.notifier).state = AppLocalizationState.loading;
    final env = await ref.read(i18nRepositoryProvider).getLocaleAsset(localeId);
    if (env.ok && env.data != null) {
      state = env.data;
      ref.read(appLocalizationState.notifier).state = AppLocalizationState.success;
    } else {
      ref.read(appLocalizationState.notifier).state = AppLocalizationState.error;
    }
  }

  //pure hydration (no repo calls, no async)
  // void hydrate(I18nAsset asset) {
  //   state = asset;
  // }
}

