import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import '../state/get_sub_products_imgs_state.dart';
import '../../domain/repositories/product_offering_repository.dart';
import '../product_offering_providers.dart';
import '../../data/models/get_sub_products_imgs_request.dart';

part 'get_sub_products_imgs_notifier.g.dart';

@riverpod
class GetSubProductsImgsNotifier extends _$GetSubProductsImgsNotifier {
  @override
  GetSubProductsImgsState build() => const GetSubProductsImgsState.initial();

  ProductOfferingRepository get _repo => ref.read(productOfferingRepoProvider);

    Future<void> getSubProductsImgs({ required GetSubProductsImgsRequest request, }) async {
    state = const GetSubProductsImgsState.loading();
    final result = await _repo.getSubProductsImgs(request: request);

    result.fold(
      (err) => state = GetSubProductsImgsState.failure(err.description ?? err.mwdesc ?? 'Server Error!'),
      (data) {
        state = GetSubProductsImgsState.success(data);
      },
    );
  }
}
