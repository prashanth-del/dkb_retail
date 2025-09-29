import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> offerList = [
      {'name': 'Gift cards', 'icon': AssetPath.svg.gift_card},
      {'name': 'Vouchers', 'icon': AssetPath.svg.voucher},
    ];
    return Container(
      height: 131,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const UiTextNew.customRubik(
                'Offers',
                fontSize: 16,
                color: DefaultColors.black,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Flexible(flex: 1, child: _offerItem(offerList[0])),
            SizedBox(
              width: 20,
            ),
            Flexible(flex: 1, child: _offerItem(offerList[1])),
          ]),
        ],
      ),
    );
  }

  Widget _offerItem(Map<String, String> offerList) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFFF6F8FB), // Background color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: UiTextNew.customRubik(
              offerList['name']!,
              fontSize: 11,
              color: DefaultColors.black,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: UISvgIcon(
                  height: 20,
                  width: 25,
                  assetPath: offerList['icon']!,
                  color: DefaultColors.blue9D)),
        ],
      ),
    );
  }
}
