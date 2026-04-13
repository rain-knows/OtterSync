import 'package:flutter/material.dart';
import 'package:ottersync/theme/design_tokens.dart';

class AIHeroSection extends StatelessWidget {
  const AIHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppThemePalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        border: Border.all(color: palette.borderStrong),
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF131521), Color(0xFF0E1016), Color(0xFF262D58)]
              : const [Color(0xFFF4F5FF), Color(0xFFFFFFFF), Color(0xFFEAEDFF)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: palette.brandAccent),
              const SizedBox(width: 10),
              Text(
                'AI 执行助手',
                style: TextStyle(
                  color: palette.title,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '支持建议-确认-执行-回写闭环：任务拆分、风险同步、日报汇总。',
            style: TextStyle(color: palette.text, height: 1.5),
          ),
        ],
      ),
    );
  }
}
