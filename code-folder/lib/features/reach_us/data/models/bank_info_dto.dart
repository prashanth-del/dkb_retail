import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_info.dart';
import './bank_info_follow_u_dto.dart';

part 'bank_info_dto.freezed.dart';
part 'bank_info_dto.g.dart';

@freezed
class BankInfoDto with _$BankInfoDto {
  const factory BankInfoDto({
    String? mail,
    int? contact,
    String? internationalContact,
    List<BankInfoFollowUDto>? followUs,
  }) = _BankInfoDto;

  factory BankInfoDto.fromJson(Map<String, dynamic> json) => _$BankInfoDtoFromJson(json);
}

extension BankInfoDtoX on BankInfoDto {
  BankInfo toEntity() => BankInfo(
      mail: mail ?? "",
      contact: contact ?? 0,
      internationalContact: internationalContact ?? "",
      followUs: followUs?.map((e)=>e.toEntity()).toList() ?? const [],
  );
}
