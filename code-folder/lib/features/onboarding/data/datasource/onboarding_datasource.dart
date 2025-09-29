import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dio/dio.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/onboarding/data/model/onboarding_block_check_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_response.dart';
import '../model/onboarding_block_journey_model.dart';
import '../model/onboarding_create_journey_model.dart';
import '../model/onboarding_file_upload_model.dart';
import '../model/onboarding_retrieve_journey_model.dart';
import '../model/onboarding_save_stage_data_model.dart';
import '../model/onboarding_stage_sum_model.dart';
import '../model/onboarding_update_account_model.dart';

abstract class OnboardingDatasource {
  Future<OnboardingBlockCheckModel> getBlockCheck();
  Future<OnboardingStageSumModel> getStageSum();

  Future<OnboardingSaveStageDataModel> saveStageData({
    required int custJourneyId,
    required String stageId,
    required Map<String, dynamic> data,
  });

  Future<OnboardingUpdateAccountModel> updateAccount({
    required int custJourneyId,
    required String accountNumber,
  });

  Future<OnboardingCreateJourneyModel> createJourney({
    required String nationalId,
    required String mobileNumber,
  });

  Future<OnboardingFileUploadModel> sendFileUpload({
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  });

  Future<OnboardingBlockJourneyModel> blockJourney({
    required String mobileNumber,
    required String blockPeriod,
    required String nationalId,
    required String blockReason,
  });

  // Future<OnboardingBlockCheckModel> getBlockJourneyStatus({
  //   required String deviceId,
  //   required String mobileNumber,
  //   required String blockPeriod,
  //   required String nationalId,
  //   required String blockReason,
  //
  // });
  Future<OnboardingRetrieveJourneyModel> retrieveJourney({
    required String nationalId,
    required String mobileNumber,
  });
}

class OnboardingDatasourceImpl extends OnboardingDatasource {
  final NetworkClient networkClient;

  OnboardingDatasourceImpl({required this.networkClient});

  @override
  Future<OnboardingBlockCheckModel> getBlockCheck() async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "BLOCK_CHECK",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {"isblocked": "false"},
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");

