import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  static const Color fallback = Colors.transparent;

  @override
  Color fromJson(String? radixString) {
    if (radixString == null) return fallback;
    final int? colorValue = int.tryParse(radixString, radix: 16);
    return colorValue == null ? fallback : Color(colorValue);
  }

  @override
  String toJson(Color color) => color.value.toRadixString(16);
}
