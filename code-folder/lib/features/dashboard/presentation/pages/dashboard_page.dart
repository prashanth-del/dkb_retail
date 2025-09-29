import 'dart:math';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/dashboard/presentation/controllers/dashboard_controllers.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/animated_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/colors.dart';
import '../widgets/content_card.dart';
import '../widgets/dashboard_appbar.dart';

/// Dashboard main screen
@RoutePage()
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Theme colors
    const Color highlightText = Colors.white;
    const Color primaryBackground = Color(0xFF1E356A);
    const Color secondaryBackground = Colors.white;
    final selectedCurrency = ref.watch(selectedCurrencyProvider);
    return Scaffold(
      body: Container(
        width: size.width,

        height: size.height,
        decoration: BoxDecoration(
          gradient: DefaultColors.primaryBackgroundGradient,
        ),
        child: Stack(
          children: [
            Lottie.asset(
              AssetPath.lottie.animatedCircleBg,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: AnimatedContainer(
                padding: EdgeInsets.zero,
                duration: Duration(milliseconds: 500),

                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 375),
                child: Opacity(
                  opacity: 1,
                  child: Lottie.asset(
                    AssetPath.lottie.dotPatternAnimation,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                  buildAppBar(highlightText, size, context),

                  _buildCurrencyTabs(
                    highlightText,
                    primaryBackground,
                    secondaryBackground,
                    size,
                  ),
                  SizedBox(height: size.height * 0.06),
                  AnimatedBalance(
                    finalBalance: 123413,
                    currency: selectedCurrency,
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildViewAccountsButton(
                    highlightText,
                    primaryBackground,
                    secondaryBackground,
                    size,
                  ),
                  SizedBox(height: size.height * 0.06),
                  buildContentCard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Currency tabs (chips)
  Widget _buildCurrencyTabs(
    Color highlightText,
    Color primaryBackground,
    Color secondaryBackground,
    Size size,
  ) {
    final List<String> currencyTabs = [
      'QAR',
      'Dollar',
      'Pounds',
      'Aus Dollars',
    ];
    final selectedCurrency = ref.watch(selectedCurrencyProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: SizedBox(
        height: size.height * 0.05,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: currencyTabs.length,
          itemBuilder: (context, index) {
            final isSelected = currencyTabs[index] == selectedCurrency;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: _CustomChip(
                ontap: () {
                  ref.read(selectedCurrencyProvider.notifier).state =
                      currencyTabs[index];
                },
                label: currencyTabs[index],
                isSelected: isSelected,
                highlightText: highlightText,
                primaryBackground: primaryBackground,
                secondaryBackground: secondaryBackground,
                size: size,
              ),
            );
          },
        ),
      ),
    );
  }

  /// Balance section with visibility toggle
  Widget _buildBalanceSection(Color highlightText, Size size) {
    return Column(
      children: [
        Text(
          'Total Balance',
          style: TextStyle(color: highlightText, fontSize: size.width * 0.04),
        ),
        SizedBox(height: size.height * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '86679',
              style: TextStyle(
                color: highlightText,
                fontSize: size.width * 0.12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' £',
              style: TextStyle(
                color: highlightText,
                fontSize: size.width * 0.08,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Icon(
              Icons.visibility_off,
              color: highlightText,
              size: size.width * 0.06,
            ),
          ],
        ),
      ],
    );
  }

  /// Button to view all accounts
  Widget _buildViewAccountsButton(
    Color highlightText,
    Color primaryBackground,
    Color secondaryBackground,
    Size size,
  ) {
    return InkWell(
      onTap: () {
        context.router.push(AccountsRoute());
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: secondaryBackground.withAlpha(40),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View all accounts',
              style: TextStyle(
                color: highlightText,
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Icon(
              Icons.arrow_forward,
              color: highlightText,
              size: size.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Chip for currency tabs
class _CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color highlightText;
  final Color primaryBackground;
  final Color secondaryBackground;
  final Size size;
  final Function()? ontap;

  const _CustomChip({
    required this.label,
    required this.isSelected,
    required this.highlightText,
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.size,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? primaryBackground : highlightText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: size.width * 0.035,
          ),
        ),
        backgroundColor: isSelected
            ? secondaryBackground
            : primaryBackground.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
