import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dkb_retail/features/beneficiary/presentation/pages/add_beneficiary_transfer_page.dart';
import 'package:dkb_retail/features/beneficiary/presentation/pages/otp_approval_page.dart';
import 'package:dkb_retail/features/beneficiary/presentation/pages/view_beneficiary_transfer_page.dart';
import 'package:dkb_retail/features/charts/presentation/pages/chart_page.dart';
import 'package:dkb_retail/features/charts/presentation/pages/transaction_data_table_page.dart';
import 'package:dkb_retail/features/common/components/common_create_username_page.dart';
import 'package:dkb_retail/features/common/components/common_otp_page.dart';
import 'package:dkb_retail/features/common/components/common_set_password_page.dart';
import 'package:dkb_retail/features/common/components/user_interests_page.dart';
import 'package:dkb_retail/features/forgot_password/presentation/pages/forgot_password_create_username_screen.dart';
import 'package:dkb_retail/features/login/presentation/pages/login_page.dart';
import 'package:dkb_retail/features/login/presentation/pages/preference_page.dart';
import 'package:dkb_retail/features/onboarding/presentation/pages/basic_details/onboarding_basic_details_page.dart';
import 'package:dkb_retail/features/onboarding/presentation/pages/onboarding_account_screen.dart';
import 'package:dkb_retail/features/onboarding/presentation/pages/onboarding_document_processing_page.dart';
import 'package:dkb_retail/features/onboarding/presentation/pages/onboarding_otp_page.dart';
import 'package:dkb_retail/features/product_offering/presentation/pages/product_contact_us_page.dart';
import 'package:dkb_retail/features/product_offering/presentation/pages/product_offering_details_page.dart';
import 'package:dkb_retail/features/product_offering/presentation/pages/product_offering_page.dart';
import 'package:dkb_retail/features/registration/presentation/pages/registration_initial_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_active_card/create_username_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_active_card/registeration_otp_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_active_card/registeration_using_active_card_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_active_card/set_password_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_inactive_card.dart/create_pin_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_inactive_card.dart/registeration_using_inactive_card_page.dart';
import 'package:dkb_retail/features/registration/presentation/registration_using_inactive_card.dart/registration_card_inactive_page.dart';
import 'package:dkb_retail/features/transfer/presentation/pages/donation_transfer_page.dart';
import 'package:dkb_retail/features/transfer/presentation/pages/transaction_status_transfer_page.dart';
import 'package:dkb_retail/features/transfer/presentation/pages/transfer_page.dart';
import 'package:dkb_retail/startup/error/presentation/pages/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/accounts/presentation/pages/account_page.dart';
import '../../features/accounts/presentation/pages/accounts_page.dart';
import '../../features/common/components/terms_condition_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_completed_screen.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_new_password_screen.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_screen.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/login/domain/entities/user.dart';
import '../../features/login/presentation/pages/login_otp_screen.dart';
import '../../features/onboard/presentation/pages/onboard_page.dart';
import '../../features/onboarding/presentation/pages/basic_details/onboarding_additional_info_details_page.dart';
import '../../features/onboarding/presentation/pages/basic_details/onboarding_address_details_page.dart';
import '../../features/onboarding/presentation/pages/basic_details/onboarding_proof_address_scanning_page.dart';
import '../../features/onboarding/presentation/pages/basic_details/onboarding_work_home_address_page.dart';
import '../../features/onboarding/presentation/pages/creating_account/onboarding_account_created_page.dart';
import '../../features/onboarding/presentation/pages/creating_account/onboarding_creating_account_page.dart';
import '../../features/onboarding/presentation/pages/creating_account/onboarding_setUsername_password_page.dart';
import '../../features/onboarding/presentation/pages/financial_details/onboarding_financial_details_page.dart';
import '../../features/onboarding/presentation/pages/financial_details/onboarding_financial_info_page.dart';
import '../../features/onboarding/presentation/pages/financial_details/onboarding_prominent_form_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_details_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_identification_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_select_branch_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_verify_identification_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_verify_identify_face_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_verify_identify_selfie_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_welcome_page.dart';
import '../../features/onboarding/presentation/pages/signature/onboarding_signature_page.dart';
import '../../features/onboarding/presentation/pages/summary/onboarding_documentation_page.dart';
import '../../features/onboarding/presentation/pages/summary/onboarding_summary_page.dart';
import '../../features/onboarding/presentation/pages/tax_residency/onboarding_tax_home_country_page.dart';
import '../../features/onboarding/presentation/pages/tax_residency/onboarding_tax_othercountries_page.dart';
import '../../features/onboarding/presentation/pages/tax_residency/onboarding_tax_residency_page.dart';
import '../../features/prayer/presentation/pages/prayer_notification_page.dart';
import '../../features/prayer/presentation/pages/prayer_setting_page.dart';
import '../../features/prayer/presentation/pages/prayer_time_page.dart';
import '../../features/rates/presentation/pages/fx_rates_screen.dart';
import '../../features/rates/presentation/pages/profit_rates_screen.dart';
import '../../features/rates/presentation/pages/profit_rates_screen_new.dart';
import '../../features/reach_us/presentation/pages/book_meet_page.dart';
import '../../features/reach_us/presentation/pages/faq_screen.dart';
import '../../features/reach_us/presentation/pages/locate_us_page.dart';
import '../../features/reach_us/presentation/pages/reach_us_page.dart';
import '../../features/reach_us/presentation/pages/request_callback_page.dart';
import '../../features/reach_us/presentation/pages/social_media_page.dart';
import '../../features/transfer/data/model/beneficiary_model.dart';
import '../../features/transfer/presentation/pages/transfer_amount_page.dart';
import '../../features/welcome_back/presentation/pages/welcome_back.dart';
import '../../startup/introduction/presentation/wallet_screen.dart';
import '../../startup/splash/presentation/pages/splash_page.dart';

