part of '../rates_datasource.dart';

Future<ApiEnvelope<List<ProfitRatesDto>>> _getProfitRates(
    NetworkClient client,
    GetProfitRatesRequest request
    ) async {
  final logger = Logger();
  try {
    const url = Specialfxrate.getProfitRatesUrl;
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

    return executeApiCall<List<ProfitRatesDto>>(
      call: () => dio.post(url,data: requestBody),
      mapJson: (json) => ApiMapper.mapList<ProfitRatesDto>(
        json,
            (data) => ProfitRatesDto.fromJson(data as Map<String, dynamic>),
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
