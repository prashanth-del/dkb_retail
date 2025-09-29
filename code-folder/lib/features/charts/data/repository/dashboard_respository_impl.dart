import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entity/active_session_entity.dart';
import '../../domain/entity/platform_transaction_entity.dart';
import '../../domain/entity/request/active_session_req.dart';
import '../../domain/entity/request/transaction_filter_req.dart';
import '../../domain/entity/transaction_analysis_entity.dart';
import '../../domain/entity/transaction_channel_entity.dart';
import '../../domain/entity/transaction_summary_entity.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasource/dashboard_datasource.dart';

class DashboardRespositoryImpl extends DashboardRepository {
  final DashboardDatasource datasource;

  DashboardRespositoryImpl(this.datasource);

  @override
  ResultEither<TransactionSummaryEntity> getTransactionSummary(
      TransactionFilterReq req) async {
    try {
      final res = await datasource.getTransactionSummary(req);
      return Right(res.toDomain());
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  ResultEither<TransactionAnalysisEntity> getTransactionMetrixAnalysis(
      TransactionFilterReq req) async {
    try {
      final res = await datasource.getTransactionMetrixAnalysis(req);
      return Right(res.toDomain());
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  ResultEither<PlatformTransactionAnalysisEntity>
      getPlatformTransactionMetrixAnalysis(TransactionFilterReq req) async {
    try {
      final res = await datasource.getPlatformTransactionMetrixAnalysis(req);
      return Right(res.toDomain());
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

  @override
  ResultEither<TrasactionChannelEntity> getTrsactionChannelsMetrix(
      TransactionFilterReq req) async {
    try {
      final res = await datasource.getTrsactionChannelsMetrix(req);
      return Right(res.toDomain());
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }
  @override
  ResultEither<ActiveSessionEntity> getActiveSession(
      ActiveSessionReq req) async {
    try {
      final res = await datasource.getActiveSession(req);
      return Right(res.toDomain());
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }

}
