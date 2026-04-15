import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/components/Common/UserAvatar.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/components/Dashboard/AssignedIssuesCard.dart';
import 'package:ottersync/components/Dashboard/DashboardActivityCard.dart';
import 'package:ottersync/components/Dashboard/DashboardFeedbackCard.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_demo_data.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppThemePalette.of(context);

    return ListView(
      padding: AppSpace.pagePaddingWithNav,
      children: [
        InkWell(
          onTap: () => context.push('/account'),
          borderRadius: BorderRadius.circular(999),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: UserAvatar(label: 'MT'),
          ),
        ),
        const SizedBox(height: 18),
        Text('仪表板', style: theme.textTheme.headlineLarge),
        const SizedBox(height: 18),
        AppSurface(
          child: InkWell(
            onTap: () => showDemoFeedback(context, '仪表板切换接口已预留。'),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Default dashboard',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: palette.textPrimary,
                  size: 34,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        AssignedIssuesCard(
          issues: JiraDemoData.assignedIssues,
          onIssueTap: (item) => showDemoFeedback(context, '将打开 ${item.key}。'),
        ),
        const SizedBox(height: 18),
        DashboardActivityCard(
          activities: JiraDemoData.dashboardActivities,
          onActivityTap: (item) =>
              showDemoFeedback(context, '将打开 ${item.issue} 的活动详情。'),
        ),
        const SizedBox(height: 18),
        DashboardFeedbackCard(
          onTap: () => showDemoFeedback(context, '反馈提交接口已预留。'),
        ),
      ],
    );
  }
}
