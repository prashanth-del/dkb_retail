import 'package:dkb_retail/startup/start_up/presentation/pages/privacy_overlay.dart';
import 'package:dkb_retail/startup/start_up/presentation/pages/security_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../../core/services/session_manager/session_manager.dart';
import 'app_shell.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(
      ";;;;;;;;;;;;;;;;aPPPPPPPPPPPPPPPPROOOOOOOOOT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;",
    );
    final isRtl = ref.watch(localePodProvider).languageCode == 'ar';
    final dir = isRtl ? TextDirection.rtl : TextDirection.ltr;

    return SessionTimeoutManager(
      sessionConfig: ref.watch(sessionConfigProvider),
      sessionStateStream: ref.watch(sessionStateStreamProvider).stream,
      child: SecurityGuard(
        child: Directionality(
          textDirection: dir,
          child: Stack(children: [AppShell(), PrivacyOverlay()]),
        ),
      ),
    );
  }
}
