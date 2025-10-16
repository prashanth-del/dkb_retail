import 'package:flutter/foundation.dart';

/// Global, process-wide lock controller.
/// Uses token-based ref-counting to avoid double-unlock & to merge multiple
/// concurrent operations into a single overlay.
class GlobalLock extends ChangeNotifier {
  GlobalLock._();
  static final GlobalLock I = GlobalLock._();

  final Set<String> _tokens = <String>{};
  int _seq = 0;

  bool get isLocked => _tokens.isNotEmpty;

  /// Start a lock and return a token to stop later.
  String start([String tag = 'op']) {
    final token = '$tag#${DateTime.now().microsecondsSinceEpoch}-${_seq++}';
    _tokens.add(token);
    notifyListeners();
    return token;
  }

  /// Stop a previously started lock. Safe to call multiple times.
  void stop(String token) {
    if (_tokens.remove(token)) {
      notifyListeners();
    }
  }

  /// Utility to run an async function under lock. Always unlocks in finally.
  Future<T> runLocked<T>(Future<T> Function() task, {String tag = 'op'}) async {
    final t = start(tag);
    try {
      return await task();
    } finally {
      stop(t);
    }
  }

  /// Debug / recovery escape hatch.
  void clearAll() {
    if (_tokens.isNotEmpty) {
      _tokens.clear();
      notifyListeners();
    }
  }
}
