import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/domain/entities/username_rules_modal.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_rule_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernamerulesProvider = Provider.autoDispose<List<UsernameRulesModal>>((
  ref,
) {
  final data = ref.watch(usernameRuleNotifierProvider);

  return data.when(
    data: (data) {
      consoleLog('******************data************* $data ');
      return data as List<UsernameRulesModal>;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// State for validation results
class UsernameValidationState {
  final String input;
  final List<String> failedRules;

  bool get isValid => input.isNotEmpty && failedRules.isEmpty;

  UsernameValidationState({this.input = '', this.failedRules = const []});

  UsernameValidationState copyWith({String? input, List<String>? failedRules}) {
    return UsernameValidationState(
      input: input ?? this.input,
      failedRules: failedRules ?? this.failedRules,
    );
  }
}

/// Notifier for validating user input dynamically
class UsernameValidationNotifier
    extends StateNotifier<UsernameValidationState> {
  UsernameValidationNotifier() : super(UsernameValidationState());

  void validate(String input, List<UsernameRulesModal> rules) {
    final failed = <String>[];

    for (final rule in rules) {
      final pattern = rule.validationPattern;
      // if (pattern == 'length>=8') {
      //   if (input.length < 8) failed.add(rule.ruleDescription);
      // } else {
      //   final regex = RegExp('[$pattern]');
      //   if (!regex.hasMatch(input)) {
      //     failed.add(rule.ruleDescription);
      //   }
      // }
      if (pattern.startsWith('length>=')) {
        // Extract the number from the pattern
        final lengthRequired = int.tryParse(pattern.split('>=')[1]) ?? 0;
        if (input.length < lengthRequired) {
          failed.add(rule.ruleDescription);
        }
      } else {
        // Regex pattern for character types
        final regex = RegExp('[$pattern]');
        if (!regex.hasMatch(input)) {
          failed.add(rule.ruleDescription);
        }
      }
    }

    state = state.copyWith(input: input, failedRules: failed);
  }
}

final usernamevalidationNotifierProvider =
    StateNotifierProvider.autoDispose<
      UsernameValidationNotifier,
      UsernameValidationState
    >((ref) => UsernameValidationNotifier());
