import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class MySettingTile extends StatelessWidget {
  const MySettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minTileHeight: 76,
        leading: CircleAvatar(
          backgroundColor: AppColors.brandSoft,
          child: Icon(icon, color: AppColors.brand),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
