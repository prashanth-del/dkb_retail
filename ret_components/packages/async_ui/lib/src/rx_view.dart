import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'builders.dart';
import 'async_view.dart';

/// For Freezed/union notifiers: map state -> AsyncValue<T> and reuse AsyncView.
class RxView<S, T> extends ConsumerWidget {
  const RxView({
    super.key,
    required this.stateProvider,
    required this.map,
    required this.data,
    this.loading,
    this.error,
    this.lockWhileLoading = true,
    this.onData,
    this.onError,
    this.childWhenEmpty,
  });

  final ProviderListenable<S> stateProvider;
  final AsyncValue<T> Function(S state) map;

  final DataBuilder<T> data;
  final LoadingBuilder? loading;
  final ErrorBuilder? error;
  final bool lockWhileLoading;
  final DataSideEffect<T>? onData;
  final ErrorSideEffect? onError;
  final Widget Function(BuildContext context, T data)? childWhenEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mappedProvider = Provider<AsyncValue<T>>((ref) {
      final s = ref.watch(stateProvider);
      return map(s);
    });

    return AsyncView<T>(
      provider: mappedProvider,
      data: data,
      loading: loading,
      error: error,
      lockWhileLoading: lockWhileLoading,
      onData: onData,
      onError: onError,
      childWhenEmpty: childWhenEmpty,
    );
  }
}
