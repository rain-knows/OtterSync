import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class WorkspaceActivityTile extends StatelessWidget {
  const WorkspaceActivityTile({
    super.key,
    required this.title,
    required this.time,
  });

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: const CircleAvatar(
        backgroundColor: AppColors.brandSoft,
        child: Icon(Icons.bolt_rounded, color: AppColors.brand),
      ),
      title: Text(title),
      subtitle: Text(time),
    );
  }
}
