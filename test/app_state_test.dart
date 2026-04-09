import 'package:flutter_test/flutter_test.dart';
import 'package:ottersync/state/app_state.dart';

void main() {
  group('AppState workflow', () {
    test('createTask should append new task with backlog status', () {
      final state = AppState();
      final before = state.tasks.length;

      final created = state.createTask(
        title: '新增复杂任务',
        projectId: state.projects.first.id,
        assigneeId: state.members.first.id,
        priority: TaskPriority.high,
        dueText: '今天',
      );

      expect(created, isTrue);
      expect(state.tasks.length, before + 1);
      expect(state.tasks.first.status, TaskStatus.backlog);
    });

    test('updateTaskStatus should record history and update status', () {
      final state = AppState();
      final id = state.tasks.first.id;

      state.updateTaskStatus(id: id, status: TaskStatus.done);

      expect(state.tasks.first.status, TaskStatus.done);
      expect(state.tasks.first.history.first.message, contains('状态更新为'));
    });

    test('sendAiMessage should generate executable suggestion for risk input', () {
      final state = AppState();
      final before = state.suggestions.length;

      state.sendAiMessage('请总结风险');

      expect(state.suggestions.length, before + 1);
      expect(state.suggestions.first.executed, isFalse);
      expect(state.suggestions.first.type, AiSuggestionType.syncRiskSummary);
    });

    test('executeSuggestion should mark suggestion executed', () {
      final state = AppState();
      final id = state.suggestions.first.id;

      state.executeSuggestion(id);

      expect(state.suggestions.first.id, id);
      expect(state.suggestions.first.executed, isTrue);
    });
  });
}
