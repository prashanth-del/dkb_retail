import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/customized_dashboard_btn.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/quick_action_card.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_credit_card.dart';
import 'dashboard_rashid_card.dart';
import 'dashboard_reward.dart';

Widget buildContentCard(BuildContext context) {
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Consumer(
          builder: (context, ref, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Customize',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BuildQuickActionsGrid(),
                SizedBox(height: 40),
                DashboardCreditCardSection(),
                SizedBox(height: 20),
                RewardsSection(),
                SizedBox(height: 20),
                DashboardRashidCard(),
                SizedBox(height: 20),
                customizedDashboardBtn(context, ref),
              ],
            );
          },
        ),
      ),
      FloatingSearchBar(),
    ],
  );
}
