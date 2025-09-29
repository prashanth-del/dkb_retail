import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entity/card_summary_entity.dart';
import '../../domain/repository/cards_repository.dart';
import '../datasource/cards_datasource.dart';

class CardsRepoImpl implements CardsRepository {
  final CardsDatasource datasource;

  CardsRepoImpl({required this.datasource});

  @override
  ResultEither<CardSummaryEntity> getCardSummary(
      {required String field, required String type}) async {
    try {
      final response = await datasource.getCardSummary(field: field, type: type);
      final cardSummary = response;
      return Either.right(cardSummary.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }

}
