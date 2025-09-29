import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/features/login/domain/entities/user.dart';
import 'package:dkb_retail/features/login/presentation/widgets/login_bottom_bar.dart';
import 'package:dkb_retail/features/rashid/presentation/pages/rashid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/i18n/controller/i18n_notifiers.dart';
import '../../../../core/router/app_router.dart';
import '../../../../network/network_client_provider.dart';
import '../../../common/components/dialogs.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../../../onboarding/presentation/controller/notifier/onboarding_block_check_notifier.dart';
import '../../../onboarding/presentation/controller/notifier/onboarding_stage_sum_notifier.dart';
import '../../../onboarding/presentation/provider/onboarding_provider.dart';
import '../controller/login_providers.dart';
import '../controller/state/login_notifiers.dart';
import '../widgets/login_app_bar.dart';
import '../widgets/login_form.dart';
import '../widgets/prayer_time.dart';

/// Login Page with username & password authentication
@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late FocusNode username, password, logIn;

  bool _isBlockCheckVerified = false;
  bool _isGetStageData = false;

  @override
  void initState() {
    super.initState();
    username = FocusNode();
    password = FocusNode();
    logIn = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginFormKey.currentState?.reset();
    });
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    logIn.dispose();
    super.dispose();
  }

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

    /// Listen for login state changes
    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) async {
          _resetForm();
          showErrorDialog(message, context, ref);
        },
        success: (user) async {
          _resetForm();
          _handleLoginSuccess(user);
        },
        orElse: () {},
      );
    });

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
          floatingActionButton: rashid(context),
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetPath.image.background),
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
                      padding: const EdgeInsets.only(
                        bottom: 30,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: LoginAppBar(),
                          ),
                          _buildBody(),
                          Spacer(),
                          loginBottomBar(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds main page content
  Widget _buildBody() {
    final isPasswordVisible = ref.watch(passwordTextVisibleProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const UiSpace.vertical(70),
          const PrayerTimeWidget(),
          const UiSpace.vertical(50),
          LoginFormWidget(
            loginFormKey: loginFormKey,
            userController: userController,
            passwordController: passwordController,
            isPasswordVisible: isPasswordVisible,
            onTogglePassword: () =>
                ref.read(passwordTextVisibleProvider.notifier).state =
                    !isPasswordVisible,
            onLoginPressed: _handleLoginPressed,
            onRegisterPressed: _handleRegisterPressed,
          ),
        ],
      ),
    );
  }

  /// Resets text controllers & form state
  void _resetForm() {
    userController.clear();
    passwordController.clear();
    loginFormKey.currentState?.reset();
  }

  /// Handles successful login flow
  void _handleLoginSuccess(User user) {
    context.router.push(LoginOtpRoute(userdetail: user));
  }

  /// Validates & processes login button press
  Future<void> _handleLoginPressed() async {
    if (userController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      showErrorDialog("Username and Password cannot be empty.", context, ref);

      return;
    }
    FocusScope.of(context).unfocus();

    final form = loginFormKey.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      //context.router.replace(HomeRoute(shouldInit: true));

      //login Logic if api are working

      final token = ref.read(authTokenProvider);
      if (token != null) {
        ref.read(authTokenProvider.notifier).state = null;
      }

      await ref
          .read(loginNotifierProvider.notifier)
          .signInWithUsernamePassword(
            customerId: "1207026",
            username: userController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }

  /// Handles register button press
  Future<void> _handleRegisterPressed() async {
    // _isBlockCheckVerified = false;
    // _isGetStageData = false;

    // await ref.read(getOnboardingBlockCheckNotifierProvider.notifier).fetch();
    // await ref.read(getOnboardingStageSumNotifierProvider.notifier).fetch();

    context.router.push(RegistrationStartRoute());
  }
}
