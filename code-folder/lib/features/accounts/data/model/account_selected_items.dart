import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../dashboard/presentation/widgets/brand_deals.dart';
import '../../../dashboard/presentation/widgets/favourites_card.dart';
import '../../../dashboard/presentation/widgets/insta_transfer_card.dart';
import '../../../dashboard/presentation/widgets/offers.dart';
import '../../../dashboard/presentation/widgets/pay_bill_widget.dart';
import '../../../dashboard/presentation/widgets/personalised_deals.dart';
import '../../../dashboard/presentation/widgets/savings_investments.dart';
import '../../../dashboard/presentation/widgets/suggested_section.dart';
import '../../../dashboard/presentation/widgets/travel_packages.dart';
import '../../../dashboard/presentation/widgets/travel_quick_link.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/account_info_card.dart';
import '../../presentation/pages/accounts_page.dart';
import '../../presentation/widget/account_info_card.dart';
// Ensure this is the correct import path

class AccountSelectedItems {
  late bool isSelectedItem;
  late String editTitle;
  late String widgetType; // Store a string identifier for the widget
  late bool isDefault;
  late int id;
  late int index;

  AccountSelectedItems({
    required this.index,
    required this.editTitle,
    required this.id,
    required this.isSelectedItem,
    required this.isDefault,
    required this.widgetType,
  });

  // Factory constructor for creating an instance from JSON
  factory AccountSelectedItems.fromJson(Map<String, dynamic> json) {
    return AccountSelectedItems(
      isSelectedItem: json['isSelectedItem'] as bool,
      editTitle: json['editTitle'] as String,
      widgetType: json['widgetType'] as String,
      isDefault: json['isDefault'] as bool,
      id: json['id'] as int,
      index: json['index'] as int,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'isSelectedItem': isSelectedItem,
      'editTitle': editTitle,
      'widgetType': widgetType,
      'isDefault': isDefault,
      'id': id,
      'index': index,
    };
  }

  // Method to get the actual widget based on the `widgetType`
  Widget getWidget(BuildContext context) {
    switch (widgetType) {
      case 'FavouritesDashCard':
        return const FavouritesDashCard();
      case 'InstaTransfersCard':
        return const InstaTransfersCard();
      case 'PayBill':
        return PayBill();
      case 'SuggestedSection':
        return const SuggestedSection();
      case 'Offers':
        return const Offers();
      case 'BrandDeals':
        return const BrandDeals();
      case 'SavingsAndInvestments':
        return const SavingsAndInvestments();
      case 'TravelPackages':
        return TravelPackages();
      case 'TravelQuickLinks':
        return const TravelQuickLinks();
      case 'PersonalisedDeals':
        return const PersonalisedDeals();
      case 'AccountInfoCard':
        return AccountInfoCardWidget(
          onAccountTap: () {
            context.router.push(AccountsRoute());
          },
        );
      default:
        return const SizedBox.shrink(); // Return an empty widget for unsupported types
    }
  }
}
