import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/account_details.dart';
import 'account_card.dart';

/// Controls expanded/collapsed state of the card stack
final cardStackExpandedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

class CardStack extends ConsumerWidget {
  final List<AccountDetails> accounts;
  final Axis direction;
  final double cardHeight;
  final double cardWidth;
  final ScrollPhysics scrollPhysics;
  final Function(AccountDetails accountDetail) cardCallbackFunction;

  const CardStack({
    super.key,
    required this.accounts,
    this.direction = Axis.vertical,
    this.cardHeight = 250,
    this.cardWidth = 380,
    this.scrollPhysics = const BouncingScrollPhysics(),
    required this.cardCallbackFunction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = ref.watch(cardStackExpandedProvider);
    final cardHeight = this.cardHeight;
    final cardWidth = this.cardWidth;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          ref.read(cardStackExpandedProvider.notifier).state = !expanded;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: direction == Axis.vertical
              ? (expanded ? (cardHeight * accounts.length) : cardHeight)
              : cardHeight + 10,
          width: direction == Axis.horizontal
              ? (expanded ? (cardWidth * accounts.length) : cardWidth)
              : cardWidth,
          child: SingleChildScrollView(
            scrollDirection: direction,
            physics: scrollPhysics,
            child: Stack(
              children: accounts.asMap().entries.map((entry) {
                final index = entry.key;
                final account = entry.value;

                /// margin logic depending on orientation + expanded state
                EdgeInsets margin;
                if (direction == Axis.vertical) {
                  margin = expanded
                      ? EdgeInsets.only(
                          top:
                              (cardHeight * (accounts.length - 1)) -
                              (cardHeight * index),
                        )
                      : EdgeInsets.only(bottom: index * 10);
                } else {
                  margin = expanded
                      ? EdgeInsets.only(
                          left:
                              (cardWidth * (accounts.length - 1)) -
                              (cardWidth * index),
                        )
                      : EdgeInsets.only(
                          left: (accounts.length - 1 - index) * 10,
                        );
                }

                return AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  alignment: Alignment.topCenter,

                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: margin,
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(10),
                      duration: const Duration(milliseconds: 500),
                      height: direction == Axis.horizontal && !expanded
                          ? cardHeight - ((accounts.length - 1 - index) * 20)
                          : cardHeight,
                      width: direction == Axis.vertical && !expanded
                          ? cardWidth - ((accounts.length - 1 - index) * 20)
                          : cardWidth,
                      child: GestureDetector(
                        onTap: expanded
                            ? () {
                                cardCallbackFunction(account);
                              }
                            : null,
                        child: AccountCard(
                          holderName: "Chetan joshi",
                          accountType: "Saving Accounts",
                          accountNumber: account.accountNumber,
                          balance: account.balance,
                          currency: "QAR",
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
