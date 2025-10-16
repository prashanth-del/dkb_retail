import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/common/presentation/dialog/custom_sheet.dart';
import 'package:dkb_retail/features/login/presentation/widgets/registration_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../../../core/cache/global_cache.dart';
import '../../../../core/constants/app_strings/default_string.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/session_manager/session_manager.dart';
import '../../../../network/network_client_provider.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request_request_info_dto.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import '../../../common/domain/locators/common_locators.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../../../common/presentation/dialog/custom_sheet.dart';
import '../../domain/entities/sign_with_credentials_entity/login_response.dart';
import '../controller/login_providers.dart';
import '../controller/state/login_notifiers.dart';
import 'login_form.dart';
import 'prayer_time.dart';

class LoginBody extends ConsumerStatefulWidget {
  const LoginBody({super.key});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends ConsumerState<LoginBody> {
  //variables
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late FocusNode username, password, logIn;

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
    //providers
    final isPasswordVisible = ref.watch(passwordTextVisibleProvider);

    /// Listen for login state changes
    ref.listen(loginNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) async {
          _resetForm();
          showErrorDialog(message, context, ref);
        },
        success: (user) async {
          _resetForm();
          _handleLoginSuccess(user!);
        },
        orElse: () {},
      );
    });

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const PrayerTimeWidget(),
          const UiSpace.vertical(30),
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
  void _handleLoginSuccess(LoginResponse user) {
    // context.router.push(RegisterationOtpRoute());
    context.router.push(
      CommonOtpRoute(
        generateOtpBefore: true,
        onGenerateOtp: (payload) async {
          final request = GenerateOtpRequest(
            requestInfo: GenerateOtpRequestRequestInfoDto(
              action: "login",
              mobileNumber: "+97433333335",
            ),
          );
          ref.read(commonRepositoryProvider).generateOtp(request: request);
        },
        title: DefaultString.instance.enterOtp,
        description: DefaultString.instance.otpReceiveMessage,
        otpLength: 6,
        timerDuration: const Duration(seconds: 15),
        onVerify: (otp) async {
          final request = ValidateOtpRequest(
            requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
          );
          final result = await ref
              .read(commonRepositoryProvider)
              .validateOtp(request: request);

          result.fold(
            (failure) =>
                showErrorDialog(failure.description.toString(), context, ref),
            (otpValidate) {
              if (mounted) {
                context.router.popAndPush(DashboardRoute());
              }
            },
          );
        },
        onCompleted: (otp) async {
          final request = ValidateOtpRequest(
            requestInfo: ValidateOtpRequestRequestInfoDto(otp: otp),
          );
          final result = await ref
              .read(commonRepositoryProvider)
              .validateOtp(request: request);

          result.fold(
            (failure) =>
                showErrorDialog(failure.description.toString(), context, ref),

            (otpValidate) {
              if (mounted) {
                context.router.popAndPush(DashboardRoute());
              }
            },
          );
        },
        suffixTap: () {
          context.router.replaceAll([LoginRoute()]);
        },
        onResend: () async {
          final request = GenerateOtpRequest(
            requestInfo: GenerateOtpRequestRequestInfoDto(
              action: "login",
              mobileNumber: "+97433333335",
            ),
          );
          ref.read(commonRepositoryProvider).generateOtp(request: request);
        },
        verifyButtonLabel: DefaultString.instance.verify,
        // nextRouteName: CreateUsernameRoute(),
      ),
    );
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
          .signWithUsernamePassword(
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

    // context.router.push(RegistrationStartRoute());
    CustomSheet.show(
      context: context,
      isDismissible: true,
      child: RegistrationBottomsheet(),
    );
  }
}
