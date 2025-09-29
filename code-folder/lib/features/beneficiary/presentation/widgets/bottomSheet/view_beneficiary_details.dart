import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewBeneficiaryDetails extends ConsumerStatefulWidget {
  final String statusType;
  const ViewBeneficiaryDetails({super.key, required this.statusType});

  @override
  ConsumerState<ViewBeneficiaryDetails> createState() =>
      _ConfirmBeneficiaryCardState();
}

class _ConfirmBeneficiaryCardState
    extends ConsumerState<ViewBeneficiaryDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKeyValueText(
          "Status",
          widget.statusType == "Approved" ? "Approved" : "Pending Approval",
          color1: DefaultColors.gray8A,
          color2: widget.statusType == "Approved"
              ? DefaultColors.greenStatus
              : DefaultColors.orange14,
        ),
        const UiSpace.vertical(10),
        _buildKeyValueText(
          "Type of Fund Transfer",
          "International Money Transfer",
        ),
        const UiSpace.vertical(10),
        _buildKeyValueText("Name", "Test Test"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Nick Name", "Test"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Bank Name", "Test"),
        const UiSpace.vertical(10),
        _buildKeyValueText("Account Number/IBAN", "1234567890"),
        const UiSpace.vertical(10),
        if (widget.statusType == "Approved")
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: UIButton.rounded(
                    backgroundColor: DefaultColors.blue60,
                    onPressed: () {
                      context.router.push(
                        OtpApprovalRoute(
                          onSubmit: () {
                            context.router.push(
                              DashboardRoute(),
                            ); // Navigate to Dashboard on submit
                          },
                        ),
                      );
                    },
                    height: 40,
                    label: "TRANSFER FUNDS",
                  ),
                ),
                Expanded(child: UISvgIcon(assetPath: SvgAssets().delete)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildKeyValueText(
    String title,
    String value, {
    Color? color1,
    Color? color2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UiTextNew.h4Regular(title, color: color1 ?? DefaultColors.gray54),
          ],
        ),
        Row(
          children: [
            UiTextNew.b14Medium(value, color: color2 ?? DefaultColors.grayD2),
          ],
        ),
      ],
    );
  }
}
