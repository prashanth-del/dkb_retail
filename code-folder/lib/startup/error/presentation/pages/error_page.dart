import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/constants/asset_path/asset_path.dart';

@RoutePage()
class ErrorPage extends ConsumerWidget {
  final String? errorTitle;
  final String? errorDesc;
  const ErrorPage({super.key, this.errorTitle, this.errorDesc});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: DefaultColors.skyBlue,
        appBar: UIAppBar.secondary(title: DefaultString.instance.error, autoLeadingWidget: null),
        body: Center(
          child: UINoContent(
            lottieAsset: AssetPath.lottie.empty,
            animHeight: 30,
            title: errorTitle ?? DefaultString.instance.securityError,
            description: errorDesc ?? DefaultString.instance.securityDesc,
            actionButton: UIButton.primary(
              onPressed: () {
                exit(0);
              },
              isRoundedButton: true,
              label: DefaultString.instance.exit,
            ),
          ),
        ),
      ),
    );
  }
}
