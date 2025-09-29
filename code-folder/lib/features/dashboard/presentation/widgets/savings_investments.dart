import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class SavingsAndInvestments extends StatelessWidget {
  const SavingsAndInvestments({super.key});

  @override
  Widget build(BuildContext context) {
    List elements = [
      SavingGridItems(
        icon: AssetPath.svg.bar_chart,
        title: 'Demat Account',
        description: 'Simplify your savings with a secure Demat account.',
        action: 'Apply Now',
      ),
      SavingGridItems(
        icon: AssetPath.svg.star,
        title: 'Risk Profile Calculator',
        description: 'Know your risk tolerance for smarter decisions.',
        action: 'Calculate',
      ),
      SavingGridItems(
        icon: AssetPath.svg.acc_calendar,
        title: 'Investments/ Saving Goals',
        description: 'Set, Track and achieve your financial goals.',
        action: 'Set Goals',
      ),
      SavingGridItems(
        icon: AssetPath.svg.acc_wallet,
        title: 'Wealth Management Services',
        description: 'Tailored strategies to grow and protect your wealth.',
        action: 'Apply Now',
      ),
    ];
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UiTextNew.customRubik(
                  textAlign: TextAlign.start,
                  'Savings & Investments',
                  fontSize: 16,
                  color: DefaultColors.black,
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.builder(
              itemBuilder: (context, index) {
                return _gridItems(elements[index]);
              },
              itemCount: elements.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 0,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 0.89,
              ),
              padding: const EdgeInsets.all(5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridItems(SavingGridItems saving) {
    return Card(
      color: const Color(0xFFF6F8FB),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 33,
              height: 33,
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: DefaultColors.white,
              ),
              child: UISvgIcon(
                width: 30,
                height: 30,
                assetPath: saving.icon,
                color: DefaultColors.blue9D,
              ),
            ),
            const SizedBox(height: 8),
            UiTextNew.custom(
              saving.title,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: DefaultColors.black,
            ),
            const SizedBox(height: 8),
            UiTextNew.custom(
              maxLines: 2,
              saving.description,
              fontSize: 10,
              color: DefaultColors.black,
            ),
            const SizedBox(height: 8),
            UiTextNew.custom(
              saving.action,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: DefaultColors.blue9D,
            ),
          ],
        ),
      ),
    );
  }
}

class SavingGridItems {
  String icon;
  String title;
  String description;
  String action;

  SavingGridItems({
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
  });
}
