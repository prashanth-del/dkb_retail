import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/generate_otp_state.dart';
import '../../domain/repositories/common_repository.dart';
import '../../data/models/otp_generate_models/generate_otp_request.dart';

part 'generate_otp_notifier.g.dart';

@riverpod
class GenerateOtpNotifier extends _$GenerateOtpNotifier {
  @override
  GenerateOtpState build() => const GenerateOtpState.initial();

  CommonRepository get _repo => ref.read(commonRepositoryProvider);

    Future<void> generateOtp({ required GenerateOtpRequest request, }) async {
    state = const GenerateOtpState.loading();
    final result = await _repo.generateOtp(request: request);

    result.fold(
      (err) => state = GenerateOtpState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = GenerateOtpState.success(data);
      },
    );
  }
}
