import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_body.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../../core/router/app_router.dart';
import '../../../common/presentation/dialog/ui_dialogs.dart';
import '../../../onboarding/presentation/controller/notifier/onboarding_block_check_notifier.dart';
import '../../../onboarding/presentation/controller/notifier/onboarding_stage_sum_notifier.dart';
import '../../../onboarding/presentation/provider/onboarding_provider.dart';
import '../controller/login_providers.dart';
import '../widgets/login_app_bar.dart';

/// Login Page with username & password authentication
@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isBlockCheckVerified = false;
  bool _isGetStageData = false;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    ref.watch(i18nAssetNotifierProvider);

    /// Listen for onboarding block verification
    ref.listen(getOnboardingBlockCheckNotifierProvider, (previous, next) {
      if (!_isBlockCheckVerified) {
        next.maybeWhen(
          data: (data) {
            if (data.isblocked == "false") {
              _isBlockCheckVerified = true;
              context.router.push(const OnboardingAccountRoute());
            }
          },
          error: (error, _) => UiDialogs.showErrorDialog(
            context: context,
            description: "$error",
            bknOkPressed: () => context.router.maybePop(),
          ),
          orElse: () {},
        );
      }
    });

    /// Listen for onboarding stage data
    ref.listen(getOnboardingStageSumNotifierProvider, (previous, next) {
      if (!_isGetStageData) {
        next.maybeWhen(
          data: (data) {
            _isGetStageData = true;
            ref.read(stageSumProvider.notifier).state = data.stageData;
          },
          error: (error, _) => UiDialogs.showErrorDialog(
            context: context,
            description: "$error",
            bknOkPressed: () => context.router.maybePop(),
          ),
          orElse: () {},
        );
      }
    });

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return PopScope(
      canPop: false,
      child: UiProgressHud(
        inAsyncCall: isLoading,
        progressIndicator: UiLoader(
          loadingText: DefaultString.instance.loading,
          // ref.getLocaleString(
          //   "Loading",
          //   defaultValue: "Loading...",
          // ),
        ),

        child: Scaffold(
          //floatingActionButton: RashidWidget(),
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetPath.image.Loginbackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Lottie.asset(
                  AssetPath.lottie.animatedCircleBg,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.015,
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoginAppBar(),
                          LoginBody(),
                          SizedBox(height: size.height * 0.1),
                          loginBottomBar(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
