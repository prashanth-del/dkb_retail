import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';

class TravelPackages extends StatelessWidget {
  TravelPackages({super.key});

  final List<Map<String, String>> travelPackages = [
    {
      'title': '- DOHA -',
      'subtitle': 'EXPLORE QATAR',
      'image': AssetPath.image.doha
    },
    {
      'title': '- PARIS -',
      'subtitle': 'TOURS IN PARIS',
      'image': AssetPath.image.paris
    },
    {
      'title': '- DOHA -',
      'subtitle': 'EXPLORE QATAR',
      'image': AssetPath.image.doha
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                UiTextNew.customRubik(
                  'Travel Packages',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: DefaultColors.black,
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 270,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: travelPackages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12.0),
                  itemBuilder: (context, index) {
                    return _travelPackItem(travelPackages[index]);
                  },
                ),
              ),
            ])));
  }

  Widget _travelPackItem(Map<String, String> package) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0, // Red channel
                0.2126, 0.7152, 0.0722, 0, 0, // Green channel
                0.2126, 0.7152, 0.0722, 0, 0, // Blue channel
                0, 0, 0, 1, 0, // Alpha channel
              ]),
              child: Image.asset(
                height: 230,
                width: 200,
                package['image']!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 260,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiTextNew.customRubik(
                  package['title']!,
                  color: Colors.white,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                UiTextNew.customRubik(
                  package['subtitle']!,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 36, // Adjust the size of the circle
              height: 36,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color:
                    DefaultColors.grey_05.withOpacity(0.7), // Background color
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                color: DefaultColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
