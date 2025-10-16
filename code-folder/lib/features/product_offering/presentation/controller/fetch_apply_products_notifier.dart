import 'package:dkb_retail/core/cache/global_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/fetch_apply_products_request.dart';
import '../../domain/repositories/product_offering_repository.dart';
import '../product_offering_providers.dart';
import '../state/fetch_apply_products_state.dart';

part 'fetch_apply_products_notifier.g.dart';

@riverpod
class FetchApplyProductsNotifier extends _$FetchApplyProductsNotifier {
  @override
  FetchApplyProductsState build() => const FetchApplyProductsState.initial();

  ProductOfferingRepository get _repo => ref.read(productOfferingRepoProvider);
  final globalCache = GlobalCache.instance;

  Future<void> fetchApplyProducts({
    required FetchApplyProductsRequest request,
  }) async {
    state = const FetchApplyProductsState.loading();
    final result = await _repo.fetchApplyProducts(request: request);

    result.fold(
      (err) => state = FetchApplyProductsState.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) async {
        // consoleLog('new method data $data');

        state = FetchApplyProductsState.success(data);
      },
    );
  }
}
