import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../../network/network_client_provider.dart';
import '../../router/app_router.dart';

final sessionStateStreamProvider = Provider(
  (_) {
    return StreamController<SessionState>()
      ..add(
        SessionState.stopListening,
      );
  },
);

final sessionConfigProvider = Provider((ref) {
  final sessionConfig = SessionConfig(
    invalidateSessionForAppLostFocus: const Duration(seconds: 240),
    invalidateSessionForUserInactivity: const Duration(seconds: 240),
  );

  sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
    if (timeoutEvent == SessionTimeoutState.userInactivityTimeout ||
        timeoutEvent == SessionTimeoutState.appFocusTimeout) {
      final navigatorContext =
          ref.read(routerProvider).navigatorKey.currentContext!;
      final timer = Timer(const Duration(seconds: 60), () async {
        final initLogout = ref.read(initLogoutProvider);
        if (!initLogout) {
          ref.read(initLogoutProvider.notifier).markTried();
          // await ref.read(loginNotifierProvider.notifier).logout();
          ref.read(initLogoutProvider.notifier).reset();
          ref.read(sessionStateStreamProvider).add(SessionState.stopListening);
          navigatorContext.router.popUntil((route) => route.isFirst);
        }
      });

      // todo: Redesign popup ui
      showDialog(
        context: ref.read(routerProvider).navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.orangeAccent,
                  size: 80,
                ),
                UiTextNew.b1Regular(
                  'Session Expire',
                  // ref
                  //     .watch(appLocalizationProvider)
                  //     .getString("Session_Expiration_Message"),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              OutlinedButton(
                onPressed: () {
                  context.router.maybePop();
                },
                child: Text(
                  'Continue',
                  // ref.watch(appLocalizationProvider)
                  //     .getString("Continue_Button")),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final initLogout = ref.read(initLogoutProvider);
                  if (!initLogout) {
                    ref.read(initLogoutProvider.notifier).markTried();
                    // await ref.read(loginNotifierProvider.notifier).logout();
                    ref.read(initLogoutProvider.notifier).reset();
                    ref
                        .read(sessionStateStreamProvider)
                        .add(SessionState.stopListening);
                    navigatorContext.router.popUntil((route) => route.isFirst);
                  }
                },
                child: Text(
                  // ref.watch(appLocalizationProvider).getString("Logout")),
                  "Logout",
                ),
              ),
            ],
          );
        },
      ).then((_) => timer.cancel());
    }
  });

  return sessionConfig;
});
