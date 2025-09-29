import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../db_uicomponents.dart';

enum _CardType { myAccount, accountDetail, myCard, loans, deposit }

class UiAccountCard extends StatefulWidget {
  final String iconAsset;
  final String headingText;
  final String title;
  final Widget? action;
  final Function()? onTap;
  final String identifierLabel;
  final String identifierValue;
  final String? maturityDateLabel;
  final String? maturityDateValue;
  final String? ibanCode;
  final String? expDate;
  final String? status;
  final String? cardLimit;
  final String? currentBalTitle;
  final String? currentBalVal;
  final String? availableBalanceTitle;
  final String? availableBalanceAmount;
  final String? currency;
  final String? ibanTitle;
  final Widget? footer;
  final TextStyle? fontFamily;
  final String? expDateLabel;
  final String? statusLabel;
  final String? creditLimitLabel;

  const UiAccountCard.myAccountCard({super.key,
    required this.iconAsset,
    this.onTap,
    this.headingText = 'Account Type',
    this.currency = 'QAR',
    required this.title,
    this.action,
    this.identifierLabel = 'Account Number',
    required this.identifierValue,
    this.currentBalTitle = 'Current Balance',
    required this.currentBalVal,
    this.ibanTitle = "IBAN",
    this.availableBalanceTitle = 'Available Balance',
    required this.availableBalanceAmount,
    this.fontFamily,
    this.maturityDateLabel,
    this.maturityDateValue})
      : _cardType = _CardType.myAccount,
        expDate = null,
        footer = null,
        status = null,
        expDateLabel = null,
        ibanCode = null,
        creditLimitLabel = null,
        statusLabel = null,
        cardLimit = null;

  const UiAccountCard.accountDetailCard({super.key,
    required this.iconAsset,
    this.onTap,
    this.headingText = 'Account Type',
    this.currency = 'QAR',
    required this.title,
    this.action,
    this.ibanTitle = "IBAN",
    this.identifierLabel = 'Account Number',
    required this.identifierValue,
    required this.ibanCode,
    this.currentBalTitle = 'Current Balance',
    required this.currentBalVal,
    this.availableBalanceTitle = 'Available Balance',
    required this.availableBalanceAmount,
    this.fontFamily,
    this.maturityDateLabel,
    this.maturityDateValue})
      : _cardType = _CardType.accountDetail,
        footer = null,
        expDate = null,
        status = null,
        expDateLabel = null,
        creditLimitLabel = null,
        statusLabel = null,
        cardLimit = null;

  const UiAccountCard.myCard({super.key,
    required this.iconAsset,
    this.onTap,
    this.headingText = 'Card Name',
    this.currency = 'QAR',
    this.ibanTitle = "IBAN",
    required this.title,
    this.action,
    this.identifierLabel = 'Card Number',
    required this.identifierValue,
    required this.expDate,
    required this.status,
    required this.cardLimit,
    this.expDateLabel = "Expiry Date",
    this.creditLimitLabel = "Credit Limit",
    this.statusLabel = "Status",
    required this.ibanCode,
    this.currentBalTitle = 'Available Credit Limit',
    required this.currentBalVal,
    this.availableBalanceTitle = 'Outstanding Balance',
    required this.availableBalanceAmount,
    this.fontFamily,
    this.maturityDateLabel,
    this.maturityDateValue})
      : _cardType = _CardType.myCard,
        footer = null;

  const UiAccountCard.loans({super.key,
    required this.iconAsset,
    this.onTap,
    this.headingText = 'Loan Account Type',
    this.currency = 'QAR',
    required this.title,
    this.expDateLabel = "Expiry Date",
    this.action,
    this.ibanTitle = "IBAN",
    this.identifierLabel = 'Account',
    required this.identifierValue,
    //this.ibanCode,
    required this.footer,
    this.fontFamily,
    this.maturityDateLabel,
    this.maturityDateValue})
      : _cardType = _CardType.loans,
        ibanCode = null,
        currentBalTitle = null,
        currentBalVal = null,
        availableBalanceTitle = null,
        availableBalanceAmount = null,
        expDate = null,
        status = null,
        creditLimitLabel = null,
        statusLabel = null,
        cardLimit = null;

