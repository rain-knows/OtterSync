import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class ProjectOverviewCard extends StatelessWidget {
  const ProjectOverviewCard({
    super.key,
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
    final palette = AppThemePalette.of(context);
    final indicatorColor = palette.brandAccent;

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
                    color: indicatorColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: indicatorColor.withValues(alpha: 0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                backgroundColor: palette.surfaceSecondary,
                valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              meta,
              style: theme.textTheme.bodySmall?.copyWith(
                color: palette.subtitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
