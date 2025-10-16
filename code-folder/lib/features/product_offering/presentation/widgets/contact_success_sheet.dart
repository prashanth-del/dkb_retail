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
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
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
        // Spacer(),
        UiSpace.vertical(10),
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(AssetPath.image.successgif),
          ),
        ),
        // UiSpace.vertical(30),
        Spacer(),
        UiTextNew.custom(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          'Thank you for your\ninterest in Dukhan Bank',
          color: DefaultColors.blue9D,
          textAlign: TextAlign.center,
          spacing: 0,
        ),
        UiSpace.vertical(16),
        UiTextNew.custom('We will contact you soon.', fontSize: 14),
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
                  children: [
                    UiTextNew.custom(
                      'Ticket No.',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: UiTextNew.custom(
                              '98A3018F8501-8A94',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              UiToast().showToast('Copied');
                            },
                            child: UISvgIcon(
                              assetPath: AssetPath.image.productTicketCopy,
                            ),
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
                    UiTextNew.custom(
                      'Product Type',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    UiTextNew.custom(
                      'Time Deposit',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
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
    );
  }
}
