import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../boot/boot_provider.dart';

class BootGate extends ConsumerStatefulWidget {
  const BootGate({
    super.key,
    required this.onReady,
    required this.onError,
    this.minSplashTime = const Duration(seconds: 3),
  });

  final VoidCallback onReady;
  final void Function(String message) onError;
  final Duration minSplashTime;

  @override
  ConsumerState<BootGate> createState() => _BootGateState();
}

class _BootGateState extends ConsumerState<BootGate> {
  bool _done = false;
  late final Future<void> _minSplash; // single, stable timer

  @override
  void initState() {
    super.initState();
    _minSplash = Future.delayed(widget.minSplashTime);
  }

  Future<void> _finishAfterMin(VoidCallback action) async {
    if (_done) return;
    await _minSplash;
    if (_done || !mounted) return;
    _done = true;
    action();
  }

  @override
  Widget build(BuildContext context) {
    // ensure the provider is running
    ref.watch(bootProvider);

    // listen for state changes
    ref.listen<AsyncValue<BootResult>>(bootProvider, (prev, next) {
      if (_done) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_done) return;

        next.when(
          data: (res) {
            _finishAfterMin(() {
              if (res is BootReady) {
                widget.onReady();
              } else if (res is BootError) {
                widget.onError(res.message);
              }
            });
          },
          error: (e, st) {
            _finishAfterMin(() => widget.onError('Unexpected error'));
          },
          loading: () {
            // keep waiting (no-op)
          },
        );
      });
    });

    return const SizedBox.shrink();
  }
}
