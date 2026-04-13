import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppThemePalette.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: palette.borderStrong),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF171924), Color(0xFF10111A), Color(0xFF212752)]
              : const [Color(0xFFF2F4FF), Color(0xFFFFFFFF), Color(0xFFE9EEFF)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 32,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OtterSync 完成度分层',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: palette.title,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '覆盖产品、业务、工程三层验收基线，保证复杂功能可交付、可协作、可追踪。',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: palette.text,
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
                value: appState.executedSuggestionCount.toString().padLeft(
                  2,
                  '0',
                ),
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
    final palette = AppThemePalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 92,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.14)
            : palette.brandSoft,
        border: Border.all(color: palette.borderStrong),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: palette.title,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: palette.text, fontSize: 12)),
        ],
      ),
    );
  }
}
