import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

Widget buildFormInputFieldForUpload(TextEditingController controller, String label, String hintText, Function() onTap) {
  return  UIFormTextField.outlined(
    hintText: hintText,
    labelHintTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: 'Rubik',
        color: DefaultColors.grayB3
    ),
    controller: controller ,
    borderColor: DefaultColors.grayE6,
    prefixIcon: Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
          child: SvgPicture.asset(AssetPath.icon.onboardingAttachFileIcon,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          onTap: onTap,
      ),
    ),
    labelUiText: UiTextNew.h4Regular(
      label,
      color: DefaultColors.white_800,
    ),
    labelTextStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        color: DefaultColors.white_800
    ),
  );


}

