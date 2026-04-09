import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        _ProfileCard(appState: appState),
        const SizedBox(height: 20),
        _SettingTile(
          icon: Icons.assignment_rounded,
          title: '我的任务',
          subtitle: '待处理 ${appState.pendingTaskCount} 项，已完成 ${appState.completedTaskCount} 项',
        ),
        _SettingTile(
          icon: Icons.schedule_rounded,
          title: '工时记录',
          subtitle: '本周估算 ${appState.estimatedWeekHours}h，可同步到 Dashboard',
        ),
        _SettingTile(
          icon: Icons.notifications_active_rounded,
          title: '风险中心',
          subtitle: '当前高优风险提醒 ${appState.riskTaskCount} 条，建议优先收敛',
        ),
        _SettingTile(
          icon: Icons.rule_rounded,
          title: '工程基线',
          subtitle: '覆盖状态边界、审计追踪、AI 写回的交付规则',
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.brandSoft,
                child: Icon(Icons.person_rounded, size: 30, color: AppColors.brand),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('第 2 小组成员', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('复杂流程与质量基线推进中', style: TextStyle(color: AppColors.subtitle)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '当前任务完成率 ${(appState.completionRate * 100).round()}%，AI 执行 ${appState.executedSuggestionCount} 次，已具备跨页面回写能力。',
            style: const TextStyle(height: 1.6, color: Color(0xFF51626A)),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: appState.completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
            backgroundColor: const Color(0xFFE7EFF1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brand),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minTileHeight: 76,
        leading: CircleAvatar(
          backgroundColor: AppColors.brandSoft,
          child: Icon(icon, color: AppColors.brand),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
