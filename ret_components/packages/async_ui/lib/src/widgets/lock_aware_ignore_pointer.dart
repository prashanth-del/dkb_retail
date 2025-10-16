import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../lock/lock_controller.dart';

/// Wrap bottom nav / FAB / action widgets to disable while locked.
class LockAwareIgnorePointer extends ConsumerWidget {
  const LockAwareIgnorePointer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locked = ref.watch(globalLockProvider) > 0;
    return IgnorePointer(ignoring: locked, child: child);
  }
}
