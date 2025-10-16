import 'dart:math';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final String balance;
  final String currency;
  final String holderName;

  const AccountCard({
    super.key,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.holderName,
  });

  // Predefined gradient color pairs
  static final List<List<Color>> gradientColors = [
    [Color(0xFF4B2ECF), Color(0xFF7B5FFF)], // purple
    [Color(0xFF2193b0), Color(0xFF6dd5ed)], // teal-blue
    [Color(0xFFff9966), Color(0xFFff5e62)], // orange-red
    [Color(0xFF11998e), Color(0xFF38ef7d)], // green
    [Color(0xFFee0979), Color(0xFFff6a00)], // pink-orange
  ];

  @override
  Widget build(BuildContext context) {
    // Pick a random gradient for each card
    final random = Random();
    final colors = gradientColors[random.nextInt(gradientColors.length)];

    return Container(
      width: 320,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Account type + number
          Text(
            "$accountType · $accountNumber",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),

          /// Balance + eye icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$balance $currency",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.visibility_off_outlined,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Name + Statement button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                holderName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.receipt_long, size: 16),
                label: const Text("Statement"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
