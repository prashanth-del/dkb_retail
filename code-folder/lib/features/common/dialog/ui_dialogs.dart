import 'dart:async';

import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/asset_path/asset_path.dart';
import '../styles/ui_text_styles.dart';

class UiDialogs {
  const UiDialogs._();

  static showSuccessDialog(
          {required BuildContext context,
          required String description,
          String title = "Success"}) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(seconds: 4), () {
              Navigator.of(context).pop(true);
            });
            return SimpleDialog(
              children: [
                UILottie(asset: AssetPath.lottie.successAnimation),
                const UiSpace.vertical(16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: UiTextStyles.uiTitleStyle(context)?.copyWith(
                        color: DefaultColors.white_900,
                      ),
                    ),
                    const UiSpace.vertical(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0)
                          .copyWith(bottom: 5), // previous bottom -> 24
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: UiTextStyles.uiInfoTitleSmall(context)?.copyWith(
                          color: DefaultColors.white_700,
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          });

  static showErrorDialog(
          {required BuildContext context,
          required String description,
          VoidCallback? bknOkPressed,
          String title = "Error"}) =>
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: [
            const UiSpace.vertical(10),
            UISvgIcon(assetPath: SvgAssets().error),
            const UiSpace.vertical(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UiTextNew.b1Semibold(
                    title,
                  ),
                  const UiSpace.vertical(16),
                  UiTextNew.b2Regular(
                    description,
                    textAlign: TextAlign.center,
                    color: DefaultColors.black15,
                  ),
                  UIButton.rounded(
                    label: "Okay",
                    onPressed: bknOkPressed,
                    maxWidth: double.maxFinite,
                  ).padding(EdgeInsets.symmetric(horizontal: 12))
                ],
              ),
            )
          ],
        ),
      );


}
