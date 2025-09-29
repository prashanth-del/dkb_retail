import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

/// Dashboard Rashid helper card
class DashboardRashidCard extends ConsumerWidget {
  const DashboardRashidCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    // Responsive values
    final double padding = size.width * 0.04;
    final double titleFontSize = size.width * 0.035;
    final double subtitleFontSize = size.width * 0.04;
    final double actionFontSize = size.width * 0.035;
    final double iconSize = size.width * 0.04;
    final double lottieWidth = size.width * 0.25;

    return Container(
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      decoration: BoxDecoration(
        color: DefaultColors.grey.withAlpha(70),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    "Have any Questions?",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  "Rashid is here to help you",
                  style: TextStyle(
                    color: DefaultColors.black,
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  children: [
                    Text(
                      "Get help",
                      style: TextStyle(
                        color: DefaultColors.blue98,
                        fontSize: actionFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Icon(
                      Icons.arrow_outward_sharp,
                      size: iconSize,
                      color: DefaultColors.blue98,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/gif/Dukhan Bank Chatbot Homepage GIF.gif",
            width: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ],
      ),
    );
  }
}
