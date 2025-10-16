import 'package:dkb_retail/features/common/domain/locators/common_locators.dart';
import 'package:dkb_retail/features/common/domain/repositories/common_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../common/data/models/otp_generate_models/generate_otp_request.dart';
import '../../../../common/data/models/otp_generate_models/generate_otp_request_request_info_dto.dart';
import '../../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../../common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import '../../../data/models/sign_in_with_credentials_models/signwith_credentials_request.dart';
import '../../../data/models/sign_in_with_credentials_models/signwith_credentials_request_body_dto.dart';
import '../../../data/models/sign_in_with_credentials_models/signwith_credentials_request_body_raw_dto.dart';
import '../../../domain/locator/login_locator.dart';
import '../../../domain/repository/login_failure.dart';
import '../../../domain/repository/login_repository.dart';
import '../login_providers.dart';
import '../../state/login_state.dart';

part 'login_notifiers.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState.initial();
  }

  LoginRepository get _repository => ref.read(loginRepoProvider);
  CommonRepository get _commonrepository => ref.read(commonRepositoryProvider);

  Future<void> signWithUsernamePassword({
    required String customerId,
    required String username,
    required String password,
  }) async {
    ref.read(loadingProvider.notifier).state = true;
    state = const LoginState.loading();
    final result = await _repository.signWithCredentials(
      request: SignwithCredentialsRequest(
        body: SignwithCredentialsRequestBodyDto(
          raw: SignwithCredentialsRequestBodyRawDto(
            userId: username,
            clientSalt: 'defaultClientSalt',
            loginChannel: "WEB",
            password: password,
          ),
        ),
      ),
    );

    ref.read(loadingProvider.notifier).state = false;

    result.fold(
      (err) => state = LoginState.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) {
        state = LoginState.success(data);
      },
    );
  }

  Future<void> validateOtp(String otp) async {
    ref.read(loadingProvider.notifier).state = true;
    state = const LoginState.loading();
    final request = ValidateOtpRequest(
      requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
    );
    final failureOrNone = await _commonrepository.validateOtp(request: request);

    state = failureOrNone.fold(
      (failure) {
        ref.read(loadingProvider.notifier).state = false;

        return LoginState.failure(switch (failure) {
          ServiceFailure(message: var m) => m,
          InternetFailure(message: var m) => m,
          ServerFailure(message: var m) => m,
          InvalidOtp(message: var m) => m,
          MaxOtpAttempted(message: var m) => m,
          // TODO: Handle this case.
          Object() => throw UnimplementedError(),
        });
      },
      (otpvalidate) {
        ref.read(loadingProvider.notifier).state = false;
        return const LoginState.otpValid();
      },
    );
  }

  Future<void> resendOtp() async {
    ref.read(loadingProvider.notifier).state = true;
    state = const LoginState.loading();
    final failureOrNone = await _repository.resendOtp();

    state = failureOrNone.fold(
      () {
        ref.read(loadingProvider.notifier).state = false;
        return const LoginState.otpResent();
      },
      (failure) {
        ref.read(loadingProvider.notifier).state = false;
        return LoginState.failure(switch (failure) {
          ServiceFailure(message: var m) => m,
          InternetFailure(message: var m) => m,
          ServerFailure(message: var m) => m,
          InvalidOtp(message: var m) => m,
          MaxOtpAttempted(message: var m) => m,
        });
      },
    );
  }

  //
  // Future<void> logout() async {
  //   ref.read(loadingProvider.notifier).state = true;
  //   state = const LoginState.loading();
  //   final failureOrNone = await _repository.logout();
  //
  //   state = failureOrNone.fold(
  //         () {
  //       ref.read(loadingProvider.notifier).state = false;
  //       ref.read(logoutStatusProvider.notifier).state = LogoutStatus.success;
  //
  //       // Clear the user profile on successful logout
  //       // ref.read(userProfileProvider.notifier).clearProfile();
  //
  //       return const LoginState.logout();
  //     },
  //         (failure) {
  //       ref.read(loadingProvider.notifier).state = false;
  //       return LoginState.failure(switch (failure) {
  //         ServiceFailure(message: var m) => m,
  //         InternetFailure(message: var m) => m,
  //         ServerFailure(message: var m) => m,
  //         InvalidOtp(message: var m) => m,
  //         MaxOtpAttempted(message: var m) => m,
  //       });
  //     },
  //   );
  // }
  //
  // Future<void> changePassword({required String oldPassword, required String newPassword, required bool isLogin}) async {
  //   ref.read(loadingProvider.notifier).state = true;
  //   state = const LoginState.loading();
  //   final failureOrNone = await _repository.changePassword(oldPassword: oldPassword, newPassword: newPassword, isLogin: isLogin);
  //
  //   state = failureOrNone.fold(
  //         () {
  //       ref.read(loadingProvider.notifier).state = false;
  //       return const LoginState.passwordReset();
  //     },
  //         (failure) {
  //       ref.read(loadingProvider.notifier).state = false;
  //       return LoginState.changePasswordFailure(switch (failure) {
  //         ServiceFailure(message: var m) => m,
  //         InternetFailure(message: var m) => m,
  //         ServerFailure(message: var m) => m,
  //         InvalidOtp(message: var m) => m,
  //         MaxOtpAttempted(message: var m) => m,
  //       });
  //     },
  //   );
  // }
}
