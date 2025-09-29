import 'package:dkb_retail/features/login/presentation/controller/state/user_profile_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/locator/login_locator.dart';
import '../../../domain/repository/login_failure.dart';
import '../../../domain/repository/login_repository.dart';
import '../login_providers.dart';
import 'login_state.dart';

part 'login_notifiers.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState.initial();
  }

  LoginRepository get _repository => ref.read(loginRepoProvider);

  Future<void> signInWithUsernamePassword({
    required String customerId,
    required String username,
    required String password,
  }) async {
    ref.read(loadingProvider.notifier).state = true;
    state = const LoginState.loading();
    final failureOrSuccess = await _repository.signInUsingUsernamePassword(
      customerId: customerId,
      username: username,
      password: password,
    );

    state = failureOrSuccess.fold(
      (failures) {
        ref.read(loadingProvider.notifier).state = false;
        return LoginState.failure(switch (failures) {
          ServiceFailure(message: var m) => m,
          InternetFailure(message: var m) => m,
          ServerFailure(message: var m) => m,
          InvalidOtp() => '',
          MaxOtpAttempted(message: var m) => m,
        });
      },
      (user) {
        ref.read(loadingProvider.notifier).state = false;

        // Only create UserProfile if userId and customerNumber are not null
        if (user.userId != null && user.customerNumber != null) {
          final userProfile = UserProfile(
            userName: user.userId!,
            customerNumber: user.customerNumber!,
            dcUserName: user.dcUserName,
            userRole: mapStringToUserRoleType(user.userRole),
          );

          ref.read(userProfileProvider.notifier).updateUserProfile(userProfile);
        }

        return LoginState.success(user);
      },
    );
  }

  Future<void> validateOtp(String otp) async {
    ref.read(loadingProvider.notifier).state = true;
    state = const LoginState.loading();
    final failureOrNone = await _repository.validateOtp(otp: otp);

    state = failureOrNone.fold(
      () {
        ref.read(loadingProvider.notifier).state = false;
        return const LoginState.otpValid();
      },
      (failure) {
        ref.read(loadingProvider.notifier).state = false;
        if (failure is MaxOtpAttempted) {
          return LoginState.maxAttempted(switch (failure) {
            ServiceFailure(message: var m) => m,
            InternetFailure(message: var m) => m,
            ServerFailure(message: var m) => m,
            InvalidOtp(message: var m) => m,
            MaxOtpAttempted(message: var m) => m,
          });
        } else {
          return LoginState.failure(switch (failure) {
            ServiceFailure(message: var m) => m,
            InternetFailure(message: var m) => m,
            ServerFailure(message: var m) => m,
            InvalidOtp(message: var m) => m,
            MaxOtpAttempted(message: var m) => m,
            // TODO: Handle this case.
            Object() => throw UnimplementedError(),
            // TODO: Handle this case.
            null => throw UnimplementedError(),
          });
        }
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

  Future<void> signInWithPassword({required String password}) async {
    await signInWithUsernamePassword(
      customerId: "1207026",
      username: "apr1207026",
      password: password,
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
