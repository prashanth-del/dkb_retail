import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/confirm_beneficiary_card.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/page3/ifsc_code_card.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/page3/view_card_reset.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottomSheet/view_bottom_sheet.dart';

class Page3 extends ConsumerStatefulWidget{
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  const Page3({super.key,
    required this.onBack,
    required this.onSubmit});

  @override
  ConsumerState<Page3> createState() =>
      _Page3State();
}
class _Page3State extends ConsumerState<Page3>{
  final TextEditingController beneAccountNoController = TextEditingController();
  final TextEditingController swiftCodeController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController branchAddressController = TextEditingController();
  final TextEditingController sortCodeController = TextEditingController();
  final TextEditingController bankSwiftCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cardReset = ref.watch(cardResetProvider);
    final isAddBeneficiary = ref.watch(isAddBeneficiaryProvider);
    final isIndia = ref.watch(isIndiaCountryProvider);
    if (isAddBeneficiary){
      beneAccountNoController.text="1234567891234";
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          const UiSpace.vertical(10),
          if (isAddBeneficiary)...[
            formBeneAccount(isEnabled:false).vertical(10),
            (cardReset ? ViewCardReset(isCountry: isIndia,) : IfscCodeCard(isCountry: isIndia,))]
          else ...[
            formBeneAccount(isEnabled:true).vertical(10),
            formSwiftCode().vertical(10),
            formBankName().vertical(10),
            formBranchName().vertical(10),
            formBranchAddress().vertical(10),
            formSortCode().vertical(10),
            formBankSwiftCode().vertical(10),
          ],

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: UIButton.rounded(
                    backgroundColor: DefaultColors.blue60,
                    onPressed: (){
                      if(isAddBeneficiary){
                        if(cardReset){
                          viewBottomSheet(
                              context: context, title: "Confirm Beneficiary", child: const ConfirmBeneficiaryCard());
                        }

                      }else{
                        viewBottomSheet(
                            context: context, title: "Confirm Beneficiary", child: const ConfirmBeneficiaryCard());
                      }

                      ref.read(isBangladeshCountryProvider.notifier).state = false;
                                        // widget.onSubmit();
                    },
                    // isDisabled: widget.buttonEnabled,
                    height: 40,
                    label: "SUBMIT",
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );

  }
  Widget formBeneAccount({required bool isEnabled}) {
    return _buildInput(
      label: DefaultString.instance.beneAccountNo,
      hint: "Please Enter",
      controller: beneAccountNoController,
      isEnabled: isEnabled,

    );
  }
  Widget formSwiftCode() {
    return _buildInput(
      label: DefaultString.instance.swiftCode,
      hint: "Please Enter",
      isDropdown: true,
      isSearchSwift: true,
      controller: swiftCodeController,

    );
  }
  Widget formBankName() {
    return _buildInput(
      label: DefaultString.instance.bankName,
      hint: "Please Enter",
      controller: bankNameController,

    );
  }
  Widget formBranchName() {
    return _buildInput(
      label: DefaultString.instance.branchName,
      hint: "Please Enter",
      controller: branchNameController,

    );
  }
  Widget formBranchAddress() {
    return _buildInput(
      label: DefaultString.instance.branchAddress,
      hint: "Please Enter",
      controller: branchAddressController,

    );
  }
  Widget formSortCode() {
    return _buildInput(
      label: DefaultString.instance.sortCode,
      hint: "Please Enter",
      controller: sortCodeController,

    );
  }
  Widget formBankSwiftCode() {
    return _buildInput(
      label: DefaultString.instance.bankSwiftCode,
      hint: "Please Enter",
      controller: bankSwiftCodeController,

    );
  }
  _buildInput(
      {required String label,
        required String hint,
        required TextEditingController controller,
        bool isDropdown = false,
        bool isSearchSwift=false,
        bool addBeneficiary = false,
        bool isEnabled = true,
        bool isAmount = false,
        ValueChanged<String>? onChanged,
        String addBeneficiaryLabel = "",
        String availBalance = "",
        int maxLines = 1,
        VoidCallback? onReset,
        Widget sheetWidget = const SizedBox.shrink()}) {
    TextStyle? textStyle = UiTextStyles.uiInfoTitleSmallBold(context)
        ?.copyWith(color: DefaultColors.gray2D);


    bool fieldEnabled = !isEnabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          borderColor: DefaultColors.grayE6,
          labelUiText: UiTextNew.b2Semibold(label),
          // maxLength: maxLines,
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
              // viewBottomSheet(
              //     context: context, title: label, child: sheetWidget);
            }
          },
          suffixIcon: isDropdown
              ? Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: isSearchSwift
                  ? const UiTextNew.custom("Search For Swift Code",
                color: DefaultColors.blueprimary,
                fontSize: 12,fontWeight: FontWeight.w500,)
                  : UISvgIcon(
                assetPath: SvgAssets().arrowDown2,
                color: DefaultColors.primaryBlue,
              ),)
              : const SizedBox.shrink(),
        ),

      ],
    );
  }
}