import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/around_custom_painter.dart';
import 'src/circular_notch_and_corner_clipper.dart';
import 'src/circular_notched_and_cornered_shape.dart';
import 'src/gap_item.dart';
import 'src/gap_location_exceptions.dart';
import 'src/navigation_bar_item.dart';
import 'src/safe_area_values.dart';
import 'src/visible_animator.dart';

export 'src/safe_area_values.dart';

typedef IndexedWidgetBuilder = Widget Function(int index, bool isActive);

class UIBottomNavigationBar extends StatefulWidget {
  final IndexedWidgetBuilder? tabBuilder;
  final int? itemCount;
  final List<IconData>? icons;
  final Function(int) onTap;
  final int activeIndex;
  final double? iconSize;
  final double? height;
  final double? notchMargin;
  final double splashRadius;
  final int? splashSpeedInMilliseconds;
  final double? leftCornerRadius;

  /// Optional custom tab bar top-right corner radius. Useless with [GapLocation.end]. Default is 0.
  final double? rightCornerRadius;

  /// Optional custom tab bar background color. Default is [Colors.white].
  final Color? backgroundColor;

  /// Optional custom splash selection animation color. Default is [Colors.purple].
  final Color? splashColor;

  /// Optional custom currently selected tab bar [IconData] color. Default is [Colors.deepPurpleAccent]
  final Color? activeColor;

  /// Optional custom currently unselected tab bar [IconData] color. Default is [Colors.black]
  final Color? inactiveColor;

  /// Optional bubble highlight color behind active tab when [enableBubbleAnimation] = true.
  final Color? bubbleColor;

  /// Bounce scale factor when tab is active. Default is 0.2.
  final double bounceScale;

  /// Optional custom [Animation] to animate corners and notch appearing.
  final Animation<double>? notchAndCornersAnimation;

  /// Optional custom type of notch. Default is [NotchSmoothness.defaultEdge].
  final NotchSmoothness? notchSmoothness;

  /// Location of the free space between tab bar items for notch.
  /// Must have the same location if [FloatingActionButtonLocation.centerDocked] or [FloatingActionButtonLocation.endDocked].
  /// Default is [GapLocation.end].
  final GapLocation? gapLocation;

  /// Free space width between tab bar items. The preferred width is equal to total width of [FloatingActionButton] and double [notchMargin].
  /// Default is 72.
  final double? gapWidth;

  /// Optional custom tab bar elevation. Default is 8.
  final double? elevation;

  /// Legacy: single shadow painter (old API).
  final Shadow? shadow;

  /// Multiple BoxShadows (modern API).
  final List<BoxShadow>? boxShadows;

  final SafeAreaValues safeAreaValues;
  final Curve? hideAnimationCurve;
  final Color? borderColor;
  final double? borderWidth;
  final AnimationController? hideAnimationController;
  final Gradient? backgroundGradient;
  final bool blurEffect;
  final ImageFilter? blurFilter;
  final double scaleFactor;

  /// Enables bubble highlight animation on tab selection.
  final bool enableBubbleAnimation;

  static const _defaultSplashRadius = 24.0;
  static const _defaultBounceScale = 0.2;

