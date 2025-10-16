import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/bill_card_model.dart';

class CardSections extends ConsumerWidget {
  final String title;
  final Widget dropdownChild;
  final StateProvider<bool> stateProvider;
  final bool showTriallingIcon;
  final bool isblueIcon;

  const CardSections({
    super.key,
    required this.title,
    required this.dropdownChild,
    required this.stateProvider,
    this.showTriallingIcon = true,
    this.isblueIcon = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isExpanded = ref.watch(stateProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  side: const BorderSide(
                    color: Color.fromARGB(137, 61, 59, 59),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Row(
                    children: [
                      Transform.rotate(
                        angle: 0.5,
                        child: Icon(
                          Icons.push_pin,
                          color: isblueIcon ? Colors.blue : Colors.white,
                          shadows: const [
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        title,
                        style: TextStyle(fontSize: screenWidth * 0.045),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ref.read(stateProvider.notifier).state = !isExpanded;
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // if (showTriallingIcon)
            // const HugeIcon(icon: HugeIcons.strokeRoundedDragDropHorizontal),
          ],
        ),
        if (isExpanded) dropdownChild,
      ],
    );
  }
}

class ActiveBillerSection2 extends StatelessWidget {
  const ActiveBillerSection2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<BillCardModel> billCards = [
      BillCardModel(
        imageUrl: 'assets/images/netflix.png',
        title: 'Netflix',
        amount: '23 QAR',
        trialIcon: Icons.arrow_upward,
      ),
      BillCardModel(
        imageUrl: 'assets/images/prime.png',
        title: 'Prime Video',
        amount: '16.24 QAR',
        trialIcon: Icons.arrow_upward,
      ),
      BillCardModel(
        imageUrl: 'assets/images/github.png',
        title: 'Git Hub',
        amount: '12.43',
        trialIcon: Icons.arrow_upward,
      ),
      BillCardModel(
        imageUrl: 'assets/images/vodafone.png',
        title: 'Vodafone',
        amount: '16.24',
        trialIcon: Icons.arrow_upward,
      ),
    ];
    return Container(
      height: screenHeight * 0.22,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 228, 230),
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
      ),
      padding: EdgeInsets.all(screenWidth * 0.033),
      child: SizedBox(
        height: screenHeight * 0.21,
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: billCards.length,
          itemBuilder: (context, index) {
            final card = billCards[index];
            return Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.03),
              child: BillCards(
                imageUrl: card.imageUrl,
                title: card.title,
                amount: card.amount,
                trialicon: card.trialIcon,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BillCards extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String amount;
  final IconData trialicon;
  final Color headerColor;

  const BillCards({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.amount,
    this.headerColor = const Color(0xFFE8F2FF),
    required this.trialicon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Container(
        width: screenWidth * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenWidth * 0.02,
              ),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.03),
                  topRight: Radius.circular(screenWidth * 0.03),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.038,
                    backgroundImage: AssetImage(imageUrl),
                  ),
                  const Spacer(),
                  Text(title),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.013,
                vertical: screenWidth * 0.008,
              ),
              child: Row(
                children: [
                  Text(amount),
                  const Spacer(),
                  Transform.rotate(angle: 0.5, child: Icon(trialicon)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardSpendSection extends StatelessWidget {
  const CardSpendSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 228, 230),
        borderRadius: BorderRadius.circular(screenWidth * 0.045),
      ),
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.033),
              child: SizedBox(
                height: screenHeight * 0.28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _spendRow(
                      context,
                      'assets/images/netflix.png',
                      'Netflix',
                      'Entertainment',
                      'QAR 2,636.41',
                      screenWidth,
                      screenHeight,
                    ),
                    _spendRow(
                      context,
                      'assets/images/prime.png',
                      'Prime',
                      'Entertainment',
                      'QAR 636.31',
                      screenWidth,
                      screenHeight,
                    ),
                    _spendRow(
                      context,
                      'assets/images/github.png',
                      'Github',
                      'Version Control',
                      'QAR 234.46',
                      screenWidth,
                      screenHeight,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'View all spends',
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Transform.rotate(
                            angle: 0.5,
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -screenHeight * 0.015,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                color: Colors.white,
                border: const Border.fromBorderSide(
                  BorderSide(color: Color.fromARGB(137, 61, 59, 59)),
                ),
              ),
              padding: EdgeInsets.all(screenWidth * 0.025),
              child: const Text('Your recent Spends'),
            ),
          ),
        ],
      ),
    );
  }

  Row _spendRow(
    BuildContext context,
    String image,
    String name,
    String category,
    String amount,
    double screenWidth,
    double screenHeight,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: screenWidth * 0.038,
        ),
        SizedBox(width: screenWidth * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(category),
          ],
        ),
        const Spacer(),
        Text(amount),
      ],
    );
  }
}

class CcBillSection extends StatelessWidget {
  const CcBillSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 228, 230),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.032),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.025),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'September',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Statement',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QAR 2,636.41',
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                  const Text(
                    'Due on the 12th October',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              MaterialButton(
                height: double.minPositive,
                minWidth: double.minPositive,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(screenWidth * 0.038),
                ),
                onPressed: () {},
                child: const Text('Pay', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
