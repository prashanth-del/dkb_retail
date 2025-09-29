import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cache/locale_cache.dart';
import 'controller/i18n_notifiers.dart';
import 'controller/i18n_providers.dart';

enum LocaleId { en, ar }
final localeIds = LocaleId.values.map((e) => e.name).toList();

class AppLocalization {
  final Ref ref;
  AppLocalization(this.ref);

  /// If you ever need current locale in widgets:
  Locale get locale => ref.watch(localePodProvider);

  /// Pure reads (no writes)
  String getString(String path, {String defaultValue = ""}) {
    final asset = ref.read(i18nAssetNotifierProvider);
    return asset?.text(path, fallback: defaultValue) ?? defaultValue;
  }

  String getValidation(String key, {String defaultValue = ""}) {
    final asset = ref.read(i18nAssetNotifierProvider);
    return asset?.validation(key, fallback: defaultValue) ?? defaultValue;
  }

/// Remove any load/init methods here – boot will hydrate i18n.
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Ref ref;
  AppLocalizationDelegate(this.ref);

  @override
  bool isSupported(Locale locale) => localeIds.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    return AppLocalization(ref); // no writes here
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) => false;
}

