import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:db_uicomponents/src/components/ui_total_avail_bal_card.dart';
import 'package:db_uicomponents/src/components/ui_account_card_list.dart';
import 'package:db_uicomponents/src/components/ui_favorites_card.dart';
import 'package:db_uicomponents/src/components/ui_insta_transfer_card.dart';
import 'package:db_uicomponents/src/components/ui_cards_card_list.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/pay_bill_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../accounts/data/model/account_summary_model.dart';
import '../../../accounts/domain/entity/account_summary_entity.dart';
import '../../../accounts/presentation/controller/notifier/account_summary_notifier.dart';
import '../../../accounts/presentation/widget/account_card.dart';
import '../../../accounts/presentation/widget/dashboard_slider.dart';
import '../../../dashboard/presentation/widgets/insta_transfer_card.dart';
import '../../../dashboard/presentation/widgets/total_avail_bal_card.dart';

class DepositDashboardPage extends ConsumerStatefulWidget {
  const DepositDashboardPage({super.key});

  @override
  ConsumerState<DepositDashboardPage> createState() =>
      _DepositDashboardPageState();
}

class _DepositDashboardPageState extends ConsumerState<DepositDashboardPage> {
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
              _buildDepositsInfoCard(tabsRouter),
              const SizedBox(height: 25),
              _buildFavoriteCard(tabsRouter),
              const SizedBox(height: 25),
              const InstaTransfersCard(),
              const SizedBox(height: 25),
              PayBill(),
              const SizedBox(height: 25),
              _buildSuggestedSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepositsInfoCard(TabsRouter tabsRouter) {
    return Container(
      height: 122,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AssetPath.image.depositsFrameImg,
          ), // Path to your image
          fit: BoxFit
              .cover, // Adjust how the image is fitted inside the container
        ),
        // border: Border.all(
        //   color: Colors.blue,
        //   width: 2,
        // ),
        borderRadius: BorderRadius.circular(
          10,
        ), // Optional: Adds rounded corners
      ),
    );
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

  AccountCard formatAccount(AccountDetailsA account, int index) {
    return AccountCard(
      accountType: account.accountType,
      accountNumber: account.accountNum,
      balance: '*********',
      currency: account.currencyName,
      index: index,
      // imgBg2:  Image.asset(
      //   AssetPath.image.cardBgRetailImg, // Replace with your second image asset path
      //   fit: BoxFit.contain,
      //   width: 100, // Adjust size if needed
      // ),
    );
  }

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
