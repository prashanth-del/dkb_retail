import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/Material.dart';

class DividerSheetCommon extends StatelessWidget {
  const DividerSheetCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        width: 50,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          color: DefaultColors.grayLightBase,
        ),
      ),
    );
  }
}
