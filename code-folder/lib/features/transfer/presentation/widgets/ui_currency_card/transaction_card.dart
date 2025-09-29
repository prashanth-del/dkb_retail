import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../pages/local_fund_transfer.dart';

class TransactionCard extends StatelessWidget {
  final String name;
  final String amount;
  final String status;
  final String date;
  final String color;
  final String? bank;
  final TransferType transferType;

  const TransactionCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.status,
    required this.date,
    required this.color,
    required this.transferType,
    this.bank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (color == "green") {
      statusColor = Colors.green;
    } else if (color == "red") {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange;
    }

    return UiCard(
      cardColor: DefaultColors.blue_light_03,
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: Name & Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.custom(
                      name,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UiTextNew.h5Regular(
                          "Ref No : 9921049478",
                          color: DefaultColors.gray7D,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UiTextNew.b3Bold(amount),
                        const SizedBox(width: 4),
                        // if (transferType == TransferType.international)
                        //   UiTextNew.b4Regular("INR"),
                      ],
                    ),
                    UiTextNew.h5Regular(
                      date,
                      color: DefaultColors.gray7D,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const UiSpace.vertical(6),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (bank != null) ...[
                UiTextNew.h5Regular(
                  "Bank: $bank",
                  color: Colors.grey,
                ),
                const UiSpace.vertical(4),
              ],
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildStatusBadge(status, statusColor),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: UiTextNew.b4Bold(
        text,
        color: Colors.white,
      ),
    );
  }
}
