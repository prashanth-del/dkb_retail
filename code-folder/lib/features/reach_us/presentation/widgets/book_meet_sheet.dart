import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:dkb_retail/features/reach_us/presentation/widgets/success_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import 'custom_button.dart';
import 'divider_sheet_widget.dart';

class BookAndMeetSheet extends StatefulWidget {
  const BookAndMeetSheet({super.key});

  @override
  State<BookAndMeetSheet> createState() => _BookAndMeetSheetState();
}

class _BookAndMeetSheetState extends State<BookAndMeetSheet> {
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
            SizedBox(height: 24),
            SuccessImageWidget(),
            SizedBox(height: 24),
            Container(
              width: 200,
              child: UiTextNew.customRubik(
                "Appointment booked successfully",
                maxLines: 2,
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: DefaultColors.grayLightBase,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    TitleSubTitleSheet(
                      title: "Preferred date and time",
                      subTitle: "12-09-2025",
                    ),
                    SizedBox(height: 2),
                    UiTextNew.customRubik(
                      " 8.00am - 9.00am",
                      maxLines: 2,
                      fontSize: 13,
                      color: DefaultColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 24),
                    TitleSubTitleSheet(
                      title: "Branch Name",
                      subTitle: "City Center, Doha",
                    ),
                    SizedBox(height: 24),
                    TitleSubTitleSheet(
                      title: "Service Type",
                      subTitle: "Savings Account",
                    ),
                    SizedBox(height: 24),
                    UiTextNew.customRubik(
                      "Reference number: 123456789",
                      maxLines: 2,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: DefaultColors.grayBase,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38),
            CustomButtonNewWidget(
              onPress: () {
                context.router.replace(ReachUsPageRoute());
                print(";;;;;;;;;;;;;;;;;;;;");
                //   context.router.replace(ReachUsPageRoute());
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

class TitleSubTitleSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleSubTitleSheet({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiTextNew.customRubik(
          title,
          maxLines: 2,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: DefaultColors.grayBase,
        ),
        SizedBox(height: 2),
        UiTextNew.customRubik(
          subTitle,
          maxLines: 2,
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: DefaultColors.black,
        ),
      ],
    );
  }
}
