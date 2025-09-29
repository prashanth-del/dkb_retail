import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

enum ShimmerFilled { filled, outline }

class UIShimmerWidget extends StatelessWidget {
  final Widget? child;
  final BoxShape shape;
  final double? width;
  final double? height;
  final ShimmerFilled? shimmerFilled;
  final double? cornerEdge;

  const UIShimmerWidget.rectangle({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.cornerEdge = 0,
  })  : shimmerFilled = ShimmerFilled.filled,
        child = null,
        shape = BoxShape.rectangle;

  const UIShimmerWidget.outlineBox({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.cornerEdge = 0,
  })  : shimmerFilled = ShimmerFilled.outline,
        child = null,
        shape = BoxShape.rectangle;

  const UIShimmerWidget.outlineBoxContainer({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.cornerEdge = 0,
  })  : shimmerFilled = ShimmerFilled.outline,
        child = null,
        shape = BoxShape.rectangle;

  const UIShimmerWidget.outlineBoxChildContainer({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.cornerEdge = 0,
  })  : shimmerFilled = ShimmerFilled.outline,
        shape = BoxShape.rectangle;

  const UIShimmerWidget.circle({
    super.key,
    this.height = 50,
    this.width = 50,
  })  : cornerEdge = null,
        shape = BoxShape.circle,
        shimmerFilled = ShimmerFilled.filled,
        child = null;

  const UIShimmerWidget.textBox({
    super.key,
    this.height = 10,
    this.width = 50,
  })  : cornerEdge = 8,
        shimmerFilled = ShimmerFilled.filled,
        child = null,
        shape = BoxShape.rectangle;

  @override
  Widget build(BuildContext context) {
    return UIShimmer(
      baseColor: DefaultColors.grey.withOpacity(0.4),
      highlightColor: DefaultColors.grey.withOpacity(0.1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          color: DefaultColors.black.withOpacity(0.4),
          border: shimmerFilled == ShimmerFilled.filled ? null : Border.all(),
          borderRadius:
              cornerEdge != null ? BorderRadius.circular(cornerEdge!) : null,
        ),
      ),
    );
  }
}
