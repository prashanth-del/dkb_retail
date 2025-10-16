import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/product_offering_repository.dart';
import '../product_offering_providers.dart';
import '../state/create_lead_apply_products_state.dart';

part 'create_lead_apply_products_notifier.g.dart';

@riverpod
class CreateLeadApplyProductsNotifier
    extends _$CreateLeadApplyProductsNotifier {
  @override
  CreateLeadApplyProductsState build() =>
      const CreateLeadApplyProductsState.initial();

  ProductOfferingRepository get _repo => ref.read(productOfferingRepoProvider);

  Future<void> createLeadApplyProducts({required dynamic request}) async {
    state = const CreateLeadApplyProductsState.loading();
    final result = await _repo.createLeadApplyProducts(request: request);

    result.fold(
      (err) => state = CreateLeadApplyProductsState.failure(
        err.description ?? err.mwdesc ?? 'Server Error!',
      ),
      (data) {
        state = CreateLeadApplyProductsState.success(data);
      },
    );
  }
}
