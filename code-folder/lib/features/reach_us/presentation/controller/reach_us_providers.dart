import 'package:dkb_retail/features/reach_us/presentation/controller/state/reach_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/locate_us_info_branche.dart';

final bankDetailsLoading = StateProvider<bool>((ref) => false);

final locateUsLoading = StateProvider<bool>((ref) => false);

final reachUsNotifierProvider =
    StateNotifierProvider<ReachUsNotifier, ReachUsState>((ref) {
      return ReachUsNotifier();
    });

final branchesProvider = Provider<List<LocateUsInfoBranche>>((ref) {
  return ref.watch(reachUsNotifierProvider).branches;
});

final atmsProvider = Provider<List<LocateUsInfoBranche>>((ref) {
  return ref.watch(reachUsNotifierProvider).atms;
});

final kiosksProvider = Provider<List<LocateUsInfoBranche>>((ref) {
  return ref.watch(reachUsNotifierProvider).kiosks;
});

final nearestBranchProvider = Provider<LocateUsInfoBranche?>((ref) {
  return ref.watch(reachUsNotifierProvider).nearestBranch;
});
