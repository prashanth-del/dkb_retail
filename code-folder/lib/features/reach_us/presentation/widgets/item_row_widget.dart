import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ItemRowWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  void Function()? onTap;
  ItemRowWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: DefaultColors.grayLightBase,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 19),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(icon, width: 32, height: 32),
              SizedBox(height: 33),
              UiTextNew.customRubik(
                title,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: 4),
              UiTextNew.custom(
                subTitle,
                color: DefaultColors.grayBase,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  final String icon;
  const ItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: DefaultColors.grayLightBase,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiTextNew.customRubik(
                title,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
              Image.asset(icon, width: 24, height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
