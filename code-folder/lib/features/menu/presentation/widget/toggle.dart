import 'package:flutter/material.dart';

class SegmentedToggle extends StatelessWidget {
  final List<Widget> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String title;

  final Color activeColor;
  final Color inactiveColor;

  const SegmentedToggle({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.white,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: screenWidth * 0.15,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(
            color: inactiveColor,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: List.generate(options.length, (index) {
              final bool isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? activeColor : inactiveColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: options[index],
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: screenWidth * 0.015),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
