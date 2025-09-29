import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardNumberProvider = StateProvider.autoDispose<String?>((ref) => null);

final pinNumberProvider = StateProvider.autoDispose<String?>((ref) => null);

final cardFocusNodeProvider = Provider.autoDispose<FocusNode>(
  (ref) => FocusNode(),
);
final pinFocusNodeProvider = Provider.autoDispose<FocusNode>(
  (ref) => FocusNode(),
);

final isVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);
final canResendOtpController = StateProvider<bool>((ref) => false);
final otpController = StateProvider<String>((ref) => '');

// Holds the entered username
final usernameProvider = StateProvider.autoDispose<String?>((ref) => null);

// Checks availability (dummy logic: username length > 7)
final isAvailableProvider = Provider<bool>((ref) {
  final username = ref.watch(usernameProvider);
  return (username?.length ?? 0) > 7;
});

// Available usernames suggestions
final availableUsernamesProvider = Provider<List<String>>((ref) {
  return ['userName1', 'userName2', 'userName3'];
});
