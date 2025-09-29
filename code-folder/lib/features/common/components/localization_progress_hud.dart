import 'dart:io';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/asset_path/asset_path.dart';
import '../../../core/i18n/controller/i18n_providers.dart';

class LocalizationProgressHud extends ConsumerWidget {
  final Widget child;
  final bool canSkip;

  const LocalizationProgressHud({
    super.key,
    required this.child,
    this.canSkip = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationState = ref.watch(appLocalizationState);

    // Listen to localization state changes
    ref.listen<AppLocalizationState>(appLocalizationState, (previous, state) {
      if (state == AppLocalizationState.error) {
        // Show toast message for error
        UiToast().showFlagMsg(
          context: context,
          msg: ref.getLocaleString(
            "Unable_to_change_language, please_try again_later",
            defaultValue: "Unable to change language, please try again later",
          ),
          level: ToastLevel.error,
        );
        UIPopupDialog().showPopup(
          viewModel: UIPopupViewModel(
            image: AssetPath.svg.error,
            context: context,
            closeIcon: canSkip,
            barrierDismissible: false,
            title: ref.getLocaleString(
              "Server_Error!",
              defaultValue: "Server Error!",
            ),
            content: ref.getLocaleString(
              "Unable_to_reach_server. Please_try_again_after_sometime.",
              defaultValue:
                  "Unable to reach server. Please try again after sometime",
            ),
            buttonText: ref.getLocaleString("Exit", defaultValue: "Exit"),
            onButtonPressed: () {
              exit(0);
            },
            onClosePressed: () {
              // ref.read(appLocalizationState.notifier).state =
              //     AppLocalizationState.initial;
              exit(0);
            },
          ),
        );
      }
    });

    return UiProgressHud(
      inAsyncCall: localizationState == AppLocalizationState.loading,
      progressIndicator: UiLoader(
        loadingText: ref.getLocaleString("Loading", defaultValue: "Loading..."),
      ),
      child: Stack(
        children: [
          child,
          // Check cmt #1 for previous UI Popup below is the code..
        ],
      ),
    );
  }
}

//Cmt #1 :- Previous UI pop up display
// if(localizationState ==  AppLocalizationState.error)
// UIPopup(
//     image: AssetPath.svg.error,
//     closeIcon: canSkip,
//     title: "Server Error!",
//     content: "Unable to reach server. Please try again after sometime.",
//     buttonText: 'Exit',
//     onButtonPressed: () {
//       exit(0);
//     },
//     onClosePressed: () {
//       ref.read(appLocalizationState.notifier).state =
//           AppLocalizationState.initial;
//       context.maybePop();
//     });

// end cmt #1
