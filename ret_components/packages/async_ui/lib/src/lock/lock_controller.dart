import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lock_bus.dart';

/// Reference-counted global UI lock.
class LockController extends Notifier<int> {
  @override
  int build() => 0;

  bool get locked => state > 0;

  LockToken acquire({String source = ''}) {
    state = state + 1;
    return LockToken(() {
      if (state > 0) state = state - 1;
    });
  }

  Future<T> runWithLock<T>(Future<T> Function() op, {String source = ''}) async {
    final t = acquire(source: source);
    try {
      return await op();
    } finally {
      t.release();
    }
  }
}

final globalLockProvider = NotifierProvider<LockController, int>(LockController.new);

/// Short alias for convenience.
class lock {
  static Future<T> runWithLock<T>(Ref ref, Future<T> Function() op, {String source = ''}) {
    return ref.read(globalLockProvider.notifier).runWithLock(op, source: source);
  }
}
