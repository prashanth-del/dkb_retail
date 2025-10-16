import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_response_data_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/models/validate_card_models/validate_card_response_dto.dart';
import 'package:dkb_retail/features/forgot_password/data/urls.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import '../../../../network/data/urls/forgot_password_url.dart';
import '../models/validate_username_models/validate_username_request.dart';
import '../models/validate_username_models/validate_username_response_dto.dart';

import '../../../../common/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';

part 'src/validate_card_details.dart';
part 'src/validate_username.dart';

abstract class ForgotPasswordDatasource {
  Future<ApiEnvelope<ValidateCardResponseDataDto>> validateCardDetails({
    required String cardNumber,
    required String cardPin,
  });

  Future<ApiEnvelope<ValidateUsernameResponseDto>> validateUsername({
    required ValidateUsernameRequest request,
  });

  // Future<ApiEnvelope<void>> resendOtp();
}

class ForgotPasswordDatasourceImpl implements ForgotPasswordDatasource {
  ForgotPasswordDatasourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ApiEnvelope<ValidateCardResponseDataDto>> validateCardDetails({
    required String cardNumber,
    required String cardPin,
  }) {
    return _validateCardDetails(
      cardNumber: cardNumber,
      cardPin: cardPin,
      client: networkClient,
    );
  }

  @override
  Future<ApiEnvelope<ValidateUsernameResponseDto>> validateUsername({
    required ValidateUsernameRequest request,
  }) {
    return _validateUsername(request: request, client: networkClient);
  }

  // @override
  // Future<ApiEnvelope> validateOtp({required String otp}) async {
  //   return _validateOtp(networkClient, otp: otp);
  // }
}
