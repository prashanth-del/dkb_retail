import 'package:dkb_retail/features/accounts/presentation/pages/account_page.dart';
import 'package:dkb_retail/features/cards/presentation/pages/cards_dashboard_page.dart';
import 'package:dkb_retail/features/deposits/presentation/pages/deposit_dashboard_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../accounts/presentation/pages/account_dashboard_page.dart';
import '../../../loans/presentation/pages/loan_dashboard_page.dart';
import 'dash_module_info.dart';
import 'default_dash_modules.dart';

final moduleDashMapProvider = Provider<Map<String, DashModuleInfo>>((ref) {
  return {
    DefaultDashModules.account: DashModuleInfo(
      id: DefaultDashModules.account,
      fallbackLabel: 'Accounts',
      i18nKey: 'Accounts',
      route: const AccountsDashboardPage(),
      onSelected: () async {
        // await ref.read(getAccountSummaryProvider.notifier).fetch();
        // await ref.read(getPendingApprovalNotifierProvider.notifier).fetch();
        // await ref.read(getCompletedTransactionNotifierProvider.notifier).fetch();
      },
    ),
    DefaultDashModules.card: DashModuleInfo(
      id: DefaultDashModules.card,
      fallbackLabel: 'Cards',
      i18nKey: 'Cards',
      route: const CardsDashboardPage(),
      onSelected: () {
        // ref.read(getCardSummaryProvider.notifier).fetch();
      },
    ),
    DefaultDashModules.loan: DashModuleInfo(
      id: DefaultDashModules.card,
      fallbackLabel: 'Loans',
      i18nKey: 'Loans',
      route: const LoanDashboardPage(),
      onSelected: () {},
    ),
    DefaultDashModules.deposit: DashModuleInfo(
      id: DefaultDashModules.card,
      fallbackLabel: 'Deposits',
      i18nKey: 'Deposits',
      route: DepositDashboardPage(),
      onSelected: () {},
    ),
  };
});
