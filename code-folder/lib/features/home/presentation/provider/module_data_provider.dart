import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/src/module_info.dart';
import '../../modules/src/module_map.dart';

final moduleDataProvider = StateProvider<List<ModuleInfo>>((ref) {
  final moduleMap = ref.watch(moduleMapProvider);
  return moduleMap.values.toList();
});

final isEditableProvider = StateProvider<bool>((ref) => true);
