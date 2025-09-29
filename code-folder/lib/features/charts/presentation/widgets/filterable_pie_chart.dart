import 'package:dkb_retail/features/charts/presentation/widgets/success_failure_count.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FilterablePieChart extends StatelessWidget {
  final Map<String, dynamic> rawData;
  final List<String> channels;
  final List<String> serviceTypes;
  final VoidCallback onRefresh;

  const FilterablePieChart({
    super.key,
    required this.rawData,
    required this.channels,
    required this.serviceTypes,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = filterTransactionData(
      rawData: rawData,
      channels: channels,
      serviceTypes: serviceTypes,
    );

    return SfCircularChart(
      // title: ChartTitle(
      //   alignment: ChartAlignment.near,
      //   text: 'Success Failure Counts',
      //   textStyle:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      series: <CircularSeries>[
        PieSeries<Map<String, dynamic>, String>(
          dataSource: chartData,
          xValueMapper: (data, _) => data['label'],
          explode: true,
          explodeIndex: 0,
          yValueMapper: (data, _) => data['value'],
          pointColorMapper: (data, _) => data['color'],
          dataLabelMapper: (data, _) => '${data['label']}: ${data['value']}',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            showZeroValue: false,
          ),
        ),
      ],
    );
  }
}
