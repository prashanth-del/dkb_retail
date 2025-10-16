import 'package:dio/dio.dart';
import 'package:dkb_retail/network/data/network_client.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/urls/reach_us_url.dart';
import '../models/branch_atm_kiosk_response.dart';

abstract class LocateUsDataSource {
  Future<BranchAtmKioskResponse> getLocateUsResponse({
    required Map<String, dynamic> requestBody,
  });
}

class LocateUsDataSourceImpl implements LocateUsDataSource {
  LocateUsDataSourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<BranchAtmKioskResponse> getLocateUsResponse({
    required Map<String, dynamic> requestBody,
  }) async {
    var uri = ReachUsUrl.locateUsUrl;
    var bodyRequest = {
      "moduleID": "accounts",
      "unit": "EGY",
    }; // change this based on each apis
    try {
      final client = networkClient.customDio(
        serviceId: "ACCSUM",
        authorizationRequired: true,
        moduleId: "ACCSUM",
        subModuleId: "ACCSUM",
        // accept_language: "en",
        // channel: "MB",
        screenId: "ACCSUM",
      );

      print(
        "lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll",
      );
      final response = await client.get(uri, data: bodyRequest);
      final responseData = response;
      BranchAtmKioskResponse branchAtmKioskResponse =
          BranchAtmKioskResponse.fromJson(
            responseData.data,
          ); // instead of responseData
      return branchAtmKioskResponse;
    } on TypeError catch (e) {
      print(e);
      throw ServiceException("Unable to load data");
    } on DioException catch (e) {
      throw ServiceException("Unable to load data");
    } on Exception catch (e) {
      throw ServiceException("Unable to load data");
    }
  }
}
