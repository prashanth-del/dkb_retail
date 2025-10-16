import 'package:db_uicomponents/db_uicomponents.dart';
import '../../../../common/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../models/biometriclogin_request.dart';
import '../models/biometric_auth_dto.dart';
import '../../../../network/data/urls/welcome_back_url.dart';
import '../models/register_biometric_request.dart';
import '../models/create_biometric_dto.dart';

class WelcomeBackDatasource {
  final NetworkClient client;
  WelcomeBackDatasource(this.client);

  Future<ApiEnvelope<BiometricAuthDto>> biometriclogin({
    required BiometricloginRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: true,
      screenId: 'COMMON',
      serviceId: 'TEST_SERVICE',
      subModuleId: '',
      moduleId: '',
    );

    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    return executeApiCall<BiometricAuthDto>(
      call: () =>
          dio.post(WelcomeBackUrl.biometriclogin, data: withDevice.toJson()),
      mapJson: (json) => ApiMapper.mapData<BiometricAuthDto>(
        json,
        (d) => BiometricAuthDto.fromJson(d),
      ),
    );
  }

  Future<ApiEnvelope<CreateBiometricDto>> registerBiometric({
    required RegisterBiometricRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: true,
      screenId: 'COMMON',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    return executeApiCall<CreateBiometricDto>(
      call: () =>
          dio.post(WelcomeBackUrl.registerBiometric, data: withDevice.toJson()),
      mapJson: (json) => ApiMapper.mapData<CreateBiometricDto>(
        json,
        (d) => CreateBiometricDto.fromJson(d),
      ),
    );
  }
}
