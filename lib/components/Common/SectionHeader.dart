import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.compact = false,
  });

  final String title;
  final Widget? action;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppThemePalette.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: compact
                ? theme.textTheme.titleMedium?.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w600,
                  )
                : theme.textTheme.titleLarge?.copyWith(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
        action ?? const SizedBox.shrink(),
      ],
    );
  }
}
