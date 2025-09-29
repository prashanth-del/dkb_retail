import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

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
            SizedBox(height: 80),

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
                      fontSize: 10,
                      color: DefaultColors.grayBase,
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 38),
            CustomButtonNewWidget(
              onPress: () {
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
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 2),
        UiTextNew.customRubik(
          subTitle,
          maxLines: 2,
          fontSize: 10,
          color: DefaultColors.grayBase,
        ),
      ],
    );
  }
}
