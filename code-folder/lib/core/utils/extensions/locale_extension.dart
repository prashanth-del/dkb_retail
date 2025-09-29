import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../i18n/controller/i18n_notifiers.dart';
import '../../i18n/controller/i18n_providers.dart';
import '../../i18n/localization.dart';

extension LocaleExtension on WidgetRef {
  @Deprecated('This i18n call is deprecated and will be removed in future. '
      'Please adapt to DefaultString.instance.<keyname>')
  String getLocaleString(String key, {String defaultValue = ""}) {
    final labelValue = this.watch(appLocalizationProvider).getString(key);
    if (labelValue.isEmpty) {
      return defaultValue;
    }
    return labelValue;
  }

  String getValidation(String key,{String defaultValue = ""}) {
    final labelValue = this.watch(appLocalizationProvider).getValidation(key);
    if (labelValue.isEmpty) {
      return defaultValue;
    }
    return labelValue;
  }

  Future<bool> switchLocale(LocaleId localeId) async {
    var localeString = "en";
    if (localeId == LocaleId.ar) {
      localeString = "ar";
    }
    final result = await read(localePodProvider.notifier).changeLocale(localeString);
    return result;
  }

  String getCurrentLang() {
    final defaultLang = this.watch(localePodProvider).languageCode;
    return defaultLang;
  }

  Locale getLocale() {
    return this.watch(localePodProvider);
  }
}
