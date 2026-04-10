import 'package:flutter/material.dart';
import 'package:ottersync/components/My/my_profile_card.dart';
import 'package:ottersync/components/My/my_setting_tile.dart';
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
        MyProfileCard(appState: appState),
        const SizedBox(height: 20),
        MySettingTile(
          icon: Icons.assignment_rounded,
          title: '我的任务',
          subtitle:
              '待处理 ${appState.pendingTaskCount} 项，已完成 ${appState.completedTaskCount} 项',
        ),
        MySettingTile(
          icon: Icons.schedule_rounded,
          title: '工时记录',
          subtitle: '本周估算 ${appState.estimatedWeekHours}h，可同步到 Dashboard',
        ),
        MySettingTile(
          icon: Icons.notifications_active_rounded,
          title: '风险中心',
          subtitle: '当前高优风险提醒 ${appState.riskTaskCount} 条，建议优先收敛',
        ),
        MySettingTile(
          icon: Icons.rule_rounded,
          title: '工程基线',
          subtitle: '覆盖状态边界、审计追踪、AI 写回的交付规则',
        ),
      ],
    );
  }
}
