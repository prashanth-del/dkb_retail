import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../widgets/ui_currency_card/transaction_card.dart';

class LocalFundTransferPage extends ConsumerStatefulWidget {
  final String title;
  final TransferType transferType;

  const LocalFundTransferPage({
    Key? key,
    required this.title,
    required this.transferType,
  }) : super(key: key);

  @override
  ConsumerState<LocalFundTransferPage> createState() =>
      _LocalFundTransferPageState();
}

enum TransferType { localBank, cardlessWithdrawal, international, masterCard }

class _LocalFundTransferPageState extends ConsumerState<LocalFundTransferPage> {
  final TextEditingController referenceController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  bool showTransactionStatus = false;
  List<Map<String, dynamic>> transactions = [];

  Future<void> _selectDate(BuildContext context, bool isEndDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isEndDate) {
          _endDate = picked;
        } else {
          _startDate = picked;
        }
      });
    }
  }

  void _onSubmit() {
    setState(() {
      showTransactionStatus = true;
      transactions = _getTransactionsForType(widget.transferType);
    });
  }

  List<Map<String, dynamic>> _getTransactionsForType(TransferType type) {
    List<Map<String, dynamic>> txnList = [];
    switch (type) {
      case TransferType.localBank:
        txnList = [
          {"name": "Krishna Ketan Nagu", "amount": "1,000,000.00 QAR", "status": "Transfer request sent to Beneficiary Bank", "date": "31 Dec, 2023", "color": "orange"},
          {"name": "Abdul Sayed Pothu Kan...", "amount": "830.45 QAR", "status": "Successful", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Test UserA", "amount": "830.45 QAR", "status": "Failed", "date": "31 Dec, 2023", "color": "red"},
        ];
        break;
      case TransferType.cardlessWithdrawal:
        txnList = [
          {"name": "Mobile No : 99210984", "amount": "1,000,000.00 QAR", "status": "Success", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Mobile No : 99210984", "amount": "830.45 QAR", "status": "Success", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Mobile No : 99210984", "amount": "830.45 QAR", "status": "Success", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Mobile No : 99210984", "amount": "830.45 QAR", "status": "Failed", "date": "31 Dec, 2023", "color": "red"},
        ];
        break;
      case TransferType.international:
        txnList = [
          {"bank": "Dukhan Bank", "name": "Abdul Sayed Pothu Kan...", "amount": "830.45 INR", "status": "Approved", "date": "31 Dec, 2023", "color": "green"},
          {"bank": "Dukhan Bank", "name": "Abdul Sayed Pothu Kan...", "amount": "830.45 INR", "status": "Approved", "date": "31 Dec, 2023", "color": "green"},
          {"bank": "Dukhan Bank", "name": "Abdul Sayed Pothu Kan...", "amount": "830.45 INR", "status": "Processed by Dukhan Bank", "date": "31 Dec, 2023", "color": "orange"},
        ];
        break;
      case TransferType.masterCard:
        txnList = [
          {"name": "Krishna Ketan Nagu", "amount": "1,000,000.00 QAR", "status": "Transfer request sent to Beneficiary Bank", "date": "31 Dec, 2023", "color": "orange"},
          {"name": "Abdul Sayed Pothu Kan...", "amount": "830.45 QAR", "status": "Successful", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Ahmed Ansari", "amount": "830.45 QAR", "status": "Successful", "date": "31 Dec, 2023", "color": "green"},
          {"name": "Test UserA", "amount": "830.45 QAR", "status": "Failed", "date": "31 Dec, 2023", "color": "red"},
        ];
        break;
    }
    return txnList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInput(
            context,
            label: "Reference Number",
            hint: "Enter Reference Number",
            controller: referenceController,
          ).vertical(10),
          Row(
            children: [
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  selectedDate: _startDate,
                  isEndDate: false,
                  showPicker: true,
                  borderColor: DefaultColors.grayE6,
                  suffixIcon: UISvgIcon(assetPath: SvgAssets().calendar),
                  onDateSelected: (date) {
                    setState(() {
                      _startDate = date;
                    });
                  },
                ),
              ),
              const UiSpace.horizontal(10),
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  isEndDate: true,
                  selectedDate: _endDate,
                  showPicker: true,
                  borderColor: DefaultColors.grayE6,
                  suffixIcon: UISvgIcon(assetPath: SvgAssets().calendar),
                  onDateSelected: (date) {
                    setState(() {
                      _endDate = date;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: UIButton.rounded(
                  maxWidth: double.infinity,
                  onPressed: _onSubmit,
                  label: "SUBMIT",
                  txtColor: DefaultColors.primaryBlue,
                  backgroundColor: DefaultColors.blue_02,
                ),
              ),
            ],
          ),
          if (showTransactionStatus) ...[
            UiCard(
              cardColor: DefaultColors.white,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.b1Medium("Transaction Status"),
                    const SizedBox(height: 10),
                    ...transactions.map((transaction) {
                      return TransactionCard(
                        transferType: widget.transferType,
                        bank: widget.transferType == TransferType.international ? transaction["bank"] : null,
                        name: transaction["name"],
                        amount: transaction["amount"],
                        status: transaction["status"],
                        date: transaction["date"],
                        color: transaction["color"],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
Widget _buildInput(BuildContext context, {
  required String label,
  required String hint,
  required TextEditingController controller,
  Widget? suffixIcon,
  VoidCallback? onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      UIFormTextField.outlined(
        borderColor: DefaultColors.grayE6,
        labelUiText: UiTextNew.b2Semibold(label),
        hintText: hint,
        suffixIcon: suffixIcon,
        controller: controller,
        textStyle: UiTextStyles.uiInfoTitleSmallBold(context)?.copyWith(color: DefaultColors.gray2D),
        readOnly: onTap != null,
        onTap: onTap,
      ),
      UiSpace.vertical(10),
    ],
  );
}
