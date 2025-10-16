import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/selection_provider.dart';
import '../widgets/animation_widget.dart';
import '../widgets/button.dart';
import '../widgets/icon.dart';

class QuickLinkPage extends ConsumerWidget {
  const QuickLinkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedIndex = ref.watch(selectedIndexesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back, size: screenWidth * 0.06),
        leadingWidth: screenWidth * 0.15,
        titleSpacing: 0,
        title: Text(
          "Customize Quick Links",
          style: TextStyle(
            color: const Color(0xff0D3E7F),
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select upto 4 Options",
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "You want have quick acces to",
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Wrap(
              spacing: screenWidth * 0.06,
              runSpacing: screenHeight * 0.035,
              children: List.generate(16, (index) {
                final isSelected = selectedIndex.contains(index);

                return GestureDetector(
                  onTap: () {
                    ref.read(selectedIndexesProvider.notifier).update((state) {
                      final newState = {...state};
                      if (newState.contains(index)) {
                        newState.remove(index); // unselect
                      } else {
                        if (newState.length < 4) {
                          newState.add(index); // add only if < 4
                        }
                      }
                      return newState;
                    });
                  },
                  child: Column(
                    children: [
                      AnimatedIconWidget(
                        child: SizedBox(
                          height: screenWidth * 0.15,
                          width: screenWidth * 0.15,
                          child: Stack(
                            children: [
                              IconWidget(),
                              if (isSelected)
                                Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: screenWidth * 0.046,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      SizedBox(
                        width: screenWidth * 0.18,
                        child: Text(
                          "Quick Link Label",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.036,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.02),
              child: Button(),
            ),
          ],
        ),
      ),
    );
  }
}
