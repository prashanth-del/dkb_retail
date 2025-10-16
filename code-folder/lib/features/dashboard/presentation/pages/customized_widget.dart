import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

import '../controllers/providers.dart';
import '../widgets/card_section.dart';
import '../widgets/progressBarSection.dart';
import '../widgets/reward_section.dart';

@RoutePage()
class CustomizeDashboardScreen extends StatelessWidget {
  const CustomizeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: UiBackgroundWrapper(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
              ), // instead of 16.r
              child: Column(
                children: [
                  CommonAuthAppBar(
                    title: 'Customise Widgets',
                    padding: EdgeInsets.zero,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pinned',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045, // instead of 18.sp
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.022), // instead of 18.h
                  CardSections(
                    stateProvider: dropdown1Provider,
                    title: 'Your Active Billers',
                    dropdownChild: ActiveBillerSection2(),
                  ),
                  SizedBox(height: screenHeight * 0.012), // instead of 10.h
                  CardSections(
                    stateProvider: dropdown2Provider,
                    title: 'Card Spends',
                    dropdownChild: CardSpendSection(),
                  ),
                  SizedBox(height: screenHeight * 0.012),
                  CardSections(
                    stateProvider: dropdown3Provider,
                    title: 'Credit Card Bills',
                    dropdownChild: CcBillSection(),
                  ),
                  SizedBox(height: screenHeight * 0.036), // instead of 30.h
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Unpinned',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                  CardSections(
                    title: 'Rewards (Condensed)',
                    dropdownChild: ProgressBarSection(),
                    stateProvider: dropdown4Provider,
                    showTriallingIcon: false,
                    isblueIcon: false,
                  ),
                  SizedBox(height: screenHeight * 0.012),
                  CardSections(
                    title: 'Rewards(Large)',
                    dropdownChild: RewardsLaregSection(),
                    stateProvider: dropdown5Provider,
                    showTriallingIcon: false,
                    isblueIcon: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
