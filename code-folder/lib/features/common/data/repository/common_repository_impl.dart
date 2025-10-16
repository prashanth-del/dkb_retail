import 'package:dartz/dartz.dart';
import 'package:dkb_retail/features/common/data/datasource/common_datasource.dart';
import 'package:dkb_retail/features/common/data/models/otp_generate_models/generate_otp_request.dart';
import 'package:dkb_retail/features/common/data/models/otp_generate_models/otp_generate_dto.dart';
import 'package:dkb_retail/features/common/data/models/otp_validate_models/otp_validate_dto.dart';
import 'package:dkb_retail/features/common/data/models/update_password_models/update_password_model_dto.dart';
import 'package:dkb_retail/features/common/domain/entities/password_rules_entites/password_rules.dart';
import 'package:dkb_retail/features/common/domain/repositories/common_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/otp_generate_entities/otp_generate.dart';
import '../../domain/entities/otp_validate_entites/otp_validate.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/entities/update_password_entites/update_password_model.dart';
import '../models/otp_validate_models/validate_otp_request.dart';
import '../models/password_rules_models/password_rules_dto.dart';
import '../models/update_password_models/update_password2_request.dart';

class CommonRepositoryImpl implements CommonRepository {
  final CommonDatasource datasource;
  const CommonRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<PasswordRules>>> getPasswordRules() async {
    try {
      final response = await datasource.getPasswordRules();

      final data = response.data;
      if (data == null) {
        return left(ServiceFailure(response.status.description.toString()));
      }

      final listOfPasswordRules = data
          .map((dto) => dto.toEntity())
          .toList(growable: false);

      print("password rules ${listOfPasswordRules.length}");

      return right(listOfPasswordRules);
    } catch (e) {
      // You can log or convert exceptions to a proper Failure object
      return left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiError, OtpGenerate>> generateOtp({
    required GenerateOtpRequest request,
  }) async {
    final env = await datasource.generateOtp(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }

  @override
  Future<Either<ApiError, OtpValidate>> validateOtp({
    required ValidateOtpRequest request,
  }) async {
    final env = await datasource.validateOtp(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }

  @override
  Future<Either<ApiError, UpdatePasswordModel>> updatePassword2({
    required UpdatePassword2Request request,
  }) async {
    final env = await datasource.updatePassword2(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }
}
