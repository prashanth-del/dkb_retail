import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedIconWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _rotation = Tween<double>(
      begin: -0.05 * math.pi,
      end: 0.05 * math.pi, // 360 degrees in radians
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat(); // Infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, child) {
        return Transform.rotate(angle: _rotation.value, child: child);
      },
      child: widget.child,
    );
  }
}
