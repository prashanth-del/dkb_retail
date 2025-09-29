import 'api_envelope.dart';

/// **Deprecated**: Use [ApiEnvelope] instead of [ApiResponse].
///
/// Example migration:
/// ```dart
/// // Before
/// Future<ApiResponse<UserDto>> login(...) async { ... }
///
/// // After
/// Future<ApiEnvelope<UserDto>> login(...) async { ... }
/// ```
///
/// This alias exists only for backward compatibility during migration.
/// Will be removed once all datasources/repositories use [ApiEnvelope].
@Deprecated('Use ApiEnvelope instead. Will be removed in future releases.')
typedef ApiResponse<T> = ApiEnvelope<T>;
