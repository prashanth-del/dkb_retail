import 'package:flutter/material.dart';

import 'point_box.dart';
import 'point_earn_card.dart';

class ProgressBarSection extends StatelessWidget {
  const ProgressBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double w(double val) => val * screenWidth / 400;
    double h(double val) => val * screenHeight / 800;
    double sp(double val) => val * screenWidth / 400;
    double r(double val) => val * screenWidth / 400;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 228, 230),
        borderRadius: BorderRadius.circular(r(14)),
      ),
      padding: EdgeInsets.all(w(14)),
      child: Column(
        children: [
          PointsEarnCard(), // Make sure PointsEarnCard is also updated for MediaQuery
          SizedBox(height: h(15)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(r(18)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(w(14)),
            child: Column(
              children: [
                Row(
                  children: [
                    PointBox(height: h(50), width: w(50)),
                    SizedBox(width: w(10)),
                    Text(
                      'claim upto 150 reward points\nafter reaching the\nnext transaction goal',
                      style: TextStyle(
                        fontSize: sp(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h(30)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: h(20),
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
                    ),
                    SizedBox(width: w(10)),
                    Text(
                      'QAR 240 AWAY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sp(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
