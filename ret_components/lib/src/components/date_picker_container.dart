import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class DatePickerContainer extends StatefulWidget {
  final DateTime? initialDate;
  final String? label;
  final int yearCount;
  final UiTextNew? labelUiText;
  final Function(DateTime?) onDateSelected;
  final String formatSymbol;
  final String hintText;
  final Widget? suffixIcon;
  final DateTime? selectedDate;
  final bool showPicker;
  final bool isEndDate; // New boolean for end date check
  final Color? borderColor;

  const DatePickerContainer(
      {super.key,
      this.initialDate,
      this.label,
      this.yearCount = 1,
      this.labelUiText,
      required this.selectedDate,
      required this.onDateSelected,
      this.suffixIcon,
      this.showPicker = true,
      this.formatSymbol = "/",
      this.hintText = "dd/mm/yyyy",
      this.isEndDate = false, // Default to false
      this.borderColor,
      });

  @override
  _DatePickerContainerState createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {

  String _formatDate(DateTime? date) {
    if (date == null) {
      return widget.hintText;
    }
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day${widget.formatSymbol}$month${widget.formatSymbol}$year';
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    DateTime futureDate =
        (widget.initialDate ?? now).add(const Duration(days: 90));
    DateTime lastDate = futureDate.isAfter(now) ? now : futureDate;

    DateTime firstDate =
        DateTime(now.year - widget.yearCount, now.month, now.day);

    if (widget.isEndDate && widget.initialDate != null) {
      firstDate = widget.initialDate!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: DefaultColors.white_800),
          ),
        if (widget.labelUiText != null) widget.labelUiText!,
        if (widget.label != null || widget.labelUiText != null)
          const UiSpace.vertical(5),
        GestureDetector(
          onTap: () async {
            if (!widget.showPicker) return;
            final pickedDate = await UICalendar().pickDateTime(
              context,
              initialDate: widget.initialDate ?? now,
              firstDate: firstDate,
              lastDate: lastDate,
              locale: const Locale('en'),
              isTimePicker: false,
            );
            // if (pickedDate = null) {
            widget.onDateSelected(pickedDate);
            // }
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: widget.borderColor ?? DefaultColors.blueLightSteel, width: 0.7),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(widget.selectedDate),
                  style: widget.selectedDate == null ? TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      color: DefaultColors.grayB3
                  ) :
                  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: widget.selectedDate == null
                          ? DefaultColors.white_600
                          : DefaultColors.white_800)
                  ,
                ),
                if (widget.suffixIcon != null) widget.suffixIcon!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
