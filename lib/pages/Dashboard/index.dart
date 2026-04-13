import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/SectionHeader.dart';
import 'package:ottersync/components/Dashboard/DashboardMetricCards.dart';
import 'package:ottersync/components/Dashboard/RiskLoadPanel.dart';
import 'package:ottersync/components/Dashboard/StatusBreakdownCard.dart';
import 'package:ottersync/components/Dashboard/SummaryPanel.dart';
import 'package:ottersync/components/Dashboard/TrendChartCard.dart';
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
        const SectionHeader(title: '项目 Dashboard'),
        const SizedBox(height: 12),
        DashboardMetricCards(appState: appState),
        const SizedBox(height: 20),
        const SectionHeader(title: '交付趋势'),
        const SizedBox(height: 12),
        TrendChartCard(bars: appState.weeklyCompletionTrend),
        const SizedBox(height: 20),
        const SectionHeader(title: '流程状态分布'),
        const SizedBox(height: 12),
        StatusBreakdownCard(appState: appState),
        const SizedBox(height: 20),
        const SectionHeader(title: '风险分布与成员负载'),
        const SizedBox(height: 12),
        RiskLoadPanel(appState: appState),
        const SizedBox(height: 20),
        const SectionHeader(title: '分析摘要'),
        const SizedBox(height: 12),
        SummaryPanel(
          summaryText: appState.summaryText,
          suggestionText: appState.suggestionText,
        ),
      ],
    );
  }
}
