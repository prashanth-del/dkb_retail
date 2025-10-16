import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class AuthHeaderWrapper extends StatelessWidget {
  final Widget child; // content inside the white scrollable part
  final double topHeight; // height of gradient/header part
  final BorderRadiusGeometry borderRadius; // top rounded border
  final double? bodyTopSpace;
  final bool? withScroll;

  // Customizable header properties

  final Color headerColor;
  final EdgeInsetsGeometry? headerPadding;
  final bool? showBackButton;
  final IconData backIcon;
  final Color backIconColor;
  final double? backIconSize;
  final VoidCallback? onBack;
  final String headerText;
  final Widget? suffix;

  final TextStyle? headerTextStyle;

  /// ✅ Optional tabs widget (new)
  final Widget? tabs;

  const AuthHeaderWrapper({
    super.key,
    required this.child,
    this.bodyTopSpace,
    this.showBackButton = true,
    this.topHeight = 200,
    this.withScroll = true,

    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(20)),

    // header customizations with defaults
    this.headerColor = DefaultColors.blue_700,
    this.headerPadding,
    this.backIcon = Icons.arrow_back_ios_new,
    this.backIconColor = Colors.white,
    this.backIconSize,
    this.onBack,
    this.suffix,
    this.headerText = 'Back',
    this.headerTextStyle,

    /// ✅ optional tabs (default = null)
    this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// Dynamically increase header height if tabs are present
    final effectiveTopHeight = tabs != null ? topHeight + 50 : topHeight;
    final effectiveBodyTopSpace =
        bodyTopSpace ??
        (tabs != null ? size.height * 0.18 : size.height * 0.12);

    return Stack(
      children: [
        /// Header Part (same widget but customizable)
        ///
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: headerColor,
            image: DecorationImage(
              image: AssetImage(AssetPath.image.headerbackground),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Container(
          width: double.infinity,
          height: effectiveTopHeight,
          padding:
              headerPadding ??
              EdgeInsets.only(
                top: size.height * 0.06,
                left: size.width * 0.04,
                right: size.width * 0.04,
                bottom: size.height * 0.015,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (showBackButton ?? true) ...[
                    InkWell(
                      onTap: onBack ?? () => Navigator.of(context).pop(),
                      child: Icon(
                        backIcon,
                        color: backIconColor,
                        size: backIconSize ?? size.aspectRatio * 40,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Text(
                      headerText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          headerTextStyle ??
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                    ),
                  ),
                  if (suffix != null) ...[const Spacer(), suffix!],
                ],
              ),

              /// 🟦 Tabs (if provided)
              if (tabs != null) ...[
                SizedBox(height: size.height * 0.015),
                tabs!,
              ],
            ],
          ),
        ),

        /// White Scrollable Part
        Container(
          height: double.infinity,
          margin: EdgeInsets.only(top: effectiveBodyTopSpace),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Scrollable or static body
              Expanded(
                child: withScroll!
                    ? SingleChildScrollView(child: child)
                    : child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
