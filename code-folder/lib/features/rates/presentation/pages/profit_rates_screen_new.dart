import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/constants/colors.dart';

@RoutePage(name: "ProfitRatesPageRoute")
class ProfitRatesPage extends StatefulWidget {
  const ProfitRatesPage({super.key});

  @override
  State<ProfitRatesPage> createState() => _ProfitRatesPageState();
}

class _ProfitRatesPageState extends State<ProfitRatesPage> {
  int? expandedIndex;
  int selectedTabIndex = 0;

  final depositRates = List.generate(
    8,
        (i) => {
      "title": "Fixed Deposit",
      "tags": ["RET", "3M", "QAR"],
      "rate": "0.50000%",
      "date": "20/11/2023",
      "details": {
        "Growth": "0.5",
        "Maturity": "20/10/2020",
        "Currency": "QAR",
        "Category": "Retail",
        "Creation": "20/10/2020",
        "Tenure": "3 Months",
      }
    },
  );

  final tabs = [
    {"label": "Time Deposit", "count": 8},
    {"label": "Advance Deposit", "count": 5},
    {"label": "Savings", "count": 12},
  ];

  Widget _buildRateCard(Map<String, Object> rate, int index) {
    final isExpanded = expandedIndex == index;
    final details = rate["details"] as Map<String, dynamic>;

    final growthValue = double.tryParse(details["Growth"] as String) ?? 0.0;
    final chartData = [
      _ChartData("Sep21", growthValue * 0.4),
      _ChartData("Oct21", growthValue * 0.5),
      _ChartData("Nov21", growthValue * 0.6),
    ];

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedIndex = isExpanded ? null : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              width: 1.2,
            ),
          ),
          child: Column(
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rate["title"] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: (rate["tags"] as List<String>)
                              .map(
                                (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AnimatedCrossFade(
                      firstChild: const Icon(
                        Icons.bar_chart,
                        color: Colors.blue,
                        size: 28,
                      ),
                      secondChild: const SizedBox.shrink(),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        rate["rate"] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rate["date"] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                  ),
                ],
              ),

              // Expanded Details
              AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.25,
                        width: double.infinity,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            labelRotation: 45,
                            labelIntersectAction: AxisLabelIntersectAction.wrap,
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            interval: 0.1,
                            majorGridLines: const MajorGridLines(width: 0.5),
                          ),
                          series: <CartesianSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (_ChartData data, _) => data.month,
                              yValueMapper: (_ChartData data, _) => data.value,
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                              spacing: 0.3,
                              animationDuration: 800,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.top,
                                textStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: details.isNotEmpty
                            ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 columns for details
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemCount: details.entries.length,
                          itemBuilder: (context, index) {
                            final entry = details.entries.elementAt(index);
                            return TextFormField(
                              initialValue: entry.value.toString(),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: entry.key,
                                isDense: true,
                                labelStyle: TextStyle(color: DefaultColors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 13,
                                color: DefaultColors.black,
                              ),
                            );
                          },
                        )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => context.router.pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text(
          "Profit Rates",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: DefaultColors.blue98,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.asMap().entries.map((entry) {
                  int index = entry.key;
                  var tab = entry.value;
                  final isSelected = selectedTabIndex == index;

                  return Padding(
                    padding: EdgeInsets.only(right: w * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04,
                          vertical: h * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? DefaultColors.blue98
                              : Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Text(
                              tab["label"] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: w * 0.035,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: w * 0.02),
                            Text(
                              "${tab["count"]}",
                              style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedTabIndex,
        children: List.generate(
          tabs.length,
              (_) => ListView.builder(
            itemCount: depositRates.length,
            itemBuilder: (context, i) => _buildRateCard(depositRates[i], i),
          ),
        ),
      ),
    );
  }
}

// Chart data class
class _ChartData {
  final String month;
  final double value;
  _ChartData(this.month, this.value);
}
