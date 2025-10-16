part of '../rates_datasource.dart';

Future<ApiEnvelope<List<FxRatesDto>>> _getFxRates(
    NetworkClient client,
    GetFxRatesRequest request
    ) async {
  final logger = Logger();
  try {
    const url = Specialfxrate.getFxRatesUrl;
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'COMMON',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

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
    final requestBody = {
      "deviceInfo": deviceModel.toJson(),
    };

    return executeApiCall<List<FxRatesDto>>(
      call: () => dio.post(url,data: requestBody),
      mapJson: (json) => ApiMapper.mapList<FxRatesDto>(
        json,
            (data) => FxRatesDto.fromJson(data as Map<String, dynamic>),
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
