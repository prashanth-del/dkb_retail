import 'package:dkb_retail/features/rates/data/datasource/rates_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../network/network_client_provider.dart';
import '../../data/repository/rates_repository_impl.dart';
import '../repository/rates_repository.dart';

final ratesDatasourceProvider = Provider<RatesDatasource>((ref) {
  final networkClient = ref.watch(networkClientProvider); // read
  return RatesDatasourceImpl(networkClient: networkClient);
});

final ratesRepositoryProvider = Provider<RatesRepository>((ref) {
  final ratesDatasource = ref.watch(ratesDatasourceProvider);

  return RatesRepositoryImpl(ratesDatasource);
});
