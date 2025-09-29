import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/styles.dart';
import 'package:flutter/material.dart';

import '../widgets/fixed_deposite_bottom_sheet.dart';

@RoutePage()
class ProfitRatesScreen extends StatelessWidget {
  const ProfitRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final tabs = [
      {"label": "Time Deposit", "count": 99},
      {"label": "Advance Deposit", "count": 99},
      {"label": "Savings", "count": 99},
    ];

    final rates = List.generate(
      7,
      (index) => {
        "title": "Fixed Deposit",
        "tags": ["RET", "3M", "QAR"],
        "rate": "0.50000%",
        "date": "20/11/2023",
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.router.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Text(
          "Profit Rates",
          style: TextStyle(
            color: DefaultColors.blue98,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = tab["label"] == "Time Deposit";
                  return Padding(
                    padding: EdgeInsets.only(right: w * 0.02),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.04,
                        vertical: h * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? DefaultColors.blue98 : Colors.white,
                        border: Border.all(
                          color: DefaultColors.black25,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${tab["label"]}",
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : DefaultColors.black25,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.035,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            "${tab["count"]}",
                            style: TextStyle(
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? DefaultColors.white
                                  : DefaultColors.black25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: h * 0.02),

            // Profit Rates List
            Expanded(
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];
                  return ProfitTile(
                    title: rate["title"] as String,
                    tags: rate["tags"] as List<String>,
                    rate: rate["rate"] as String,
                    date: rate["date"] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extracted Profit Tile Widget
class ProfitTile extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String rate;
  final String date;

  const ProfitTile({
    super.key,
    required this.title,
    required this.tags,
    required this.rate,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return InkWell(
      onTap: () => showDepositDetails(context),
      child: Container(
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            // Left content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.04,
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Row(
                    children: tags
                        .map(
                          (tag) => Container(
                            margin: EdgeInsets.only(right: w * 0.02),
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.025,
                              vertical: h * 0.003,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w600,
                                color: DefaultColors.black4E,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // Right content
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rate,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.045,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: h * 0.005),
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
