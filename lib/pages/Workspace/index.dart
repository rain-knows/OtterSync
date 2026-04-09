import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final onlineCount = appState.members.where((member) => member.online).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        _WorkspaceHeader(
          memberCount: appState.members.length,
          onlineCount: onlineCount,
          activeProjects: appState.activeProjectCount,
        ),
        const SizedBox(height: 20),
        const _SectionTitle(title: '组织与权限'),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.apartment_rounded,
          title: '当前工作区',
          content:
              '第 2 小组协作空间 · 活跃项目 ${appState.activeProjectCount} 个，成员 ${appState.members.length} 人。',
        ),
        const SizedBox(height: 12),
        const _InfoCard(
          icon: Icons.lock_person_rounded,
          title: '权限治理',
          content: '支持管理员、成员、访客三级访问控制，可按项目细粒度授权。',
        ),
        const SizedBox(height: 20),
        const _SectionTitle(title: '成员状态'),
        const SizedBox(height: 12),
        ...appState.members
            .map(
              (member) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: member.online
                        ? const Color(0xFFD7EEF2)
                        : const Color(0xFFE8EEF0),
                    child: Icon(
                      Icons.person_rounded,
                      color: member.online
                          ? const Color(0xFF0E5E6F)
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
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFF6B7B83),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: 10),
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
              .map(
                (item) => _ActivityTile(title: item.title, time: item.time),
              )
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
            '工作区与群组',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF132026),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '聚合成员、角色、权限与协作动态，为后续邀请、审批和共享流程提供基础。',
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFD7EEF2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF0E5E6F)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Color(0xFF6B7B83),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
        backgroundColor: Color(0xFFD7EEF2),
        child: Icon(Icons.bolt_rounded, color: Color(0xFF0E5E6F)),
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
        color: const Color(0xFF132026),
      ),
    );
  }
}
