
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/card_summary_entity.dart';

part 'card_summary_model.freezed.dart';
part 'card_summary_model.g.dart';

@freezed
class CardSummaryModel with _$CardSummaryModel {
  const factory CardSummaryModel({
    required List<CreditInfo> totalAvailableCreditLimit,
    required List<CreditInfo> totalOutstandingBalance,
    required int totalCard,
    required List<CardSummary> cardSummary,
  }) = _CardSummaryModel;

  factory CardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CardSummaryModelFromJson(json);

  const CardSummaryModel._();

  CardSummaryEntity toDomain() {
    return CardSummaryEntity(
        totalAvailableCreditLimit: totalAvailableCreditLimit,
        totalOutstandingBalance: totalOutstandingBalance,
        totalCard: totalCard,
        cardSummary: cardSummary);
  }

  static Map<String, dynamic> get dummyResponse => {
    "status": {
      "code": "000000",
      "description": " SUCCESS"
    },
    "data": {
      "totalAvailableCreditLimit": [
        {
          "currencyName": "QAR",
          "amt": "23,583,159.82"
        }
      ],
      "totalOutstandingBalance": [
        {
          "currencyName": "QAR",
          "amt": "11,245,983.38"
        }
      ],
      "totalCard": 456,
      "cardSummary": [
        {
          "encCardNumber": "b8x/tp7gQ6EVpH+yKemA/WzdtuTkx4cw1VfJW0sSo490YFJO3wGQAep2usGn5s+U/5yCVR/QdpOzEfUFq1ZbsYnWEOEj3PGiA3T2nWUO13NfK+DqbQJMYKQ51lU1my77fl0JXUL+KvYnq6+SXEdEa5jgdvMQHHHHvInP+Psw0mp/fRTxFO5oMZV3YkHf4VceopfUxeOKMKQIeFmNvoxh+K2ftsRQV6CPc/fYg0alv068kNYvRuoCl/u7cXM5GtfhZp5fb2lJHqPB0ImVgeTroqxnvNsXwJ61685cgH1ws3iR8L4rUYl4ndgF8tkHuwJRYOaRDePM2WDJiu/RDgnXvQ==",
          "cuid": "RMB86719502",
          "cardName": "- AMGAD AHMED  SAEED",
          "cardType": "VISA SIGNATURE CUSTOMER",
          "primaryCard": "1",
          "cardExpiry": "09/27",
          "maskedCardNo": "XXXX XXXX XXXX 4079",
          "accountNo": "10420593",
          "currency": "QAR",
          "availableCreditLimit": "13,145.34",
          "cardLimit": "16,000.00",
          "outstandingBalance": "-2,854.66",
          "status": "Active"
        },
        {
          "encCardNumber": "fBaC+jLvFJtHTDrzgSgDeTd7k/Me0aWf0GFpGt7ZgJVwI/YyWTcaEEfTAXmyFv27TbJEbfjjRigq9b2LygvwGrPV1KtLbkTymQ+3TaoPY4dX4I20XMTSDt2Cjf0jY/IF30/F1R3cTH7WuOxm0Zi49B3OaV6lYb8txhnRMQKk5D5p/ji68KesghznwXtvmRG3Fu0NtBpqnIjD/4UR+vdOYGym5n9cG7LZY60VwFXLwSzN7yKvpeYiZz2nrlOOKDRXNDXMQJ+ESsFb2XpYno4CWwLMKOyHtvaXY+cOmdP5SFUFfCvvAV42Qpt3xDuBLGLVEA6cvKmpIVGT1u3RFTwVtQ==",
          "cuid": "RMB72718222",
          "cardName": "- TESTING_01",
          "cardType": "VISA CORPORATE QATAR AIRWAYS",
          "primaryCard": "1",
          "cardExpiry": "12/24",
          "maskedCardNo": "XXXX XXXX XXXX 3420",
          "accountNo": "19002346",
          "currency": "QAR",
          "availableCreditLimit": "146,000.00",
          "cardLimit": "146,000.00",
          "outstandingBalance": "0.00",
          "status": "Active"
        }
      ]
    }
  };
}

@freezed
class CreditInfo with _$CreditInfo {
  const factory CreditInfo({
    required String amt,
    required String currencyName,
  }) = _CreditInfo;

  factory CreditInfo.fromJson(Map<String, dynamic> json) =>
      _$CreditInfoFromJson(json);
}

@freezed
class CardSummary with _$CardSummary {
  const factory CardSummary({
    required String encCardNumber,
    required String cuid,
    required String cardName,
    required String cardType,
    required String primaryCard,
    required String cardExpiry,
    required String maskedCardNo,
    required String accountNo,
    required String currency,
    required String availableCreditLimit,
    required String cardLimit,
    required String outstandingBalance,
    required String status,
  }) = _CardSummary;

  factory CardSummary.fromJson(Map<String, dynamic> json) =>
      _$CardSummaryFromJson(json);
}
