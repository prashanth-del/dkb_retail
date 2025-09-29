import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class BrandDeals extends StatelessWidget {
  const BrandDeals({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      AssetPath.image.boss,
      AssetPath.image.chanel,
      AssetPath.image.nike,
      AssetPath.image.ck,
    ];

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const UiTextNew.customRubik(
                  'Deals on your \nfavourite brands',
                  fontSize: 16,
                  color: DefaultColors.black,
                ),
                GestureDetector(
                  child: const UiTextNew.customRubik(
                    'View All',
                    fontSize: 12,
                    color: DefaultColors.blue9D,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Bill Items List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: imgList.map((item) => _brand_deal(item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brand_deal(String image) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ClipOval(
        child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
      ),
    );
    //   CircleAvatar(
    //   radius: 35,
    //   backgroundImage: AssetImage(
    //     image,
    //   ),
    //   backgroundColor: Colors.transparent,
    // );
  }
}
