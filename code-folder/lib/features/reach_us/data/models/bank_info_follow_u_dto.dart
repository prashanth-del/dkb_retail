import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_info_follow_u.dart';


part 'bank_info_follow_u_dto.freezed.dart';
part 'bank_info_follow_u_dto.g.dart';

@freezed
class BankInfoFollowUDto with _$BankInfoFollowUDto {
  const factory BankInfoFollowUDto({
    String? name,
    String? url,
    String? displayImage,
    int? displayOrder,
  }) = _BankInfoFollowUDto;

  factory BankInfoFollowUDto.fromJson(Map<String, dynamic> json) => _$BankInfoFollowUDtoFromJson(json);
}

extension BankInfoFollowUDtoX on BankInfoFollowUDto {
  BankInfoFollowU toEntity() => BankInfoFollowU(
      name: name ?? "",
      url: url ?? "",
      displayImage: displayImage ?? "",
      displayOrder: displayOrder ?? 0,
  );
}
