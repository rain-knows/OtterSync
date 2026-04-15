import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_models.dart';

enum AllWorkViewMode { list, grid }

class AllWorkToolbar extends StatelessWidget {
  const AllWorkToolbar({
    super.key,
    required this.selectedFilter,
    required this.viewMode,
    required this.onFilterTap,
    required this.onViewModeChanged,
  });

  final FilterItem selectedFilter;
  final AllWorkViewMode viewMode;
  final VoidCallback onFilterTap;
  final ValueChanged<AllWorkViewMode> onViewModeChanged;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 84,
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: palette.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: palette.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      selectedFilter.icon,
                      color: palette.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      selectedFilter.title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(fontSize: 22),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: palette.textPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _ViewModeButton(
          icon: Icons.view_headline_rounded,
          selected: viewMode == AllWorkViewMode.list,
          onTap: () => onViewModeChanged(AllWorkViewMode.list),
        ),
        const SizedBox(width: 12),
        _ViewModeButton(
          icon: Icons.grid_view_rounded,
          selected: viewMode == AllWorkViewMode.grid,
          onTap: () => onViewModeChanged(AllWorkViewMode.grid),
        ),
      ],
    );
  }
}

class _ViewModeButton extends StatelessWidget {
  const _ViewModeButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 108,
        height: 84,
        decoration: BoxDecoration(
          color: selected ? palette.primarySoft : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: palette.border),
        ),
        child: Icon(
          icon,
          color: selected ? palette.primary : palette.textSecondary,
          size: 38,
        ),
      ),
    );
  }
}
