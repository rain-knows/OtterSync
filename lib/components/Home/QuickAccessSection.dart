import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/theme/design_tokens.dart';
import 'package:ottersync/viewmodels/jira_models.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final List<QuickAccessItem> items;
  final ValueChanged<QuickAccessItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final wideItem = items.first;
    final gridItems = items.skip(1).toList();

    return Column(
      children: [
        InkWell(
          onTap: () => onItemTap(wideItem),
          child: AppSurface(
            margin: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                _FeatureIcon(icon: wideItem.icon, color: wideItem.color),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wideItem.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        wideItem.subtitle,
                        style: const TextStyle(
                          color: Color(0xFF8E4BC3),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                if (wideItem.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: wideItem.color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      wideItem.badge!,
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.2,
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return InkWell(
              onTap: () => onItemTap(item),
              borderRadius: BorderRadius.circular(AppSpace.radiusLarge),
              child: AppSurface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FeatureIcon(icon: item.icon, color: item.color),
                    const Spacer(),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, size: 32, color: const Color(0xFF6B3FA0)),
    );
  }
}
