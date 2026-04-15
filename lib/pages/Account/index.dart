import 'package:flutter/material.dart';
import 'package:ottersync/components/Account/AccountActionList.dart';
import 'package:ottersync/components/Account/AccountProfileCard.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/theme/design_tokens.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const items = [
      AccountActionItem(
        title: '邀请人员访问该网站',
        icon: Icons.person_add_alt_1_outlined,
      ),
      AccountActionItem(title: '通知设置', icon: Icons.notifications_none_rounded),
      AccountActionItem(title: '提供反馈', icon: Icons.mail_outline_rounded),
      AccountActionItem(title: '评价我们', icon: Icons.star_border_rounded),
      AccountActionItem(
        title: '更多 Atlassian 应用',
        icon: Icons.grid_view_rounded,
      ),
      AccountActionItem(title: '设置', icon: Icons.settings_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('账户', style: theme.textTheme.headlineMedium),
      ),
      body: ListView(
        padding: AppSpace.pagePadding,
        children: [
          AccountProfileCard(
            onAddSite: () => showDemoFeedback(context, '后续可在这里接入站点新增流程。'),
          ),
          const SizedBox(height: 18),
          AccountActionList(
            items: items,
            onTap: (item) =>
                showDemoFeedback(context, '${item.title} 入口已保留，可直接接后端。'),
          ),
        ],
      ),
    );
  }
}
