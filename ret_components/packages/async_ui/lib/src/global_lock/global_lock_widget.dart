import 'package:flutter/material.dart';
import 'global_lock.dart';

/// Put this ONCE near the top of your app (MaterialApp.builder is ideal).
/// It draws a single non-dismissible overlay while GlobalLock is engaged,
/// and also blocks back/edge-swipe navigation.
class GlobalLockUI extends StatefulWidget {
  final Widget child;
  final Widget? loader; // optional custom loader
  final Color? barrierColor;

  const GlobalLockUI({
    super.key,
    required this.child,
    this.loader,
    this.barrierColor,
  });

  @override
  State<GlobalLockUI> createState() => _GlobalLockUIState();
}

class _GlobalLockUIState extends State<GlobalLockUI> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GlobalLock.I,
      builder: (context, _) {
        final locked = GlobalLock.I.isLocked;

        // Block system back & iOS interactive-pop while locked.
        return PopScope(
          canPop: !locked,
          child: Stack(
            children: [
              widget.child,
              if (locked)
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Stack(
                      children: [
                        ModalBarrier(
                          dismissible: false,
                          color: widget.barrierColor ??
                              Colors.black.withOpacity(0.20),
                        ),
                        // Center loader
                        Center(
                          child: widget.loader ??
                              const _DefaultLockHUD(), // simple spinner
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _DefaultLockHUD extends StatelessWidget {
  const _DefaultLockHUD();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.90),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 12, spreadRadius: 2, color: Colors.black26),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
