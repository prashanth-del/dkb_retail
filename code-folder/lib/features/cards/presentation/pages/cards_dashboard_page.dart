import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/ui_total_avail_bal_card.dart';
import 'package:db_uicomponents/src/components/ui_account_card_list.dart';
import 'package:db_uicomponents/src/components/ui_favorites_card.dart';
import 'package:db_uicomponents/src/components/ui_insta_transfer_card.dart';
import 'package:db_uicomponents/src/components/ui_cards_card_list.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/cards/presentation/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../accounts/presentation/widget/dashboard_slider.dart';
import '../../../dashboard/presentation/widgets/insta_transfer_card.dart';
import '../../../dashboard/presentation/widgets/pay_bill_widget.dart';
import '../../../dashboard/presentation/widgets/total_avail_bal_card.dart';
import '../../data/model/card_summary_model.dart';
import '../../domain/entity/card_summary_entity.dart';
import '../controller/notifier/cards_summary_notifier.dart';
import '../widget/card_shimmer.dart';

class CardsDashboardPage extends ConsumerStatefulWidget {
  const CardsDashboardPage({super.key});

  @override
  ConsumerState<CardsDashboardPage> createState() => _CardsDashboardPageState();
}

class _CardsDashboardPageState extends ConsumerState<CardsDashboardPage> {
  // int? _expandedIndex;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    // UserProfile? userProfile = ref.watch(userProfileProvider);
    final cardSummaryProvider = ref.watch(getCardSummaryProvider);
    // final pendingApprovalProvider =
    // ref.watch(getPendingApprovalNotifierProvider);
    // final completedTransaction =
    // ref.watch(getCompletedTransactionNotifierProvider);

    // bool isLoading = userProfile == null || userProfile.userRole == null
    //     ? false
    //     : userProfile.userRole == UserRoleType.maker
    //     ? accSummaryProvider.isLoading
    //     : accSummaryProvider.isLoading || pendingApprovalProvider.isLoading;

    // if (isLoading) {
    //   return const AccountDashboardShimmer();
    // } else if (userProfile == null || userProfile.userRole == null) {
    //   return _buildErrorContent("Unable to get user role");
    // } else {
    //   return _buildContent(tabsRouter, userProfile.userRole!);
    // }

