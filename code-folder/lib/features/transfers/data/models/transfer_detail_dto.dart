// GENERATED DTO (Freezed): TransferDetailDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transfer_detail.dart';


part 'transfer_detail_dto.freezed.dart';
part 'transfer_detail_dto.g.dart';

@freezed
class TransferDetailDto with _$TransferDetailDto {
  const factory TransferDetailDto({
    String? name,
    String? mail,
    int? contact,
    String? internationalContact,
    String? instaUrl,
    String? twitterUrl,
    String? fbUrl,
    String? dukhenBankUrl,
  }) = _TransferDetailDto;

  factory TransferDetailDto.fromJson(Map<String, dynamic> json) => _$TransferDetailDtoFromJson(json);
}

extension TransferDetailDtoX on TransferDetailDto {
  TransferDetail toEntity() => TransferDetail(
      name: name ?? "",
      mail: mail ?? "",
      contact: contact ?? 0,
      internationalContact: internationalContact ?? "",
      instaUrl: instaUrl ?? "",
      twitterUrl: twitterUrl ?? "",
      fbUrl: fbUrl ?? "",
      dukhenBankUrl: dukhenBankUrl ?? "",
  );
}
