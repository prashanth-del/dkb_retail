// import 'package:dkb_retail/core/theme/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ThemeToggle extends ConsumerWidget {
//   const ThemeToggle({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appTheme = ref.watch(appThemeMode);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Dynamic Theme Toggle")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               appTheme == AppThemeMode.light
//                   ? 'Light'
//                   : appTheme == AppThemeMode.dark
//                   ? "Dark"
//                   : appTheme == AppThemeMode.system
//                   ? 'System'
//                   : '',
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(appThemeMode.notifier).state = AppThemeMode.light,
//               child: const Text("Light Mode"),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(appThemeMode.notifier).state = AppThemeMode.dark,
//               child: const Text("Dark Mode"),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(appThemeMode.notifier).state = AppThemeMode.system,
//               child: const Text("System Default"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
