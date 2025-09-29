import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/security_threat.dart';
import '../../domain/use_case/device_security.dart';
import '../../provider/dialog_provider.dart';
import '../../provider/overlay_provider.dart' as overlay;

class SecurityGuard extends ConsumerStatefulWidget {
  final Widget child;
  const SecurityGuard({super.key, required this.child});

  @override
  ConsumerState<SecurityGuard> createState() => _SecurityGuardState();
}

class _SecurityGuardState extends ConsumerState<SecurityGuard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    /// Comment to bypass security
    // _checkAppSecurity();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(overlay.isBackgroundDetected.notifier).state =
        state != AppLifecycleState.resumed;
    if (state == AppLifecycleState.resumed) {
      _checkAppSecurity();
    }
  }

  Future<void> _checkAppSecurity() async {
    if (ref.read(isDialogHappened)) return;
    final service = DeviceSecurityService();
    final threat = await service.detectSecurityThreat();
    if (threat != const SecurityThreat.noThreat()) {
      /// TODO - Add popup to exit app
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
