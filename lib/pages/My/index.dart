import 'package:flutter/material.dart';
import 'package:ottersync/components/My/ProfileOverviewCard.dart';
import 'package:ottersync/components/My/SettingsOptionTile.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/state/theme_controller.dart';
import 'package:ottersync/theme/design_tokens.dart';

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final themeController = ThemeControllerScope.of(context);

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        ProfileOverviewCard(appState: appState),
        const SizedBox(height: 20),
        SettingsOptionTile(
          icon: Icons.assignment_rounded,
          title: '我的任务',
          subtitle:
              '待处理 ${appState.pendingTaskCount} 项，已完成 ${appState.completedTaskCount} 项',
        ),
        SettingsOptionTile(
          icon: Icons.schedule_rounded,
          title: '工时记录',
          subtitle: '本周估算 ${appState.estimatedWeekHours}h，可同步到 Dashboard',
        ),
        SettingsOptionTile(
          icon: Icons.notifications_active_rounded,
          title: '风险中心',
          subtitle: '当前高优风险提醒 ${appState.riskTaskCount} 条，建议优先收敛',
        ),
        SettingsOptionTile(
          icon: Icons.rule_rounded,
          title: '工程基线',
          subtitle: '覆盖状态边界、审计追踪、AI 写回的交付规则',
        ),
        SettingsOptionTile(
          icon: themeController.isDarkMode
              ? Icons.dark_mode_rounded
              : Icons.light_mode_rounded,
          title: '外观模式',
          subtitle: themeController.isDarkMode ? '当前为深色模式' : '当前为浅色模式',
          onTap: themeController.toggle,
          trailing: Switch(
            value: themeController.isDarkMode,
            onChanged: (_) => themeController.toggle(),
          ),
        ),
      ],
    );
  }
}
