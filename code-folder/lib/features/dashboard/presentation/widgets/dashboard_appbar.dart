import 'package:dkb_retail/features/dashboard/presentation/widgets/animated_profile.dart';
import 'package:flutter/material.dart';

Widget buildAppBar(Color highlightText, Size size, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
    child: Row(
      children: [
        AnimatedProfilePhoto(),
        const Spacer(),
        _ScoreBadge(highlightText: highlightText, size: size),
        SizedBox(width: size.width * 0.02),
        Icon(
          Icons.notifications_none,
          color: highlightText,
          size: size.width * 0.07,
        ),
      ],
    ),
  );
}

Widget _ScoreBadge({required Color highlightText, required Size size}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.03,
      vertical: size.height * 0.007,
    ),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: 20),
        SizedBox(width: size.width * 0.02),
        Text(
          '472',
          style: TextStyle(
            color: highlightText,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.04,
          ),
        ),
      ],
    ),
  );
}
