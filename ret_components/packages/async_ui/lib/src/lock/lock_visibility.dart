import 'package:flutter/widgets.dart';

class LockOverlayVisibilityNotification extends Notification {
  final bool hideOverlay;
  final bool suppressBackGuard;
  final WidgetBuilder? customOverlay; // optional page overlay

  LockOverlayVisibilityNotification({
    required this.hideOverlay,
    required this.suppressBackGuard,
    this.customOverlay,
  });
}

/// Wrap a page to change overlay behavior just for that page.
class LockSuppressor extends StatefulWidget {
  const LockSuppressor({
    super.key,
    required this.child,
    this.hideOverlay = false,
    this.suppressBackGuard = false,
    this.customOverlay,
  });

  final Widget child;
  final bool hideOverlay;
  final bool suppressBackGuard;
  final WidgetBuilder? customOverlay;

  @override
  State<LockSuppressor> createState() => _LockSuppressorState();
}

class _LockSuppressorState extends State<LockSuppressor> {
  void _dispatchPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      LockOverlayVisibilityNotification(
        hideOverlay: widget.hideOverlay,
        suppressBackGuard: widget.suppressBackGuard,
        customOverlay: widget.customOverlay,
      ).dispatch(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _dispatchPostFrame();
  }

  @override
  void didUpdateWidget(covariant LockSuppressor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hideOverlay != widget.hideOverlay ||
        oldWidget.suppressBackGuard != widget.suppressBackGuard ||
        oldWidget.customOverlay != widget.customOverlay) {
      _dispatchPostFrame();
    }
  }

  @override
  void dispose() {
    // Reset to defaults synchronously (outside build phase).
    LockOverlayVisibilityNotification(
      hideOverlay: false,
      suppressBackGuard: false,
      customOverlay: null,
    ).dispatch(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listener is only to allow children to emit nested overrides if needed.
    return NotificationListener<LockOverlayVisibilityNotification>(
      onNotification: (_) => false,
      child: widget.child,
    );
  }
}
