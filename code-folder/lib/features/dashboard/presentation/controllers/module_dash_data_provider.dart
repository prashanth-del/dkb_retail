import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/src/dash_module_info.dart';
import '../../modules/src/module_dash_map.dart';

final moduleDashDataProvider = StateProvider<List<DashModuleInfo>>((ref) {
  final moduleDashMap = ref.watch(moduleDashMapProvider);
  return moduleDashMap.values.toList();
});