  UIBottomNavigationBar._internal({
    Key? key,
    required this.activeIndex,
    required this.onTap,
    this.tabBuilder,
    this.itemCount,
    this.icons,
    this.height,
    this.splashRadius = _defaultSplashRadius,
    this.splashSpeedInMilliseconds,
    this.notchMargin,
    this.backgroundColor,
    this.splashColor,
    this.activeColor,
    this.inactiveColor,
    this.bubbleColor,
    this.bounceScale = _defaultBounceScale,
    this.notchAndCornersAnimation,
    this.leftCornerRadius,
    this.rightCornerRadius,
    this.iconSize,
    this.notchSmoothness,
    this.gapLocation,
    this.gapWidth,
    this.elevation,
    this.shadow,
    this.boxShadows,
    this.borderColor,
    this.borderWidth,
    this.safeAreaValues = const SafeAreaValues(),
    this.hideAnimationCurve,
    this.hideAnimationController,
    this.backgroundGradient,
    this.blurEffect = false,
    this.blurFilter,
    this.scaleFactor = 1.0,
    this.enableBubbleAnimation = false,
  })  : assert(icons != null || itemCount != null),
        assert(
          ((itemCount ?? icons!.length) >= 2) &&
              ((itemCount ?? icons!.length) <= 5),
        ),
        super(key: key) {
    if (gapLocation == GapLocation.end) {
      if (rightCornerRadius != 0) {
        throw NonAppropriatePathException(
            'RightCornerRadius along with ${GapLocation.end} or/and ${FloatingActionButtonLocation.endDocked} causes render issue => '
            'consider set rightCornerRadius to 0.');
      }
    }
    if (gapLocation == GapLocation.center) {
      final iconsCountIsOdd = (itemCount ?? icons!.length).isOdd;
      if (iconsCountIsOdd) {
        throw NonAppropriatePathException(
            'Odd count of icons along with $gapLocation causes render issue => '
            'consider set gapLocation to ${GapLocation.end}');
      }
    }
  }

  UIBottomNavigationBar({
    Key? key,
    required List<IconData> icons,
    required int activeIndex,
    required Function(int) onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? bubbleColor,
    double bounceScale = _defaultBounceScale,
    Animation<double>? notchAndCornersAnimation,
    double? leftCornerRadius,
    double? rightCornerRadius,
    double? iconSize,
    NotchSmoothness? notchSmoothness,
    GapLocation? gapLocation,
    double? gapWidth,
    double? elevation,
    Shadow? shadow,
    List<BoxShadow>? boxShadows,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
    ImageFilter? imageFilter,
    bool blurEffect = false,
    double scaleFactor = 1.0,
    bool enableBubbleAnimation = false,
  }) : this._internal(
          key: key,
          icons: icons,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          splashRadius: splashRadius ?? _defaultSplashRadius,
          splashSpeedInMilliseconds: splashSpeedInMilliseconds,
          notchMargin: notchMargin,
          backgroundColor: backgroundColor,
          splashColor: splashColor,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          bubbleColor: bubbleColor,
          bounceScale: bounceScale,
          notchAndCornersAnimation: notchAndCornersAnimation,
          leftCornerRadius: leftCornerRadius ?? 0,
          rightCornerRadius: rightCornerRadius ?? 0,
          iconSize: iconSize,
          notchSmoothness: notchSmoothness,
          gapLocation: gapLocation ?? GapLocation.end,
          gapWidth: gapWidth,
          elevation: elevation,
          shadow: shadow,
          boxShadows: boxShadows,
          borderColor: borderColor,
          borderWidth: borderWidth,
          safeAreaValues: safeAreaValues,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
          backgroundGradient: backgroundGradient,
          blurFilter: imageFilter,
          blurEffect: blurEffect,
          scaleFactor: scaleFactor,
          enableBubbleAnimation: enableBubbleAnimation,
        );

