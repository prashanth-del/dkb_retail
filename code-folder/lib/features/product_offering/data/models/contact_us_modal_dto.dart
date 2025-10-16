// GENERATED DTO (Freezed): ContactUsModalDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contact_us_modal.dart';
import './contact_us_modal_statu_dto.dart';
import './contact_us_modal_payload_item_dto.dart';

part 'contact_us_modal_dto.freezed.dart';
part 'contact_us_modal_dto.g.dart';

@freezed
class ContactUsModalDto with _$ContactUsModalDto {
  const factory ContactUsModalDto({
    ContactUsModalStatuDto? status,
    List<ContactUsModalPayloadItemDto>? payload,
  }) = _ContactUsModalDto;

  factory ContactUsModalDto.fromJson(Map<String, dynamic> json) => _$ContactUsModalDtoFromJson(json);
}

extension ContactUsModalDtoX on ContactUsModalDto {
  ContactUsModal toEntity() => ContactUsModal(
      status: status?.toEntity(),
      payload: payload?.map((e)=>e.toEntity()).toList() ?? const [],
  );
}
