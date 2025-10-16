// GENERATED Entity (Freezed): ValidateCardResponseData
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_card_response_data.freezed.dart';

@freezed
class ValidateCardResponseData with _$ValidateCardResponseData {
  const factory ValidateCardResponseData({
    required String rimNumber,
    String? userName,
    required bool otp,
  }) = _ValidateCardResponseData;
}
