import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/common/components/auto_leading_widget.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/beneficiary_model.dart';
import '../../modules/src/transfer_module_info.dart';
import '../provider/transfer_provider.dart';
import '../widgets/ben_pciker_sheet.dart';
import '../widgets/bottom_sheet/transaction_status_bottom_sheet.dart';

@RoutePage()
class TransferPage extends ConsumerStatefulWidget {
  const TransferPage({super.key});

  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initialIndex = 0;
  int selectedIndex = 0;
  List<String> tabPages = [
    DefaultString.instance.domesticTransfer,
    DefaultString.instance.internationalTransfer,
  ];
  late List<TransferModuleInfo> domestic;
  late List<TransferModuleInfo> ift;
  late List<TransferModuleInfo> fawran;
  late List<TransferModuleInfo> transaction;
  late List<TransferModuleInfo> transactionIFT;
  late List<TransferModuleInfo> fav;
  late List<TransferModuleInfo> bene;
  late List<BeneficiaryModel> beneficiaries;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabPages.length,
      vsync: this,
      initialIndex: initialIndex,
    );
    domestic = ref.read(domesticListProvider.notifier).state;
    ift = ref.read(iftListProvider.notifier).state;
    fawran = ref.read(fawranListProvider.notifier).state;
    transaction = ref.read(transactionListProvider.notifier).state;
    transactionIFT = ref.read(transactionIFTListProvider.notifier).state;
    fav = ref.read(favListProvider.notifier).state;
    bene = ref.read(benListProvider.notifier).state;
    _loadBen();
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadBen() async {
    beneficiaries = await BeneficiaryModel.loadDummyBeneficiaries();
  }

  _buildBenPicker({
    required TransferModuleInfo transModule,
    bool showFlag = false,
    bool showBankName = false,
    bool showAccount = true,
    bool showIfsc = false,
    bool sendBeneficiary = false,
    bool showPurpose = false,
    bool sendLater = true,
    bool showRemit = false,
    bool showSendAmount = false,
    bool showGetAmount = false,
    bool showBenRelation = false,
    List<String> info = const [],
  }) async {
    BeneficiaryModel? beneficiary = await UIPopupDialog<BeneficiaryModel>()
        .showBottomSheet(
          context: context,
          child: BeneficiaryPickerSheet(
            beneficiaryList: beneficiaries,
            hintText: DefaultString.instance.searchBen,
            title: DefaultString.instance.selectBen,
            isFlag: showFlag,
            displayBank: showBankName,
            displayAccountNum: showAccount,
            displayIfsc: showIfsc,
          ),
        );

    if (beneficiary != null && mounted) {
      transModule.onSelected.call(
        context,
        beneficiary: sendBeneficiary ? beneficiary : null,
        purpose: showPurpose,
        displayBank: showBankName,
        displayAccountNum: showAccount,
        displayIfsc: showIfsc,
        info: info,
        showFlag: showFlag,
        showSendLater: sendLater,
        showRemit: showRemit,
        showSendAmount: showSendAmount,
        showGetAmount: showGetAmount,
        showBenRelation: showBenRelation,
      );
    }
  }

  _buildRow({
    required String title,
    String? trailText,
    required List<TransferModuleInfo> elements,
    bool isColumn = true,
    bool subtitle = false,
  }) {
    return UiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiTextNew.h4Medium(title),
                if (trailText != null)
                  UiTextNew.h4Medium(trailText, color: DefaultColors.blue88),
              ],
            ),
          ),
          if (isColumn) const UiSpace.vertical(20),
          SizedBox(
            height: isColumn ? 100 : 60,
            child: UIListView<TransferModuleInfo>(
              direction: Axis.horizontal,
              scrollPhysics: const ScrollPhysics(),
              elements: elements,
              itemBuilder: (context, index) {
                TransferModuleInfo item = elements[index];
                return isColumn
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: context.screenWidth / 4.5,
                          child: Column(
                            children: [
                              if (!subtitle)
                                Expanded(
                                  child: Image.asset(
                                    item.assetPathOrDefault,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              if (subtitle)
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: UiCard(
                                      cardColor: DefaultColors.blue_light_03,
                                      child: Center(
                                        child: UiTextNew.custom(
                                          item.title[0],
                                          color: DefaultColors.primaryBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: UiTextNew.h4Medium(
                                    item.title,
                                    maxLines: subtitle ? 1 : 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              if (subtitle)
                                const Expanded(
                                  child: UiTextNew.h5Regular("XXXXXXX743"),
                                ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.router.push(item.route);
                              },
                              child: Image.asset(
                                item.assetPathOrDefault,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const UiSpace.horizontal(10),
                            SizedBox(
                              width: context.screenWidth / 3.6,
                              child: UiTextNew.h4Medium(item.title),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: UIAppBar.secondary(
        title: DefaultString.instance.fundTransfer,
        autoLeadingWidget: const AutoLeadingWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            // transfers
            DefaultTabController(
              length: tabPages.length,
              child: UiCard(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    UITabBar(
                      tabs: tabPages,
                      tabController: _tabController,
                      selectedTabIndex: selectedIndex,
                      onTap: (index) {
                        if (selectedIndex != index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        }
                      },
                      dividerColor: DefaultColors.primaryGreen,
                      inActiveDividerColor: DefaultColors.grayE5,
                      activeTabColor: Colors.transparent,
                      activeTabTextColor: DefaultColors.primaryBlue,
                      inActiveTabTextColor: DefaultColors.gray8A,
                      activeIcons: [
                        AssetPath.icon.domesticActive,
                        AssetPath.icon.iftActive,
                      ],
                      inActiveIcons: [
                        AssetPath.icon.domestic,
                        AssetPath.icon.ift,
                      ],
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.21,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          UIGridList<TransferModuleInfo>(
                            elements: domestic,
                            itemBuilder: (context, index) {
                              TransferModuleInfo item = domestic[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: UiCard(
                                  onTap: () async {
                                    ref
                                        .read(selectedTransferProvider.notifier)
                                        .state = TransferSelection(
                                      classification: "domestic",
                                      index: index,
                                    );

                                    if (index == 0) {
                                      item.onSelected.call(
                                        context,
                                        beneficiary: null,
                                        purpose: false,
                                        displayBank: false,
                                        displayAccountNum: false,
                                        displayIfsc: false,
                                        showFlag: false,
                                        showSendLater: true,
                                        showRemit: false,
                                        showSendAmount: false,
                                        showGetAmount: false,
                                        showBenRelation: false,
                                      );
                                    } else {
                                      await _buildBenPicker(
                                        showIfsc: index == 3,
                                        showAccount: index != 3,
                                        showBankName: index == 2,
                                        transModule: item,
                                        sendBeneficiary: index != 0,
                                        info: index == 2
                                            ? info
                                            : index == 3
                                            ? dCardInfo
                                            : [],
                                        showPurpose: index == 2,
                                        sendLater: index != 3,
                                      );
                                    }
                                  },
                                  cardColor: DefaultColors.blue_light_03,
                                  child: Center(
                                    child: ListTile(
                                      trailing: Image.asset(
                                        item.assetPathOrDefault,
                                        height: 35,
                                        width: 35,
                                      ),
                                      title: Text(
                                        item.title,
                                        style: UiTextNew.h4Regular(item.title)
                                            .getTextStyle(context)
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            crossCount: 2,
                            mainAxisExtent: context.screenHeight * 0.099,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                          ),
                          UIGridList<TransferModuleInfo>(
                            elements: ift,
                            itemBuilder: (context, index) {
                              TransferModuleInfo item = ift[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: UiCard(
                                  onTap: () async {
                                    ref
                                        .read(selectedTransferProvider.notifier)
                                        .state = TransferSelection(
                                      classification: "ift",
                                      index: index,
                                    );
                                    await _buildBenPicker(
                                      transModule: item,
                                      showIfsc: index == 0 || index == 3,
                                      showAccount: false,
                                      showBankName: index != 2,
                                      showFlag: true,
                                      info: index == 0 || index == 1
                                          ? iftInfo
                                          : [],
                                      sendBeneficiary: true,
                                      showRemit: index != 2,
                                      showSendAmount: true,
                                      showGetAmount: true,
                                      showBenRelation: index != 2,
                                      sendLater: false,
                                    );
                                  },
                                  cardColor: DefaultColors.blue_light_03,
                                  child: Center(
                                    child: ListTile(
                                      trailing: Image.asset(
                                        item.assetPathOrDefault,
                                        height: 35,
                                        width: 35,
                                      ),
                                      title: Text(
                                        item.title,
                                        style: UiTextNew.h4Regular(item.title)
                                            .getTextStyle(context)
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            crossCount: 2,
                            mainAxisExtent: context.screenHeight * 0.099,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // fawran
            const UiSpace.vertical(20),
            _buildRow(title: DefaultString.instance.fawran, elements: fawran),

            // transaction
            const UiSpace.vertical(20),
            SizedBox(
              height: 140,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  UIListView<TransferModuleInfo>(
                    direction: Axis.horizontal,
                    scrollPhysics: const ScrollPhysics(),
                    elements: transaction,
                    itemBuilder: (context, index) {
                      TransferModuleInfo item = transaction[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: UiCard(
                          child: SizedBox(
                            width: context.screenWidth / 2.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (index == 0) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return TransactionStatusSheet();
                                          },
                                        );
                                      }
                                      if (index == 1) {
                                        ref
                                            .read(
                                              selectedTransferProvider.notifier,
                                            )
                                            .state = TransferSelection(
                                          classification: "donation",
                                          index: index,
                                        );
                                        context.router.push(item.route);
                                      }
                                    },
                                    child: Image.asset(
                                      item.assetPathOrDefault,
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      right: 5,
                                      left: 5,
                                    ),
                                    child: UiTextNew.b14Semibold(
                                      item.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  UIListView<TransferModuleInfo>(
                    direction: Axis.horizontal,
                    scrollPhysics: const ScrollPhysics(),
                    elements: transactionIFT,
                    itemBuilder: (context, index) {
                      TransferModuleInfo item = transactionIFT[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: UiCard(
                          child: SizedBox(
                            width: context.screenWidth / 3.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    item.assetPathOrDefault,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      right: 5,
                                      left: 5,
                                    ),
                                    child: UiTextNew.b14Semibold(
                                      item.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // favourite
            const UiSpace.vertical(20),
            _buildRow(
              title: DefaultString.instance.favourites,
              elements: fav,
              trailText: DefaultString.instance.viewAll,
              subtitle: true,
            ),

            // beneficiary
            const UiSpace.vertical(20),
            _buildRow(
              title: DefaultString.instance.ben,
              elements: bene,
              isColumn: false,
            ),
          ],
        ),
      ),
    );
  }
}
