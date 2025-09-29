// GENERATED DTO (Freezed): TransferDetailDto
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transfer_detail.dart';

part 'transfer_detail_dto.freezed.dart';
part 'transfer_detail_dto.g.dart';

@freezed
class TransferDetailDto with _$TransferDetailDto {
  const factory TransferDetailDto({
    String? atkn,
    String? reftkn,
    String? customerNumber,
    String? branchCode,
    String? firstLogin,
    String? accessDate,
    String? custinfoFlag,
    String? preferredLang,
    String? preferredUnits,
    String? registeredUnit,
    String? isOtpRequired,
    String? userName,
    String? customerSegment,
    String? customerType,
    String? far,
    String? userNo,
    String? userId,
    String? customerId,
    String? emailId,
    String? otpRefNo,
    String? maskedMobileNo,
    String? dcUserName,
    String? registrationDate,
    String? address1,
    String? authorityAmount,
    String? userRole,
    String? userRoleCode,
    String? companyNameRole,
    String? dccustomerTypeID,
  }) = _TransferDetailDto;

  factory TransferDetailDto.fromJson(
    Map<String, dynamic> json,
  ) => // data + success
      _$TransferDetailDtoFromJson(json);
  const TransferDetailDto._();
  TransferDetail toDomain() {
    return TransferDetail(
      accessDate: accessDate!,
      address1: address1!,
      atkn: atkn!,
      authorityAmount: authorityAmount!,
      branchCode: branchCode!,
      companyNameRole: companyNameRole!,
      custinfoFlag: custinfoFlag!,
      customerId: customerId!,
      customerNumber: customerNumber!,
      customerSegment: customerSegment!,
      customerType: customerType!,
      dccustomerTypeID: dccustomerTypeID!,
      dcUserName: dcUserName!,
      emailId: emailId!,
      far: far!,
      firstLogin: firstLogin!,
      isOtpRequired: isOtpRequired!,
      maskedMobileNo: maskedMobileNo!,
      otpRefNo: otpRefNo!,
      preferredLang: preferredLang!,
      preferredUnits: preferredUnits!,
      reftkn: reftkn!,
      registeredUnit: registeredUnit!,
      registrationDate: registrationDate!,
      userId: userId!,
      userName: userName!,
      userNo: userNo!,
      userRole: userRole!,
      userRoleCode: userRoleCode!,
      //  otpLength: int.parse(otpLength?.isEmpty ?? true ? '6' : otpLength!),
    );
  }
}

extension TransferDetailDtoX on TransferDetailDto {
  TransferDetail toEntity() => TransferDetail(
    atkn: atkn ?? "",
    reftkn: reftkn ?? "",
    customerNumber: customerNumber ?? "",
    branchCode: branchCode ?? "",
    firstLogin: firstLogin ?? "",
    accessDate: accessDate ?? "",
    custinfoFlag: custinfoFlag ?? "",
    preferredLang: preferredLang ?? "",
    preferredUnits: preferredUnits ?? "",
    registeredUnit: registeredUnit ?? "",
    isOtpRequired: isOtpRequired ?? "",
    userName: userName ?? "",
    customerSegment: customerSegment ?? "",
    customerType: customerType ?? "",
    far: far ?? "",
    userNo: userNo ?? "",
    userId: userId ?? "",
    customerId: customerId ?? "",
    emailId: emailId ?? "",
    otpRefNo: otpRefNo ?? "",
    maskedMobileNo: maskedMobileNo ?? "",
    dcUserName: dcUserName ?? "",
    registrationDate: registrationDate ?? "",
    address1: address1 ?? "",
    authorityAmount: authorityAmount ?? "",
    userRole: userRole ?? "",
    userRoleCode: userRoleCode ?? "",
    companyNameRole: companyNameRole ?? "",
    dccustomerTypeID: dccustomerTypeID ?? "",
  );
}

//dart run db_codegen:schemacast --feature transfers --root TransferDetail --input ../json/TransferDetails
//
