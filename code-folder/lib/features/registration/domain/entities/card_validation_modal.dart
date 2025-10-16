// GENERATED Entity (Freezed): CardValidationModal
import 'package:freezed_annotation/freezed_annotation.dart';


part 'card_validation_modal.freezed.dart';

@freezed
class CardValidationModal with _$CardValidationModal {
  const factory CardValidationModal({
    required String code,
    required String bin,
    required String productType,
    required String cardType,
    required String status,
  }) = _CardValidationModal;
}
