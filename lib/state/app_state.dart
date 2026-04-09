import 'package:flutter/material.dart';

enum TaskPriority { high, medium, low }

class TaskItem {
  TaskItem({
    required this.id,
    required this.title,
    required this.project,
    required this.priority,
    required this.dueText,
    this.done = false,
  });

  final String id;
  final String title;
  final String project;
  final TaskPriority priority;
  final String dueText;
  bool done;
}

class ProjectProgress {
  const ProjectProgress({
    required this.title,
    required this.progress,
    required this.meta,
    required this.accent,
  });

  final String title;
  final double progress;
  final String meta;
  final Color accent;
}

class WorkspaceMember {
  const WorkspaceMember({
    required this.name,
    required this.role,
    required this.online,
  });

  final String name;
  final String role;
  final bool online;
}

class WorkspaceActivity {
  const WorkspaceActivity({required this.title, required this.time});

  final String title;
  final String time;
}

class AIMessage {
  const AIMessage({required this.isMine, required this.text, required this.time});

  final bool isMine;
  final String text;
  final DateTime time;
}

class AppState extends ChangeNotifier {
  final List<TaskItem> _tasks = [
    TaskItem(
      id: 't-1',
      title: '搭建底部导航与主页面框架',
      project: 'OtterSync 移动端适配',
      priority: TaskPriority.high,
      dueText: '今天截止',
      done: true,
    ),
    TaskItem(
      id: 't-2',
      title: '补充 Dashboard 指标和趋势图',
      project: 'OtterSync 移动端适配',
      priority: TaskPriority.medium,
      dueText: '明天下午',
    ),
    TaskItem(
      id: 't-3',
      title: '实现 AI 对话输入与回复逻辑',
      project: 'AI 辅助任务流原型',
      priority: TaskPriority.high,
      dueText: '本周内',
    ),
    TaskItem(
      id: 't-4',
      title: '整理 Workspace 成员与权限数据',
      project: '协作空间治理',
      priority: TaskPriority.medium,
      dueText: '周五前',
      done: true,
    ),
    TaskItem(
      id: 't-5',
      title: '补齐个人中心统计联动',
      project: '协作空间治理',
      priority: TaskPriority.low,
      dueText: '下周一',
    ),
  ];

  final List<WorkspaceMember> members = const [
    WorkspaceMember(name: '张怡博', role: '项目管理员', online: true),
    WorkspaceMember(name: '王行健', role: '开发负责人', online: true),
    WorkspaceMember(name: '林雯', role: '测试工程师', online: false),
    WorkspaceMember(name: '赵可', role: '产品经理', online: true),
  ];

  final List<WorkspaceActivity> _activities = [
    WorkspaceActivity(title: '张怡博更新了任务状态', time: '10 分钟前'),
    WorkspaceActivity(title: '王行健创建了 Sprint 规划', time: '今天 09:20'),
    WorkspaceActivity(title: '测试组提交了审核反馈', time: '昨天 18:40'),
  ];

  final List<String> promptTemplates = const [
    '生成测试步骤',
    '总结 Sprint 风险',
    '输出日报草稿',
  ];

  final List<AIMessage> _messages = [
    AIMessage(
      isMine: false,
      text: '我可以帮助你生成测试步骤、梳理任务依赖、总结日报，或将自然语言转成系统操作建议。',
      time: DateTime(2026, 4, 9, 9, 30),
    ),
  ];

  List<TaskItem> get tasks => List.unmodifiable(_tasks);
  List<AIMessage> get aiMessages => List.unmodifiable(_messages);
  List<WorkspaceActivity> get activities => List.unmodifiable(_activities);

  int get activeProjectCount => _tasks.map((task) => task.project).toSet().length;

  int get pendingTaskCount => _tasks.where((task) => !task.done).length;

  int get completedTaskCount => _tasks.where((task) => task.done).length;

  int get estimatedWeekHours => completedTaskCount * 6 + pendingTaskCount * 4;

  int get riskTaskCount => _tasks
      .where((task) => !task.done && task.priority == TaskPriority.high)
      .length;

