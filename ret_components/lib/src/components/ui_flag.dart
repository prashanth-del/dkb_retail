import 'package:flutter/material.dart';

class L10n {

  static final all = [
    const Locale('en'),
    const Locale('ar')
  ];

  static String getFlag(String countryCode) {
    try {
      return _extractFlag(countryCode);
    } catch (e) {
      return _extractFlag('US');
    }
  }

  static String _extractFlag(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji =
        String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return emoji;
  }

  static String getLang(String code) {
    switch (code) {
      case 'en':
        String lang = 'English';
        return lang;

      case 'ar':
        String lang = 'عربي';
        return lang;

      default:
        String lang = 'English';
        return lang;

    }
  }
}