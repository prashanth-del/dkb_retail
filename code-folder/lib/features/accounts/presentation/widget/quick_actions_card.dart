import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

Widget quickActionCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: DefaultColors.grey.withAlpha(100),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        quickActionItemCard(icon: Icons.wallet, title: "Quick \n Transfer"),
        quickActionItemCard(
          icon: Icons.wallet,
          title: "Download \n e-statement",
        ),
        quickActionItemCard(icon: Icons.wallet, title: "Request \n Checkbooks"),
        quickActionItemCard(icon: Icons.wallet, title: "Pay \n Bills"),
      ],
    ),
  );
}

Widget quickActionItemCard({required IconData icon, required String title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DefaultColors.white.withAlpha(200),
        ),
        padding: const EdgeInsets.all(20),
        child: Icon(icon, color: DefaultColors.black),
      ),
      const SizedBox(height: 8),
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: DefaultColors.black, fontSize: 14),
      ),
    ],
  );
}
