import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UIShimmer extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final Widget child;
  const UIShimmer({
    required this.child,
    this.baseColor,
    this.highlightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade400,
      highlightColor: highlightColor ?? Colors.grey.shade200,
      child: child,
    );
  }
}
