import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class UiSplashAnim extends StatefulWidget {
  final String videoAsset;
  final String svgAsset;
  final Alignment? begin;
  final Alignment? end;
  final Function() navigateToScreen;

  const UiSplashAnim(
      {super.key,
      required this.videoAsset,
      required this.navigateToScreen,
      required this.svgAsset,
      this.begin,
      this.end});

  @override
  State<UiSplashAnim> createState() => _UiSplashAnimState();
}

class _UiSplashAnimState extends State<UiSplashAnim>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoController;
  late final AnimationController _animController;

  late Animation<double> splashVideoOpacityAnim;
  late Animation<double> logoOpacityAnim;
  late Animation<double> logoWidthAnim;
  late Animation<Alignment> logoAlignmentAnim;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(widget.videoAsset)
      ..initialize().then(
        (_) => _videoController.play(),
      );

    _animController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    splashVideoOpacityAnim = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0, 0.4),
      ),
    );

    logoOpacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 0.6),
      ),
    );

    logoWidthAnim = Tween<double>(begin: 195, end: 120).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
      ),
    );

    logoAlignmentAnim = Tween<Alignment>(
      begin: widget.begin ?? Alignment.center,
      end: widget.end ?? Alignment.topCenter,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.42, 1.0, curve: Curves.elasticOut),
      ),
    );

    _videoController.addListener(() {
      if (_videoController.value.isCompleted) {
        _animController.forward();
      }
    });

    _animController.addListener(() {
      setState(() {});

      if (_animController.isCompleted) {
        widget.navigateToScreen();
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: logoAlignmentAnim.value,
          child: Opacity(
            opacity: logoOpacityAnim.value,
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: SvgPicture.asset(
                widget.svgAsset,
                width: logoWidthAnim.value,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: splashVideoOpacityAnim.value,
          child: VideoPlayer(_videoController),
        )
      ],
    );
  }
}
