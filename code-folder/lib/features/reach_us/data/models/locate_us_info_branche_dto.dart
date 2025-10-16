import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/locate_us_info_branche.dart';
import './locate_us_info_branche_coordinate_dto.dart';

part 'locate_us_info_branche_dto.freezed.dart';
part 'locate_us_info_branche_dto.g.dart';

@freezed
class LocateUsInfoBrancheDto with _$LocateUsInfoBrancheDto {
  const factory LocateUsInfoBrancheDto({
    String? locatorType,
    dynamic? searchString,
    LocateUsInfoBrancheCoordinateDto? coordinates,
    dynamic? facility,
    dynamic? address,
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
    dynamic? typeLocation,
    String? workingHours,
    String? workingHoursInArb,
    String? status,
    String? dateCreate,
    String? userCreate,
    dynamic? dateModif,
    dynamic? userModif,
    dynamic? maintenanceVendor,
    String? atmType,
    dynamic? currencySupported,
    dynamic? isActive,
    dynamic? installationDate,
  }) = _LocateUsInfoBrancheDto;

  factory LocateUsInfoBrancheDto.fromJson(Map<String, dynamic> json) => _$LocateUsInfoBrancheDtoFromJson(json);
}

extension LocateUsInfoBrancheDtoX on LocateUsInfoBrancheDto {
  LocateUsInfoBranche toEntity() => LocateUsInfoBranche(
      locatorType: locatorType ?? "",
      searchString: searchString,
      coordinates: coordinates?.toEntity(),
      facility: facility,
      address: address,
      arabicName: arabicName ?? "",
      cashDeposit: cashDeposit ?? 0,
      cashOut: cashOut ?? 0,
      chequeDeposit: chequeDeposit ?? 0,
      city: city ?? "",
      cityInArabic: cityInArabic ?? "",
      code: code ?? "",
      contactDetails: contactDetails ?? "",
      country: country ?? "",
      disablePeople: disablePeople ?? 0,
      fullAddress: fullAddress ?? "",
      fullAddressArb: fullAddressArb ?? "",
      onlineLocation: onlineLocation ?? 0,
      timing: timing ?? "",
      typeLocation: typeLocation,
      workingHours: workingHours ?? "",
      workingHoursInArb: workingHoursInArb ?? "",
      status: status ?? "",
      dateCreate: dateCreate ?? "",
      userCreate: userCreate ?? "",
      dateModif: dateModif,
      userModif: userModif,
      maintenanceVendor: maintenanceVendor,
      atmType: atmType ?? "",
      currencySupported: currencySupported,
      isActive: isActive,
      installationDate: installationDate,
  );
}
