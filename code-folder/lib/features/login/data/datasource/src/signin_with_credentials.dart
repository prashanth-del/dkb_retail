part of '../login_datasource.dart';

Future<ApiEnvelope<SignwithCredentialsDto>> _signwithCredentials2({
  required SignwithCredentialsRequest request,
  required NetworkClient client,
}) async {
  final dio = client.customDio(
    authorizationRequired: true,
    screenId: 'COMMON',
    serviceId: 'TEST_SERVICE',
    subModuleId: 'FUND_TRANSFERS',
    moduleId: 'TRANSFERS',
    channel: 'WEB',
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

  final requestBody = {
    "requestInfo": request.body?.raw?.toJson(),
    "deviceInfo": deviceModel.toJson(),
  };

  return executeApiCall<SignwithCredentialsDto>(
    call: () => dio.post(LoginUrl.signwithCredentials2, data: requestBody),
    mapJson: (json) => ApiMapper.mapData<SignwithCredentialsDto>(
      json,
      (d) => SignwithCredentialsDto.fromJson(d),
    ),
  );
}

Future<String?> _encryptPwd({required String pwd, required String kp}) async {
  final dbComponentsPlugin = DbChannel();
  Map<String, String> toEncrypt = {
    'val': pwd,
    'pk': kp,
    'salt': 'abcdefghijklmnopqrstuvwxyz0123456789',
    'itr': '5000',
    'kl': '128',
  };
  late final String? encryptedPwd;
  try {
    if (Platform.isIOS) {
      encryptedPwd = await CustomMethodChannel().encryptCode(
        toEncrypt: toEncrypt,
      );
    } else {
      encryptedPwd = await dbComponentsPlugin.encrypt(toEncrypt: toEncrypt);
    }
  } catch (e) {
    consoleLog('Error in encryption : $e');
  }
  return encryptedPwd;
}

Future<String?> _encryptPayload({required String payload}) async {
  final dbComponentsPlugin = DbChannel();
  Map<String, String> toEncrypt = {'payLoad': payload};
  late final String? encryptedPayload;
  try {
    if (Platform.isIOS) {
      encryptedPayload = await CustomMethodChannel().encryptCode(
        toEncrypt: toEncrypt,
      );
    } else {
      encryptedPayload = await dbComponentsPlugin.encrypt(toEncrypt: toEncrypt);
    }
  } catch (e) {
    consoleLog('Error in encryption : $e');
  }
  return encryptedPayload;
}

// Future<ApiEnvelope<RpDto>> _fetchRp(NetworkClient client) async {
//   final dio = client.baseDio;
//   final rpBody = {"unit": 'PRD', "channel": 'RMB'};

//   return executeApiCall<RpDto>(
//     call: () => dio.post(LoginUrl.rpUrl, data: rpBody),
//     mapJson: (json) =>
//         ApiMapper.mapData<RpDto>(json, (data) => RpDto.fromJson(data)),
//   );
// }

void printLongString(String text) {
  final int chunkSize = 800; // Adjust chunk size if needed
  for (int i = 0; i < text.length; i += chunkSize) {
    print(
      text.substring(
        i,
        i + chunkSize > text.length ? text.length : i + chunkSize,
      ),
    );
  }
}
