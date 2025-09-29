import 'package:flutter_riverpod/flutter_riverpod.dart';

final isBackgroundDetected = StateProvider<bool>((ref) => false);
final isOverlayDetected = StateProvider<bool>((ref) => false);