import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/theme/controller/theme_providers.dart';
import 'package:dkb_retail/core/theme/theme.action.dart';
import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeToggleSheet extends ConsumerWidget {
  const ThemeToggleSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // toggleThemeMode(ref, ThemeMode.light);
    // switchBrand(ref, Brand.regular);
    final themeMode = ref.watch(themeModeProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.brightness_auto),
          title: const UiTextNew.b14Medium("System Default"),
          trailing: themeMode == ThemeMode.system
              ? Icon(Icons.check, color: context.bankTheme.colorScheme.primary)
              : null,
          onTap: () {
            ref.read(themeModeProvider.notifier).state = ThemeMode.system;
            toggleThemeMode(ref, ThemeMode.system);
       
          },
        ),
        ListTile(
          leading: const Icon(Icons.light_mode),
          title: const UiTextNew.b14Medium("Light Theme"),
          trailing: themeMode == ThemeMode.light
              ? Icon(Icons.check, color: context.colorScheme.primary)
              : null,
          onTap: () {
            ref.read(themeModeProvider.notifier).state = ThemeMode.light;
            toggleThemeMode(ref, ThemeMode.light);
   
          },
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const UiTextNew.b14Medium("Dark Theme"),
          trailing: themeMode == ThemeMode.dark
              ? Icon(Icons.check, color: context.colorScheme.primary)
              : null,
          onTap: () {
            ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
            toggleThemeMode(ref, ThemeMode.dark);

          },
        ),
      ],
    );
  }
}
