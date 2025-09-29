import 'package:flutter/material.dart';
import '../../db_uicomponents.dart';

class UiMainTabCard extends StatelessWidget {

  final UICardModel uiCardModel;

  const UiMainTabCard({super.key, required this.uiCardModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: UiCard(
        cardColor: Color(0xFF2171B6),
        curve: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              image: uiCardModel.assetBgImg == null
                  ? null
                  : DecorationImage(image: AssetImage(uiCardModel.assetBgImg!),
              alignment: Alignment.centerLeft,
              //fit: BoxFit.fill,
              //opacity: 0.5
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: UiTextNew.h3Semibold(
                  color: DefaultColors.white,
                  uiCardModel.title,
                ),
                subtitle: (uiCardModel.subtitle != null)
                    ? UiTextNew.custom(
                  uiCardModel.subtitle!,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.white_300,
                  fontFamily: Fonts.rubik,
                )
                    : null,
                isThreeLine: uiCardModel.subtitle != null,
                trailing: InkWell(
                  onTap: uiCardModel.onTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        uiCardModel.viewAll,
                        style:
                        UiTextNew.h2Bold("").getTextStyle(context)?.copyWith(

                          fontSize: 16,
                          //decoration: TextDecoration.underline,
                          // shadows: [
                          //   Shadow(
                          //       color: DefaultColors.gray7D,
                          //       offset: Offset(0, 4))
                          // ],
                          color: Colors.white,
                          height: -0.5,
                          decorationColor: DefaultColors.gray7D,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UiSpace.vertical(1),
                        if (uiCardModel.availablelimit != null)
                          UiTextNew.custom(
                            uiCardModel.availablelimit!,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: DefaultColors.white_300,
                          ),
                        if (uiCardModel.availablelimitvalue != null)
                          UiTextNew.b2Semibold(
                            uiCardModel.availablelimitvalue!,
                            lineHeight: 1,
                            color: DefaultColors.white,
                          ),
                        if (uiCardModel.outstandingbalance != null) ...[
                          const UiSpace.vertical(8), // Add vertical space
                          UiTextNew.custom(
                            uiCardModel.outstandingbalance!,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: DefaultColors.white_300,
                          ),
                        ],
                        if (uiCardModel.outstandingbalancevalue != null)
                          UiTextNew.b2Semibold(
                            uiCardModel.outstandingbalancevalue!,
                            lineHeight: 1,
                            color: DefaultColors.white,
                            //color: DefaultColors.blue9D,
                          ),
                        if (uiCardModel.secAmount1 != null)
                          UiTextNew.b2Semibold(
                            uiCardModel.secAmount1!,
                            spacing: 0,
                            color: DefaultColors.white,
                            // color: DefaultColors.blue9D,
                          ),
                        if (uiCardModel.secAmount3 != null)
                          UiTextNew.b2Semibold(
                            uiCardModel.secAmount2!,
                            color: DefaultColors.white,
                          ),
                        if (uiCardModel.secAmount3 != null)
                          UiTextNew.b2Semibold(
                            uiCardModel.secAmount3!,
                            color: DefaultColors.white,
                          ),
                        const UiSpace.vertical(15),
                      ],
                    ),
                  ),
                  if (uiCardModel.loanTab) const UiSpace.horizontal(5),
                  if (uiCardModel.loanTab)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Instalment',
                              style: context.textTheme.bodySmall
                                  ?.copyWith(
                                  color: DefaultColors.gray7D,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  fontSize: 13)
                                  .merge(uiCardModel.fontFamily)),
                          Text(
                            uiCardModel.instalmentAmount1!,
                            style: context.textTheme.bodyLarge
                                ?.copyWith(
                                color: DefaultColors.blue9D,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0,
                                fontSize: 18)
                                .merge(uiCardModel.fontFamily),
                          ),
                          Text(
                            uiCardModel.instalmentAmount2!,
                            style: context.textTheme.bodySmall
                                ?.copyWith(
                                color: DefaultColors.gray7D,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                fontSize: 12)
                                .merge(uiCardModel.fontFamily),
                          ),
                          Text(
                            uiCardModel.instalmentAmount3!,
                            style: context.textTheme.bodySmall
                                ?.copyWith(
                                color: DefaultColors.gray7D,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                fontSize: 12)
                                .merge(uiCardModel.fontFamily),
                          ),

                          // New Card Type content

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           if(uiCardModel.availablelimit != null)
                          //           UiTextNew.custom(
                          //             uiCardModel.availablelimit!,
                          //             fontSize: 10,
                          //             fontWeight: FontWeight.w400,
                          //             color: DefaultColors.white_700,
                          //           ),
                          //           // Add any additional widgets specific to the new card type here.
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                ],
              ),
              const UiSpace.vertical(12)
            ],
          ),
        ),
      ),
    );

  }
}

class UICardModel {
  final String? assetBgImg;
  final String title;
  final String? subtitle;
  final String? trailText;
  final String? primaryAmount;
  final String? secAmount1;
  final String? secAmount2;
  final String? secAmount3;
  final String? instalmentAmount1;
  final String? instalmentAmount2;
  final String? instalmentAmount3;
  final String? availablelimit;
  final String? availablelimitvalue;
  final String? outstandingbalance;
  final String? outstandingbalancevalue;
  final bool loanTab;
  final TextStyle? fontFamily;
  final TextStyle? titleStyle;
  final TextStyle? subStyle;
  final bool isNewCardType;
  final String viewAll;
  final Function()? onTap;

  UICardModel({required this.title,
    this.subtitle,
    this.primaryAmount,
    this.secAmount1,
    this.secAmount2,
    this.trailText,
    this.secAmount3,
    this.loanTab = false,
    this.availablelimit,
    this.viewAll = "View All",
    this.availablelimitvalue,
    this.outstandingbalance,
    this.outstandingbalancevalue,
    this.instalmentAmount1,
    this.instalmentAmount2,
    this.instalmentAmount3,
    this.assetBgImg,
    this.isNewCardType = false,
    this.titleStyle,
    this.fontFamily,
    this.subStyle,
    this.onTap})
      : assert(
  !(loanTab &&
      (instalmentAmount1 == null ||
          instalmentAmount2 == null ||
          instalmentAmount3 == null)),
  'Instalment Amount is required when isLoanTab is true');
}
