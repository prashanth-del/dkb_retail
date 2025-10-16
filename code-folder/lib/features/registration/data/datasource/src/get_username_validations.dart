part of '../username_validations_datasource.dart';

Future<ApiEnvelope<List<UsernameRulesModalDto>>> _getUsernameValidations(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const usernameValidations = LoginUrl.usernameValidations;
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'BIN',
      serviceId: 'BIN',
      subModuleId: 'BIN',
      moduleId: 'BIN',
    );

    final requestBody = {
      "requestInfoDto": {"type": "username"},
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

    return executeApiCall<List<UsernameRulesModalDto>>(
      call: () => dio.post(usernameValidations, data: requestBody),
      mapJson: (json) {
        return ApiMapper.mapList(json, (data) {
          consoleLog('username rulees json $data');
          return UsernameRulesModalDto.fromJson(data);
        });
      },
    );

    // await Future.delayed(Duration(seconds: 2));

    // var dummyData = {
    //   "status": {"code": "000000", "description": "SUCCESS"},
    //   "data": [
    //     {"ruleDescription": "Minimum 1 Uppercase", "validationPattern": "A-Z"},
    //     {"ruleDescription": "Minimum 1 Lowercase", "validationPattern": "a-z"},
    //     {"ruleDescription": "Minimum 1 Digit", "validationPattern": "0-9"},
    //     {
    //       "ruleDescription": "Minimum length 8 characters",
    //       "validationPattern": "length>=8",
    //     },
    //   ],
    // };

    // return ApiMapper.mapList<UsernameRulesModalDto>(
    //   dummyData,
    //   (data) => UsernameRulesModalDto.fromJson(data),
    // );
  } catch (e, s) {
    logger.e("Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to get username validations'),
      AppStatus.error,
    );
  }
}
