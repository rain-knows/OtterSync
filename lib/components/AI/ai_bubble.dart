import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class AIBubble extends StatelessWidget {
  const AIBubble({super.key, required this.isMe, required this.text});

  final bool isMe;
  final String text;

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? AppColors.brand : Colors.white;
    final textColor = isMe ? Colors.white : AppColors.title;

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
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(text, style: TextStyle(color: textColor, height: 1.5)),
        ),
      ),
    );
  }
}
