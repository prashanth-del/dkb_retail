import 'package:flutter/material.dart';

class PointsEarnCard extends StatelessWidget {
  const PointsEarnCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 251, 252),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/icons/chest.png',
            width: screenWidth * 0.05,
            height: screenHeight * 0.025,
            color: Colors.blue,
          ),
          Text(
            '1285 Reward Points earned',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Transform.rotate(
            angle: 0.5,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.blue,
              size: screenWidth * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}
