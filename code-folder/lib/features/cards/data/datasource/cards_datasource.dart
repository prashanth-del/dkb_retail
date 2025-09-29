import 'package:dio/dio.dart';

import '../../../../common/utils.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/urls/card_url.dart';
import '../model/card_summary_model.dart';

abstract class CardsDatasource {
  Future<CardSummaryModel> getCardSummary(
      {required String field, required String type});
}

class CardsDatasourceImpl implements CardsDatasource {
  final NetworkClient networkClient;

  CardsDatasourceImpl({required this.networkClient});


  @override
  Future<CardSummaryModel> getCardSummary(
      {required String field, required String type}) async {
    try {
      const uri = CardUrl.getCardSummaryEndpoint;

      var requestBody = {
        "cardSumAndStmtReq": {
          "sort": [
            {"field": field, "type": type}
          ]
        },
        "deviceInfo": await getDeviceInfo()
      };

      final client = networkClient.customDio(
        serviceId: "CRDSUM",
        authorizationRequired: false,
        moduleId: "CARD",
        subModuleId: "SUMMARY",
        screenId: "CRDSUM",
      );

      // final response = CardSummaryModel.dummyResponse;
      // final responseData = response['data'];
      //
      // CardSummaryModel accountSummaryModel =
      // CardSummaryModel.fromJson(responseData);
      // return accountSummaryModel;

      final response = await client.post(uri, data: requestBody);
      final accSummaryJson = response.data;
      if (accSummaryJson['status']['code'] == '000000') {
        CardSummaryModel cardSummaryModel = CardSummaryModel.fromJson(response.data["data"]);

        return cardSummaryModel;
      } else {
        throw ServiceException(accSummaryJson["status"]["description"]);
      }

    } on TypeError catch (e) {
      throw ServiceException("Unable to load cards");
    } on DioException catch (e) {
      throw ServiceException("Unable to load cards");
    } on Exception catch (e) {
      throw ServiceException("Unable to load cards");
    }
  }

}
