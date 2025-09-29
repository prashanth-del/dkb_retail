import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/account_url.dart';
import '../model/account_summary_model.dart';

abstract class AccountsDatasource {
  Future<AccountSummaryModel> getAccountSummary(
      {required Map<String, dynamic> requestBody});
}

class AccountsDatasourceImpl implements AccountsDatasource {
  final NetworkClient networkClient;

  AccountsDatasourceImpl({required this.networkClient});

  @override
  Future<AccountSummaryModel> getAccountSummary(
      {required Map<String, dynamic> requestBody}) async {
    try {
      var uri = AccountUrl.getAccountSummaryEndpoint;

      final client = networkClient.customDio(
        serviceId: "ACCSUM",
        authorizationRequired: true,
        moduleId: "ACCOUNT",
        subModuleId: "SUMMARY",
        screenId: "ACC-SUMMARY",
      );
      // final response = AccountSummaryModel.dummyResponse;
      // final responseData = response['data'];
      final response = await client.post(uri, data: requestBody);
      final responseData = response.data['data'];

      AccountSummaryModel accountSummaryModel =
          AccountSummaryModel.fromJson(responseData);
      return accountSummaryModel;
    } on TypeError catch (e) {
      throw ServiceException("Unable to load accounts");
    } on DioException catch (e) {
      throw ServiceException("Unable to load accounts");
    } on Exception catch (e) {
      throw ServiceException("Unable to load accounts");
    }
  }
}
