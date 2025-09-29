import 'package:db_uicomponents/src/template/ui_account_card.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:flutter/material.dart';
import '../../components.dart';

class UITab extends StatelessWidget {
  final String tabName;
  final bool active;
  final Color? activeTabColor;
  final String? assetIcon;
  final double? activeTabRadius;
  final Color? activeTabTextColor;
  final Color? inActiveTabTextColor;

  const UITab({
    super.key,
    required this.tabName,
    this.active = false,
    this.activeTabColor,
    this.assetIcon,
    this.activeTabRadius,
    this.activeTabTextColor,
    this.inActiveTabTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: active ? (activeTabColor ?? Theme.of(context).primaryColor) : null,
        
      ),
      padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5).toDirectional(context),
      child: Center(
        child: Column(
          children: [
            if(assetIcon != null)
            Image.asset(assetIcon!, height: 20, width: 20),
            Center(
              child: UiTextNew.custom(
                tabName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                fontSize: 14,
                fontFamily: Fonts.rubik,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active ? (activeTabTextColor ?? DefaultColors.white_0) : (inActiveTabTextColor ?? Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
