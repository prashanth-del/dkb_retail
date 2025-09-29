import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/beneficiary_country_picker.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/confirm_bank_sheet.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/tabPages/beneficiary_user_card.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IfscCodeCard extends ConsumerStatefulWidget {
  final bool isCountry;

  const IfscCodeCard({super.key, this.isCountry = false});

  @override
  ConsumerState<IfscCodeCard> createState() => _IfscCodeCardState();
}

class _IfscCodeCardState extends ConsumerState<IfscCodeCard> {
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  final beneficiariesBank = [
    "Agrani Bank",
    "AB Bank Limited",
    "Bank Asia Limited",
    "Bangladesh Commerce Bank LTD",
    "BRAC Bank Limited",
    "Dhaka Bank Limited",
    "Dutch-Bangla Bank Limited",
    "Sonali Bank",
    "Shahjalal Islami Bank",
  ];
  final beneficiariesBranch = [
    "Bogura",
    "Chattogram",
    "Cox's Bazar",
    "Dinajpur",
    "Khulna",
    "Mymensingh",
    "Sirajganj",
  ];

  @override
  Widget build(BuildContext context) {
    return UiCard(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          _buildInput(
            label: widget.isCountry ? "IFSC Code" : "Branch Name",
            hint: widget.isCountry ? "Enter IFSC Code" : "Enter Code",
            controller: branchNameController,
          ),

          const UiSpace.vertical(20),
          const Row(
            children: [
              Expanded(
                child: Divider(color: DefaultColors.grayB3, thickness: 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: UiTextNew.b1Medium("or", color: DefaultColors.grayB3),
              ),
              Expanded(
                child: Divider(thickness: 1, color: DefaultColors.grayB3),
              ),
            ],
          ),
          const UiSpace.vertical(20),
          _buildInput(
            label: "Bank Name",
            hint: "Please Select",
            controller: bankNameController,
            isDropdown: true,
            isEnabled: false,
            dropDownLabel: "Select Bank",
            sheetWidget: BeneficiaryCountryPicker(
              beneficiaryList: beneficiariesBank,
              hintText: "Search",
              title: "Bank Name",
              onTap: (selectedCountry) {
                setState(() {
                  bankNameController.text = selectedCountry;
                });
              },
            ),
          ),

          const UiSpace.vertical(10),
          _buildInput(
            label: "Branch",
            hint: "Please Select",
            controller: branchController,
            dropDownLabel: "Select Branch",
            isDropdown: true,
            isEnabled: false,
            sheetWidget: BeneficiaryCountryPicker(
              beneficiaryList: beneficiariesBranch,
              hintText: "Search",
              title: "Select Branch",
              onTap: (selectedCountry) {
                setState(() {
                  branchController.text = selectedCountry;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIButton.rounded(
                backgroundColor: DefaultColors.blue_02,
                txtColor: DefaultColors.primaryBlue,
                height: 40,
                label: "Search",
                onPressed: () {
                  viewBottomSheet(
                    heightPercentage: 0.2,
                    context: context,
                    title: "Confirm Bank",
                    child: ConfirmBankSheet(
                      bankTitle: widget.isCountry
                          ? "IFSC Code"
                          : "Bank & Branch code",
                      bankBranchCode: branchNameController.text,
                      bankName: bankNameController.text,
                      branchLocation: branchController.text,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
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
