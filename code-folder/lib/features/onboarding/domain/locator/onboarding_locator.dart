import 'package:dkb_retail/features/onboarding/data/datasource/onboarding_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../network/network_client_provider.dart';
import '../../data/repository/onboarding_repository.dart';
import '../repository/onboarding_repository.dart';

final onboardingDataSource = Provider<OnboardingDatasource>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return OnboardingDatasourceImpl(networkClient: networkClient);
});

final onboardingRepository = Provider<OnboardingRepository>((ref) {
  final datasource = ref.watch(onboardingDataSource);

  return OnboardingRepositoryImpl(datasource);
});
