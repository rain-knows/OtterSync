import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/UserAvatar.dart';
import 'package:ottersync/theme/design_tokens.dart';

class IssueListTile extends StatelessWidget {
  const IssueListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.status,
    this.avatar,
    this.trailing,
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final Widget? leading;
  final String? status;
  final String? avatar;
  final Widget? trailing;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leading ?? _IssueCheckbox(color: palette.primary),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                ),
              ),
              if (!compact && (status != null || avatar != null)) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (status != null)
                      Text(
                        status!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: palette.textSecondary,
                        ),
                      ),
                    if (status != null && avatar != null)
                      const SizedBox(width: 10),
                    if (avatar != null) UserAvatar(label: avatar!, size: 24),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing!],
      ],
    );
  }
}

class _IssueCheckbox extends StatelessWidget {
  const _IssueCheckbox({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(Icons.check_rounded, color: color, size: 26),
    );
  }
}
