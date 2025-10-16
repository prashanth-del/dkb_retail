import 'package:freezed_annotation/freezed_annotation.dart';


part 'bank_info_follow_u.freezed.dart';

@freezed
class BankInfoFollowU with _$BankInfoFollowU {
  const factory BankInfoFollowU({
    required String name,
    required String url,
    required String displayImage,
    required int displayOrder,
  }) = _BankInfoFollowU;
}