  UIBottomNavigationBar.builder({
    Key? key,
    required int itemCount,
    required IndexedWidgetBuilder tabBuilder,
    required int activeIndex,
    required Function(int) onTap,
    double? height,
    double? splashRadius,
    int? splashSpeedInMilliseconds,
    double? notchMargin,
    Color? backgroundColor,
    Color? splashColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? bubbleColor,
    double bounceScale = _defaultBounceScale,
    Animation<double>? notchAndCornersAnimation,
    double? leftCornerRadius,
    double? rightCornerRadius,
    NotchSmoothness? notchSmoothness,
    GapLocation? gapLocation,
    double? gapWidth,
    double? elevation,
    Shadow? shadow,
    List<BoxShadow>? boxShadows,
    Color? borderColor,
    double? borderWidth,
    SafeAreaValues safeAreaValues = const SafeAreaValues(),
    Curve? hideAnimationCurve,
    AnimationController? hideAnimationController,
    Gradient? backgroundGradient,
    bool blurEffect = false,
    ImageFilter? imageFilter,
    double scaleFactor = 1.0,
    bool enableBubbleAnimation = false,
  }) : this._internal(
          key: key,
          tabBuilder: tabBuilder,
          itemCount: itemCount,
          activeIndex: activeIndex,
          onTap: onTap,
          height: height,
          splashRadius: splashRadius ?? _defaultSplashRadius,
          splashSpeedInMilliseconds: splashSpeedInMilliseconds,
          notchMargin: notchMargin,
          backgroundColor: backgroundColor,
          splashColor: splashColor,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          bubbleColor: bubbleColor,
          bounceScale: bounceScale,
          notchAndCornersAnimation: notchAndCornersAnimation,
          leftCornerRadius: leftCornerRadius ?? 0,
          rightCornerRadius: rightCornerRadius ?? 0,
          notchSmoothness: notchSmoothness,
          gapLocation: gapLocation ?? GapLocation.end,
          gapWidth: gapWidth,
          elevation: elevation,
          shadow: shadow,
          boxShadows: boxShadows,
          borderColor: borderColor,
          borderWidth: borderWidth,
          safeAreaValues: safeAreaValues,
          hideAnimationCurve: hideAnimationCurve,
          hideAnimationController: hideAnimationController,
          backgroundGradient: backgroundGradient,
          blurEffect: blurEffect,
          blurFilter: imageFilter,
          scaleFactor: scaleFactor,
          enableBubbleAnimation: enableBubbleAnimation,
        );

  @override
  _UIBottomNavigationBarState createState() => _UIBottomNavigationBarState();
}

