import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class AccountCard extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final String balance;
  final String currency;
  final int index;
  final VoidCallback? onTap; // Add the onTap callback for navigation

  const AccountCard({
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.index,
    this.onTap, // Make onTap optional
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger navigation when tapped
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(index % 2 == 0 ? AssetPath.image.card1BgImg : AssetPath.image.card2BgImg),
            fit: BoxFit.fill,
          ),
          // color: DefaultColors.primaryBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiTextNew.h4Regular(
                accountType,
                color: DefaultColors.white,
              ),
              SizedBox(height: 8),
              UiTextNew.customRubik(
                accountNumber,
                color: DefaultColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiTextNew.h4Regular(
                    'Current Balance',
                    color: DefaultColors.white_f3,
                  ),
                  Row(
                    children: [
                      UiTextNew.h5Regular(
                        currency,
                        color: DefaultColors.white_0,
                      ),
                      SizedBox(width: 4),
                      UiTextNew.customRubik(
                        '********',
                        color: DefaultColors.white,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}