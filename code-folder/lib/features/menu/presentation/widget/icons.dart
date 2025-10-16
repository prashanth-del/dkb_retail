import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback function;
  const IconWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      child: Column(
        children: [
          Container(
            height: screenWidth * 0.15,
            width: screenWidth * 0.15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withAlpha(100)),
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.045),
              child: Image.asset(icon, color: Colors.black, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: screenWidth * 0.015),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
