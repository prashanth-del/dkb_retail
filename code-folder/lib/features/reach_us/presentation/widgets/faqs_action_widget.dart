import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class FaqsActionWidget extends StatelessWidget {
  const FaqsActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: DefaultColors.white,
          strokeAlign: 1,
        ),
        color: DefaultColors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
        child: UiTextNew.customRubik(
          DefaultString.instance.faqsTitle,
          fontSize: 12,
          color: DefaultColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