  double get completionRate {
    if (_tasks.isEmpty) {
      return 0;
    }
    return completedTaskCount / _tasks.length;
  }

  List<double> get weeklyCompletionTrend {
    const base = [0.36, 0.48, 0.44, 0.62, 0.71, 0.65, 0.78];
    final boost = completionRate * 0.22;
    return base.map((item) => (item + boost).clamp(0.12, 0.96)).toList();
  }

  String get summaryText {
    return '当前 Sprint 完成率 ${(completionRate * 100).round()}%，'
        '共 $completedTaskCount 项已完成、$pendingTaskCount 项待处理。';
  }

  String get suggestionText {
    if (riskTaskCount > 0) {
      return '建议优先收敛高优任务，降低延期风险后再扩展新需求。';
    }
    return '建议继续保持节奏，推进任务详情和数据接口对接。';
  }

  List<ProjectProgress> get projectProgressList {
    const palette = [
      Color(0xFF0E5E6F),
      Color(0xFF4D7C8A),
      Color(0xFF6A8E9A),
      Color(0xFF3B7382),
    ];

    final grouped = <String, List<TaskItem>>{};
    for (final task in _tasks) {
      grouped.putIfAbsent(task.project, () => []).add(task);
    }

    final result = <ProjectProgress>[];
    var index = 0;
    grouped.forEach((project, list) {
      final done = list.where((task) => task.done).length;
      final progress = done / list.length;
      result.add(
        ProjectProgress(
          title: project,
          progress: progress,
          meta: 'Sprint 当前 $done / ${list.length} 任务完成',
          accent: palette[index % palette.length],
        ),
      );
      index++;
    });

    result.sort((a, b) => b.progress.compareTo(a.progress));
    return result;
  }

  bool addTask(String title) {
    final content = title.trim();
    if (content.isEmpty) {
      return false;
    }

    _tasks.insert(
      0,
      TaskItem(
        id: 't-${DateTime.now().microsecondsSinceEpoch}',
        title: content,
        project: '快速记录',
        priority: TaskPriority.medium,
        dueText: '待安排',
      ),
    );
    _addActivity('新增任务「$content」');
    notifyListeners();
    return true;
  }

  void toggleTask(String id) {
    for (final task in _tasks) {
      if (task.id == id) {
        task.done = !task.done;
        _addActivity(task.done ? '任务「${task.title}」已完成' : '任务「${task.title}」重新开启');
        notifyListeners();
        return;
      }
    }
  }

  void sendPrompt(String prompt) {
    sendAiMessage(prompt);
  }

  void sendAiMessage(String text) {
    final content = text.trim();
    if (content.isEmpty) {
      return;
    }

    _messages.add(
      AIMessage(isMine: true, text: content, time: DateTime.now()),
    );
    _messages.add(
      AIMessage(
        isMine: false,
        text: _buildReply(content),
        time: DateTime.now(),
      ),
    );
    final shortText = content.length > 14
        ? '${content.substring(0, 14)}...'
        : content;
    _addActivity('AI 助手处理了指令：$shortText');
    notifyListeners();
  }

  void _addActivity(String title) {
    _activities.insert(0, WorkspaceActivity(title: title, time: '刚刚'));
    if (_activities.length > 12) {
      _activities.removeLast();
    }
  }

  String _buildReply(String input) {
    if (input.contains('测试')) {
      return '已为你生成建议：先补主流程冒烟用例，再覆盖异常分支与权限边界。';
    }
    if (input.contains('风险')) {
      return '当前主要风险集中在高优先级任务未闭环，建议按影响范围逐项拆解处理。';
    }
    if (input.contains('日报')) {
      return '日报草稿：今天完成 1 项核心任务，推进 2 项功能，明日聚焦 Dashboard 与 AI 交互优化。';
    }
    if (input.contains('拆分')) {
      return '可拆分为：页面框架、状态管理、交互联动、数据展示四个子任务，并按可交付顺序推进。';
    }
    return '收到，我会基于当前项目数据继续给出可执行建议。';
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required super.notifier, required super.child});

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in widget tree.');
    return scope!.notifier!;
  }
}
