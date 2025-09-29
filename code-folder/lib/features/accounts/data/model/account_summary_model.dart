import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/account_summary_entity.dart';

part 'account_summary_model.freezed.dart';
part 'account_summary_model.g.dart';

@freezed
class AccountSummaryModel with _$AccountSummaryModel {
  const factory AccountSummaryModel({
    required List<Map<String, String>> totalAvailBalance,
    required List<AccountDetailsA> accountDetails,
  }) = _AccountSummaryModel;

  factory AccountSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$AccountSummaryModelFromJson(json);

  const AccountSummaryModel._();

  AccountSummaryEntity toDomain() {
    return AccountSummaryEntity(
      totalAvailBalance: totalAvailBalance,
      accountDetails: accountDetails,
    );
  }
  static Map<String, dynamic> get dummyResponse => {
    "status": {
      "code": "000000",
      "description": "SUCCESS"
    },
    "data": {
      "totalAvailBalance": [
        {
          "currencyName": "QAR",
          "amt": "50,619,312.13"
        },
        {
          "currencyName": "USD",
          "amt": "177,244,063.28"
        },
        {
          "currencyName": "EUR",
          "amt": "100,057.99"
        },
        {
          "currencyName": "GBP",
          "amt": "87,156.18"
        }
      ],
      "accountDetails": [
        {
          "auId": "6b51f7c4-9d10-49b4-aa70-a30c47dc6026",
          "accountNum": "0222-1207026-001-0010-000",
          "availableBal": "50,619,312.13",
          "currencyName": "QAR",
          "accountType": "Current Account",
          "accountTypeFlag": "3",
          "acctFormat": "",
          "iban": "QA10 DOHB 0222 1207 0260 0100 1000 0",
          "currencyCode": "1",
          "availableBalRaw": "50619312.13",
          "currentBalance": "50,618,812.13",
          "currentBalanceRaw": "50618812.13",
          "ledgerCode": "10",
          "subAccountCode": "0",
          "clearBalance": "50,619,312.13",
          "clearBalanceRaw": "50619312.13"
        },
        {
          "auId": "42a52373-a4a6-43a2-a856-76e3d41ffa2e",
          "accountNum": "0222-1207026-002-0010-000",
          "availableBal": "177,244,063.28",
          "currencyName": "USD",
          "accountType": "Current Account",
          "accountTypeFlag": "3",
          "acctFormat": "",
          "iban": "QA92 DOHB 0222 1207 0260 0200 1000 0",
          "currencyCode": "2",
          "availableBalRaw": "177244063.28",
          "currentBalance": "177,244,063.28",
          "currentBalanceRaw": "177244063.28",
          "ledgerCode": "10",
          "subAccountCode": "0",
          "clearBalance": "177,244,063.28",
          "clearBalanceRaw": "177244063.28"
        },
        {
          "auId": "1ed4b3ae-0eb5-4d1c-8f5a-783da10af8ac",
          "accountNum": "0222-1207026-003-0010-000",
          "availableBal": "87,156.18",
          "currencyName": "GBP",
          "accountType": "Current Account",
          "accountTypeFlag": "3",
          "acctFormat": "",
          "iban": "QA77 DOHB 0222 1207 0260 0300 1000 0",
          "currencyCode": "3",
          "availableBalRaw": "87156.18",
          "currentBalance": "87,156.18",
          "currentBalanceRaw": "87156.18",
          "ledgerCode": "10",
          "subAccountCode": "0",
          "clearBalance": "87,156.18",
          "clearBalanceRaw": "87156.18"
        },
        {
          "auId": "a1648c93-9c78-450b-b75e-bfd19476ccd7",
          "accountNum": "0222-1207026-069-0010-000",
          "availableBal": "100,057.99",
          "currencyName": "EUR",
          "accountType": "Current Account",
          "accountTypeFlag": "3",
          "acctFormat": "",
          "iban": "QA57 DOHB 0222 1207 0260 6900 1000 0",
          "currencyCode": "69",
          "availableBalRaw": "100057.99",
          "currentBalance": "100,057.99",
          "currentBalanceRaw": "100057.99",
          "ledgerCode": "10",
          "subAccountCode": "0",
          "clearBalance": "100,057.99",
          "clearBalanceRaw": "100057.99"
        }
      ]
    }


  };


}

@freezed
class AccountDetailsA with _$AccountDetailsA {
  const factory AccountDetailsA({
    required String auId,
    required String accountNum,
    required String availableBal,
    required String currencyName,
    required String currentBalance,
    required String accountType,
    required String accountTypeFlag,
    required String acctFormat,
    required String iban,
    required String currencyCode,
    required String availableBalRaw,
    required String currentBalanceRaw,
    required String ledgerCode,
    required String subAccountCode,
    required String clearBalance,
    required String clearBalanceRaw
  }) = _AccountDetailsA;

  factory AccountDetailsA.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsAFromJson(json);
}
