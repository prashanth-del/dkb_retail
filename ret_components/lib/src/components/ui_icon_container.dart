import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../db_uicomponents.dart';

class UIIconContainer extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final double? size;
  final String? imgAsset;
  final String? imgNetwork;
  final Color? iconColor;
  final Color? color;
  final FocusNode? focusNode;
  final bool isNavigateBack;
  final Decoration? decoration;
  final Function()? onTap;
  const UIIconContainer(
      {super.key,
      this.imgAsset,
      this.imgNetwork,
      this.icon,
      this.iconSize,
      this.size,
      this.iconColor,
      this.color,
      this.focusNode,
      this.isNavigateBack = false,
      this.decoration,
      this.onTap});

  @override
  Widget build(BuildContext context) {

    Widget? buildImageOrIcon() {
      if (imgAsset != null) {
        return imgAsset!.endsWith('.svg')
            ? SvgPicture.asset(
                      imgAsset!,
              width: iconSize ?? 20,
              height: iconSize ?? 20,
                    )
            : Image.asset(
          imgAsset!,
          width: iconSize ?? 30,
          height: iconSize ?? 30,
        );
      } else if (imgNetwork != null) {
        return Image.network(
          imgNetwork!,
          width: iconSize ?? 30,
          height: iconSize ?? 30,
        );
      } else if(icon != null) {
        return Center(
          child: Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? DefaultColors.blue9D,
          ),
        );
      } else {
        return null;
      }
    }

    return InkWell(
        focusNode: focusNode,
        onTap: isNavigateBack
            ? () => Navigator.of(context).pop()
            : onTap,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return DefaultColors.transparent;
            }
            if (states.contains(WidgetState.hovered)) {
              return DefaultColors.transparent;
            }
            return null;
          },
        ),
        child: Container(
          height: size ?? 35,
          width: size ?? 35,
          decoration: decoration ?? BoxDecoration(
              color: color ?? DefaultColors.blue9D.withOpacity(0.3),
              shape: BoxShape.circle),
          child: buildImageOrIcon()
        ));
  }
}
