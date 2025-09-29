import 'package:flutter/material.dart';

import '../../db_uicomponents.dart';

class UIIconButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  const UIIconButton({super.key, required this.icon, this.iconSize, this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        iconSize: iconSize ?? 20,
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
            minHeight: iconSize ?? 20,
            minWidth: iconSize ?? 20,
            maxHeight: iconSize ?? 20,
            maxWidth: iconSize ?? 20
        ),
        icon: Icon(icon,
          color: iconColor ?? DefaultColors.black15,
          size: iconSize ?? 20,
        ));
  }
}
