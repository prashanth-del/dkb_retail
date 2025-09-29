import 'package:flutter/material.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import '../../../common/styles/ui_text_styles.dart';
import '../../data/model/transfer_model.dart';
import '../provider/transfer_provider.dart';
import '../widgets/bottom_sheet/confirm_transaction_sheet.dart';

class WesternUnionPage extends ConsumerStatefulWidget {
  final String title;

  const WesternUnionPage({Key? key, required this.title, required onSubmit}) : super(key: key);

  @override
  ConsumerState<WesternUnionPage> createState() => _WesternUnionPageState();
}

class _WesternUnionPageState extends ConsumerState<WesternUnionPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController mtcnController = TextEditingController();
  final TextEditingController transactionSeqController = TextEditingController();
  bool showTransactionStatus = false;

  void _onSubmit() {
    setState(() {
      showTransactionStatus = true;
    });
  }

  void _showTransactionBottomSheet() {
    final selectedTransfer = ref.read(selectedTransferProvider);
    final transactionDetails =
    TransactionHelper.getTransactionDetails(selectedTransfer, isNextPage: false);

    viewBottomSheet(
      context: context,
      title: "Transaction Status",
      heightPercentage: 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ConfirmTransactionSheet(
          transferType: "Western Union Money Transfer",
          transactionDetails: transactionDetails,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  isEndDate: false,
                  selectedDate: _startDate,
                  label: "From Date",
                  initialDate: _startDate ?? DateTime.now(),
                  showPicker: true,
                  borderColor: DefaultColors.grayE6,
                  suffixIcon: UISvgIcon(assetPath: SvgAssets().calendar),
                  onDateSelected: (date) {
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                      });
                    }
                  },
                ),
              ),
              UiSpace.horizontal(10),
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  isEndDate: true,
                  selectedDate: _endDate,
                  label: "To Date",
                  initialDate: _endDate ?? (_startDate ?? DateTime.now()),
                  showPicker: true,
                  borderColor: DefaultColors.grayE6,
                  suffixIcon: UISvgIcon(assetPath: SvgAssets().calendar),
                  onDateSelected: (date) {
                    if (date != null) {
                      setState(() {
                        _endDate = date;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          UiSpace.vertical(10),
          _buildInput(label: "MTCN", hint: "Enter MTCN", controller: mtcnController),
          _buildInput(
            label: "Transaction Sequence Number",
            hint: "Enter Transaction Sequence Number",
            controller: transactionSeqController,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
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
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.b1Medium("Transaction Status"),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showTransactionBottomSheet,
                      child: UiCard(
                        cardColor: DefaultColors.blue_light_03,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UiTextNew.h5Regular("MTCN", color: DefaultColors.grey),
                                  UiTextNew.h5Regular("Transaction Seq No.", color: DefaultColors.grey),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UiTextNew.b14Medium("1234543234"),
                                  UiTextNew.b14Medium("123456"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          borderColor: DefaultColors.grayE6,
          labelUiText: UiTextNew.b2Semibold(label),
          hintText: hint,
          controller: controller,
          textStyle: UiTextStyles.uiInfoTitleSmallBold(context)
              ?.copyWith(color: DefaultColors.gray2D),
        ),
        UiSpace.vertical(10),
      ],
    );
  }
}