part 'app_router.gr.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter run --flavor dev
final routerProvider = Provider((_) => AppRouter());

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(path: '/error', page: ErrorRoute.page),
    AutoRoute(path: '/onboard', page: OnBoardRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/welcome-back', page: WelcomeBackRoute.page),

    AutoRoute(
      path: '/registration-active-card',
      page: RegisterationUsingActiveCardRoute.page,
    ),
    //AutoRoute(path: '/youTube', page: YoutubePageRoute.page),
    AutoRoute(path: '/social_web', page: SocialWebViewPageRoute.page),
    AutoRoute(
      path: '/registration-inactive-card',
      page: RegisterationUsingInactiveCardRoute.page,
    ),
    AutoRoute(path: '/registration-otp-page', page: RegisterationOtpRoute.page),
    AutoRoute(path: '/create-username', page: CreateUsernameRoute.page),
    AutoRoute(path: '/set-password', page: SetPasswordRoute.page),
    AutoRoute(path: '/user-interests', page: UserInterestsRoute.page),
    AutoRoute(path: '/user-registration', page: RegistrationStartRoute.page),
    AutoRoute(path: '/create-pin', page: CreatePinRoute.page),
    AutoRoute(path: '/common-otp-page', page: CommonOtpRoute.page),
    AutoRoute(path: '/common-password-page', page: CommonSetPasswordRoute.page),
    AutoRoute(path: '/card-inactive', page: RegistrationCardInactiveRoute.page),
    AutoRoute(
      path: '/common-create-username-page',
      page: CommonCreateUsernameRoute.page,
    ),
    // AutoRoute(path: '/product-offering-page', page: ProductOfferingRoute.page),
    CustomRoute(
      path: '/product_offering_page',
      page: ProductOfferingRoute.page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnim = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curvedAnim),
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800),
    ),
    AutoRoute(
      path: '/product-contactus-page',
      page: ProductContactUsRoute.page,
    ),
    AutoRoute(path: '/prayer-timing-screen', page: PrayerTimingsPageRoute.page),
    AutoRoute(
      path: '/prayer-time-setting-screen',
      page: PrayerTimeSettingRoute.page,
    ),
    AutoRoute(
      path: '/prayer-time-notification-screen',
      page: PrayerNotificationsPageRoute.page,
    ),
    AutoRoute(
      path: '/product-offering-details',
      page: ProductOfferingDetailsRoute.page,
    ),
    AutoRoute(path: '/forget-password-screen', page: ForgotPasswordRoute.page),
    AutoRoute(path: '/fwallet-screen', page: WalletRoute.page),
    // AutoRoute(path: '/fx-rates-screen', page: FxRatesRoute.page),
    CustomRoute(
      path: '/fx-rates-screen',
      page: FxRatesRoute.page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800),
    ),
    AutoRoute(path: '/fx-rates-screen', page: ProfitRatesRoute.page),
    // AutoRoute(path: '/fx-rates-screen-new', page: ProfitRatesPageRoute.page),
    CustomRoute(
      path: '/profit-rates-screen',
      page: ProfitRatesPageRoute.page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800),
    ),
    AutoRoute(path: '/forget-password-otp-screen', page: LoginOtpRoute.page),
    AutoRoute(
      path: '/forget-password-otp-screen',
      page: ForgetPasswordTaskCompleteRoute.page,
    ),
    AutoRoute(
      path: '/forgot-password-create-username-screen',
      page: ForgotPasswordCreateUsernameRoute.page,
    ),
    AutoRoute(path: '/set-password-screen', page: SetNewPasswordRoute.page),
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
      children: [
        AutoRoute(
          path: "dashboard",
          page: DashboardRoute.page,
          keepHistory: false,
        ),
        // AutoRoute(
        //     path: "account-dashboard-edit",
        //     page: AccountsDashboardEditRoute.page),
        // AutoRoute(path: "approvals", page: DashboardRoute.page),
        // AutoRoute(path: "my-account", page: DashboardRoute.page),
        // AutoRoute(path: "my-cards", page: DashboardRoute.page),
        // AutoRoute(path: "transfer", page: TransferRoute.page),
        // AutoRoute(
        //   path: "cards",
        //   page: CardsEmptyRoute.page,
        //   children: [
        //     AutoRoute(
        //       path: "my-cards",
        //       page: MyCardRoute.page,
        //     ),
        //     AutoRoute(
        //       path: "card-details",
        //       page: CardDetailsRoute.page,
        //     ),
        //   ],
        // ),
        // AutoRoute(
        //   path: "ExchangeRatePage.routeName",
        //   page: DashboardRoute.page,
        // ),
      ],
    ),
    // AutoRoute(
    //   path: '/accounts',
    //   page: AccountDashboardRoute.page,
    // ),
    // AutoRoute(
    //   path: '/login',
    //   page: LoginRoute.page,
    // ),
    AutoRoute(path: '/transfer-amount', page: TransferAmountRoute.page),
    AutoRoute(
      path: '/transfer-transaction',
      page: TransactionStatusTransferRoute.page,
    ),
    AutoRoute(path: '/transfer-donation', page: DonationTransferRoute.page),
    // AutoRoute(
    //   path: '/ift-transfer',
    //   page: IFTTransferRoute.page,
    // ),
    AutoRoute(path: "/add-beneficiary", page: AddBeneficiaryTransferRoute.page),
    AutoRoute(
      path: "/viewBeneficairyTransfer",
      page: ViewBeneficiaryTransferRoute.page,
    ),
    AutoRoute(path: "/fund_transfer_otp", page: OtpApprovalRoute.page),
    AutoRoute(path: '/preference', page: PreferenceRoute.page),
    AutoRoute(path: '/chart', page: ChartRoute.page),
    AutoRoute(path: '/trans-chart', page: TransactionDataTableRoute.page),
    AutoRoute(path: '/account-page', page: AccountsRoute.page),
    AutoRoute(path: '/account-page', page: AccountRoute.page),
    AutoRoute(path: '/casa_account_screen', page: OnboardingAccountRoute.page),
    AutoRoute(path: '/welcome-message-page', page: OnboardingWelcomeRoute.page),
    AutoRoute(
      path: '/details-onboarding-page',
      page: OnboardingDetailsRoute.page,
    ),
    AutoRoute(path: '/otp-onboarding-page', page: OnboardingOtpRoute.page),
    AutoRoute(
      path: '/onboarding-select-branch-page',
      page: OnboardingSelectBranchRoute.page,
    ),
    AutoRoute(
      path: '/onboarding-identification-page',
      page: OnboardingIdentificationRoute.page,
    ),

    AutoRoute(
      path: '/onboarding-verify-identify-page',
      page: OnboardingVerifyIdentificationRoute.page,
    ),
    AutoRoute(
      path: '/onboarding-verify-identify-page',
      page: OnboardingVerifyIdentifySelfieRoute.page,
    ),
    AutoRoute(
      path: '/onboarding-verify-identify-page',
      page: OnboardingVerifyIdentifyFaceRoute.page,
    ),
    AutoRoute(
      path: '/basic_details-page',
      page: OnboardingBasicDetailsRoute.page,
    ),
    AutoRoute(
      path: '/terms-&-condition-page',
      page: TermsAndConditionsRoute.page,
    ),
    // AutoRoute(path: '/reach_us-page', page: ReachUsPageRoute.page),
    CustomRoute(
      path: '/reach_us-page',
      page: ReachUsPageRoute.page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;
        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 800),
      reverseDuration: Duration(milliseconds: 800),
    ),
    AutoRoute(path: '/locate_us-page', page: LocateUsPageRoute.page),
    AutoRoute(path: '/faq_screen', page: FaqScreenRoute.page),
    AutoRoute(path: '/bookAndMeet', page: BookAndMeetPageRoute.page),
    AutoRoute(path: '/requestCallback', page: RequestCallbackPageRoute.page),
    AutoRoute(
      path: '/additional_details-page',
      page: OnboardingAdditionalInfoDetailsRoute.page,
    ),
    AutoRoute(
      path: '/address_details-page',
      page: OnboardingAddressDetailsRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_proof_address-scanning',
      page: OnboardingProofAddressScanningRoute.page,
    ),

    AutoRoute(
      path: '/onboarding_work_home_address_page',
      page: OnboardingWorkHomeAddressRoute.page,
    ),
    AutoRoute(page: OnboardingFinancialDetailsRoute.page),
    AutoRoute(
      path: '/onboarding_prominent_form_page',
      page: OnboardingProminentFormRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_tax_residency_page',
      page: OnboardingTaxResidencyRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_tax_otherCountries_page',
      page: OnboardingTaxOtherCountriesRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_tax_home_country_page',
      page: OnboardingTaxHomeCountryRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_summary_page',
      page: OnboardingSummaryRoute.page,
    ),

    AutoRoute(
      path: '/onboarding_documentation_page',
      page: OnboardingDocumentationRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_documentation_page',
      page: OnboardingSignatureRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_Creating_Account_page',
      page: OnboardingCreatingAccountRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_setUsername_password_page',
      page: OnboardingSetUsernamePasswordRoute.page,
    ),
    AutoRoute(
      path: '/onboarding_account_created_page',
      page: OnboardingAccountCreatedRoute.page,
    ),
  ];
}

