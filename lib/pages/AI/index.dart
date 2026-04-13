import 'package:flutter/material.dart';
import 'package:ottersync/components/AI/AIHeroSection.dart';
import 'package:ottersync/components/AI/ChatBubble.dart';
import 'package:ottersync/components/AI/ChatInputBar.dart';
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
    final palette = AppThemePalette.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: AppSpace.pagePadding,
            children: [
              const AIHeroSection(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: appState.promptTemplates
                    .map(
                      (item) => ActionChip(
                        label: Text(item),
                        onPressed: () => appState.sendPrompt(item),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              Text(
                '执行建议',
                style: TextStyle(
                  color: palette.title,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              if (appState.suggestions.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text('暂无建议，可输入“拆分/风险/日报”触发。'),
                  ),
                )
              else
                ...appState.suggestions.map(
                  (item) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description),
                      trailing: item.executed
                          ? Text(
                              '已执行',
                              style: TextStyle(color: palette.success),
                            )
                          : FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                backgroundColor: palette.brandSoft,
                                foregroundColor: palette.brandAccent,
                              ),
                              onPressed: () =>
                                  appState.executeSuggestion(item.id),
                              child: const Text('确认执行'),
                            ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ...appState.aiMessages.map(
                (message) =>
                    ChatBubble(isMe: message.isMine, text: message.text),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
          child: ChatInputBar(
            controller: _controller,
            onChanged: (_) => setState(() {}),
            onSend: () => _send(appState),
          ),
        ),
      ],
    );
  }
}
