import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDashboardShimmer extends StatelessWidget {
  const AccountDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          _buildCardShimmer(height: 61).vertical(20),
          _buildCardShimmer(height: 178).vertical(20),
          // const UiCard(
          //     padding: EdgeInsets.all(10),
          //     cardColor: DefaultColors.skyBlue,
          //     child: PendingAprrovalShimmer()).vertical(20),
          // const UiCard(
          //     padding: EdgeInsets.all(10),
          //     cardColor: DefaultColors.skyBlue,
          //     child: CompletedTransactionShimmer()),
        ],
      ),
    );
  }

  Widget _buildCardShimmer(
      {required double height, double width = double.maxFinite}) {
    return UIShimmer(
      baseColor: DefaultColors.grey.withOpacity(0.4),
      highlightColor: DefaultColors.grey.withOpacity(0.1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: DefaultColors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
