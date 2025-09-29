import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/quick_actions_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../common/components/card_stack.dart';
import '../../../common/models/account_details.dart';

// If needed elsewhere, otherwise remove
final selectedIndexProvider = StateProvider<int>((ref) => 0);

@RoutePage()
class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              /// Top App Bar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.router.pop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: DefaultColors.black,
                      size: 24,
                    ),
                  ),
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: DefaultColors.black15,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Title + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "All Accounts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: DefaultColors.grey.withAlpha(100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "All Accounts",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Icon(Icons.add, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Recent Spends Section
              Container(
                decoration: BoxDecoration(
                  color: DefaultColors.grey.withAlpha(100),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Spends",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "10,000 QAR",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              CardStack(
                accounts: accounts,
                direction: Axis.vertical,
                cardCallbackFunction: (accountDetail) {
                  context.router.push(
                    AccountRoute(index: int.parse(accountDetail.accountNumber)),
                  );
                },
              ),
              const SizedBox(height: 24),

              /// Quick Actions
              Padding(padding: EdgeInsets.all(8.0), child: quickActionCard()),
            ],
          ),
        ),
      ),
    );
  }
}
