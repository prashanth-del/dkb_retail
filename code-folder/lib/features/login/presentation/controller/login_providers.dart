import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/cache/global_cache.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';

final addUserFormKey = GlobalKey<FormState>();
final primaryLoginFormKey = GlobalKey<FormState>();

final GlobalKey<ScaffoldState> primaryLoginScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> switchUserScaffoldKey =
    GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> addUserScaffoldKey = GlobalKey<ScaffoldState>();

final loadingProvider = StateProvider<bool>((ref) => false);
final loginObscureProvider = StateProvider<bool>((ref) => true);
final addUserObscureProvider = StateProvider<bool>((ref) => true);
final primaryLoginObscureProvider = StateProvider<bool>((ref) => true);

final consentSeenProvider = StateProvider<bool>((ref) {
  final isSeen = GlobalCache.instance.isConsentSeen();
  return isSeen;
});

final preferenceSeenProvider = StateProvider<bool>((ref) {
  final isSeen = GlobalCache.instance.isPreferenceSeen();
  return isSeen;
});

final localUsernameProvider = StateProvider<String>((ref) {
  final username = GlobalCache.instance.getUsername();
  return username;
});

final selectedLangFlagProvider = StateProvider<String>((ref) {
  final flag = GlobalCache.instance.getSelectedLangFlag();
  return flag;
});

final changePWdSeenProvider = StateProvider<bool>((ref) {
  final isSeen = GlobalCache.instance.isChangePwdSeen();
  return isSeen;
});

final passwordTextVisibleProvider = StateProvider<bool>((ref) {
  return false;
});

final selectedLanguageProvider = StateProvider<int>((ref) {
  // final defaultLang = ref.watch(localePodProvider).languageCode;
  // if (defaultLang == "en") {
  //   return 1;
  // } else if (defaultLang == "ar") {
  //   return 0;
  // }
  return 0;
});

final otpLengthProvider = StateProvider<int>((ref) => 6);

final canLocaleSkipProvider = StateProvider<bool>((ref) => false);

const forgetPwdUrl =
    "https://dbankonline.dohabank.com.qa/doha/corpforgotpassword/default.aspx";

//forget password card providers

final forgetPasswordDebitCardPinProvider = StateProvider<String>((ref) => "");
