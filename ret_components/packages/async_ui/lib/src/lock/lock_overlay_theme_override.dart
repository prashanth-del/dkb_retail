import 'package:flutter/material.dart';
import 'lock_overlay_theme.dart';

/// A convenience wrapper to override [LockOverlayTheme] fields for a subtree.
///
/// Useful when a single page/screen needs a different loader UI or behavior.
///
/// Examples:
/// - Hide overlay on Splash: `visible: false`
/// - Use branded loader: `overlayBuilder: (...) => UiLoader(...)`
/// - Allow back during lock (rare): `allowBackWhileLocked: true`
class LockOverlayThemeOverride extends StatelessWidget {
  const LockOverlayThemeOverride({
    super.key,
    required this.child,

    /// Override the overlay widget (takes precedence over app-level builder).
    this.overlayBuilder,

    /// Override the dimmer color (e.g., use brand color with opacity).
    this.barrierColor,

    /// If true, taps under overlay are blocked. If false, taps pass through.
    this.absorbTaps,

    /// If true, allows system/app-bar back during lock.
    this.allowBackWhileLocked,

    /// If false, completely hides the overlay in this subtree.
    this.visible,
  });

  /// The subtree to which this override applies.
  final Widget child;

  /// Custom widget for the overlay (loader/dimmer).
  final LockOverlayBuilder? overlayBuilder;

  /// Color for the overlay barrier (dimmer).
  final Color? barrierColor;

  /// Whether to block taps while overlay is visible.
  final bool? absorbTaps;

  /// Whether to allow back navigation while locked.
  final bool? allowBackWhileLocked;

  /// Whether to show the overlay at all in this subtree.
  final bool? visible;

  @override
  Widget build(BuildContext context) {
    final parent = LockOverlayTheme.of(context);
    return LockOverlayTheme(
      data: parent.copyWith(
        overlayBuilder: overlayBuilder,
        barrierColor: barrierColor,
        absorbTaps: absorbTaps,
        allowBackWhileLocked: allowBackWhileLocked,
        visible: visible,
      ),
      child: child,
    );
  }
}
