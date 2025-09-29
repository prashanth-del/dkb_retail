import 'package:dkb_retail/features/beneficiary/presentation/pages/add_beneficiary_transfer_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/router/app_router.dart';
import '../../../dashboard/presentation/controllers/dashboard_controllers.dart';
import 'default_modules.dart';
import 'module_info.dart';

final moduleMapProvider = Provider<Map<String, ModuleInfo>>((ref) {
  // final userRole = ref.read(userProfileProvider)?.userRole;
  // final isVerifier = userRole == UserRoleType.verifier;
  return {
    DefaultModules.dashboard: ModuleInfo(
      id: DefaultModules.dashboard,
      activeIcon: AssetPath.icon.bottomDashboardIcon,
      fallbackLabel: 'Dashboard',
      i18nKey: 'Dashboard',
      route: const DashboardRoute(),
      onSelected: () async {
        ref.read(activeDashBoardIndex.notifier).state = 0;
      },
    ),
    DefaultModules.approval: ModuleInfo(
      id: DefaultModules.approval,
      activeIcon: AssetPath.icon.bottomTransferIcon,
      fallbackLabel: "Transfer", // ? 'Verification' : 'Approvals',
      i18nKey: "Transfer", // ? 'Verification' : 'Approvals',
      route: const DashboardRoute(),
      onSelected: () async {
        // ref.read(activeTabIndex.notifier).state = 0;
        // await ref
        //     .read(approvalNotifierProvider.notifier)
        //     .fetchTransactionSummary(action: 'PENDING');
        // ref.read(checkBoxVisibilityProvider.notifier).state = false;
      },
    ),
    DefaultModules.account: ModuleInfo(
      id: DefaultModules.account,
      activeIcon: AssetPath.icon.bottomPayIcon,
      fallbackLabel: 'Pay',
      i18nKey: 'Pay',
      route: const DashboardRoute(),
      onSelected: () {
        // ref.read(getAccountSummaryProvider.notifier).fetch();
      },
    ),
    DefaultModules.card: ModuleInfo(
      id: DefaultModules.card,
      activeIcon: AssetPath.icon.bottomServicesIcon,
      fallbackLabel: 'Services',
      i18nKey: 'Services',
      route: const DashboardRoute(), //(canNavigate: false),
      onSelected: () {
        // ref.read(getCardSummaryProvider.notifier).fetch();
      },
    ),
    DefaultModules.exchangeRate: ModuleInfo(
      id: DefaultModules.exchangeRate,
      activeIcon: AssetPath.icon.bottomMenuIcon,
      fallbackLabel: 'Menu',
      i18nKey: 'Menu',
      route: const DashboardRoute(), //(canNavigate: false),
      onSelected: () {
        // ref.read(getExchangeRateNotifierProvider.notifier).fetch();
      },
    ),
  };
});
