import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/otp_validate_models/validate_otp_request.dart';
import '../state/validate_otp_state.dart';
import '../../domain/repositories/common_repository.dart';

part 'validate_otp_notifier.g.dart';

@riverpod
class ValidateOtpNotifier extends _$ValidateOtpNotifier {
  @override
  ValidateOtpState build() => const ValidateOtpState.initial();

  CommonRepository get _repo => ref.read(commonRepositoryProvider);

    Future<void> validateOtp({ required ValidateOtpRequest request, }) async {
    state = const ValidateOtpState.loading();
    final result = await _repo.validateOtp(request: request);

    result.fold(
      (err) => state = ValidateOtpState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = ValidateOtpState.success(data);
      },
    );
  }
}
