
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:dkb_retail/features/transfer/presentation/provider/transfer_provider.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/bottom_sheet/confirm_transaction_sheet.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/ui_currency_card/currency_exchange_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import 'bottom_sheet/attach_bottom_sheet.dart';
import 'bottom_sheet/charge_type_bottom_sheet.dart';

class IftTransferPage2 extends ConsumerStatefulWidget {

  const IftTransferPage2({
    Key? key,

  }) : super(key: key);

  @override
  ConsumerState<IftTransferPage2> createState() => _IftTransferPage2State();
}

class _IftTransferPage2State extends ConsumerState<IftTransferPage2> {
  String? _purpose;
  String? _fund;
  final  TextEditingController transactionRemarks = TextEditingController();
  final TextEditingController chargeTypeController = TextEditingController();
  final TextEditingController attachController = TextEditingController();

  bool isFileUploaded = false;
  String uploadedText = "Click to attach";
  bool isPrefixAttach = true;
  bool isDropDownAttach = true;

  void _updateFile() {
    setState(() {
      uploadedText = "File Uploaded";
      attachController.text=uploadedText;
      isFileUploaded = true;
      isDropDownAttach=!isDropDownAttach;
      isPrefixAttach = !isPrefixAttach;
    });
  }

  void _deleteFile() {
    setState(() {
      uploadedText = "Click to attach";
      isFileUploaded = false;
      attachController.text="";
      isDropDownAttach=!isDropDownAttach;
      isPrefixAttach = !isPrefixAttach;
    });
  }

  @override
  Widget build(BuildContext context) {

    final selectedTransfer = ref.watch(selectedTransferProvider);
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCard(),
                    const UiSpace.vertical(10),
                    _buildPurpose(),
                    _buildSourceFund(),
                    if(selectedTransfer?.index==0)...{
                    _buildChargeType(),
                    },
                     UiSpace.vertical(10),
                    _buildInput(
                      label: "Transaction Remarks",
                      hint: "Please Enter",
                      controller: transactionRemarks,
                      isDropdown: false,
                    ),
                    const UiSpace.vertical(10),
                    if(selectedTransfer?.index==0)...
                    {
                    _buildAttachmentBox(),
                   },
                    const UiSpace.vertical(10),

                  ],
                ),

            ),
          ),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildPurpose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.remittance),
        UiDropdown(
          items: [
            UiDropdownValue(value: 'Pilgrimage', labelText: 'Pilgrimage'),
            UiDropdownValue(value: 'School Fees', labelText: 'School Fees'), // Added

          ],
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _purpose,
          onChanged: (val) {
            setState(() {
              _purpose = val;
            });
          },
        ),
      ],
    );
  }
  Widget _buildChargeType() {
    final chargeTypes = [
      {
        'title': 'All Charges Borne by Me',
        'description': 'All transfers charges will be recovered from your Account\nDukhan Bank charges QAR 15'
      },
      {
        'title': 'Split the Charges',
        'description': 'Dukhan Bank charges QAR 15 will be recovered from your account and correspondent bank charges will be from beneficiary'
      },
      {
        'title': 'All Charges Borne by Beneficiary',
        'description': 'All transfer charges will be recovered from beneficiary\nDukhan Bank charges QAR 15'
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInput(
          label: 'Charge Type',
          dropDownLabel: "Charge Type",
          dropheightPercentage: .50,
          hint: DefaultString.instance.plsSelect,
          controller: chargeTypeController,
          isDropdown: true,
          isEnabled: false,
          sheetWidget: ChargeTypeBottomSheet(
            chargeTypes: chargeTypes,
            onSelect: (selected) {
              setState(() {
                chargeTypeController.text = selected;
              });
            },
          ),
        ),
        const UiSpace.vertical(6),
        UiTextNew.custom(
          "All transfers charges will be recovered from your Account\nDukhan Bank charges QAR 15",
          fontSize: 12,
          color: Colors.grey,
        ),
      ],
    );
  }


  Widget _buildSourceFund() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.Funds),
        UiDropdown(
          items: [
            UiDropdownValue(
                value: 'Personal Savings', labelText: 'Personal Savings'),
            UiDropdownValue(value: 'Salary', labelText: 'Salary'),
          ],
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _fund,
          onChanged: (val) {
            setState(() {
              _fund = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCard() {
    return CurrencyExchangeCard(
      name: 'Ahmed Ansari',
      fromCurrency: 'QAR',
      toCurrency: 'CNY',
      fromFlag: 'QA',
      toFlag: 'CN',
      fromAmount: 90000.00,
      toAmount: 175360.03,
    );
  }


  Widget _buildAttachmentBox() {
    return _buildInput(
      label: "Attachments",
      dropDownLabel: "Choose an action",
      hint: "Click to attach",
      isPrefix: isPrefixAttach,
      controller: attachController,
      isDropdown: isDropDownAttach,
      dropheightPercentage: .20,
      isEnabled: false,
      sheetWidget: ActionSelectionSheet(
        onCameraTap: () {
          Navigator.pop(context);
          _updateFile();
        },
        onGalleryTap: () {
          Navigator.pop(context);
          _updateFile();
        },
        onPdfTap: () {
          Navigator.pop(context);
          _updateFile();
        },
      ),
      suffixIcon: isFileUploaded
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _deleteFile,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 10),
              child: Icon(
                Icons.delete_outline,
                color: DefaultColors.primaryBlue,
                size: 22,
              ),
            ),
          ),
        ],
      )
          : null,
    );
  }

  Widget _buildSendButton() {
    final selectedTransfer = ref.watch(selectedTransferProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:  UIButton.rounded(
        label: "SEND",
        backgroundColor: DefaultColors.blue_300,
        txtColor: Colors.white,
        maxWidth: double.infinity,
        onPressed: () {
          viewBottomSheet(
            context: context,
            title: "Confirm Transactions",
            heightPercentage: 0.6,
            child: ConfirmTransactionSheet(
              transferType :"ift",
              isConfirm: true,
              transactionDetails: TransactionHelper.getTransactionDetails(selectedTransfer,isNextPage: false),

            )
          );


        },
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isDropdown = false,
    bool isEnabled = true,
    bool isPrefix =false,
    String dropDownLabel="",
    double? dropheightPercentage,
    ValueChanged<String>? onChanged,
    VoidCallback? onReset,
    Widget? suffixIcon,
    Widget sheetWidget = const SizedBox.shrink(),
  }) {
    TextStyle? textStyle = UiTextStyles.uiInfoTitleSmallBold(context)
        ?.copyWith(color: DefaultColors.gray2D);


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
          suffixIcon: suffixIcon ??
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
          prefixIcon: isPrefix?
          Container(
            child: Icon(Icons.attach_file, color: DefaultColors.primaryBlue),
          )
              :null,
          onChanged: (value) {
            onChanged?.call(value);
            // _validateForm();
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
