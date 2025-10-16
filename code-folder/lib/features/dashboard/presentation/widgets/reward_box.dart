import 'package:flutter/material.dart';

import '../../data/reward_box_model.dart';

class RewardBox extends StatelessWidget {
  final RewardBoxType type;
  final String title;
  final double progressPercentage;
  final VoidCallback onTap;
  final double width;

  const RewardBox({
    super.key,
    required this.type,
    required this.title,
    required this.onTap,
    this.progressPercentage = 0.0,
    this.width = 180,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double w(double val) => val * screenWidth / 400;
    double h(double val) => val * screenHeight / 800;
    double sp(double val) => val * screenWidth / 400;
    double r(double val) => val * screenWidth / 400;

    return Container(
      width: double.maxFinite,
      height: h(167),
      padding: EdgeInsets.all(r(8)),
      decoration: BoxDecoration(
        color: type == RewardBoxType.white
            ? const Color.fromARGB(255, 226, 228, 230)
            : null,
        gradient: type == RewardBoxType.gradient
            ? LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(r(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              color: type == RewardBoxType.white ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: sp(14),
            ),
          ),
          if (type == RewardBoxType.white) ...[
            Container(
              height: h(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 195, 236, 248),
                borderRadius: BorderRadius.circular(r(10)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 84, 170, 240),
                      borderRadius: BorderRadius.circular(r(10)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: h(10)),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                minWidth: w(width - 30),
                height: h(33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(r(16)),
                  side: const BorderSide(color: Colors.blue),
                ),
                onPressed: onTap,
                child: Text(
                  'Collect now',
                  style: TextStyle(color: Colors.blue, fontSize: sp(13)),
                ),
              ),
            ),
          ] else ...[
            SizedBox(height: h(15)),
            InkWell(
              onTap: onTap,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: h(33),
                  width: w(130),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(r(16)),
                  ),
                  child: Image.asset(
                    'assets/images/collect.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
