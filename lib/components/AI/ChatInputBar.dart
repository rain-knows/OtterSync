import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final canSend = controller.text.trim().isNotEmpty;
    final palette = AppThemePalette.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: palette.panel.withValues(alpha: 0.96),
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: false,
                hintText: '输入指令，例如：拆分高优任务 / 同步风险 / 生成日报',
              ),
              onChanged: onChanged,
              onSubmitted: (_) {
                if (canSend) {
                  onSend();
                }
              },
            ),
          ),
          FilledButton(
            onPressed: canSend ? onSend : null,
            child: const Text('发送'),
          ),
        ],
      ),
    );
  }
}
