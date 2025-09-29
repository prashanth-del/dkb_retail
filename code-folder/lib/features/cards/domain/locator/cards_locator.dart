import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/datasource/cards_datasource.dart';
import '../../data/repository/cards_repo_impl.dart';
import '../repository/cards_repository.dart';


part 'cards_locator.g.dart';

@riverpod
CardsDatasource cardsDatasourceLocator(CardsDatasourceLocatorRef ref) {
  return CardsDatasourceImpl(networkClient: ref.read(networkClientProvider));
}

@riverpod
CardsRepository cardsRepositoryLocator(CardsRepositoryLocatorRef ref) {
  return CardsRepoImpl(datasource: ref.watch(cardsDatasourceLocatorProvider));
}
