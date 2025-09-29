import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenTrackingObserver extends AutoRouterObserver {
  final ProviderRef ref;

  ScreenTrackingObserver(this.ref);

  String screenNameProvider = "";
  String screenPathProvider = "";

  String get currentScreenName => screenNameProvider;
  String get currentPathName => screenPathProvider;

  @override
  void didPush(Route route, Route? previousRoute) {
    _setCurrentScreenName(route);
    _setCurrentPathName(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _setCurrentScreenName(previousRoute);
    _setCurrentPathName(previousRoute);
    super.didPop(route, previousRoute);
  }

  void _setCurrentScreenName(Route? route) {
    if (route != null && route.settings.name != null) {
      log("Current screen name = ${route.settings.name}");
      screenNameProvider = route.settings.name!.replaceAll('/', '');
    }
  }

  void _setCurrentPathName(Route? route) {
    if (route != null && route.data != null) {
      log("Current path name = ${route.data!.path}");
      screenPathProvider = route.data!.path.replaceAll('/', '');
    }
  }
}

final screenTrackingObserverProvider = Provider((ref) => ScreenTrackingObserver(ref));


