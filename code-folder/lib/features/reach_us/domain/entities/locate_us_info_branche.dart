import 'package:freezed_annotation/freezed_annotation.dart';
import './locate_us_info_branche_coordinate.dart';

part 'locate_us_info_branche.freezed.dart';

@freezed
class LocateUsInfoBranche with _$LocateUsInfoBranche {
  const factory LocateUsInfoBranche({
    required String locatorType,
    required dynamic searchString,
    LocateUsInfoBrancheCoordinate? coordinates,
    required dynamic facility,
    required dynamic address,
    required String arabicName,
    required int cashDeposit,
    required int cashOut,
    required int chequeDeposit,
    required String city,
    required String cityInArabic,
    required String code,
    required String contactDetails,
    required String country,
    required int disablePeople,
    required String fullAddress,
    required String fullAddressArb,
    required int onlineLocation,
    required String timing,
    required dynamic typeLocation,
    required String workingHours,
    required String workingHoursInArb,
    required String status,
    required String dateCreate,
    required String userCreate,
    required dynamic dateModif,
    required dynamic userModif,
    required dynamic maintenanceVendor,
    required String atmType,
    required dynamic currencySupported,
    required dynamic isActive,
    required dynamic installationDate,
  }) = _LocateUsInfoBranche;
}
