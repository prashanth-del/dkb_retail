part of '../login_datasource.dart';

Future<ApiEnvelope<UserDto>> _signInWithCredentials(
    NetworkClient client, {
      required String customerId,
      required String username,
      required String password,
    }) async {
  final logger = Logger();
  try {
    const loginUri = LoginUrl.authUrl;
    final dio = client.customDio(
        authorizationRequired: false,
        screenId: 'LOGIN',
        serviceId: 'LOGIN',
        subModuleId: 'LGN',
        moduleId: 'LGN',
        customerId: customerId
    );

    /// TODO - Call once encryption done at service end
    final res = await _fetchRp(client);
    if (!res.ok) {
      return ApiEnvelope.error(res.status, res.appStatus);
    }

    // final publicKey = res.data!.key ?? '';
    // final clientSaltBase64 = "" ?? '';
    // final clientSalt = base64Decode(clientSaltBase64);
    // final encryptedPayload = await EncryptionService().prepareEncryptedPayload(
    //   username: username,
    //   password: password,
    //   clientSalt: clientSalt,
    //   publicKey: publicKey,
    // );
    //
    // if (encryptedPayload.isEmpty) {
    //   return ApiEnvelope.error(
    //     const ApiError(description: 'Encryption failed'),
    //     AppStatus.error,
    //   );
    // }
    // String? encryptedPwd = await _encryptPwd(pwd: password,kp: res.data!.key ?? "");
    // if(encryptedPwd == null) {
    //   return ApiResponse(error: 'Encryption Error');
    // }

    String appVer = await getAppVersion();
    DeviceModel? deviceModel =
    await DeviceInfo(appVer: appVer, endToEndId: '').deviceType();
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }

    final loginBody = {
      "userInfo": {
        "customerNo": customerId,
        "userName": username,
        "password": password,
        "loginType": "PASS"
      },
      "deviceInfo": deviceModel.toJson()
    };

    // String? encryptedBody = await _encryptPayload(payload: jsonEncode(loginBody));
    // if(encryptedBody == null) {
    //   return ApiResponse(error: 'Encryption Error');
    // }
    //
    // printLongString("Encrypted data : $encryptedBody");

    return executeApiCall<UserDto>(
      call: () => dio.post(loginUri, data: loginBody),
      mapJson: (json) => ApiMapper.mapData<UserDto>(
        json,
            (data) => UserDto.fromJson(data),
      ),
    );
  } catch (e, s) {
    logger.e("Login Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to fetch'),
      AppStatus.error,
    );
  }
}

Future<String?> _encryptPwd({required String pwd, required String kp}) async {
  final dbComponentsPlugin = DbChannel();
  Map<String, String> toEncrypt = {
    'val': pwd,
    'pk': kp,
    'salt': 'abcdefghijklmnopqrstuvwxyz0123456789',
    'itr': '5000',
    'kl': '128'
  };
  late final String? encryptedPwd;
  try {
    if (Platform.isIOS) {
      encryptedPwd =
      await CustomMethodChannel().encryptCode(toEncrypt: toEncrypt);
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
      encryptedPayload =
      await CustomMethodChannel().encryptCode(toEncrypt: toEncrypt);
    } else {
      encryptedPayload = await dbComponentsPlugin.encrypt(toEncrypt: toEncrypt);
    }
  } catch (e) {
    consoleLog('Error in encryption : $e');
  }
  return encryptedPayload;
}

Future<ApiEnvelope<RpDto>> _fetchRp(NetworkClient client) async {
  final dio = client.baseDio;
  final rpBody = {"unit": 'PRD', "channel": 'RMB'};

  return executeApiCall<RpDto>(
    call: () => dio.post(LoginUrl.rpUrl, data: rpBody),
    mapJson: (json) => ApiMapper.mapData<RpDto>(
      json,
          (data) => RpDto.fromJson(data),
    ),
  );
}


void printLongString(String text) {
  final int chunkSize = 800; // Adjust chunk size if needed
  for (int i = 0; i < text.length; i += chunkSize) {
    print(text.substring(
        i, i + chunkSize > text.length ? text.length : i + chunkSize));
  }
}
