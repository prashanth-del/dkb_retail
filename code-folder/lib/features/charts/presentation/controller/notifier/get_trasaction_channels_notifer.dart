import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/request/transaction_filter_req.dart';
import '../../../domain/entity/transaction_channel_entity.dart';
import '../../../domain/locator/dashboard_locator.dart';

part 'get_trasaction_channels_notifer.g.dart';

@riverpod
class GetTrasactionChannelsNotifer extends _$GetTrasactionChannelsNotifer {
  @override
  FutureOr<TrasactionChannelEntity> build() {
    return future;
  }

  fetch(TransactionFilterReq req) async {
    state = const AsyncLoading();
    final failureOrSuccess =
        await ref.read(dashboardRepoProvider).getTrsactionChannelsMetrix(req);
    state = failureOrSuccess.fold(
        (error) => AsyncError(error, StackTrace.current),
        (data) => AsyncData(data));
  }
}
