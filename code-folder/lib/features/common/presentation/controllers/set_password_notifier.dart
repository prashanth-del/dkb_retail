import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/password_rules_entites/password_rules.dart';

class PasswordValidationState {
  final String input;
  final List<String> failedRules;

  bool get isValid => input.isNotEmpty && failedRules.isEmpty;

  PasswordValidationState({this.input = '', this.failedRules = const []});

  PasswordValidationState copyWith({String? input, List<String>? failedRules}) {
    return PasswordValidationState(
      input: input ?? this.input,
      failedRules: failedRules ?? this.failedRules,
    );
  }
}

class PasswordValidationNotifier
    extends StateNotifier<PasswordValidationState> {
  PasswordValidationNotifier() : super(PasswordValidationState());

  void validate(String input, List<PasswordRules> rules) {
    // 🧩 If input is empty — mark all rules as failed
    final allFailed = rules.map((e) => e.ruleDescription).toList();
    if (input.isEmpty || input == '') {
      state = state.copyWith(input: input, failedRules: allFailed);
      return;
    }

    final failed = <String>[];

    for (final rule in rules) {
      final pattern = rule.validationPattern;

      // 🧮 Handle length condition (e.g., "length>=8")
      if (pattern.startsWith('length>=')) {
        final lengthRequired = int.tryParse(pattern.split('>=')[1]) ?? 0;
        if (input.length < lengthRequired) {
          failed.add(rule.ruleDescription);
        }
      } else {
        try {
          String finalPattern = pattern;

          if (pattern.startsWith(r'\')) {
            finalPattern = pattern;
          } else if (!(pattern.startsWith('[') && pattern.endsWith(']'))) {
            finalPattern = '[$pattern]';
          }

          final regex = RegExp(finalPattern.replaceAll('\\\\', '\\'));
          if (!regex.hasMatch(input)) {
            failed.add(rule.ruleDescription);
          }
        } catch (e) {
          debugPrint('⚠️ Invalid regex pattern from rule: $pattern');
        }
      }
    }

    // ✅ Update state with the new validation result
    state = state.copyWith(input: input, failedRules: failed);
  }
}

final passwordValidationNotifierProvider =
    StateNotifierProvider.autoDispose<
      PasswordValidationNotifier,
      PasswordValidationState
    >((ref) => PasswordValidationNotifier());
