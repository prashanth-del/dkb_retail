import 'package:freezed_annotation/freezed_annotation.dart';
import './bank_info_follow_u.dart';

part 'bank_info.freezed.dart';

@freezed
class BankInfo with _$BankInfo {
  const factory BankInfo({
    required String mail,
    required int contact,
    required String internationalContact,
    required List<BankInfoFollowU> followUs,
  }) = _BankInfo;
}
