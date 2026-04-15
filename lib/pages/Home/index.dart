import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/components/Common/SectionHeader.dart';
import 'package:ottersync/components/Common/UserAvatar.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/components/Home/HomeOverviewCard.dart';
import 'package:ottersync/components/Home/QuickAccessSection.dart';
import 'package:ottersync/components/Home/RecentProjectsCard.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_demo_data.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final theme = Theme.of(context);

    return ListView(
      padding: AppSpace.pagePaddingWithNav,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => context.push('/account'),
              borderRadius: BorderRadius.circular(999),
              child: const UserAvatar(label: 'MT'),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => showDemoFeedback(context, '创建工作项接口已预留。'),
              icon: Icon(
                Icons.add_rounded,
                color: palette.textSecondary,
                size: 34,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: palette.textSecondary,
              size: 34,
            ),
            hintText: '搜索',
            fillColor: palette.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: palette.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: palette.border),
            ),
          ),
        ),
        const SizedBox(height: 26),
        SectionHeader(
          title: '今日概述',
          action: Icon(
            Icons.expand_more_rounded,
            color: palette.textPrimary,
            size: 34,
          ),
        ),
        const SizedBox(height: 16),
        HomeOverviewCard(
          onCopy: () => showDemoFeedback(context, '摘要内容复制接口已预留。'),
          onLike: () => showDemoFeedback(context, '反馈提交接口已预留。'),
          onDislike: () => showDemoFeedback(context, '反馈提交接口已预留。'),
          onMore: () => showDemoFeedback(context, '更多动态接口已预留。'),
        ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '快速访问',
          action: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '编辑',
                style: TextStyle(color: palette.primary, fontSize: 16),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.expand_more_rounded,
                color: palette.textPrimary,
                size: 28,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QuickAccessSection(
          items: JiraDemoData.homeQuickAccess,
          onItemTap: (item) {
            if (item.route != null) {
              context.push(item.route!);
              return;
            }
            showDemoFeedback(context, '${item.title} 交互入口已预留。');
          },
        ),
        const SizedBox(height: 28),
        SectionHeader(
          title: '最近项目',
          action: Icon(
            Icons.expand_more_rounded,
            color: palette.textPrimary,
            size: 34,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '今天',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        RecentProjectsCard(
          items: JiraDemoData.recentProjects,
          onItemTap: (item) =>
              showDemoFeedback(context, '将打开 ${item.key} 的详情页。'),
        ),
      ],
    );
  }
}
