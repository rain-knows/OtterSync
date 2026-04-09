import 'package:flutter/material.dart';

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        _ProfileCard(),
        SizedBox(height: 20),
        _SettingTile(
          icon: Icons.assignment_rounded,
          title: '我的任务',
          subtitle: '查看负责的 Story、Bug 和审核记录',
        ),
        _SettingTile(
          icon: Icons.schedule_rounded,
          title: '工时记录',
          subtitle: '统计每日投入并回填项目 Dashboard',
        ),
        _SettingTile(
          icon: Icons.notifications_active_rounded,
          title: '通知中心',
          subtitle: '任务提醒、测试反馈、权限变更',
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFFD7EEF2),
                child: Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: Color(0xFF0E5E6F),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '第 2 小组成员',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Flutter 页面框架设计中',
                    style: TextStyle(color: Color(0xFF6B7B83)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            '这里后续可扩展个人资料、偏好设置、消息中心、访问令牌和版本信息。',
            style: TextStyle(height: 1.6, color: Color(0xFF51626A)),
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
          backgroundColor: const Color(0xFFD7EEF2),
          child: Icon(icon, color: const Color(0xFF0E5E6F)),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
