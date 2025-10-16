import 'package:flutter/widgets.dart';

typedef DataBuilder<T> = Widget Function(BuildContext context, T data);
typedef LoadingBuilder = Widget Function(BuildContext context);
typedef ErrorBuilder   = Widget Function(BuildContext context, Object error, StackTrace? stackTrace);

typedef DataSideEffect<T> = void Function(T data);
typedef ErrorSideEffect   = void Function(Object error, StackTrace? stackTrace);
