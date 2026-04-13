import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isMe, required this.text});

  final bool isMe;
  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);

    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe
        ? palette.brand.withValues(alpha: 0.92)
        : palette.surface.withValues(alpha: 0.95);
    final textColor = isMe ? Colors.white : palette.text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: alignment,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          constraints: const BoxConstraints(maxWidth: 290),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: palette.border),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(text, style: TextStyle(color: textColor, height: 1.5)),
        ),
      ),
    );
  }
}
