import 'dart:math';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';

class DonutChartPainter extends CustomPainter {
  final List<DonutChartData> data;

  DonutChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.fold(0, (sum, item) => sum + item.value);
    double startAngle = -pi / 2;

    double radius = min(size.width / 2, size.height / 2); // Outer radius of donut
    double donutWidth = 40; // Width of the donut
    double innerRadius = radius - donutWidth; // Inner radius of donut

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = donutWidth
      ..strokeCap = StrokeCap.butt; // Ensure the stroke is not rounded

    for (var segment in data) {
      final sweepAngle = (segment.value / total) * 2 * pi;
      paint.color = segment.color;

      // Draw the segment of the donut
      canvas.drawArc(
        Rect.fromLTWH(
          size.width / 2 - radius,
          size.height / 2 - radius,
          radius * 2,
          radius * 2,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      // Calculate the midpoint angle of the segment
      final middleAngle = startAngle + sweepAngle / 2;
      final textRadius = (radius - donutWidth / 20); // Adjust the textRadius for proper centering

      // Calculate the position for the text
      final textX = size.width / 2 + textRadius * cos(middleAngle);
      final textY = size.height / 2 + textRadius * sin(middleAngle);

      // Draw a debug marker for text position (optional)

      // Create text painter
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '${(segment.value / total * 100).toStringAsFixed(2)}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Paint text centered on the calculated position
      textPainter.paint(
        canvas,
        Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}