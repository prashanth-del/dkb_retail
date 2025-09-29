import 'dart:ui';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../provider/overlay_provider.dart' as overlay;

class PrivacyOverlay extends ConsumerWidget {
  const PrivacyOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppInBackground = ref.watch(overlay.isBackgroundDetected);
    if (!isAppInBackground) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetPath.image.splash),
                fit: BoxFit.fill)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
            ),
          ),
        ),
      ),
    );

    // If you later want a blurred splash image, replace with BackdropFilter version.
  }
}
