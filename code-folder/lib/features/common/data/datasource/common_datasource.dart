import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/features/common/data/common_urls.dart';
import 'package:dkb_retail/network/domain/models/api_envelope.dart';
import 'package:logger/logger.dart';

import '../../../../common/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/common_url.dart';
import '../../../../network/domain/models/api_error.dart';
import '../models/otp_generate_models/generate_otp_request.dart';
import '../models/otp_generate_models/otp_generate_dto.dart';
import '../models/otp_validate_models/otp_validate_dto.dart';
import '../models/otp_validate_models/validate_otp_request.dart';
import '../models/password_rules_models/password_rules_dto.dart';
import '../models/update_password_models/update_password2_request.dart';
import '../models/update_password_models/update_password_model_dto.dart';

part 'src/get_password_rules.dart';
part 'src/otp_generate.dart';
part 'src/otp_validation.dart';
part 'src/update_password.dart';

abstract class CommonDatasource {
  Future<ApiEnvelope<List<PasswordRulesDto>>> getPasswordRules();

  Future<ApiEnvelope<UpdatePasswordModelDto>> updatePassword2({
    required UpdatePassword2Request request,
  });

  Future<ApiEnvelope<OtpGenerateDto>> generateOtp({
    required GenerateOtpRequest request,
  });

  Future<ApiEnvelope<OtpValidateDto>> validateOtp({
    required ValidateOtpRequest request,
  });
}

class CommonDataSourceImpl implements CommonDatasource {
  CommonDataSourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ApiEnvelope<List<PasswordRulesDto>>> getPasswordRules() {
    return _getCardValidations(networkClient);
  }

  @override
  Future<ApiEnvelope<UpdatePasswordModelDto>> updatePassword2({
    required UpdatePassword2Request request,
  }) {
    return _updatePassword2(request: request, client: networkClient);
  }

  @override
  Future<ApiEnvelope<OtpGenerateDto>> generateOtp({
    required GenerateOtpRequest request,
  }) {
    return _generateOtp(client: networkClient, request: request);
  }

  @override
  Future<ApiEnvelope<OtpValidateDto>> validateOtp({
    required ValidateOtpRequest request,
  }) {
    return _validateOtp(client: networkClient, request: request);
  }
}
