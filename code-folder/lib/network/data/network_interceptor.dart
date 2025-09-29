import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dio/dio.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/cache/global_cache.dart';
import '../../core/cache/locale_cache.dart';
import '../../core/constants/asset_path/asset_path.dart';
import '../../core/router/app_router.dart';
import '../../core/services/session_manager/session_manager.dart';
import '../../core/utils/method_channel/custom_method_channel.dart';
import '../../startup/start_up/domain/entity/security_threat.dart';
import '../../startup/start_up/provider/dialog_provider.dart';
import '../domain/models/api_dio_exception.dart';
import '../domain/models/api_error.dart';
import '../domain/models/api_unauthenticated_error.dart';
import '../network_client_provider.dart';
import 'cookie_manager.dart';

class NetworkInterceptor implements Interceptor {
  final CookieManager cookieManager;
  final ProviderRef ref;

  NetworkInterceptor(this.cookieManager, this.ref);

  InterceptorsWrapper get interceptorsWrapper => InterceptorsWrapper(
        onRequest: onRequest,
        onResponse: onResponse,
        onError: onError,
      );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final initLogout = ref.read(initLogoutProvider);
    final localeId = LocaleCache.instance.getLocaleId(); // en or ar
    // todo: get unit and Accept-Language from cache dynamically.
    final commonHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'charset': 'utf-8',
      'Accept-Language': options.headers['Accept-Language'] ?? localeId,
      'channel': 'MB',
      'unit': 'PRD',
    };

    options.headers.addAll({
      'cookie': cookieManager.generateCookieHeader(),
    });

    // if (options.uri.path
    //         .endsWith('/common-service/common/txnMetricsByService') ||
    //     options.uri.path
    //         .endsWith('/common-service/common/txnMetricsPieChart')) {
    //   commonHeaders['channel'] = 'MB';
    // }

    options.headers.addAll(commonHeaders);

    bool isVpnConnected = false;
    if (Platform.isAndroid) {
      isVpnConnected = await UiDeviceSecurityChecker.isVpnConnected();
    } else {
      // DeviceSecurityService deviceSecurityService = DeviceSecurityService();
      // isVpnConnected = await deviceSecurityService.detectIosVpn();
    }

    if (isVpnConnected) {
      final context = ref.read(routerProvider).navigatorKey.currentContext!;
      if (ref.watch(isDialogHappened)) return;
      ref.read(isDialogHappened.notifier).state = true;
      await UIPopupDialog()
          .showPopup(
        viewModel: UIPopupViewModel(
            image: AssetPath.svg.error,
            context: context,
            barrierDismissible: false,
            title: "Error",
            content: getMessage(
                securityThreat: const SecurityThreat.vpnDetected(),
                localeId: localeId),
            buttonText: "Exit",
            onButtonPressed: () {
              exit(0);
            },
            onClosePressed: () {
              exit(0);
            }),
      )
          .then((val) {
        ref.read(isDialogHappened.notifier).state = false;
      });
      return;
    }

    if (options.data != null && _encRequired(uri: options.uri.path)) {
      consoleLog('Normal Data : ${options.data}');
      var encryptedData =
          await _encryptPayload(payload: jsonEncode(options.data));
      consoleLog('Encrypted Data : $encryptedData');
      options.data = encryptedData;
    }

    final accessToken = ref.watch(authTokenProvider);

    // if (accessToken != null) {
    //   if (accessToken.isAccessTokenExpired &&
    //       !options.uri.path.endsWith("/logout")) {
    //     handler.next(options);
    //
    //     Timer(const Duration(seconds: 1), () async {
    //       if (initLogout) return;
    //
    //       UiToast().showToast('Session expired');
    //       final navigator = ref.read(routerProvider).navigatorKey.currentState!;
    //       final logoutStatus = ref.watch(logoutStatusProvider);
    //
    //       if (logoutStatus == LogoutStatus.ideal && !initLogout) {
    //         ref.read(initLogoutProvider.notifier).markTried();
    //
    //         await ref.read(loginNotifierProvider.notifier).logout();
    //
    //         if (logoutStatus == LogoutStatus.success) {
    //           ref.read(initLogoutProvider.notifier).reset();
    //         }
    //
    //         ref
    //             .read(sessionStateStreamProvider)
    //             .add(SessionState.stopListening);
    //         navigator.popUntil((route) => route.isFirst);
    //       }
    //     });
    //     return;
    //   }
    // }

    // final logMessage = 'REQUEST[${options.method}] => PATH: ${options.path}\n'
    //     'Headers: ${options.headers}\n'
    //     'Data: ${options.data}';
    // await _storeLog(logMessage);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // if (!response.realUri.path.endsWith("auth-service/auth/v1/public/rp")) {
    //   cookieManager.updateCookie(response);
    // }
    cookieManager.updateCookie(response);
    if (kDebugMode) {
      consoleLog('Response : ${response.data}');
    }

    // 1) Decrypt (if required) -> String JSON
    if (response.data != null && _encRequired(uri: response.realUri.path)) {
      consoleLog('Response Data before decrypt: ${response.data}');
      final decrypted = await _decryptPayload(payload: jsonEncode(response.data));
      consoleLog('after native debug Data : $decrypted');
      if (decrypted != null && decrypted.isNotEmpty) {
        // IMPORTANT: decode to structured JSON
        response.data = jsonDecode(decrypted);
      }
    }

    // 2) Normalize non-encrypted responses too
    response.data = _normalizeJson(response.data);

    // final logMessage = 'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}\n'
    //     'Data: ${response.data}';
    // await _storeLog(logMessage);

    handler.next(response);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    final initLogout = ref.read(initLogoutProvider);

    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      UiToast().showToast('No internet connection');
      return handler.next(DioException(
        requestOptions: error.requestOptions,
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      ));
    }

    final response = error.response;
    // if (response != null &&
    //     (response.statusCode == HttpStatus.unauthorized ||
    //         response.statusCode == 401)) {
    //   if (!response.realUri.path.endsWith("/logout")) {
    //     final navigator = ref.read(routerProvider).navigatorKey.currentState!;
    //     final logoutStatus = ref.watch(logoutStatusProvider);
    //
    //     if (logoutStatus == LogoutStatus.ideal && !initLogout) {
    //       ref.read(initLogoutProvider.notifier).markTried();
    //
    //       await ref.read(loginNotifierProvider.notifier).logout();
    //
    //       if (logoutStatus == LogoutStatus.success) {
    //         ref.read(initLogoutProvider.notifier).reset();
    //         ref
    //             .read(sessionStateStreamProvider)
    //             .add(SessionState.stopListening);
    //         navigator.popUntil((route) => route.isFirst);
    //       }
    //     }
    //     return handler.next(DioException(
    //       requestOptions: error.requestOptions,
    //       error: 'Session Expired',
    //       type: DioExceptionType.badResponse,
    //     ));
    //   } else {
    //     final navigator = ref.read(routerProvider).navigatorKey.currentState!;
    //     ref.read(initLogoutProvider.notifier).reset();
    //     ref.read(sessionStateStreamProvider).add(SessionState.stopListening);
    //     navigator.popUntil((route) => route.isFirst);
    //     return handler.next(DioException(
    //       requestOptions: error.requestOptions,
    //       error: 'Session Expired',
    //       type: DioExceptionType.badResponse,
    //     ));
    //   }
    // }

    if (response != null && response.data is Map) {
      ApiDioException apiError = ApiDioException(
          requestOptions: error.requestOptions,
          error: ApiError.fromJson(response.data),
          response: error.response,
          type: error.type);
      switch (response.statusCode) {
        case HttpStatus.unauthorized:
          return handler.next(ApiUnAuthenticatedError(
              requestOptions: error.requestOptions,
              error: ApiError.fromJson(response.data),
              response: error.response,
              type: error.type));
        case HttpStatus.notFound:
          return handler.next(ApiNotFoundError(
              requestOptions: error.requestOptions,
              error: ApiError.fromJson(response.data),
              response: error.response,
              type: error.type));
        default:
          return handler.next(apiError);
      }
    }
    // final logMessage = 'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}\n'
    //     'Message: ${error.message}';
    // await _storeLog(logMessage);
    handler.next(error);
  }

  Future<void> _storeLog(String log) async {
    try {
      // Get the app-specific document directory
      final directory = await getApplicationDocumentsDirectory();
      final logFilePath = '${directory.path}/app_logs.txt';
      final file = File(logFilePath);

      // Check if the file exists, create it if it doesn't
      if (!await file.exists()) {
        await file.create(
            recursive: true); // This creates the file if it doesn't exist
      }

      // Get current timestamp
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // Append log to the file
      await file.writeAsString('$formattedDate: $log\n', mode: FileMode.append);

      consoleLog('Log stored at: $logFilePath');
    } catch (e) {
      consoleLog('Error storing log: $e');
    }
  }

  Future<String?> _encryptPayload({required String payload}) async {
    final dbComponentsPlugin = DbChannel();
    Map<String, String> toEncrypt = {'payLoad': payload};
    late final String? encryptedPayload;
    try {
      if (Platform.isIOS) {
        encryptedPayload =
            await CustomMethodChannel().encryptCode(toEncrypt: toEncrypt);
      } else {
        encryptedPayload =
            await dbComponentsPlugin.encrypt(toEncrypt: toEncrypt);
      }
    } catch (e) {
      consoleLog('Error in encryption : $e');
    }
    return encryptedPayload;
  }

  Future<String?> _decryptPayload({required String payload}) async {
    final dbComponentsPlugin = DbChannel();
    Map<String, String> toDecrypt = {'payLoad': payload};
    late final String? decryptedPayLoad;
    try {
      if (Platform.isIOS) {
        decryptedPayLoad =
            await CustomMethodChannel().decryptPayload(toDecrypt: toDecrypt);
      } else {
        decryptedPayLoad =
            await dbComponentsPlugin.decryptPayLoad(toDecrypt: toDecrypt);
      }
    } catch (e) {
      consoleLog('Error in encryption : $e');
    }
    return decryptedPayLoad;
  }
}

