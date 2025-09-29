import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'donut_chart_painter.dart';

class DonutChartWidget extends StatelessWidget {
  final List<DonutChartData> data;
  final double width;
  final double height;

  const DonutChartWidget({
    super.key,
    required this.data,
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DonutChartPainter(data),
      ),
    );
  }
}