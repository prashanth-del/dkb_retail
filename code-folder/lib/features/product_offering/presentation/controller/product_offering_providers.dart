// Riverpod providers/controllers for product_offering.
// Define your Notifiers, Controllers, and Providers here.
// Example:
// final product_offeringControllerProvider = StateNotifierProvider<ProductOfferingController, ProductOfferingState>((ref) {
//   final repo = ref.watch(product_offeringRepositoryProvider);
//   return ProductOfferingController(repo);
// });
import 'package:dkb_retail/core/cache/global_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productIndex = StateProvider.autoDispose<int>((ref) => 0);
final productsloadingProvider = StateProvider.autoDispose<bool>((ref) => false);
final productsformisValidProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final isApplyProductsCachedProvider = StateProvider.autoDispose<bool>((ref) {
  final isSeen = GlobalCache.instance.hasProductsCache;
  return isSeen;
});
