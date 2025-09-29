import 'package:flutter/services.dart';

class AvoidSpecialCharacterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value contains only alphanumeric characters
    if (RegExp(r'^[a-zA-Z0-9]*$').hasMatch(newValue.text)) {
      // If valid, return the new value
      return newValue;
    }
    // If invalid, return the old value
    return oldValue;
  }
}