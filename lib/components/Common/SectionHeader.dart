import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: palette.title,
        letterSpacing: -0.3,
      ),
    );
  }
}
