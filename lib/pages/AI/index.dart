import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class AIView extends StatefulWidget {
  const AIView({super.key});

  @override
  State<AIView> createState() => _AIViewState();
}

class _AIViewState extends State<AIView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send(AppState appState) {
    appState.sendAiMessage(_controller.text);
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: AppSpace.pagePadding,
            children: [
              const _AIHero(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: appState.promptTemplates
                    .map(
                      (item) => ActionChip(
                        label: Text(item),
                        onPressed: () => appState.sendPrompt(item),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text('执行建议', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              if (appState.suggestions.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text('暂无建议，可输入“拆分/风险/日报”触发。'),
                  ),
                )
              else
                ...appState.suggestions
                    .map(
                      (item) => Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.description),
                          trailing: item.executed
                              ? const Text('已执行', style: TextStyle(color: AppColors.success))
                              : FilledButton.tonal(
                                  onPressed: () => appState.executeSuggestion(item.id),
                                  child: const Text('确认执行'),
                                ),
                        ),
                      ),
                    )
                    .toList(),
              const SizedBox(height: 10),
              ...appState.aiMessages
                  .map((message) => _Bubble(isMe: message.isMine, text: message.text))
                  .toList(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          child: _InputBar(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            onSend: () => _send(appState),
          ),
        ),
      ],
    );
  }
}

class _AIHero extends StatelessWidget {
  const _AIHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [Color(0xFF16343D), Color(0xFF315C67)]),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'AI 执行助手',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '支持建议-确认-执行-回写闭环：任务拆分、风险同步、日报汇总。',
            style: TextStyle(color: Color(0xFFD8E9ED), height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.isMe, required this.text});

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
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
          child: Text(text, style: TextStyle(color: textColor, height: 1.5)),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
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
          FilledButton(onPressed: canSend ? onSend : null, child: const Text('发送')),
        ],
      ),
    );
  }
}
