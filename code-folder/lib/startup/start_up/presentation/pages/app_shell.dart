import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:async_ui/async_ui.dart';
import 'package:db_uicomponents/components.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../../core/i18n/controller/i18n_providers.dart';
import '../../../../core/i18n/localization.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/observers/screen_tracking_observer.dart';
import '../../../../core/theme/controller/theme_providers.dart';
import '../../../../network/network_client_provider.dart';
import '../../../../core/constants/app_strings/default_string.dart';


class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(networkClientProvider);
    final router = ref.read(routerProvider);
    final themeCfg = ref.watch(themeConfigProvider);
    final themeMode = ref.watch(themeModeProvider);
    print(
      "materiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiialRooooooooooooooooooooooooooot",
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(
          navigatorObservers: () => [ref.read(screenTrackingObserverProvider)],
        ),

        theme: themeCfg.lightTheme,
        darkTheme: themeCfg.darkTheme,
        themeMode: themeMode,

        // I18N
        localizationsDelegates: [
          ...GlobalMaterialLocalizations.delegates,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          ref.watch(appLocalizationDelegateProvider),
        ],
        supportedLocales: localeIds.map((id) => Locale(id)).toList(),
        locale: ref.watch(localePodProvider),

        /// Optional: global i18n change trigger so DefaultString.instance.* updates
        // builder: (context, child) {
        //   return Consumer(
        //     builder: (context, ref, _) {
        //       ref.watch(i18nAssetNotifierProvider);
        //       return child ?? const SizedBox.shrink();
        //     },
        //   );
        // },
          builder: (context, child) {
          /// Optional: global i18n change trigger so DefaultString.instance.* updates
          ref.watch(i18nAssetNotifierProvider);
          return LockOverlayTheme(
            data: LockOverlayThemeData(
              barrierColor: Colors.black.withOpacity(0.30),
              absorbTaps: true,
              allowBackWhileLocked: false,
              overlayBuilder: (ctx, _) => UiLoader.blocking(
                loadingText: DefaultString.instance.loading,
                backdropBlur: 2.0,
                absorb: false, // GlobalLockUI already blocks taps
              ),
            ),
            child: GlobalLockUI(
              child: SafeArea(top: false,child: child ?? const SizedBox.shrink()),
            ),
          );
        },
      ),
    );
  }
}
