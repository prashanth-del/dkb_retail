import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_path/asset_path.dart';

class AutoLeadingWidget extends StatelessWidget {
  const AutoLeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutoLeadingButton(
      builder: (context, leadingType, action) {
        return GestureDetector(
          onTap: () {
            if (action != null) action();
          },
          child: UISvgIcon(assetPath: AssetPath.icon.leading),
        );
      },
    );
  }
}
