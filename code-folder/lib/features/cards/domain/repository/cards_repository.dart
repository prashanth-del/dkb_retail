
import '../../../../core/utils/typedefs.dart';
import '../entity/card_summary_entity.dart';

abstract class CardsRepository {
  ResultEither<CardSummaryEntity> getCardSummary(
      {required String field, required String type});

}
