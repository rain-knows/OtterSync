import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class DashboardMetricCards extends StatelessWidget {
  const DashboardMetricCards({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    AppThemePalette.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        MetricStatCard(
          title: '完成率',
          value: '${(appState.completionRate * 100).round()}%',
          hint: '任务状态实时联动',
        ),
        MetricStatCard(
          title: '累计工时',
          value: '${appState.estimatedWeekHours}h',
          hint: '按完成/待办估算',
        ),
        MetricStatCard(
          title: '待处理任务',
          value: appState.pendingTaskCount.toString().padLeft(2, '0'),
          hint: '跨页面同步统计',
        ),
        MetricStatCard(
          title: '风险项',
          value: appState.riskTaskCount.toString().padLeft(2, '0'),
          hint: '高优或风险标记任务',
        ),
      ],
    );
  }
}

class MetricStatCard extends StatelessWidget {
  const MetricStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.hint,
  });

  final String title;
  final String value;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: palette.subtitle)),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(hint, style: TextStyle(color: palette.subtitle)),
            ],
          ),
        ),
      ),
    );
  }
}
