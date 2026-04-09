import 'package:flutter/material.dart';

enum TaskPriority { high, medium, low }

enum TaskStatus { backlog, inProgress, review, done }

enum AiSuggestionType { splitTask, syncRiskSummary, createDailyReport }

class CompletionLayer {
  const CompletionLayer({
    required this.name,
    required this.score,
    required this.acceptanceCriteria,
  });

  final String name;
  final double score;
  final List<String> acceptanceCriteria;
}

class ProjectRecord {
  const ProjectRecord({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.phase,
  });

  final String id;
  final String name;
  final String ownerId;
  final String phase;
}

class TaskHistoryEntry {
  const TaskHistoryEntry({
    required this.message,
    required this.time,
  });

  final String message;
  final DateTime time;
}

class TaskItem {
  TaskItem({
    required this.id,
    required this.title,
    required this.projectId,
    required this.assigneeId,
    required this.priority,
    required this.dueText,
    required this.status,
    this.isRisk = false,
    List<String>? dependencyIds,
    List<TaskHistoryEntry>? history,
  }) : dependencyIds = dependencyIds ?? [],
       history = history ?? [];

  final String id;
  final String title;
  final String projectId;
  String assigneeId;
  final TaskPriority priority;
  final String dueText;
  TaskStatus status;
  bool isRisk;
  final List<String> dependencyIds;
  final List<TaskHistoryEntry> history;

  bool get done => status == TaskStatus.done;
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
    required this.id,
    required this.name,
    required this.role,
    required this.online,
  });

  final String id;
  final String name;
  final String role;
  final bool online;
}

class WorkspaceActivity {
  const WorkspaceActivity({required this.title, required this.time});

  final String title;
  final String time;
}

class WorkspaceAudit {
  const WorkspaceAudit({
    required this.action,
    required this.operator,
    required this.scope,
    required this.time,
  });

  final String action;
  final String operator;
  final String scope;
  final String time;
}

class RolePermission {
  const RolePermission({
    required this.role,
    required this.permissions,
  });

  final String role;
  final List<String> permissions;
}

class ProjectPolicy {
  const ProjectPolicy({
    required this.projectName,
    required this.policy,
  });

  final String projectName;
  final String policy;
}

class AIMessage {
  const AIMessage({required this.isMine, required this.text, required this.time});

  final bool isMine;
  final String text;
  final DateTime time;
}

class AiSuggestion {
  const AiSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.executed = false,
  });

  final String id;
  final String title;
  final String description;
  final AiSuggestionType type;
  final bool executed;

  AiSuggestion copyWith({bool? executed}) {
    return AiSuggestion(
      id: id,
      title: title,
      description: description,
      type: type,
      executed: executed ?? this.executed,
    );
  }
}

class AppState extends ChangeNotifier {
  static const int _maxActivityCount = 16;
  static const int _maxActivityPreviewLength = 14;
  static const String _addTaskActivityPrefix = '新增任务「';
  static const String _aiActivityPrefix = 'AI 助手处理了指令：';
  static const String _autoTaskIdPrefix = 't-auto-';

  final List<CompletionLayer> completionLayers = const [
    CompletionLayer(
      name: '产品完整性',
      score: 0.78,
      acceptanceCriteria: ['核心 5 Tab 功能具备可用路径', '核心流程可演示', '主要空态可识别'],
    ),
    CompletionLayer(
      name: '业务完整性',
      score: 0.66,
      acceptanceCriteria: ['任务具备创建/分配/流转', '风险项可识别并汇总', 'AI 输出可写回业务流'],
    ),
    CompletionLayer(
      name: '工程完整性',
      score: 0.58,
      acceptanceCriteria: ['状态边界明确', '关键逻辑具备测试入口', '异常态具备基础反馈'],
    ),
  ];

  final List<ProjectRecord> _projects = const [
    ProjectRecord(id: 'p-mobile', name: 'OtterSync 移动端适配', ownerId: 'm-1', phase: '交付中'),
    ProjectRecord(id: 'p-ai', name: 'AI 辅助任务流原型', ownerId: 'm-2', phase: '验证中'),
    ProjectRecord(id: 'p-workspace', name: '协作空间治理', ownerId: 'm-4', phase: '设计完善'),
  ];

