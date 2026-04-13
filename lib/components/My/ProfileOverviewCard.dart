import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class ProfileOverviewCard extends StatelessWidget {
  const ProfileOverviewCard({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: palette.surface.withValues(alpha: 0.9),
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: palette.brandSoft,
                child: Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: palette.brandAccent,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '第 2 小组成员',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '复杂流程与质量基线推进中',
                    style: TextStyle(color: palette.subtitle),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '当前任务完成率 ${(appState.completionRate * 100).round()}%，AI 执行 ${appState.executedSuggestionCount} 次，已具备跨页面回写能力。',
            style: TextStyle(height: 1.6, color: palette.text),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: appState.completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
            backgroundColor: palette.surfaceSecondary,
            valueColor: AlwaysStoppedAnimation<Color>(palette.brandAccent),
          ),
        ],
      ),
    );
  }
}
