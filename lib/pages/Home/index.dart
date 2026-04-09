import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

enum _TaskFilter { all, pending, completed, risk }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _TaskFilter _filter = _TaskFilter.pending;
  final TextEditingController _quickAddController = TextEditingController();
  bool _canQuickAdd = false;

  @override
  void dispose() {
    _quickAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final tasks = switch (_filter) {
      _TaskFilter.all => appState.tasks,
      _TaskFilter.pending => appState.tasks.where((task) => !task.done).toList(),
      _TaskFilter.completed => appState.tasks.where((task) => task.done).toList(),
      _TaskFilter.risk => appState.tasks.where((task) => !task.done && task.isRisk).toList(),
    };

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        _HeroCard(appState: appState),
        const SizedBox(height: 20),
        const _SectionTitle(title: '完成度分层验收'),
        const SizedBox(height: 12),
        ...appState.completionLayers
            .map(
              (layer) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _LayerCard(layer: layer),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '项目推进'),
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
        const _SectionTitle(title: '任务流程闭环'),
        const SizedBox(height: 12),
        _QuickAddCard(
          controller: _quickAddController,
          canSubmit: _canQuickAdd,
          onChanged: (value) => setState(() => _canQuickAdd = value.trim().isNotEmpty),
          onSubmit: () {
            final created = appState.addTask(_quickAddController.text);
            if (created) {
              _quickAddController.clear();
              setState(() => _canQuickAdd = false);
            }
          },
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
              label: const Text('进行中'),
              selected: _filter == _TaskFilter.pending,
              onSelected: (_) => setState(() => _filter = _TaskFilter.pending),
            ),
            FilterChip(
              label: const Text('已完成'),
              selected: _filter == _TaskFilter.completed,
              onSelected: (_) => setState(() => _filter = _TaskFilter.completed),
            ),
            FilterChip(
              label: const Text('风险'),
              selected: _filter == _TaskFilter.risk,
              onSelected: (_) => setState(() => _filter = _TaskFilter.risk),
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
                  child: _TaskCard(task: task),
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
        gradient: const LinearGradient(colors: [AppColors.brand, Color(0xFF3C8D9E)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OtterSync 完成度分层',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '覆盖产品、业务、工程三层验收基线，保证复杂功能可交付、可协作、可追踪。',
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
              _MetricChip(
                label: 'AI执行',
                value: appState.executedSuggestionCount.toString().padLeft(2, '0'),
              ),
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
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _LayerCard extends StatelessWidget {
  const _LayerCard({required this.layer});

  final CompletionLayer layer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(layer.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
                Text('${(layer.score * 100).round()}%'),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: layer.score,
              minHeight: 8,
              borderRadius: BorderRadius.circular(999),
            ),
            const SizedBox(height: 10),
            ...layer.acceptanceCriteria.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 6, color: AppColors.subtitle),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: const TextStyle(color: AppColors.subtitle))),
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

class _QuickAddCard extends StatelessWidget {
  const _QuickAddCard({
    required this.controller,
    required this.canSubmit,
    required this.onChanged,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool canSubmit;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '快速创建任务并纳入流程跟踪...',
                ),
                onChanged: onChanged,
                onSubmitted: (_) {
                  if (canSubmit) {
                    onSubmit();
                  }
                },
              ),
            ),
            FilledButton(onPressed: canSubmit ? onSubmit : null, child: const Text('创建')),
          ],
        ),
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
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
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
            Text(meta, style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7B83))),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final theme = Theme.of(context);
    final priorityColor = switch (task.priority) {
      TaskPriority.high => AppColors.warning,
      TaskPriority.medium => const Color(0xFF4D7C8A),
      TaskPriority.low => const Color(0xFF6B7B83),
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Tag(text: appState.priorityLabel(task.priority), color: priorityColor.withValues(alpha: 0.14), foreground: priorityColor),
                _Tag(
                  text: appState.statusLabel(task.status),
                  color: const Color(0xFFE7F1F4),
                  foreground: AppColors.brand,
                ),
                _Tag(text: task.dueText, color: const Color(0xFFF1F5F6), foreground: const Color(0xFF4B5A61)),
                if (task.isRisk) _Tag(text: '风险', color: const Color(0xFFFDECEC), foreground: AppColors.warning),
                if (task.dependencyIds.isNotEmpty)
                  _Tag(text: '依赖 ${task.dependencyIds.length}', color: const Color(0xFFF1F5F6), foreground: AppColors.subtitle),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${appState.projectNameById(task.projectId)} · 负责人 ${appState.memberNameById(task.assigneeId)}',
              style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.subtitle),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => appState.updateTaskStatus(id: task.id, status: TaskStatus.inProgress),
                  child: const Text('推进'),
                ),
                OutlinedButton(
                  onPressed: () => appState.updateTaskStatus(id: task.id, status: TaskStatus.review),
                  child: const Text('评审'),
                ),
                FilledButton(
                  onPressed: () => appState.updateTaskStatus(id: task.id, status: TaskStatus.done),
                  child: const Text('完成'),
                ),
                TextButton(
                  onPressed: () => appState.splitTask(task.id),
                  child: const Text('拆分子任务'),
                ),
              ],
            ),
            if (task.history.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                '最近记录：${task.history.first.message}',
                style: const TextStyle(color: AppColors.subtitle, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.text,
    required this.color,
    required this.foreground,
  });

  final String text;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: foreground),
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
