part of '../common_datasource.dart';

Future<ApiEnvelope<OtpValidateDto>> _validateOtp({
  required ValidateOtpRequest request,
  required NetworkClient client,
}) async {
  final dio = client.customDio(
    authorizationRequired: false,
    screenId: 'OTP_SCREEN',
    serviceId: 'OTP_SERVICE',
    subModuleId: 'OTP_SUBMODULE',
    moduleId: 'AUTH_MODULE',
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
  final requestWithDevice = request.copyWith(deviceInfo: deviceModel);

  final requestBody = {
    "requestInfo": requestWithDevice.requestInfo?.toJson() ?? {},
    "deviceInfo": deviceModel.toJson(),
  };

  return executeApiCall<OtpValidateDto>(
    call: () => dio.post(
      CommonUrl.validateOtp,
      data: requestBody,
    ),
    mapJson: (json) => ApiMapper.mapData<OtpValidateDto>(
      json,
          (d) => OtpValidateDto.fromJson(d),
    ),
  );
}