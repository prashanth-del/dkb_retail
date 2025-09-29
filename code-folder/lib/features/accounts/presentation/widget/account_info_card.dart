import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/account_dashboard_shimmer.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/account_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../dashboard/presentation/widgets/total_avail_bal_card.dart';
import '../../data/model/account_summary_model.dart';
import '../../domain/entity/account_summary_entity.dart';
import '../controller/notifier/account_summary_notifier.dart';
import '../pages/accounts_page.dart';
import 'account_card.dart';

class AccountInfoCardWidget extends ConsumerStatefulWidget {
  final VoidCallback? onAccountTap;

  const AccountInfoCardWidget({
    super.key,
    this.onAccountTap, // Accepts a callback for account tap actions
  });

  @override
  ConsumerState<AccountInfoCardWidget> createState() =>
      _AccountInfoCardWidgetState();
}

class _AccountInfoCardWidgetState extends ConsumerState<AccountInfoCardWidget> {
  @override
  Widget build(BuildContext context) {
    final accountSummary = ref.watch(getAccountSummaryProvider);
    return accountSummary.when(
      data: (data) => _buildAccountSummaryCard(data),
      error: (error, _) => _buildErrorContent(error),
      loading: () => const AccountDashboardShimmer(),
    );
  }

  Widget _buildAccountSummaryCard(AccountSummaryEntity data) {
    // Format account details
    List<Widget> column = data.accountDetails.asMap().entries.map((entry) {
      int index = entry.key;
      var account = entry.value;
      return Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
        child: Column(
          children: [
            AccountTile(account: account),
            const UiSpace.vertical(10),
            Flexible(child: formatAccount(account, index)),
            const UiSpace.vertical(20),
          ],
        ),
      );
    }).toList();

    return UiSwiper<Widget>.swiper3(
      elements: column,
      itemBuilder: (context, index) {
        return column[index];
      },
      height: context.screenHeight / 3,
    );
    return Container();

    // return TotalAvailBalCard(
    //   title: 'Total Account Balance',
    //   currency: data.totalAvailBalance[0]['currencyName'] ?? "QAR",
    //   balance: data.totalAvailBalance[0]['amt'],
    //   isBalanceVisible: false,
    //   accountData: formattedAccounts,
    //   onToggleVisibility: (isVisible) {
    //
    //   },
    // );
  }

  Widget _buildErrorContent(dynamic error) {
    final i18Description = ref.getLocaleString(
      "Please_try_again_later",
      defaultValue: "Please try again later",
    );
    return Column(
      children: [
        const UiSpace.vertical(60),
        UiServerError(
          lottieAssetPath: AssetPath.lottie.empty,
          errorMessage: error.toString(),
          description: i18Description,
        ),
        const UiSpace.vertical(20),
      ],
    );
  }

  AccountCard formatAccount(AccountDetailsA account, int index) {
    return AccountCard(
      accountType: account.accountType,
      accountNumber: account.accountNum,
      balance: account.availableBal,
      currency: account.currencyName,
      onTap: widget.onAccountTap,
      index: index,
    );
  }
}
