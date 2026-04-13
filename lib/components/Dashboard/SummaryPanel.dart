import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({
    super.key,
    required this.summaryText,
    required this.suggestionText,
  });

  final String summaryText;
  final String suggestionText;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(summaryText, style: const TextStyle(height: 1.6)),
            const SizedBox(height: 12),
            Text(
              suggestionText,
              style: TextStyle(color: palette.subtitle, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
