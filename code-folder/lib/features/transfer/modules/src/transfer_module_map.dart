import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/transfer/modules/src/transfer_module_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import 'default_features.dart';

final domesticMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    DomesticModules.toMyOwnDB: TransferModuleInfo(
      id: DomesticModules.toMyOwnDB,
      assetPath: AssetPath.icon.selfTransfer,
      title: DomesticModules.toMyOwnDB,
      route: TransferAmountRoute(title: DomesticModules.toMyOwnDB),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const <String>[],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
          showSendLater = true,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          }) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? DomesticModules.toMyOwnDB,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    DomesticModules.toAnotherDB: TransferModuleInfo(
      id: DomesticModules.toAnotherDB,
      title: DomesticModules.toAnotherDB,
      route: TransferAmountRoute(title: DomesticModules.toAnotherDB),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? DomesticModules.toAnotherDB,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    DomesticModules.toAnotherLocal: TransferModuleInfo(
      id: DomesticModules.toAnotherLocal,
      assetPath: AssetPath.icon.toBank,
      title: DomesticModules.toAnotherLocal,
      route: TransferAmountRoute(title: DomesticModules.toAnotherLocal),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? DomesticModules.toAnotherLocal,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    DomesticModules.dCardLess: TransferModuleInfo(
      id: DomesticModules.dCardLess,
      title: DomesticModules.dCardLess,
      assetPath: AssetPath.icon.cashless,
      route: TransferAmountRoute(title: DomesticModules.dCardLess),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? DomesticModules.dCardLess,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
  };
});

final iftMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    IFTModules.internationalTransfer: TransferModuleInfo(
      id: IFTModules.internationalTransfer,
      assetPath: AssetPath.icon.earthPrimary,
      title: IFTModules.internationalTransfer,
      route: TransferAmountRoute(title: IFTModules.internationalTransfer),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? IFTModules.internationalTransfer,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    IFTModules.cashPayout: TransferModuleInfo(
      id: IFTModules.cashPayout,
      assetPath: AssetPath.icon.money,
      title: IFTModules.cashPayout,
      route: TransferAmountRoute(title: IFTModules.cashPayout),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? IFTModules.cashPayout,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    IFTModules.westUnion: TransferModuleInfo(
      id: IFTModules.westUnion,
      assetPath: AssetPath.icon.westUnion,
      title: IFTModules.westUnion,
      route: TransferAmountRoute(title: IFTModules.westUnion),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? IFTModules.westUnion,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
    IFTModules.masterCard: TransferModuleInfo(
      id: IFTModules.masterCard,
      assetPath: AssetPath.icon.masterCard,
      title: IFTModules.masterCard,
      route: TransferAmountRoute(title: IFTModules.masterCard),
      onSelected: (context,
          {title,
          beneficiary,
          purpose = false,
          info = const [],
          displayBank = false,
          displayIfsc = false,
          displayAccountNum = true,
          showFlag = false,
            showRemit = false,
            showSendAmount = false,
            showGetAmount = false,
            showBenRelation = false,
          showSendLater = true}) async {
        await context.router.push(TransferAmountRoute(
            title: title ?? IFTModules.masterCard,
            beneficiary: beneficiary,
            purpose: purpose,
            info: info,
            displayBank: displayBank,
            displayIfsc: displayIfsc,
            displayAccountNum: displayAccountNum,
            showFlag: showFlag,
            showSendLater: showSendLater,
            showRemit: showRemit,
            showSendAmount: showSendAmount,
            showGetAmount: showGetAmount,
            showBenRelation: showBenRelation));
      },
    ),
  };
});

// fawran
final fawranMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    FawranModules.transfer: TransferModuleInfo(
      id: FawranModules.transfer,
      assetPath: AssetPath.icon.fTransfer,
      title: FawranModules.transfer,
      route: TransferAmountRoute(title: FawranModules.transfer),
    ),
    FawranModules.profile: TransferModuleInfo(
      id: FawranModules.profile,
      assetPath: AssetPath.icon.fProfile,
      title: FawranModules.profile,
      route: TransferAmountRoute(title: FawranModules.profile),
    ),
    FawranModules.history: TransferModuleInfo(
      id: FawranModules.history,
      assetPath: AssetPath.icon.fHistory,
      title: FawranModules.history,
      route: TransferAmountRoute(title: FawranModules.history),
    ),
  };
});

// transaction
final transactionMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    // TransactionModules.schTransfer: TransferModuleInfo(
    //   id: TransactionModules.schTransfer,
    //   assetPath: AssetPath.icon.fTransfer,
    //   title: TransactionModules.schTransfer,
    //   route: TransferAmountRoute(title: TransactionModules.schTransfer),
    // ),
    TransactionModules.tranStatus: TransferModuleInfo(
      id: TransactionModules.tranStatus,
      assetPath: AssetPath.icon.transStatus,
      title: TransactionModules.tranStatus,
      route: TransferAmountRoute(title: TransactionModules.tranStatus),
    ),
    TransactionModules.donation: TransferModuleInfo(
      id: TransactionModules.donation,
      assetPath: AssetPath.icon.donation,
      title: TransactionModules.donation,
      route: DonationTransferRoute(title: TransactionModules.donation),
    ),
  };
});

final transactionMapIFTProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    TransactionModulesIFT.schTransfer: TransferModuleInfo(
      id: TransactionModulesIFT.schTransfer,
      assetPath: AssetPath.icon.schtransfer,
      title: TransactionModulesIFT.schTransfer,
      route: TransferAmountRoute(title: TransactionModulesIFT.schTransfer),
    ),
    TransactionModulesIFT.tranStatus: TransferModuleInfo(
      id: TransactionModulesIFT.tranStatus,
      assetPath: AssetPath.icon.transStatus,
      title: TransactionModulesIFT.tranStatus,
      route: TransferAmountRoute(title: TransactionModulesIFT.tranStatus),
    ),
    TransactionModulesIFT.donation: TransferModuleInfo(
      id: TransactionModulesIFT.donation,
      assetPath: AssetPath.icon.donation,
      title: TransactionModulesIFT.donation,
      route: TransferAmountRoute(title: TransactionModulesIFT.donation),
    ),
  };
});

// fav
final favMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    FavModules.name1: TransferModuleInfo(
      id: FavModules.name1,
      title: FavModules.name1,
      route: TransferAmountRoute(title: FavModules.name1),
    ),
    FavModules.name2: TransferModuleInfo(
      id: FavModules.name2,
      title: FavModules.name2,
      route: TransferAmountRoute(title: FavModules.name2),
    ),
    FavModules.name3: TransferModuleInfo(
      id: FavModules.name3,
      title: FavModules.name3,
      route: TransferAmountRoute(title: FavModules.name3),
    ),
  };
});

// beneficiary
final benMapProvider = Provider<Map<String, TransferModuleInfo>>((ref) {
  return {
    BenModules.addBen: TransferModuleInfo(
      id: BenModules.addBen,
      assetPath: AssetPath.icon.addBen,
      title: BenModules.addBen,
      route: const AddBeneficiaryTransferRoute(),
    ),
    BenModules.viewBen: TransferModuleInfo(
      id: BenModules.viewBen,
      assetPath: AssetPath.icon.viewBen,
      title: BenModules.viewBen,
      route: const ViewBeneficiaryTransferRoute(),
    ),
  };
});
