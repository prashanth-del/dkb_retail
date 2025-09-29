import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class FavouritesCard extends StatelessWidget {
  final List<String> names;
  final List<UISvgIcon> icons;
  final VoidCallback onViewAllPressed;

  const FavouritesCard({
    Key? key,
    required this.names,
    required this.icons,
    required this.onViewAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Favourites',
                fontSize: 16,
                color: DefaultColors.white_800,
              ),
              GestureDetector(
                onTap: onViewAllPressed,
                child: const UiTextNew.customRubik(
                  'View All',
                  fontSize: 12,
                  color: DefaultColors.blue9D,
                ),
              ),
            ],
          ),
          Spacer(),
          // const SizedBox(height: 5.0),
          SizedBox(
            height: 61.0,
            // width: 72,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: names.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12.0),
              itemBuilder: (context, index) {

                return _FavouriteItem(name: names[index], icon: icons[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavouriteItem extends StatelessWidget {
  final String name;
  final UISvgIcon icon;
  const _FavouriteItem({Key? key, required this.name, required this.icon}) : super(key: key);

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
            decoration: BoxDecoration(
              color: Color(0xFFF6F8FB), // Background color
              shape: BoxShape.circle,
            ),
            child: Center(child: icon), // Center the icon
          ),
          const SizedBox(height: 6.0,),
          UiTextNew.customRubik(
            name.length > 8 ? '${name.substring(0, 7)}..' : name,
            fontSize: 11,
            color: DefaultColors.white_800,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}


