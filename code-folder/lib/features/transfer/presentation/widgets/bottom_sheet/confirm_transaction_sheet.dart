import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/transfer/presentation/provider/transfer_provider.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/ui_currency_card/currency_exchange_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmTransactionSheet extends ConsumerStatefulWidget {
  final Map<String, List<Map<String, String>>> transactionDetails;
  final bool isConfirm;
  final String transferType;

  const ConfirmTransactionSheet({
    Key? key,
    this.transferType = "ift",
    this.isConfirm = false,
    required this.transactionDetails,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConfirmTransactionSheetState();
}

class _ConfirmTransactionSheetState
    extends ConsumerState<ConfirmTransactionSheet> {
  bool isChecked = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    final selectedTransfer = ref.watch(selectedTransferProvider);
    return Column(
      children: [
        // ListTile(
        //   minLeadingWidth: 0,
        //   contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //   title: UiTextNew.b1Semibold("Confirm Transactions"),
        //   trailing: UIIconContainer(
        //     icon: Icons.close,
        //     color: DefaultColors.transparent,
        //     iconColor: DefaultColors.black,
        //     iconSize: 18,
        //     onTap: () {
        //       context.router.maybePop();
        //     },
        //   ),
        // ),
        // const Divider(color: DefaultColors.blue_02, thickness: 1),
        Column(
          children: [
            if (selectedTransfer?.classification == "ift") ...{
              const CurrencyExchangeCard(
                name: 'Ahmed Ansari',
                fromCurrency: 'QAR',
                toCurrency: 'CNY',
                fromFlag: 'QA',
                toFlag: 'CN',
                fromAmount: 90000.00,
                toAmount: 175360.03,
                exchangeRate: "CNY 1.00 = QAR 0.51",
              ),
              const UiSpace.vertical(10),
            },

            ...widget.transactionDetails["details"]!.map((detail) {
              final title = detail.keys.first;
              final value = detail.values.first;
              return Row(
                children: [_buildKeyValueText(title, value).vertical(10)],
              );
            }).toList(),
            UiSpace.vertical(10),
            if (selectedTransfer?.classification == "ift") ...[
              ...widget.transactionDetails["chargeDetails"]!.map((detail) {
                final title = detail["title"];
                final currency = detail["currency"];
                final value = detail["value"];

                return _buildKeyValueIFT(
                  title ?? "",
                  currency ?? "",
                  value ?? "",
                ).vertical(10);
              }).toList(),
            ],

            if (widget.isConfirm || selectedTransfer?.classification == "ift")
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: DefaultColors.primaryBlue,
                    checkColor: DefaultColors.white,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  UiTextNew.custom(
                    color: DefaultColors.gray2D,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    "I agree to",
                  ),
                  UiTextNew.custom(
                    color: DefaultColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    "  terms & conditions",
                  ),
                ],
              ),
            if (selectedTransfer?.classification == "ift") ...{
              Row(
                children: [
                  Checkbox(
                    value: isChecked2,
                    activeColor: DefaultColors.primaryBlue,
                    checkColor: DefaultColors.white,
                    onChanged: (value) {
                      setState(() {
                        isChecked2 = value ?? false;
                      });
                    },
                  ),
                  Flexible(
                    child: UiTextNew.custom(
                      color: DefaultColors.gray2D,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      "I confirm & acknowledge that the money transfer is  not related  to payment for BITCOIN or any other CRYPTO currency",
                    ),
                  ),
                ],
              ),
              // UiSpace.vertical(10),
            },

            Row(
              children: [
                Expanded(
                  child: UIButton.rounded(
                    backgroundColor: DefaultColors.blue60,
                    onPressed: () {
                      if (widget.isConfirm) {
                        context.router.push(
                          OtpApprovalRoute(
                            onSubmit: () {
                              Navigator.pop(context);
                              Navigator.pop(context);

                              Future.microtask(() {
                                ref.read(currentStepProvider.notifier).state +=
                                    1;
                              });
                            },
                          ),
                        );
                      } else {
                        if (selectedTransfer?.classification == "donation") {
                          context.router.push(
                            OtpApprovalRoute(
                              onSubmit: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                context.replaceRoute(
                                  DonationTransferRoute(
                                    title: "transfer_success_page",
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          ref.read(currentStepProvider.notifier).state += 1;
                          Navigator.pop(context);
                        }
                      }
                    },
                    height: 40,
                    label: "CONFIRM",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyValueText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.h4Regular(title, color: DefaultColors.gray54),
        UiTextNew.b14Medium(value, color: DefaultColors.grayD2),
      ],
    );
  }

  Widget _buildKeyValueIFT(String title, String currency, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiTextNew.h4Regular(title, color: DefaultColors.gray54),
        Row(
          children: [
            UiTextNew.h5Regular(currency, color: DefaultColors.gray54),
            const SizedBox(width: 4), // Adds a small space
            UiTextNew.b14Medium(value, color: DefaultColors.gray2D),
          ],
        ),
      ],
    );
  }
}
