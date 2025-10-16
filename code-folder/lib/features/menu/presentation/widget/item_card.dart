import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String image;
  final String title;
  const ItemCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.432,
      height: screenWidth * 0.295,
      decoration: BoxDecoration(
        color: const Color.fromARGB(225, 40, 44, 56),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          spacing: 0,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: screenWidth * 0.2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.navigate_next, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
