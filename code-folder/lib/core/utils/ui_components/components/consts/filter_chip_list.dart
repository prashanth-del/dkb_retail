import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class FilterChipList extends StatelessWidget {
  final List<String> channels;
  final List<String> selectedChannels;
  final ValueChanged<List<String>> onSelectionChanged;

  const FilterChipList({
    Key? key,
    required this.channels,
    required this.selectedChannels,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 8.0,
      children: channels.map((channel) {
        return FilterChip(
          color: WidgetStateColor.resolveWith((_) => DefaultColors.primaryBlue),
          label: Text(
            channel,
            style: const TextStyle(fontSize: 12, color: DefaultColors.white),
          ),
          checkmarkColor: DefaultColors.white,
          selectedColor: Color(0xFFD9E5F0),
          backgroundColor: Colors.grey.shade200,
          selected: selectedChannels.contains(channel),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: selectedChannels.contains(channel)
                  ? DefaultColors.primaryBlue
                  : Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          onSelected: (selected) {
            List<String> updatedSelection = List.from(selectedChannels);
            if (selected) {
              updatedSelection.add(channel);
            } else {
              updatedSelection.remove(channel);
            }
            onSelectionChanged(updatedSelection);
          },
        );
      }).toList(),
    );
  }
}