bool _encRequired({required String uri}) {
  bool retVal = false;
  var isEncEnabled = GlobalCache.instance.getEncFlag();
  if (isEncEnabled == "Y" &&
      !uri.endsWith("/public/rp") &&
      !uri.endsWith("/common/labels") &&
      !uri.endsWith("/common-service/common/banner") &&
      !uri.endsWith("/auth/v1/user/forceupdate") &&
      !uri.endsWith("/common-service/common/termsandcondition")
  ) {
    retVal = true;
  }
  return retVal;
}

bool _decRequired({required String uri}) {
  bool retVal = false;
  var isEncEnabled = GlobalCache.instance.getEncFlag();
  if (isEncEnabled == "Y" &&
      !uri.endsWith("/public/rp") &&
      !uri.endsWith("/common/labels") &&
      !uri.endsWith("/auth/v1/user/forceupdate") &&
      !uri.endsWith("/common-service/common/termsandcondition") &&
      !uri.endsWith("/common-service/common/banner") &&
      !uri.endsWith("/account-service/v1/statement/export") &&
      !uri.endsWith("/card-service/v1/card/statement/export") &&
      !uri.endsWith("/transfer-service/v1/transfers/fileDownload") &&
      !uri.endsWith("/auth/logout")) {
    retVal = true;
  }
  return retVal;
}

/// Ensures object JSON is a Map<String, dynamic>. Leaves lists/primitives as is.
Object? _normalizeJson(Object? raw) {
  try {
    // If server sent a JSON string, decode it.
    if (raw is String) {
      final decoded = jsonDecode(raw);
      return _normalizeJson(decoded);
    }

    // If it's a Map (dynamic keys), cast to Map<String, dynamic>.
    if (raw is Map) {
      // This will throw if keys aren't String; which is desirable to catch bad payloads early.
      return Map<String, dynamic>.from(raw);
    }

    // Arrays / numbers / bool / null -> pass through unchanged
    return raw;
  } catch (e) {
    // If something is really off (e.g., HTML), keep original to aid debugging
    return raw;
  }
}
