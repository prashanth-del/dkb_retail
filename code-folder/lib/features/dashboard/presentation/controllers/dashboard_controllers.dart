import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeDashBoardIndex = StateProvider<int>((ref) => 0);
final selectedTransferType = StateProvider<String>((ref) => "domestic");
final isBalanceVisibleAccounts = StateProvider<bool>((ref) => false);

/// Provider to hold quick action container animation controller value
final animationValueProvider = StateProvider<double>((ref) => 0.0);

/// Provider to hold quick action container animation controller value
final selectedCurrencyProvider = StateProvider<String>((ref) => "QAR");
