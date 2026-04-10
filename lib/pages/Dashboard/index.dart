import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/section_title.dart';
import 'package:ottersync/components/Dashboard/dashboard_chart_card.dart';
import 'package:ottersync/components/Dashboard/dashboard_metric_grid.dart';
import 'package:ottersync/components/Dashboard/dashboard_risk_and_load_card.dart';
import 'package:ottersync/components/Dashboard/dashboard_status_distribution_card.dart';
import 'package:ottersync/components/Dashboard/dashboard_summary_card.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        const SectionTitle(title: '项目 Dashboard'),
        const SizedBox(height: 12),
        DashboardMetricGrid(appState: appState),
        const SizedBox(height: 20),
        const SectionTitle(title: '交付趋势'),
        const SizedBox(height: 12),
        DashboardChartCard(bars: appState.weeklyCompletionTrend),
        const SizedBox(height: 20),
        const SectionTitle(title: '流程状态分布'),
        const SizedBox(height: 12),
        DashboardStatusDistributionCard(appState: appState),
        const SizedBox(height: 20),
        const SectionTitle(title: '风险分布与成员负载'),
        const SizedBox(height: 12),
        DashboardRiskAndLoadCard(appState: appState),
        const SizedBox(height: 20),
        const SectionTitle(title: '分析摘要'),
        const SizedBox(height: 12),
        DashboardSummaryCard(
          summaryText: appState.summaryText,
          suggestionText: appState.suggestionText,
        ),
      ],
    );
  }
}