  const UiAccountCard.deposit({super.key,
    required this.iconAsset,
    this.onTap,
    this.headingText = 'Account Type',
    this.currency = 'QAR',
    required this.title,
    this.action,
    this.identifierLabel = 'Account Number',
    required this.identifierValue,
    this.maturityDateLabel,
    this.maturityDateValue,
    required this.footer,
    this.fontFamily})
      : _cardType = _CardType.deposit,
        currentBalTitle = null,
        currentBalVal = null,
        availableBalanceTitle = null,
        availableBalanceAmount = null,
        ibanCode = null,
        this.ibanTitle = null,
        expDate = null,
        status = null,
        expDateLabel = null,
        creditLimitLabel = null,
        statusLabel = null,
        cardLimit = null;

  final _CardType _cardType;

  @override
  State<UiAccountCard> createState() => _UiAccountCardState();
}

class _UiAccountCardState extends State<UiAccountCard> {
  @override
  Widget build(BuildContext context) {
    return UiCard(
      curve: 10,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                contentPadding: EdgeInsets.zero,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.b14Semibold(
                      widget.title,
                      maxLines: 2,
                      spacing: 0,
                      color: DefaultColors.blue_900,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        UiTextNew.b3Regular(
                          widget.identifierLabel,
                          color: DefaultColors.white_700,
                        ),
                        UiSpace.horizontal(5),
                        UiTextNew.b3Semibold(
                          widget.identifierValue,
                          lineHeight: 1.2,
                          color: DefaultColors.white_750,
                        ),
                      ],
                    ),
                    if (widget._cardType == _CardType.accountDetail)
                      Row(
                        children: [
                          UiTextNew.b3Regular(
                            widget.ibanTitle!,
                            color: DefaultColors.gray7D,
                          ),
                          UiSpace.horizontal(5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: UiTextNew.b3Regular(
                                  widget.ibanCode!,
                                  color: DefaultColors.blue9D,
                                ),
                              ),
                              const UiSpace.horizontal(4),
                              IconButton(
                                iconSize: 20,
                                style: const ButtonStyle(
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                    minHeight: 20,
                                    minWidth: 20,
                                    maxHeight: 20,
                                    maxWidth: 20),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: widget.ibanCode!))
                                      .then((_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                            "IBAN copied to clipboard")));
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: DefaultColors.blue9D,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        if (widget._cardType == _CardType.deposit) ...[
                          if (widget.maturityDateLabel != null &&
                              widget.maturityDateValue != null) ...[
                            const UiSpace.vertical(10),
                            UiTextNew.b3Regular(
                              widget.maturityDateLabel!,
                              color: DefaultColors.gray7D,
                            ),
                            UiSpace.horizontal(5),
                            UiTextNew.b3Semibold(
                              widget.maturityDateValue!,
                              color: DefaultColors.white_750,
                            ),
                          ],
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        if (widget._cardType == _CardType.myCard) ...[
                          if (widget.expDateLabel != null &&
                              widget.expDate != null) ...[
                            const UiSpace.vertical(10),
                            UiTextNew.b3Regular(
                              widget.expDateLabel!,
                              color: DefaultColors.gray7D,
                            ),
                            UiSpace.horizontal(5),
                            UiTextNew.b3Semibold(
                              widget.expDate!,
                              color: DefaultColors.white_750,
                            ),
                          ],
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        if (widget._cardType == _CardType.myCard) ...[
                          if (widget.statusLabel != null &&
                              widget.status != null) ...[
                            const UiSpace.vertical(10),
                            UiTextNew.b3Regular(
                              widget.statusLabel!,
                              color: DefaultColors.gray7D,
                            ),
                            UiSpace.horizontal(5),
                            UiTextNew.b3Semibold(
                              widget.status!,
                              color: DefaultColors.white_750,
                            ),
                          ],
                        ],
                      ],
                    ),
                  ],
                ),
                trailing: widget.action ?? _buildDirectionalArrowIcon()
            ),

            if ((widget._cardType == _CardType.accountDetail) ||
                (widget._cardType == _CardType.loans))
              const UiSpace.vertical(10),
            // if ((widget._cardType == _CardType.accountDetail) ||
            //     (widget._cardType == _CardType.loans))

            // if ((widget._cardType == _CardType.accountDetail) ||
            //     (widget._cardType == _CardType.loans))

            //const UiSpace.vertical(10),
            if (widget._cardType == _CardType.myAccount ||
                widget._cardType == _CardType.accountDetail)
              _buildTwoInfoRow2(
                  widget.currentBalTitle ?? "Current Balance",
                  widget.currentBalVal ?? "",
                  widget.availableBalanceTitle ?? "",
                  widget.availableBalanceAmount ?? "",
                  widget.currency ?? ""),
            if (widget._cardType == _CardType.myCard)
              _buildThreeInfoRow(
                widget.creditLimitLabel ?? 'Credit Limit',
                widget.cardLimit!,
                widget.currentBalTitle ?? "Status",
                widget.currentBalVal!,
                widget.availableBalanceTitle ?? "Outstanding Balance",
                widget.availableBalanceAmount!,
                widget.currency!,
              ),
            if (widget._cardType == _CardType.myCard)
              const UiSpace.vertical(10),
            if ((widget._cardType != _CardType.loans) &&
                (widget._cardType != _CardType.deposit))
              _buildTwoInfoRow(
                widget.currentBalTitle!,
                widget.currentBalVal!,
                widget.availableBalanceTitle!,
                widget.availableBalanceAmount!,
                widget.currency!,
              ),
            if ((widget._cardType == _CardType.loans) ||
                (widget._cardType == _CardType.deposit))
              widget.footer!,
            const UiSpace.vertical(15),
          ],
        ),
      ),
    );
  }

  Widget _buildThreeInfoRow(String title1, String value1, String title2,
      String value2, String title3, String value3, currency) {
    bool isLtr = Directionality.of(context) == TextDirection.ltr;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // _buildCardInfoColumn2(title1, value1, fontSize: 14),
        // Spacer(),
        // _buildCardInfoColumn2(title2, value2, fontSize: 14),
        // Spacer(),
        // _buildCardInfoColumn2(title3, value3,
        //     fontSize: 14, currency: widget.currency),
        // if (isLtr) UiSpace.horizontal(15),
        Column(
          children: [
            _buildInfoColumnLabel(title1, title2, title3),
          ],
        ),
        Column(
          children: [_buildInfoColumnValue(value1, value2, value3, currency)],
        ),
      ],
    );
  }

  Widget _buildInfoColumnLabel(String title1, String title2, String title3,
      {String? currency, double? fontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.b2Regular(
          title1,
          color: DefaultColors.white_700,
        ),
        UiTextNew.b2Regular(
          title2,
          color: DefaultColors.white_700,
        ),
        UiTextNew.b2Regular(
          title3,
          color: DefaultColors.white_700,
        ),
      ],
    );
  }

  Widget _buildInfoColumnValue(String value1, String value2, String value3,
      String currency,
      {double? fontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const Spacer(),

        if (currency != null)
          Row(
            children: [
              UiTextNew.custom(
                "$currency",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: Fonts.rubik,
                color: DefaultColors.blue9D,
              ),
              const UiSpace.horizontal(5),
              UiTextNew.custom(
                value1,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: Fonts.rubik,
                color: DefaultColors.blue9D,
              ),
            ],
          ).toLTRDirection(),
        Row(
          children: [
            UiTextNew.custom(
              "$currency",
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.rubik,
              color: DefaultColors.blue9D,
            ),
            const UiSpace.horizontal(5),
            UiTextNew.custom(
              value2,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.rubik,
              color: DefaultColors.blue9D,
            ),
          ],
        ).toLTRDirection(),

        Row(
          children: [
            UiTextNew.custom(
              "$currency",
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.rubik,
              color: DefaultColors.blue9D,
            ),
            const UiSpace.horizontal(5),
            UiTextNew.custom(
              value3,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.rubik,
              color: DefaultColors.blue9D,
            ),
          ],
        ).toLTRDirection(),
        // Text.rich(
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 1,
        //   TextSpan(
        //       text: "$currency ",
        //       children: [
        //         TextSpan(
        //             text: value1,
        //             style: UiTextNew.b1Semibold(
        //               "",
        //             ).getTextStyle(context)),
        //       ],
        //       style: UiTextNew.b2Semibold(
        //         "",
        //         color: DefaultColors.white_700,
        //       ).getTextStyle(context)),
        // ),

        if (currency == null)
          UiTextNew.b1Semibold(
            value2,
            color: DefaultColors.black,
          )
        // Text(
        //   value,
        //   style: context.textTheme.bodyMedium?.copyWith(
        //       color: DefaultColors.black,
        //       fontSize: fontSize ?? 14,
        //       letterSpacing: 0,
        //       fontWeight: FontWeight.w700,
        //       fontFamily: fontFamily),
        // )
      ],
    );
  }

  Widget _buildTwoInfoRow(String title1, String value1, String title2,
      String value2, String currency) {
    return Row(
      children: [
        // _buildCardInfoColumn(title1, title2,),
        // Spacer(),
        // _buildCardInfoColumn2(value1, value2,currency: currency),
      ],
    );
  }

  Widget _buildTwoInfoRow2(String title1, String value1, String title2,
      String value2, String currency) {
    return Row(
      children: [
        _buildCardInfoColumn(
          title1,
          title2,
        ),
        Spacer(),
        _buildCardInfoColumn2(value1, value2, currency: currency),
      ],
    );
  }

  Widget _buildCardInfoColumn(String title1, String title2,
      {String? title3, double? fontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.b2Regular(
          title1,
          color: DefaultColors.white_700,
        ),
        UiTextNew.b2Regular(
          title2,
          color: DefaultColors.white_700,
        ),
      ],
    );
  }

  Widget _buildCardInfoColumn2(String value1, String value2,
      {String? currency, double? fontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            TextSpan(
                text: currency == null ? currency : "$currency ",
                children: [
                  TextSpan(
                    text: value1,
                    style: UiTextNew.b2Semibold(
                      "",
                      lineHeight: 1,
                      color: DefaultColors.blue9D,
                    ).getTextStyle(context),
                  )
                ],
                style: UiTextNew.b2Semibold(
                  "",
                  lineHeight: 1,
                  color: DefaultColors.blue9D,
                ).getTextStyle(context))),
        UiSpace.vertical(5),
        Text.rich(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            TextSpan(
                text: currency == null ? currency : "$currency ",
                children: [
                  TextSpan(
                    text: value2,
                    style: UiTextNew.b2Semibold(
                      "",
                      lineHeight: 1,
                      color: DefaultColors.blue9D,
                    ).getTextStyle(context),
                  )
                ],
                style: UiTextNew.b2Semibold(
                  "",
                  lineHeight: 1,
                  color: DefaultColors.blue9D,
                ).getTextStyle(context))),
      ],
    );
  }

  Widget _buildDirectionalArrowIcon() {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final arrowIcon = Platform.isIOS && isRtl ? Icons.arrow_back_ios : Icons.arrow_forward_ios;

    return Padding(
      padding: EdgeInsets.only(
        bottom: widget._cardType == _CardType.myCard ? 20 : 0,
      ),
      child: Icon(
        arrowIcon,
        size: 16,
        color: DefaultColors.blue9D,
      ),
    );
  }
}