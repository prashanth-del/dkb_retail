import 'package:db_uicomponents/src/template/ui_account_card.dart';
import 'package:db_uicomponents/src/utils/extensions/context_extension.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';
import 'ui_tab.dart';

class UITabBar extends StatelessWidget {
  final List<String> tabs;
  final List<String>? activeIcons;
  final List<String>? inActiveIcons;
  final TabController tabController;
  final bool isScrollable;
  final ScrollPhysics? physics;
  final Color? dividerColor;
  final Color? inActiveDividerColor;
  final Color? activeTabColor;
  final double? activeTabRadius;
  final Color? activeTabTextColor;
  final Color? inActiveTabTextColor;
  final void Function(int)? onTap;
  final int selectedTabIndex;

  const UITabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    this.isScrollable = true,
    this.physics,
    this.activeIcons,
    this.inActiveIcons,
    this.dividerColor,
    this.inActiveDividerColor,
    this.activeTabColor,
    this.activeTabRadius,
    this.activeTabTextColor,
    this.inActiveTabTextColor,
    this.onTap,
    this.selectedTabIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    tabController.animateTo(selectedTabIndex, duration: const Duration(milliseconds: 150));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: context.screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: tabs.asMap().entries.map((entry) {
              int index = entry.key;
              String tab = entry.value;
              bool isSelected = index == selectedTabIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (onTap != null) onTap!(index);
                    tabController.animateTo(index, duration: const Duration(milliseconds: 150));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UITab(
                        tabName: tab,
                        active: isSelected,
                        activeTabColor: activeTabColor,
                        activeTabRadius: activeTabRadius,
                        activeTabTextColor: activeTabTextColor,
                        inActiveTabTextColor: inActiveTabTextColor,
                        assetIcon:
                            !(activeIcons == null && inActiveIcons == null)
                                ? isSelected
                                    ? activeIcons![index]
                                    : inActiveIcons![index]
                                : null,
                      ),
                      if(dividerColor != null)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.linear,
                          height: 4,
                          width: (context.screenWidth / tabs.length) - 20,
                          decoration: BoxDecoration(
                            color: isSelected ? (dividerColor ?? Colors.transparent) : (inActiveDividerColor ?? Colors.transparent),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
