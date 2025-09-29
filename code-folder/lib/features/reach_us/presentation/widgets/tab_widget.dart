import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/constants/colors.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final ValueChanged<int> indexSelected;
  final int currentIndex;

  const TabWidget({
    super.key,
    required this.indexSelected,
    required this.currentIndex,
  });

  final List<String> activityTrack = const ["All", "Branch", "ATM", "Kiosk"];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: Colors.white,
        ),
        height: 36,
        child: Row(
          children: List.generate(activityTrack.length, (index) {
            return Expanded(
              child: TabItemWidget(
                onTap: () => indexSelected(index),
                title: activityTrack[index],
                selected: currentIndex == index,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TabItemWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TabItemWidget({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: selected ? DefaultColors.blueLightBase : DefaultColors.white,
          ),
          child: Center(
            child: UiTextNew.custom(
              title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: selected ? DefaultColors.white : DefaultColors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// class TabWidget extends StatelessWidget {
//   final ValueChanged<int> indexSelected;
//   final int currentIndex;
//
//   const TabWidget({
//     super.key,
//     required this.indexSelected,
//     required this.currentIndex,
//   });
//
//   final List<String> activityTrack = const ["All", "Branch", "ATM", "Kiosk"];
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(80),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(80),
//           color: Colors.white,
//         ),
//         height: 36,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
//           child: ListView.builder(
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             itemCount: activityTrack.length,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return TabItemWidget(
//                 onTap: () => indexSelected(index), // 👈 just call parent
//                 title: activityTrack[index],
//                 selected: currentIndex == index, // 👈 highlight from parent
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TabItemWidget extends StatelessWidget {
//   final String title;
//   final bool selected;
//   final VoidCallback onTap;
//   final BorderRadius? borderRadius;
//   TabItemWidget({
//     super.key,
//     required this.title,
//     required this.selected,
//     required this.onTap,
//     this.borderRadius,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 70,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(80),
//           color: selected ? DefaultColors.blueLightBase : DefaultColors.white,
//         ),
//         child: Center(
//           child: UiTextNew.custom(
//             title,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: selected ? DefaultColors.white : DefaultColors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