      return OnboardingBlockCheckModel.fromJson(responseData!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingSaveStageDataModel> saveStageData({
    required int custJourneyId,
    required String stageId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "BLOCK_CHECK",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        // "data": {
        //   // "isblocked": "false"
        // }
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['status'];
      consoleLog("SuccessResponse $responseData");

      return OnboardingSaveStageDataModel.fromJson(response['status']!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingUpdateAccountModel> updateAccount({
    required int custJourneyId,
    required String accountNumber,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "UPDATE_ACC",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        // "data": {
        //   // "isblocked": "false"
        // }
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['status'];
      consoleLog("SuccessResponse $responseData");

      return OnboardingUpdateAccountModel.fromJson(response['status']!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingStageSumModel> getStageSum() async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "STAGE_SUM",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {
          "Stagedata": [
            {
              "stageId": "OPEN_NEW_ACC_REQ",
              "stageDesc": "Open new account requirements screen",
              "priority": 1,
            },
            {
              "stageId": "OPEN_NEW_ACC_DTL",
              "stageDesc": "Open new account (QID/Mobile No & T&C)",
              "priority": 2,
            },
            {
              "stageId": "VALIADATE_OTP",
              "stageDesc": "Validate OTP",
              "priority": 3,
            },
            {
              "stageId": "PRODUCTION_SELECTION",
              "stageDesc": "Production Selection",
              "priority": 4,
            },
            {
              "stageId": "IDENTIFICATION_QID",
              "stageDesc": "Identification (QID Scan & Requirement screen)",
              "priority": 5,
            },
            {
              "stageId": "QID_SCAN",
              "stageDesc": "QID Scanning both side",
              "priority": 6,
            },
            {
              "stageId": "IDENTIFICATION_SCAN_SUM",
              "stageDesc": "Identification Summary (scan summary)",
              "priority": 7,
            },
            {
              "stageId": "IDENTIFICATION_PASSPORT",
              "stageDesc": "Identification - Passport Scanning",
              "priority": 8,
            },
            {
              "stageId": "IDENTIFICATION_SUM",
              "stageDesc": "Identification-summary",
              "priority": 9,
            },
            {
              "stageId": "IDENTIFICATION_SELFIE",
              "stageDesc": "Identification-selfie",
              "priority": 10,
            },
            {
              "stageId": "TAKE_SELFIE",
              "stageDesc": "Take selfie",
              "priority": 11,
            },
            {
              "stageId": "IDENTIFICATION_DTL",
              "stageDesc":
                  "Identification-basic details(auto filled based on scanned data upon MOI validation)",
              "priority": 12,
            },
            {
              "stageId": "IDENTIFICATION_INFO",
              "stageDesc": "Identification- additional info",
              "priority": 13,
            },
            {
              "stageId": "IDENTIFICATION_RESIDENT",
              "stageDesc":
                  "Identification-resident address info with document upload for address proof",
              "priority": 14,
            },
            {
              "stageId": "IDENTIFICATION_ADDRESS",
              "stageDesc": "Identification-Home Country Resident Address",
              "priority": 15,
            },
            {
              "stageId": "FINANTIAL_DTL",
              "stageDesc": "Financial Details with address proof attachment",
              "priority": 16,
            },
            {
              "stageId": "FINANTIAL_DTL2",
              "stageDesc": "Financial Details screen2",
              "priority": 17,
            },
            {
              "stageId": "FINANTIAL_DTL3",
              "stageDesc": "Financial Details3",
              "priority": 18,
            },
            {
              "stageId": "TAX_RESIDENCY",
              "stageDesc": "Tax Residency 1",
              "priority": 19,
            },
            {
              "stageId": "TAX_RESIDENCY2",
              "stageDesc": "Tax Residency2",
              "priority": 20,
            },
            {
              "stageId": "TAX_RESIDENCY_COUNTRY",
              "stageDesc": "Tax Residency home country",
              "priority": 21,
            },
            {"stageId": "SUMMARY", "stageDesc": "Summary", "priority": 22},
            {
              "stageId": "DOC_T&C",
              "stageDesc": "Documentation & Terms and conditions",
              "priority": 23,
            },
            {"stageId": "SIGN", "stageDesc": "Signature", "priority": 24},
            {"stageId": "OTP", "stageDesc": "OTP", "priority": 25},
            {
              "stageId": "ACCOUNT_CREATION",
              "stageDesc": "Account Creation",
              "priority": 26,
            },
            {
              "stageId": "CONFIRMATION",
              "stageDesc": "Confirmation",
              "priority": 27,
            },
            {
              "stageId": "USER_NAME_PWD",
              "stageDesc": "User name and password creation",
              "priority": 28,
            },
            {
              "stageId": "CONGRATS",
              "stageDesc": "Congratulations",
              "priority": 29,
            },
            {
              "stageId": "PROCEED_LGN",
              "stageDesc": "Proceed to login",
              "priority": 30,
            },
          ],
        },
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");
      return OnboardingStageSumModel.fromJson(responseData!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingFileUploadModel> sendFileUpload({
    required String fileExtension,
    required String fileSize,
    required String nationalId,
    required String mobileNumber,
    required String fileType,
    required String fileBase64,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "BLOCK_CHECK",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {
          "fileType": fileType,
          "fileName": "4444Test0901251224086852",
          "fullName": "Mohammed Abdullah",
          "QIDNumber": "28425001234",
          "expirationDate": "07/06/2024",
          "dateOfBirth": "21/11/1981",
          "Nationality": "Qatari",
        },
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");
      return OnboardingFileUploadModel.fromJson(response);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingBlockJourneyModel> blockJourney({
    required String mobileNumber,
    required String blockPeriod,
    required String nationalId,
    required String blockReason,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        screenId: "BLOCK_CHECK",
      );
      dio.options.headers.remove("customerId");
      DeviceModel? deviceModel = await DeviceInfo(
        appVer: "",
        endToEndId: '',
      ).deviceType();
      final reqBody = {"deviceId": deviceModel?.deviceId};
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/blockCheck", data: reqBody);
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingBlockCheckModel.fromJson(data['data']));
      // if (apiRes.isSuccess) {
      //   return apiRes.data!;
      // }

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {"Message": "This data is added in the block journey"},
      };

      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");
      return OnboardingBlockJourneyModel.fromJson(responseData!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingCreateJourneyModel> createJourney({
    required String nationalId,
    required String mobileNumber,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        // serviceId: "LOANDET",
        screenId: "CREATE_JOURNEY",
        // moduleId: "LOAN",
        // subModuleId: "DETAILS"
      );
      dio.options.headers.remove("customerId");
      final reqBody = {"nationalId": nationalId, "mobileNumber": mobileNumber};
      consoleLog("Request Body: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {"custJourneyId": 6},
      };
      // final res =
      // await dio.post("/digital-onboarding/onboard/v1/retriveJourney", options: Options(headers: {
      //   "channel": "MB",
      //   "unit": "PRD",
      //   "screenId":"RETRIEVE_JOURNEY",
      //   "Accept-Language": 'en',
      // }), data: reqBody);
      // consoleLog("RRRRRRRRRRRRR : $res");
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingRetrieveJourneyModel.fromJson(data['data']));
      // consoleLog("Response: $apiRes");
      // if (apiRes.isSuccess) {
      //   return apiR"es.data!;
      // }
      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");
      return OnboardingCreateJourneyModel.fromJson(responseData!);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }

  @override
  Future<OnboardingRetrieveJourneyModel> retrieveJourney({
    required String nationalId,
    required String mobileNumber,
  }) async {
    try {
      final dio = networkClient.customDio(
        authorizationRequired: false,
        // serviceId: "LOANDET",
        screenId: "RETRIEVE_JOURNEY",
        // moduleId: "LOAN",
        // subModuleId: "DETAILS"
      );
      dio.options.headers.remove("customerId");
      final reqBody = {"nationalId": nationalId, "mobileNumber": mobileNumber};
      consoleLog("Request Bodyhhhhhhhh: $reqBody");

      var dummyResponse = {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {
          "summary": {
            "OPEN_NEW_ACC_DTL": {
              "QID": "11111111111",
              "Mobile_No": "+974 33333333",
              "T&c": "YES",
            },
            "VALIADATE_OTP": {"Validate_OTP": "YES"},
            "PRODUCTION_SELECTION": {
              "Product_Type": "Savings Account",
              "Branch_Selected": "Dukhan Bank - City Center Branch 1",
            },
            "IDENTIFICATION_QID": {"Identification_QID": "YES"},
            "QID_SCAN": {
              "frontImage": "_frontImage",
              "backImage": "_backImage",
            },
            "IDENTIFICATION_SCAN_SUM": {
              "fullName": "Mohammed Abdullah",
              "QIDNumber": "28425001234",
              "expirationDate": "07/06/2024",
              "dateOfBirth": "21/11/1981",
              "Nationality": "Qatari",
            },
            "IDENTIFICATION_PASSPORT": {
              "Name": "User3",
              "streetNumber": "12345",
              "buildingNumber": "23465",
              "flat_villa_unit_no": "2",
              "Last Name": "Last name",
            },
            "IDENTIFICATION_SUM": {
              "Name": "User3",
              "streetNumber": "12345",
              "buildingNumber": "23465",
              "flat_villa_unit_no": "2",
              "Last Name": "Last name",
            },
            "IDENTIFICATION_SELFIE": {"Identification-selfie": "YES"},
            "TAKE_SELFIE": {"TAKE_SELFIE": "_imageFile"},
            "IDENTIFICATION_DTL": {
              "salutation": "Ms",
              "short_name": "AAAAAA",
              "full_name": "Ali Mohammed Ahmed Faisal Al Than",
              "E_mail": "aaaaaa@gmail.com",
            },
            "IDENTIFICATION_INFO": {
              "Country_of_birth": "Qatar",
              "City_of_Birth": "Doha",
              "Marital_status": "Married",
              "EmploymentStatus": "Student",
              "Profession": "",
              "Other_employee_status": "",
              "Designation_Job": "",
              "Employee_name": "",
            },
            "IDENTIFICATION_RESIDENT": {
              "Area_number": "Area No:1223",
              "Street_name": "Street Name: street",
              "Building_number": "No.1233",
              "Zone_number": "6000069",
              "Proof_address_type": "Bill",
            },
            "IDENTIFICATION_ADDRESS": {
              "Area_number": "Area No: 123",
              "Street_name": "Streetr Name: street",
              "PO_Box": "No.222",
              "Country": "Qatar",
              "Same_As_Personal_Address": "YES",
            },
            "FINANTIAL_DTL": {
              "Source_of_Income": "Self-Employed",
              "other_Source": "",
              "country": "Qatar",
              "uploaded": "selectedFile",
              "Source_of_wealth": "Investments",
              "TotalMonthlySalary": "QAR 100",
              "Estimated_net_worth_assets": "QAR 120",
              "Additional_Income": "QAR 1000",
              "Total_Annual_Income": "QAR 2200",
              "withdrawals": "1",
              "Deposits": '1',
            },
            "FINANTIAL_DTL2": {"Financial_details": "Savings"},
            "FINANTIAL_DTL3": {"Financial_Details3": "NO"},
            "TAX_RESIDENCY": {"TIN_Number": "1111111111111111"},
            "TAX_RESIDENCY2": {
              "Other_Countries_Tax_Residency": ["Qatar", "India"],
            },
            "TAX_RESIDENCY_COUNTRY": {"TIN_Number": "11111111111111"},
            "SUMMARY": {
              "stageId": "SUMMARY",
              "stageDesc": "Summary",
              "priority": 22,
            },
            "DOC_T&C": {"Documentation & Terms and conditions": "YES"},
            "SIGN": {"Sign_Image": "_signatureImage"},
            "OTP": {"OTP": "YES"},
            "ACCOUNT_CREATION": {"Account_Creation": "YES"},
            "CONFIRMATION": {"CONFIRMATION": "YES"},
            "USER_NAME_PWD": {
              "Username": "AAAAA",
              "password": "BBBBB",
              "Confirm_password": "BBBBB",
            },
            "CONGRATS": {"CONGRATS": "YES"},
            "PROCEED_LGN": {"PROCEED_LGN": "YES"},
          },
        },
        "custJourneyId": "6",
        "nextStageDesc": "Take selfie",
        "nextStageId": "TAKE_SELFIE",
      }; // final res =
      // await dio.post("/digital-onboarding/onboard/v1/retriveJourney", options: Options(headers: {
      //   "channel": "MB",
      //   "unit": "PRD",
      //   "screenId":"RETRIEVE_JOURNEY",
      //   "Accept-Language": 'en',
      // }), data: reqBody);
      // consoleLog("RRRRRRRRRRRRR : $res");
      // final apiRes = ApiResponse.fromJson(
      //     res.data, (data) => OnboardingRetrieveJourneyModel.fromJson(data['data']));
      // consoleLog("Response: $apiRes");
      // if (apiRes.isSuccess) {
      //   return apiR"es.data!;
      // }
      final response =
          dummyResponse; //await client.post(uri, data: requestBody);
      final responseData = response['data'];
      consoleLog("SuccessResponse $responseData");
      return OnboardingRetrieveJourneyModel.fromJson(response);

      // throw ServiceException(apiRes.error ?? "Server Error");
    } on TypeError catch (e) {
      throw ServiceException("Type Conversion Error");
    } on DioException catch (e) {
      throw ServiceException("Server Error");
    } catch (e) {
      throw GeneralException(e.toString());
    }
  }
}