    return _buildContent(tabsRouter);
  }

  Widget _buildContent(TabsRouter tabsRouter) {
    return UiScrollBar(
      padding: const EdgeInsets.only(right: 5),
      controller: _scrollController,
      child: Directionality(
        textDirection: context.localeDirection,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const SizedBox(height: 15),
              _buildCardInfoCard(tabsRouter),
              const SizedBox(height: 12),
              _buildFavoriteCard(tabsRouter),
              const SizedBox(height: 25),
              const InstaTransfersCard(),
              const SizedBox(height: 25),
              PayBill(),
              const SizedBox(height: 24),
              _buildSuggestedSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfoCard(TabsRouter tabsRouter) {
    // return  _buildAccountSummaryCard(tabsRouter);
    final cardSummary = ref.watch(getCardSummaryProvider);

    return cardSummary.when(
      data: (data) => _buildCardSummaryCard(data, tabsRouter),
      error: (error, _) => _buildErrorContent(error),
      loading: () => const CardShimmer(),
    );
  }

  Widget _buildCardSummaryCard(CardSummaryEntity data, TabsRouter tabsRouter) {
    List<CreditCardUI> formattedCards = data.cardSummary.map((card) {
      return formatCards(card);
    }).toList();

    return UiSwiper<CardSummary>.swiper3(
      elements: data.cardSummary,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Expanded(
                child: CardWidget(index: index, card: data.cardSummary[index]),
              ),
              const UiSpace.vertical(20),
            ],
          ),
        );
      },
      height: context.screenHeight / 4.2,
    );

    // return TotalAvailBalCard(
    //   title: 'Total Outstanding Balance',
    //   currency: 'QAR',
    //   outstandingBalance: data.totalOutstandingBalance
    //       .where((currency) => currency.currencyName == 'QAR')
    //       .map((currency) => currency.amt)
    //       .first,
    //   isBalanceVisible: false,
    //   cardData: formattedCards,
    //   onToggleVisibility: (isVisible) {
    //     // print('Balance visibility toggled: $isVisible');
    //   },
    // );
  }

  Widget _buildFavoriteCard(TabsRouter tabsRouter) {
    return FavouritesCard(
      names: const ['Joseph', 'Karthik', 'Sanjana', 'Joseph'],
      icons: [
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
        UISvgIcon(assetPath: AssetPath.icon.UserIcon),
      ],
      onViewAllPressed: () {
        // Handle View All press
        print("View All pressed!");
      },
    );
  }

  Widget _buildSuggestedSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: UiTextNew.customRubik(
            "Suggested for you!",
            color: DefaultColors.white_800,
            fontSize: 16,
          ),
        ),
        UiSpace.vertical(10),
        SizedBox(height: 208, child: DashboardSlider()),
      ],
    );
  }

  Widget _buildErrorContent(dynamic error) {
    final i18Description = ref.getLocaleString(
      "Please_try_again_later",
      defaultValue: "Please try again later",
    );
    return Column(
      children: [
        const UiSpace.vertical(20),
        UiServerError(
          lottieAssetPath: AssetPath.lottie.empty,
          errorMessage: error.toString(),
          description: i18Description,
        ),
        const UiSpace.vertical(20),
      ],
    );
  }

  CreditCardUI formatCards(CardSummary card) {
    return CreditCardUI(
      cardHolderName: card.cardName,
      cardNumber: card.maskedCardNo,
      outstandingBalance: card.outstandingBalance,
      availableLimit: card.availableCreditLimit,
      backgroundImage: DecorationImage(
        image: AssetImage(AssetPath.image.cardsBgImg),
        fit: BoxFit.cover,
      ),
    );
  }

  //
  // Widget _buildPendingApprovalsCard(TabsRouter tabsRouter) {
  //   final pendingApprovalProvider =
  //   ref.watch(getPendingApprovalNotifierProvider);
  //
  //   return UiCard(
  //     cardColor: DefaultColors.skyBlue,
  //     padding: const EdgeInsets.only(bottom: 15, left: 15, top: 10),
  //     child: pendingApprovalProvider.when(
  //       data: (data) => _buildPendingApprovalContent(
  //           data.pendingApproval ?? [], tabsRouter),
  //       error: (error, _) => UiServerError(
  //         errorMessage: error.toString(),
  //         lottieAssetPath: AssetPath.lottie.empty,
  //       ),
  //       loading: () => const PendingAprrovalShimmer(),
  //     ),
  //   );
  // }
  //
  // Widget _buildPendingApprovalContent(
  //     List<ProductEntity> pendingApprovals, TabsRouter tabsRouter) {
  //   final userRole = ref.read(userProfileProvider)?.userRole;
  //   final isVerifier = userRole == UserRoleType.verifier;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Flexible(
  //         child: UiTextNew.h3Semibold(
  //           isVerifier?
  //           ref.getLocaleString("Pending_for_Verification"):ref.getLocaleString("Pending_Approvals") ,
  //           color: DefaultColors.black24,
  //         ),
  //       ),
  //       const UiSpace.vertical(16),
  //       Column(
  //         children: pendingApprovals.asMap().entries.map((entry) {
  //           final index = entry.key;
  //           final approval = entry.value;
  //           return Padding(
  //             padding: const EdgeInsets.fromLTRB(0, 0, 15, 5),
  //             child: UiCard(
  //               child: Column(
  //                 children: [
  //                   _buildMenuHeader(approval, index, tabsRouter),
  //                   CustomExpandableTile(
  //                     subProductEntities: approval.subProduct ?? [],
  //                     isExpanded: _expandedIndex == index,
  //                     productEntity: approval,
  //                     onSubProductTap: (product) => _navigateToApprovals(
  //                         tabsRouter, product,
  //                         fromSubmenu: true),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildMenuHeader(
  //     ProductEntity approval, int index, TabsRouter tabsRouter) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
  //     child: ListTile(
  //       leading: SvgPicture.asset(
  //         PendingApprovalIcons().getIconPath(approval.productCode.orEmpty()),
  //         width: 22,
  //         height: 22,
  //       ),
  //       title: InkWell(
  //         onTap: () =>
  //             _navigateToApprovals(tabsRouter, approval, fromSubmenu: false),
  //         child: UiTextNew.b2Medium(
  //           ref.getLocaleString(approval.productCode ?? "",
  //               defaultValue: approval.productDesc.orEmpty()),
  //           lineHeight: 1,
  //           color: DefaultColors.black24,
  //         ),
  //       ),
  //       trailing: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           if (approval.count != null)
  //             Container(
  //               height: 21.0,
  //               width: 21.0,
  //               alignment: Alignment.center,
  //               decoration: const BoxDecoration(
  //                 color: DefaultColors.blue9B,
  //                 shape: BoxShape.circle,
  //               ),
  //               child: UiTextNew.b3Medium(
  //                 "${approval.count}",
  //                 overflow: TextOverflow.ellipsis,
  //                 color: DefaultColors.whiteFD,
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           const UiSpace.horizontal(10),
  //           InkWell(
  //             onTap: () => _toggleExpansion(index),
  //             child: Icon(
  //               _expandedIndex == index
  //                   ? Icons.keyboard_arrow_up
  //                   : Icons.keyboard_arrow_down,
  //               color: DefaultColors.blue9D,
  //             ),
  //           ),
  //         ],
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(horizontal: 4),
  //       visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
  //       dense: true,
  //     ),
  //   );
  // }
  //
  // Widget _buildCompletedTransactionsCard() {
  //   return const UiCard(
  //     cardColor: DefaultColors.skyBlue,
  //     child: Padding(
  //       padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
  //       child: CompletedTransaction(),
  //     ),
  //   );
  // }
  //
  // Widget _buildSuggestedSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10),
  //         child: UiTextNew.h3Semibold(
  //           ref.getLocaleString("Suggested_for_you!"),
  //           color: DefaultColors.black,
  //         ),
  //       ),
  //       const UiSpace.vertical(10),
  //       const DashboardSlider(),
  //     ],
  //   );
  // }
  //
  // Widget _buildErrorContent(dynamic error) {
  //   final i18Description = ref.getLocaleString("Please_try_again_later",
  //       defaultValue: "Please try again later");
  //   return Column(
  //     children: [
  //       const UiSpace.vertical(20),
  //       UiServerError(
  //         lottieAssetPath: AssetPath.lottie.empty,
  //         errorMessage: error.toString(),
  //         description: i18Description,
  //       ),
  //       const UiSpace.vertical(20),
  //     ],
  //   );
  // }
  //
  // void _navigateToTab(TabsRouter tabsRouter, int index) {
  //   final moduleData = ref.read(moduleMapProvider).values.toList();
  //   tabsRouter.setActiveIndex(index);
  //   moduleData[index].onSelected?.call();
  // }
  //
  // void _toggleExpansion(int index) {
  //   setState(() => _expandedIndex = (_expandedIndex == index) ? null : index);
  // }
  //
  // void _navigateToApprovals(TabsRouter tabsRouter, ProductEntity product,
  //     {required bool fromSubmenu}) async {
  //   // UiToast().showToast("Coming Soon");
  //   ref.read(activeTabIndex.notifier).state = 0;
  //   ref.read(checkBoxVisibilityProvider.notifier).state = fromSubmenu;
  //   _expandedIndex = null;
  //   tabsRouter.setActiveIndex(1);
  //   await ref.read(approvalNotifierProvider.notifier).fetchTransactionSummary(
  //     productEntity: product,
  //     action: 'PENDING',
  //   );
  // }
  //
}

class DropdownField extends StatelessWidget {
  final String hintText;

  const DropdownField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: const [],
      onChanged: (value) {},
    );
  }
}
