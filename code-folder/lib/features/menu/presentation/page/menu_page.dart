import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/toggle_state_provider.dart';
import '../widget/icons.dart';
import '../widget/item_card.dart';
import '../widget/refer_card.dart';
import '../widget/toggle.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final themeIndex = ref.watch(themeToggleProvider);
    final languageIndex = ref.watch(languageToggleProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  spacing: screenWidth * 0.02,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.056,
                      backgroundImage: const NetworkImage(
                        "https://www.shutterstock.com/image-photo/positive-handsome-arabic-businessman-beard-600nw-2510267591.jpg",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alqabiadi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.046,
                          ),
                        ),
                        const Text(
                          "View Profile",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: screenWidth * 0.1,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.5),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: const Color(0xff446193),
                        size: screenWidth * 0.065,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Wrap(
                  spacing: screenWidth * 0.035,
                  runSpacing: screenWidth * 0.035,
                  children: const [
                    ItemCard(
                      image: "assets/images/accounts.png",
                      title: 'Accounts',
                    ),
                    ItemCard(
                      image: "assets/images/credit1.png",
                      title: 'Credit Cards',
                    ),
                    ItemCard(
                      image: "assets/images/deposits.png",
                      title: 'Deposits',
                    ),
                    ItemCard(
                      image: "assets/images/finance.png",
                      title: 'Finance',
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconWidget(
                      title: 'Requests',
                      icon: 'assets/icons/requests.png',
                      function: () {},
                    ),
                    IconWidget(
                      title: 'Reach Us',
                      icon: 'assets/icons/reach.png',
                      function: () {},
                    ),
                    IconWidget(
                      title: 'Invest',
                      icon: 'assets/icons/invest.png',
                      function: () {},
                    ),
                    IconWidget(
                      title: 'Offer',
                      icon: 'assets/icons/offer.png',
                      function: () {},
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                const ReferCard(),
                SizedBox(height: screenWidth * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SegmentedToggle(
                      options: const [
                        Icon(Icons.dark_mode_outlined, color: Colors.black),
                        Icon(Icons.light_mode_outlined, color: Colors.black),
                      ],
                      selectedIndex: themeIndex,
                      activeColor: Colors.grey.shade700,
                      onChanged: (index) =>
                          ref.read(themeToggleProvider.notifier).state = index,
                      title: 'Themes',
                    ),
                    SegmentedToggle(
                      options: const [
                        Text(
                          "عربي",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "English",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                      selectedIndex: languageIndex,
                      activeColor: Colors.blue.shade200,
                      onChanged: (index) =>
                          ref.read(languageToggleProvider.notifier).state =
                              index,
                      title: 'Language',
                    ),
                    IconWidget(
                      title: "Logout",
                      icon: "assets/icons/logout.png",
                      function: () {},
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  "Version No 11.2.1.51",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
