import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class HomeTaskCard extends StatelessWidget {
  const HomeTaskCard({super.key, required this.task});

  final TaskItem task;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final theme = Theme.of(context);
    final priorityColor = switch (task.priority) {
      TaskPriority.high => AppColors.warning,
      TaskPriority.medium => const Color(0xFF4D7C8A),
      TaskPriority.low => AppColors.subtitle,
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
                  color: const Color(0xFFE7F1F4),
                  foreground: AppColors.brand,
                ),
                _Tag(
                  text: task.dueText,
                  color: const Color(0xFFF1F5F6),
                  foreground: const Color(0xFF4B5A61),
                ),
                if (task.isRisk)
                  _Tag(
                    text: '风险',
                    color: const Color(0xFFFDECEC),
                    foreground: AppColors.warning,
                  ),
                if (task.dependencyIds.isNotEmpty)
                  _Tag(
                    text: '依赖 ${task.dependencyIds.length}',
                    color: const Color(0xFFF1F5F6),
                    foreground: AppColors.subtitle,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${appState.projectNameById(task.projectId)} · 负责人 ${appState.memberNameById(task.assigneeId)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.subtitle,
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
      decoration: BoxDecoration(
        color: color,
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
