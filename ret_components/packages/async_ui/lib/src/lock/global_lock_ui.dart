import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lock_controller.dart';
import 'lock_visibility.dart';
import 'lock_overlay_theme.dart';

class GlobalLockUI extends ConsumerStatefulWidget {
  const GlobalLockUI({
    super.key,
    required this.child,
    this.overlayBuilder,    // legacy hook
    this.absorbTaps = true, // legacy fallback
  });

  final Widget child;
  final Widget Function(BuildContext context)? overlayBuilder;
  final bool absorbTaps;

  @override
  ConsumerState<GlobalLockUI> createState() => _GlobalLockUIState();
}

class _GlobalLockUIState extends ConsumerState<GlobalLockUI> {
  bool _forceHideOverlay = false;
  bool _suppressBackGuard = false;
  WidgetBuilder? _pageOverlayBuilder;

  void _applyNote(LockOverlayVisibilityNotification note) {
    if (!mounted) return;
    setState(() {
      _forceHideOverlay   = note.hideOverlay;
      _suppressBackGuard  = note.suppressBackGuard;
      _pageOverlayBuilder = note.customOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LockOverlayVisibilityNotification>(
      onNotification: (note) {
        // Defer to next frame to avoid "setState during build".
        WidgetsBinding.instance.addPostFrameCallback((_) => _applyNote(note));
        return true;
      },
      child: _Logic(
        child: widget.child,
        legacyOverlayBuilder: widget.overlayBuilder,
        legacyAbsorbTaps: widget.absorbTaps,
        forceHideOverlay: _forceHideOverlay,
        suppressBackGuard: _suppressBackGuard,
        pageOverlayBuilder: _pageOverlayBuilder,
      ),
    );
  }
}

class _Logic extends ConsumerWidget {
  const _Logic({
    required this.child,
    required this.legacyOverlayBuilder,
    required this.legacyAbsorbTaps,
    required this.forceHideOverlay,
    required this.suppressBackGuard,
    required this.pageOverlayBuilder,
  });

  final Widget child;
  final Widget Function(BuildContext context)? legacyOverlayBuilder;
  final bool legacyAbsorbTaps;
  final bool forceHideOverlay;
  final bool suppressBackGuard;
  final WidgetBuilder? pageOverlayBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count  = ref.watch(globalLockProvider);
    final locked = count > 0;

    final theme       = LockOverlayTheme.of(context);
    final showOverlay = locked && !forceHideOverlay && theme.visible;
    final allowBack   = theme.allowBackWhileLocked || suppressBackGuard;

    final overlay = pageOverlayBuilder?.call(context) ??
        theme.overlayBuilder?.call(context, theme) ??
        legacyOverlayBuilder?.call(context) ??
        _DefaultDimmer(theme.barrierColor);

    final absorb = theme.absorbTaps;

    return PopScope(
      canPop: !locked || allowBack,
      child: Stack(
        children: [
          child,
          if (showOverlay)
            AbsorbPointer(absorbing: absorb, child: overlay),
        ],
      ),
    );
  }
}

class _DefaultDimmer extends StatelessWidget {
  const _DefaultDimmer(this.barrierColor);
  final Color? barrierColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (barrierColor ?? Colors.black.withOpacity(0.25)),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 44, height: 44,
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}
