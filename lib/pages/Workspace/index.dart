import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final onlineCount = appState.members.where((member) => member.online).length;

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        _WorkspaceHeader(
          memberCount: appState.members.length,
          onlineCount: onlineCount,
          activeProjects: appState.activeProjectCount,
        ),
        const SizedBox(height: 20),
        const _SectionTitle(title: '权限矩阵'),
        const SizedBox(height: 12),
        ...appState.rolePermissionMatrix
            .map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(item.role),
                  subtitle: Text(item.permissions.join(' · ')),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '项目级授权策略'),
        const SizedBox(height: 12),
        ...appState.projectPolicies
            .map(
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
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '成员状态'),
        const SizedBox(height: 12),
        ...appState.members
            .map(
              (member) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: member.online ? AppColors.brandSoft : const Color(0xFFE8EEF0),
                    child: Icon(
                      Icons.person_rounded,
                      color: member.online ? AppColors.brand : const Color(0xFF8A99A0),
                    ),
                  ),
                  title: Text(member.name),
                  subtitle: Text(member.role),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: member.online ? const Color(0xFFDFF4E6) : const Color(0xFFF0F3F4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      member.online ? '在线' : '离线',
                      style: TextStyle(
                        color: member.online ? AppColors.success : AppColors.subtitle,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '操作审计'),
        const SizedBox(height: 12),
        ...appState.audits
            .take(6)
            .map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(item.action),
                  subtitle: Text('${item.operator} · ${item.scope}'),
                  trailing: Text(item.time, style: const TextStyle(color: AppColors.subtitle, fontSize: 12)),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 8),
        const _SectionTitle(title: '最近动态'),
        const SizedBox(height: 12),
        if (appState.activities.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('暂无动态，完成任务或发起 AI 指令后会自动记录。'),
            ),
          )
        else
          ...appState.activities
              .map((item) => _ActivityTile(title: item.title, time: item.time))
              .toList(),
      ],
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader({
    required this.memberCount,
    required this.onlineCount,
    required this.activeProjects,
  });

  final int memberCount;
  final int onlineCount;
  final int activeProjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F1F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Workspace 治理中心',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.title),
          ),
          const SizedBox(height: 10),
          const Text(
            '聚合角色权限、授权策略、审计记录和动态事件，保证协作模块可管理可追溯。',
            style: TextStyle(height: 1.5, color: Color(0xFF51626A)),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: const CircleAvatar(
        backgroundColor: AppColors.brandSoft,
        child: Icon(Icons.bolt_rounded, color: AppColors.brand),
      ),
      title: Text(title),
      subtitle: Text(time),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.title,
      ),
    );
  }
}
