import 'dart:convert';
import 'package:flutter/services.dart';

class Flag {
  final String code;
  final String? name;
  final String? country;
  final String? countryCode;
  final String flag;

  Flag({
    required this.code,
    this.name,
    this.country,
    this.countryCode,
    required this.flag,
  });

  static Future<List<Flag>> loadFlags() async {
    final jsonString = await rootBundle.loadString('assets/json/flag.json');
    final List<dynamic> jsonList = json.decode(jsonString)['flags'];
    return jsonList
        .map((json) => Flag(
        code: json['code'],
        flag: json['flag'],
        countryCode: json['countryCode'],
        country: json['country'],
        name: json['name']))
        .toList();
  }
}
