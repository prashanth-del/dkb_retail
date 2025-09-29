import 'package:flutter/material.dart';

class UISlideAnimation extends StatefulWidget {
  final Widget child;

  const UISlideAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<UISlideAnimation> createState() => _UISlideAnimationState();
}

class _UISlideAnimationState extends State<UISlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust duration as needed
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Start from left
      end: Offset.zero, // Slide to right
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust curve as needed
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
