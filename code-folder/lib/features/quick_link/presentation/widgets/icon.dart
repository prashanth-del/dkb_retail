import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: screenWidth * 0.13,
          width: screenWidth * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withAlpha(100), width: 0.5),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.015),
            child: Image.asset("assets/rhombus.png"),
          ),
        ),
      ],
    );
  }
}
