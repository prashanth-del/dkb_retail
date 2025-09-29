import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';

/// Rewards section containing points, reward cards and referral card
class RewardsSection extends ConsumerWidget {
  const RewardsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    // Dummy values (later can be replaced with providers)
    final int rewardPoints = 472;
    final int transactionsAway = 2;

    final double spacing = size.height * 0.02;
    final double titleFontSize = size.width * 0.045;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rewards',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: spacing),
        _RewardPointsHeader(points: rewardPoints),
        SizedBox(height: spacing),
        _RewardCards(transactionsAway: transactionsAway),
        SizedBox(height: size.height * 0.05),
        const ReferAndEarnCard(),
      ],
    );
  }
}

/// Header widget showing reward points
class _RewardPointsHeader extends StatelessWidget {
  final int points;
  const _RewardPointsHeader({required this.points});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double iconSize = size.width * 0.06;
    final double fontSize = size.width * 0.04;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.blue, size: iconSize),
              SizedBox(width: size.width * 0.02),
              Text(
                '$points Reward Points Earned',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            size: iconSize * 0.6,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

/// Reward cards with collect button and progress indicator
class _RewardCards extends StatelessWidget {
  final int transactionsAway;
  const _RewardCards({required this.transactionsAway});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardHeight = size.height * 0.2;
    final double padding = size.width * 0.04;
    final double fontSize = size.width * 0.035;

    return SizedBox(
      height: cardHeight,
      child: Row(
        children: [
          // Left reward card
          Expanded(
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  transform: GradientRotation(2),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 8, 100, 176),
                    Color.fromARGB(255, 119, 165, 205),
                    Color.fromARGB(255, 8, 100, 176),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Reward Unlocked',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        width: size.width * 0.35,
                        height: size.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Collect Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Icon(
                      Icons.star,
                      color: Colors.white.withAlpha(40),
                      size: 20,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 30,
                    child: Icon(
                      Icons.star,
                      color: Colors.white.withAlpha(50),
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 0,
                    child: Icon(
                      Icons.star,
                      color: Colors.white.withAlpha(30),
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
          // Right progress card
          Expanded(
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$transactionsAway transactions away from unlocking the reward',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize * 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  const LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    color: Colors.black,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Collect Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
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

/// Referral section
class ReferAndEarnCard extends StatelessWidget {
  const ReferAndEarnCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String referralCode = 'FRIEND2024';

    final double fontSize = size.width * 0.035;

    return SizedBox(
      height: size.height * 0.25,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Refer & Earn',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.015,
                  horizontal: size.width * 0.04,
                ),
                decoration: BoxDecoration(
                  color: DefaultColors.grey.withAlpha(70),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer(
                      builder: (context, ref, _) {
                        return SizedBox(
                          width: size.width * 0.6,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal,
                              ),
                              children: [
                                TextSpan(text: 'Invite friends and '),
                                TextSpan(
                                  text: ref.getLocaleString(
                                    'earn 50 points',
                                    defaultValue: 'earn 50 points',
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: fontSize,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' for each successful referral!',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: size.height * 0.04),
                    Text(
                      'Your Referral Code',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          referralCode,
                          style: TextStyle(
                            letterSpacing: 4,
                            color: Colors.black,
                            fontSize: fontSize * 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: referralCode),
                            );
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 20,
                            color: DefaultColors.blue98,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Share Link',
                          style: TextStyle(
                            color: DefaultColors.blue98,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Icon(
                          Icons.share,
                          size: 16,
                          color: DefaultColors.blue98,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: Container(
              width: size.width * 0.25,
              height: size.width * 0.25,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/gif/dashboard/gift_box.gif'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
