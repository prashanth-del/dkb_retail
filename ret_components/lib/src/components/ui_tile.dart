import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UITile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? leadingIconPath;
  final String price;
  final String date;
  final Color priceColor;
  final String currencyCode;
  final bool showDivider;
  final bool isRtl;
  final VoidCallback? endIconTap;
  final bool isNegative;

  const UITile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIconPath,
    required this.price,
    this.currencyCode = "QAR",
    required this.date,
    this.isRtl = false,
    this.endIconTap,
    this.showDivider = true,
    this.priceColor = Colors.red,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          minLeadingWidth: 0,
          horizontalTitleGap: 5,
          dense: true,
          minVerticalPadding: 0,
          contentPadding: isRtl
              ? const EdgeInsets.only(right: 5)
              : const EdgeInsets.only(right: 15),
          leading: isRtl
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTrailingIcon(),
                    const UiSpace.horizontal(10),
                    _buildTrailingContent(),
                  ],
                )
              : _buildLeadingIcon(),
          trailing: isRtl
              ? _buildLeadingIcon()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTrailingContent(),
                    const UiSpace.horizontal(10),
                    _buildTrailingIcon()
                  ],
                ),
          title: Text(
            title,
            style: TextStyle(
              color: DefaultColors.grayD3,
              fontFamily: _getFontFamily(Fonts.rubik),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          ),
          onTap: endIconTap,
        ),

        // Divider
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                UiSpace.vertical(12),
                Divider(
                  color: DefaultColors.gray0F,
                  height: 1,
                  thickness: 1,
                ),
                UiSpace.vertical(12),
              ],
            ),
          ),
      ],
    );
  }

  String _getFontFamily(Fonts family) {
    switch (family) {
      case Fonts.sfPro:
        return "sfPro";
      case Fonts.rubik:
        return "Rubik";
      case Fonts.diodrumArabic:
        return "DiodrumArabic";
    }
  }

  Widget _buildTrailingContent() {
    return Column(
      crossAxisAlignment:
          isRtl ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          '$price $currencyCode',
          style: TextStyle(
            color: DefaultColors.grayD3,
            fontSize: 16,
            fontFamily: _getFontFamily(Fonts.rubik),
            fontWeight: FontWeight.w600,
          ),
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        ),
        Text(
          date,
          style: TextStyle(
            color: DefaultColors.gray96,
            fontSize: 13,
            fontFamily: _getFontFamily(Fonts.rubik),
            fontWeight: FontWeight.w400,
          ),
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        ),
      ],
    );
  }

  Widget _buildTrailingIcon() {
    return UISvgIcon(
      assetPath: "assets/icons/three_dot.svg",
      onTap: endIconTap,
    );
  }

  Widget _buildLeadingIcon() {
    if (leadingIconPath == null) {
      return const SizedBox.shrink();
    }

    return Transform(
      transform: Matrix4.identity()..scale(isRtl ? -1.0 : 1.0, 1.0),
      alignment: Alignment.center,
      child: UISvgIcon(
        assetPath: leadingIconPath!,
        width: 35,
        height: 35,
      ),
    );
  }
}
