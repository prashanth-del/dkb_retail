import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<List<double>> yPointsList;
  final List<String> xLabels;
  final double minY;
  final double maxY;
  final double padding = 40.0;
  final List<Color> lineColors;
  final List<String> lineTitles;

  LineChartPainter({
    required this.yPointsList,
    required this.xLabels,
    required this.minY,
    required this.maxY,
    required this.lineColors,
    required this.lineTitles,
  });

  String formatValue(double value) {
    if (value >= 100000) {
      return '${(value / 100000).toStringAsFixed(1)}L';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(1);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double xInterval = (size.width - 2 * padding) / (xLabels.length - 1.5);
    double yInterval = size.height / (maxY - minY);

    // Draw x-axis
    Paint xPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(5, size.height), Offset(size.width, size.height), xPaint);

    // Draw y-axis labels and horizontal grid lines
    Paint gridPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    double yStep = (maxY - minY) / 5;
    for (int i = 0; i <= 5; i++) {
      double yValue = minY + (yStep * i);
      double y = size.height - ((yValue - minY) * yInterval);

      // Draw horizontal grid line
      canvas.drawLine(Offset(5, y), Offset(size.width, y), gridPaint);

      // Draw y-axis label
      textPainter.text = TextSpan(
        text: formatValue(yValue),
        style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(0 - textPainter.width - 4, y - textPainter.height / 2));
    }

    // Draw x-axis labels
    // for (int i = 0; i < xLabels.length; i++) {
    for (int i = 0; i < 6; i++) {
      double x = padding + xInterval * i;
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, size.height + 2));
    }

    // Draw lines
    for (int k = 0; k < yPointsList.length; k++) {
      List<double> yPoints = yPointsList[k];
      Paint paint = Paint()
        ..color = lineColors[k]
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      Path path = Path();

      if (yPoints.isNotEmpty) {
        double x = padding;
        double y = size.height - ((yPoints[0] - minY) * yInterval);
        path.moveTo(x, y);

        // for (int i = 1; i < yPoints.length; i++) {
        for (int i = 1; i < 6; i++) {
          double x1 = x + xInterval / 2;
          double y1 = y;
          x = padding + xInterval * i;
          y = size.height - ((yPoints[i] - minY) * yInterval);
          double x2 = x - xInterval / 2;
          double y2 = y;
          path.cubicTo(x1, y1, x2, y2, x, y);
        }
      }

      canvas.drawPath(path, paint);

      //Draw Points
      Paint pointPaint = Paint()
        ..color = Colors.transparent
        ..strokeWidth = 4
        ..style = PaintingStyle.fill;

      for (int i = 0; i < yPoints.length; i++) {
        double x = padding + xInterval * i;
        double y = size.height - ((yPoints[i] - minY) * yInterval);
        canvas.drawCircle(Offset(x, y), 4, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}