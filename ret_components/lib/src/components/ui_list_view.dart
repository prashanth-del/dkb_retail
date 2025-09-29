import 'package:db_uicomponents/components.dart';

import 'ui_no_content.dart';
import 'package:flutter/material.dart';
import '../styles/theme/colorscheme/colors/default_colors.dart';

class UIListView<T> extends StatefulWidget {
  final List<T> elements;
  final ScrollPhysics? scrollPhysics;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Future<void> Function()? onRefresh;
  final bool loading;
  final bool separatorReq;
  final EdgeInsets? padding;
  final EdgeInsets? separatorPadding;
  final Color? separatorColor;
  final ScrollController? controller;
  final bool showScrollBar;
  final String? noContentTitle;
  final Axis? direction;
  final String? noContentBody;
  final Widget? noContentElement;

  const UIListView({
    super.key,
    required this.elements,
    required this.itemBuilder,
    this.onRefresh,
    this.controller,
    this.noContentElement,
    this.scrollPhysics,
    this.separatorColor,
    this.separatorPadding,
    this.showScrollBar = false,
    this.direction,
    this.loading = false,
    this.separatorReq = false,
    this.padding,
    this.noContentTitle,
    this.noContentBody,
  });

  @override
  State<UIListView<T>> createState() => _UIListViewState<T>();
}

class _UIListViewState<T> extends State<UIListView<T>> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget seperatedList = ListView.separated(
      itemBuilder: widget.itemBuilder,
      itemCount: widget.elements.length,
      shrinkWrap: true,
      controller: widget.showScrollBar
          ? (widget.controller ?? _scrollController)
          : widget.controller,
      scrollDirection: widget.direction ?? Axis.vertical,
      separatorBuilder: (BuildContext context, int index) {
        return widget.separatorReq
            ? Padding(
                padding: widget.separatorPadding ?? const EdgeInsets.all(0.0),
                child: Divider(
                  color: widget.separatorColor ?? DefaultColors.gray96,
                  height: 0,
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              );
      },
      physics: widget.scrollPhysics ?? const NeverScrollableScrollPhysics(),
      padding: widget.padding ?? const EdgeInsets.all(0),
    );

    Widget listView = UiScrollBar(
      controller: widget.controller ?? _scrollController,
      child: seperatedList,
    );
    return widget.loading
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(DefaultColors.blue9D),
              strokeWidth: 2,
            ),
          )
        : widget.elements.isEmpty
            ? widget.noContentElement ??
                Center(
                  child: UINoContent(
                    title: widget.noContentTitle,
                    description: widget.noContentBody,
                  ),
                )
            : widget.onRefresh == null
                ? (widget.showScrollBar ? listView : seperatedList)
                : RefreshIndicator(
                    onRefresh: widget.onRefresh!,
                    child: (widget.showScrollBar ? listView : seperatedList));
  }
}
