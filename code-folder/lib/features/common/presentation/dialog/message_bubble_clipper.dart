import 'package:flutter/material.dart';

class MessageBubbleClipper extends CustomClipper<Path> {
  final bool isFABLeft;

  MessageBubbleClipper({this.isFABLeft = false});

  @override
  Path getClip(Size size) {
    double radius = 16.0;
    double pointerSize = 12.0;

    Path path = Path();
    if (isFABLeft) {
      path.moveTo(pointerSize, 0);
      path.lineTo(size.width - radius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, radius);
      path.lineTo(size.width, size.height - radius);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - radius,
        size.height,
      );
      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
      path.lineTo(0, radius + pointerSize);
      path.quadraticBezierTo(0, pointerSize, radius, pointerSize);
      path.lineTo(pointerSize, 0); // pointer
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width - pointerSize - radius, 0);
      path.quadraticBezierTo(
        size.width - pointerSize,
        0,
        size.width - pointerSize,
        radius,
      );
      path.lineTo(size.width - pointerSize, size.height - radius);
      path.quadraticBezierTo(
        size.width - pointerSize,
        size.height,
        size.width - pointerSize - radius,
        size.height,
      );
      path.lineTo(radius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - radius);
      path.lineTo(0, radius);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
