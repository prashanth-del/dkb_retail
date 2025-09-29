import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class ManageCard extends StatelessWidget {
  final List<String> names;
  final List<UISvgIcon> icons;

  const ManageCard({
    Key? key,
    required this.names,
    required this.icons,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const UiTextNew.customRubik(
                'Manage & Services',
                fontSize: 16,
                color: DefaultColors.white_800,
              ),
            ],
          ),
          const SizedBox(height: 10), // Added spacing between text and list
          SizedBox(
            height: 61.0,
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.2, // Dynamically set the width as 20% of the screen width
      height: screenWidth * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36, // Adjust the size of the circle
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB), // Background color
              shape: BoxShape.circle,
            ),
            child: Center(child: icon), // Center the icon
          ),
          const SizedBox(height: 6.0),
          // This widget now allows text wrapping by using a Column with a flexible text widget
          UiTextNew.customRubik(
            name.length > 10 ? '${name.substring(0, 7)}..' : name,
            fontSize: 11,
            color: DefaultColors.white_800,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
