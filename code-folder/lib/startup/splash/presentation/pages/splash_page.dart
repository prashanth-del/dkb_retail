import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:dkb_retail/startup/splash/presentation/widgets/boot_gate.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../features/login/presentation/controller/login_providers.dart';
import '../widgets/splash_view.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goNext() {
      final isPrefSeen = ref.read(preferenceSeenProvider);
      final localUsername = ref.read(localUsernameProvider);
      if (isPrefSeen) {
        context.router.replace(
          localUsername.isEmpty ? LoginRoute() : WelcomeBackRoute(),
        );
      } else {
        context.router.replace(const WalletRoute());
      }
    }

    void goError(String why) {
      context.router.replace(
        ErrorRoute(errorTitle: 'Startup error', errorDesc: why),
      );
    }

    return Scaffold(
      backgroundColor: context.color.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const SplashView(
            fadeDelay: Duration(milliseconds: 4200),
            fadeDuration: Duration(milliseconds: 4000),
          ),
          BootGate(
            onReady: goNext,
            onError: goError,
            minSplashTime: const Duration(milliseconds: 5930),
          ),
        ],
      ),
    );
  }
}
