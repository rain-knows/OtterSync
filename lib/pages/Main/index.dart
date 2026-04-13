import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ottersync/theme/design_tokens.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

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

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [palette.panel, palette.canvas],
          ),
        ),
        child: SafeArea(child: widget.navigationShell),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
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
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
