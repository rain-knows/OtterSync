import 'package:flutter/material.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        _WorkspaceHeader(),
        SizedBox(height: 20),
        _SectionTitle(title: '组织与权限'),
        SizedBox(height: 12),
        _InfoCard(
          icon: Icons.apartment_rounded,
          title: '当前工作区',
          content: '第 2 小组协作空间 · 项目管理员 1 人，成员 6 人，访客 2 人',
        ),
        SizedBox(height: 12),
        _InfoCard(
          icon: Icons.lock_person_rounded,
          title: '权限治理',
          content: '支持项目管理员、普通成员、外部访客三级访问控制，并可按项目授予权限。',
        ),
        SizedBox(height: 20),
        _SectionTitle(title: '最近动态'),
        SizedBox(height: 12),
        _ActivityTile(title: '张怡博更新了任务状态', time: '10 分钟前'),
        _ActivityTile(title: '王行健创建了 Sprint 规划', time: '今天 09:20'),
        _ActivityTile(title: '测试组提交了审核反馈', time: '昨天 18:40'),
      ],
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F1F4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '工作区与群组',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF132026),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '这里聚合团队成员、群组、权限配置与协作动态，后续可继续补邀请、审批与共享流。',
            style: TextStyle(height: 1.5, color: Color(0xFF51626A)),
          ),
        ],
      ),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
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
