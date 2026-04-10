import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/section_title.dart';
import 'package:ottersync/components/Workspace/workspace_activity_tile.dart';
import 'package:ottersync/components/Workspace/workspace_header.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final onlineCount = appState.members
        .where((member) => member.online)
        .length;

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        WorkspaceHeader(
          memberCount: appState.members.length,
          onlineCount: onlineCount,
          activeProjects: appState.activeProjectCount,
        ),
        const SizedBox(height: 20),
        const SectionTitle(title: '权限矩阵'),
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
        const SectionTitle(title: '项目级授权策略'),
        const SizedBox(height: 12),
        ...appState.projectPolicies.map(
          (policy) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.brandSoft,
                child: Icon(Icons.shield_rounded, color: AppColors.brand),
              ),
              title: Text(policy.projectName),
              subtitle: Text(policy.policy),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionTitle(title: '成员状态'),
        const SizedBox(height: 12),
        ...appState.members.map(
          (member) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: member.online
                    ? AppColors.brandSoft
                    : const Color(0xFFE8EEF0),
                child: Icon(
                  Icons.person_rounded,
                  color: member.online
                      ? AppColors.brand
                      : const Color(0xFF8A99A0),
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
                      ? const Color(0xFFDFF4E6)
                      : const Color(0xFFF0F3F4),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  member.online ? '在线' : '离线',
                  style: TextStyle(
                    color: member.online
                        ? AppColors.success
                        : AppColors.subtitle,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionTitle(title: '操作审计'),
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
                    style: const TextStyle(
                      color: AppColors.subtitle,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        const SizedBox(height: 8),
        const SectionTitle(title: '最近动态'),
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
            (item) => WorkspaceActivityTile(title: item.title, time: item.time),
          ),
      ],
    );
  }
}
