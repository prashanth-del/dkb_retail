import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    ); // keep digits only
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i % 4 == 0 && i != 0) formatted += ' ';
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
