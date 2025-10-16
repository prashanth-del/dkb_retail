import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';

class LocateCard extends StatelessWidget {
  final Map<String, dynamic> loc;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onNavigate;

  const LocateCard({
    super.key,
    required this.loc,
    required this.isSelected,
    required this.onTap,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final addressText = loc["name"] ?? "";

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                AssetPath.image.branchDefaultImage,
                width: 92,
                height: 92,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.customRubik(
                      loc["type"],
                      color: DefaultColors.grayBase,
                      fontSize: 14,
                    ),
                    UiTextNew.b15Medium("Open", color: DefaultColors.greenBase),
                    UiTextNew.customRubik(
                      addressText,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      maxLines: 1,
                    ),
                    UiTextNew.customRubik(
                      "${loc["address"]}, ${loc["country"]}",
                      fontSize: 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onNavigate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetPath.image.navigationImage,
                      width: 32,
                      height: 32,
                    ),
                    UiTextNew.custom(
                      DefaultString.instance.direction,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: DefaultColors.blueLightBase,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
