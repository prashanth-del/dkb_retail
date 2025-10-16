class RewardBoxModel {
  final RewardBoxType type;
  final String title;
  final double progressPercentage;

  RewardBoxModel({
    required this.type,
    required this.title,
    this.progressPercentage = 0.0,
  });
}

enum RewardBoxType { gradient, white }

final List<RewardBoxModel> rewardBoxes = [
  RewardBoxModel(type: RewardBoxType.gradient, title: 'New Reward\nUnlocked'),

  RewardBoxModel(
    type: RewardBoxType.white,
    title: '2 more transaction away\nfrom unlocking this\nreward',
    progressPercentage: 0.7,
  ),
];
