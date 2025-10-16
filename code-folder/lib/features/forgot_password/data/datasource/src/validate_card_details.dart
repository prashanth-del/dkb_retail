part of '../forgot_password_datasource.dart';

Future<ApiEnvelope<ValidateCardResponseDataDto>> _validateCardDetails({
  required String cardNumber,
  required String cardPin,
  required NetworkClient client,
}) async {
  try {
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'BIN',
      serviceId: 'BIN',
      subModuleId: 'BIN',
      moduleId: 'BIN',
    );

    final appVer = await getAppVersion();
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: 'E2E123',
    ).deviceType();

    final data = {"cardNumber": cardNumber, "pin": cardPin};

    final requestBody = {
      "requestInfo": data,
      "deviceInfo": {
        "deviceId": "DEVICE123",
        "ipAddress": "192.168.1.1",
        "vendorId": "VENDOR123",
        "osVersion": "1.0.0",
        "osType": "Android",
        "appVersion": "2.1.0",
        "endToEndId": "E2E123",
      },
    };

    return executeApiCall<ValidateCardResponseDataDto>(
      call: () =>
          dio.post(ForgotPasswordUrls.validateCardUrl, data: requestBody),
      mapJson: (json) {
        return ApiMapper.mapData<ValidateCardResponseDataDto>(json, (response) {
          return ValidateCardResponseDataDto.fromJson(response);
        });
      },
    );
  } catch (e, s) {
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to card validations'),
      AppStatus.error,
    );
  }
}
