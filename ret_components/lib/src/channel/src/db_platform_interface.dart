import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'db_method_channel.dart';

abstract class DbPlatformInterface extends PlatformInterface {
  /// Constructs a DbUicomponentsPlatform.
  DbPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static DbPlatformInterface _instance = DbMethodChannel();

  /// The default instance of [DbPlatformInterface] to use.
  ///
  /// Defaults to [DbMethodChannel].
  static DbPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DbPlatformInterface] when
  /// they register themselves.
  static set instance(DbPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> encrypt({required Map<String, String> toEncrypt}) {
    throw UnimplementedError('encrypt() has not been implemented.');
  }

  Future<String?> decryptPayLoad({required Map<String, String> toDecrypt}) {
    throw UnimplementedError('decryptPayLoad() has not been implemented.');
  }

  Future<bool> detectVpn() {
    throw UnimplementedError('detectVPN() has not been implemented.');
  }
}
