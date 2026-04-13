import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class WorkspaceOverviewBanner extends StatelessWidget {
  const WorkspaceOverviewBanner({
    super.key,
    required this.memberCount,
    required this.onlineCount,
    required this.activeProjects,
  });

  final int memberCount;
  final int onlineCount;
  final int activeProjects;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        border: Border.all(color: palette.borderStrong),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF15161A), Color(0xFF101114), Color(0xFF171B2D)]
              : const [Color(0xFFF7F8FF), Color(0xFFFFFFFF), Color(0xFFEEF2FF)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workspace 治理中心',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: palette.title,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '聚合角色权限、授权策略、审计记录和动态事件，保证协作模块可管理可追溯。',
            style: TextStyle(height: 1.5, color: palette.text),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(text: '成员 $memberCount 人'),
              _Tag(text: '在线 $onlineCount 人'),
              _Tag(text: '项目 $activeProjects 个'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.06) : palette.surface,
        border: Border.all(color: palette.borderStrong),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: palette.title, fontWeight: FontWeight.w600),
      ),
    );
  }
}
