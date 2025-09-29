import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import 'src/legend_widget.dart';
import 'src/line_chart_widget.dart';

class LineChart extends StatelessWidget {
  final List<Color> lineColors;
  final List<String> lineTitles;
  final List<List<double>> yPointsList;
  final List<String> xLabels;

  const LineChart(
      {super.key,
        required this.lineColors,
        required this.lineTitles,
        required this.yPointsList,
        required this.xLabels});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UICardView(
        borderColor: const Color.fromARGB(255, 198, 226, 250),
        cardCornerRadius: 8,
        height: context.screenWidth * 0.65,
        width: context.screenWidth * 0.95,
        elevation: 1.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: LegendWidget(
                  lineColors: lineColors, lineTitles: lineTitles),
            ),
            Expanded(
              child: LineChartWidget(
                yPointsList: yPointsList,
                xLabels: xLabels,
                minY: 0,
                maxY: 36000,
                lineColors: lineColors,
                lineTitles: lineTitles,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
