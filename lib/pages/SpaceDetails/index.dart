import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/components/SpaceDetails/BacklogTabView.dart';
import 'package:ottersync/components/SpaceDetails/BoardTabView.dart';
import 'package:ottersync/components/SpaceDetails/CalendarTabView.dart';
import 'package:ottersync/components/SpaceDetails/FormsTabView.dart';
import 'package:ottersync/components/SpaceDetails/SummaryTabView.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_demo_data.dart';

class SpaceDetailsView extends StatelessWidget {
  const SpaceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return DefaultTabController(
      length: 5,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              titleSpacing: 0,
              title: Row(
                children: [
                  Text(
                    'ottersync',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: palette.textSecondary,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () => showDemoFeedback(context, '空间筛选接口已预留。'),
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
                IconButton(
                  onPressed: () => showDemoFeedback(context, '更多空间操作接口已预留。'),
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                dividerColor: palette.divider,
                labelColor: palette.primary,
                unselectedLabelColor: palette.textSecondary,
                indicatorColor: palette.primary,
                tabAlignment: TabAlignment.start,
                tabs: const [
                  Tab(text: '摘要'),
                  Tab(text: '面板'),
                  Tab(text: '日历'),
                  Tab(text: '表单'),
                  Tab(text: '待办事项列表'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SummaryTabView(
                  metrics: JiraDemoData.summaryMetrics,
                  onStatusTap: (status) =>
                      showDemoFeedback(context, '将按$status筛选工作项。'),
                ),
                BoardTabView(
                  onOpenBacklog: () =>
                      DefaultTabController.of(context).animateTo(4),
                ),
                CalendarTabView(filters: JiraDemoData.calendarFilters),
                const FormsTabView(),
                BacklogTabView(
                  groups: JiraDemoData.backlogGroups,
                  onCreate: () => showDemoFeedback(context, '创建待办事项接口已预留。'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
