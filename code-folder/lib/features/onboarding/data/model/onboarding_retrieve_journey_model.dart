import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/onboarding_retrieve_journey_entity.dart';



part 'onboarding_retrieve_journey_model.freezed.dart';
part 'onboarding_retrieve_journey_model.g.dart';

@freezed
class OnboardingRetrieveJourneyModel with _$OnboardingRetrieveJourneyModel {
  const factory OnboardingRetrieveJourneyModel({

    @JsonKey(name: 'data') required DataList data,


  }) = _OnboardingRetrieveJourneyModel;

  factory OnboardingRetrieveJourneyModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingRetrieveJourneyModelFromJson(json);

  const OnboardingRetrieveJourneyModel._();

  OnboardingRetrieveJourneyEntity toDomain() {
    return OnboardingRetrieveJourneyEntity(
      data: data,
    );
  }
}

@freezed
class DataList with _$DataList {
  const factory DataList({
    @JsonKey(name: 'summary') required Map<String,Map<String, dynamic>>? dataSummary,
  }) = _DataList;

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);
}

@freezed
class Summary with _$Summary {
  const factory Summary({
    @JsonKey(name: 'PRODUCTION_SELECTION') required ProductSelection productSelection,
    @JsonKey(name: 'IDENTIFICATION_DTL') required BasicDetails basicDetails,
    @JsonKey(name: 'IDENTIFICATION_INFO') required AdditionalInfoDetails additionalInfoDetails,
    @JsonKey(name: 'IDENTIFICATION_RESIDENT') required PersonalResidentMailingAddress personalResidentMailingAddress,
    @JsonKey(name: 'IDENTIFICATION_ADDRESS') required WorkHomeAddress workHomeAddress,
    @JsonKey(name: 'FINANTIAL_DTL') required FinancialInfo1 financialInfo1,
    @JsonKey(name: 'FINANTIAL_DTL2') required FinancialInfo2 financialInfo2,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
}


@freezed
class ProductSelection with _$ProductSelection {
  const factory ProductSelection({
    @JsonKey(name: 'Product_Type') required String? productType,
    @JsonKey(name: 'Branch_Selected') required String? branchSelected,
  }) = _ProductSelection;

  factory ProductSelection.fromJson(Map<String, dynamic> json) =>
      _$ProductSelectionFromJson(json);
}

@freezed
class BasicDetails with _$BasicDetails {
  const factory BasicDetails({
    @JsonKey(name: 'salutation') required String? salutation,
    @JsonKey(name: 'short_name') required String? shortName,
    @JsonKey(name: 'full_name') required String? fullName,
    @JsonKey(name: 'E_mail') required String? eMail,


  }) = _BasicDetails;

  factory BasicDetails.fromJson(Map<String, dynamic> json) =>
      _$BasicDetailsFromJson(json);
}

@freezed
class AdditionalInfoDetails with _$AdditionalInfoDetails {
  const factory AdditionalInfoDetails({
    @JsonKey(name: 'Country_of_birth') required String? countryOfBirth,
    @JsonKey(name: 'City_of_Birth') required String? cityOfBirth,
    @JsonKey(name: 'Marital_status') required String? maritalStatus,
    @JsonKey(name: 'EmploymentStatus') required String? employmentStatus,
    @JsonKey(name: 'Profession') required String? profession,
    @JsonKey(name: 'Other_employee_status') required String? otherEmployeeStatus,
    @JsonKey(name: 'Designation_Job') required String? designationJob,
    @JsonKey(name: 'Employee_name') required String? employeeName,

  }) = _AdditionalInfoDetails;

  factory AdditionalInfoDetails.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoDetailsFromJson(json);
}


@freezed
class PersonalResidentMailingAddress with _$PersonalResidentMailingAddress {
  const factory PersonalResidentMailingAddress({
    @JsonKey(name: 'Area_number') required String? areaNumber,
    @JsonKey(name: 'Street_name') required String? streetName,
    @JsonKey(name: 'Building_number') required String? buildingNumber,
    @JsonKey(name: 'Zone_number') required String? zoneNumber,
    @JsonKey(name: 'Proof_address_type') required String? proofAddressType,

  }) = _PersonalResidentMailingAddress;

  factory PersonalResidentMailingAddress.fromJson(Map<String, dynamic> json) =>
      _$PersonalResidentMailingAddressFromJson(json);
}

@freezed
class WorkHomeAddress with _$WorkHomeAddress {
  const factory WorkHomeAddress({
    @JsonKey(name: 'Area_number') required String? areaNumber,
    @JsonKey(name: 'Street_name') required String? streetName,
    @JsonKey(name: 'PO_Box') required String? poBox,
    @JsonKey(name: 'Country') required String? country,
    @JsonKey(name: 'Same_As_Personal_Address') required String? sameAsPersonalAddress,

  }) = _WorkHomeAddress;

  factory WorkHomeAddress.fromJson(Map<String, dynamic> json) =>
      _$WorkHomeAddressFromJson(json);
}

@freezed
class FinancialInfo1 with _$FinancialInfo1 {
  const factory FinancialInfo1({
    @JsonKey(name: 'Source_of_Income') required String? sourceOfIncome,
    @JsonKey(name: 'other_Source') required String? otherSource,
    @JsonKey(name: 'Country') required String? country,
    @JsonKey(name: 'uploaded') required String? uploaded,
    @JsonKey(name: 'Source_of_wealth') required String? sourceOfWealth,
    @JsonKey(name: 'TotalMonthlySalary') required String? totalMonthlySalary,
    @JsonKey(name: 'Estimated_net_worth_assets') required String? estimatedNetWorthAssets,
    @JsonKey(name: 'Additional_Income') required String? additionalIncome,
    @JsonKey(name: 'Total_Annual_Income') required String? totalAnnualIncome,
    @JsonKey(name: 'withdrawals') required String? withdrawals,
    @JsonKey(name: 'Deposits') required String? deposits,


  }) = _FinancialInfo1;

  factory FinancialInfo1.fromJson(Map<String, dynamic> json) =>
      _$FinancialInfo1FromJson(json);
}

@freezed
class FinancialInfo2 with _$FinancialInfo2 {
  const factory FinancialInfo2({
    @JsonKey(name: 'Financial_details') required String? financialDetails,


  }) = _FinancialInfo2;

  factory FinancialInfo2.fromJson(Map<String, dynamic> json) =>
      _$FinancialInfo2FromJson(json);
}

