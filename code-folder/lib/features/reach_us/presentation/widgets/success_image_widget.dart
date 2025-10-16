import 'package:flutter/material.dart';

class SuccessImageWidget extends StatelessWidget {
  const SuccessImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/gif/reach_us/success.gif",
      height: 109,
      width: 109,
    );
  }
}
