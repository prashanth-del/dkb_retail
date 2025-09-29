import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cache/theme/cache/theme_cache.dart';
import 'controller/theme_providers.dart';
import 'domain/brand.dart';

/// To toggle theme mode
void toggleThemeMode(WidgetRef ref, ThemeMode mode) {
  // final current = ref.read(themeModeProvider);
  // final next = switch (current) {
  //   ThemeMode.dark => ThemeMode.light,
  //   ThemeMode.light => ThemeMode.dark,
  //   ThemeMode.system => ThemeMode.system,
  // };
  ref.read(themeModeProvider.notifier).state = mode;
}

/// To toggle between brands
Future<void> switchBrand(WidgetRef ref, Brand brand) async {
  final ok = await ref.read(themeStateProvider.notifier).load(brand);
  if (ok) {
    ref.read(brandProvider.notifier).state = brand;
    await ThemeCache.instance.saveBrandEnum(brand);
  }
}
