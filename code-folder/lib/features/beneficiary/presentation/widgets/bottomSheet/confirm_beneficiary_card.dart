import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/beneficiary/presentation/controller/beneficiary_provider.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/popUpDialog/Beneficiary_transfer_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmBeneficiaryCard extends ConsumerStatefulWidget{
 final bool showButton;
  const ConfirmBeneficiaryCard({super.key,this.showButton=true});

  @override
  ConsumerState<ConfirmBeneficiaryCard> createState() =>
      _ConfirmBeneficiaryCardState();
}
class _ConfirmBeneficiaryCardState extends ConsumerState<ConfirmBeneficiaryCard>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKeyValueText("Type of Fund Transfer", "International Money Transfer"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Country", "China"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Full Name", "Test Test"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Address", "002-test avenue"),
        const UiSpace.vertical(10),
        _buildKeyValueText("City", "Shanghai"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Account Number/IBAN", "1234567890"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Swift Code", "AINFCNBJ"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Sort Code", "123456"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Intermediary Bank Swift Code ", "FJNCTYHN"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Bank Name", "Asian Infrastructure Investment Bank"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Branch Name", "Test"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Branch Address", "Test"),
        const UiSpace.vertical(10),
        if (widget.showButton)
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: UIButton.rounded(
                  backgroundColor: DefaultColors.blue60,
                  onPressed: (){
                    context.router.push(
                      OtpApprovalRoute(
                        onSubmit: () {
                          BeneficiaryTransferDialog(
                            context: context, ref: ref,).show_bene_successfully_dailog(

                            onViewButtonTap: () {
                              viewBottomSheet(
                                  context: context, title: "Beneficiary Details", child: const ConfirmBeneficiaryCard(showButton: false,));
                            },
                            onDismissButtonTap: () {
                              ref.read(isIndiaCountryProvider.notifier).state = false;
                              context.pushRoute(DashboardRoute());
                            },
                          );
                        },
                      ),
                    );
                  },
                  height: 40,
                  label: "CONFIRM",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildKeyValueText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UiTextNew.h4Regular(title, color: DefaultColors.gray54),
          ],
        ),
        Row(
          children: [
            UiTextNew.b14Medium(value, color: DefaultColors.grayD2),
          ],
        ),
      ],
    );
  }
  
}