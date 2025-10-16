import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network_client_provider.dart';
import '../data/datasource/product_offering_datasource.dart';
import '../data/repositories/impl/product_offering_repository_impl.dart';
import '../domain/repositories/product_offering_repository.dart';

final productOfferingDatasourceProvider = Provider<ProductOfferingDataSource>((
  ref,
) {
  final client = ref.watch(networkClientProvider);
  return ProductOfferingDatasourceImpl(networkClient: client);
});

final productOfferingRepoProvider = Provider<ProductOfferingRepository>((ref) {
  final ds = ref.watch(productOfferingDatasourceProvider);
  return ProductOfferingRepositoryImpl(ds);
});
