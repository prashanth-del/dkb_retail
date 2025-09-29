import 'dart:io';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UICalendar {
  Future<DateTime?> pickDateTime(BuildContext context,
      {required DateTime initialDate,
        required DateTime firstDate,
        required DateTime lastDate,
        required Locale? locale,
        bool isTimePicker = false}) async {
    return await showPlatformDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      isTimePicker: isTimePicker,
    );
  }

  Future<DateTime?> showPlatformDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Locale? locale,
    bool isTimePicker = false,
  }) async {
    if (Platform.isIOS) {
      return _showCupertinoDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
        isTimePicker: isTimePicker,
      );
    } else {
      return _showMaterialDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
      );
    }
  }

  Future<DateTime?> _showCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Locale? locale,
    bool isTimePicker = false,
  }) async {
    if (isTimePicker) {
      return await showModalBottomSheet<DateTime?>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        builder: (context) {
          DateTime? dateTime = initialDate;
          return SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Divider
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: DefaultColors.gray96,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CupertinoButton(
                      child: Text(
                        locale == const Locale('en') ? 'Cancel' : 'إلغاء',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(),
                    CupertinoButton(
                      child: Text(
                        locale == const Locale('en') ? 'Done' : 'تم',
                        style: TextStyle(
                          color: DefaultColors.blue9D,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(dateTime);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (value) {
                      dateTime = value;
                    },
                    initialDateTime: initialDate,
                    minimumDate: firstDate,
                    maximumDate: lastDate,
                    mode: isTimePicker
                        ? CupertinoDatePickerMode.time
                        : CupertinoDatePickerMode.date,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (context) {
          DateTime? dateTime = initialDate;
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Row(
                  children: [
                    CupertinoButton(
                      child: Text(
                        locale == const Locale('en') ? 'Cancel' : 'إلغاء',
                        style: TextStyle(
                          color: DefaultColors.red64,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(),
                    CupertinoButton(
                      child: Text(
                        locale == const Locale('en') ? 'Done' : 'تم',
                        style: TextStyle(
                          color: DefaultColors.blue9D,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(dateTime);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: firstDate,
                    maximumDate: lastDate,
                    onDateTimeChanged: (DateTime newDate) {
                      dateTime = newDate;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<DateTime?> _showMaterialDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Locale? locale,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,

      lastDate: lastDate,
      locale: locale,
    );
  }
}
