import 'package:flutter/material.dart';

class UISliderScreen2 extends StatefulWidget {
  final int slideCount;
  final List<Widget Function(int index)> slideBuilders;
  final BorderRadius borderRadius;
  final bool autoPlay;
  final double aspectRatio;
  final double viewportFraction;
  final double containerWidth;
  final double containerHeight;

  const UISliderScreen2({
    super.key,
    required this.slideCount,
    required this.slideBuilders,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.autoPlay = true,
    this.aspectRatio = 2,
    this.viewportFraction = 1,
    this.containerWidth = 390,
    this.containerHeight = 172,
  })  : assert(slideBuilders.length == slideCount);

  @override
  State<UISliderScreen2> createState() => _UISliderScreenState();
}

class _UISliderScreenState extends State<UISliderScreen2> {
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
        border: Border.all(width: 1, color: Colors.white),
        color: const Color(0xFF00529B),
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
            left: 15,
            right: 15,
            bottom: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(widget.slideCount, (index) {
                return GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      width: _currentPage % widget.slideCount == index
                          ? 23.13
                          : 7.19,
                      height: 7.19,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.79),
                        color: _currentPage % widget.slideCount == index
                            ? const Color(0xFFF3AB40)
                            : Colors.white,
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
