import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../data/model/card_summary_model.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final CardSummary card;
  const CardWidget({super.key, required this.index, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(index % 2 == 0 ? AssetPath.image.card3BgImg : AssetPath.image.card4BgImg),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UiSpace.vertical(30),
            UiTextNew.h4Regular(
              card.maskedCardNo,
              color: DefaultColors.white,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UiTextNew.h5Regular(
                  'Available Limit',
                  color: DefaultColors.white_f3,
                ),
                UiTextNew.h4Medium(
                  "${card.availableCreditLimit} ${card.currency}",
                  color: DefaultColors.white_f3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
