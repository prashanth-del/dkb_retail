import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class UITile2 extends StatefulWidget {
  final String title;
  final String subtitle;
  final String leadingIconPath;
  final String subtitlevalue;
  final String transactionRef;
  final String transactionRefValue;
  final String initialDateHeader;
  final String initialDateValue;
  final String amount;
  final String amountValue;
  final String? statusLabel;
  final EdgeInsets? padding;
  final String? status;
  final VoidCallback? viewMore;

  final Color priceColor;

  final bool isNegative; // To handle if the price is negative

  const UITile2({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIconPath,
    required this.subtitlevalue,
    required this.transactionRef,
    this.padding,
    required this.transactionRefValue,
    required this.initialDateHeader,
    required this.initialDateValue,
    required this.amount,
    required this.amountValue,
    this.statusLabel,
    this.priceColor = Colors.red,
    this.isNegative = false,
    this.viewMore,
    this.status,
  }) : super(key: key);

  @override
  State<UITile2> createState() => _UITile2State();
}

class _UITile2State extends State<UITile2> {
  @override
  Widget build(BuildContext context) {
    return UiCard(
      child: Padding(
        padding: widget.padding ?? EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              minLeadingWidth: 0,
              horizontalTitleGap: 5,
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              // leading: UISvgIcon(
              //   width: 40,
              //   height: 40,
              //   assetPath: widget.leadingIconPath,
              // ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UiSpace.vertical(8),
                  UiTextNew.h3Semibold(
                    widget.title,
                    color: DefaultColors.blue_900,
                    //fontWeight: FontWeight.w600,
                    //fontSize: 16,
                    //fontFamily: Fonts.rubik,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UiTextNew.b3Regular(
                        widget.subtitle,
                        color: DefaultColors.white_700,
                      ),
                      UiSpace.horizontal(5),
                      UiTextNew.b3Semibold(
                        widget.subtitlevalue,
                        color: DefaultColors.white_750,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      UiTextNew.b3Regular(
                        //widget.transactionRef,
                        widget.initialDateHeader,
                        color: DefaultColors.white_700,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      UiTextNew.b3Semibold(
                        // widget.transactionRefValue,
                        widget.initialDateValue,
                        color: DefaultColors.white_750,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UiSpace.horizontal(18),
                  GestureDetector(
                      onTap: widget.viewMore,
                      child:
                          UISvgIcon(assetPath: "assets/icons/three_dot.svg")),
                ],
              ),
            ),
            UiSpace.vertical(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // _buildCardInfoRow(widget.initialDateHeader,
                //         value: widget.initialDateValue),
                _buildCardInfoRow(widget.amount, currency: widget.amountValue),
                Spacer(),
                if (widget.status != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 7.0,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF1DB954),
                          borderRadius: BorderRadius.circular(24.0),
                          border:
                              Border.all(color: Color(0xFF1DB954), width: 1)),
                      child: UiTextNew.b1Medium(
                        // widget.pendingLabel ?? "Success",
                        widget.statusLabel ?? "Success",
                        color: DefaultColors.white_0,
                      ),
                    ),
                  ),
              ],
            ),

            // UiSpace.vertical(10),

            UiSpace.vertical(15),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInfoRow(String title,
      {String? value, String? currency, double? fontSize}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UiTextNew.b2Regular(
          title,
          color: DefaultColors.white_700,
        ),
        const SizedBox(
          width: 5,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currency ?? "", // Use empty string if currency is null
                style: UiTextNew.b2Semibold(
                  currency ?? "",
                  lineHeight: 1,
                  color: DefaultColors.gray9D,
                ).getTextStyle(context),
                overflow: TextOverflow.ellipsis, // Handle overflow
                maxLines: 1, // Restrict to a single line
              ),
              Flexible(
                child: Text(
                  value ?? "", // Use empty string if value is null
                  style: UiTextNew.b2Semibold(
                    value ?? "",
                    lineHeight: 1,
                    color: DefaultColors.white_750,
                  ).getTextStyle(context),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 2, // Restrict to a single line
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
