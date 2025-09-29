import 'package:db_uicomponents/src/styles/theme/colorscheme/colors/default_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A common customizable app bar used across the app
class CommonAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final EdgeInsets? padding;
  final Widget? suffix;
  final Color backgroundColor;
  final Color? iconColor;
  final double? height; // user can override if needed

  const CommonAuthAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.padding,
    this.showBackButton = true,
    this.onBack,
    this.suffix,
    this.iconColor,
    this.backgroundColor = Colors.transparent,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dynamicHeight = height ?? size.height * 0.08; // ~8% of screen height
    final iconSize = size.width * 0.03;
    final horizontalPadding = size.width * 0.04; // dynamic padding
    final fontSize = size.width * 0.045; // ~4.5% of screen width

    return Container(
      color: backgroundColor,
      height: dynamicHeight,
      padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          // Back button
          if (showBackButton) ...[
            InkWell(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(size.width * 0.01),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: DefaultColors.black25.withAlpha(60))),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: iconSize,
                  color: iconColor ?? DefaultColors.blue98,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            )
          ],

          // Title
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: DefaultColors.blue9D,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Optional suffix (e.g. icon, button, menu)
          if (suffix != null) suffix!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      height ?? WidgetsBinding.instance.window.physicalSize.height * 0.08);
}
