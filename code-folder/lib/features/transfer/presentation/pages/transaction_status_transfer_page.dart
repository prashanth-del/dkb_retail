import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:dkb_retail/features/transfer/presentation/pages/western_union_page.dart';

import 'local_fund_transfer.dart';

@RoutePage()
class TransactionStatusTransferPage extends StatefulWidget {
  final String moduleId;

  const TransactionStatusTransferPage({super.key, required this.moduleId});

  @override
  State<TransactionStatusTransferPage> createState() =>
      _TransactionStatusTransferPageState();
}

class _TransactionStatusTransferPageState
    extends State<TransactionStatusTransferPage> {
  @override
  Widget build(BuildContext context) {
    Widget? body;

    switch (widget.moduleId) {
      case 'Another Local Bank':
        body = LocalFundTransferPage(
          title: "",
          transferType: TransferType.localBank, // onSubmit: () {
          //   // Handle submit action here
          //   print("Submit button pressed!");
          // },
        );
        break;

      case 'D-Cardless Withdrawal':
        body = LocalFundTransferPage(
          title: "",
          transferType: TransferType.cardlessWithdrawal,
        );

        // body = Center(child: UiTextNew.b14Semibold("Invalid Module"));
        break;
      case 'International Transfer':
        body = LocalFundTransferPage(
          title: "",
          transferType: TransferType.international,
        );

        // body = Center(child: UiTextNew.b14Semibold("Invalid Module"));
        break;

      case 'Western Union Money Transfer':
        body = WesternUnionPage(title: "", onSubmit: () {});
        // body = Center(child: UiTextNew.b14Semibold("Invalid Module"));
        break;
      case 'Master Card Transfer':
        body = LocalFundTransferPage(
          title: "",
          transferType: TransferType.masterCard,
        );
        break;
      default:
      // body = Center(child: UiTextNew.b14Semibold("Invalid Module"));
    }

    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: UIAppBar.secondary(
        title: widget.moduleId,
        autoLeadingWidget: AutoLeadingWidget(),
      ),
      body: body,
    );
  }
}
