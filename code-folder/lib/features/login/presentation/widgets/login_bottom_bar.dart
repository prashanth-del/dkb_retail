import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/dialog/custom_sheet.dart';
import '../../../reach_us/presentation/widgets/more_sheet_widget.dart';
import 'rates_bottom_sheet.dart';

class LoginBottomBar extends StatefulWidget {
  const LoginBottomBar({super.key});

  @override
  _LoginBottomBarState createState() => _LoginBottomBarState();
}

class _LoginBottomBarState extends State<LoginBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAnimatedTab(
            index: 0,
            svgIconPath: AssetPath.svg.emergencyBlockIcon,
            title: "Emergency Block",
            onTap: () => setState(() => _selectedIndex = 0),
          ),
          _buildAnimatedTab(
            index: 1,
            svgIconPath: AssetPath.svg.ratesIcon,
            title: "Rates",
            onTap: () {
              setState(() => _selectedIndex = 1);
              CustomSheet.show(
                context: context,
                isDismissible: true,
                child: ratesBottomSheet(context),
              );
            },
          ),
          _buildAnimatedTab(
            index: 2,
            svgIconPath: AssetPath.svg.productsIcon,
            title: "Products",
            badgeCount: 5,
            onTap: () {
              setState(() => _selectedIndex = 2);
              context.router.push(const ProductOfferingRoute());
            },
            heroTag: 'productTitleHero',
          ),
          _buildAnimatedTab(
            index: 3,
            svgIconPath: AssetPath.svg.moreIcon,
            title: "More",
            onTap: () {
              setState(() => _selectedIndex = 3);
              CustomSheet.show(context: context,isDismissible: true, child: MoreSheetWidget());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTab({
    required int index,
    required String svgIconPath,
    required String title,
    int? badgeCount,
    VoidCallback? onTap,
    String? heroTag,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        _controller.reset();
        _controller.forward();
        onTap?.call();
        if (mounted) {
          setState(() {
            _selectedIndex = -1;
          });
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final icon = SvgPicture.asset(svgIconPath, height: 26);

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.width * 0.2,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    if (badgeCount != null && isSelected)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          badgeCount.toString(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: isSelected ? 13 : 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: Colors.white,
                  ),
                  child:
                      index ==
                          2 // Products tab
                      ? Hero(
                          tag: '$heroTag',
                          flightShuttleBuilder:
                              (
                                flightContext,
                                animation,
                                direction,
                                fromContext,
                                toContext,
                              ) {
                                return AnimatedBuilder(
                                  animation: animation,
                                  builder: (context, child) {
                                    final t = Curves.easeInOutCubic.transform(
                                      animation.value,
                                    ); // smooth curve
                                    final size =
                                        12 + (18 - 12) * t; // animate 12 → 18
                                    return Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: size,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Text(title, textAlign: TextAlign.center),
                ),
                if (isSelected)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(top: 6),
                    height: 3,
                    width: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.yellow, Colors.tealAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget loginBottomBar(BuildContext context) {
  return const LoginBottomBar();
}
