import 'dart:ui';

import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class CreditCards extends StatelessWidget {
  final CreditCardUI cards;
  const CreditCards({
    required this.cards,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 237,
        child: Column(
            children:[ Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreditCardUI(
                      cardHolderName: cards.cardHolderName,
                      cardNumber: cards.cardNumber,
                      outstandingBalance: cards.outstandingBalance,
                      availableLimit: cards.availableLimit,
                      backgroundImage: cards.backgroundImage,
                    ),
                  ],
                ),
              ),
            ),
              const SizedBox(height: 10),

              PointsComponent(
                points: 2346,
                onRedeemPressed: () {
                  print('Redeem pressed');
                },
              ),

            ]
        ),

      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 6.0,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? DefaultColors.blue9D : DefaultColors.grayB3,
      ),
    );
  }
}

class UiCardsCardList extends StatefulWidget {
  final List<CreditCardUI> cards;

  const UiCardsCardList({
    required this.cards,
    Key? key,
  }) : super(key: key);

  @override
  _UiCardsCardListState createState() => _UiCardsCardListState();
}

class _UiCardsCardListState extends State<UiCardsCardList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 261,
          child: PageView.builder(
            itemCount: widget.cards.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final card = widget.cards[index];
              return CreditCards(
                cards: card,
              );            },
          ),
        ),
        // Dots Indicator
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.cards.length,
                  (index) => DotIndicator(isActive: currentIndex == index),
            ),
          ),
        ),
      ],
    );
  }
}


class CreditCardUI extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String outstandingBalance;
  final String availableLimit;
  final DecorationImage backgroundImage;

  const CreditCardUI({
    Key? key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.outstandingBalance,
    required this.availableLimit,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 203,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: backgroundImage,
      ),
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(16), // Ensure rounded corners for the blur
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                ),
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 18), // Add padding inside the blurred area
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Holder Name and Number
                    UiTextNew.customRubik(
                      cardHolderName,
                      fontSize: 12,
                      color: DefaultColors.white_0,
                    ),
                     SizedBox(height: 1),
                    UiTextNew.h5Regular(
                      cardNumber,
                      color: DefaultColors.white_0,
                    ),
                    const SizedBox(height: 10),
                    // Outstanding Balance and Available Limit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UiTextNew.h5Regular(
                              'Outstanding Balance',
                              color: DefaultColors.white_0,
                            ),
                            UiTextNew.customRubik(
                              outstandingBalance,
                              fontSize: 12,
                              color: DefaultColors.white_0,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UiTextNew.h5Regular(
                              'Available Limit',
                              color: DefaultColors.white_0,
                            ),
                            UiTextNew.customRubik(
                              availableLimit,
                              fontSize: 12,
                              color: DefaultColors.white_0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class PointsComponent extends StatelessWidget {
  final int points;
  final VoidCallback onRedeemPressed;

  const PointsComponent({
    Key? key,
    required this.points,
    required this.onRedeemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.2),
      //       blurRadius: 8,
      //       spreadRadius: 2,
      //     ),
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              UiTextNew.h5Regular(
                  'You have got ',
                color: Colors.black,
              ),
              UiTextNew.customRubik(
                '$points points',
                fontSize: 12,
                color: Colors.black,
              )
            ],
          ),
          TextButton(
            onPressed: onRedeemPressed,
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
            child:const  UiTextNew.customRubik(
            'REDEEM',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: DefaultColors.blue9D,
            )
          ),
        ],
      ),
    );
  }
}
