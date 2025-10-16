import 'package:db_uicomponents/db_uicomponents.dart';

import '../../../../common/utils.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/reach_us_url.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../models/bank_info_dto.dart';
import '../models/call_back_request_dto.dart';
import '../models/callback_fields_dto.dart';
import '../models/faqs_dto.dart';
import '../models/fetch_bank_info_request.dart';
import '../models/fetch_call_back_request_request.dart';
import '../models/fetch_callback_fields_request.dart';
import '../models/fetch_faq_request.dart';
import '../models/fetch_locate_us_info_request.dart';
import '../models/locate_us_info_dto.dart';

class ReachUsDatasource {
  final NetworkClient client;

  ReachUsDatasource(this.client);

  Future<ApiEnvelope<FaqsDto>> fetchFaq({
    required FetchFaqRequest request,
  }) async {
    final dio = client.customDio(
      serviceId: "Service1",
      authorizationRequired: false,
      moduleId: "mod1",
      subModuleId: "sub1",
      channel: "web",
      unit: "HQ",
      screenId: "scr1",
    );

    // Map<String, dynamic> headers = {
    //   "ipAddress": "192.168.1.10",
    //   "deviceId": "DEV123",
    //   "username": "testuser",
    //   "userId": "U1001",
    //   "partnerId": "P2001",
    //   "x-correlationId": "CORR-12345",
    //   "authType": "TOKEN",
    // };
    // dio.options.headers.addAll(headers);

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
    final body = {
      ...withDevice.toJson(), // spread other request fields
      "deviceInfo": deviceModel
          .toJson(), // nested deviceInfo exactly as in deviceModel
    };

    return executeApiCall<FaqsDto>(
      call: () => dio.post(ReachUsUrl.fetchFaq, data: body),
      mapJson: (json) =>
          ApiMapper.mapData<FaqsDto>(json, (d) => FaqsDto.fromJson(d)),
    );
  }

  // Future<ApiEnvelope<List<CallbackFieldsDto>>> fetchCallbackFields({
  //   required FetchCallbackFieldsRequest request,
  // }) async {
  //   final dio = client.customDio(
  //     serviceId: "MENUS",
  //     authorizationRequired: false,
  //     channel: "WEB",
  //     moduleId: "TRANSFERS",
  //     screenId: "callback",
  //     subModuleId: "FUND_TRANSFERS",
  //   );
  //
  //   // Inject DeviceModel (ignored in JSON) — and guard against null
  //   final appVer = await getAppVersion();
  //   final deviceModel = await DeviceInfo(
  //     appVer: appVer,
  //     endToEndId: '',
  //   ).deviceType();
  //   if (deviceModel == null) {
  //     return ApiEnvelope.error(
  //       const ApiError(description: 'Unable to fetch device info'),
  //       AppStatus.error,
  //     );
  //   }
  //   final withDevice = request.copyWith(deviceInfo: deviceModel);
  //
  //   return executeApiCall<List<CallbackFieldsDto>>(
  //     call: () =>
  //         dio.get(ReachUsUrl.fieldRequestCallback, data: withDevice.toJson()),
  //     mapJson: (json) => ApiMapper.mapList<CallbackFieldsDto>(
  //       json,
  //       (d) => CallbackFieldsDto.fromJson(d),
  //     ),
  //   );
  // }

  Future<ApiEnvelope<List<CallBackRequestDto>>> fetchCallBackRequest({
    required FetchCallBackRequestRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: true,
      screenId: 'callback',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

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
    final withDevice = request.copyWith(
      deviceInfo: deviceModel,
    ); // todo this later
    final requestJson = {
      "requestInfo": withDevice.dynamicFields,
      "deviceInfo": deviceModel.toJson(), // spread all fields at root
    };

    return executeApiCall<List<CallBackRequestDto>>(
      call: () => dio.post(ReachUsUrl.requestCallbackURL, data: requestJson),
      mapJson: (json) => ApiMapper.mapList<CallBackRequestDto>(
        json,
        (d) => CallBackRequestDto.fromJson(d),
      ),
    );
  }

  Future<ApiEnvelope<BankInfoDto>> fetchBankInfo({
    required FetchBankInfoRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'SCID',
      serviceId: 'SC',
      subModuleId: 'SMD',
      moduleId: 'MD-01',
      unit: "UN",
      channel: "CH",
    );

    // dio.options.headers.addAll({"bookingId": "BK"});
    print("heaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaader");
    print(dio.options.headers);

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
    final body = {
      ...withDevice.toJson(), // spread other request fields
      "deviceInfo": {
        "deviceId": "DEVICE123",
        "ipAddress": "192.168.1.1",
        "vendorId": "VENDOR123",
        "osVersion": "1.0.0",
        "osType": "Android",
        "appVersion": "2.1.0",
        "endToEndId": "E2E123",
      },
      // deviceModel
      //     .toJson(), // nested deviceInfo exactly as in deviceModel
    };

    return executeApiCall<BankInfoDto>(
      call: () => dio.post(ReachUsUrl.bankDetailsUrl, data: body),
      mapJson: (json) =>
          ApiMapper.mapData<BankInfoDto>(json, (d) => BankInfoDto.fromJson(d)),
    );
  }

  Future<ApiEnvelope<List<LocateUsInfoDto>>> fetchLocateUsInfo({
    required FetchLocateUsInfoRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'SCID',
      serviceId: 'SC',
      subModuleId: 'SMD',
      moduleId: 'MD-01',
      unit: "UN",
      channel: "CH",
    );

    dio.options.headers.addAll({"bookingId": "BK"});

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
    final body = {
      ...withDevice.toJson(), // spread other request fields
      "deviceInfo": {
        "deviceId": "DEVICE123",
        "ipAddress": "192.168.1.1",
        "vendorId": "VENDOR123",
        "osVersion": "1.0.0",
        "osType": "Android",
        "appVersion": "2.1.0",
        "endToEndId": "E2E123",
      },
      // deviceModel
      //     .toJson(), // nested deviceInfo exactly as in deviceModel
    };

    return executeApiCall<List<LocateUsInfoDto>>(
      call: () => dio.post(ReachUsUrl.fetchLocateUsInfo, data: body),
      mapJson: (json) => ApiMapper.mapList<LocateUsInfoDto>(
        json,
        (d) => LocateUsInfoDto.fromJson(d),
      ),
    );
  }

  Future<ApiEnvelope<List<CallbackFieldsDto>>> fetchCallbackFields({
    required FetchCallbackFieldsRequest request,
  }) async {
    final dio = client.customDio(
      authorizationRequired: true,
      screenId: 'callback',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

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
    print("deviiiiiiiiiiiiiiiiiiiiiiiiiiiiiice_model");

    print(deviceModel);
    final withDevice = request.copyWith(deviceInfo: deviceModel);

    print("Request body with deviceInfo:");
    print(withDevice.toJson());
    print(deviceModel);

    // Build request body: include deviceInfo as nested object
    final body = {
      ...withDevice.toJson(), // spread other request fields
      "deviceInfo": deviceModel
          .toJson(), // nested deviceInfo exactly as in deviceModel
    };

    return executeApiCall<List<CallbackFieldsDto>>(
      call: () => dio.post(
        ReachUsUrl.fetchCallbackFields,
        data: body, // send full body including deviceInfo
      ),
      mapJson: (json) => ApiMapper.mapList<CallbackFieldsDto>(
        json,
        (d) => CallbackFieldsDto.fromJson(d),
      ),
    );
  }
}
