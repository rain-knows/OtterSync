import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        const _SectionTitle(title: '项目 Dashboard'),
        const SizedBox(height: 12),
        _MetricGrid(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '交付趋势'),
        const SizedBox(height: 12),
        _ChartCard(bars: appState.weeklyCompletionTrend),
        const SizedBox(height: 20),
        const _SectionTitle(title: '分析摘要'),
        const SizedBox(height: 12),
        _SummaryCard(
          summaryText: appState.summaryText,
          suggestionText: appState.suggestionText,
        ),
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
        _MetricTile(
          title: '完成率',
          value: '${(appState.completionRate * 100).round()}%',
          hint: '与任务状态实时联动',
        ),
        _MetricTile(
          title: '累计工时',
          value: '${appState.estimatedWeekHours}h',
          hint: '按完成/待办估算',
        ),
        _MetricTile(
          title: '待处理任务',
          value: appState.pendingTaskCount.toString().padLeft(2, '0'),
          hint: '跨页面同步统计',
        ),
        _MetricTile(
          title: '风险项',
          value: appState.riskTaskCount.toString().padLeft(2, '0'),
          hint: '高优未完成任务数',
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.title,
    required this.value,
    required this.hint,
  });

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
              Text(title, style: const TextStyle(color: Color(0xFF6B7B83))),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(hint, style: const TextStyle(color: Color(0xFF6B7B83))),
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
                                  color: const Color(0xFF0E5E6F),
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
            Text(
              suggestionText,
              style: const TextStyle(color: Color(0xFF6B7B83), height: 1.6),
            ),
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
        color: const Color(0xFF132026),
      ),
    );
  }
}
