import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/SectionHeader.dart';
import 'package:ottersync/components/Home/HomeHeroSection.dart';
import 'package:ottersync/components/Home/LayerProgressCard.dart';
import 'package:ottersync/components/Home/ProjectOverviewCard.dart';
import 'package:ottersync/components/Home/QuickCreateBar.dart';
import 'package:ottersync/components/Home/TaskOverviewCard.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

enum _TaskFilter { all, pending, completed, risk }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  _TaskFilter _filter = _TaskFilter.pending;
  final TextEditingController _quickAddController = TextEditingController();
  bool _canQuickAdd = false;

  @override
  void dispose() {
    _quickAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final tasks = switch (_filter) {
      _TaskFilter.all => appState.tasks,
      _TaskFilter.pending =>
        appState.tasks.where((task) => !task.done).toList(),
      _TaskFilter.completed =>
        appState.tasks.where((task) => task.done).toList(),
      _TaskFilter.risk =>
        appState.tasks.where((task) => !task.done && task.isRisk).toList(),
    };

    return ListView(
      padding: AppSpace.pagePadding,
      children: [
        HomeHeroSection(appState: appState),
        const SizedBox(height: 20),
        const SectionHeader(title: '完成度分层验收'),
        const SizedBox(height: 12),
        ...appState.completionLayers.map(
          (layer) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: LayerProgressCard(layer: layer),
          ),
        ),
        const SizedBox(height: 8),
        const SectionHeader(title: '项目推进'),
        const SizedBox(height: 12),
        ...appState.projectProgressList.map(
          (project) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProjectOverviewCard(
              title: project.title,
              progress: project.progress,
              meta: project.meta,
              accent: project.accent,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SectionHeader(title: '任务流程闭环'),
        const SizedBox(height: 12),
        QuickCreateBar(
          controller: _quickAddController,
          canSubmit: _canQuickAdd,
          onChanged: (value) =>
              setState(() => _canQuickAdd = value.trim().isNotEmpty),
          onSubmit: () {
            final created = appState.addTask(_quickAddController.text);
            if (created) {
              _quickAddController.clear();
              setState(() => _canQuickAdd = false);
            }
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('全部'),
              selected: _filter == _TaskFilter.all,
              onSelected: (_) => setState(() => _filter = _TaskFilter.all),
            ),
            FilterChip(
              label: const Text('进行中'),
              selected: _filter == _TaskFilter.pending,
              onSelected: (_) => setState(() => _filter = _TaskFilter.pending),
            ),
            FilterChip(
              label: const Text('已完成'),
              selected: _filter == _TaskFilter.completed,
              onSelected: (_) =>
                  setState(() => _filter = _TaskFilter.completed),
            ),
            FilterChip(
              label: const Text('风险'),
              selected: _filter == _TaskFilter.risk,
              onSelected: (_) => setState(() => _filter = _TaskFilter.risk),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (tasks.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text('当前筛选下暂无任务。'),
            ),
          )
        else
          ...tasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskOverviewCard(task: task),
            ),
          ),
      ],
    );
  }
}
