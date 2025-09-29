import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/cache/global_cache.dart';
import 'data/network_client.dart';
import 'domain/models/auth_tokens.dart';
import 'notifier/logout_init.dart';

final authTokenProvider = StateProvider<AuthTokens?>((ref) {
  final authToken = GlobalCache.instance.getTkn();
  return authToken;
});

final networkClientProvider = Provider<NetworkClient>((ref) {
  return NetworkClient(ref);
});

final initLogoutProvider = StateNotifierProvider<InitLogoutNotifier, bool>((ref) {
  return InitLogoutNotifier();
});