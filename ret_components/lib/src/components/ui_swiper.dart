import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../db_uicomponents.dart';

enum _SwiperType { swiper1, swiper2, swiper3 }

class UiSwiper<T> extends StatefulWidget {
  final List<T> elements;
  final Widget Function(BuildContext, int)? itemBuilder;
  final double? height;
  
  @Deprecated("Don't use analytics instead use UiAnalyticsSwiper")
  const UiSwiper.swiper3(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      this.height})
      : _swiperType = _SwiperType.swiper3;

  const UiSwiper.swiper1(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      this.height})
      : _swiperType = _SwiperType.swiper1;

  const UiSwiper.swiper2(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      this.height})
      : _swiperType = _SwiperType.swiper2;

  final _SwiperType _swiperType;

  @override
  State<UiSwiper<T>> createState() => _UiSwiperState<T>();
}

class _UiSwiperState<T> extends State<UiSwiper<T>> {
  int activeIndex = 0;

  SwiperPlugin updatePagination() {
    Alignment alignment = Alignment.bottomCenter;
    Color activeColor = DefaultColors.blue9D;
    Color inActiveColor = DefaultColors.grayE4;
    double inActiveSize = 6;
    double activeSize = 6;
    switch (widget._swiperType) {
      case _SwiperType.swiper3:
        alignment = Alignment.bottomCenter;
        activeColor = DefaultColors.primaryBlue;
        inActiveColor = DefaultColors.primaryBlue.withOpacity(0.2);
        inActiveSize = 7;
        activeSize = 14;
        return SwiperPagination(
          alignment: alignment,
          builder: SwiperCustomPagination(builder: (context, config) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.elements
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(
                              height: inActiveSize,
                              width:
                                  widget.elements.indexOf(item) == activeIndex
                                      ? activeSize
                                      : inActiveSize),
                          child: Container(
                            height: inActiveSize,
                            width: widget.elements.indexOf(item) == activeIndex
                                ? activeSize
                                : inActiveSize,
                            decoration: BoxDecoration(
                                color:
                                    widget.elements.indexOf(item) == activeIndex
                                        ? activeColor
                                        : inActiveColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
        );
      case _SwiperType.swiper1:
        alignment = Alignment.bottomLeft;
        activeColor = DefaultColors.blue9B;
        inActiveColor = DefaultColors.white;
        inActiveSize = 6;
        activeSize = 16;
        return SwiperPagination(
          alignment: alignment,
          builder: SwiperCustomPagination(builder: (context, config) {
            return Row(
              children: widget.elements
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(
                              height: inActiveSize,
                              width:
                                  widget.elements.indexOf(item) == activeIndex
                                      ? activeSize
                                      : inActiveSize),
                          child: Container(
                            height: inActiveSize,
                            width: widget.elements.indexOf(item) == activeIndex
                                ? activeSize
                                : inActiveSize,
                            decoration: BoxDecoration(
                                color:
                                    widget.elements.indexOf(item) == activeIndex
                                        ? activeColor
                                        : inActiveColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
        );
      case _SwiperType.swiper2:
        alignment = Alignment.topLeft;
        activeColor = DefaultColors.white;
        inActiveColor = DefaultColors.white.withOpacity(0.5);
        inActiveSize = 6;
        return SwiperPagination(
          alignment: alignment,
          builder: SwiperCustomPagination(builder: (context, config) {
            return Row(
              children: widget.elements
                  .map((item) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            height: inActiveSize,
                            decoration: BoxDecoration(
                                color:
                                    widget.elements.indexOf(item) == activeIndex
                                        ? activeColor
                                        : inActiveColor,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? context.screenHeight / 5.3,
      width: context.screenWidth,
      child: Swiper(
        viewportFraction: 1,
        indicatorLayout: PageIndicatorLayout.WARM,
        layout: SwiperLayout.DEFAULT,
        autoplay: false,
        loop: false,
        itemCount: widget.elements.length,
        onIndexChanged: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        control: const SwiperControl(
            color: Colors.transparent, disableColor: Colors.transparent),
        pagination: updatePagination(),
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}



