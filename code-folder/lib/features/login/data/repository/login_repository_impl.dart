import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../common/utils.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/login_failure.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/login_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<Either<LoginFailure, User>> signInUsingUsernamePassword({
    required String customerId,
    required String username,
    required String password,
  }) async {
    try {
      final response = await datasource.signInWithCredentials(
        customerId: customerId,
        username: username,
        password: password,
      );

      // final dummyresponse = LoginResponseModel.dummyResponse;
      // final response = ApiResponse(
      //     data: GenericResponse<UserDto>.fromJson(
      //         dummyresponse, (data) => UserDto.fromJson(data)));
      if(!response.ok){
        return left(LoginFailure.serviceFailure(response.message));
      }
      final dto = response.data;
      if(dto == null){
        return left(LoginFailure.serviceFailure(response.message));
      }
      final user = dto.toDomain();
      if ( user.isOtpRequired == null) {
        return left(const LoginFailure.serviceFailure(
            "Cannot Process your request. Please try after sometimes(OTP)."));
      }
      return right(user);
      // if (response.isSuccess) {
      //   if (response.data!.data != null) {
      //     User user = response.data!.data!.toDomain();
      //     if (user.isOtpRequired == null) {
      //       return left(const LoginFailure.serviceFailure(
      //           "Cannot Process your request. Please try after sometimes(OTP)."));
      //     } else {
      //       return right(user);
      //     }
      //   } else {
      //     String err =
      //         response.data!.status?.description ?? 'Failed! Please try again.';
      //     return left(LoginFailure.serviceFailure(err));
      //   }
      // } else {
      //   return left(
      //       LoginFailure.serverFailure(response.error ?? 'Server Error'));
      // }
    } catch (e) {
      consoleLog('Error : $e');
      return left(LoginFailure.serviceFailure(e.toString()));
    }
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
