import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/bottom_navbar_provider.dart';
import 'menu_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavbarIndex = ref.watch(bottomNavbarProvider);
    final List<Widget> pages = [
      Center(child: Text("Home Page")),
      Center(child: Text("Bills Page")),
      Center(child: Text("Transfer Page")),
      Center(child: Text("Wallet Page")),
      MenuPage(),
    ];
    return Scaffold(
      body: pages[bottomNavbarIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),

        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: BottomNavigationBar(
          type:
              BottomNavigationBarType.fixed, // <-- Prevents resizing & shifting
          currentIndex: bottomNavbarIndex,
          onTap: (index) {
            ref.read(bottomNavbarProvider.notifier).state = index;
          },
          selectedIconTheme: IconThemeData(
            color: Colors.black,
            size: 24,
          ), // fixed size
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
            size: 24,
          ), // fixed size
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12, // fixed size
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12, // fixed size
          ),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.tab), label: "Offers"),
            BottomNavigationBarItem(
              icon: Icon(Icons.ios_share_outlined),
              label: "Pay",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ],
        ),
      ),
    );
  }
}
