import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/components/AllWork/AllWorkToolbar.dart';
import 'package:ottersync/components/AllWork/FilterSheet.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/components/Common/IssueListTile.dart';
import 'package:ottersync/components/Common/UserAvatar.dart';
import 'package:ottersync/components/Common/demo_feedback.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_demo_data.dart';
import 'package:ottersync/viewmodels/jira_models.dart';

class AllWorkView extends StatefulWidget {
  const AllWorkView({super.key});

  @override
  State<AllWorkView> createState() => _AllWorkViewState();
}

class _AllWorkViewState extends State<AllWorkView> {
  FilterItem _selectedFilter = JiraDemoData.filters.first;
  AllWorkViewMode _viewMode = AllWorkViewMode.list;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final issues = JiraDemoData.recentProjects.take(2).toList();

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
            const SizedBox(width: 16),
            Expanded(child: Text('所有工作', style: theme.textTheme.headlineLarge)),
            IconButton(
              onPressed: () => showDemoFeedback(context, '搜索工作项接口已预留。'),
              icon: const Icon(Icons.search_rounded, size: 34),
            ),
            IconButton(
              onPressed: () => showDemoFeedback(context, '创建工作项接口已预留。'),
              icon: const Icon(Icons.add_rounded, size: 34),
            ),
          ],
        ),
        const SizedBox(height: 18),
        AllWorkToolbar(
          selectedFilter: _selectedFilter,
          viewMode: _viewMode,
          onFilterTap: _openFilterSheet,
          onViewModeChanged: (mode) => setState(() => _viewMode = mode),
        ),
        const SizedBox(height: 30),
        Text('待办', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 16),
        _viewMode == AllWorkViewMode.list
            ? AppSurface(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: issues
                      .asMap()
                      .entries
                      .map(
                        (entry) => Column(
                          children: [
                            InkWell(
                              onTap: () => showDemoFeedback(
                                context,
                                '将打开 ${entry.value.key}。',
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: IssueListTile(
                                  title: entry.value.title,
                                  subtitle: entry.value.key,
                                  compact: true,
                                ),
                              ),
                            ),
                            if (entry.key != issues.length - 1)
                              const Divider(
                                height: 1,
                                indent: 70,
                                endIndent: 16,
                              ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.2,
                ),
                itemCount: issues.length,
                itemBuilder: (context, index) {
                  final item = issues[index];
                  return InkWell(
                    onTap: () => showDemoFeedback(context, '将打开 ${item.key}。'),
                    child: AppSurface(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_box_outline_blank_rounded,
                            size: 34,
                          ),
                          const Spacer(),
                          Text(item.title, style: theme.textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(item.key, style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }

  Future<void> _openFilterSheet() async {
    final filter = await showModalBottomSheet<FilterItem>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterSheet(
        recentFilter: _selectedFilter,
        filters: JiraDemoData.filters,
        onCreate: () => showDemoFeedback(context, '创建筛选器接口已预留。'),
      ),
    );
    if (filter != null) {
      setState(() => _selectedFilter = filter);
    }
  }
}
