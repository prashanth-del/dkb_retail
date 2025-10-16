import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/branch_atm_kiosk_entity.dart';

part 'branch_atm_kiosk_response.freezed.dart';
part 'branch_atm_kiosk_response.g.dart';

@freezed
class BranchAtmKioskResponse with _$BranchAtmKioskResponse {
  const factory BranchAtmKioskResponse({
    Status? status,
    List<BranchAtmKioskData>? data,
  }) = _BranchAtmKioskResponse;

  factory BranchAtmKioskResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchAtmKioskResponseFromJson(json);
  const BranchAtmKioskResponse._();

  LocateUsEntity toDomain() {
    return LocateUsEntity(status: status!, data: data!);
  }
}

@freezed
class Status with _$Status {
  const factory Status({String? code, String? description}) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

@freezed
class BranchAtmKioskData with _$BranchAtmKioskData {
  const factory BranchAtmKioskData({
    List<LocationItem>? branches,
    List<LocationItem>? atms,
    List<LocationItem>? kiosks,
  }) = _BranchAtmKioskData;

  factory BranchAtmKioskData.fromJson(Map<String, dynamic> json) =>
      _$BranchAtmKioskDataFromJson(json);
}

@freezed
class LocationItem with _$LocationItem {
  const factory LocationItem({
    String? locatorType,
    String? searchString,
    Coordinates? coordinates,
    String? facility,
    String? address,
    String? arabicName,
    int? cashDeposit,
    int? cashOut,
    int? chequeDeposit,
    String? city,
    String? cityInArabic,
    String? code,
    String? contactDetails,
    String? country,
    int? disablePeople,
    String? fullAddress,
    String? fullAddressArb,
    int? onlineLocation,
    String? timing,
    String? typeLocation,
    String? workingHours,
    String? workingHoursInArb,
    String? status,
    String? dateCreate,
    String? userCreate,
    String? dateModif,
    String? userModif,
    String? maintenanceVendor,
    String? atmType,
    String? currencySupported,
    String? isActive,
    String? installationDate,
  }) = _LocationItem;

  factory LocationItem.fromJson(Map<String, dynamic> json) =>
      _$LocationItemFromJson(json);
}

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({double? latitude, double? longitude}) =
      _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}
