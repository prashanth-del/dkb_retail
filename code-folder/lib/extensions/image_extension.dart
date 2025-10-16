import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

extension Base64ImageExtension on String {
  /// Converts a Base64 string to a Uint8List for image processing.
  Uint8List? toImageBytes() {
    try {
      // Remove data URI prefix if present (e.g., "data:image/jpeg;base64,")
      String base64String = this;
      if (contains('data:image')) {
        base64String = split(',').last;
      }
      return base64Decode(base64String);
    } catch (e) {
      debugPrint('Error decoding Base64 string: $e');
      return null;
    }
  }

  /// Converts a Base64 string to an Image widget for display.
  Widget? toImageWidget({
    required BuildContext context, // Add BuildContext as a required parameter
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ImageErrorWidgetBuilder? errorBuilder,
  }) {
    final bytes = toImageBytes();
    if (bytes == null) {
      return errorBuilder?.call(
            context, // Use the provided BuildContext
            'Invalid Base64 image data',
            StackTrace.current,
          ) ??
          const SizedBox.shrink(); // Fallback if no errorBuilder provided
    }
    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      errorBuilder: errorBuilder,
    );
  }
}
