import 'package:dkb_retail/features/registration/data/datasource/card_validation_datasource.dart';
import 'package:dkb_retail/features/registration/data/repository/card_validation_repo_impl.dart';
import 'package:dkb_retail/features/registration/domain/repository/card_validation_repository.dart';
import 'package:dkb_retail/network/network_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardValidationDatasourceProvider = Provider<CardValidationDatasource>((
  ref,
) {
  final client = ref.watch(networkClientProvider);

  return CardValidationDatasourceImpl(networkClient: client);
});

final cardValidationsRepoProvider = Provider<CardValidationRepository>((ref) {
  final cardValidDatasource = ref.watch(cardValidationDatasourceProvider);

  return CardValidationRepoImpl(cardValidationDatasource: cardValidDatasource);
});
