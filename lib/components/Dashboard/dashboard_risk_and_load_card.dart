import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class DashboardRiskAndLoadCard extends StatelessWidget {
  const DashboardRiskAndLoadCard({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final risks = appState.riskDistribution;
    final loads = appState.memberLoadRatios;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _RiskChip(
                  label: '高优',
                  value: risks[TaskPriority.high] ?? 0,
                  color: AppColors.warning,
                ),
                _RiskChip(
                  label: '中优',
                  value: risks[TaskPriority.medium] ?? 0,
                  color: const Color(0xFF4D7C8A),
                ),
                _RiskChip(
                  label: '低优',
                  value: risks[TaskPriority.low] ?? 0,
                  color: AppColors.subtitle,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('成员负载'),
            const SizedBox(height: 8),
            ...List.generate(
              appState.members.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(appState.members[index].name),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: index < loads.length ? loads[index] : 0,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(999),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.brand,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiskChip extends StatelessWidget {
  const _RiskChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
