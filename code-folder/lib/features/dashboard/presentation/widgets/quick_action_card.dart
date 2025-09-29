import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../controllers/dashboard_controllers.dart';

class BuildQuickActionsGrid extends ConsumerStatefulWidget {
  const BuildQuickActionsGrid({super.key});

  @override
  ConsumerState<BuildQuickActionsGrid> createState() => _QuickActionsTabState();
}

class _QuickActionsTabState extends ConsumerState<BuildQuickActionsGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    controller.addListener(() {
      ref.read(animationValueProvider.notifier).state = controller.value;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animationValue = ref.watch(animationValueProvider);

    final List<Map<String, dynamic>> quickActions = [
      {'label': 'Transfer', 'icon': Icons.swap_horiz},
      {'label': 'QMP', 'icon': Icons.qr_code_2},
      {'label': 'Requests', 'icon': Icons.format_list_bulleted},
      {'label': 'More', 'icon': Icons.more_horiz},
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
        border: GradientBoxBorder(
          gradient: LinearGradient(
            transform: GradientRotation(animationValue * 2 * pi),
            colors: [Colors.transparent, Colors.transparent, Colors.blue],
          ),
          width: 1,
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: quickActions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  action['icon'] as IconData,
                  color: Colors.blue,
                  size: 32,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                action['label'] as String,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          );
        },
      ),
    );
  }
}
