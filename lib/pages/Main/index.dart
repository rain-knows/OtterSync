import 'package:flutter/material.dart';
import 'package:ottersync/pages/AI/index.dart';
import 'package:ottersync/pages/Dashboard/index.dart';
import 'package:ottersync/pages/Home/index.dart';
import 'package:ottersync/pages/My/index.dart';
import 'package:ottersync/pages/Workspace/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _TabItem {
  const _TabItem({
    required this.icon,
    required this.selectedIcon,
    required this.text,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String text;
}

class _MainPageState extends State<MainPage> {
  final List<_TabItem> _tabList = const [
    _TabItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      text: '项目',
    ),
    _TabItem(
      icon: Icons.groups_2_outlined,
      selectedIcon: Icons.groups_2_rounded,
      text: '工作区',
    ),
    _TabItem(
      icon: Icons.auto_awesome_outlined,
      selectedIcon: Icons.auto_awesome_rounded,
      text: 'AI',
    ),
    _TabItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics_rounded,
      text: '分析',
    ),
    _TabItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person_rounded,
      text: '我的',
    ),
  ];

  int _currentIndex = 0;

  List<Widget> _getChildren() {
    return const [
      HomeView(),
      WorkspaceView(),
      AIView(),
      DashboardView(),
      MyView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: KeyedSubtree(
            key: ValueKey(_currentIndex),
            child: _getChildren()[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: _tabList
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.text,
              ),
            )
            .toList(),
        onDestinationSelected: (int index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
