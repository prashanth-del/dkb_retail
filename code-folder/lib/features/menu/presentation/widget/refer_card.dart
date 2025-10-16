import 'package:flutter/material.dart';

class ReferCard extends StatelessWidget {
  const ReferCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth * 0.3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        gradient: const LinearGradient(
          stops: [0, 8],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff16074C), Color(0xff106EB2)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/refercard.png",
                height: screenWidth * 0.3,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Refer and Earn",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.036,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.36,
                    child: Text(
                      "Exclusive Benefits Awaits You!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * 0.028,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                        Size(screenWidth * 0.01, screenWidth * 0.07),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Apply Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.025,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
