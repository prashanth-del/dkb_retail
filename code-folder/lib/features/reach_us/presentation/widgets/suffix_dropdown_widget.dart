import 'package:flutter/Material.dart';

class SuffixCommonIcon extends StatelessWidget {
  final bool isDropdown;
  const SuffixCommonIcon({super.key, required this.isDropdown});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isDropdown
          ? Icons.keyboard_arrow_up_outlined
          : Icons.keyboard_arrow_down_outlined,
      color: Colors.black,
    );
  }
}
