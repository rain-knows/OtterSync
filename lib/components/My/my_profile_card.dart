import 'package:flutter/material.dart';
import 'package:ottersync/state/app_state.dart';
import 'package:ottersync/theme/design_tokens.dart';

class MyProfileCard extends StatelessWidget {
  const MyProfileCard({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.brandSoft,
                child: Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: AppColors.brand,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '第 2 小组成员',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '复杂流程与质量基线推进中',
                    style: TextStyle(color: AppColors.subtitle),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '当前任务完成率 ${(appState.completionRate * 100).round()}%，AI 执行 ${appState.executedSuggestionCount} 次，已具备跨页面回写能力。',
            style: const TextStyle(height: 1.6, color: Color(0xFF51626A)),
          ),
          const SizedBox(height: 14),
          LinearProgressIndicator(
            value: appState.completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
            backgroundColor: const Color(0xFFE7EFF1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brand),
          ),
        ],
      ),
    );
  }
}
