import 'dart:developer';

import 'package:dkb_retail/features/common/domain/entities/password_rules_entites/password_rules.dart';
import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:dkb_retail/features/common/domain/repositories/common_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/utils.dart';
import '../../data/models/otp_generate_models/generate_otp_request.dart';
import '../../data/models/otp_validate_models/validate_otp_request.dart';
import '../../data/models/update_password_models/update_password2_request.dart';
import '../../domain/entities/otp_generate_entities/otp_generate.dart';
import '../../domain/entities/otp_validate_entites/otp_validate.dart';
import '../state/update_password2_state.dart';

part 'common_notifier.g.dart';

@riverpod
class CommonNotifier extends _$CommonNotifier {
  @override
  FutureOr<dynamic> build() async {
    return future;
  }

  CommonRepository get _cardvalidationrepository =>
      ref.read(commonRepositoryProvider);

  String? lastCommonErrorMessage;

  Future<List<PasswordRules>> getPasswordRules() async {
    state = const AsyncLoading();
    final failureOrSuccess = await _cardvalidationrepository.getPasswordRules();

    state = failureOrSuccess.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) {
        consoleLog('password rules success $r');
        return AsyncData(r);
      },
    );
    return [];
  }

  Future<void> updatePassword2({
    required UpdatePassword2Request request,
  }) async {
    state = const AsyncLoading();
    ;
    final result = await _cardvalidationrepository.updatePassword2(
      request: request,
    );

    result.fold(
      (err) => state = AsyncError(
        err.description ?? err.mwdesc ?? 'Server Error!',
        StackTrace.current,
      ),
      (data) {
        state = AsyncData(data);
      },
    );
  }

  Future<OtpGenerate?> generateOtp({
    required GenerateOtpRequest request,
  }) async {
    state = const AsyncLoading();

    final result = await _cardvalidationrepository.generateOtp(request: request);

    return result.fold(
          (err) {
        state = AsyncError(
          err.description ?? err.mwdesc ?? 'Server Error!',
          StackTrace.current,
        );
        return null;
      },
          (data) {
        consoleLog('OTP generated successfully');
        state = AsyncData(data);
        return data;
      },
    );
  }

  Future<OtpValidate?> validateOtp({
    required ValidateOtpRequest request,
  }) async {
    state = const AsyncLoading();

    final result = await _cardvalidationrepository.validateOtp(request: request);

    return result.fold(
          (err) {
        state = AsyncError(
          err.description ?? err.mwdesc ?? 'Server Error!',
          StackTrace.current,
        );
        return null;
      },
          (data) {
        consoleLog('OTP validated successfully');
        state = AsyncData(data);
        return data;
      },
    );
  }

  Future<bool> generateOtpWithResult(GenerateOtpRequest request) async {
    try {
      final result = await generateOtp(request: request);
      if (result == null) {
        final error = (state is AsyncError)
            ? (state as AsyncError).error?.toString()
            : 'Failed to generate OTP';
        lastCommonErrorMessage = error;
        return false;
      }
      return true;
    } catch (e) {
      lastCommonErrorMessage = e.toString();
      return false;
    }
  }

}
