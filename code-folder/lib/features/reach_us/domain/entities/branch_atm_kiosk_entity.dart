import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/branch_atm_kiosk_response.dart';

part 'branch_atm_kiosk_entity.freezed.dart';

@freezed
class LocateUsEntity with _$LocateUsEntity {
  const factory LocateUsEntity({
    required Status status,
    required List<BranchAtmKioskData> data,
  }) = _LocateUsEntity;
}
