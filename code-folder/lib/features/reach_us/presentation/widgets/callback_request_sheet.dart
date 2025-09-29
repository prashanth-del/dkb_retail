import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import 'custom_button.dart';
import 'divider_sheet_widget.dart';

class CallbackRequestSheet extends StatefulWidget {
  const CallbackRequestSheet({super.key});

  @override
  State<CallbackRequestSheet> createState() => _CallbackRequestSheetState();
}

class _CallbackRequestSheetState extends State<CallbackRequestSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10),
            DividerSheetCommon(),
            SizedBox(height: 80),

            Container(
              width: 200,
              child: UiTextNew.customRubik(
                "Thank you for your callback request",
                maxLines: 2,
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: DefaultColors.grayLightBase,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    UiTextNew.customRubik(
                      "We will call you back within 1 business day",
                      maxLines: 2,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 14),
                    UiTextNew.customRubik(
                      "Reference number: 123456789",
                      maxLines: 2,
                      fontSize: 10,
                      color: DefaultColors.grayBase,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38),
            CustomButtonNewWidget(
              onPress: () {
                print(";;;;;;;;;;;;;;;;;;;;");
                context.router.replace(ReachUsPageRoute());
              },
              title: "Done",
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
