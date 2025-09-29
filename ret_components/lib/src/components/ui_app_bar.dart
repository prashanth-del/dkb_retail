import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum _AppBarType { login, primary, secondary, centreLogo, standard }

class UIAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? logoPath;
  final String? leadingLogoPath;
  final bool automaticImplyLeading;
  final bool isCentreLogo;
  final Widget? autoLeadingWidget;
  final List<Widget>? actions;
  final Color? appBarColor;
  final Color? backButtonColor;
  final double? height;
  final double? iconWidth;
  final Function()? onBackTap;
  final _AppBarType _type;
  final double? iconHeight;
  final String? subtitle;
  final Widget? extendedWidget;
  final SystemUiOverlayStyle? value;
  final BorderRadius borderRadius;

  const UIAppBar.login({
    required this.logoPath,
    required this.actions,
    this.value,
    this.appBarColor,
    this.height,
    this.onBackTap,
    this.extendedWidget,
    super.key,
  })  : title = null,
        autoLeadingWidget = null,
        leadingLogoPath = null,
        backButtonColor = null,
        automaticImplyLeading = false,
        isCentreLogo = false,
        iconHeight = null,
        this.subtitle = null,
        iconWidth = null,
        _type = _AppBarType.login,
        borderRadius = BorderRadius.zero,
        assert(logoPath != null);

  const UIAppBar.primary({
    required this.logoPath,
    required this.actions,
    this.value,
    this.appBarColor,
    this.height,
    this.onBackTap,
    this.extendedWidget,
    this.subtitle,
    super.key,
  })  : title = null,
        autoLeadingWidget = null,
        leadingLogoPath = null,
        backButtonColor = null,
        isCentreLogo = false,
        _type = _AppBarType.primary,
        iconHeight = null,
        iconWidth = null,
        automaticImplyLeading = false,
        borderRadius = const BorderRadius.only(
          bottomLeft: Corners.s16Radius,
          bottomRight: Corners.s16Radius,
        ),
        assert(logoPath != null);

  const UIAppBar.secondary({
    required this.title,
    this.height,
    this.iconHeight,
    this.iconWidth,
    this.appBarColor,
    this.subtitle,
    this.onBackTap,
    this.actions,
    this.value,
    required this.autoLeadingWidget,
    this.extendedWidget,
    super.key,
  })  : logoPath = null,
        isCentreLogo = false,
        automaticImplyLeading = true,
        leadingLogoPath = null,
        backButtonColor = null,
        _type = _AppBarType.secondary,
        borderRadius = const BorderRadius.only(
          bottomLeft: Corners.s16Radius,
          bottomRight: Corners.s16Radius,
        ),
        assert(title != null);

  const UIAppBar.centreLogo({
    required this.logoPath,
    this.autoLeadingWidget,
    this.automaticImplyLeading = false,
    this.leadingLogoPath,
    this.actions,
    this.subtitle,
    this.height,
    this.onBackTap,
    this.appBarColor = Colors.white,
    this.value,
    this.extendedWidget,
    super.key,
  })  : title = null,
        backButtonColor = null,
        isCentreLogo = true,
        iconHeight = null,
        _type = _AppBarType.centreLogo,
        iconWidth = null,
        borderRadius = const BorderRadius.only(
          bottomLeft: Corners.s16Radius,
          bottomRight: Corners.s16Radius,
        ),
        assert(logoPath != null);
  @Deprecated("Use secondary app bar instead of this")
  const UIAppBar.standard({
    required this.title,
    this.value,
    this.appBarColor,
    this.height,
    this.subtitle,
    this.actions,
    this.onBackTap,
    this.autoLeadingWidget,
    this.automaticImplyLeading = false,
    this.backButtonColor = Colors.black87,
    this.extendedWidget,
    super.key,
  })  : leadingLogoPath = null,
        logoPath = null,
        iconHeight = null,
        _type = _AppBarType.standard,
        iconWidth = null,
        isCentreLogo = false,
        borderRadius = BorderRadius.zero;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value ??
          const SystemUiOverlayStyle(
              statusBarColor: DefaultColors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarColor: DefaultColors.black,
              systemNavigationBarIconBrightness: Brightness.dark),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: appBarColor ?? DefaultColors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), // Rounded bottom-left corner
            bottomRight: Radius.circular(15), // Rounded bottom-right corner
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (automaticImplyLeading && autoLeadingWidget == null)
                    InkWell(
                      onTap: onBackTap ??
                          () {
                            Navigator.of(context).pop();
                          },
                      child: leadingLogoPath != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 6, top: 6),
                              child: _UIAppBarIcon(
                                iconPath: leadingLogoPath!,
                                width: iconWidth ?? context.screenWidth / 8,
                                height: iconHeight ?? 22,
                              ),
                            )
                          : Container(),
                    ).toDirectional(context)
                  else if (autoLeadingWidget != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 2),
                      child: SizedBox(
                        height: iconHeight ?? 22,
                        child: autoLeadingWidget!,
                      ),
                    ).toDirectional(context),
                  if (!automaticImplyLeading &&
                      (logoPath != null && !isCentreLogo))
                    _UIAppBarIcon(
                      iconPath: logoPath!,
                    ),
                  if (actions != null) ...[
                    const Spacer(),
                    ..._buildActions(),
                  ]
                ],
              ),
              if (title != null)
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            bottom: extendedWidget != null ? 10 : 0),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const UiSpace.vertical(5),
                              UiTextNew.h1Semibold(
                                title!,
                                color: DefaultColors.white,
                                textAlign: TextAlign.center,
                                lineHeight: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // cmt: For sub header
                              if (subtitle != null)
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: UiTextNew.custom(
                                      subtitle!,
                                      color: DefaultColors.white_700,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (extendedWidget != null) extendedWidget!,
                    ],
                  ),
                ),
              if (isCentreLogo && logoPath != null)
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: context.screenWidth - 80,
                      child: _UIAppBarIcon(iconPath: logoPath!),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return actions!.map((action) => action).toList();
  }

  @override
  Size get preferredSize {
    final baseHeight = kToolbarHeight;
    double extendedHeight = extendedWidget != null ? kToolbarHeight * 0.8 : 0;
    double subtitleHeight = 0;
    if (subtitle != null) {
      subtitleHeight =
          kToolbarHeight * (isSubtitleSingleLine(subtitle!) ? 0.4 : 0.8);
    }
    if (extendedWidget == null && subtitle != null) {
      subtitleHeight =
          kToolbarHeight * (isSubtitleSingleLine(subtitle!) ? 0.3 : 0.8);
    }

    return Size.fromHeight(baseHeight + extendedHeight + subtitleHeight);
  }

  bool isSubtitleSingleLine(String subtitle) {
    double maxWidth = 200;
    double estimatedWidth = (subtitle.length * 3);
    return estimatedWidth <= maxWidth;
  }
}
//   @override
//   Size get preferredSize => Size.fromHeight(height ??
//       (extendedWidget == null
//           ? kToolbarHeight
//           : (kToolbarHeight * 1.9 + 3 + (subtitle != null ? 10 : 0))));
// }

class _UIAppBarIcon extends StatelessWidget {
  final String iconPath;
  final double? width;
  final double? height;

  const _UIAppBarIcon({
    required this.iconPath,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return iconPath.endsWith('.svg')
        ? SvgPicture.asset(
            iconPath,
            width: width,
            height: height,
          )
        : Image.asset(
            iconPath,
            width: width,
            height: height,
          );
  }
}
