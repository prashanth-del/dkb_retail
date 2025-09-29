import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UiTabBar3 extends StatefulWidget {
  final List<String> tabs; // List of tab labels
  final List<Widget> childrens;
  final Color? theme;// List of corresponding tab contents

  const UiTabBar3({Key? key, required this.tabs, required this.childrens, this.theme})
      : assert(tabs.length == childrens.length,
            'The length of tabs and childrens must be equal',),
        super(key: key);

  @override
  _UiTabBar3State createState() => _UiTabBar3State();
}

class _UiTabBar3State extends State<UiTabBar3> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(widget.tabs.length, (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? widget.theme ?? Theme.of(context).primaryColor : DefaultColors.white,
                    borderRadius: _getBorderRadius(index),
                    border: Border.all(
                      color:
                          isSelected ? widget.theme ?? Theme.of(context).primaryColor : DefaultColors.grayE6,
                      width: 0.5,
                    ),
                  ),
                  child: UiTextNew.h5Regular(
                    widget.tabs[index],
                    // size: 12,
                    color:
                        isSelected ? DefaultColors.white : DefaultColors.gray54,
                  ),
                ),
              ),
            );
          }),
        ),
        if (widget.childrens.isNotEmpty) widget.childrens[selectedIndex]
      ],
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      ).toDirectional(context);
    } else if (index == widget.tabs.length - 1) {
      return BorderRadius.only(
        topRight: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ).toDirectional(context);
    }
    return BorderRadius.zero;
  }
}
