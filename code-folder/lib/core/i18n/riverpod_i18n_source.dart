import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/i18n_notifiers.dart';
import 'i18n_source.dart';

class RiverpodI18nSource implements I18nSource {
  final WidgetRef _ref;
  RiverpodI18nSource(this._ref);

  @override
  String text(String key, {required String fallback}) {
    final asset = _ref.read(i18nAssetNotifierProvider);
    return asset?.text(key, fallback: fallback) ?? fallback;
  }

  @override
  String validation(String key, {required String fallback}) {
    final asset = _ref.read(i18nAssetNotifierProvider);
    return asset?.validation(key, fallback: fallback) ?? fallback;
  }
}
