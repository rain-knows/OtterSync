import 'package:flutter/material.dart';

class AIInputBar extends StatelessWidget {
  const AIInputBar({
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

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
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
