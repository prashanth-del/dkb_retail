import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/ui_favorites_card.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

class FavouritesDashCard extends StatelessWidget {
  const FavouritesDashCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FavouritesCard(
      names: ['Joseph', 'Karthik', 'Sanjana', 'Joseph'],
      icons: [
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon)
      ],
      onViewAllPressed: () {
        // Handle View All press
        print("View All pressed!");
      },
    );
  }
}
