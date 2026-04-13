import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class TaskOverviewCard extends StatelessWidget {
  const TaskOverviewCard({super.key, required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final theme = Theme.of(context);
    final palette = AppThemePalette.of(context);
    final priorityColor = switch (task.priority) {
      TaskPriority.high => palette.warning,
      TaskPriority.medium => palette.brandAccent,
      TaskPriority.low => palette.subtitle,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Tag(
                  text: appState.priorityLabel(task.priority),
                  color: priorityColor.withValues(alpha: 0.14),
                  foreground: priorityColor,
                ),
                _Tag(
                  text: appState.statusLabel(task.status),
                  color: palette.brandSoft,
                  foreground: palette.brandAccent,
                ),
                _Tag(
                  text: task.dueText,
                  color: palette.surfaceSecondary.withValues(alpha: 0.5),
                  foreground: palette.text,
                ),
                if (task.isRisk)
                  _Tag(
                    text: '风险',
                    color: palette.warning.withValues(alpha: 0.14),
                    foreground: palette.warning,
                  ),
                if (task.dependencyIds.isNotEmpty)
                  _Tag(
                    text: '依赖 ${task.dependencyIds.length}',
                    color: palette.surfaceSecondary.withValues(alpha: 0.5),
                    foreground: palette.subtitle,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${appState.projectNameById(task.projectId)} · 负责人 ${appState.memberNameById(task.assigneeId)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: palette.subtitle,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => appState.updateTaskStatus(
                    id: task.id,
                    status: TaskStatus.inProgress,
                  ),
                  child: const Text('推进'),
                ),
                OutlinedButton(
                  onPressed: () => appState.updateTaskStatus(
                    id: task.id,
                    status: TaskStatus.review,
                  ),
                  child: const Text('评审'),
                ),
                FilledButton(
                  onPressed: () => appState.updateTaskStatus(
                    id: task.id,
                    status: TaskStatus.done,
                  ),
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
                style: TextStyle(color: palette.subtitle, fontSize: 12),
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
    final palette = AppThemePalette.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}
