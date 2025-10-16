import 'package:dkb_retail/features/forgot_password/data/models/validate_username_models/validate_username_request_request_info_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/locator/forgot_password_locator.dart';
import '../../state/validate_username_state.dart';
import '../../../domain/repositories/forgot_password_repository.dart';

import '../../../data/models/validate_username_models/validate_username_request.dart';

part 'validate_username_notifier.g.dart';

@riverpod
class ValidateUsernameNotifier extends _$ValidateUsernameNotifier {
  @override
  ValidateUsernameState build() => const ValidateUsernameState.initial();

  ForgotPasswordRepository get _repo => ref.read(forgotPasswordRepoProvider);

  Future<void> validateUsername({required String username}) async {
    state = const ValidateUsernameState.loading();
    final result = await _repo.validateUsername(
      request: ValidateUsernameRequest(
        requestInfo: ValidateUsernameRequestRequestInfoDto(userId: username),
      ),
    );

    result.fold(
      (err) => state = ValidateUsernameState.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) {
        state = ValidateUsernameState.success(data);
      },
    );
  }
}
