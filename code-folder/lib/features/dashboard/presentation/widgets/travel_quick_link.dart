import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

class TravelQuickLinks extends StatelessWidget {
  const TravelQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    List names = ['Flights', 'Hotels', 'My Trips'];
    List icons = [
      UISvgIcon(
        assetPath: AssetPath.svg.plane,
        color: DefaultColors.blue9D,
        width: 28,
        height: 28,
      ),
      UISvgIcon(
        assetPath: AssetPath.svg.hotel,
        color: DefaultColors.blue9D,
        width: 28,
        height: 28,
      ),
      UISvgIcon(
        assetPath: AssetPath.svg.my_trip,
        color: DefaultColors.blue9D,
        width: 28,
        height: 28,
      ),
    ];
    return Container(
      height: 131,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
                'Explore travel with us',
                fontSize: 16,
                color: DefaultColors.black,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 61.0,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: names.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12.0),
              itemBuilder: (context, index) {
                return _TravelItem(name: names[index], icon: icons[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TravelItem extends StatelessWidget {
  final String name;
  final UISvgIcon icon;

  const _TravelItem({Key? key, required this.name, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 36, // Adjust the size of the circle
            height: 36,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Color(0xFFF6F8FB), // Background color
              shape: BoxShape.circle,
            ),
            child: Center(child: icon), // Center the icon
          ),
          const SizedBox(
            height: 6.0,
          ),
          UiTextNew.customRubik(
            name.length > 8 ? '${name.substring(0, 7)}..' : name,
            fontSize: 11,
            color: DefaultColors.black,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
