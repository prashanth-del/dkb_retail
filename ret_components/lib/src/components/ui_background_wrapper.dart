import 'package:db_uicomponents/src/styles/theme/colorscheme/colors/default_colors.dart';
import 'package:flutter/material.dart';

class UiBackgroundWrapper extends StatelessWidget {
  // a background wrapper for dkb_retail app
  final Widget child;
  final List<Color>? gradientColors;
  final Gradient? gradient;
  const UiBackgroundWrapper(
      {super.key, required this.child, this.gradient, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Left top gradient
        ShaderMask(
          shaderCallback: (Rect bounds) {
            // Vertical fade mask
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black, // fully visible at top
                Colors.transparent, // fade out at bottom
              ],
              stops: [0.3, 1.0], // start fade at 70%
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn, // keeps top, fades out bottom
          child: Container(
            height: size.height * 0.15,
            width: size.width,
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: gradientColors ??
                        [
                          DefaultColors.green_82.withAlpha(60),
                          DefaultColors.blue60.withAlpha(60),
                        ],
                  ),
            ),
          ),
        ),
        child
      ],
    );
  }
}
