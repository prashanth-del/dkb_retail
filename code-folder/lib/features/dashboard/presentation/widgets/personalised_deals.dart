import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class PersonalisedDeals extends StatelessWidget {
  const PersonalisedDeals({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Personalised Deals',
                  fontSize: 16,
                  color: DefaultColors.black,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AssetPath.image.personalised_deal,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
