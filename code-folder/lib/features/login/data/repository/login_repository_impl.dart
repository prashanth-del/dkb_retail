import 'package:dkb_retail/features/login/data/models/sign_in_with_credentials_models/signwith_credentials_dto.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/entities/sign_with_credentials_entity/login_response.dart';
import '../../domain/repository/login_failure.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/login_datasource.dart';
import '../models/sign_in_with_credentials_models/signwith_credentials_request.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);
  @override
  Future<Either<ApiError, LoginResponse>> signWithCredentials({
    required SignwithCredentialsRequest request,
  }) async {
    final env = await datasource.signwithCredentials2(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }

  @override
  Future<Option<LoginFailure>> resendOtp() async {
    try {
      final response = await datasource.resendOtp();

      if (!response.ok) {
        return some(LoginFailure.serviceFailure(response.message));
      }

      // Success case
      return none();
    } on ServiceException catch (e) {
      return some(LoginFailure.serviceFailure(e.toString()));
    } catch (e) {
      return some(LoginFailure.serviceFailure(e.toString()));
    }
  }

  @override
  Future<Option<LoginFailure>> validateOtp({required String otp}) async {
    try {
      // Call the datasource
      final response = await datasource.validateOtp(otp: otp);

      // Check for success/failure using ApiEnvelope.ok
      if (!response.ok) {
        // Map specific AppStatus if needed
        switch (response.appStatus) {
          case AppStatus.otpThrottle:
            return some(LoginFailure.maxOtpAttempted(response.message));
          case AppStatus.otpAlreadySent:
            return some(LoginFailure.serviceFailure(response.message));
          case AppStatus.error:
          default:
            return some(LoginFailure.invalidOtp(response.message));
        }
      }

      // Success case
      return none();
    } on ServiceException catch (e) {
      return some(LoginFailure.serviceFailure(e.toString()));
    } catch (e) {
      return some(LoginFailure.serviceFailure(e.toString()));
    }
  }

  // @override
  // Future<Option<LoginFailure>> changePassword(
  //     {required String oldPassword,
  //     required String newPassword,
  //     required bool isLogin}) async {
  //   try {
  //     final response = await datasource.changePassword(
  //         oldPassword: oldPassword, newPassword: newPassword, isLogin: isLogin);
  //     if (response.error != null) {
  //       return some(LoginFailure.serviceFailure(response.error.toString()));
  //     } else {
  //       ApiError resBody = ApiError.fromJson(response.data);
  //       if (resBody.code == '000000') {
  //         return none();
  //       } else {
  //         return some(LoginFailure.serviceFailure(
  //             resBody.description ?? "Error while validating otp"));
  //       }
  //     }
  //   } on ServiceException catch (e) {
  //     return some(LoginFailure.serviceFailure(e.toString()));
  //   }
  // }
  //
  // @override
  // Future<Option<LoginFailure>> logout() async {
  //   try {
  //     final response = await datasource.logout();
  //
  //     if (response.error != null) {
  //       return some(LoginFailure.serviceFailure(response.error.toString()));
  //     } else {
  //       ApiError resBody = ApiError.fromJson(response.data);
  //       if (resBody.code == '000000') {
  //         return none();
  //       } else {
  //         return some(LoginFailure.serviceFailure(
  //             resBody.description ?? "Unable to logout"));
  //       }
  //     }
  //   } on ServiceException catch (e) {
  //     return some(LoginFailure.serviceFailure(e.toString()));
  //   }
  // }
  //
  // @override
  // Future<Either<MenuFailure, List<Menu>>> getMenuItems(String screenId) async {
  //   try {
  //     final response = await datasource.menuItems(screenId: screenId);
  //     if (response.isSuccess) {
  //       if (response.data != null) {
  //         return right(response.data!.data);
  //       } else {
  //         String err =
  //             response.data!.status?.description ?? 'Failed! Please try again.';
  //         return left(MenuFailure.serviceFailure(err));
  //       }
  //     } else {
  //       if (response.error.toString().contains("connection error")) {
  //         return left(const MenuFailure.internetFailure(
  //             "Please check internet connection"));
  //       }
  //       return left(
  //           MenuFailure.serverFailure(response.error ?? 'Server Error'));
  //     }
  //   } catch (e) {
  //     return left(MenuFailure.serviceFailure(e.toString()));
  //   }
  // }
}
