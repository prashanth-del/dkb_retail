import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/beneficiary_country_picker.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/popUpDialog/Beneficiary_transfer_dialog.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:dkb_retail/features/transfer/data/model/beneficiary_model.dart';
import 'package:dkb_retail/features/transfer/data/model/flag_model.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/ben_pciker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Currency { btdTaka, inrRupee, sriRupee, usDollar, others }

class Page1 extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;
  const Page1({super.key, required this.onSubmit});

  @override
  ConsumerState<Page1> createState() => _Page1State();
}

class _Page1State extends ConsumerState<Page1> {
  final TextEditingController countryController = TextEditingController();
  String? _selectedFromCurrency;
  String? _selectedFromBeneType;
  String? _selectedFromBank;

  bool _showCurrencyDropdown() {
    return countryController.text == "Bangladesh" ||
        countryController.text == "Srilanka" ||
        countryController.text == "India";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              UiTextNew.b14Regular(
                ref.getLocaleString(
                  "Type_Fund_Transfer",
                  defaultValue: "Type of Fund Transfer",
                ),
                color: DefaultColors.gray8A,
              ),
            ],
          ),
          Row(
            children: [
              UiTextNew.b14Medium(
                ref.getLocaleString(
                  "International_Money_Transfer",
                  defaultValue: "International Money Transfer",
                ),
                color: DefaultColors.grayD2,
              ),
            ],
          ),
          const UiSpace.vertical(10),

          formCountry().vertical(10),
          if (countryController.text.isNotEmpty) ...[
            if (_showCurrencyDropdown()) _buildCurrencyDropdown(),
            if (_selectedFromCurrency == Currency.usDollar.toString() &&
                countryController.text == "Srilanka")
              _buildBankDropdown(),
            if (_selectedFromCurrency == Currency.btdTaka.toString() ||
                (_selectedFromCurrency == Currency.inrRupee.toString()) ||
                (_selectedFromCurrency == Currency.sriRupee.toString()) ||
                (_selectedFromBank == "1" &&
                    countryController.text == "Srilanka"))
              _buildBeneficiaryTypeDropdown(),
          ],

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: UIButton.rounded(
                    backgroundColor: DefaultColors.blue60,
                    onPressed: () {
                      if (countryController.text == "India") {
                        ref.read(isIndiaCountryProvider.notifier).state = true;
                      }
                      if (countryController.text == "Bangladesh" &&
                          Currency.others.toString() != _selectedFromCurrency) {
                        ref.read(isBangladeshCountryProvider.notifier).state =
                            true;
                      }
                      ref.read(isAddBeneficiaryProvider.notifier).state = true;
                      ref.read(cardResetProvider.notifier).state = false;
                      // if(_showCurrencyDropdown()){
                      //   ref.read(isAddBeneficiaryProvider.notifier).state = false;
                      //   BeneficiaryTransferDialog(context: context, ref: ref).show_swift_dialog(onTap: (){
                      //     context.maybePop();
                      //     widget.onSubmit();
                      //   });
                      // }

                      if (Currency.others.toString() == _selectedFromCurrency ||
                          (!_showCurrencyDropdown())) {
                        ref.read(isAddBeneficiaryProvider.notifier).state =
                            false;
                        BeneficiaryTransferDialog(
                          context: context,
                          ref: ref,
                        ).show_swift_dialog(
                          onTap: () {
                            context.maybePop();
                            widget.onSubmit();
                          },
                        );
                      } else {
                        widget.onSubmit();
                      }
                    },
                    // isDisabled: widget.buttonEnabled,
                    height: 40,
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

  Widget _buildCurrencyDropdown() {
    Map<String, List<UiDropdownValue>> countryCurrencyMap = {
      "Bangladesh": [
        UiDropdownValue(
          value: Currency.btdTaka.toString(),
          labelText: 'BTD - Bangladeshi Taka',
        ),
        UiDropdownValue(value: Currency.others.toString(), labelText: 'Others'),
      ],
      "India": [
        UiDropdownValue(
          value: Currency.inrRupee.toString(),
          labelText: 'INR - Indian Rupee',
        ),
        UiDropdownValue(value: Currency.others.toString(), labelText: 'Others'),
      ],
      "Srilanka": [
        UiDropdownValue(
          value: Currency.sriRupee.toString(),
          labelText: 'LKR - Sri Lankan Rupee',
        ),
        UiDropdownValue(
          value: Currency.usDollar.toString(),
          labelText: 'USD - United States Dollar',
        ),
        UiDropdownValue(value: Currency.others.toString(), labelText: 'Others'),
      ],
    };

    List<UiDropdownValue> currencyItems =
        countryCurrencyMap[countryController.text] ?? [];

    return Column(
      children: [
        const UiSpace.vertical(10),
        Row(children: [UiTextNew.h4Medium(DefaultString.instance.currency)]),
        UiDropdown(
          items: currencyItems,
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedFromCurrency,
          onChanged: (val) {
            setState(() {
              _selectedFromCurrency = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBeneficiaryTypeDropdown() {
    Map<String, List<UiDropdownValue>> beneficiaryTypeMap = {
      "Bangladesh": [
        UiDropdownValue(value: '1', labelText: 'Individual'),
        UiDropdownValue(value: '2', labelText: 'Non-Individual'),
      ],
      "Srilanka": [
        UiDropdownValue(value: '1', labelText: 'Individual'),
        UiDropdownValue(value: '2', labelText: 'Non-Individual'),
      ],
      "India": [
        UiDropdownValue(value: '1', labelText: 'Individual'),
        UiDropdownValue(value: '2', labelText: 'Non-Individual'),
      ],
    };

    List<UiDropdownValue> beneficiaryItems =
        beneficiaryTypeMap[countryController.text] ?? [];

    return Column(
      children: [
        const UiSpace.vertical(10),
        Row(children: [UiTextNew.h4Medium(DefaultString.instance.beneType)]),
        UiDropdown(
          items: beneficiaryItems,
          height: 50,
          hintText: DefaultString.instance.plsSelect,
          selectedValue: _selectedFromBeneType,
          onChanged: (val) {
            setState(() {
              _selectedFromBeneType = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBankDropdown() {
    return Column(
      children: [
        const UiSpace.vertical(10),
        const Row(children: [UiTextNew.h4Medium("Bank Name")]),
        UiDropdown(
          items: [
            UiDropdownValue(value: '1', labelText: 'Bank of Ceylon'),
            UiDropdownValue(value: '2', labelText: 'Commercial Bank PLC'),
            UiDropdownValue(value: '3', labelText: 'Hatton National Bank'),
            UiDropdownValue(value: '4', labelText: 'National Savings Bank'),
            UiDropdownValue(value: '5', labelText: 'Others'),
          ],
          height: 50,
          hintText: "Select Bank",
          selectedValue: _selectedFromBank,
          onChanged: (val) {
            setState(() {
              _selectedFromBank = val;
            });
          },
        ),
      ],
    );
  }

  Widget formCountry() {
    final beneficiaries = [
      "Bangladesh",
      "Srilanka",
      "India",
      "China",
      "Haiti",
      "Honduras",
      "Hong Kong",
      "Hungary",
      "Iceland",
    ];
    return _buildInput(
      label: DefaultString.instance.country,
      hint: "Please Select",
      controller: countryController,
      dropDownLabel: DefaultString.instance.selectBenCountry,
      isDropdown: true,
      isEnabled: false,
      availBalance: "",
      maxLines: countryController.text.isEmpty ? 1 : 2,
      sheetWidget: BeneficiaryCountryPicker(
        beneficiaryList: beneficiaries,
        hintText: "Search",
        title: DefaultString.instance.selectBenCountry,
        onTap: (selectedCountry) {
          setState(() {
            countryController.text = selectedCountry;
            _selectedFromCurrency = null;
            _selectedFromBeneType = null;
            _selectedFromBank = null;
          });
        },
      ),
    );
  }

  _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    // required TransferField field,
    bool isDropdown = false,
    bool addBeneficiary = false,
    bool isEnabled = true,
    bool isAmount = false,
    ValueChanged<String>? onChanged,
    String addBeneficiaryLabel = "",
    String availBalance = "",
    String dropDownLabel = "",
    int maxLines = 1,
    VoidCallback? onReset,
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
          maxLength: maxLines,
          readOnly: fieldEnabled,
          hintText: hint,
          validator: (value) {
            return null;
          },
          onChanged: (value) {
            // onChanged?.call(value);
            // _validateForm();
          },
          textStyle: textStyle,
          controller: controller,
          onTap: () {
            if (isDropdown) {
              viewBottomSheet(
                context: context,
                title: dropDownLabel,
                child: sheetWidget,
              );
            }
          },
          suffixIcon: isDropdown
              ? Container(
                  margin: const EdgeInsetsDirectional.only(end: 10),
                  child: UISvgIcon(
                    assetPath: SvgAssets().arrowDown2,
                    color: DefaultColors.primaryBlue,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
