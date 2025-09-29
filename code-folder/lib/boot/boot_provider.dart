import 'package:dkb_retail/common/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/cache/locale_cache.dart';
import '../core/cache/theme/cache/theme_cache.dart';
import '../core/i18n/controller/i18n_providers.dart';
import '../core/i18n/domain/entity/i18n_asset.dart';
import '../core/theme/controller/theme_providers.dart';
import '../core/theme/domain/brand.dart';

// ----- your existing BootResult/BootReady/BootError models -----
class BootPiece {
  final bool ok;
  final bool fromCache;
  const BootPiece({required this.ok, required this.fromCache});
}

sealed class BootResult {
  const BootResult();
}

class BootReady extends BootResult {
  final String localeId;
  final I18nAsset i18nAsset;
  final String themeKey;
  final bool usedCache;
  const BootReady({
    required this.localeId,
    required this.i18nAsset,
    required this.themeKey,
    required this.usedCache,
  });
}

class BootError extends BootResult {
  final String message;
  const BootError(this.message);
}

final bootProvider = FutureProvider<BootResult>((ref) async {
  // 1) open Hive theme box
  await ThemeCache.instance.init(encrypted: false);

  // 2) i18n
  final localeId = LocaleCache.instance.getLocaleId();
  final i18nEnv = await ref
      .read(i18nRepositoryProvider)
      .getLocaleAsset(localeId);
  final i18nOk = i18nEnv.ok && i18nEnv.data?.hasI18n == true;

  // 3) theme brand (enum)
  final cachedBrand = await ThemeCache.instance.readBrandEnum();
  consoleLog('Theme Brand: $cachedBrand');
  final brand = cachedBrand ?? Brand.regular;
  ref.read(brandProvider.notifier).state = brand;

  final themeOk = await ref.read(themeStateProvider.notifier).load(brand);

  if (i18nOk && themeOk) {
    return BootReady(
      localeId: localeId,
      i18nAsset: i18nEnv.data!,
      themeKey: brand.key,
      usedCache: !i18nEnv.ok && i18nEnv.data != null,
    );
  }

  final why = switch ((i18nOk, themeOk)) {
    (false, false) => 'Network Error',
    (false, true) => 'Network Error',
    (true, false) => 'Network Error',
    (true, true) => null,
  };

  return BootError(why ?? 'Unexpected error');
});
