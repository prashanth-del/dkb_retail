import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/extensions/context_extension.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/ui_currency_card/currency_exchange_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../common/components/info_card.dart';
import '../provider/transfer_provider.dart';

class TransactionSuccessPage extends ConsumerStatefulWidget {
  final Map<String, List<Map<String, String>>> transactionDetails;

  const TransactionSuccessPage({super.key,required this.transactionDetails,});

  @override
  ConsumerState createState() => _TransactionSuccessPageState();}

class _TransactionSuccessPageState extends ConsumerState<TransactionSuccessPage> {
  void showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SvgPicture.asset(
                  AssetPath.svg.transactionSuccessNew,
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 10),
              UiTextNew.h3Medium("Success"),
              const SizedBox(height: 6),
              UiTextNew.h5Regular("Transaction added to favourites successfully"),
              const SizedBox(height: 20),
              UIButton.rounded(
                label: "OK",
                backgroundColor: DefaultColors.blue_300,
                txtColor: Colors.white,
                maxWidth: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(isFavProvider.notifier).state=true;
                  // showNextSuccessPopup(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void showBottomSheet(BuildContext context) {
    UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: 'Favourite Transaction',
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            UiTextNew.h4Medium("Nickname"),
            const SizedBox(height: 8),
            UIFormTextField.outlined(
              borderColor: DefaultColors.grayE6,
              hintText: "Enter Nickname",
              onChanged: (value) {
              },
            ),
            const SizedBox(height: 20),

            UIButton.rounded(
              label: "SUBMIT",
              backgroundColor: DefaultColors.blue_300,
              txtColor: Colors.white,
              maxWidth: double.infinity,
              onPressed: () {

                Navigator.pop(context);
                showSuccessPopup(context);
                print("Favourite Transaction Submitted");
              },
            ),
          ],
        ),
      ),
    );

  }


  void showNextSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SvgPicture.asset(
                  AssetPath.svg.transactionSuccessNew,
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 10),
              UiTextNew.h3Medium("Success"),
              const SizedBox(height: 6),
              UiTextNew.h5Regular("Statement downloaded successfully"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: UIButton.rounded(
                      label: "DISMISS",
                      backgroundColor: DefaultColors.grayE5,
                      txtColor: DefaultColors.blue_300,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: UIButton.rounded(
                      label: "VIEW",
                      backgroundColor: DefaultColors.blue_300,
                      txtColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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


  @override
  Widget build(BuildContext context) {

    final isFav = ref.watch(isFavProvider);
    final selectedTransfer = ref.watch(selectedTransferProvider);
    return SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Success Indicator
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Container(
                            decoration: BoxDecoration(
                              color: DefaultColors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsetsDirectional.symmetric(vertical: 20),
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: 50, horizontal: context.width(10)),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetPath.svg.transactionSuccessNew),
                                const UiSpace.vertical(10),
                                UiTextNew.h6Semibold(
                                  "Transaction Successful",
                                  color: DefaultColors.gray2D,
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            ),
                          ),
                        ]),
                        if(selectedTransfer?.classification=="ift")...{
                                CurrencyExchangeCard(
                                      name: 'Ahmed Ansari',
                                      fromCurrency: 'QAR',
                                      toCurrency: 'CNY',
                                      fromFlag: 'QA',
                                      toFlag: 'CN',
                                      fromAmount: 90000.00,
                                      toAmount: 175360.03,
                                  exchangeRate: "CNY 1.00 = QAR 0.51",
                                ),
                          const UiSpace.vertical(20),
                        },

                        UiCard(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Column(
                                children: [
                                  ...widget.transactionDetails["details"]!.map((detail) {
                                    final title = detail.keys.first;
                                    final value = detail.values.first;
                                    return Row(
                                      children: [
                                        _buildKeyValueText(title, value).vertical(10),
                                      ],
                                    );
                                  }).toList(),
                                ]
                            ),
                          ),
                        )

                      ],
                    ),

                      if(selectedTransfer?.classification=="domestic" && selectedTransfer?.index==3)...{
                      Column(
                        children: [
                          const UiSpace.vertical(20),
                          InfoCard(title: "", descriptions: ["An SMS message containing the D-Cardless PIN has been sent to your beneficiary.",
                          "Please provide the Request Reference Number (RRN) received by you to your beneficiary in order to execute the transaction on Dukhan Bank ATM.",
                            "The Request Reference Number (RRN) is valid only for 24hrs.",
                           "Please refer to the Request Reference Number (RRN) for further enquiries."

                          ])
                        ],
                          ),
                      },

                     SizedBox(height: 20),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: UIButton.rounded(
                          backgroundColor: DefaultColors.white,
                          onPressed: () {
                            print("Share/Download Clicked");
                            showNextSuccessPopup(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, color: DefaultColors.blue_300, size: 18), // Using a share icon
                              const SizedBox(width: 5),
                              Text(
                                DefaultString.instance.shareDownload ?? "SHARE/DOWNLOAD",
                                style: TextStyle(
                                  color: DefaultColors.blue_300,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if(selectedTransfer?.classification=="domestic")...{
                      const SizedBox(width: 10),

                      Expanded(
                        child: UIButton.rounded(
                          backgroundColor: DefaultColors.white,

                          onPressed: () {
                            print("Favourite Clicked");
                            showBottomSheet(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isFav?Icon(Icons.star, color: DefaultColors.blue_300, size: 18):Icon(Icons.star_border, color: DefaultColors.blue_300, size: 18), // Using a star icon
                              const SizedBox(width: 5),
                              Text(
                                isFav?"ADDED":DefaultString.instance.favourite ?? "FAVOURITE",
                                style: TextStyle(
                                  color: DefaultColors.blue_300,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),}
                    ],
                  ),

                  UIButton.rounded(
                    label: DefaultString.instance.makeAnotherTransfer ?? "Make Another Transfer",
                    backgroundColor: DefaultColors.blue_300,
                    txtColor: Colors.white,
                    maxWidth: double.infinity,
                    onPressed: () {
                      ref.read(isFavProvider.notifier).state=false;
                      ref.read(currentStepProvider.notifier).state =0;
                      Navigator.pop(context);

                    },
                  ),
                ],
              ),
            ),

          ],
        ));
  }
}


