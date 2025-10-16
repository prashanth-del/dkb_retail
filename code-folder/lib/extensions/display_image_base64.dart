import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DisplayBase64Image extends StatelessWidget {
  final String base64String;
  final double width;
  final double height;
  final BoxFit fit;

  // Decode once
  late final Uint8List? imageBytes = base64String.isNotEmpty
      ? base64Decode(base64String)
      : null;

  DisplayBase64Image({
    super.key,
    required this.base64String,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageBytes == null) {
      return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
    }
    return Image.memory(imageBytes!, width: width, height: height, fit: fit);
  }
}
