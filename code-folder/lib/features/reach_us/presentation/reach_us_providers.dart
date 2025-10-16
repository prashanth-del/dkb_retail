import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/network_client_provider.dart';
import '../data/datasource/reach_us_datasource.dart';
import '../data/repositories/impl/reach_us_repository_impl.dart';
import '../domain/repositories/reach_us_repository.dart';

final reachUsDatasourceProvider = Provider<ReachUsDatasource>((ref) {
  final client = ref.watch(networkClientProvider);
  return ReachUsDatasource(client);
});

final reachUsRepoProvider = Provider<ReachUsRepository>((ref) {
  final ds = ref.watch(reachUsDatasourceProvider);
  return ReachUsRepositoryImpl(ds);
});
//dart run db_codegen:featurecast --feature reach_us --api fetchFaq --root Faqs --input ../json/faq_model.json
