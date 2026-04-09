import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        const _SectionTitle(title: '项目 Dashboard'),
        const SizedBox(height: 12),
        _MetricGrid(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '交付趋势'),
        const SizedBox(height: 12),
        _ChartCard(bars: appState.weeklyCompletionTrend),
        const SizedBox(height: 20),
        const _SectionTitle(title: '流程状态分布'),
        const SizedBox(height: 12),
        _StatusDistributionCard(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '风险分布与成员负载'),
        const SizedBox(height: 12),
        _RiskAndLoadCard(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '分析摘要'),
        const SizedBox(height: 12),
        _SummaryCard(summaryText: appState.summaryText, suggestionText: appState.suggestionText),
      ],
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _MetricTile(title: '完成率', value: '${(appState.completionRate * 100).round()}%', hint: '任务状态实时联动'),
        _MetricTile(title: '累计工时', value: '${appState.estimatedWeekHours}h', hint: '按完成/待办估算'),
        _MetricTile(title: '待处理任务', value: appState.pendingTaskCount.toString().padLeft(2, '0'), hint: '跨页面同步统计'),
        _MetricTile(title: '风险项', value: appState.riskTaskCount.toString().padLeft(2, '0'), hint: '高优或风险标记任务'),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.title, required this.value, required this.hint});

  final String title;
  final String value;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.subtitle)),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(hint, style: const TextStyle(color: AppColors.subtitle)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.bars});

  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    const labels = ['一', '二', '三', '四', '五', '六', '日'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('最近 7 天任务完成趋势', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            SizedBox(
              height: 196,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  bars.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: bars[index]),
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeOutCubic,
                            builder: (context, animatedValue, child) {
                              return Container(
                                height: 140 * animatedValue,
                                decoration: BoxDecoration(
                                  color: AppColors.brand,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(labels[index]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusDistributionCard extends StatelessWidget {
  const _StatusDistributionCard({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final statusMap = appState.workflowStatusCount;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: statusMap.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 80, child: Text(appState.statusLabel(entry.key))),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: appState.tasks.isEmpty ? 0 : entry.value / appState.tasks.length,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.value.toString()),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _RiskAndLoadCard extends StatelessWidget {
  const _RiskAndLoadCard({required this.appState});

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
                _RiskChip(label: '高优', value: risks[TaskPriority.high] ?? 0, color: AppColors.warning),
                _RiskChip(label: '中优', value: risks[TaskPriority.medium] ?? 0, color: const Color(0xFF4D7C8A)),
                _RiskChip(label: '低优', value: risks[TaskPriority.low] ?? 0, color: AppColors.subtitle),
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
                    SizedBox(width: 70, child: Text(appState.members[index].name)),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: index < loads.length ? loads[index] : 0,
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(999),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brand),
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
  const _RiskChip({required this.label, required this.value, required this.color});

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
      child: Text('$label $value', style: TextStyle(color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summaryText, required this.suggestionText});

  final String summaryText;
  final String suggestionText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summaryText, style: const TextStyle(height: 1.6)),
            const SizedBox(height: 12),
            Text(suggestionText, style: const TextStyle(color: AppColors.subtitle, height: 1.6)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.title,
      ),
    );
  }
}
