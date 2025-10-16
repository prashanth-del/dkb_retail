// GENERATED DTO (Freezed): ContactUsModalStatuDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contact_us_modal_statu.dart';


part 'contact_us_modal_statu_dto.freezed.dart';
part 'contact_us_modal_statu_dto.g.dart';

@freezed
class ContactUsModalStatuDto with _$ContactUsModalStatuDto {
  const factory ContactUsModalStatuDto({
    String? code,
    String? message,
  }) = _ContactUsModalStatuDto;

  factory ContactUsModalStatuDto.fromJson(Map<String, dynamic> json) => _$ContactUsModalStatuDtoFromJson(json);
}

extension ContactUsModalStatuDtoX on ContactUsModalStatuDto {
  ContactUsModalStatu toEntity() => ContactUsModalStatu(
      code: code ?? "",
      message: message ?? "",
  );
}
