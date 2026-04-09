import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';

enum _TaskFilter { all, pending, completed }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _TaskFilter _filter = _TaskFilter.pending;
  final TextEditingController _quickAddController = TextEditingController();

  @override
  void dispose() {
    _quickAddController.dispose();
    super.dispose();
  }

  void _addQuickTask(AppState appState) {
    final added = appState.addTask(_quickAddController.text);
    if (!added) {
      return;
    }
    _quickAddController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final canQuickAdd = _quickAddController.text.trim().isNotEmpty;

    final tasks = switch (_filter) {
      _TaskFilter.all => appState.tasks,
      _TaskFilter.pending => appState.tasks.where((task) => !task.done).toList(),
      _TaskFilter.completed =>
        appState.tasks.where((task) => task.done).toList(),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        _HeroCard(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '进行中的项目'),
        const SizedBox(height: 12),
        ...appState.projectProgressList
            .map(
              (project) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProjectCard(
                  title: project.title,
                  progress: project.progress,
                  meta: project.meta,
                  accent: project.accent,
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '我的待办'),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quickAddController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '快速新增一条待办...',
                    ),
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) {
                      if (canQuickAdd) {
                        _addQuickTask(appState);
                      }
                    },
                  ),
                ),
                FilledButton(
                  onPressed: canQuickAdd ? () => _addQuickTask(appState) : null,
                  child: const Text('新增'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('全部'),
              selected: _filter == _TaskFilter.all,
              onSelected: (_) => setState(() => _filter = _TaskFilter.all),
            ),
            FilterChip(
              label: const Text('待处理'),
              selected: _filter == _TaskFilter.pending,
              onSelected: (_) => setState(() => _filter = _TaskFilter.pending),
            ),
            FilterChip(
              label: const Text('已完成'),
              selected: _filter == _TaskFilter.completed,
              onSelected: (_) => setState(() => _filter = _TaskFilter.completed),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (tasks.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text('当前筛选下暂无任务。'),
            ),
          )
        else
          ...tasks
              .map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TaskCard(
                    task: task,
                    onToggle: () => appState.toggleTask(task.id),
                  ),
                ),
              )
              .toList(),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.appState});

  final AppState appState;

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
            children: [
              _MetricChip(
                label: '活跃项目',
                value: appState.activeProjectCount.toString().padLeft(2, '0'),
              ),
              _MetricChip(
                label: '待处理任务',
                value: appState.pendingTaskCount.toString().padLeft(2, '0'),
              ),
              _MetricChip(label: '本周工时', value: '${appState.estimatedWeekHours}h'),
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
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
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
  const _TaskCard({required this.task, required this.onToggle});

  final TaskItem task;
  final VoidCallback onToggle;

  Color get _priorityColor => switch (task.priority) {
    TaskPriority.high => const Color(0xFFE86B6B),
    TaskPriority.medium => const Color(0xFF4D7C8A),
    TaskPriority.low => const Color(0xFF6B7B83),
  };

  String get _priorityLabel => switch (task.priority) {
    TaskPriority.high => '高优先级',
    TaskPriority.medium => '中优先级',
    TaskPriority.low => '低优先级',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: task.done, onChanged: (_) => onToggle()),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: task.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _priorityColor.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          _priorityLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _priorityColor,
                          ),
                        ),
                      ),
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
                          task.dueText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4B5A61),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.project,
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
