import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class UICalender2 {

  static Future<void> showAsBottomSheetRangePicker({
    required BuildContext context,
    required void Function(List<DateTime?> selectedDateTime)? onValueChanged,
    List<DateTime?> selectedValues = const [],
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
          height: 370,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.range,
            ),
            value: selectedValues,
            onValueChanged: onValueChanged,
          ),
        );
      },
    );
  }
}
