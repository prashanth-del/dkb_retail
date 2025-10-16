import 'package:dartz/dartz.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_response_data_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_response_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_username_models/validate_username_response_dto.dart';
import 'package:dkb_retail/features/forgot_password/domain/entities/validate_card_entites/validate_card_response.dart';
import 'package:dkb_retail/features/forgot_password/domain/entities/validate_card_entites/validate_card_response_data.dart';

import '../../../../core/errors/failures.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../domain/entities/validate_card_entites/validate_card.dart';
import '../../domain/entities/validate_username_response.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasource/forgot_password_datasource.dart';
import '../models/validate_username_models/validate_username_request.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordDatasource datasource;

  ForgotPasswordRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ValidateCardResponseData>> validateCard({
    required String cardNumber,
    required String cardPin,
  }) async {
    try {
      final response = await datasource.validateCardDetails(
        cardNumber: cardNumber,
        cardPin: cardPin,
      );

      print("data from validate card repo ${response.data.toString()}");

      final data = response.data;
      if (data == null) {
        return left(ServiceFailure(response.status.description.toString()));
      }

      final validatedCardDetails = data.toEntity();
      print("data from validate card repo ${validatedCardDetails.toString()}");
      return right(validatedCardDetails);
    } catch (e) {
      // You can log or convert exceptions to a proper Failure object
      return left(ServiceFailure(e.toString()));
    }
  }

  @override
  Future<Either<ApiError, ValidateUsernameResponse>> validateUsername({
    required ValidateUsernameRequest request,
  }) async {
    final env = await datasource.validateUsername(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);
  }
}
