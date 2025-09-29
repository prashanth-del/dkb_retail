import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/ui_tile.dart';
import 'package:flutter/material.dart';

class UiCard extends StatelessWidget {
  final Widget? child;
  final Color? cardColor;
  final Color? shadowColor;
  final double? curve;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final Function()? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double maxWidth;
  final BoxConstraints boxConstraints;

  const UiCard({
    this.curve,
    this.child,
    this.cardColor,
    this.shadowColor,
    this.onTap,
    this.elevation = 0,
    this.borderColor,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    super.key,
    this.maxWidth = double.infinity,
    this.boxConstraints = const BoxConstraints.tightForFinite(),
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.localeDirection,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent, // Remove splash color
        highlightColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: boxConstraints,
          child: Card(
            margin: margin,
            elevation: elevation,
            color: cardColor ?? Colors.white,
            shadowColor: shadowColor ?? Colors.blueGrey.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(curve ?? 8.0),
              side: borderColor != null
                  ? BorderSide(color: borderColor!)
                  : const BorderSide(
                      color: DefaultColors.blue_light_03,
                    ),
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