  final List<TaskItem> _tasks = [
    TaskItem(
      id: 't-1',
      title: '搭建底部导航与主页面框架',
      projectId: 'p-mobile',
      assigneeId: 'm-2',
      priority: TaskPriority.high,
      dueText: '今天截止',
      status: TaskStatus.done,
      history: [TaskHistoryEntry(message: '初始化完成', time: DateTime(2026, 4, 8, 10, 10))],
    ),
    TaskItem(
      id: 't-2',
      title: '补充 Dashboard 指标和趋势图',
      projectId: 'p-mobile',
      assigneeId: 'm-1',
      priority: TaskPriority.medium,
      dueText: '明天下午',
      status: TaskStatus.inProgress,
      history: [TaskHistoryEntry(message: '进入开发阶段', time: DateTime(2026, 4, 8, 15, 20))],
    ),
    TaskItem(
      id: 't-3',
      title: '实现 AI 对话输入与回复逻辑',
      projectId: 'p-ai',
      assigneeId: 'm-2',
      priority: TaskPriority.high,
      dueText: '本周内',
      status: TaskStatus.review,
      isRisk: true,
      dependencyIds: ['t-2'],
      history: [TaskHistoryEntry(message: '提测后待评审', time: DateTime(2026, 4, 8, 19, 10))],
    ),
    TaskItem(
      id: 't-4',
      title: '整理 Workspace 成员与权限数据',
      projectId: 'p-workspace',
      assigneeId: 'm-3',
      priority: TaskPriority.medium,
      dueText: '周五前',
      status: TaskStatus.done,
      history: [TaskHistoryEntry(message: '权限模型草案完成', time: DateTime(2026, 4, 7, 16, 40))],
    ),
    TaskItem(
      id: 't-5',
      title: '补齐个人中心统计联动',
      projectId: 'p-workspace',
      assigneeId: 'm-4',
      priority: TaskPriority.low,
      dueText: '下周一',
      status: TaskStatus.backlog,
      dependencyIds: ['t-4'],
      history: [TaskHistoryEntry(message: '需求待排期', time: DateTime(2026, 4, 8, 9, 30))],
    ),
  ];

  final List<WorkspaceMember> members = const [
    WorkspaceMember(id: 'm-1', name: '张怡博', role: '项目管理员', online: true),
    WorkspaceMember(id: 'm-2', name: '王行健', role: '开发负责人', online: true),
    WorkspaceMember(id: 'm-3', name: '林雯', role: '测试工程师', online: false),
    WorkspaceMember(id: 'm-4', name: '赵可', role: '产品经理', online: true),
  ];

  final List<RolePermission> rolePermissionMatrix = const [
    RolePermission(role: '管理员', permissions: ['成员管理', '项目授权', '审计查看', '任务流转']),
    RolePermission(role: '成员', permissions: ['任务处理', 'AI 建议执行', '动态记录']),
    RolePermission(role: '访客', permissions: ['只读查看', 'Dashboard 浏览']),
  ];

  final List<ProjectPolicy> projectPolicies = const [
    ProjectPolicy(projectName: 'OtterSync 移动端适配', policy: '仅管理员可发布里程碑；成员可变更任务状态'),
    ProjectPolicy(projectName: 'AI 辅助任务流原型', policy: 'AI 建议执行需二次确认并记录审计'),
    ProjectPolicy(projectName: '协作空间治理', policy: '权限策略更新需管理员与产品双确认'),
  ];

  static const List<WorkspaceActivity> _seedActivities = [
    WorkspaceActivity(title: '张怡博更新了任务状态', time: '10 分钟前'),
    WorkspaceActivity(title: '王行健创建了 Sprint 规划', time: '今天 09:20'),
    WorkspaceActivity(title: '测试组提交了审核反馈', time: '昨天 18:40'),
  ];
  final List<WorkspaceActivity> _activities = [..._seedActivities];

