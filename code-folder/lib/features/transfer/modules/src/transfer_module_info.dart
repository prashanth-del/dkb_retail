import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/beneficiary_model.dart';

part 'transfer_module_info.freezed.dart';

@freezed
class TransferModuleInfo with _$TransferModuleInfo {
  const factory TransferModuleInfo({
    required String id,
    String? assetPath,
    required String title,
    required PageRouteInfo<void> route,
    @Default(_defaultOnSelected)
    Future<void> Function(
      BuildContext, {
      String? title,
      BeneficiaryModel? beneficiary,
      bool purpose,
      List<String> info,
      bool displayBank,
      bool displayIfsc,
      bool displayAccountNum,
      bool showFlag,
      bool showSendLater,
      bool showRemit,
      bool showSendAmount,
      bool showGetAmount,
      bool showBenRelation,
    })
    onSelected,
  }) = _TransferModuleInfo;

  const TransferModuleInfo._();

  String get assetPathOrDefault => assetPath ?? AssetPath.icon.home;
}

Future<void> _defaultOnSelected(
  BuildContext context, {
  String? title,
  BeneficiaryModel? beneficiary,
  bool purpose = false,
  List<String> info = const <String>[],
  bool displayBank = false,
  bool displayIfsc = false,
  bool displayAccountNum = true,
  bool showFlag = false,
  bool showSendLater = true,
  bool showRemit = false,
  bool showSendAmount = false,
  bool showGetAmount = false,
  bool showBenRelation = false,
}) async {
  debugPrint("Default onSelected called with title: $title");
}
