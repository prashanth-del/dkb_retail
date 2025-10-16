import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final ValueChanged<int> indexSelected;
  final int currentIndex;
  final bool isImage;
  final List<String> filterList;

  const TabWidget({
    super.key,
    required this.indexSelected,
    required this.currentIndex,
    required this.isImage,
    required this.filterList,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: Colors.white,
        ),
        height: 36,
        child: Row(
          children: List.generate(filterList.length, (index) {
            return Expanded(
              child: TabItemWidget(
                onTap: !isImage ? () => indexSelected(index) : null,
                title: filterList[index],
                selected: currentIndex == index,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TabItemWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const TabItemWidget({
    super.key,
    required this.title,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: selected ? DefaultColors.blueLightBase : DefaultColors.white,
        ),
        child: Center(
          child: UiTextNew.custom(
            title,
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? DefaultColors.white : DefaultColors.black,
          ),
        ),
      ),
    );

    // Wrap with GestureDetector only if onTap is provided
    if (onTap != null) {
      content = GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}
