import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'fixed_deposite_bottom_sheet.dart';

class ProfitTile extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String rate;
  final String date;
  final String lastMonthDate;
  final String tenure;
  final String category;
  final String currency;

  const ProfitTile({
    super.key,
    required this.title,
    required this.tags,
    required this.rate,
    required this.date,
    required this.lastMonthDate,
    required this.tenure,
    required this.category,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return InkWell(
      splashColor: DefaultColors.transparent,
      highlightColor: DefaultColors.transparent,
      onTap: () => showDepositDetails(
        context,
        title: title,
        rate: rate,
        lastMonthDate: lastMonthDate,
        currency: currency,
        category: category,
        creationDate: date,
        tenure: tenure,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left Column: Title + Tags
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.042,
                    ),
                  ),
                  SizedBox(height: h * 0.01),

                  /// Wrap tags so they flow to next line if overflow
                  Wrap(
                    spacing: w * 0.02,
                    runSpacing: h * 0.008,
                    children: tags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03,
                          vertical: h * 0.004,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w600,
                            color: DefaultColors.black4E,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            /// Right Column: Rate + Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rate,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.048,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: h * 0.004),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: w * 0.03,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
