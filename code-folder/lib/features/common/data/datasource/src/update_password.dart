part of '../common_datasource.dart';

Future<ApiEnvelope<UpdatePasswordModelDto>> _updatePassword2({
  required UpdatePassword2Request request,
  required NetworkClient client,
}) async {
  final dio = client.customDio(
    authorizationRequired: true,
    screenId: 'COMMON',
    serviceId: 'TEST_SERVICE',
    subModuleId: '',
    moduleId: '',
  );

  print("remove client ${request.toJson()}");

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

  final requestJson = {
    'requestInfo': request.body?.raw,
    'deviceInfo': deviceModel,
  };

  return executeApiCall<UpdatePasswordModelDto>(
    call: () => dio.post(CommonUrl.updatePassword2, data: requestJson),
    mapJson: (json) => ApiMapper.mapData<UpdatePasswordModelDto>(
      json,
      (d) => UpdatePasswordModelDto.fromJson(d),
    ),
  );
}
