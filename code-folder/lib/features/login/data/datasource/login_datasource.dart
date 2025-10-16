import 'dart:io';

import 'package:db_uicomponents/db_uicomponents.dart';

import '../../../../common/utils.dart';
import '../../../../core/utils/method_channel/custom_method_channel.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/status_policy.dart';
import '../../../../network/data/urls/login_url.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../../../network/domain/models/api_response.dart';
import '../models/sign_in_with_credentials_models/signwith_credentials_dto.dart';
import '../models/sign_in_with_credentials_models/signwith_credentials_request.dart';

part 'src/resend_otp.dart';
part 'src/signin_with_credentials.dart';
part 'src/validate_otp.dart';

abstract class LoginDatasource {
  Future<ApiEnvelope<void>> validateOtp({required String otp});

  Future<ApiEnvelope<void>> resendOtp();

  Future<ApiEnvelope<SignwithCredentialsDto>> signwithCredentials2({
    required SignwithCredentialsRequest request,
  });
  //
  // Future<ApiResponse> logout();
  //
  // Future<ApiResponse> changePassword({required String oldPassword,
  //   required String newPassword,
  //   required bool isLogin});
  //
  // Future<ApiResponse> menuItems({
  //   required String screenId
  // });

  //   Future<ApiEnvelope<SignwithCredentials2Dto>> signwithCredentials2({
  //   required SignwithCredentials2Request request,
  // }) async {
  //   final dio = client.customDio(
  //     authorizationRequired: true,
  //     screenId: 'COMMON',
  //     serviceId: 'TEST_SERVICE',
  //     subModuleId: '',
  //     moduleId: '',
  //   );

  //   // Inject DeviceModel (ignored in JSON) — and guard against null
  //   final appVer = await getAppVersion();
  //   final deviceModel = await DeviceInfo(appVer: appVer, endToEndId: '').deviceType();
  //   if (deviceModel == null) {
  //     return ApiEnvelope.error(
  //       const ApiError(description: 'Unable to fetch device info'),
  //       AppStatus.error,
  //     );
  //   }
  //   final withDevice = request.copyWith(deviceInfo: deviceModel);

  //   return executeApiCall<SignwithCredentials2Dto>(
  //     call: () => dio.post(LoginUrl.signwithCredentials2, data: withDevice.toJson()),
  //     mapJson: (json) => ApiMapper.mapData<SignwithCredentials2Dto>(json, (d) => SignwithCredentials2Dto.fromJson(d)),
  //   );
  // }
}

class LoginDatasourceImpl implements LoginDatasource {
  LoginDatasourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ApiEnvelope<SignwithCredentialsDto>> signwithCredentials2({
    required SignwithCredentialsRequest request,
  }) {
    return _signwithCredentials2(client: networkClient, request: request);
  }

  @override
  Future<ApiEnvelope> resendOtp() async {
    return _resendOtp(networkClient);
  }

  @override
  Future<ApiEnvelope> validateOtp({required String otp}) async {
    return _validateOtp(networkClient, otp: otp);
  }
}
