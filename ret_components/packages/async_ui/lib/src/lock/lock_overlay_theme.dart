import 'package:flutter/widgets.dart';

/// Lock overlay theming (per-subtree).
///
/// Put a single [LockOverlayTheme] high up (e.g., around your `MaterialApp` via
/// `builder`) to set app-wide defaults for the global loading overlay shown by
/// `GlobalLockUI`.
///
/// You can override any field deeper in the tree using
/// [LockOverlayThemeOverride].
///
/// Precedence for the overlay widget:
/// 1) `LockOverlayTheme.data.overlayBuilder` (closest theme in the tree)
/// 2) `GlobalLockUI.overlayBuilder` (legacy parameter)
/// 3) A minimal dimmer + CircularProgressIndicator
///
/// ### Typical use
/// ```dart
/// // App level (MaterialApp.builder)
/// builder: (context, child) => LockOverlayTheme(
///   data: const LockOverlayThemeData(
///     visible: true,                // show overlay when locked
///     absorbTaps: true,             // block taps under overlay
///     allowBackWhileLocked: false,  // block system/appbar back
///   ),
///   child: GlobalLockUI(child: child ?? SizedBox.shrink()),
/// )
/// ```
///
/// ### Page-level overrides
/// ```dart
/// // On Splash, hide the overlay (keep lock behavior)
/// LockOverlayThemeOverride(
///   visible: false,
///   child: SplashPage(),
/// )
///
/// // On a specific screen, use a custom loader & allow back
/// LockOverlayThemeOverride(
///   overlayBuilder: (ctx, theme) => MyBrandLoader(),
///   allowBackWhileLocked: true,
///   child: OrdersPage(),
/// )
/// ```
typedef LockOverlayBuilder = Widget Function(
    BuildContext context,
    LockOverlayThemeData theme,
    );

/// Immutable data for lock overlay behavior and styling.
///
/// All fields have sensible defaults. Override only what you need.
class LockOverlayThemeData {
  /// Should the overlay be visible when globally locked?
  ///
  /// - `true` (default): show overlay during lock.
  /// - `false`: keep lock behavior (back/taps may still be blocked depending on
  ///   other flags) but do not render any overlay.
  final bool visible;

  /// Should taps be blocked while the overlay is shown?
  ///
  /// - `true` (default): overlay uses `AbsorbPointer` to swallow gestures.
  /// - `false`: show overlay but let taps pass through (rare).
  final bool absorbTaps;

  /// Allow system/app-bar back while locked?
  ///
  /// - `false` (default): `GlobalLockUI` prevents back navigation while locked.
  /// - `true`: back/pop is allowed even during lock (use sparingly).
  final bool allowBackWhileLocked;

  /// Optional barrier/dimmer color for the overlay background.
  ///
  /// - If `null`, a reasonable default is used (e.g., semi-transparent black).
  final Color? barrierColor;

  /// Optional custom overlay widget (e.g., your brand loader).
  ///
  /// If set, this takes precedence over `GlobalLockUI.overlayBuilder`.
  final LockOverlayBuilder? overlayBuilder;

  const LockOverlayThemeData({
    this.visible = true,
    this.absorbTaps = true,
    this.allowBackWhileLocked = false,
    this.barrierColor,
    this.overlayBuilder,
  });

  /// Create a new theme by overriding selected fields.
  LockOverlayThemeData copyWith({
    bool? visible,
    bool? absorbTaps,
    bool? allowBackWhileLocked,
    Color? barrierColor,
    LockOverlayBuilder? overlayBuilder,
  }) {
    return LockOverlayThemeData(
      visible: visible ?? this.visible,
      absorbTaps: absorbTaps ?? this.absorbTaps,
      allowBackWhileLocked: allowBackWhileLocked ?? this.allowBackWhileLocked,
      barrierColor: barrierColor ?? this.barrierColor,
      overlayBuilder: overlayBuilder ?? this.overlayBuilder,
    );
  }
}

/// InheritedWidget that provides [LockOverlayThemeData] to descendants.
///
/// Use [LockOverlayTheme.of] to read the closest theme in the tree.
class LockOverlayTheme extends InheritedWidget {
  final LockOverlayThemeData data;

  const LockOverlayTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Returns the nearest [LockOverlayThemeData] or defaults if none found.
  static LockOverlayThemeData of(BuildContext context) {
    final t = context.dependOnInheritedWidgetOfExactType<LockOverlayTheme>();
    return t?.data ?? const LockOverlayThemeData();
  }

  @override
  bool updateShouldNotify(LockOverlayTheme oldWidget) => oldWidget.data != data;
}
