import '../../../../utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import 'line_chart_painter.dart';

class LineChartWidget extends StatelessWidget {
  final List<List<double>> yPointsList;
  final List<String> xLabels;
  final double minY;
  final double maxY;
  final List<Color> lineColors;
  final List<String> lineTitles;

  const LineChartWidget({
    super.key,
    required this.yPointsList,
    required this.xLabels,
    required this.minY,
    required this.maxY,
    required this.lineColors,
    required this.lineTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SizedBox(
          height: context.screenWidth * 0.45,
          width: context.screenWidth * 0.70,
          child: CustomPaint(
            painter: LineChartPainter(
              yPointsList: yPointsList,
              xLabels: xLabels,
              minY: minY,
              maxY: maxY,
              lineColors: lineColors,
              lineTitles: lineTitles,
            ),
          ),
        ),
      ),
    );
  }
}