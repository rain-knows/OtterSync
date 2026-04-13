import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/SectionHeader.dart';
import 'package:ottersync/components/Workspace/ActivityFeedItem.dart';
import 'package:ottersync/components/Workspace/WorkspaceOverviewBanner.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final palette = AppThemePalette.of(context);
    final onlineCount = appState.members
        .where((member) => member.online)
        .length;

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        WorkspaceOverviewBanner(
          memberCount: appState.members.length,
          onlineCount: onlineCount,
          activeProjects: appState.activeProjectCount,
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: '权限矩阵'),
        const SizedBox(height: 12),
        ...appState.rolePermissionMatrix.map(
          (item) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(item.role),
              subtitle: Text(item.permissions.join(' · ')),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionHeader(title: '项目级授权策略'),
        const SizedBox(height: 12),
        ...appState.projectPolicies.map(
          (policy) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: palette.brandSoft,
                child: Icon(Icons.shield_rounded, color: palette.brandAccent),
              ),
              title: Text(policy.projectName),
              subtitle: Text(policy.policy),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionHeader(title: '成员状态'),
        const SizedBox(height: 12),
        ...appState.members.map(
          (member) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: member.online
                    ? palette.brandSoft
                    : palette.surfaceSecondary,
                child: Icon(
                  Icons.person_rounded,
                  color: member.online ? palette.brandAccent : palette.subtitle,
                ),
              ),
              title: Text(member.name),
              subtitle: Text(member.role),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: member.online
                      ? palette.success.withValues(alpha: 0.14)
                      : palette.surfaceSecondary.withValues(alpha: 0.5),
                  border: Border.all(color: palette.border),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  member.online ? '在线' : '离线',
                  style: TextStyle(
                    color: member.online ? palette.success : palette.subtitle,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionHeader(title: '操作审计'),
        const SizedBox(height: 12),
        ...appState.audits
            .take(6)
            .map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(item.action),
                  subtitle: Text('${item.operator} · ${item.scope}'),
                  trailing: Text(
                    item.time,
                    style: TextStyle(color: palette.subtitle, fontSize: 12),
                  ),
                ),
              ),
            ),
        const SizedBox(height: 8),
        const SectionHeader(title: '最近动态'),
        const SizedBox(height: 12),
        if (appState.activities.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('暂无动态，完成任务或发起 AI 指令后会自动记录。'),
            ),
          )
        else
          ...appState.activities.map(
            (item) => ActivityFeedItem(title: item.title, time: item.time),
          ),
      ],
    );
  }
}
