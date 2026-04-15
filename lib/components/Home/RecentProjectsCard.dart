import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/components/Common/IssueListTile.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_models.dart';

class RecentProjectsCard extends StatelessWidget {
  const RecentProjectsCard({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final List<JiraIssueSummary> items;
  final ValueChanged<JiraIssueSummary> onItemTap;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return AppSurface(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: items
            .asMap()
            .entries
            .map(
              (entry) => Column(
                children: [
                  InkWell(
                    onTap: () => onItemTap(entry.value),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: IssueListTile(
                        title: entry.value.title,
                        subtitle:
                            '${entry.value.key} • ${entry.value.subtitle}',
                      ),
                    ),
                  ),
                  if (entry.key != items.length - 1)
                    Divider(
                      height: 1,
                      color: palette.divider,
                      indent: 70,
                      endIndent: 16,
                    ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
