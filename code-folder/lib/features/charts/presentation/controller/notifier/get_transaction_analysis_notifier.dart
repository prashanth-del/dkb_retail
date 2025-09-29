import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/request/transaction_filter_req.dart';
import '../../../domain/entity/transaction_analysis_entity.dart';
import '../../../domain/locator/dashboard_locator.dart';

part 'get_transaction_analysis_notifier.g.dart';

@riverpod
class GetTransactionAnalysisNotifier extends _$GetTransactionAnalysisNotifier {
  @override
  FutureOr<TransactionAnalysisEntity> build() {
    return future;
  }

  fetch(TransactionFilterReq req) async {
    state = const AsyncLoading();
    final failureOrSuccess =
        await ref.read(dashboardRepoProvider).getTransactionMetrixAnalysis(req);
    state = failureOrSuccess.fold(
        (error) => AsyncError(error, StackTrace.current),
        (data) => AsyncData(data));
  }
}

@riverpod
class TransactionTableAnalysisNotifier
    extends _$TransactionTableAnalysisNotifier {
  @override
  FutureOr<TransactionAnalysisEntity> build() {
    return future;
  }

  fetch(TransactionFilterReq req) async {
    state = const AsyncLoading();
    final failureOrSuccess =
        await ref.read(dashboardRepoProvider).getTransactionMetrixAnalysis(req);
    state = failureOrSuccess.fold(
        (error) => AsyncError(error, StackTrace.current),
        (data) => AsyncData(data));
  }
}
