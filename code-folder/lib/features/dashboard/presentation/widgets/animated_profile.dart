import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

class AnimatedProfilePhoto extends StatefulWidget {
  const AnimatedProfilePhoto({super.key});

  @override
  State<AnimatedProfilePhoto> createState() => _AnimatedProfilePhotoState();
}

class _AnimatedProfilePhotoState extends State<AnimatedProfilePhoto> {
  double currentSize = 50;
  late List<double> sizes;
  bool _initialized = false;
  bool showLogo = false;
  bool _isDisposed = false; // 👈 cleanup flag

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      final width = MediaQuery.of(context).size.width;
      sizes = [width * 0.11, width * 0.14, width * 0.2];
      currentSize = sizes[0];

      _startAnimationLoop();
    }
  }

  Future<void> _startAnimationLoop() async {
    await Future.delayed(const Duration(seconds: 4));

    while (mounted && !_isDisposed) {
      if (!mounted) return;
      setState(() => currentSize = sizes[2]);
      await Future.delayed(const Duration(milliseconds: 200));
      if (!mounted) return;

      showLogo = false;
      setState(() => currentSize = sizes[1]);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      showLogo = true;
      setState(() => currentSize = sizes[0]);
      await Future.delayed(const Duration(seconds: 4));
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // 👈 stops future loops instantly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final photoRadius = size.aspectRatio * 45;

    return SizedBox(
      width: size.width * 0.15,
      height: size.height * 0.07,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(end: currentSize),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Container(
                width: value,
                height: value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: GradientBoxBorder(
                    width: 2,
                    gradient: DefaultColors.primaryBackgroundGradient,
                  ),
                ),
              );
            },
          ),
          AnimatedCrossFade(
            crossFadeState: showLogo
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
            firstChild: CircleAvatar(
              radius: photoRadius,
              child: Image.asset(
                AssetPath.image.loginHeaderlogo,
                fit: BoxFit.cover,
              ),
            ),
            secondChild: CircleAvatar(
              radius: photoRadius,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/100?img=1',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
