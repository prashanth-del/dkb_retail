import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/chart/line_chart/src/legend_widget.dart';
import 'package:flutter/material.dart';
import 'src/donut_chart_widget.dart';

class DonutChartData {
  final double value;
  final Color color;
  final String title;

  DonutChartData(
      {required this.value, required this.color, required this.title});
}

class DonutChart extends StatelessWidget {

  final List<DonutChartData> data;

  const DonutChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UICardView(
        borderColor: const Color.fromARGB(255, 198, 226, 250),
        cardCornerRadius: 8,
        height: context.screenWidth * 0.73,
        width: context.screenWidth * 0.95,
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LegendWidget(
                  lineColors: data.map((item) => item.color).toList(),
                  lineTitles: data.map((item) => item.title).toList()),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: DonutChartWidget(
                  height: context.screenWidth * 0.40,
                  width: context.screenWidth * 0.45,
                  data: data,
                )),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
