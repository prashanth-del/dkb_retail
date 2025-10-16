part of '../common_datasource.dart';

Future<ApiEnvelope<List<PasswordRulesDto>>> _getCardValidations(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const url = CommonUrls.getRules;
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'BIN',
      serviceId: 'BIN',
      subModuleId: 'BIN',
      moduleId: 'BIN',
    );

    final requestBody = {
      "requestInfoDto": {"type": "password"},
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

    return executeApiCall<List<PasswordRulesDto>>(
      call: () => dio.post(url, data: requestBody),
      mapJson: (json) => ApiMapper.mapList<PasswordRulesDto>(
        json,
        (data) => PasswordRulesDto.fromJson(data as Map<String, dynamic>),
      ),
    );
  } catch (e, s) {
    logger.e("Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to card validations'),
      AppStatus.error,
    );
  }
}
