import 'dart:ui' show ImageFilter;
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiLoader extends StatelessWidget {
  /// Text under the spinner.
  final String loadingText;

  /// Enable a full-screen backdrop (dim + optional blur).
  final bool withBackdrop;

  /// Backdrop tint color; defaults to a semi-transparent black.
  final Color? backdropColor;

  /// Backdrop blur amount (0 = no blur).
  final double backdropBlur;

  /// Whether the backdrop should absorb taps (block UI).
  /// If you're using GlobalLockUI (which already absorbs), set this to false.
  final bool absorb;

  const UiLoader({
    super.key,
    this.loadingText = 'Loading...',
    this.withBackdrop = false,
    this.backdropColor,
    this.backdropBlur = 0.0,
    this.absorb = true,
  });

  /// Handy factory if you always want the blocking overlay version.
  factory UiLoader.blocking({
    Key? key,
    String loadingText = 'Loading...',
    Color? backdropColor,
    double backdropBlur = 0.0,
    bool absorb = true,
  }) {
    return UiLoader(
      key: key,
      loadingText: loadingText,
      withBackdrop: true,
      backdropColor: backdropColor,
      backdropBlur: backdropBlur,
      absorb: absorb,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final card = Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.textTheme.bodyMedium?.color ?? Colors.blue,
              ),
              strokeWidth: 2,
            ),
          ),
          UiSpace.vertical(20),
          UiTextNew.b2Regular(loadingText),
        ],
      ),
    );

    if (!withBackdrop) return card;

    // Full-screen overlay with (optional) blur + tint + optional absorb
    final tint = backdropColor ?? (theme.brightness == Brightness.dark ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.2));

    return Stack(
      fit: StackFit.expand,
      children: [
        // (Optional) Blur the content behind
        Positioned.fill(
          child: IgnorePointer(
            // The blur/tint itself doesn't need to capture taps.
            ignoring: true,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: backdropBlur,
                sigmaY: backdropBlur,
              ),
              child: Container(color: tint),
            ),
          ),
        ),

        // Absorb taps if requested (prevents interaction under the overlay)
        if (absorb)
          const Positioned.fill(child: AbsorbPointer()),

        // Center the loader card
        Center(child: card),
      ],
    );
  }
}