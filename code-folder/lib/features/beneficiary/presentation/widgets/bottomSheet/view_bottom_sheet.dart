import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

viewBottomSheet({
  required BuildContext context,
  required String title,
  required Widget child,
  double? heightPercentage,
}) {
  UiBottomSheet.basicSheet(
    context: context,
    maxHeightPercentage: heightPercentage ?? 0.85,
    title: title,
    child: child,
    backIconPath: AssetPath.icon.back_right,
  );
}
