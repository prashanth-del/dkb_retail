import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class DateRangePicker extends StatelessWidget {
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final ValueChanged<DateTime?> onStartDateSelected;
  final ValueChanged<DateTime?> onEndDateSelected;

  const DateRangePicker({
    Key? key,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
  }) : super(key: key);

  Future<void> _pickDate(
    BuildContext context,
    DateTime initialDate,
    ValueChanged<DateTime?> onDatePicked, {
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      onDatePicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _pickDate(
              context,
              selectedStartDate ?? DateTime.now().subtract(Duration(days: 7)),
              onStartDateSelected,
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime.now().subtract(Duration(days: 7)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9E5F0), width: 2),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedStartDate == null)
                    const Text(
                      "Start Date",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  if (selectedStartDate != null)
                    Text(
                      "${selectedStartDate?.day}-${selectedStartDate?.month}-${selectedStartDate?.year}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  const Icon(Icons.calendar_today, color: DefaultColors.primaryBlue),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: GestureDetector(
            onTap: () => selectedStartDate != null
                ? _pickDate(
                    context,
                    selectedStartDate!,
                    onEndDateSelected,
                    firstDate: selectedStartDate!,
                    lastDate: selectedStartDate!.add(const Duration(days: 7)),
                  )
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9E5F0), width: 2),
                color:
                    selectedStartDate != null ? Colors.white : Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedEndDate == null)
                    Text(
                      "End Date",
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedStartDate != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  if (selectedEndDate != null)
                    Text(
                      "${selectedEndDate?.day}-${selectedEndDate?.month}-${selectedEndDate?.year}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  Icon(
                    Icons.calendar_today,
                    color: selectedStartDate != null
                        ? DefaultColors.primaryBlue
                        : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
