import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/build_enviornment/build_environment.dart';
import '../../core/router/observers/screen_tracking_observer.dart';
import '../domain/cookie_manager_interface.dart';
import '../domain/header_manager_interface.dart';
import '../domain/network_client_interface.dart';
import '../network_client_provider.dart';
import 'cookie_manager.dart';
import 'header_manager.dart';
import 'network_interceptor.dart';

class NetworkClient implements NetworkClientInterface {
  static NetworkClient? _instance;
  static late Dio _dio;
  final ProviderRef ref;
  final CookieManagerInterface cookieManager;
  final HeaderManagerInterface headerManager;
  final NetworkInterceptor networkInterceptor;

  NetworkClient._(this.ref, this.cookieManager, this.networkInterceptor,
      this.headerManager);

  factory NetworkClient(ProviderRef ref) {
    if (_instance == null) {
      // final accessToken = ref.watch(authTokenProvider);
      final screenObserver = ref.watch(screenTrackingObserverProvider);

      _instance = NetworkClient._(
          ref,
          CookieManager(),
          NetworkInterceptor(CookieManager(), ref),
          HeaderManager(screenObserver));
      _instance!._initialize();
    }

    return _instance!;
  }

  Future<void> _initialize() async {
   _dio = await DioClient.getClient(
      [
        // "assets/security/<filename>.pem"
      ],
    );

   _dio.options.baseUrl = AppConfig.shared.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);

    // final cookieJar = CookieJar();
    // _dio.interceptors.add(CookieManager(cookieJar));

    _dio.interceptors.add(networkInterceptor.interceptorsWrapper);

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true));
    }
  }

  @override
  Dio get baseDio => _dio;

  @override
  Dio customDio({
    String? serviceId,
    required bool authorizationRequired,
    String? moduleId,
    String? subModuleId,
    String? screenId,
    String? customerId,
    String? Cookie,
    String? unit,
    String? channel,
  }) {
    final dio = _dio;

    final latestAccessToken = ref.watch(authTokenProvider);

    dio.options.headers.addAll(headerManager.getHeaders(
      serviceId: serviceId,
      moduleId: moduleId,
      subModuleId: subModuleId,
      screenId: screenId,
      customerId: customerId,
    ));

    if (authorizationRequired && latestAccessToken != null) {
      dio.options.headers['Authorization'] = 'Bearer ${latestAccessToken.atkn}';
    }

    return dio;
  }
}
