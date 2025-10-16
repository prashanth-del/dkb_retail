import 'package:flutter/material.dart';

import '../../data/reward_box_model.dart';
import 'point_box.dart';
import 'point_earn_card.dart';
import 'reward_box.dart';

class RewardsLaregSection extends StatelessWidget {
  const RewardsLaregSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<RewardBoxModel> rewardBoxes = [
      RewardBoxModel(
        type: RewardBoxType.gradient,
        title: 'New Reward\nUnlocked',
      ),

      RewardBoxModel(
        type: RewardBoxType.white,
        title: '2 more transaction away\nfrom unlocking this\nreward',
        progressPercentage: 0.7,
      ),
    ];

    return SizedBox(
      width: screenWidth,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 228, 230),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            padding: EdgeInsets.all(screenWidth * 0.045),
            child: Column(
              children: [
                const PointsEarnCard(),
                SizedBox(height: screenHeight * 0.012),
                Container(
                  height: screenHeight * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          PointBox(
                            height: screenHeight * 0.08,
                            width: screenWidth * 0.15,
                            fontSize: screenWidth * 0.045,
                            iconSize: screenWidth * 0.048,
                            imageSize: screenWidth * 0.06,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '150 reward bonus',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.048,
                                ),
                              ),
                              Text(
                                'claim upto 150 reward points after\nreaching the next transaction goal',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: screenHeight * 0.025,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 195, 236, 248),
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.025,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        84,
                                        170,
                                        240,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        screenWidth * 0.025,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.013),
                          const Text(
                            'QAR 240 AWAY',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.1,
            right: screenWidth * 0.08,
            child: SizedBox(
              height: screenHeight * 0.21,
              width: screenWidth,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.55),
                itemCount: rewardBoxes.length,
                itemBuilder: (context, index) {
                  final reward = rewardBoxes[index];
                  return Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.03),
                    child: RewardBox(
                      type: reward.type,
                      title: reward.title,
                      onTap: () {},
                      width: screenWidth * 0.4,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
