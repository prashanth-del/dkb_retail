import '../../../../core/errors/exception_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/domain/models/api_response.dart';
import '../../domain/entity/request/active_session_req.dart';
import '../../domain/entity/request/transaction_filter_req.dart';
import '../models/active_session_dto.dart';
import '../models/channel_dto.dart';
import '../models/platform_transaction_dto.dart';
import '../models/transaction_analysis_dto.dart';
import '../models/transaction_summary_dto.dart';

abstract class DashboardDatasource {
  Future<TransactionSummaryDto> getTransactionSummary(TransactionFilterReq req);
  Future<ActiveSessionDto> getActiveSession(ActiveSessionReq req);
  Future<TransactionAnalysisDto> getTransactionMetrixAnalysis(
      TransactionFilterReq req);

  Future<PlatformTransactionAnalysisDto> getPlatformTransactionMetrixAnalysis(
      TransactionFilterReq req);

  Future<TrasactionChannelDto> getTrsactionChannelsMetrix(
      TransactionFilterReq req);
}

class DashboardDatasourceImpl extends DashboardDatasource {
  NetworkClient networkClient;

  DashboardDatasourceImpl(this.networkClient);
  @override
  Future<TransactionSummaryDto> getTransactionSummary(
      TransactionFilterReq req) async {
    try {
      final dio = networkClient.customDio(
          serviceId: "metricsByService",
          screenId: "ANALYTICS",
          authorizationRequired: true);

      final reqBody = {
        "startDate": req.startDate,
        "endDate": req.endDate,
        "filter": {"channels": req.channels}
      };

      final res = await dio.post("/common-service/common/txnMetricsByDateRange",
          data: reqBody);

      final apiRes = ApiResponse<TransactionSummaryDto>.fromJson(
          res.data, (data) => TransactionSummaryDto.fromJson(data));

      if (apiRes.isSuccess) {
        return apiRes.data!;
      } else {
        throw ServiceException(apiRes.status?.description ?? "Error");
      }
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future<TransactionAnalysisDto> getTransactionMetrixAnalysis(
      TransactionFilterReq req) async {
    try {
      final dio = networkClient.customDio(
          serviceId: "metricsByService",
          screenId: "ANALYTICS",
          authorizationRequired: true);

      final reqBody = {
        "startDate": req.startDate ?? "",
        "endDate": req.endDate ?? "",
        "type": req.type,
        "filter": {
          "channels":
              req.channels?.where((channel) => channel != "All").toList(),
          "serviceTypes": [
            "Login",
            "Transfers",
            "Beneficiary",
            "Payments",
          ]
        }
      };

      final res =
          await dio.post("/common-service/common/txnMetrics", data: reqBody);

      // final res = {
      //   "status": {"code": "000000", "description": "SUCCESS"},
      //   "data": {
      //     "transactionAnalysis": {
      //       "totalTransactions": 886,
      //       "services": [
      //         {
      //           "serviceType": "fundTransfers",
      //           "successCount": 466,
      //           "failureCount": 420,
      //           "channelBreakdown": [
      //             {
      //               "channelId": "MB",
      //               "successCount": 466,
      //               "failureCount": 420,
      //               "failureReasons": [
      //                 {"reason": "Message", "count": 420}
      //               ]
      //             },
      //             {
      //               "channelId": "IB",
      //               "successCount": 200,
      //               "failureCount": 420,
      //               "failureReasons": [
      //                 {"reason": "Message", "count": 420}
      //               ]
      //             }
      //           ],
      //           "successRate": "50.60",
      //           "failureRate": "47.40"
      //         },
      //         {
      //           "serviceType": "Payments",
      //           "successCount": 466,
      //           "failureCount": 420,
      //           "channelBreakdown": [
      //             {
      //               "channelId": "MB",
      //               "successCount": 466,
      //               "failureCount": 420,
      //               "failureReasons": [
      //                 {"reason": "Message", "count": 420}
      //               ]
      //             },
      //             {
      //               "channelId": "IB",
      //               "successCount": 200,
      //               "failureCount": 420,
      //               "failureReasons": [
      //                 {"reason": "Message", "count": 420}
      //               ]
      //             }
      //           ],
      //           "successRate": "50.60",
      //           "failureRate": "47.40"
      //         }
      //       ]
      //     }
      //   }
      // };

      final apiRes = ApiResponse<TransactionAnalysisDto>.fromJson(
          res.data,
          (data) =>
              TransactionAnalysisDto.fromJson(data['transactionAnalysis']));

      if (apiRes.isSuccess) {
        return apiRes.data!;
      }
      throw ServiceException(apiRes.status?.description ?? "Error");
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future<PlatformTransactionAnalysisDto> getPlatformTransactionMetrixAnalysis(
      TransactionFilterReq req) async {
    try {
      final dio = networkClient.customDio(
          serviceId: "metricsByService",
          screenId: "ANALYTICS",
          authorizationRequired: true);

      final reqBody = {
        "startDate": req.startDate ?? "",
        "endDate": req.endDate ?? "",
        "type": req.type,
        "filter": {
          "channels":
              req.channels?.where((channel) => channel != "All").toList()
        }
      };

      final res = await dio.post("/common-service/common/txnMetricsByService",
          data: reqBody);

      final apiRes = ApiResponse<PlatformTransactionAnalysisDto>.fromJson(
          res.data,
          (data) => PlatformTransactionAnalysisDto.fromJson(
              data['transactionAnalysis']));

      if (apiRes.isSuccess) {
        return apiRes.data!;
      }
      throw ServiceException(apiRes.status?.description ?? "Error");
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future<TrasactionChannelDto> getTrsactionChannelsMetrix(
      TransactionFilterReq req) async {
    try {
      final dio = networkClient.customDio(
          serviceId: "metricsByService",
          screenId: "ANALYTICS",
          authorizationRequired: true);

      final reqBody = {
        "startDate": req.startDate ?? "",
        "endDate": req.endDate ?? "",
        "type": req.type,
        "filter": {
          "channels":
              req.channels?.where((channel) => channel != "All").toList()
        }
      };
      final res = await dio.post("/common-service/common/txnMetricsPieChart",
          data: reqBody);

      // final res = {
      //   "status": {"code": "000000", "description": "SUCCESS"},
      //   "data": {
      //     "trasactionChannels": [
      //       {"id": "RIB", "success": 15500, "failure": 2100},
      //       {"id": "RMB", "success": 15500, "failure": 2100},
      //       {"id": "IB", "success": 15500, "failure": 2100},
      //       {"id": "MB", "success": 15500, "failure": 2100}
      //     ]
      //   }
      // };

      final apiRes = ApiResponse<TrasactionChannelDto>.fromJson(
          res.data, (data) => TrasactionChannelDto.fromJson(data));

      if (apiRes.isSuccess) {
        return apiRes.data!;
      }
      throw ServiceException(apiRes.status?.description ?? "Error");
    } catch (e) {
      throw handleExceptions(e);
    }
  }

  @override
  Future<ActiveSessionDto> getActiveSession(ActiveSessionReq req) async {
    try {
      final dio = networkClient.customDio(
          serviceId: "metricsByService",
          screenId: "ANALYTICS",
          authorizationRequired: true);

      final reqBody = {
        // "startDate": req.startDate ?? "",
        // "endDate": req.endDate ?? "",
        // "type": req.type,
        // "filter": {"channels": req.channels}
      };
      final res =
          await dio.post("/common-service/common/active-sessions", data: {});

      // final res = {
      //   "status": {
      //     "code": "000000",
      //     "description": "SUCCESS"
      //   },
      //   "data": {
      //     "yAxis": {
      //       "title": "Session Count",
      //       "values": [
      //         "0",
      //         "200",
      //         "400",
      //         "600",
      //         "800",
      //         "1000"
      //       ]
      //     },
      //     "xAxis": {
      //       "title": "Time",
      //       "values": [
      //         "17:00",
      //         "15:00",
      //         "13:00",
      //         "11:00",
      //         "09:00",
      //         "07:00"
      //       ]
      //     },
      //     "series": [
      //       {
      //         "data": [
      //           {
      //             "x": "17:00",
      //             "y": "20"
      //           },
      //           {
      //             "x": "15:00",
      //             "y": "8"
      //           },
      //           {
      //             "x": "13:00",
      //             "y": "3"
      //           },
      //           {
      //             "x": "11:00",
      //             "y": "17"
      //           },
      //           {
      //             "x": "09:00",
      //             "y": "7"
      //           },
      //           {
      //             "x": "07:00",
      //             "y": "0"
      //           }
      //         ],
      //         "name": "Retail"
      //       },
      //       {
      //         "data": [
      //           {
      //             "x": "17:00",
      //             "y": "3"
      //           },
      //           {
      //             "x": "15:00",
      //             "y": "20"
      //           },
      //           {
      //             "x": "13:00",
      //             "y": "14"
      //           },
      //           {
      //             "x": "11:00",
      //             "y": "6"
      //           },
      //           {
      //             "x": "09:00",
      //             "y": "12"
      //           },
      //           {
      //             "x": "07:00",
      //             "y": "0"
      //           }
      //         ],
      //         "name": "Corporate"
      //       }
      //     ],
      //     "title": "Active Session Count"
      //   }
      // };

      final apiRes = ApiResponse<ActiveSessionDto>.fromJson(
          res.data, (data) => ActiveSessionDto.fromJson(data));

      if (apiRes.isSuccess) {
        return apiRes.data!;
      }
      throw ServiceException(apiRes.status?.description ?? "Error");
    } catch (e) {
      throw handleExceptions(e);
    }
  }
}
