import 'package:dkb_retail/features/product_offering/data/datasource/product_offering_datasource.dart';
import 'package:dkb_retail/features/product_offering/data/repository/product_offering_repository_impl.dart';
import 'package:dkb_retail/features/product_offering/domain/repository/product_offering_repository.dart';
import 'package:dkb_retail/network/network_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productOfferingDatasourceProvider = Provider<ProductOfferingDataSource>((
  ref,
) {
  final client = ref.watch(networkClientProvider);

  return ProductOfferingDatasourceImpl(networkClient: client);
});

final productOfferingRepoProvider = Provider<ProductOfferingRepository>((ref) {
  final productOfferingDatasource = ref.watch(
    productOfferingDatasourceProvider,
  );

  return ProductOfferingRepositoryImpl(
    productOfferingDataSource: productOfferingDatasource,
  );
});
