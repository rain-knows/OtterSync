import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        _HeroCard(),
        SizedBox(height: 20),
        _SectionTitle(title: '进行中的项目'),
        SizedBox(height: 12),
        _ProjectCard(
          title: 'OtterSync 移动端适配',
          progress: 0.72,
          meta: 'Sprint 2 · 12 / 16 任务完成',
          accent: Color(0xFF0E5E6F),
        ),
        SizedBox(height: 12),
        _ProjectCard(
          title: 'AI 辅助任务流原型',
          progress: 0.43,
          meta: '待完善提示词与操作编排',
          accent: Color(0xFF4D7C8A),
        ),
        SizedBox(height: 20),
        _SectionTitle(title: '我的待办'),
        SizedBox(height: 12),
        _TaskCard(
          title: '搭建底部导航与主页面框架',
          tag: '高优先级',
          detail: '今天截止 · 需要完成安卓手机首页框架',
        ),
        SizedBox(height: 12),
        _TaskCard(
          title: '补充 Dashboard 关键指标卡片',
          tag: '计划中',
          detail: '接入燃尽图、工时与完成率占位组件',
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF0E5E6F), Color(0xFF3C8D9E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OtterSync',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '面向项目协作、任务流转、AI 辅助和数据分析的移动端管理框架。',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.86),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _MetricChip(label: '活跃项目', value: '06'),
              _MetricChip(label: '待处理任务', value: '18'),
              _MetricChip(label: '本周工时', value: '29h'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.title,
    required this.progress,
    required this.meta,
    required this.accent,
  });

  final String title;
  final double progress;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text('${(progress * 100).round()}%'),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                minHeight: 9,
                value: progress,
                backgroundColor: const Color(0xFFE3ECEE),
                valueColor: AlwaysStoppedAnimation<Color>(accent),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              meta,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6B7B83),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.title,
    required this.tag,
    required this.detail,
  });

  final String title;
  final String tag;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFD7EEF2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                color: Color(0xFF0E5E6F),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F6),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4B5A61),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    detail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6B7B83),
                    ),
                  ),
                ],
              ),
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
