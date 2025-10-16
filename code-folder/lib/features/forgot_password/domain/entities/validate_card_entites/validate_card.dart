// GENERATED Entity (Freezed): ValidateCard
import 'package:freezed_annotation/freezed_annotation.dart';
import 'validate_card_header.dart';
import 'validate_card_request.dart';
import 'validate_card_response.dart';

part 'validate_card.freezed.dart';

@freezed
class ValidateCard with _$ValidateCard {
  const factory ValidateCard({
    required String url,
    ValidateCardHeader? headers,
    ValidateCardRequest? request,
    ValidateCardResponse? response,
  }) = _ValidateCard;
}
