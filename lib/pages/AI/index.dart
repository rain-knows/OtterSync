import 'package:flutter/material.dart';

class AIView extends StatelessWidget {
  const AIView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        _AIHero(),
        SizedBox(height: 20),
        _PromptRow(),
        SizedBox(height: 20),
        _Bubble(isMe: false, text: '我可以帮助你生成测试步骤、梳理任务依赖、总结日报，或将自然语言转成系统操作建议。'),
        _Bubble(isMe: true, text: '帮我拆分 “移动端页面框架搭建” 这个 Story，并给出优先级建议。'),
        _Bubble(
          isMe: false,
          text: '建议优先完成底部导航、项目首页、AI 页面、Dashboard 占位图表，再补任务详情与权限管理细节。',
        ),
        SizedBox(height: 20),
        _InputBar(),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF16343D), Color(0xFF315C67)],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'AI 智能辅助',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '后续这里可接入自然语言问答、测试用例生成、代码建议、任务流转触发等能力。',
            style: TextStyle(color: Color(0xFFD8E9ED), height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _PromptRow extends StatelessWidget {
  const _PromptRow();

  @override
  Widget build(BuildContext context) {
    const prompts = ['生成测试步骤', '总结 Sprint 风险', '输出日报草稿'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: prompts
          .map(
            (item) => Chip(
              label: Text(item),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          )
          .toList(),
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
    final color = isMe ? const Color(0xFF0E5E6F) : Colors.white;
    final textColor = isMe ? Colors.white : const Color(0xFF132026);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: alignment,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
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

class _InputBar extends StatelessWidget {
  const _InputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '输入你的问题或操作指令...',
              style: TextStyle(color: Color(0xFF8A99A0)),
            ),
          ),
          FilledButton(onPressed: () {}, child: const Text('发送')),
        ],
      ),
    );
  }
}