class _UIBottomNavigationBarState extends State<UIBottomNavigationBar>
    with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  late final AnimationController _bubbleController;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _splashAnimation;

  double _bubbleRadius = 0;
  double _iconScale = 1;
  double _bubbleLeft = 0;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.activeIndex; // Initialize to current active index

    _bubbleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.splashSpeedInMilliseconds ?? 300),
    );

    _splashAnimation = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.linear,
    )..addListener(() {
        setState(() {
          _bubbleRadius = widget.splashRadius * _splashAnimation.value;
          if (_bubbleRadius == widget.splashRadius) {
            _bubbleRadius = 0;
          }
          if (_splashAnimation.value < 0.5) {
            _iconScale = 1 + _splashAnimation.value * widget.scaleFactor;
          } else {
            _iconScale =
                1 + widget.scaleFactor - _splashAnimation.value * widget.scaleFactor;
          }
        });
      });

    _bubbleAnimation = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeInOut,
    )..addListener(() {
        setState(() {
          final screenWidth = MediaQuery.of(context).size.width;
          final itemCount = widget.itemCount ?? widget.icons!.length;
          final effectiveWidth = screenWidth - (widget.gapWidth ?? 0);
          final tabWidth = effectiveWidth / itemCount;
          final previousLeft = _previousIndex * tabWidth;
          final targetLeft = widget.activeIndex * tabWidth;
          _bubbleLeft = lerpDouble(previousLeft, targetLeft, _bubbleAnimation.value)!;
        });
      });

    _bubbleController.value = 1.0; // Start at end state for initial position
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
    widget.notchAndCornersAnimation?.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(UIBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeIndex != oldWidget.activeIndex) {
      _previousIndex = oldWidget.activeIndex;
      if (widget.enableBubbleAnimation) {
        if (_bubbleController.isAnimating) {
          _bubbleController.reset();
        }
        _bubbleController.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = CircularNotchedAndCorneredRectangleClipper(
      shape: CircularNotchedAndCorneredRectangle(
        animation: widget.notchAndCornersAnimation,
        notchSmoothness: widget.notchSmoothness ?? NotchSmoothness.defaultEdge,
        gapLocation: widget.gapLocation ?? GapLocation.end,
        leftCornerRadius: widget.leftCornerRadius ?? 0.0,
        rightCornerRadius: widget.rightCornerRadius ?? 0.0,
      ),
      geometry: geometryListenable,
      notchMargin: widget.notchMargin ?? 8,
    );

    return PhysicalShape(
      elevation: widget.elevation ?? 8,
      color: Colors.transparent,
      clipper: clipper,
      child: AroundCustomPainter(
        clipper: clipper,
        shadow: widget.shadow,
        borderColor: widget.borderColor ?? Colors.transparent,
        borderWidth: widget.borderWidth ?? 2,
        child: widget.hideAnimationController != null
            ? VisibleAnimator(
                showController: widget.hideAnimationController!,
                curve: widget.hideAnimationCurve ?? Curves.fastOutSlowIn,
                child: _buildBottomBar(context),
              )
            : _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: widget.backgroundColor ?? Colors.white,
      child: SafeArea(
        top: widget.safeAreaValues.top,
        bottom: widget.safeAreaValues.bottom,
        left: widget.safeAreaValues.left,
        right: widget.safeAreaValues.right,
        child: widget.blurEffect
            ? ClipRect(
                child: BackdropFilter(
                  filter: widget.blurFilter ??
                      ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                  child: _buildBody(context),
                ),
              )
            : _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bottomPadding =
        widget.safeAreaValues.bottom ? 0 : MediaQuery.paddingOf(context).bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemCount = widget.itemCount ?? widget.icons!.length;
    final effectiveWidth = screenWidth - (widget.gapWidth ?? 0);
    final tabWidth = effectiveWidth / itemCount;

    // Adjust for padding in HomePage's tabBuilder
    final paddingAdjustments = List.generate(itemCount, (index) {
      if (index == 0) return 4.0; // left: 4
      if (index == itemCount - 1) return 6.0; // right: 6
      return 0.0;
    });
    final adjustedTabWidth = effectiveWidth / itemCount;

    return Container(
      height: (widget.height ?? kBottomNavigationBarHeight) + bottomPadding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows ??
            (widget.shadow != null
                ? [
                    BoxShadow(
                      color: widget.shadow!.color,
                      blurRadius: widget.shadow!.blurRadius,
                      offset: widget.shadow!.offset,
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: widget.elevation ?? 8,
                    )
                  ]),
      ),
      child: Stack(
        children: [
          // Sliding bubble highlight background
          if (widget.enableBubbleAnimation)
            Positioned(
              left: _bubbleLeft + (widget.activeIndex == 0 ? 4 : 0), // Adjust for left padding
              bottom: 0,
              width: adjustedTabWidth - (widget.activeIndex == 0 ? 4 : 0) - (widget.activeIndex == itemCount - 1 ? 6 : 0),
              height: widget.height,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.bubbleColor ?? const Color(0x33007BFF),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: _buildItems(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    final gapWidth = widget.gapWidth ?? 72;
    final gapItemWidth = widget.notchAndCornersAnimation != null
        ? gapWidth * widget.notchAndCornersAnimation!.value
        : gapWidth;
    final itemCount = widget.itemCount ?? widget.icons!.length;

    final items = <Widget>[];
    for (var i = 0; i < itemCount; i++) {
      final isActive = i == widget.activeIndex;

      if (widget.gapLocation == GapLocation.center && i == itemCount / 2) {
        items.add(GapItem(width: gapItemWidth));
      }

      items.add(
        NavigationBarItem(
          isActive: isActive,
          bubbleRadius: _bubbleRadius,
          maxBubbleRadius: widget.splashRadius,
          bubbleColor: widget.splashColor,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          child: widget.tabBuilder?.call(i, isActive),
          iconData: widget.icons?.elementAt(i),
          iconScale: _iconScale,
          iconSize: widget.iconSize,
          onTap: () => widget.onTap(i),
        ),
      );

      if (widget.gapLocation == GapLocation.end && i == itemCount - 1) {
        items.add(GapItem(width: gapItemWidth));
      }
    }
    return items;
  }
}

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}

enum GapLocation { none, center, end }
