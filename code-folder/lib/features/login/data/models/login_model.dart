import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/login_entity.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'data') required LoginData data,
  }) = _LoginResponseModel;

  const LoginResponseModel._();

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  static Map<String, dynamic> get dummyResponse => {
        "status": {"code": "000000", "description": "SUCCESS"},
        "data": {
          "atkn":
              "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcHIxMjA3MDI2IiwiaWF0IjoxNzMzNjQ0NDIyLCJleHAiOjE3MzM2NDYyMjIsImlzcyI6IkRCIiwianRpIjoiMDdiZTNmZjMtNDFkZS00OTZhLTkyYjgtNTFmYWU1OGUwNjE0In0.Zw2nxRDA3gg-CRvxlQTEZsrAlCewf9GDrLX_BhXwbzguJHOfSY2T40sF_9cKLl-k4-phtdAWetijkoAWitNKJoCjtXkNJ4bBnNHcHK7Rr1JJ6NZSdCwVmrBhxsF3HKkxLW1PByf8t65c1CYoiqKS6s_KYiloN1r4_5WjwQx4DcnpYRoqt3oItt2ExIXWX041LwNDyBcyEbSGjTIZT6ZOrtlQXh8drEoiZ_9UIFcqBB6-mIblce_vkrMTjcLrM3uvvADkOIZqq27r2gRIyxDnMjXLSx1sYq_KShEflxyZTSOlvb3p6yVdvanx29pZk2UQIctSiSDaTKmshiRMyUsAg",
          "reftkn":
              "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcHIxMjA3MDI2IiwiaWF0IjoxNzMzNjQ0NDIyLCJleHAiOjE3MzM2NDYyMjIsImlzcyI6IkRCIiwianRpIjoiMDdiZTNmZjMtNDFkZS00OTZhLTkyYjgtNTFmYWU1OGUwNjE0In0.Zw2nxRDA3gg-CRvxlQTEZsrAlCewf9GDrLX_BhXwbzguJHOfSY2T40sF_9cKLl-k4-phtdAWetijkoAWitNKJoCjtXkNJ4bBnNHcHK7Rr1JJ6NZSdCwVmrBhxsF3HKkxLW1PByf8t65c1CYoiqKS6s_KYiloN1r4_5WjwQx4DcnpYRoqt3oItt2ExIXWX041LwNDyBcyEbSGjTIZT6ZOrtlQXh8drEoiZ_9UIFcqBB6-mIblce_vkrMTjcLrM3uvvADkOIZqq27r2gRIyxDnMjXLSx1sYq_KShEflxyZTSOlvb3p6yVdvanx29pZk2UQIctSiSDaTKmshiRMyUsAg",
          "customerNumber": "1207026",
          "branchCode": "222",
          "firstLogin": "1",
          "accessDate": "08/12/2024 10:52:13 AM",
          "custinfoFlag": "N",
          "preferredLang": "EN",
          "preferredUnits": "[]",
          "registeredUnit": "PRD",
          "isOtpRequired": "Y",
          "userName": "apr1207026",
          "customerSegment": "N",
          "customerType": "null",
          "far": "59",
          "userNo": "09",
          "userId": "apr1207026",
          "customerId": "4545",
          "emailId": "sdileep@dohabank.com.qa",
          "otpRefNo": "",
          "maskedMobileNo": "+974***2529",
          "dcUserName": "Corp Cust TestX",
          "registrationDate": "2023-11-06T12:12:49+03:00",
          "address1": ", 112A,Test Street, Doha, Qatar",
          "authorityAmount": "50000000",
          "userRole": "Approver",
          "userRoleCode": "A",
          "companyNameRole": "apr1207026-Approver",
          "dccustomerTypeID": "7"
        }
      };
}

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone') required int phone,
    @JsonKey(name: 'is_email_verified') required bool isEmailVerified,
    @JsonKey(name: 'is_authenticated') required bool isAuthenticated,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}

// Extension to map LoginResponseModel to LoginEntity
extension LoginResponseModelToDomain on LoginResponseModel {
  LoginEntity toDomain() {
    return LoginEntity(status: status, message: message, data: data);
  }

// LoginEntity toDomain() {
//   return LoginEntity(
//     userId: data.userId,
//     firstName: data.firstName,
//     email: data.email,
//     phone: data.phone,
//     isEmailVerified: data.isEmailVerified,
//     isAuthenticated: data.isAuthenticated,
//   );
// }
}
