import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';

import '../../../../network/domain/models/api_error.dart';
import '../../data/models/validate_username_models/validate_username_request.dart';
import '../entities/validate_card_entites/validate_card_response_data.dart';
import '../entities/validate_username_response.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ValidateCardResponseData>> validateCard({
    required String cardNumber,
    required String cardPin,
  });

  Future<Either<ApiError, ValidateUsernameResponse>> validateUsername({
    required ValidateUsernameRequest request,
  });

  // Future<Option<ForgotPasswordFailure>> resendOtp();
  //
  // Future<Option<LoginFailure>> logout();
  //
  // Future<Option<LoginFailure>> changePassword({required String oldPassword, required String newPassword, required bool isLogin});
  //
  // Future<Either<MenuFailure, List<Menu>>> getMenuItems(String screenId);
}
