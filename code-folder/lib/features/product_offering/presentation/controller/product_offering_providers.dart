// Riverpod providers/controllers for product_offering.
// Define your Notifiers, Controllers, and Providers here.
// Example:
// final product_offeringControllerProvider = StateNotifierProvider<ProductOfferingController, ProductOfferingState>((ref) {
//   final repo = ref.watch(product_offeringRepositoryProvider);
//   return ProductOfferingController(repo);
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productIndex = StateProvider<int>((ref) => 0);
final productsloadingProvider = StateProvider<bool>((ref) => false);
