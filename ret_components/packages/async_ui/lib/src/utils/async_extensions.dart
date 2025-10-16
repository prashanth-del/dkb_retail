import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncFlags on AsyncValue {
  bool get loadingOrRefreshing => isLoading || (hasValue && isRefreshing);
}
