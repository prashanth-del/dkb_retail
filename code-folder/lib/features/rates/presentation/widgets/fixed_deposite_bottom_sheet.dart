import 'package:dartz/dartz.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/default_string.dart';

class DepositDetailsSheet extends StatelessWidget {
  final String title;
  final String rate;
  final String lastMonthDate;
  final String currency;
  final String category;
  final String creationDate;
  final String tenure;

  const DepositDetailsSheet({
    super.key,
    required this.title,
    required this.rate,
    required this.lastMonthDate,
    required this.currency,
    required this.category,
    required this.creationDate,
    required this.tenure,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button
        // Align(
        //   alignment: Alignment.topRight,
        //   child: IconButton(
        //     icon: Icon(Icons.close, color: DefaultColors.white),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),

        // Title
        Container(
          padding: EdgeInsets.fromLTRB(width * 0.05,0,width*0.05,width*0.05),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.02),
                  width: width * 0.12,
                  height: height * 0.005,
                  decoration: BoxDecoration(
                    color: DefaultColors.grayF9,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: DefaultColors.blueprimary,
                  ),
                ),
              ),
              SizedBox(height: width * 0.03),

              // Rate card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rate,
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: width * 0.015),
                    Text(
                      DefaultString.instance.growthTillDate,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: width * 0.02),
                    Text(
                      "${DefaultString.instance.lastMonthDate} : $lastMonthDate",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: width * 0.04),

              // Info boxes in Wrap (responsive 2 per row)
              Wrap(
                spacing: width * 0.03,
                runSpacing: width * 0.03,
                children: [
                  _buildInfoBox(context, DefaultString.instance.currency, currency),
                  _buildInfoBox(context, DefaultString.instance.category, category),
                  _buildInfoBox(context, DefaultString.instance.creationDate, creationDate),
                  _buildInfoBox(context, DefaultString.instance.tenure, tenure),
                ],
              ),
              SizedBox(height: width * 0.05),

              // Done button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.blueprimary,
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  child: Text(
                    DefaultString.instance.done,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(BuildContext context, String label, String value) {
    final width = MediaQuery.of(context).size.width;
    final boxWidth = (width - width * 0.15) / 2; // spacing & padding accounted

    return Container(
      width: boxWidth,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // avoids overflow
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: width * 0.015),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Call this bottom sheet
void showDepositDetails(
    BuildContext context, {
      required String title,
      required String rate,
      required String lastMonthDate,
      required String currency,
      required String category,
      required String creationDate,
      required String tenure,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DepositDetailsSheet(
      title: title,
      rate: rate,
      lastMonthDate: lastMonthDate,
      currency: currency,
      category: category,
      creationDate: creationDate,
      tenure: tenure,
    ),
  );
}
