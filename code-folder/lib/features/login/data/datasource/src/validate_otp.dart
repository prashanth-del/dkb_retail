part of '../login_datasource.dart';

Future<ApiEnvelope<void>> _validateOtp(
  NetworkClient client, {
  required String otp,
}) async {
  print("inside validate otp");
  try {
    const validateOtpUri = LoginUrl.validateOtpUrl;

    final dio = client.customDio(
      serviceId: "LOGIN",
      authorizationRequired: true,
      moduleId: "LGN",
      subModuleId: "LGN",
      screenId: "LGN",
    );

    dio.options.headers.remove("customerId");

    // Get device info
    String appVer = await getAppVersion();
    DeviceModel? deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();

    if (deviceModel == null) {
      final apiError = ApiError(
        description: 'Unable to fetch device info',
        code: 'device',
      );
      return ApiEnvelope.error(apiError, StatusPolicy.defaultPolicy(apiError));
    }

    final validateOtpBody = {
      "otpValue": otp,
      "deviceInfo": deviceModel.toJson(),
    };

    final validateOtpResponse = ApiResponse(
      data: {
        "status": {
          "code": "000000",
          "description": "OTP validated successfully",
          "value": true,
        },
      },
    );

    // await dio.post(
    //   validateOtpUri,
    //   data: validateOtpBody,
    // );

    print("Validate OTP response: ${validateOtpResponse.data}");

    // Parse ApiError from response
    final statusMap =
        validateOtpResponse.data?['status'] as Map<String, dynamic>?;
    final apiError = statusMap != null
        ? ApiError.fromJson(statusMap)
        : const ApiError(code: 'unknown', description: 'Unknown error');

    // Determine AppStatus using StatusPolicy
    final appStatus = StatusPolicy.defaultPolicy(apiError);

    // Return ApiEnvelope
    return appStatus == AppStatus.success
        ? ApiEnvelope.success(null, apiError, appStatus)
        : ApiEnvelope.error(apiError, appStatus);
  } catch (e) {
    consoleLog("Error in validating OTP: $e");
    final apiError = ApiError(code: 'network', description: e.toString());
    return ApiEnvelope.error(apiError, StatusPolicy.defaultPolicy(apiError));
  }
}
