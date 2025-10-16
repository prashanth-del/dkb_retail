import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/domain/entities/username_rules_modal.dart';
import 'package:dkb_retail/features/registration/domain/locator/username_validation_locator.dart';
import 'package:dkb_retail/features/registration/domain/repository/username_rules_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'username_rule_notifier.g.dart';

@riverpod
class UsernameRuleNotifier extends _$UsernameRuleNotifier {
  @override
  FutureOr<dynamic> build() async {
    return future;
  }

  UsernameRulesRepository get _usernameRulesRepository =>
      ref.read(usernameValidationsRepoProvider);

  Future<List<UsernameRulesModal>> getUsernameValidations() async {
    state = const AsyncLoading();
    final failureOrSuccess = await _usernameRulesRepository
        .getUsernameValidations();

    state = failureOrSuccess.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) {
        consoleLog('username validation success $r');
        return AsyncData(r);
      },
    );
    return [];
  }
}

// @riverpod
// class UsernameRuleNotifier extends _$UsernameRuleNotifier {
//   @override
//   FutureOr<List<UsernameRulesModal>> build() async {
//     return _fetchUsernameValidations();
//   }

//   UsernameRulesRepository get _usernameRulesRepository =>
//       ref.read(usernameValidationsRepoProvider);

//   Future<List<UsernameRulesModal>> _fetchUsernameValidations() async {
//     final failureOrSuccess = await _usernameRulesRepository
//         .getUsernameValidations();

//     return failureOrSuccess.fold(
//       (failure) => throw Exception(failure.message),
//       (rules) {
//         consoleLog('Username validation rules fetched: $rules');
//         return rules;
//       },
//     );
//   }

//   /// Call this manually if you want to refresh rules
//   Future<void> getUsernameValidations() async {
//     state = const AsyncLoading();
//     try {
//       final rules = await _fetchUsernameValidations();
//       state = AsyncData(rules);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
// }
