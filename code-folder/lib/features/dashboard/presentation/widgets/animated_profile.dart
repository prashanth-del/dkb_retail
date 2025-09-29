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
  double currentSize = 50; // initial size of the animated container
  late List<double> sizes;
  bool isAnimating = false;
  bool _initialized = false; // ensure didChangeDependencies runs only once
  bool showLogo = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      final width = MediaQuery.of(context).size.width;
      sizes = [width * 0.11, width * 0.14, width * 0.2];
      currentSize = sizes[0];

      // Start the recursive animation loop
      _startAnimationLoop();
    }
  }

  Future<void> _startAnimationLoop() async {
    // Wait 4 seconds before first animation
    await Future.delayed(const Duration(seconds: 4));

    while (mounted) {
      setState(() => currentSize = sizes[2]); // first step
      await Future.delayed(const Duration(milliseconds: 200));
      showLogo = false;
      setState(() => currentSize = sizes[1]); // second step
      await Future.delayed(const Duration(seconds: 2));

      showLogo = true;
      setState(() => currentSize = sizes[0]); // reset
      await Future.delayed(
        const Duration(seconds: 4),
      ); // wait before next cycle
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final photoRadius = size.width * 0.05;

    return SizedBox(
      width: size.width * 0.175,
      height: size.height * 0.075,
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
            duration: Duration(milliseconds: 300),
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
