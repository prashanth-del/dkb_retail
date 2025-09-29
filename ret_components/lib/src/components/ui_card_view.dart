import 'package:flutter/material.dart';

class UICardView extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? elevation;
  final double? cardCornerRadius;
  final Color? borderColor;

  const UICardView({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.elevation,
    this.cardCornerRadius,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: elevation ?? 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? Colors.blue
            ),
            borderRadius: BorderRadius.circular(cardCornerRadius ?? 10),
          ),
          child: Container(
            width: width ?? constraints.maxWidth * 0.8,
            height: height ?? constraints.maxHeight * 0.5,
            padding: const EdgeInsets.all(10),
            child: child,
          ),
        );
      },
    );
  }
}