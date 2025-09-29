import 'package:flutter/material.dart';

import '../../db_uicomponents.dart';

class UiTabBar2 extends StatefulWidget {
  final List<String> tabItemsLabel;
  final void Function(int) onSelected;
  final bool isScrollable;
  final int? selectedItem;
  final void Function(TabController)? onController;

  const UiTabBar2({
    required this.tabItemsLabel,
    required this.onSelected,
    this.onController,
    this.selectedItem,
    this.isScrollable = false,
    Key? key,
  }) : super(key: key);

  @override
  State<UiTabBar2> createState() => _UiTabBarState();
}

class _UiTabBarState extends State<UiTabBar2>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int? selectedTabIndex;

  @override
  void initState() {
    super.initState();
    // Initialize selectedTabIndex from widget.selectedItem or default to 0
    selectedTabIndex = widget.selectedItem ?? 0;

    // Initialize TabController
    tabController = TabController(
      length: widget.tabItemsLabel.length,
      vsync: this,
      initialIndex: selectedTabIndex!,
    );

    // Pass the TabController to parent if onController is provided
    if (widget.onController != null) {
      widget.onController!(tabController);
    }

    // Listen to TabController changes
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          selectedTabIndex = tabController.index;
        });
        widget.onSelected(tabController.index); // Notify the parent widget
      }
    });
  }

  @override
  void didUpdateWidget(covariant UiTabBar2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the widget.selectedItem changes, update the TabController's index
    if (widget.selectedItem != null && widget.selectedItem != selectedTabIndex) {
      setState(() {
        selectedTabIndex = widget.selectedItem;
        tabController.animateTo(selectedTabIndex!);
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Function to calculate text width using TextPainter for underline sizing
  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      scrollDirection: widget.isScrollable ? Axis.horizontal : Axis.vertical,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.tabItemsLabel.length, (index) {
          bool isSelected = selectedTabIndex == index;

          final textStyle = TextStyle(
            color: isSelected ? const Color(0xFF00529B) : const Color(0xFF9E9FA7),
            fontSize: 14,
          );

          // Calculate text width for the underline effect
          final textWidth = _calculateTextWidth(widget.tabItemsLabel[index], textStyle);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTabIndex = index;
              });
              tabController.animateTo(index); // Change the tab on tap
              widget.onSelected(index); // Notify parent widget of selection
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? DefaultColors.blue9B :DefaultColors.white_0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children :[
                  UiTextNew.custom(
                    widget.tabItemsLabel[index],
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ?   DefaultColors.white_0 : DefaultColors.blue9B,

                  ),
                  UiSpace.vertical(2)
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 250),
                  //   height: 2,
                  //   width: isSelected ? textWidth + 8 : 0, // Set width of underline to match text
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color(0xFF00529B),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
