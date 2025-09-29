import 'package:db_uicomponents/db_uicomponents.dart';

import '../styles/theme/colorscheme/colors/default_colors.dart';
import 'ui_no_content.dart';
import 'package:flutter/material.dart';

class UIGridList<T> extends StatelessWidget {
  final List<T> elements;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<void> Function()? onRefresh;
  final bool loading;
  final int crossCount;
  final EdgeInsets? padding;
  final String? noContentTitle;
  final String? noContentBody;
  final double? mainAxisExtent;
  const UIGridList(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      required this.crossCount,
      this.onRefresh,
      this.loading = false,
      this.noContentBody,
      this.noContentTitle,
        this.mainAxisExtent,
      this.padding});

  @override
  Widget build(BuildContext context) {
    Widget gridView = GridView.builder(
      itemBuilder: itemBuilder,
      itemCount: elements.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: mainAxisExtent ?? context.screenHeight / 3.8,
        // childAspectRatio: 0.7,
        mainAxisSpacing: 0,
        crossAxisCount: crossCount,
        crossAxisSpacing: 0,
      ),
      padding: padding ?? EdgeInsets.zero,
    );
    return loading
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(DefaultColors.blue9D),
              strokeWidth: 2,
            ),
          )
        : elements.isEmpty
            ? Center(
                child: UINoContent(
                  title: noContentTitle ?? "No Content",
                  description:
                      noContentBody ?? "Not able to find any related data",
                ),
              )
            : onRefresh == null
                ? gridView
                : RefreshIndicator(onRefresh: onRefresh!, child: gridView);
  }
}
