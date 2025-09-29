import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardShimmer(height: 60)..vertical(20),
              UiSpace.vertical(20),
              _buildCardShimmer(height: 200).vertical(20)
              // UiSpace.horizontal(10),
              // _buildCardShimmer(height: 40).expanded(),
            ],
          ),
          // Column(
          //   children: List.generate(
          //     4,
          //         (_) => _buildCardShimmer(height: 200).vertical(10),
          //   ),
          // )
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
