import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/components/Common/SectionHeader.dart';
import 'package:ottersync/components/Common/UserAvatar.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/components/Spaces/SpaceCard.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_demo_data.dart';
import 'package:ottersync/viewmodels/jira_models.dart';

class SpacesView extends StatelessWidget {
  const SpacesView({super.key});

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
              onPressed: () => showDemoFeedback(context, '搜索空间接口已预留。'),
              icon: const Icon(Icons.search_rounded, size: 34),
            ),
            IconButton(
              onPressed: () => showDemoFeedback(context, '创建空间接口已预留。'),
              icon: const Icon(Icons.add_rounded, size: 34),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text('空间', style: theme.textTheme.headlineLarge),
        const SizedBox(height: 28),
        const SectionHeader(title: '最近查看'),
        const SizedBox(height: 14),
        SpaceCard(
          space: const JiraSpace(name: 'ottersync', key: '最近查看'),
          onTap: () => context.push('/space-details'),
        ),
        const SizedBox(height: 26),
        const SectionHeader(title: '所有空间'),
        const SizedBox(height: 14),
        ...JiraDemoData.spaces.map(
          (space) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SpaceCard(
              space: space,
              onTap: () => context.push('/space-details'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        AppSurface(
          color: palette.surfaceInset,
          child: Text(
            '空间页在两种主题下都保持相同布局，只切换颜色层级和边框对比度。',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
