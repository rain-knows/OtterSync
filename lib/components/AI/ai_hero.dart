import 'package:flutter/material.dart';

class AIHero extends StatelessWidget {
  const AIHero({super.key});

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
                'AI 执行助手',
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
            '支持建议-确认-执行-回写闭环：任务拆分、风险同步、日报汇总。',
            style: TextStyle(color: Color(0xFFD8E9ED), height: 1.5),
          ),
        ],
      ),
    );
  }
}
