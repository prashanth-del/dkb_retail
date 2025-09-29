import 'dart:math';
import 'package:dkb_retail/features/common/components/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/account_details.dart';

/// Provider for expanded state
final expandedProvider = StateProvider<bool>((ref) => false);

class DashboardCreditCardSection extends ConsumerWidget {
  const DashboardCreditCardSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Colors (can also move these into a theme provider later)
    const Color primaryText = Colors.black;
    const Color secondaryText = Colors.black54;
    const Color tertiaryText = Colors.grey;
    const Color cardColor = Color.fromARGB(255, 2, 30, 54);
    const Color highlight = Colors.white;

    final accounts = [
      AccountDetails(
        holderName: "Chetan Joshi",
        accountType: "Saving Account",
        accountNumber: "123456789001",
        balance: "50,000",
        currency: "QAR",
      ),
      AccountDetails(
        holderName: "Chetan Joshi",
        accountType: "Salary Account",
        accountNumber: "123456789002",
        balance: "30,000",
        currency: "QAR",
      ),
      AccountDetails(
        holderName: "Chetan Joshi",
        accountType: "Business Account",
        accountNumber: "123456789003",
        balance: "75,000",
        currency: "QAR",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Credit Cards",
              style: TextStyle(
                color: secondaryText,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  "Manage Cards",
                  style: TextStyle(
                    color: primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                  color: primaryText,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: highlight,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: tertiaryText.withAlpha(50),
                spreadRadius: 1,
                blurRadius: 30,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Used",
                      style: TextStyle(
                        color: secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Available",
                      style: TextStyle(
                        color: secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(5),
                  backgroundColor: tertiaryText,
                  color: cardColor,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "24000",
                            style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: " QAR",
                            style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "5482",
                            style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: " QAR",
                            style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Total Limit: ",
                          style: TextStyle(color: secondaryText, fontSize: 14),
                        ),
                        TextSpan(
                          text: " 35000 QAR",
                          style: TextStyle(
                            color: secondaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CardStack(
                accounts: accounts,
                cardWidth: 350,
                cardCallbackFunction: (accounts) {},
                direction: Axis.horizontal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
