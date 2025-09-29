import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? logoPath;
  final String? leadingLogoPath;
  final bool automaticImplyLeading;
  final bool isCentreLogo;
  final Widget? leadingWidget;
  final Widget? trailing;
  final Color? appBarColor;
  final Color? backButtonColor;
  final double? height;
  final SystemUiOverlayStyle? value;
  final EdgeInsets padding;
  final List<Widget>? actions;
  final BorderRadius borderRadius;

  const UIAppBar2({
    super.key,
    this.title,
    this.logoPath,
    this.leadingLogoPath,
    this.automaticImplyLeading = false,
    this.isCentreLogo = false,
    this.leadingWidget,
    this.trailing,
    this.actions,
    this.appBarColor = Colors.white,
    this.backButtonColor,
    this.height,
    this.value,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: value ?? const SystemUiOverlayStyle(
            statusBarColor: DefaultColors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: DefaultColors.white,
            systemNavigationBarIconBrightness: Brightness.dark
        ),
        child: Container(
            height: preferredSize.height,
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: borderRadius,
            ),
            child: SafeArea(
                bottom: false,
                child: Container(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (logoPath != null) _buildLogoSection(),
                      if (actions != null) ..._buildActions(),
                    ],
                  ),
                ))));
  }

  List<Widget> _buildActions() {
    return actions!.map((action) => action).toList();
  }

  Widget _buildLogoSection() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SvgPicture.asset(logoPath!)],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);
}
