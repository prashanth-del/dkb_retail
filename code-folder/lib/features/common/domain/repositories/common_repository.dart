import 'package:dartz/dartz.dart';
import '../entities/otp_generate_entities/otp_generate.dart';
import '../../data/models/otp_generate_models/generate_otp_request.dart';
import '../entities/otp_validate_entites/otp_validate.dart';
import '../../data/models/otp_validate_models/validate_otp_request.dart';

import '../../../../core/errors/failures.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../data/models/update_password_models/update_password2_request.dart';
import '../entities/otp_generate_entities/otp_generate.dart';
import '../entities/otp_validate_entites/otp_validate.dart';
import '../entities/password_rules_entites/password_rules.dart';
import '../entities/update_password_entites/update_password_model.dart';

abstract class CommonRepository {
  Future<Either<Failure, List<PasswordRules>>> getPasswordRules();
  Future<Either<ApiError, UpdatePasswordModel>> updatePassword2({
    required UpdatePassword2Request request,
  });
  Future<Either<ApiError, OtpGenerate>> generateOtp({ required GenerateOtpRequest request});
  Future<Either<ApiError, OtpValidate>> validateOtp({ required ValidateOtpRequest request, });
}
