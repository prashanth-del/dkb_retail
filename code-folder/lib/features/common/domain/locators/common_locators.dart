import 'package:dkb_retail/features/common/data/datasource/common_datasource.dart';
import 'package:dkb_retail/features/common/data/repository/common_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/network_client_provider.dart';
import '../repositories/common_repository.dart';

final commonDataSourceProvider = Provider<CommonDatasource>((ref) {
  final networkClient = ref.watch(networkClientProvider); // read
  return CommonDataSourceImpl(
    networkClient: networkClient,
  ); // return validationAccountModel
});

final commonRepositoryProvider = Provider<CommonRepository>((ref) {
  final datasource = ref.watch(commonDataSourceProvider);
  return CommonRepositoryImpl(datasource: datasource); //return Entity
});
