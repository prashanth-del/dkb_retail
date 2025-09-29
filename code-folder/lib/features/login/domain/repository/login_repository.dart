import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import 'login_failure.dart';

abstract class LoginRepository {
  Future<Either<LoginFailure, User>> signInUsingUsernamePassword({
    required String customerId,
    required String username,
    required String password,
  });

  Future<Option<LoginFailure>> validateOtp({
    required String otp,
  });

  Future<Option<LoginFailure>> resendOtp();
  //
  // Future<Option<LoginFailure>> logout();
  //
  // Future<Option<LoginFailure>> changePassword({required String oldPassword, required String newPassword, required bool isLogin});
  //
  // Future<Either<MenuFailure, List<Menu>>> getMenuItems(String screenId);
}
