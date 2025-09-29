import 'package:db_uicomponents/db_uicomponents.dart' as ui;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UiLineShadeGraph extends StatefulWidget {
  final List<Color> lineColors;
  final List<String> lineTitles;
  final List<List<double>> yPointsList;
  final List<String> xLabels;

  const UiLineShadeGraph(
      {super.key,
        required this.lineColors,
        required this.lineTitles,
        required this.yPointsList,
        required this.xLabels});

  @override
  State<UiLineShadeGraph> createState() => _UiLineShadeGraphState();
}

class _UiLineShadeGraphState extends State<UiLineShadeGraph> {
  List<Color> gradientColors = [
    ui.DefaultColors.blue_600.withOpacity(0.5),
    ui.DefaultColors.green54.withOpacity(0.8)
  ];

  List<List<FlSpot>> spotsList = [];

  double minX = 0;
  double maxX = 6;
  double? minY;
  double? maxY;
  int totalX = 0;

  _initialize() {
    gradientColors.clear();
    spotsList = widget.yPointsList.map((values) {
      final localMin = values.reduce((a, b) => a < b ? a : b);
      final localMax = values.reduce((a, b) => a > b ? a : b);

      minY = (minY == null) ? localMin : (minY! < localMin ? minY : localMin);
      maxY = (maxY == null) ? localMax : (maxY! > localMax ? maxY : localMax);

      return values
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
          .toList();
    }).toList();

    if(widget.xLabels.length - 1 < 6){
      maxX = widget.xLabels.length - 1;
    }
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ui.UICardView(
      borderColor: const Color.fromARGB(255, 198, 226, 250),
      cardCornerRadius: 8,
      height: 270,
      width: double.infinity,
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 1),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _buildLegend(widget.lineColors, widget.lineTitles),
              ),
            ),
            _buildChart(),
          ],
        ),
      ),
    );
  }

  _buildChart() {
    String showChar = '';
    minY = 0;
    double mid = ((maxY! + minY!) / 2);

    String y0, y1, y2;

    y0 = minY!.toStringAsFixed(0);
    y1 = mid.toStringAsFixed(0);
    y2 = maxY!.toStringAsFixed(0);

    debugPrint("MID - $mid");
    if(mid > 999){
      debugPrint("in mid");
      y1 = "${(mid / 1000).toStringAsFixed(0)}K";
    }
    if(maxY! > 999){
      y2 = "${(maxY! / 1000).toStringAsFixed(0)}K";
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 25,top: 18),
          width: 40,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ui.UiTextNew.b4Regular(y2),
                ui.UiTextNew.b4Regular(y1),
                ui.UiTextNew.b4Regular(y0),
              ]
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(left: 5),
              width: widget.xLabels.length * 54,
              child: LineChart(
                curve: Curves.linear,
                LineChartData(
                  minX: minX,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  backgroundColor: ui.DefaultColors.white,
                  gridData: const FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      drawHorizontalLine: true
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          String label = widget.xLabels[value.toInt()];
                          List<String> labelA = label.split(" ");
                          if (value >= 0.0 && value < widget.xLabels.length) {
                            return ui.UiTextNew.b3Regular(
                                "${labelA[0]}\n${labelA[1]}");
                          }
                          return const Text('');
                        },
                        reservedSize: 35,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: ui.DefaultColors.skyBlue),
                      left: BorderSide(color: ui.DefaultColors.skyBlue),
                      right: BorderSide.none,
                      top: BorderSide.none,
                    ),
                  ),
                  lineBarsData: List.generate(
                    spotsList.length,
                        (index) =>
                        _buildLine(spotsList[index], widget.lineColors[index]),
                  ),
                  lineTouchData: _buildTooltip(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildTooltip() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        showOnTopOfTheChartBoxArea: true,
        tooltipRoundedRadius: 8,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tooltipMargin: 20,
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipItems: (touchedSpots) {
          return touchedSpots.asMap().entries.map((entry) {
            int reverseIndex = entry.value.barIndex;
            final spot = entry.value;
            return LineTooltipItem(
              '${widget.lineTitles[reverseIndex]} - ${spot.y.toStringAsFixed(2)}',
              const TextStyle(
                fontSize: 8,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    );
  }

  _buildLine(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 1,
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.2),
      ),
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: color,
            strokeWidth: 1,
            strokeColor: color,
          );
        },
      ),
    );
  }

  List<Widget> _buildLegend(List<Color> colors, List<String> labels) {
    return List.generate(colors.length, (index) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLegendItem(labels[index], colors[index]),
          if (index < colors.length - 1) const ui.UiSpace.horizontal(10),
        ],
      );
    }).expand((widget) => widget.children).toList();
  }

  _buildLegendItem(String label, Color color) {
    double indexIconSize = 8;
    return Row(
      children: [
        Container(
          color: color,
          width: indexIconSize,
          height: indexIconSize,
        ),
        const ui.UiSpace.horizontal(3),
        ui.UiTextNew.b3Regular(label),
      ],
    );
  }
}
