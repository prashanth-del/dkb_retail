import 'package:flutter/material.dart';

/// Read all color tokens from the active ThemeData/ColorScheme.
/// Usage: `final c = AppThemeColors.of(context);`
class AppThemeColors {
  AppThemeColors._(this._c);
  final ColorScheme _c;

  static AppThemeColors of(BuildContext context) =>
      AppThemeColors._(Theme.of(context).colorScheme);

  // ---- Brand / Primary ----
  Color get brand              => _c.primary;
  Color get onBrand            => _c.onPrimary;
  Color get brandContainer     => _c.primaryContainer;
  Color get onBrandContainer   => _c.onPrimaryContainer;
  Color get brandInverse       => _c.inversePrimary;

  // ---- Accent / Secondary ----
  Color get accent             => _c.secondary;
  Color get onAccent           => _c.onSecondary;
  Color get accentContainer    => _c.secondaryContainer;
  Color get onAccentContainer  => _c.onSecondaryContainer;

  // ---- Tertiary (support) ----
  Color get tertiary           => _c.tertiary;
  Color get onTertiary         => _c.onTertiary;
  Color get tertiaryContainer  => _c.tertiaryContainer;
  Color get onTertiaryContainer=> _c.onTertiaryContainer;

  // ---- Surfaces / Background ----
  Color get surface            => _c.surface;
  Color get onSurface          => _c.onSurface;
  @Deprecated('surfaceVariant is deprecated and shouldn\'t be used. Use surfaceContainerHighest instead.')
  Color get surfaceVariant     => _c.surfaceVariant;
  Color get onSurfaceVariant   => _c.onSurfaceVariant;

  // M3 extended surface roles (Flutter 3.22+)
  Color get surfaceDim         => _c.surfaceDim;
  Color get surfaceBright      => _c.surfaceBright;
  Color get surfaceLowest      => _c.surfaceContainerLowest;
  Color get surfaceLow         => _c.surfaceContainerLow;
  Color get surfaceContainer   => _c.surfaceContainer;
  Color get surfaceHigh        => _c.surfaceContainerHigh;
  Color get surfaceHighest     => _c.surfaceContainerHighest;
  Color get surfaceTint        => _c.surfaceTint;

  @Deprecated('background is deprecated and shouldn\'t be used. Use surface instead.')
  Color get background         => _c.background;
  @Deprecated('onBackground is deprecated and shouldn\'t be used. Use onSurface instead.')
  Color get onBackground       => _c.onBackground;

  // ---- Semantic ----
  Color get danger             => _c.error;
  Color get onDanger           => _c.onError;

  // ---- Utility ----
  Color get outline            => _c.outline;
  Color get outlineVariant     => _c.outlineVariant;
  Color get shadow             => _c.shadow;
  Color get scrim              => _c.scrim;
  Color get inverseSurface     => _c.inverseSurface;
  Color get onInverseSurface   => _c.onInverseSurface;

  // ---- Helpful aliases (optional) ----
  Color get ctaBg              => brand;
  Color get ctaFg              => onBrand;
  Color get textPrimary        => onSurface;
  Color get textMuted          => onSurfaceVariant;
  Color get icon               => onSurfaceVariant;
  Color get divider            => outline;
}