  static const List<WorkspaceAudit> _seedAudits = [
    WorkspaceAudit(action: '角色策略更新', operator: '张怡博', scope: '全局权限', time: '今天 09:30'),
    WorkspaceAudit(action: 'AI 建议执行', operator: '王行健', scope: 'AI 辅助任务流原型', time: '今天 10:10'),
    WorkspaceAudit(action: '风险任务复核', operator: '林雯', scope: 'OtterSync 移动端适配', time: '昨天 17:45'),
  ];
  final List<WorkspaceAudit> _audits = List.from(_seedAudits);

  final List<String> promptTemplates = const [
    '生成测试步骤',
    '总结 Sprint 风险',
    '输出日报草稿',
    '拆分高优任务',
  ];

  final List<AIMessage> _messages = [
    AIMessage(
      isMine: false,
      text: '我可以生成建议并执行写回：任务拆分、风险同步、日报汇总。',
      time: DateTime(2026, 4, 9, 9, 30),
    ),
  ];

  final List<AiSuggestion> _suggestions = [
    const AiSuggestion(
      id: 's-1',
      title: '拆分 Dashboard 指标任务',
      description: '将 Dashboard 任务拆分为指标聚合、图表渲染、摘要生成 3 个子任务。',
      type: AiSuggestionType.splitTask,
    ),
  ];

  int _taskCounter = 0;
  int _suggestionCounter = 1;

  List<ProjectRecord> get projects => List.unmodifiable(_projects);
  List<TaskItem> get tasks => List.unmodifiable(_tasks);
  List<AIMessage> get aiMessages => List.unmodifiable(_messages);
  List<WorkspaceActivity> get activities => List.unmodifiable(_activities);
  List<WorkspaceAudit> get audits => List.unmodifiable(_audits);
  List<AiSuggestion> get suggestions => List.unmodifiable(_suggestions);

  int get activeProjectCount => _tasks.map((task) => task.projectId).toSet().length;
  int get pendingTaskCount => _tasks.where((task) => task.status != TaskStatus.done).length;
  int get completedTaskCount => _tasks.where((task) => task.status == TaskStatus.done).length;
  int get estimatedWeekHours => completedTaskCount * 6 + pendingTaskCount * 4;

  int get riskTaskCount => _tasks
      .where((task) => !task.done && (task.priority == TaskPriority.high || task.isRisk))
      .length;

  int get executedSuggestionCount => _suggestions.where((item) => item.executed).length;

  double get completionRate {
    if (_tasks.isEmpty) {
      return 0;
    }
    return completedTaskCount / _tasks.length;
  }

  Map<TaskStatus, int> get workflowStatusCount {
    final map = <TaskStatus, int>{
      TaskStatus.backlog: 0,
      TaskStatus.inProgress: 0,
      TaskStatus.review: 0,
      TaskStatus.done: 0,
    };
    for (final task in _tasks) {
      map[task.status] = (map[task.status] ?? 0) + 1;
    }
    return map;
  }

  Map<TaskPriority, int> get riskDistribution {
    final map = <TaskPriority, int>{
      TaskPriority.high: 0,
      TaskPriority.medium: 0,
      TaskPriority.low: 0,
    };
    for (final task in _tasks.where((task) => !task.done)) {
      map[task.priority] = (map[task.priority] ?? 0) + 1;
    }
    return map;
  }

