part of '../product_offering_datasource.dart';

Future<ApiEnvelope<List<ContactUsModalPayloadItemDto>>> _getContactUsFields(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const productsUrl = ProductsUrl.productContactusUrl;
    // http://34.18.92.50:7575/products/retrieve-eligible-products
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'applyProducts',
      serviceId: 'MENUS',
      subModuleId: 'FUND_TRANSFERS',
      moduleId: 'TRANSFERS',
    );

    final extraheaders = <String, String>{'channel': 'WEB'};

    // dio.options.headers.addAll(extraheaders);

    // final loginBody = {};

    dio.options.headers.addAll(extraheaders);
    // Inject DeviceModel (ignored in JSON) — and guard against null
    final appVer = await getAppVersion();
    final deviceData = await getDeviceInfo();
    print('device: $deviceData ');
    final deviceModel = await DeviceInfo(
      appVer: appVer,
      endToEndId: '',
    ).deviceType();
    print('device***: $deviceModel');
    if (deviceModel == null) {
      return ApiEnvelope.error(
        const ApiError(description: 'Unable to fetch device info'),
        AppStatus.error,
      );
    }

    //  final withDevice = request.copyWith(deviceInfo: deviceModel);

    return executeApiCall<List<ContactUsModalPayloadItemDto>>(
      call: () =>
          dio.post(productsUrl, data: {"deviceInfo": deviceModel.toJson()}),
      mapJson: (json) {
        return ApiMapper.mapList(
          json,
          (data) => ContactUsModalPayloadItemDto.fromJson(data),
        );
      },
    );

    //    await Future.delayed(Duration(seconds: 2));

    // var dummyData = {
    //   "status": {"code": "000000", "message": "SUCCESS"},
    //   "data": [
    //     {
    //       "fieldKey": "NameofPerson",
    //       "fieldName": "Full Name",
    //       "fieldOption": "mandatory",
    //       "fieldLength": "50",
    //       "fieldValidations": "[a-zA-Z ]+",
    //       "fieldType": "alphabets",
    //       "fieldList": null,
    //       "sequence": 1,
    //     },
    //     {
    //       "fieldKey": "TypeOfBusiness",
    //       "fieldName": "Type Of Business",
    //       "fieldOption": "mandatory",
    //       "fieldLength": "200",
    //       "fieldValidations": "[a-zA-Z ]+",
    //       "fieldType": "alphabets",
    //       "fieldOptions": null,
    //       "sequence": 3,
    //     },
    //     {
    //       "fieldKey": "ContactNo",
    //       "fieldName": "Contact No",
    //       "fieldOption": "optional",
    //       "fieldLength": "10",
    //       "fieldValidations": "[0-9]+",
    //       "fieldType": "numeric",
    //       "fieldOptions": null,
    //       "sequence": 2,
    //     },
    //   ],
    // };
    // // // return ApiEnvelope.success(

    // //   ApiError(code: '00000'),
    // //   AppStatus.success,
    // // );
    // return ApiMapper.mapList<ContactUsModalDto>(
    //   dummyData,
    //   (data) => ContactUsModalDto.fromJson(data),
    // );

    // return ApiMapper.mapList(dummyData, (data) {
    //   consoleLog('**contactus $data');
    //   return ContactUsModalPayloadItemDto.fromJson(data);
    // });
  } catch (e, s) {
    logger.e("Login Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to fetch products contactus '),
      AppStatus.error,
    );
  }
}
