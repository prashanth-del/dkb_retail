// GENERATED DTO (Freezed): ValidateCardRequestDeviceInfoDto
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/validate_card_entites/validate_card_request_device_info.dart';

part 'validate_card_request_device_info_dto.freezed.dart';
part 'validate_card_request_device_info_dto.g.dart';

@freezed
class ValidateCardRequestDeviceInfoDto with _$ValidateCardRequestDeviceInfoDto {
  const factory ValidateCardRequestDeviceInfoDto({
    String? deviceId,
    String? ipAddress,
    String? vendorId,
    String? osVersion,
    String? osType,
    String? appVersion,
    String? endToEndId,
  }) = _ValidateCardRequestDeviceInfoDto;

  factory ValidateCardRequestDeviceInfoDto.fromJson(
    Map<String, dynamic> json,
  ) => _$ValidateCardRequestDeviceInfoDtoFromJson(json);
}

extension ValidateCardRequestDeviceInfoDtoX
    on ValidateCardRequestDeviceInfoDto {
  ValidateCardRequestDeviceInfo toEntity() => ValidateCardRequestDeviceInfo(
    deviceId: deviceId ?? "",
    ipAddress: ipAddress ?? "",
    vendorId: vendorId ?? "",
    osVersion: osVersion ?? "",
    osType: osType ?? "",
    appVersion: appVersion ?? "",
    endToEndId: endToEndId ?? "",
  );
}
