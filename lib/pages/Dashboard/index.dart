import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        _SectionTitle(title: '项目 Dashboard'),
        SizedBox(height: 12),
        _MetricGrid(),
        SizedBox(height: 20),
        _SectionTitle(title: '交付趋势'),
        SizedBox(height: 12),
        _ChartCard(),
        SizedBox(height: 20),
        _SectionTitle(title: '分析摘要'),
        SizedBox(height: 12),
        _SummaryCard(),
      ],
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _MetricTile(title: '完成率', value: '78%', hint: '本周提升 6%'),
        _MetricTile(title: '累计工时', value: '148h', hint: '较计划低 9h'),
        _MetricTile(title: '待审核任务', value: '05', hint: '测试组处理中'),
        _MetricTile(title: '风险项', value: '02', hint: '需求变更、联调延期'),
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
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
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
  const _ChartCard();

  @override
  Widget build(BuildContext context) {
    const bars = [0.42, 0.58, 0.5, 0.72, 0.81, 0.66, 0.88];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '最近 7 天任务完成数',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bars
                    .map(
                      (value) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: value),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutCubic,
                            builder: (context, animatedValue, child) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 150 * animatedValue,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0E5E6F),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '当前 Sprint 整体推进稳定，UI 框架已完成首版，后续重点在任务详情、状态流转和 AI 接口联动。',
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 12),
            Text(
              '建议下一步补齐路由、详情页层级和假数据模型，让页面骨架能承接真实业务数据。',
              style: TextStyle(color: Color(0xFF6B7B83), height: 1.6),
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
