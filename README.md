# OtterSync

OtterSync 是一个基于 Flutter 的项目协作原型应用，围绕**任务流转、团队协作治理、AI 执行闭环和数据分析看板**构建。

## 项目定位

当前版本面向“复杂流程可演示”的原型验证，重点覆盖：

- **完成度分层**：产品完整性 / 业务完整性 / 工程完整性
- **统一状态模型**：项目、任务、成员、动态、审计、AI 建议统一管理
- **业务闭环**：任务创建、状态流转、风险标记、历史追踪
- **协作治理**：权限矩阵、项目策略、操作审计、动态事件流
- **AI 闭环**：建议生成 → 人工确认 → 执行回写
- **多维分析**：交付趋势、流程状态、风险分布、成员负载

## 核心功能模块

应用采用底部 5 Tab 导航：

1. **项目**：任务筛选、快速新增、项目进度与完成度分层展示  
2. **工作区**：成员状态、角色权限矩阵、项目授权策略、审计与动态  
3. **AI**：对话交互、Prompt 模板、执行建议确认与回写  
4. **分析**：指标总览、趋势图、状态分布、风险与负载分析  
5. **我的**：个人任务/工时/风险与工程基线信息聚合

## 技术栈

- Flutter
- Dart（`sdk: ^3.11.1`）
- Material 3
- `ChangeNotifier` + `InheritedNotifier`（`AppState` / `AppStateScope`）

## 目录结构

```text
lib/
├── main.dart              # 应用入口
├── routes/                # 根组件与主题配置
├── state/                 # 全局状态与业务模型
├── pages/
│   ├── Main/              # 5 Tab 主框架
│   ├── Home/              # 项目页
│   ├── Workspace/         # 工作区页
│   ├── AI/                # AI 页
│   ├── Dashboard/         # 分析页
│   └── My/                # 我的页
└── theme/                 # 设计令牌
test/
└── app_state_test.dart    # 关键状态流转测试
```

## 快速开始

1. 安装 Flutter SDK（需满足 `pubspec.yaml` 中 Dart 版本约束）
2. 获取依赖：

   ```bash
   flutter pub get
   ```

3. 运行应用：

   ```bash
   flutter run
   ```

## 开发与测试

- 静态检查：

  ```bash
  flutter analyze
  ```

- 运行测试：

  ```bash
  flutter test
  ```

## 说明

- 当前仓库为原型工程，数据以内存状态为主（`AppState`）。
- 可在此基础上继续扩展后端 API、持久化和权限系统。
