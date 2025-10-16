part of '../forgot_password_datasource.dart';

Future<ApiEnvelope<ValidateUsernameResponseDto>> _validateUsername({
  required ValidateUsernameRequest request,
  required NetworkClient client,
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
    endToEndId: 'E2E123',
  ).deviceType();
  if (deviceModel == null) {
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to fetch device info'),
      AppStatus.error,
    );
  }
  final withDevice = request.copyWith(deviceInfo: deviceModel);

  return executeApiCall<ValidateUsernameResponseDto>(
    call: () =>
        dio.post(ForgotPasswordUrl.validateUsername, data: withDevice.toJson()),
    mapJson: (json) => ApiMapper.mapData<ValidateUsernameResponseDto>(
      json,
      (d) => ValidateUsernameResponseDto.fromJson(d),
    ),
  );
}
