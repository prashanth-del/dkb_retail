
import 'package:flutter/cupertino.dart';

import '../../db_uicomponents.dart';

class UiAnalyticsSwiper<T> extends StatefulWidget {
  final List<T> elements;
  final Widget Function(BuildContext, int) itemBuilder;
  final double? height;

  const UiAnalyticsSwiper({
    Key? key,
    required this.elements,
    required this.itemBuilder,
    this.height,
  });


  @override
  State<UiAnalyticsSwiper<T>> createState() => _CustomCarouselState<T>();
}

class _CustomCarouselState<T> extends State<UiAnalyticsSwiper<T>> {
  late PageController _pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      // Update active index only when page is fully settled
      final page = _pageController.page;
      if (page != null) {
        final newIndex = page.round();
        if (_activeIndex != newIndex) {
          setState(() {
            _activeIndex = newIndex;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPagination() {
    Color activeColor = DefaultColors.blue_600;
    Color inActiveColor = DefaultColors.white_0;
    double inActiveSize = 7;
    double activeSize = 14;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.elements.length, (index) {
        bool isActive = index == _activeIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            height: inActiveSize,
            width: isActive ? activeSize : inActiveSize,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inActiveColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double carouselHeight = widget.height ?? constraints.maxHeight;

        return Column(
          children: [
            SizedBox(
              height: 148,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.elements.length,
                itemBuilder: (context, index) {
                  return widget.itemBuilder(context, index);
                },
              ),
            ),
            _buildPagination(),
          ],
        );
      },
    );
  }
}