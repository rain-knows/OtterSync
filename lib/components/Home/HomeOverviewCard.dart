import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/theme/design_tokens.dart';

class HomeOverviewCard extends StatelessWidget {
  const HomeOverviewCard({
    super.key,
    required this.onCopy,
    required this.onLike,
    required this.onDislike,
    required this.onMore,
  });

  final VoidCallback onCopy;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final theme = Theme.of(context);

    return AppSurface(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No recent work activities found in the last 4 days.',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 27,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: palette.textSecondary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '使用人工智能。验证结果。',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ),
              IconButton(
                onPressed: onCopy,
                icon: Icon(
                  Icons.content_copy_outlined,
                  color: palette.textPrimary,
                ),
              ),
              IconButton(
                onPressed: onLike,
                icon: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: palette.textPrimary,
                ),
              ),
              IconButton(
                onPressed: onDislike,
                icon: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: palette.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: onMore, child: const Text('查看更多')),
        ],
      ),
    );
  }
}
