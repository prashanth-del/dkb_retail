import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/product_offering/domain/locator/product_offering_locator.dart';
import 'package:dkb_retail/features/product_offering/domain/repository/product_offering_repository.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_contact_us_notifier.g.dart';

@riverpod
class ProductContactUsNotifier extends _$ProductContactUsNotifier {
  @override
  FutureOr<dynamic> build() async {
    // fetch();
    //fetchloansSummary();
    return future;
    //getContatcUsFields();
  }

  ProductOfferingRepository get _repository =>
      ref.read(productOfferingRepoProvider);

  Future<void> getContatcUsFields() async {
    ref.read(productsloadingProvider.notifier).state = true;
    state = const AsyncLoading();
    final failureOrSuccess = await _repository.getContactUsFields();

    ref.read(productsloadingProvider.notifier).state = false;
    state = failureOrSuccess.fold(
      (l) {
        consoleLog(l.message);
        return AsyncError(l.message, StackTrace.current);
      },
      (r) {
        consoleLog('contactus : $r');
        return AsyncData(r);
      },
    );
  }
}
