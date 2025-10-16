part of '../card_validation_datasource.dart';

Future<ApiEnvelope<List<CardValidationModalDto>>> _getCardValidations(
  NetworkClient client,
) async {
  final logger = Logger();
  try {
    const cardValidationUrl = LoginUrl.cardValidations;
    final dio = client.customDio(
      authorizationRequired: false,
      screenId: 'BIN',
      serviceId: 'BIN',
      subModuleId: 'BIN',
      moduleId: 'BIN',
    );

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

    final requestJson = {
      "requestInfo": {},
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

    return executeApiCall<List<CardValidationModalDto>>(
      call: () => dio.post(cardValidationUrl, data: requestJson),
      mapJson: (json) {
        return ApiMapper.mapList(
          json,
          (data) => CardValidationModalDto.fromJson(data),
        );
      },
    );

    // return executeApiCall<List<CardValidationModalDto>>(
    //   call: () => dio.get(cardValidationUrl),
    //   mapJson: (json) {
    //     // json['data'] is the list of cards
    //     final dataList = (json['data'] as List<dynamic>?) ?? [];

    //     return ApiMapper.mapList(
    //       json, // mapList still receives the full JSON
    //       (item) =>
    //           CardValidationModalDto.fromJson(item as Map<String, dynamic>),
    //     );
    //   },
    // );

    // await Future.delayed(Duration(seconds: 2));

    // var dummyData = {
    //   "data": [
    //     {
    //       "code": "1050",
    //       "bin": "12345678",
    //       "productType": "MC Infinity Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1051",
    //       "bin": "345678",
    //       "productType": "MC Infinity Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //   ],
    //   "status": {"code": "000000", "description": "SUCCESS"},
    // };

    // var dummyData = {
    //   "data": [
    //     {
    //       "code": "401",
    //       "bin": "420374",
    //       "productType": "ISLAMIC PLATINUM",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "900",
    //       "bin": "527158",
    //       "productType": "MC PRESTIGE DEBT",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "005",
    //       "bin": "420375",
    //       "productType": "PRESTIGE DEBIT",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "101",
    //       "bin": "457658",
    //       "productType": "INIFINITE DEBIT",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "701",
    //       "bin": "512713",
    //       "productType": "MC QND PLATINUM CR",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "003",
    //       "bin": "420375",
    //       "productType": "SALARY CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "301",
    //       "bin": "420373",
    //       "productType": "ISLAMIC GOLD",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "203",
    //       "bin": "420374",
    //       "productType": "VISA PLATINUM",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "702",
    //       "bin": "527283",
    //       "productType": "PREPAID",
    //       "cardType": "PREPAID",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "700",
    //       "bin": "512713",
    //       "productType": "MC PLATINUM CR",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "600",
    //       "bin": "516140",
    //       "productType": "MC PRIVATE CR",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "068",
    //       "bin": "557686",
    //       "productType": "DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "070",
    //       "bin": "532704",
    //       "productType": "DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "066",
    //       "bin": "557685",
    //       "productType": "DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "075",
    //       "bin": "425886",
    //       "productType": "CREDIT CARD",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "706",
    //       "bin": "639950",
    //       "productType": "HIMYAN",
    //       "cardType": "PREPAID",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "716",
    //       "bin": "639950",
    //       "productType": "HIMYAN DEBIT",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "704",
    //       "bin": "527283",
    //       "productType": "PREPAID",
    //       "cardType": "PREPAID",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "411",
    //       "bin": "438227",
    //       "productType": "GREEN SIGNATURE CREDIT",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "403",
    //       "bin": "420374",
    //       "productType": "VISA PLATINUM CREDIT H",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "608",
    //       "bin": "457659",
    //       "productType": "VISA AFFLUENT INFINITE CREDIT",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "102",
    //       "bin": "457658",
    //       "productType": "INFINITE DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "703",
    //       "bin": "512713",
    //       "productType": "MC ALMAJD CREDIT",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "999",
    //       "bin": "538611",
    //       "productType": "MC Platinum",
    //       "cardType": "PREPAID",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "604",
    //       "bin": "457659",
    //       "productType": "INFINITE PRIV CARD",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "603",
    //       "bin": "457659",
    //       "productType": "INFINITE CREDIT",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "073",
    //       "bin": "425886",
    //       "productType": "INIFINITE DEBIT",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "051",
    //       "bin": "408597",
    //       "productType": "Platinum Card",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "606",
    //       "bin": "457659",
    //       "productType": "INFINITE RETAIL METAL CREDIT",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "006",
    //       "bin": "420375",
    //       "productType": "Home Worker Card",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "801",
    //       "bin": "510463",
    //       "productType": "MC World Retail Debit Card",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "062",
    //       "bin": "475790",
    //       "productType": "SIGNATURE CARD",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "058",
    //       "bin": "557686",
    //       "productType": "DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "082",
    //       "bin": "532704",
    //       "productType": "DEBIT CARD",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "226",
    //       "bin": "425886",
    //       "productType": "CREDIT CARD",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "993",
    //       "bin": "90909090",
    //       "productType": "MC Platinum",
    //       "cardType": "PREPAID",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "994",
    //       "bin": "90909091",
    //       "productType": "MC Premium Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "995",
    //       "bin": "90909092",
    //       "productType": "MC Premium Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "996",
    //       "bin": "90909093",
    //       "productType": "Visa Gold Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "998",
    //       "bin": "90909095",
    //       "productType": "Visa Signature Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1000",
    //       "bin": "90909096",
    //       "productType": "Visa Business Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1001",
    //       "bin": "90909097",
    //       "productType": "Visa Infinite Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1002",
    //       "bin": "90909098",
    //       "productType": "Visa Travel Card",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1003",
    //       "bin": "90909099",
    //       "productType": "Visa Reward Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1005",
    //       "bin": "90909101",
    //       "productType": "MC Travel Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1006",
    //       "bin": "90909102",
    //       "productType": "MC Travel Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1007",
    //       "bin": "90909103",
    //       "productType": "MC Shopping Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1008",
    //       "bin": "90909104",
    //       "productType": "MC Shopping Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1009",
    //       "bin": "90909105",
    //       "productType": "MC Corporate Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1010",
    //       "bin": "90909106",
    //       "productType": "MC Corporate Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1012",
    //       "bin": "90909108",
    //       "productType": "Visa Silver Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1013",
    //       "bin": "90909109",
    //       "productType": "Visa Silver Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1014",
    //       "bin": "90909110",
    //       "productType": "MC Silver Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1015",
    //       "bin": "90909111",
    //       "productType": "MC Silver Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1016",
    //       "bin": "90909112",
    //       "productType": "MC Classic Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1017",
    //       "bin": "90909113",
    //       "productType": "MC Classic Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1018",
    //       "bin": "90909114",
    //       "productType": "Visa Student Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1019",
    //       "bin": "90909115",
    //       "productType": "Visa Student Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1020",
    //       "bin": "90909116",
    //       "productType": "MC Student Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1022",
    //       "bin": "90909118",
    //       "productType": "Visa Business Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1023",
    //       "bin": "90909119",
    //       "productType": "Visa Business Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1024",
    //       "bin": "90909120",
    //       "productType": "MC Business Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1025",
    //       "bin": "90909121",
    //       "productType": "MC Business Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1026",
    //       "bin": "90909122",
    //       "productType": "Visa Premium Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1027",
    //       "bin": "90909123",
    //       "productType": "Visa Premium Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1029",
    //       "bin": "90909125",
    //       "productType": "MC Premium Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1030",
    //       "bin": "90909126",
    //       "productType": "Visa Rewards Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1031",
    //       "bin": "90909127",
    //       "productType": "Visa Rewards Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1032",
    //       "bin": "90909128",
    //       "productType": "MC Rewards Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1033",
    //       "bin": "90909129",
    //       "productType": "MC Rewards Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1034",
    //       "bin": "90909130",
    //       "productType": "Visa Lifestyle Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1035",
    //       "bin": "90909131",
    //       "productType": "Visa Lifestyle Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1036",
    //       "bin": "90909132",
    //       "productType": "MC Lifestyle Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1037",
    //       "bin": "90909133",
    //       "productType": "MC Lifestyle Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1039",
    //       "bin": "90909135",
    //       "productType": "Visa Family Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1040",
    //       "bin": "90909136",
    //       "productType": "MC Family Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1041",
    //       "bin": "90909137",
    //       "productType": "MC Family Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1042",
    //       "bin": "90909138",
    //       "productType": "Visa Youth Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1043",
    //       "bin": "90909139",
    //       "productType": "Visa Youth Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1044",
    //       "bin": "90909140",
    //       "productType": "MC Youth Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1045",
    //       "bin": "90909141",
    //       "productType": "MC Youth Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1046",
    //       "bin": "90909142",
    //       "productType": "Visa Digital Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1048",
    //       "bin": "90909144",
    //       "productType": "MC Digital Debit",
    //       "cardType": "DEBIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1049",
    //       "bin": "90909145",
    //       "productType": "MC Digital Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //     {
    //       "code": "1050",
    //       "bin": "90909146",
    //       "productType": "MC Infinity Credit",
    //       "cardType": "CREDIT",
    //       "status": "ACTIVE",
    //     },
    //   ],
    //   "status": {"code": "000000", "description": "SUCCESS"},
    // };

    // return ApiMapper.mapList<CardValidationModalDto>(
    //   dummyData,
    //   (data) => CardValidationModalDto.fromJson(data),
    // );
  } catch (e, s) {
    logger.e("Error", error: e, stackTrace: s);
    return ApiEnvelope.error(
      const ApiError(description: 'Unable to card validations'),
      AppStatus.error,
    );
  }
}
