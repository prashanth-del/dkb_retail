import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/common/components/info_card.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/bottom_sheet/confirm_transaction_sheet.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/bottom_sheet/pay_later_bottom_sheet.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/transfer_success_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../data/model/beneficiary_model.dart';
import '../provider/transfer_provider.dart';
import '../widgets/ben_pciker_sheet.dart';
import '../widgets/ift_transfer_page2.dart';

@RoutePage()
class TransferAmountPage extends ConsumerStatefulWidget {
  final String title;
  final BeneficiaryModel? beneficiary;
  final bool purpose;
  final List<String> info;
  final bool displayBank;
  final bool displayIfsc;
  final bool displayAccountNum;
  final bool showFlag;
  final bool showBenRelation;
  final bool showSendLater;
  final bool showRemit;
  final bool showSendAmount;
  final bool showGetAmount;
  const TransferAmountPage({
    super.key,
    required this.title,
    this.beneficiary,
    this.purpose = false,
    this.info = const <String>[],
    this.displayBank = false,
    this.displayIfsc = false,
    this.showBenRelation = false,
    this.displayAccountNum = true,
    this.showFlag = false,
    this.showSendLater = false,
    this.showRemit = false,
    this.showSendAmount = false,
    this.showGetAmount = false,
  });

  @override
  ConsumerState<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends ConsumerState<TransferAmountPage> {
  String? _selectedFromAccount;
  String? _selectedToAccount;
  String? _selectedPurpose;
  String? _selectedRelation;
  String? _selectedRemittance;
  BeneficiaryModel? selectedBeneficiary;
  List<BeneficiaryModel> beneficiaries = [];
  List<UiDropdownValue> filteredItems = [];

  // List<String> list = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String? _purpose;
  String? _fund;

  @override
  void initState() {
    if (widget.beneficiary != null) {
      _loadBen();
    }
    super.initState();
  }

  Future<void> _loadBen() async {
    selectedBeneficiary = widget.beneficiary;
    beneficiaries = await BeneficiaryModel.loadDummyBeneficiaries();
    setState(() {});
  }

  _buildSendTo() {
    final List<UiDropdownValue> dropdownItems = [
      UiDropdownValue(
        value: 'Current Account 202-234567-4-1-90-0',
        labelText: 'Current Account 202-234567-4-1-90-0',
      ),
      UiDropdownValue(
        value: 'Savings Account 202-234567-4-1-90-0 ',
        labelText: 'Savings Account 202-234567-4-1-90-0',
      ),
      UiDropdownValue(
        value: 'Current Account 202-234567-4-1-90-0 ',
        labelText: 'Current Account 202-234567-4-1-90-0',
      ),
      UiDropdownValue(
        value: 'Savings Account 202-234567-4-1-90-0',
        labelText: 'Savings Account 202-234567-4-1-90-0',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Medium(DefaultString.instance.sendTo),
        UiDropdown(
          items: dropdownItems,
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedFromAccount,
          onChanged: (val) {
            setState(() {
              _selectedFromAccount = val;

              // Find the index of the selected item
              final int selectedIndex = dropdownItems.indexWhere(
                (item) => item.value == val,
              );

              if (selectedIndex != -1) {
                final selectedItem = dropdownItems[selectedIndex];
                ref
                    .read(transactionProvider.notifier)
                    .updateTransaction(fromAccount: selectedItem.value);
              }
            });
          },
        ),
      ],
    );
  }

  _buildBenPicker() async {
    BeneficiaryModel? ben = await UIPopupDialog<BeneficiaryModel>()
        .showBottomSheet(
          context: context,
          child: BeneficiaryPickerSheet(
            beneficiaryList: beneficiaries,
            hintText: DefaultString.instance.searchBen,
            title: DefaultString.instance.selectBen,
            isFlag: widget.showFlag,
            displayBank: widget.displayBank,
            displayAccountNum: widget.displayAccountNum,
            displayIfsc: widget.displayIfsc,
            showAdd: false,
          ),
        );

    if (ben != null && mounted) {
      selectedBeneficiary = ben;
      setState(() {});
    }
  }

  _buildBeneficiary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Medium(DefaultString.instance.beneficiary),
        ListTile(
          tileColor: DefaultColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: const Color(0xFF00539D).withOpacity(0.2)),
          ),
          leading: widget.showFlag
              ? CircleAvatar(
                  radius: 24,
                  child: Center(
                    child: Image.asset(
                      "assets/images/flags/${selectedBeneficiary!.flag.flag}",
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 24,
                  backgroundColor: DefaultColors.blue_02,
                  child: Center(
                    child: UiTextNew.h4Medium(
                      selectedBeneficiary!.name[0],
                      color: DefaultColors.blue88,
                    ),
                  ),
                ),
          title: UiTextNew.h4Medium(selectedBeneficiary!.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.displayBank)
                UiTextNew.h5Regular(selectedBeneficiary!.bankName),
              if (widget.displayIfsc)
                UiTextNew.h5Regular(selectedBeneficiary!.ifsc),
              if (widget.displayAccountNum)
                UiTextNew.h5Regular(selectedBeneficiary!.accountNumber),
            ],
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.keyboard_arrow_down,
                size: 25,
                color: Color(0xFF00529B),
              ),
            ],
          ),
          onTap: _buildBenPicker,
        ),
      ],
    );
  }

  _buildPurpose() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.purpose),
        UiDropdown(
          items: [
            UiDropdownValue(value: 'School Fees', labelText: 'School Fees'),
            UiDropdownValue(value: 'Holiday', labelText: 'Holiday / Vacation'),
            UiDropdownValue(value: 'Rent', labelText: 'Rent'),
            UiDropdownValue(value: 'Buy', labelText: 'Medical'),
          ],
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedPurpose,
          onChanged: (val) {
            setState(() {
              _selectedPurpose = val;
            });
          },
        ),
      ],
    );
  }

  _buildInfo() {
    return Column(
      children: [
        const UiSpace.vertical(20),
        InfoCard(title: "", descriptions: widget.info),
      ],
    );
  }

  _buildBenRelation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.benRelation),
        UiDropdown(
          items: [
            UiDropdownValue(value: 'Father', labelText: 'Father'),
            UiDropdownValue(value: 'Mother', labelText: 'Spouse'),
          ],
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedRelation,
          onChanged: (val) {
            setState(() {
              _selectedRelation = val;
            });
          },
        ),
      ],
    );
  }

  _buildRemit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.remitCurrency),
        UiDropdown(
          items: [
            UiDropdownValue(value: 'QAR', labelText: 'QAR - Qatari Riyal'),
            UiDropdownValue(value: 'INR', labelText: 'INR - Indian Rupees'),
          ],
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedRemittance,

          onChanged: (val) {
            setState(() {
              _selectedRemittance = val;
            });
          },
        ),
        Text.rich(
          TextSpan(
            text: "INR 1.00 = ",
            style: const UiTextNew.h4Medium(
              "",
            ).getTextStyle(context).copyWith(color: DefaultColors.gray53),
            children: [
              TextSpan(
                text: "QAR 0.041",
                style: const UiTextNew.h4Medium(
                  "",
                ).getTextStyle(context).copyWith(color: DefaultColors.blue88),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSendAmount({bool isSender = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(
          isSender
              ? DefaultString.instance.youSend
              : DefaultString.instance.recGet,
        ),
        UIFormTextField.outlined(
          hintText: '0.0',
          controller: amountController,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, top: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: 10,
                    child: Center(
                      child: Image.asset(
                        isSender
                            ? "assets/images/flags/qa.png"
                            : "assets/images/flags/in.png",
                      ),
                    ),
                  ),
                ),
                const UiSpace.horizontal(2),
                Flexible(child: UiTextNew.h5Regular(isSender ? 'QAR' : 'INR')),
                const SizedBox(height: 30, child: VerticalDivider()),
              ],
            ),
          ),
          height: 50,
        ),
      ],
    );
  }

  bool isSendLater = false;

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(currentStepProvider);
    final selectedTransfer = ref.watch(selectedTransferProvider);

    Widget? leadingWidget;

    if (currentStep == 0 ||
        !(selectedTransfer?.classification == "ift" &&
            selectedTransfer?.index == 3)) {
      if (currentStep == 0 ||
          (currentStep == 1 &&
              selectedTransfer?.classification != "domestic")) {
        leadingWidget = UISvgIcon(
          assetPath: AssetPath.icon.leading,
          onTap: currentStep == 0
              ? () => Navigator.pop(context)
              : () => ref.read(currentStepProvider.notifier).state = 0,
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (currentStep == 0) {
          return true;
        } else if (currentStep == 1) {
          if (selectedTransfer?.classification == "domestic" ||
              (selectedTransfer?.classification == "ift" &&
                  selectedTransfer?.index == 3)) {
            return false;
          }
          ref.read(currentStepProvider.notifier).state = 0;
          return false;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: DefaultColors.white_f3,
        appBar: UIAppBar.secondary(
          title: widget.title,
          autoLeadingWidget: leadingWidget,
        ),
        body: _getPage(currentStep, selectedTransfer),
      ),
    );
  }

  Widget _getPage(int step, TransferSelection? selectedTransfer) {
    switch (step) {
      case 0:
        return _buildMainPage(selectedTransfer);
      case 1:
        return selectedTransfer?.classification == "ift"
            ? (selectedTransfer?.index == 3
                  ? TransactionSuccessPage(
                      transactionDetails:
                          TransactionHelper.getTransactionDetails(
                            selectedTransfer,
                            isNextPage: true,
                          ),
                    )
                  : IftTransferPage2())
            : TransactionSuccessPage(
                transactionDetails: TransactionHelper.getTransactionDetails(
                  selectedTransfer,
                  isNextPage: true,
                ),
              );
      case 2:
        return TransactionSuccessPage(
          transactionDetails: TransactionHelper.getTransactionDetails(
            selectedTransfer,
            isNextPage: true,
          ),
        );
      default:
        return _buildMainPage(selectedTransfer);
    }
  }

  Widget _buildPurposeofRemitance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.remittance),
        UiDropdown(
          items: [
            UiDropdownValue(value: 'Pilgrimage', labelText: 'Pilgrimage'),
            UiDropdownValue(
              value: 'School Fees',
              labelText: 'School Fees',
            ), // Added
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

  Widget _buildSourceFund() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UiSpace.vertical(20),
        UiTextNew.h4Medium(DefaultString.instance.Funds),
        UiDropdown(
          items: [
            UiDropdownValue(
              value: 'Personal Savings',
              labelText: 'Personal Savings',
            ),
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

  _buildMainPage(TransferSelection? selectedTransfer) {
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // from ac
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

                  // send to
                  const UiSpace.vertical(20),
                  if (selectedBeneficiary == null) _buildSendTo(),
                  if (selectedBeneficiary != null) _buildBeneficiary(),

                  // ben relation
                  if (selectedTransfer?.classification == 'ift' &&
                      (selectedTransfer?.index == 0 ||
                          selectedTransfer?.index == 1))
                    if (widget.showBenRelation) _buildBenRelation(),

                  // remit current
                  if (selectedTransfer?.classification == 'ift' &&
                      (selectedTransfer?.index == 0 ||
                          selectedTransfer?.index == 1))
                    if (widget.showRemit) _buildRemit(),
                  // you send
                  if (widget.showSendAmount) _buildSendAmount(),

                  // recipient get
                  if (widget.showGetAmount) _buildSendAmount(isSender: false),

                  // amount
                  if (!widget.showFlag) const UiSpace.vertical(20),
                  if (!widget.showFlag)
                    UiTextNew.h4Medium(DefaultString.instance.amount),
                  if (!widget.showFlag)
                    const UIFormTextField.outlined(
                      hintText: '0.0',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: UiTextNew.h5Regular('QAR')),
                            SizedBox(height: 30, child: VerticalDivider()),
                          ],
                        ),
                      ),
                      height: 50,
                    ),

                  // purpose
                  if (widget.purpose) _buildPurpose(),

                  // transaction remarks
                  if (!widget.showFlag) const UiSpace.vertical(20),
                  if (!widget.showFlag)
                    UiTextNew.h4Medium(DefaultString.instance.transRemark),
                  if (!widget.showFlag)
                    const UIFormTextField.outlined(
                      hintText: 'Remarks',
                      height: 50,
                    ),
                  if (selectedTransfer?.classification == 'ift' &&
                      (selectedTransfer?.index == 3)) ...[
                    _buildPurposeofRemitance(),
                    _buildSourceFund(),
                  ],
                  // info
                  if (widget.info.isNotEmpty) _buildInfo(),
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
                if (widget.showSendLater)
                  Expanded(
                    child: UIButton.rounded(
                      maxWidth: context.screenWidth / 2.5,
                      onPressed: () {
                        setState(() {
                          isSendLater = !isSendLater;
                        });

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => PayLaterBottomSheet(),
                        );
                      },
                      txtColor: DefaultColors.blue88,
                      backgroundColor: DefaultColors.blue_02,
                      label: DefaultString.instance.sendLater.toUpperCase(),
                    ),
                  ),
                if (widget.showSendLater) const UiSpace.horizontal(20),
                Expanded(
                  child: UIButton.rounded(
                    maxWidth: context.screenWidth / 2.5,
                    onPressed: () {
                      if ((selectedTransfer?.classification == "domestic"))
                        viewBottomSheet(
                          context: context,
                          title: "Confrim Transactions",
                          heightPercentage: 0.4,
                          child: ConfirmTransactionSheet(
                            transactionDetails:
                                TransactionHelper.getTransactionDetails(
                                  selectedTransfer,
                                ),
                          ),
                        );

                      if (selectedTransfer?.classification == "ift") {
                        if (selectedTransfer?.index == 3) {
                          viewBottomSheet(
                            context: context,
                            title: "Confirm Transactions",
                            heightPercentage: 0.6,
                            child: ConfirmTransactionSheet(
                              transferType: "ift",
                              isConfirm: true,
                              transactionDetails:
                                  TransactionHelper.getTransactionDetails(
                                    selectedTransfer,
                                    isNextPage: false,
                                  ),
                            ),
                          );
                        } else {
                          ref.read(currentStepProvider.notifier).state += 1;
                        }
                      }
                    },
                    label: (selectedTransfer?.classification == "domestic")
                        ? DefaultString.instance.sendNow.toUpperCase()
                        : "CONTINUE",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
