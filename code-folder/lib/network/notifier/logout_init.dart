import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitLogoutNotifier extends StateNotifier<bool> {
  InitLogoutNotifier() : super(false);

  void markTried() => state = true;
  void reset() => state = false;
}