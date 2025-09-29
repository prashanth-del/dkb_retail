import 'package:flutter/material.dart';

class UISliderScreen extends StatefulWidget {
  final int slideCount;
  final List<Widget Function(int index)> slideBuilders;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final BorderRadius borderRadius;
  final bool autoPlay;
  final double aspectRatio;
  final double viewportFraction;
  final double containerWidth;
  final double containerHeight;

  const UISliderScreen({
    super.key,
    required this.slideCount,
    required this.slideBuilders,
    this.gradientStartColor = const Color(0xFF1F5397),
    this.gradientEndColor = const Color(0xFF064A8A),
    this.borderRadius = const BorderRadius.all(Radius.circular(12.44)),
    this.autoPlay = true,
    this.aspectRatio = 2,
    this.viewportFraction = 1,
    this.containerWidth = 398,
    this.containerHeight = 255.32,
  })  : assert(slideBuilders.length == slideCount);

  @override
  State<UISliderScreen> createState() => _UISliderScreenState();
}

class _UISliderScreenState extends State<UISliderScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        int nextPage = _currentPage + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoPlay();
      }
    });
  }

  Widget _buildSlide(int index) {
    return widget
        .slideBuilders[index % widget.slideCount](index % widget.slideCount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.gradientStartColor, widget.gradientEndColor],
        ),
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) => _buildSlide(index),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            top: 15,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(widget.slideCount, (index) {
                return GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      width: 111.94,
                      height: 4.97,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.95),
                        color: _currentPage % widget.slideCount == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
