import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeneficiaryTransferDialog {
  final BuildContext context;
  final WidgetRef ref;

  BeneficiaryTransferDialog({required this.context, required this.ref});

  void show_swift_dialog({required VoidCallback onTap}) {
    UIPopupDialog().showPopup(
      viewModel: UIPopupViewModel(
        image: AssetPath.svg.successError,
        context: context,
        imageSize: 80,
        title: "Swift transfer charges applicable are as follows;",
        contentWidget: SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiTextNew.b14Medium(
                  "ALL BANK CHARGES BORN BY ME - ",
                  color: DefaultColors.gray2D,
                ),
                UiTextNew.b14Regular(
                  "Both Dukhan Bank charges QAR 15 and Correspondent Bank charges will be recovered from remitter.",
                  color: DefaultColors.gray54,
                ),
                UiSpace.vertical(8),
                UiTextNew.b14Medium(
                  "SPLIT CHARGES - Dukhan",
                  color: DefaultColors.gray2D,
                ),
                UiTextNew.b14Regular(
                  "Bank charge QAR 15 will be recovered from remitter and correspondent bank charges will be from beneficiary.",
                  color: DefaultColors.gray54,
                ),
                UiSpace.vertical(8),
                UiTextNew.b14Medium(
                  "ALL CHARGES BORN BY BENEFICIARY -",
                  color: DefaultColors.gray2D,
                ),
                UiTextNew.b14Regular(
                  "Both Dukhan Bank charge QAR 15 and Correspondent Bank charges will be recovered from beneficiary.",
                  color: DefaultColors.gray54,
                ),
              ],
            ),
          ),
        ),
        buttonText: "OK",
        onClosePressed: onTap,
        onButtonPressed: onTap,
      ),
    );
  }

  void show_bene_successfully_dailog({
    required VoidCallback onViewButtonTap,
    required VoidCallback onDismissButtonTap,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AssetPath.svg.transactionSuccessNew),
                  const UiSpace.vertical(15),
                  const UiTextNew.h6Semibold(
                    "Beneficiary Added Successfully",
                    textAlign: TextAlign.center,
                  ),
                  const UiSpace.vertical(15),
                  const UIAlert.info(
                    message: "Note",
                    content: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: UiTextNew.h5Regular(
                        "For security of your transactions, transferring of funds to your new beneficiary will be activated after 2 hours ",
                        color: DefaultColors.gray54,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: UIButton.rounded(
                      backgroundColor: DefaultColors.blue_02,
                      txtColor: DefaultColors.blueprimary,
                      onPressed: onDismissButtonTap,
                      height: 40,
                      label: "DISMISS",
                    ),
                  ),
                  const UiSpace.horizontal(15),
                  Expanded(
                    child: UIButton.rounded(
                      backgroundColor: DefaultColors.blue60,
                      onPressed: onViewButtonTap,
                      height: 40,
                      label: "VIEW",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
