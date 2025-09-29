import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../../../core/services/session_manager/session_manager.dart';
import '../provider/module_data_provider.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  final bool shouldInit;
  const HomePage({super.key, this.shouldInit = false});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionStateStreamProvider).add(SessionState.startListening);
      final modules = ref.read(moduleDataProvider.notifier).state;
      modules[0].onSelected?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moduleData = ref.watch(moduleDataProvider);
    // bool isLoading = ref.watch(summaryLoadingProvider);
    return PopScope(
      canPop: false,
      child: AutoTabsScaffold(
        homeIndex: 0,
        inheritNavigatorObservers: true,
        backgroundColor: const Color(0xFFF8F9FD),
        lazyLoad: false,
        routes: moduleData.map((data) => data.route).toList(),
        bottomNavigationBuilder: (_, tabRouter) {
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity == null) return;

              int newIndex = tabRouter.activeIndex;
              if (details.primaryVelocity! > 0 && newIndex < moduleData.length - 1) {
                newIndex++;
              } else if (details.primaryVelocity! < 0 && newIndex > 0) {
                newIndex--;
              }

              if (newIndex != tabRouter.activeIndex) {
                if (newIndex != 0 && newIndex != 1) {
                  UiToast().showToast("Coming Soon");
                  return;
                }
                moduleData[newIndex].onSelected?.call();
                tabRouter.setActiveIndex(newIndex);
              }
            },
            child: UIBottomNavigationBar.builder(
              itemCount: moduleData.length,
              activeIndex: tabRouter.activeIndex,
              onTap: (index) {
                if (index != 0 && index != 1) {
                  UiToast().showToast("Coming Soon");
                  return;
                }
                if (index == tabRouter.activeIndex) return;
                moduleData[index].onSelected?.call();
                tabRouter.setActiveIndex(index);
              },
              tabBuilder: (i, isActive) {
                Color? tabColor = tabRouter.activeIndex == i
                    ? DefaultColors.primaryBlue
                    : const Color(0xFF9E9FA7);
                Color? iconColor = tabRouter.activeIndex == i
                    ? null
                    : const Color(0xFF9E9FA7);

                return Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 4 : 0,
                    right: i == moduleData.length - 1 ? 6 : 0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UiSpace(
                        56,
                        2,
                        color: tabRouter.activeIndex == i
                            ? DefaultColors.primaryBlue
                            : const Color(0xFFffffff),
                      ),
                      const UiSpace.vertical(8),
                      SvgPicture.asset(
                        moduleData[i].activeIcon,
                        color: iconColor,
                        width: getIconSize(i),
                        height: getIconSize(i),
                      ),
                      Gap(getGap(i)),
                      UiTextNew.custom(
                        moduleData[i].i18nKey,
                        fontSize: 11.5,
                        textAlign: TextAlign.center,
                        color: tabColor,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              height: context.mediaQuery.size.height * 0.08,
              elevation: 4,
              gapLocation: GapLocation.none,
              leftCornerRadius: 20,
              rightCornerRadius: 20,
              splashSpeedInMilliseconds: 300,
              backgroundColor: const Color(0xFFF8F9FD),
              activeColor: DefaultColors.primaryBlue,
              inactiveColor: const Color(0xFF9E9FA7),
              bubbleColor: const Color(0x33007BFF),
              bounceScale: 0.2,
              enableBubbleAnimation: true,
              boxShadows: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double getIconSize(int index) {
    switch (index) {
      case 2:
      case 4:
        return 17.5;
      default:
        return 17;
    }
  }

  double getGap(int index) {
    switch (index) {
      case 2:
      case 4:
        return 7;
      default:
        return 8;
    }
  }
}
