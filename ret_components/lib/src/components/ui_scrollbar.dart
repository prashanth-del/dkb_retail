import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../db_uicomponents.dart';

class UiScrollBar extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final Widget child;
  final ScrollController controller;

  const UiScrollBar(
      {super.key,
      required this.child,
      this.padding,
      required this.controller,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // always will be right aligned
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: RawScrollbar(
          thickness: 0,
          controller: controller,
          thumbColor: DefaultColors.transparent,
          thumbVisibility: true,
          radius: const Radius.circular(20),
          crossAxisMargin: 2,
          child: Padding(
            padding: contentPadding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
