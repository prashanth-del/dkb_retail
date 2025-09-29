import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactSuccessSheet extends ConsumerStatefulWidget {
  const ContactSuccessSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactSuccessSheetState();
}

class _ContactSuccessSheetState extends ConsumerState<ContactSuccessSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          UiSpace.vertical(10),
          Center(
            child: Container(
              height: 6,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: DefaultColors.gray0F,
              ),
            ),
          ),
          UiSpace.vertical(30),
          UiTextNew.h1Semibold(
            'Thank you for your\ninterest in Dukhan Bank',
            color: DefaultColors.blue9D,
            textAlign: TextAlign.center,
          ),
          UiSpace.vertical(16),
          UiTextNew.b14Medium('We will contact you soon.'),
          UiSpace.vertical(16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DefaultColors.grayB3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiTextNew.b14Medium('Ticket No.'),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: UiTextNew.b14Semibold('98A3018F8501-8A94'),
                            ),
                            UISvgIcon(
                              assetPath: AssetPath.image.productTicketCopy,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: DefaultColors.grayB3, height: 0),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiTextNew.b14Medium('Product Type'),
                      UiTextNew.b14Semibold('Time Deposit'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UiSpace.vertical(16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: UIButton.rounded(
              height: 48,
              btnCurve: 30,

              backgroundColor: DefaultColors.blue9D,
              onPressed: () {
                context.router.replaceAll([LoginRoute()]);
              },
              label: 'Done',
            ),
          ),
        ],
      ),
    );
  }
}
