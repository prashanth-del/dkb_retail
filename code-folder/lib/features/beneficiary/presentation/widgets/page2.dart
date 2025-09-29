import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page2 extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  const Page2({super.key, required this.onBack, required this.onSubmit});

  @override
  ConsumerState<Page2> createState() => _Page2State();
}

class _Page2State extends ConsumerState<Page2> {
  final TextEditingController beneFullNameController = TextEditingController();
  final TextEditingController beneNickNameController = TextEditingController();
  final TextEditingController beneAddressController = TextEditingController();
  final TextEditingController beneRelationshipController =
      TextEditingController();
  final TextEditingController beneCityController = TextEditingController();
  final TextEditingController beneMobileNumberController =
      TextEditingController();
  String? _selectedFromRelationship;
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    final isBangladesh = ref.watch(isBangladeshCountryProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const UiSpace.vertical(10),
          formBeneFullName().vertical(10),
          formBeneNickName().vertical(10),
          formBeneAddress().vertical(10),
          formBeneCity().vertical(10),
          if (isBangladesh) ...[
            formBeneMobileNumber().vertical(10),
            _buildCountryDropdown().vertical(10),
          ],
          _buildRelationshipDropdown().vertical(10),

          // formBeneRelationship().vertical(10),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: UIButton.rounded(
                    backgroundColor: DefaultColors.blue60,
                    onPressed: () {
                      widget.onSubmit();
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

  Widget _buildRelationshipDropdown() {
    return Column(
      children: [
        const UiSpace.vertical(10),
        const Row(children: [UiTextNew.h4Medium("Beneficiary Relationship")]),
        UiDropdown(
          items: [
            UiDropdownValue(value: '1', labelText: 'Father'),
            UiDropdownValue(value: '2', labelText: 'Mother'),
            UiDropdownValue(value: '3', labelText: 'Brother'),
            UiDropdownValue(value: '4', labelText: 'Friend'),
            UiDropdownValue(value: '5', labelText: 'Others'),
          ],
          height: 50,
          hintText: "Please Select",
          selectedValue: _selectedFromRelationship,
          onChanged: (val) {
            setState(() {
              _selectedFromRelationship = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      children: [
        const UiSpace.vertical(10),
        const Row(children: [UiTextNew.h4Medium("Beneficiary Mobile Number")]),
        UiDropdown(
          items: [
            UiDropdownValue(value: '1', labelText: 'Qatar'),
            UiDropdownValue(value: '2', labelText: 'India'),
            UiDropdownValue(value: '3', labelText: 'Bangladesh'),
            UiDropdownValue(value: '4', labelText: 'China'),
            UiDropdownValue(value: '5', labelText: 'SriLanka'),
            UiDropdownValue(value: '6', labelText: 'Others'),
          ],
          height: 50,
          hintText: "Please Select",
          selectedValue: _selectedCountry,
          onChanged: (val) {
            setState(() {
              _selectedCountry = val;
            });
          },
        ),
      ],
    );
  }

  Widget formBeneNickName() {
    return _buildInput(
      label: DefaultString.instance.beneNickName,
      hint: "Please Enter",
      controller: beneNickNameController,
      maxLines: 1,
      onReset: () {},
    );
  }

  Widget formBeneFullName() {
    return _buildInput(
      label: DefaultString.instance.beneFullName,
      hint: "Please Enter",
      controller: beneFullNameController,
      maxLines: 1,
    );
  }

  Widget formBeneAddress() {
    return _buildInput(
      label: DefaultString.instance.beneAddress,
      hint: "Please Enter",
      controller: beneAddressController,
      maxLines: 1,
    );
  }

  Widget formBeneCity() {
    return _buildInput(
      label: DefaultString.instance.beneCity,
      hint: "Please Enter",
      controller: beneCityController,
      maxLines: 1,
    );
  }

  Widget formBeneMobileNumber() {
    return _buildInput(
      label: "Beneficiary Mobile Number",
      hint: "Please Enter",
      controller: beneMobileNumberController,
      maxLines: 1,
    );
  }

  Widget formBeneRelationship() {
    return _buildInput(
      label: DefaultString.instance.beneRelationship,
      hint: "Please Select",
      controller: beneRelationshipController,
      isDropdown: true,
      maxLines: beneRelationshipController.text.isEmpty ? 1 : 2,
      onReset: () {},
    );
  }

  _buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isDropdown = false,

    bool isEnabled = true,
    ValueChanged<String>? onChanged,
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
          // maxLine: maxLines,
          readOnly: fieldEnabled,
          hintText: hint,
          validator: (value) {
            return null;
          },
          // onReset: onReset,
          onChanged: (value) {
            onChanged?.call(value);
            // _validateForm();
          },
          textStyle: textStyle,
          controller: controller,
          onTap: () {
            if (isDropdown) {
              // viewBottomSheet(
              //     context: context, title: label, child: sheetWidget);
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
