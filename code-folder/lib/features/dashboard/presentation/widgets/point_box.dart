import 'package:flutter/material.dart';

class PointBox extends StatelessWidget {
  final double height;
  final double width;
  final double iconSize;
  final double imageSize;
  final double fontSize;

  const PointBox({
    this.height = 50,
    this.width = 50,
    this.fontSize = 14,
    this.iconSize = 15,
    this.imageSize = 17,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: height * (screenHeight / 800), // scale based on screen height
      width: width * (screenWidth / 400), // scale based on screen width
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 195, 236, 248),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      padding: EdgeInsets.all(screenWidth * 0.012),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '150',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSize * (screenWidth / 400),
            ),
          ),
          Row(
            children: [
              Icon(Icons.add, size: iconSize * (screenWidth / 400)),
              SizedBox(width: screenWidth * 0.01),
              Image.asset(
                'assets/images/coins.png',
                width: imageSize * (screenWidth / 400),
                height: imageSize * (screenWidth / 400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
