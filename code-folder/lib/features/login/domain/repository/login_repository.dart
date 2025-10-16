import 'package:fpdart/fpdart.dart';

import '../../../../network/domain/models/api_error.dart';
import '../../data/models/sign_in_with_credentials_models/signwith_credentials_request.dart';
import '../entities/sign_with_credentials_entity/login_response.dart';
import 'login_failure.dart';

abstract class LoginRepository {
  Future<Option<LoginFailure>> validateOtp({required String otp});

  Future<Either<ApiError, LoginResponse>> signWithCredentials({
    required SignwithCredentialsRequest request,
  });

  Future<Option<LoginFailure>> resendOtp();
}
