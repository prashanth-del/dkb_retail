import 'package:dkb_retail/features/registration/data/models/username_validation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsernameNotifier extends StateNotifier<UsernameValidation> {
  UsernameNotifier() : super(const UsernameValidation());

  void validate(String username) {
    if (username.isEmpty) {
      // reset validation state
      state = const UsernameValidation();
      return;
    }
    state = UsernameValidation.check(username);
  }
}

final usernamevalidationProvider =
    StateNotifierProvider.autoDispose<UsernameNotifier, UsernameValidation>(
      (ref) => UsernameNotifier(),
    );
