import 'package:flutter/material.dart';

class HomeQuickAddCard extends StatelessWidget {
  const HomeQuickAddCard({
    super.key,
    required this.controller,
    required this.canSubmit,
    required this.onChanged,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool canSubmit;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '快速创建任务并纳入流程跟踪...',
                ),
                onChanged: onChanged,
                onSubmitted: (_) {
                  if (canSubmit) {
                    onSubmit();
                  }
                },
              ),
            ),
            FilledButton(
              onPressed: canSubmit ? onSubmit : null,
              child: const Text('创建'),
            ),
          ],
        ),
      ),
    );
  }
}