  List<double> get memberLoadRatios {
    if (members.isEmpty) {
      return [];
    }
    return members.map((member) {
      final load = _tasks.where((task) => task.assigneeId == member.id && !task.done).length;
      return (load / 4).clamp(0.0, 1.0);
    }).toList();
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
      return '建议优先收敛高优风险任务，并将 AI 风险摘要同步到协作审计。';
    }
    return '建议继续保持节奏，推进任务详情、策略治理和自动化验证覆盖。';
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
      grouped.putIfAbsent(task.projectId, () => []).add(task);
    }

    final result = <ProjectProgress>[];
    var index = 0;
    grouped.forEach((projectId, list) {
      final done = list.where((task) => task.done).length;
      final progress = done / list.length;
      final name = projectNameById(projectId);
      result.add(
        ProjectProgress(
          title: name,
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

  String projectNameById(String id) {
    return _projects.firstWhere((project) => project.id == id).name;
  }

  String memberNameById(String id) {
    return members.firstWhere((member) => member.id == id).name;
  }

  bool addTask(String title) {
    return createTask(
      title: title,
      projectId: 'p-mobile',
      assigneeId: members.first.id,
      priority: TaskPriority.medium,
      dueText: '待安排',
    );
  }

  bool createTask({
    required String title,
    required String projectId,
    required String assigneeId,
    required TaskPriority priority,
    required String dueText,
    List<String> dependencyIds = const [],
  }) {
    final content = title.trim();
    if (content.isEmpty) {
      return false;
    }

    final task = TaskItem(
      id: _nextTaskId(),
      title: content,
      projectId: projectId,
      assigneeId: assigneeId,
      priority: priority,
      dueText: dueText,
      status: TaskStatus.backlog,
      dependencyIds: [...dependencyIds],
      history: [TaskHistoryEntry(message: '任务创建', time: DateTime.now())],
    );
    _tasks.insert(0, task);
    _addActivity('$_addTaskActivityPrefix$content」');
    _addAudit('任务创建', memberNameById(assigneeId), projectNameById(projectId));
    notifyListeners();
    return true;
  }

  void toggleTask(String id) {
    final task = _tasks.where((item) => item.id == id).firstOrNull;
    if (task == null) {
      return;
    }
    final next = task.done ? TaskStatus.inProgress : TaskStatus.done;
    updateTaskStatus(id: id, status: next);
  }

  void updateTaskStatus({required String id, required TaskStatus status}) {
    final task = _tasks.where((item) => item.id == id).firstOrNull;
    if (task == null) {
      return;
    }
    task.status = status;
    task.history.insert(0, TaskHistoryEntry(message: '状态更新为 ${statusLabel(status)}', time: DateTime.now()));
    task.isRisk = status != TaskStatus.done && task.priority == TaskPriority.high;
    _addActivity('任务「${task.title}」更新为 ${statusLabel(status)}');
    _addAudit('任务状态流转', memberNameById(task.assigneeId), projectNameById(task.projectId));
    notifyListeners();
  }

  void assignTask({required String id, required String memberId}) {
    final task = _tasks.where((item) => item.id == id).firstOrNull;
    if (task == null) {
      return;
    }
    task.assigneeId = memberId;
    task.history.insert(0, TaskHistoryEntry(message: '负责人调整为 ${memberNameById(memberId)}', time: DateTime.now()));
    _addActivity('任务「${task.title}」重新分配给 ${memberNameById(memberId)}');
    _addAudit('任务分配', memberNameById(memberId), projectNameById(task.projectId));
    notifyListeners();
  }

  void splitTask(String id) {
    final parent = _tasks.where((item) => item.id == id).firstOrNull;
    if (parent == null) {
      return;
    }
    final children = [
      '梳理业务流转节点',
      '完善状态校验逻辑',
      '补齐异常态与验收项',
    ];
    for (final title in children) {
      createTask(
        title: '${parent.title} - $title',
        projectId: parent.projectId,
        assigneeId: parent.assigneeId,
        priority: TaskPriority.medium,
        dueText: '本周内',
        dependencyIds: [parent.id],
      );
    }
    _addActivity('任务「${parent.title}」已拆分为 3 个子任务');
    notifyListeners();
  }

  void sendPrompt(String prompt) {
    sendAiMessage(prompt);
  }

  void sendAiMessage(String text) {
    final content = text.trim();
    if (content.isEmpty) {
      return;
    }

    _messages.add(AIMessage(isMine: true, text: content, time: DateTime.now()));
    final reply = _buildReply(content);
    _messages.add(AIMessage(isMine: false, text: reply, time: DateTime.now()));

    final suggestion = _buildSuggestion(content);
    if (suggestion != null) {
      _suggestions.insert(0, suggestion);
    }

    final shortText = content.length > _maxActivityPreviewLength ? '${content.substring(0, _maxActivityPreviewLength)}...' : content;
    _addActivity('$_aiActivityPrefix$shortText');
    notifyListeners();
  }

  void executeSuggestion(String id) {
    final index = _suggestions.indexWhere((item) => item.id == id);
    if (index < 0) {
      return;
    }
    final suggestion = _suggestions[index];
    if (suggestion.executed) {
      return;
    }
    switch (suggestion.type) {
      case AiSuggestionType.splitTask:
        final target = _tasks.where((task) => task.priority == TaskPriority.high && !task.done).firstOrNull;
        if (target != null) {
          splitTask(target.id);
        }
      case AiSuggestionType.syncRiskSummary:
        _addActivity('AI 已同步风险摘要：高优风险任务 $riskTaskCount 项');
      case AiSuggestionType.createDailyReport:
        _addActivity('AI 已回写日报：完成 $completedTaskCount 项，待办 $pendingTaskCount 项');
    }
    _suggestions[index] = suggestion.copyWith(executed: true);
    _addAudit('AI 建议执行', 'AI Assistant', '智能执行队列');
    notifyListeners();
  }

  String statusLabel(TaskStatus status) {
    return switch (status) {
      TaskStatus.backlog => '待开始',
      TaskStatus.inProgress => '进行中',
      TaskStatus.review => '待评审',
      TaskStatus.done => '已完成',
    };
  }

  String priorityLabel(TaskPriority priority) {
    return switch (priority) {
      TaskPriority.high => '高优先级',
      TaskPriority.medium => '中优先级',
      TaskPriority.low => '低优先级',
    };
  }

  void _addActivity(String title) {
    _activities.insert(0, WorkspaceActivity(title: title, time: '刚刚'));
    if (_activities.length > _maxActivityCount) {
      _activities.removeLast();
    }
  }

  void _addAudit(String action, String operator, String scope) {
    _audits.insert(
      0,
      WorkspaceAudit(
        action: action,
        operator: operator,
        scope: scope,
        time: _timeLabel(DateTime.now()),
      ),
    );
    if (_audits.length > _maxActivityCount) {
      _audits.removeLast();
    }
  }

  String _nextTaskId() {
    _taskCounter++;
    return '$_autoTaskIdPrefix$_taskCounter';
  }

  AiSuggestion? _buildSuggestion(String input) {
    _suggestionCounter++;
    if (input.contains('拆分')) {
      return AiSuggestion(
        id: 's-$_suggestionCounter',
        title: '建议拆分高优任务',
        description: '拆解高优任务并自动回写依赖关系。',
        type: AiSuggestionType.splitTask,
      );
    }
    if (input.contains('风险')) {
      return AiSuggestion(
        id: 's-$_suggestionCounter',
        title: '同步风险摘要',
        description: '将风险任务数量与建议写入协作动态和审计记录。',
        type: AiSuggestionType.syncRiskSummary,
      );
    }
    if (input.contains('日报')) {
      return AiSuggestion(
        id: 's-$_suggestionCounter',
        title: '生成并回写日报',
        description: '汇总今日任务状态并写入工作区动态。',
        type: AiSuggestionType.createDailyReport,
      );
    }
    return null;
  }

  String _buildReply(String input) {
    if (input.contains('测试')) {
      return '已生成建议：主流程冒烟、权限边界、异常回退三组测试用例。';
    }
    if (input.contains('风险')) {
      return '识别到 $riskTaskCount 项风险任务，建议执行“同步风险摘要”写回工作区。';
    }
    if (input.contains('日报')) {
      return '已准备日报草稿并可一键回写到协作动态。';
    }
    if (input.contains('拆分')) {
      return '可拆分为：业务流转、状态校验、异常处理三类子任务。';
    }
    return '收到，我会基于当前项目数据继续给出可执行建议。';
  }

  String _timeLabel(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '今天 $hour:$minute';
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

extension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
