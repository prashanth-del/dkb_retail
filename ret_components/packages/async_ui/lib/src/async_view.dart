import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'builders.dart';
import 'lock/lock_controller.dart';
import 'lock/lock_bus.dart';
import 'utils/async_extensions.dart';

/// Render a Provider<AsyncValue<T>> with auto global-lock on loading/refresh.
class AsyncView<T> extends ConsumerStatefulWidget {
  const AsyncView({
    super.key,
    required this.provider,
    required this.data,
    this.loading,
    this.error,
    this.lockWhileLoading = true,
    this.onData,
    this.onError,
    this.childWhenEmpty,
  });

  final ProviderListenable<AsyncValue<T>> provider;
  final DataBuilder<T> data;
  final LoadingBuilder? loading;
  final ErrorBuilder? error;
  final bool lockWhileLoading;
  final DataSideEffect<T>? onData;
  final ErrorSideEffect? onError;
  final Widget Function(BuildContext context, T data)? childWhenEmpty;

  @override
  ConsumerState<AsyncView<T>> createState() => _AsyncViewState<T>();
}

class _AsyncViewState<T> extends ConsumerState<AsyncView<T>> {
  LockToken? _token;

  @override
  void didUpdateWidget(covariant AsyncView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncLock();
  }

  @override
  void initState() {
    super.initState();
    _syncLock();
  }

  void _syncLock() {
    final async = ref.read(widget.provider);
    final isLoading = async.loadingOrRefreshing;

    if (!widget.lockWhileLoading) return;

    if (isLoading && _token == null) {
      _token = ref.read(globalLockProvider.notifier).acquire(source: 'AsyncView');
    } else if (!isLoading && _token != null) {
      _token!.release();
      _token = null;
    }
  }

  @override
  void dispose() {
    _token?.release();
    _token = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(widget.provider);

    // react to transitions safely inside build
    ref.listen<AsyncValue<T>>(widget.provider, (prev, next) {
      if (!widget.lockWhileLoading) return;
      final was = prev?.loadingOrRefreshing ?? false;
      final now = next.loadingOrRefreshing;
      if (!was && now && _token == null) {
        _token = ref.read(globalLockProvider.notifier).acquire(source: 'AsyncView');
      } else if (was && !now && _token != null) {
        _token!.release();
        _token = null;
      }

      next.when(
        data: (d) => widget.onData?.call(d),
        error: (e, st) => widget.onError?.call(e, st),
        loading: () {},
      );
    });

    return async.when(
      data: (value) {
        if (widget.childWhenEmpty != null) {
          return widget.childWhenEmpty!(context, value);
        }
        return widget.data(context, value);
      },
      loading: () => widget.loading?.call(context) ?? const SizedBox.shrink(),
      error: (e, st) =>
      widget.error?.call(context, e, st) ?? Center(child: Text('Error: $e')),
    );
  }
}
