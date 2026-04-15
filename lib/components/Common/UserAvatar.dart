import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.label,
    this.size = 48,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? palette.avatar,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor ?? const Color(0xFF09326C),
          fontWeight: FontWeight.w700,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}
