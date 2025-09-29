// Data source for reach_us — implement your API calls here.
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/network_client.dart';
import '../models/transfer_detail_dto.dart';

abstract class ReachUsDataSource {
  // Example:
  // Future<Map<String, dynamic>> login({required String username, required String password});

  Future<TransferDetailDto> getTestList({
    required Map<String, dynamic> requestBody,
  });
}

class ReachUsDataSourceImpl implements ReachUsDataSource {
  ReachUsDataSourceImpl({required this.networkClient});
  final NetworkClient networkClient;

  @override
  Future<TransferDetailDto> getTestList({
    required Map<String, dynamic> requestBody,
  }) async {
    //  var uri = DashboardUrl.countryURL;
    // var bodyRequest = {
    //   "customerNo": "1207026",
    //   "userName": "apr1207026",
    //   "branchCode": "0011",
    //   "countryCode": "EG",
    // };
    try {
      // final client = networkClient.customDio(
      //   serviceId: "TRANS_DET",
      //   authorizationRequired: true,
      //   moduleId: "P08",
      //   subModuleId: "SP20",
      //   // accept_language: "en",
      //   // channel: "MB",
      //   screenId: "TRANS",
      // );

      print(
        "lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll",
      );
      final dummyData = {
        "atkn":
            "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcHIxMjA3MDI2IiwiaWF0IjoxNzMzNjQ0NDIyLCJleHAiOjE3MzM2NDYyMjIsImlzcyI6IkRCIiwianRpIjoiMDdiZTNmZjMtNDFkZS00OTZhLTkyYjgtNTFmYWU1OGUwNjE0In0.Zw2nxRDA3gg-CRvxlQTEZsrAlCewf9GDrLX_BhXwbzguJHOfSY2T40sF_9cKLl-k4-phtdAWetijkoAWitNKJoCjtXkNJ4bBnNHcHK7Rr1JJ6NZSdCwVmrBhxsF3HKkxLW1PByf8t65c1CYoiqKS6s_KYiloN1r4_5WjwQx4DcnpYRoqt3oItt2ExIXWX041LwNDyBcyEbSGjTIZT6ZOrtlQXh8drEoiZ_9UIFcqBB6-mIblce_vkrMTjcLrM3uvvADkOIZqq27r2gRIyxDnMjXLSx1sYq_KShEflxyZTSOlvb3p6yVdvanx29pZk2UQIctSiSDaTKmshiRMyUsAg",
        "reftkn":
            "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcHIxMjA3MDI2IiwiaWF0IjoxNzMzNjQ0NDIyLCJleHAiOjE3MzM2NDYyMjIsImlzcyI6IkRCIiwianRpIjoiMDdiZTNmZjMtNDFkZS00OTZhLTkyYjgtNTFmYWU1OGUwNjE0In0.Zw2nxRDA3gg-CRvxlQTEZsrAlCewf9GDrLX_BhXwbzguJHOfSY2T40sF_9cKLl-k4-phtdAWetijkoAWitNKJoCjtXkNJ4bBnNHcHK7Rr1JJ6NZSdCwVmrBhxsF3HKkxLW1PByf8t65c1CYoiqKS6s_KYiloN1r4_5WjwQx4DcnpYRoqt3oItt2ExIXWX041LwNDyBcyEbSGjTIZT6ZOrtlQXh8drEoiZ_9UIFcqBB6-mIblce_vkrMTjcLrM3uvvADkOIZqq27r2gRIyxDnMjXLSx1sYq_KShEflxyZTSOlvb3p6yVdvanx29pZk2UQIctSiSDaTKmshiRMyUsAg",
        "customerNumber": "1207026",
        "branchCode": "222",
        "firstLogin": "1",
        "accessDate": "08/12/2024 10:52:13 AM",
        "custinfoFlag": "N",
        "preferredLang": "EN",
        "preferredUnits": "[]",
        "registeredUnit": "PRD",
        "isOtpRequired": "Y",
        "userName": "apr1207026",
        "customerSegment": "N",
        "customerType": "null",
        "far": "59",
        "userNo": "09",
        "userId": "apr1207026",
        "customerId": "4545",
        "emailId": "sdileep@dohabank.com.qa",
        "otpRefNo": "",
        "maskedMobileNo": "+974***2529",
        "dcUserName": "Corp Cust TestX",
        "registrationDate": "2023-11-06T12:12:49+03:00",
        "address1": ", 112A,Test Street, Doha, Qatar",
        "authorityAmount": "50000000",
        "userRole": "Approver",
        "userRoleCode": "A",
        "companyNameRole": "apr1207026-Approver",
        "dccustomerTypeID": "7",
      };
      TransferDetailDto assetsAndLiabilitiesModel = TransferDetailDto.fromJson(
        dummyData,
      ); // instead of responseData
      return assetsAndLiabilitiesModel;
    } on TypeError catch (e) {
      print("errrrrrrrrrrrrrrrrrror");
      print(e);
      throw ServiceException("Unable to load data");
    } on DioException catch (e) {
      throw ServiceException("Unable to load data");
    } on Exception catch (e) {
      throw ServiceException("Unable to load data");
    }
  }
}
