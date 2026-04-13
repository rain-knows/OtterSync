import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class ActivityFeedItem extends StatelessWidget {
  const ActivityFeedItem({super.key, required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: CircleAvatar(
        backgroundColor: palette.brandSoft,
        child: Icon(Icons.bolt_rounded, color: palette.brandAccent),
      ),
      title: Text(title),
      subtitle: Text(time),
    );
  }
}
