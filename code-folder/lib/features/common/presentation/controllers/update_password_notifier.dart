import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/update_password_models/update_password2_request.dart';
import '../../domain/repositories/common_repository.dart';
import '../state/update_password2_state.dart';

part 'update_password_notifier.g.dart';

@riverpod
class UpdatePasswordNotifier extends _$UpdatePasswordNotifier {
  @override
  UpdatePassword2State build() => const UpdatePassword2State.initial();

  CommonRepository get _repo => ref.read(commonRepositoryProvider);

  Future<void> updatePassword2({
    required UpdatePassword2Request request,
  }) async {
    state = const UpdatePassword2State.loading();
    final result = await _repo.updatePassword2(request: request);

    result.fold(
      (err) => state = UpdatePassword2State.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) {
        state = UpdatePassword2State.success(data);
      },
    );
  }
}
