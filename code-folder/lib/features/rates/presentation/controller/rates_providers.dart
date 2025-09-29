import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");
final selectedCurrencyProvider = StateProvider<String?>((ref) => "USD");

final topCurrenciesProvider = StateProvider<List<Map<String, String>>>(
  (ref) => [
    {"flag": "🇶🇦", "code": "QAR", "rate": "1.00"},
    {"flag": "🇺🇸", "code": "USD", "rate": "2.73"},
  ],
);

final fxlistSelectedAlphabetProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

final currentAlphabetProvider = StateProvider<String?>((ref) => null);
