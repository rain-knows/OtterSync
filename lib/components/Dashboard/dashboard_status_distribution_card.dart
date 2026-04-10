import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';

class DashboardStatusDistributionCard extends StatelessWidget {
  const DashboardStatusDistributionCard({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final statusMap = appState.workflowStatusCount;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: statusMap.entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(appState.statusLabel(entry.key)),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: appState.tasks.isEmpty
                              ? 0
                              : entry.value / appState.tasks.length,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.value.toString()),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
