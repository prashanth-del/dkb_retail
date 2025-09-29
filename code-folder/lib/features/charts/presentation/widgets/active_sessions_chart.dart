import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActiveSessionsChart extends StatelessWidget {
  final String title;
  final String xAxisTitle;
  final String yAxisTitle;
  final List<String> xAxisCategories;
  final List<int> yAxisValues;
  final List<ChartSeriesData> seriesData;
  final VoidCallback onRefresh;

  const ActiveSessionsChart({
    super.key,
    required this.title,
    required this.xAxisTitle,
    required this.yAxisTitle,
    required this.xAxisCategories,
    required this.yAxisValues,
    required this.seriesData,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            title: AxisTitle(
              text: xAxisTitle,
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: UiTextNew.b4Regular("").getTextStyle(context),
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              final value = details.text;
              if (xAxisCategories.contains(value)) {
                return ChartAxisLabel(value, const TextStyle(fontSize: 12));
              }
              return ChartAxisLabel('', const TextStyle(fontSize: 0));
            },
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(
              text: yAxisTitle,
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            labelStyle: UiTextNew.b4Regular("").getTextStyle(context),
            minimum: yAxisValues.first.toDouble(),
            maximum: yAxisValues.last.toDouble(),
            // interval: (yAxisValues[1] - yAxisValues[0]).toDouble(),
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              final value = details.value.toInt();
              if (yAxisValues.contains(value)) {
                return ChartAxisLabel('$value', const TextStyle(fontSize: 12));
              }

              return ChartAxisLabel('', const TextStyle(fontSize: 0));
            },
          ),
          title: ChartTitle(
            text: title,
            textStyle: const UiTextNew.h3Semibold("").getTextStyle(context).copyWith(fontSize: 13),
            alignment: ChartAlignment.near,
          ),
          legend: Legend(isVisible: true, iconHeight: 8, iconWidth: 8, textStyle: UiTextNew.h5Regular("").getTextStyle(context)),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: seriesData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final colors = [DefaultColors.primaryBlue, const Color(0xFFF39C12)];
            return LineSeries<SessionData, String>(
              color: colors[index % colors.length],
              name: data.name,
              dataSource: _mapDataToFixedXAxis(data.data),
              xValueMapper: (SessionData data, _) => data.time,
              yValueMapper: (SessionData data, _) => data.sessionCount,
              markerSettings: const MarkerSettings(isVisible: true),
            );
          }).toList(),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: onRefresh,
          ),
        ),
      ],
    );
  }

  List<SessionData> _mapDataToFixedXAxis(List<SessionData> data) {
    final Map<String, int> dataMap = {
      for (var item in data) item.time: item.sessionCount,
    };

    return xAxisCategories.map((category) {
      if (dataMap.containsKey(category)) {
        return SessionData(category, dataMap[category]!);
      } else {
        int? prevY;
        int? nextY;
        String? prevCategory;
        String? nextCategory;

        for (int i = 0; i < xAxisCategories.length - 1; i++) {
          if (category.compareTo(xAxisCategories[i]) > 0 &&
              category.compareTo(xAxisCategories[i + 1]) < 0) {
            prevCategory = xAxisCategories[i];
            nextCategory = xAxisCategories[i + 1];
            prevY = dataMap[prevCategory];
            nextY = dataMap[nextCategory];
            break;
          }
        }

        if (prevY != null && nextY != null) {
          final interpolatedY = prevY + (nextY - prevY) ~/ 2;
          return SessionData(category, interpolatedY);
        } else {
          return SessionData(category, 0);
        }
      }
    }).toList();
  }

// List<SessionData> _mapDataToFixedXAxis(List<SessionData> data) {
//   final Map<String, int> dataMap = {
//     for (var item in data) item.time: item.sessionCount,
//   };
//
//   return xAxisCategories.map((category) {
//     return SessionData(
//       category,
//       dataMap[category] ?? 0,
//     );
//   }).toList();
// }
}

class SessionData {
  final String time;
  final int sessionCount;

  SessionData(this.time, this.sessionCount);
}

class ChartSeriesData {
  final String name;
  final List<SessionData> data;

  ChartSeriesData(this.name, this.data);
}
