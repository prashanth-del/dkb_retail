import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:dkb_retail/features/transfer/presentation/provider/transfer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class TransactionStatusSheet extends ConsumerWidget {
  const TransactionStatusSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: DefaultColors.white_0,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            title: UiTextNew.b1Semibold("Transaction Status"),
            trailing: UIIconContainer(
              icon: Icons.close,
              color: DefaultColors.transparent,
              iconColor: DefaultColors.black,
              iconSize: 18,
              onTap: () => context.router.maybePop(),
            ),
          ),
          const Divider(color: DefaultColors.blue_02, thickness: 1),
          const SizedBox(height: 10),
          _buildTransactionItem('assets/icons/another_bank.svg',
              "Another Local Bank", context, ref),
          _buildTransactionItem(
              'assets/icons/cashless.svg', "D-Cardless Withdrawal",context,ref),
          const Divider(color: DefaultColors.blue_02, thickness: 1, height: 20),
          _buildTransactionItem(
              'assets/icons/earth.svg', "International Transfer", context,ref ),
          _buildTransactionItem('assets/icons/western_union.svg', "Western Union Money Transfer", context,ref),
          _buildTransactionItem(
              'assets/icons/master_card.svg', "Master Card Transfer", context,ref),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      String assetPath, String title, BuildContext context,ref
    ) {
    return GestureDetector(
      onTap: () {
        context.router.push( TransactionStatusTransferRoute(moduleId:title ));
       if (title =="Western Union Money Transfer")
         ref.read(selectedTransferProvider.notifier).state =
            TransferSelection(classification: "Western Union Money Transfer", index: 0);
      },
      child: UiCard(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        borderRadius: BorderRadius.circular(8),
        cardColor: DefaultColors.bluelight04,
        child: _buildCardContent(assetPath, title),
      ),
    );
  }

  Widget _buildCardContent(String assetPath, String title) {
    return Row(
      children: [
        UISvgIcon(assetPath: assetPath, height: 24, width: 24),
        const SizedBox(width: 10),
        UiTextNew.b14Medium(title),
      ],
    );
  }
}
