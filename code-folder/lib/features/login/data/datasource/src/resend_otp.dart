part of '../login_datasource.dart';




Future<ApiEnvelope<void>> _resendOtp(NetworkClient client) async {
  try {
    const resendOtpUri = LoginUrl.resendOtpUrl;

    final dio = client.customDio(
      serviceId: "GENOTP",
      authorizationRequired: true,
      moduleId: "LOGIN",
      subModuleId: "LOGIN",
      screenId: "LGN",
    );

    final response = await dio.post(resendOtpUri, data: {});

    consoleLog("Resent OTP response: ${response.data}");

    final statusMap = response.data['status'] as Map<String, dynamic>?;
    final apiError = statusMap != null
        ? ApiError.fromJson(statusMap)
        : const ApiError(code: 'unknown', description: 'Unknown error');

    final appStatus = StatusPolicy.defaultPolicy(apiError);

    return appStatus == AppStatus.success
        ? ApiEnvelope.success(null, apiError, appStatus)
        : ApiEnvelope.error(apiError, appStatus);
  } catch (e) {
    consoleLog("Error in validating OTP: $e");

    final apiError = ApiError(code: 'network', description: e.toString());
    return ApiEnvelope.error(apiError, StatusPolicy.defaultPolicy(apiError));
  }
}
