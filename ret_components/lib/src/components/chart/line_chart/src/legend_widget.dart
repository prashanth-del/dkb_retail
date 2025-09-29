import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  final List<Color> lineColors;
  final List<String> lineTitles;

  const LegendWidget({
    super.key,
    required this.lineColors,
    required this.lineTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(lineTitles.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                color: lineColors[index],
              ),
              const SizedBox(width: 4),
              Text(
                lineTitles[index],
                style: const TextStyle(fontSize: 12),

              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      }),
    );
  }
}