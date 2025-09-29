import 'package:dkb_retail/features/product_offering/domain/locator/product_offering_locator.dart';
import 'package:dkb_retail/features/product_offering/domain/repository/product_offering_repository.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_offering_notifier.g.dart';

@riverpod
class ProductOfferingNotifier extends _$ProductOfferingNotifier {
  @override
  FutureOr<dynamic> build() async {
    // fetch();
    //fetchloansSummary();
    return future;
  }

  ProductOfferingRepository get _repository =>
      ref.read(productOfferingRepoProvider);

  Future<void> getProductsOffering() async {
    ref.read(productsloadingProvider.notifier).state = true;
    state = const AsyncLoading();
    final failureOrSuccess = await _repository.getProductOffering();

    ref.read(productsloadingProvider.notifier).state = false;
    state = failureOrSuccess.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
