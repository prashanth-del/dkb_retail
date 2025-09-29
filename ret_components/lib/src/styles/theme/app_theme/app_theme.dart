import '../colorscheme/colorscheme.dart';
import '../colorscheme/default_colorscheme.dart';
import 'domain/repository/app_theme_repository.dart';

class BuiltInThemes {
  static const String defaultTheme = 'Default';
}

@Deprecated('Use dynamic theme to get theme from service or local')
class AppThemeEx {
  final bool builtIn;
  final String themeName;
  final AppColorScheme lightTheme;
  final AppColorScheme darkTheme;

  const AppThemeEx({
    required this.builtIn,
    required this.themeName,
    required this.lightTheme,
    required this.darkTheme,
  });

  static const AppThemeEx fallback = AppThemeEx(
    builtIn: true,
    themeName: BuiltInThemes.defaultTheme,
    lightTheme: DefaultColorScheme.light(),
    darkTheme: DefaultColorScheme.dark(),
  );

  static Iterable<AppThemeEx> get builtIns => themeMap.entries
      .map(
        (entry) => AppThemeEx(
      builtIn: true,
      themeName: entry.key,
      lightTheme: entry.value.lightTheme,
      darkTheme: entry.value.darkTheme,
    ),
  )
      .toList();

  static AppThemeEx fromName(String themeName) {
    for (final theme in builtIns) {
      if (theme.themeName == themeName) {
        return theme;
      }
    }
    throw ArgumentError('The theme $themeName does not exist.');
  }

  static Future<AppThemeEx> fromServer() async {
    final repository = AppThemeRepository();

    final failureOrTheme = await repository.getTheme();

    return failureOrTheme.fold(
          (failure) => throw Exception(),
          (r) => r,
    );
  }
}
