

import '../../../../core/utils/typedefs.dart';
import '../entity/active_session_entity.dart';
import '../entity/platform_transaction_entity.dart';
import '../entity/request/active_session_req.dart';
import '../entity/request/transaction_filter_req.dart';
import '../entity/transaction_analysis_entity.dart';
import '../entity/transaction_channel_entity.dart';
import '../entity/transaction_summary_entity.dart';

abstract class DashboardRepository {
  ResultEither<TransactionSummaryEntity> getTransactionSummary(
      TransactionFilterReq req);
  ResultEither<TransactionAnalysisEntity> getTransactionMetrixAnalysis(
      TransactionFilterReq req);
  ResultEither<PlatformTransactionAnalysisEntity>
      getPlatformTransactionMetrixAnalysis(TransactionFilterReq req);
  ResultEither<TrasactionChannelEntity> getTrsactionChannelsMetrix(
      TransactionFilterReq req);

  ResultEither<ActiveSessionEntity> getActiveSession(
      ActiveSessionReq req);
}