@RoutePage()
class PlaceholderPage extends StatelessWidget {
  final String label;

  const PlaceholderPage({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Center(child: Text(label)),
    );
  }
}

@RoutePage(name: 'ScreenBlurOverlayWrapper')
class ScreenBlurOverlayWrapperPage extends StatelessWidget {
  const ScreenBlurOverlayWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBlurOverlay(child: BackGroundVisibilityController());
  }
}

class BackGroundVisibilityController extends StatefulWidget {
  const BackGroundVisibilityController({super.key});

  @override
  State<BackGroundVisibilityController> createState() =>
      _BackGroundVisibilityControllerState();
}

class _BackGroundVisibilityControllerState
    extends State<BackGroundVisibilityController>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      ScreenBlurOverlay.of(context).disable();
    } else {
      ScreenBlurOverlay.of(context).enable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

abstract interface class BlurController {
  bool get enabled;

  void enable();

  void disable();
}

class ScreenBlurOverlay extends StatefulWidget {
  final Widget child;

  const ScreenBlurOverlay({required this.child, super.key});

  static BlurController of(BuildContext context) => context
      .getInheritedWidgetOfExactType<_InheritedScreenBlurOverlay>()!
      .controller;

  @override
  State<ScreenBlurOverlay> createState() => _ScreenBlurOverlayState();
}

class _ScreenBlurOverlayState extends State<ScreenBlurOverlay>
    implements BlurController {
  bool _enabled = false;

  @override
  void enable() {
    if (_enabled) {
      return;
    }

    setState(() {
      _enabled = true;
    });
  }

  @override
  void disable() {
    if (!_enabled) {
      return;
    }

    setState(() {
      _enabled = false;
    });
  }

  @override
  bool get enabled => _enabled;

  @override
  Widget build(BuildContext context) {
    return _InheritedScreenBlurOverlay(
      controller: this,
      child: Stack(
        children: [
          widget.child,
          (() {
            return const SizedBox();
          })(),
          // Center(child: Text(_enabled.toString())),
          if (_enabled) ...[
            (() {
              return const SizedBox();
            })(),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            // Image.asset(
            //   'assets/splash_screen.png',
            //   fit: BoxFit.fill,
            // ),
          ],
        ],
      ),
    );
  }
}

class _InheritedScreenBlurOverlay extends InheritedWidget {
  final BlurController controller;

  const _InheritedScreenBlurOverlay({
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedScreenBlurOverlay oldWidget) => false;
}
