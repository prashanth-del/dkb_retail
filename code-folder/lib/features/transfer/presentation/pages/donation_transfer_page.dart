import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:dkb_retail/features/transfer/presentation/provider/transfer_provider.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/bottom_sheet/confirm_transaction_sheet.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/transfer_success_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class DonationTransferPage extends ConsumerStatefulWidget {
  final String title;

  const DonationTransferPage({super.key, required this.title});

  @override
  ConsumerState<DonationTransferPage> createState() =>
      _DonationTransferPageState();
}

class _DonationTransferPageState extends ConsumerState<DonationTransferPage> {
  String? _selectedToAccount;
  TextEditingController donationType = TextEditingController();
  TextEditingController donationAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedTransfer = ref.watch(selectedTransferProvider);

    Widget body;

    switch (widget.title) {
      case 'Donations':
        body = _buildDonationPage(selectedTransfer);
        break;
      case "transfer_success_page":
        body = TransactionSuccessPage(
          transactionDetails: TransactionHelper.getTransactionDetails(
            selectedTransfer,
            isNextPage: true,
          ),
        );
        break;
      default:
        body = Center(child: UiTextNew.b14Semibold("Invalid Module"));
    }

    return WillPopScope(
      onWillPop: () async {
        if (widget.title == "Donations") {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: UIAppBar.secondary(
          title: "Donations",
          autoLeadingWidget: widget.title == "Donations"
              ? AutoLeadingWidget()
              : null,
        ),
        body: body,
      ),
    );
  }

  Widget _buildDonationPage(TransferSelection? selectedTransfer) {
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInput(
                    label: "Select type of Donation",
                    hint: "Please Select",
                    controller: donationType,
                    isDropdown: true,
                    isEnabled: false,
                    dropDownLabel: "Select Type of Donation",
                    dropheightPercentage: .18,
                    sheetWidget: UiCard(
                      cardColor: DefaultColors.blue_02,
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        donationType.text = "Qatar Red Crescent";
                        context.maybePop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            UiTextNew.b1Medium(
                              "Qatar Red Crescent",
                              color: DefaultColors.primaryBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const UiSpace.vertical(20),
                  UiTextNew.h4Medium(DefaultString.instance.fromAccount),
                  UiDropdown(
                    items: [
                      UiDropdownValue(
                        value: 'Current Account',
                        labelText: 'Current Account 202-234567-4-1-90-0',
                      ),
                      UiDropdownValue(
                        value: 'Savings Account',
                        labelText: 'Savings Account 202-234567-4-1-90-0',
                      ),
                    ],
                    height: 50,
                    hintText: DefaultString.instance.plsSelect,
                    selectedValue: _selectedToAccount,
                    onChanged: (val) {
                      setState(() {
                        _selectedToAccount = val;
                      });
                    },
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Available Balance : ",
                      style: const UiTextNew.h5Regular("")
                          .getTextStyle(context)
                          .copyWith(color: DefaultColors.gray53),
                      children: [
                        TextSpan(
                          text: "QAR 50,000.00",
                          style: const UiTextNew.h4Medium("")
                              .getTextStyle(context)
                              .copyWith(color: DefaultColors.blue88),
                        ),
                      ],
                    ),
                  ),
                  const UiSpace.vertical(20),
                  _buildInput(
                    label: DefaultString.instance.donationAmount,
                    hint: "Please Enter",
                    controller: donationAmount,
                    isPrefix: true,
                  ),
                ],
              ),
            ),
          ),

          // buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: UIButton.rounded(
                    maxWidth: context.screenWidth / 2.5,
                    onPressed: () {
                      viewBottomSheet(
                        context: context,
                        title: "Confirm Transactions",
                        heightPercentage: 0.35,
                        child: ConfirmTransactionSheet(
                          transferType: "donation",
                          transactionDetails:
                              TransactionHelper.getTransactionDetails(
                                selectedTransfer,
                                isNextPage: false,
                              ),
                        ),
                      );
                    },
                    label: "NEXT",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isDropdown = false,
    bool isEnabled = true,
    bool isPrefix = false,
    String dropDownLabel = "",
    double? dropheightPercentage,
    ValueChanged<String>? onChanged,
    Widget? suffixIcon,
    Widget sheetWidget = const SizedBox.shrink(),
  }) {
    TextStyle? textStyle = UiTextStyles.uiInfoTitleSmallBold(
      context,
    )?.copyWith(color: DefaultColors.gray2D);

    bool fieldEnabled = !isEnabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          borderColor: DefaultColors.grayE6,
          labelUiText: UiTextNew.b2Semibold(label),
          // maxLine: maxLines,
          readOnly: fieldEnabled,
          hintText: hint,
          validator: (value) {},
          suffixIcon:
              suffixIcon ??
              (isDropdown
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: DefaultColors.blue_300,
                        size: 20,
                      ),
                    )
                  : null),
          prefixIcon: isPrefix
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: UiTextNew.h4Medium(
                          'QAR',
                          color: DefaultColors.grayB3,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          onChanged: (value) {
            onChanged?.call(value);
          },
          textStyle: textStyle,
          controller: controller,
          onTap: () {
            if (isDropdown) {
              viewBottomSheet(
                context: context,
                title: dropDownLabel,
                heightPercentage: dropheightPercentage,
                child: sheetWidget,
              );
            }
          },
        ),
      ],
    );
  }
}
