# Day 5：高级特性与 AI 协作

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 GitHub Projects/Stacked PRs/Copilot 2026 新特性
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：多 PR 管理工作流

---

## 今日学习路径

```
🍅 番茄1-2：GitHub Projects 看板 + Issue Fields（2026重磅更新）
🍅 番茄3-4：Stacked PRs + Sub-Issues（2026重磅更新）
🍅 番茄5-6：GitHub Copilot 2026 新特性 + Agent Merge
🍅 番茄7-8：刻意练习：多 PR 管理工作流 + 复习输出
```

---

## 🔥 为何 Day 5 是这门课最"哇塞"的一天？

前四天你学会了 **Push → PR → Merge → Deploy** 的基础闭环。但 GitHub 在 2026 年已经远远不止是一个"代码托管平台"——它进化成了 **AI 原生开发者平台**。

今天你将解锁：
- **Copilot Desktop App**：管理多个 AI Agent 并行工作的桌面应用
- **Agent Merge**：AI 自动处理 PR 冲突和合并
- **Issue Fields**：像数据库一样管理 Issue 元数据
- **Stacked PRs**：大 PR 拆小、小 PR 堆叠
- **Sub-Issues**：史诗级任务分解

这些是 2026 年 GitHub 最核心的武器。学会它们，你的开发效率将直接翻倍。

---

## 🍅 番茄1-2：GitHub Projects + Issue Fields（50分钟）

### 1.1 GitHub Projects 是什么？（用大白话理解）

**传统看板的痛点：**
- Issue 列表像流水账，没有全局视图
- 进度靠"感觉"，无法量化
- 跨团队协作信息散落在多个地方

**GitHub Projects = 可编程的项目管理看板**

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Projects 架构                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   📋 看板视图（Board View）                                   │
│   ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐      │
│   │  Backlog  │ │  To Do   │ │ In Progress│ │  Done    │      │
│   │  ● Issue1 │ │  ● Issue3│ │  ● Issue5│ │  ● Issue7│      │
│   │  ● Issue2 │ │  ● Issue4│ │  ● Issue6│ │  ● Issue8│      │
│   └──────────┘ └──────────┘ └──────────┘ └──────────┘      │
│                                                             │
│   📊 表格视图（Table View）                                    │
│   ├─────────┼─────────┼───────────┼────────┤                │
│   │ Title   │ Status  │ Priority  │ Owner  │                │
│   ├─────────┼─────────┼───────────┼────────┤                │
│                                                             │
│   📈 路线图视图（Roadmap View）                                │
│   ├──── Jan ────┼──── Feb ────┼─── Mar ────┤                │
│                                                             │
│   🔄 自动化规则                                               │
│   ├── PR merged → Move to "Done"                             │
│   └── New Issue → Auto-assign                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 Projects vs. Issues —— 区别与配合

| 维度 | Issues | Projects |
|:-----|:-------|:---------|
| **定位** | 单个任务的描述和讨论 | 多个任务的聚合视图 |
| **归属** | 属于某个 Repository | 跨 Repository（Org/User 级别） |
| **视图** | 列表（Filterable） | 看板/表格/路线图/日历 |
| **自定义字段** | 有限（Labels, Milestones） | **无限**（2026 全新支持） |
| **自动化** | 基础（Actions） | **内置自动化规则引擎** |
| **适用场景** | Bug Report, Feature Request | Sprint Planning, 发布管理 |

**最佳实践：**
```
Issues = 数据的"存储层"（每个 Issue 是一条记录）
Projects = 数据的"展示层"（看板是 Issues 的可视化排列）
```

### 1.3 Issue Fields —— 2026 年最激动人心的更新

**背景：** 过去 Issue 只有 Title + Body + Labels + Milestones，信息维度太少。想要 Priority、Effort、Sprint 这些字段？要么靠 Label 标签（乱），要么靠第三方工具（割裂）。

**2026 年 Issue Fields 原生支持类型化元数据：**

```
┌─────────────────────────────────────────────────────────────┐
│                    Issue Fields 类型系统                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📝 Text          → 单行文本        e.g. "frontend"         │
│  📄 Paragraph     → 多行文本        e.g. 详细描述           │
│  🔢 Number        → 数字           e.g. Story Points: 5    │
│  ✅ Single Select → 单选           e.g. Priority: High     │
│  ☑️ Multi Select  → 多选           e.g. Tags: [bug, perf]  │
│  📅 Date          → 日期           e.g. Due: 2026-07-01    │
│  👤 Assignee      → 用户           e.g. @fangyan           │
│  🔗 Iteration     → 迭代周期       e.g. Sprint 24          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**为什么 Issue Fields 是革命性的？**

1. **结构化数据** —— 不再是纯文本描述，可以像数据库一样查询和排序
2. **跨仓库统一** —— 组织级别定义字段模板，所有仓库统一遵从
3. **自动化驱动** —— 字段变化触发自动化规则（如 Priority=Critical 自动 @ 项目经理）
4. **报表能力** —— 在 Projects 中可以按字段聚合、统计、生成图表

### 1.4 创建 Issue Fields 实战

```yaml
# 在 Organization Settings > Repository 中定义 Issue Fields

fields:
  - name: Priority
    type: single_select
    options:
      - 🔴 Critical
      - 🟡 High
      - 🟢 Medium
      - ⚪ Low
    default: Medium

  - name: Effort
    type: number
    description: "Story Points (1-13)"
    validation:
      min: 1
      max: 13

  - name: Sprint
    type: iteration
    duration: 2 weeks
    start_date: 2026-06-08

  - name: Team
    type: single_select
    options:
      - Frontend
      - Backend
      - ML/AI
      - DevOps
```

### 1.5 自动化规则

GitHub Projects 内置自动化引擎，无需写代码就能设置规则：

```
┌─────────────────────────────────────────────────────────────┐
│                    自动化规则示例                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🎯 当你把 Issue 拖入 "In Progress" 列：                     │
│  → 自动 Assign 给拖拽者                                     │
│  → 自动添加 Label "in-progress"                              │
│                                                             │
│  🎯 当 PR 被 Merge：                                         │
│  → 自动将关联 Issue 移动到 "Done" 列                          │
│  → 自动关闭 Issue                                           │
│                                                             │
│  🎯 当 Priority = Critical：                                 │
│  → 自动 @mention 项目经理                                    │
│  → 设置 Due Date = 24h 内                                    │
│                                                             │
│  🎯 当 Sprint 结束时：                                       │
│  → 自动将未完成的 Issue 移入下一个 Sprint                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 1.6 实战：搭建你的第一个 Project 看板

```bash
# 步骤1：创建 Project（网页端）
# Repo > Projects > "New Project"
# 选择 "Board" 模板

# 步骤2：添加自定义字段
# Project Settings > Fields > Add Field
# 添加 Priority (Single Select), Effort (Number), Sprint (Iteration)

# 步骤3：创建自动化规则
# Project Settings > Automation > New Rule
# 规则: "When issue is added to 'In Progress' → Set status to 'In Progress'"

# 步骤4：批量导入 Issues
# 使用 GitHub CLI 批量创建 Issue 并关联 Project
gh issue create --title "用户登录模块" --label "feature" --project "Sprint 24"
gh issue create --title "修复支付 Bug"   --label "bug"     --project "Sprint 24"
gh issue create --title "性能优化"       --label "perf"    --project "Sprint 24"
```

> ✋ **费曼自测**：用你自己的话解释 Issue Fields 解决了什么问题。为什么说它让 GitHub 从一个"代码托管平台"变成了"项目管理平台"？

---

## 🍅 番茄3-4：Stacked PRs + Sub-Issues（50分钟）

### 2.1 Stacked PRs —— 2026 年大 PR 拆分利器

**痛点场景：**
> 你开发一个"用户积分系统"，改了 30 个文件、涉及 5 个模块。一次性提 PR：
> - Reviewer 看到 3000 行 diff 直接崩溃
> - 一个功能阻塞了另一个功能的合并
> - 冲突难以定位

**Stacked PRs = 把大 PR 拆成多个小 PR，堆叠合并**

```
传统方式：
┌────────────────────────────────────────────┐
│   一个巨型 PR：积分系统（30 files, 3000+ lines） │
│   ← 审阅者：毁灭吧，赶紧的 😱                │
└────────────────────────────────────────────┘

Stacked PRs 方式：
┌────────────────────────────────────────────┐
│   PR #1: 积分数据库模型（4 files, 120 lines）│  ← 小、快
│   PR #2: 积分计算逻辑（6 files, 200 lines） │  ← 审阅快
│   PR #3: 积分 API（8 files, 300 lines）     │  ← 容易 review
│   PR #4: 积分 UI 组件（10 files, 400 lines）│  ← 独立部署
│   PR #5: 积分测试（2 files, 150 lines）     │
└────────────────────────────────────────────┘
```

### 2.2 Stacked PRs 工作原理

```
分支堆叠（Chain）:
                                    
        main
          │
          ▼
    feature/1-db-model    ← PR #1 (base: main)
          │
          ▼
    feature/2-logic       ← PR #2 (base: feature/1-db-model)
          │
          ▼
    feature/3-api         ← PR #3 (base: feature/2-logic)
          │
          ▼
    feature/4-ui          ← PR #4 (base: feature/3-api)
          │
          ▼
    feature/5-tests       ← PR #5 (base: feature/4-ui)
```

**合并过程：**
```
1. PR #1 合并到 main ✅
2. PR #2 重设 base 为 main → 只包含自己的 diff ✅
3. PR #3 重设 base 为 main → 只包含自己的 diff ✅
4. 依次类推...直到所有 PR 合并完成
```

### 2.3 使用 gh-stack 管理 Stacked PRs

GitHub 2026 年推出官方 `gh-stack` 扩展，让 Stacked PRs 管理变得简单：

```bash
# 安装 gh-stack 扩展
gh extension install github/gh-stack

# 从当前分支创建 stacked PRs
# 假设你当前在 feature/5-tests 分支
gh stack create

# 查看堆叠状态（可视化依赖树）
gh stack status

# 输出示例：
# Stack: feature/积分系统
# ─────────────────────────────────────────
# ◉ #101  feature/1-db-model  ← main        [已合并]
# ◉ #102  feature/2-logic     ← #101        [审阅中]
# ◉ #103  feature/3-api       ← #102        [待审阅]
# ◉ #104  feature/4-ui        ← #103        [草稿]
# ◉ #105  feature/5-tests     ← #104        [草稿]

# 当 PR #101 合并后，自动更新后续 PR 的 base
gh stack rebase

# 批量列出所有堆叠 PR
gh stack list
```

### 2.4 Stacked PRs 的黄金法则

```
✅ 适合 Stacked PRs：
  - 大型 Feature（跨多个模块）
  - 重构（每个步骤独立）
  - 渐进式架构变更

❌ 不适合 Stacked PRs：
  - Bug Fix（单一 PR 更直接）
  - 小改动（拆分会增加 overhead）
  - 紧急 Hotfix（需要快速合并）

📐 拆分原则：
  - 每个 PR 不超过 10 个文件
  - 每个 PR diff 不超过 400 行
  - 每个 PR 有独立的功能完整性
  - 按依赖关系排序：模型 → 逻辑 → API → UI
```

### 2.5 Sub-Issues —— 2026 年任务分解利器

**背景：** 过去 Issue 无法嵌套。一个大型 Issue（如"实现支付系统"）要拆成多个独立 Issue，父 Issue 只能靠手动关联，丢失了整体上下文。

**2026 年 Sub-Issues 原生支持父子层级：**

```
┌─────────────────────────────────────────────────────────────┐
│                    Sub-Issues 层级结构                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  #88 实现支付系统（Parent Issue）                             │
│  ├── #89 集成 Stripe SDK（Sub-Issue）                       │
│  │   ├── #92 处理 Webhook 回调（Sub-Issue）                 │
│  │   └── #93 测试回调签名验证（Sub-Issue）                   │
│  ├── #90 支付页面 UI（Sub-Issue）                           │
│  └── #91 支付状态管理（Sub-Issue）                          │
│                                                             │
│  ⚡ Parent Issue 的进度 = 所有 Sub-Issue 进度的聚合           │
│    ├── 4/5 Sub-Issues Closed → 80% 进度条                   │
│    └── 点击 Parent Issue 即可看到完整子任务分解              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2.6 Sub-Issues + Dependencies 联合使用

```bash
# 创建 Parent Issue
gh issue create --title "实现用户通知系统" \
  --label "feature" \
  --project "Sprint 24"

# 创建 Sub-Issues（使用 --parent 参数）
gh issue create --title "通知数据库模型" \
  --parent "#120" \
  --assignee "@me"

gh issue create --title "邮件通知服务" \
  --parent "#120" \
  --depends-on "#121" \
  --assignee "@me"

gh issue create --title "推送通知服务" \
  --parent "#120" \
  --depends-on "#121" \
  --assignee "@me"

gh issue create --title "通知偏好设置页" \
  --parent "#120" \
  --depends-on "#122,#123" \
  --assignee "@me"
```

**依赖关系可视化：**
```
#120 实现用户通知系统
├── #121 通知数据库模型        [已完成]
├── #122 邮件通知服务          [进行中]  ← 依赖 #121
├── #123 推送通知服务          [待开始]  ← 依赖 #121
└── #124 通知偏好设置页        [待开始]  ← 依赖 #122, #123

📌 关键路径：121 → 122/123 → 124
📌 如果 #122 阻塞，#124 自动标记为阻塞状态
```

> ✋ **费曼自测**：Sub-Issues 和 Stacked PRs 有什么本质区别？它们分别是解决什么问题的？

---

## 🍅 番茄5-6：GitHub Copilot 2026 新特性（50分钟）

### 3.1 Copilot 2026 —— 从代码补全到 AI 开发平台

2026 年的 Copilot 已经不再是那个"帮你补全代码行"的插件。它进化成了一个**完整的 AI 开发平台**。

看看 2024 → 2026 的进化：

| 维度 | 2024 年 | 2026 年 |
|:-----|:--------|:--------|
| **交互方式** | VS Code 插件 | VS Code + **桌面应用** + CLI + Web |
| **上下文窗口** | 几千 token | **百万 token**（整个代码库） |
| **Agent 模式** | 单 Agent | **多 Agent 协作** |
| **代码补全** | 行级补全 | **全文件生成** |
| **PR 处理** | 只读代码 | **Agent Merge（自动合并 PR）** |
| **问题修复** | 建议 | **自动创建 PR 修复** |
| **管理界面** | 无 | **Copilot Desktop App** |

### 3.2 Copilot Desktop App —— 你的 AI 开发指挥中心

**这是一个独立的桌面应用（不是 VS Code 插件），核心功能：**

```
┌─────────────────────────────────────────────────────────────┐
│                 Copilot Desktop App                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🤖 Agent 管理面板                                            │
│  ├── 当前运行中的 Agent 列表                                  │
│  ├── 每个 Agent 的状态：思考中 / 编码中 / 等待 review          │
│  ├── 资源使用：token 消耗 / API 调用次数                        │
│  └── Agent 通信日志（Agent 之间如何协作）                      │
│                                                             │
│  🔍 知识图谱                                                  │
│  ├── 实时显示 Agent 理解的代码结构                              │
│  ├── 类/函数/文件之间的依赖关系                                │
│  └── 正在修改的范围高亮显示                                    │
│                                                             │
│  🎮 控制中心                                                  │
│  ├── 暂停/恢复所有 Agent                                     │
│  ├── 分配新任务给特定 Agent                                  │
│  ├── 调整推理级别（快速/平衡/深度）                            │
│  └── 查看对话历史和分析报告                                   │
│                                                             │
│  📊 统计面板                                                  │
│  ├── 今日代码生产力：生成/修改/删除行数                        │
│  ├── Agent 效率排名                                          │
│  └── 项目健康度评分                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 3.3 百万 Token 上下文窗口 —— 理解整个代码库

2026 年 Copilot 的上下文窗口从几千 token 扩展到 **100 万+ token**。

**这意味着什么？**

```
传统 Copilot（2024）:
┌────────────────────────────────────────────┐
│  当前文件 + 附近几个文件                      │
│  → "看到了局部，看不到全局"                   │
│  → 生成的代码可能与项目风格不一致              │
└────────────────────────────────────────────┘

Copilot 2026:
┌────────────────────────────────────────────┐
│  整个代码库（百万 token 窗口）                │
│  → 理解项目架构和编码规范                      │
│  → 跨文件生成一致的代码                        │
│  → 知道哪里已经有类似的实现，避免重复            │
│  → 自动遵循项目现有的设计模式                    │
└────────────────────────────────────────────┘
```

**实际效果：**
```python
# 你只需要写注释：
# "在 users/ 目录下创建一个管理员用户管理模块，包含 CRUD 操作，
#  遵循项目中现有的 RESTful API 风格和错误处理模式"

# Copilot 2026 会：
# 1. 扫描 users/ 目录现有所有文件
# 2. 理解项目使用的框架（FastAPI? Django?）
# 3. 理解现有的错误处理模式（try-except? decorator?）
# 4. 生成完整的模块文件
# 5. 自动生成对应的测试文件
```

### 3.4 可配置推理级别 —— 速度 vs 深度

```yaml
推理级别（可实时切换）:
  🚀 快速（Fast）:
    速度: ⚡⚡⚡⚡⚡
    质量: ⭐⭐⭐
    适用: 简单补全、格式化、简单重构
    
  ⚖️ 平衡（Balanced）:
    速度: ⚡⚡⚡
    质量: ⭐⭐⭐⭐
    适用: 日常编码、函数实现、Bug 修复
    
  🧠 深度（Deep）:
    速度: ⚡
    质量: ⭐⭐⭐⭐⭐
    适用: 复杂架构决策、安全审计、大型重构

# 切换方式：
# Copilot Desktop App → 当前任务 → 推理级别滑条
# 或 CLI：
copilot config set reasoning-level deep
```

### 3.5 Agent Merge —— AI 自动处理 PR 合并

**这是 2026 年最让人兴奋的 Copilot 功能之一：**

```
传统 PR 合并流程:
创建 PR → 等待 Reviewer → 解决冲突 → 再次请求 → 合并
                               ↓
                     人工解决冲突（最痛苦的部分）

Agent Merge 流程:
创建 PR → Copilot Agent 自动:
          ├── ✅ 代码审查（Code Review）
          ├── ✅ 冲突检测与自动解决
          ├── ✅ 兼容性验证（编译 + 测试）
          ├── ✅ 安全扫描（Secret Scanning + CodeQL）
          └── ✅ 自动合并（冲突解决后）
          ↓
       合并完成，通知 Reviewer
```

**Agent Merge 配置：**
```yaml
# .github/agent-merge.yml
version: 1
agent_merge:
  enabled: true
  
  # 自动合并条件
  auto_merge:
    - match: "dependabot/**"
      rules:
        - checks: all_passing
        - reviews: 1_approval
    - match: "feature/**"
      rules:
        - checks: all_passing
        - reviews: 2_approval
        - conflict_strategy: auto_resolve
  
  # 冲突解决策略
  conflict_resolution:
    strategy: auto_3way_merge  # 自动三方合并
    fallback: create_conflict_pr  # 无法解决时，创建冲突说明 PR
    
  # Agent 通知
  notifications:
    on_merge: "@owner"
    on_conflict: "@team"
```

### 3.6 Canvases —— 可视化编程空间

Copilot 2026 引入 **Canvases**，这是一个可视化的编程工作区：

```
┌─────────────────────────────────────────────────────────────┐
│                    Canvases 工作区                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐  ┌──────────────┐                         │
│  │ 函数流程图     │  │ 代码片段      │                         │
│  │ ┌─→ validate  │  │ def process(  │                         │
│  │ │   → parse   │  │     data =    │                         │
│  │ │   → process │  │     sanitize  │                         │
│  │ └─→ output    │  │     return    │                         │
│  └──────────────┘  └──────────────┘                         │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐                         │
│  │ Issue #88    │  │ 测试输出      │                         │
│  │ 实现支付系统   │  │ ✓ 单元测试通过  │                         │
│  │ → 子任务列表  │  │ ✓ 集成测试通过  │                         │
│  └──────────────┘  └──────────────┘                         │
│                                                             │
│  🤖 Agent A（负责后端）  🤖 Agent B（负责前端）                │
│  └── 正在实现 API       └── 等待 API 就绪                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Canvases 核心能力：**
1. **拖放式编程** —— 函数块可以拖拽连接，生成调用关系图
2. **实时可视化** —— 代码修改后流程图自动更新
3. **AI 协作空间** —— 多个 Agent 在同一个 Canvas 上工作
4. **Issue 集成** —— 可以从 Issue 创建 Canvas，任务状态自动同步

### 3.7 Copilot CLI —— 终端中的 AI

```bash
# 让 Copilot 解释代码
copilot explain "为什么这个 SQL 查询这么慢？"

# 让 Copilot 修复编译错误
copilot fix

# 让 Copilot 生成 git 提交信息
copilot commit

# 让 Copilot 审查当前分支的变更
copilot review

# 让 Copilot 分析 CI 失败原因
copilot ci-analyze

# 深度分析（使用 Deep 推理级别）
copilot analyze --deep "重构建议：users 模块"
```

> ✋ **费曼自测**：Copilot Desktop App 和 VS Code 插件版 Copilot 有什么区别？为什么需要一个独立的桌面应用？

---

## 🍅 番茄6（续）：Security & Quality —— Dependabot, Secret Scanning, CodeQL

### 3.8 Dependabot —— 自动依赖管理

```bash
# Dependabot 自动检测依赖中的安全漏洞
# 并自动创建修复 PR

# 配置 Dependabot（.github/dependabot.yml）
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
    labels:
      - "dependencies"
      - "security"

  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
```

### 3.9 Secret Scanning —— 自动检测密钥泄露

```
🚨 Secret Scanning 自动检测提交中的：
  - API Keys (AWS, Azure, GCP)
  - Database URLs
  - Private Keys (SSH, GPG)
  - Tokens (GitHub, GitLab, Slack)
  - Passwords and Credentials

当检测到 Secrets 时：
1. 发送告警给仓库管理员
2. 自动撤销泄露的密钥（如 GitHub Token）
3. 提供修复指南
```

### 3.10 CodeQL —— 代码质量与安全分析

```bash
# CodeQL 自动分析代码中的安全漏洞和代码质量问题

# 在 GitHub Actions 中启用 CodeQL
# .github/workflows/codeql-analysis.yml
name: "CodeQL"

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * 0'  # 每周扫描

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    permissions:
      security-events: write
      actions: read
      contents: read

    strategy:
      fail-fast: false
      matrix:
        language: ['javascript', 'python']

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: ${{ matrix.language }}

      - name: Autobuild
        uses: github/codeql-action/autobuild@v3

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
```

> ✋ **费曼自测**：Dependabot、Secret Scanning、CodeQL 这三个安全工具分别解决什么问题？在实际项目中应该按什么顺序启用它们？

---

## 🍅 番茄7-8：刻意练习 + 复习输出（50分钟）

### 4.1 刻意练习项目：多 PR 管理工作流

这是一个综合性练习，设计成模拟真实团队协作场景。

**场景设定：**
> 你是一个开源项目 "TaskMaster"（任务管理工具）的核心维护者。今天有 3 个 PR 需要处理：
> 1. 一个新功能的 Stacked PRs（3 个子 PR）
> 2. 一个 Dependabot 自动创建的依赖更新 PR
> 3. 一个包含 Sub-Issues 的 Epic Issue

**练习步骤：**

#### Step 1：创建项目结构（10分钟）

```bash
# 1. 创建练习仓库
mkdir taskmaster-practice
cd taskmaster-practice
git init
git checkout -b main
echo "# TaskMaster" > README.md
git add README.md
git commit -m "chore: init"

# 2. 创建 Projects 看板（网页端）
# New Project → Board Template → 添加列：
# 待办 | 进行中 | 审阅中 | 已完成

# 3. 创建 Issue Fields
# Priority: Critical / High / Medium / Low
# Effort: 1-13
# Sprint: Iteration 字段
# Type: Feature / Bug / Refactor / Docs
```

#### Step 2：创建父 Issue + Sub-Issues（10分钟）

```bash
# 创建 Epic Issue
gh issue create --title "用户邀请系统" \
  --body "实现邀请好友功能" \
  --label "feature" \
  --field "Priority=High" \
  --field "Effort=8" \
  --field "Type=Feature"

# 创建 Sub-Issues
gh issue create --title "邀请链接生成" \
  --parent "#1" \
  --field "Priority=High" \
  --field "Effort=3"

gh issue create --title "邀请接受逻辑" \
  --parent "#1" \
  --depends-on "#2" \
  --field "Priority=High" \
  --field "Effort=3"

gh issue create --title "邀请页面 UI" \
  --parent "#1" \
  --depends-on "#3" \
  --field "Priority=Medium" \
  --field "Effort=2"

# 查看 Sub-Issues 依赖树
gh issue view "#1" --json subIssues,subIssuesProgress
```

#### Step 3：创建 Stacked PRs（15分钟）

```bash
# 基于 Sub-Issue #2 创建分支
gh issue develop "#2" --branch feature/invite-link

# 实现邀请链接生成功能
echo "def generate_invite_link(user_id):
    return f'https://taskmaster.dev/invite/{user_id}'" > invite.py

git add invite.py
git commit -m "feat: add invite link generation"

# 基于此分支创建第二个分支
git checkout -b feature/invite-accept

# 实现邀请接受逻辑
echo "def accept_invite(invite_code):
    return {'status': 'accepted', 'code': invite_code}" > accept.py

git add accept.py
git commit -m "feat: add invite accept logic"

# 创建 PR 堆叠
git checkout feature/invite-link
gh pr create --title "邀请链接生成" --base main --fill
# → PR #4

git checkout feature/invite-accept
gh pr create --title "邀请接受逻辑" --base feature/invite-link --fill
# → PR #5

# 查看堆叠状态
gh stack status
```

#### Step 4：设置自动化规则 + Agent Merge（10分钟）

```yaml
# 在仓库中创建 .github/agent-merge.yml

version: 1
agent_merge:
  enabled: true
  auto_merge:
    - match: "feature/**"
      rules:
        - checks: all_passing
        - reviews: 1_approval
        - conflict_strategy: auto_resolve

  conflict_resolution:
    strategy: auto_3way_merge
    fallback: create_conflict_pr
```

#### Step 5：使用 Copilot 辅助审查（5分钟）

```bash
# 使用 Copilot CLI 审查变更
copilot review

# 让 Copilot 分析是否违反最佳实践
copilot analyze --deep "检查安全性"
```

### 4.2 练习验收清单

```
□ 成功创建 Projects 看板并添加自定义字段
□ 成功创建 Parent Issue + 3 个 Sub-Issues
□ 成功设置 Sub-Issues 依赖关系
□ 成功创建 Stacked PRs（至少 2 个堆叠 PR）
□ 成功安装并配置 Agent Merge
□ 成功使用 Copilot CLI 审查代码
□ 成功查看依赖树并确认关键路径
```

### 4.3 今日命令速查表

```bash
# ─── GitHub Projects ───
gh project list                              # 列出所有 Project
gh project view <number> --web               # 打开 Project 网页
gh issue create --project "Sprint 24"        # 创建 Issue 并关联 Project

# ─── Issue Fields ───
gh issue create --field "Priority=High"      # 创建 Issue 时设置字段
gh issue edit <number> --field "Effort=5"    # 编辑 Issue 字段
gh issue list --field "Priority=Critical"    # 按字段筛选

# ─── Sub-Issues ───
gh issue create --parent "<parent_number>"   # 创建 Sub-Issue
gh issue create --depends-on "<issue_num>"   # 设置依赖
gh issue view <number> --json subIssues      # 查看子任务树

# ─── Stacked PRs ───
gh stack create                              # 从当前分支创建 PR 堆叠
gh stack status                              # 查看堆叠状态
gh stack rebase                              # 重设堆叠 base
gh stack list                                # 列出堆叠 PR

# ─── Copilot 2026 ───
copilot explain "代码问题描述"                # 解释代码
copilot fix                                  # 修复错误
copilot review                               # 审查变更
copilot commit                               # 生成提交信息
copilot analyze --deep "分析内容"            # 深度分析
copilot ci-analyze                           # 分析 CI 失败
copilot config set reasoning-level deep      # 设置推理级别

# ─── Security & Quality ───
# 配置文件位于 .github/dependabot.yml
# 配置文件位于 .github/workflows/codeql-analysis.yml
```

### 4.4 今日知识图谱

```
GitHub 2026 高级特性
│
├── 📋 项目管理
│   ├── GitHub Projects ←→ Issues 配合
│   ├── Issue Fields（类型化元数据）
│   └── Automation（自动化规则引擎）
│
├── 🔄 高级 PR 工作流
│   ├── Stacked PRs（大 PR 拆小）
│   │   └── gh-stack 管理工具
│   ├── Sub-Issues（任务层级分解）
│   │   └── Dependencies（依赖管理）
│   └── Agent Merge（AI 自动合并）
│
├── 🤖 AI 协作
│   ├── Copilot Desktop App（多 Agent 管理）
│   ├── 百万 Token 上下文
│   ├── 可配置推理级别
│   ├── Canvases（可视化编程空间）
│   └── Copilot CLI（终端 AI）
│
└── 🔒 安全与质量
    ├── Dependabot（依赖漏洞）
    ├── Secret Scanning（密钥泄露）
    └── CodeQL（代码分析）
```

### 4.5 自我检查清单

完成今天的学习后，你应该能够：

**基础（必须掌握）：**
- [ ] 能创建 GitHub Projects 看板并配置自定义字段
- [ ] 能使用 Issue Fields 结构化 Issue 元数据
- [ ] 能创建 Sub-Issues 并设置依赖关系
- [ ] 能使用 gh-stack 管理 Stacked PRs

**进阶（推荐掌握）：**
- [ ] 能配置 Projects 自动化规则
- [ ] 能配置 Dependabot 自动更新
- [ ] 能理解 Copilot Desktop App 的能力
- [ ] 能配置 Agent Merge

**挑战（锦上添花）：**
- [ ] 能在团队推广 Stacked PRs 工作流
- [ ] 能设计组织级别的 Issue Fields 模板
- [ ] 能结合 Copilot Canvases 和 Agent Merge 实现半自动化开发流程

### 4.6 常见问题 FAQ

**Q: Stacked PRs 听起来很好，但我的团队习惯了传统方式，怎么办？**
A: 从小处开始。先在一个中型 Feature 上试验 Stacked PRs，向团队展示它的好处：审阅更快、冲突更少。一旦尝到甜头，自然会推广。

**Q: Issue Fields 和 Labels 有什么区别？**
A: Labels 是纯文本标签（只支持存在/不存在），Issue Fields 是类型化数据（支持数字、日期、枚举等）。Fields 可以排序、聚合、做计算，Labels 只能筛选。

**Q: Agent Merge 安全吗？会不会自动合入有问题的代码？**
A: Agent Merge 有一整套安全机制：必须先通过 CI checks、必须有一定数量的 Approval、冲突自动解决后还会重新运行测试。也可以设置为"仅创建合并建议"（manual_approval 模式）。

**Q: Copilot Desktop App 一定要用吗？**
A: 不是必须。如果你只需要代码补全，VS Code 插件版就够了。但如果你需要管理多个 Agent、查看知识图谱、调整推理级别，桌面应用是更好的选择。

**Q: Sub-Issues 最多能嵌套多少层？**
A: GitHub 官方建议不超过 3 层。太深的嵌套反而不利于管理。一个 Parent Issue + 5-10 个 Sub-Issues 是最佳实践。

### 4.7 今日学习输出

学习完成后，请在 `Claude_Memory/` 或你的学习笔记中记录：

```markdown
# Day 5 学习总结

## 核心收获（用一句话总结每个主题）
- GitHub Projects: ________________________________
- Issue Fields: __________________________________
- Stacked PRs: __________________________________
- Sub-Issues: ___________________________________
- Copilot 2026: _________________________________
- Agent Merge: __________________________________
- Security & Quality: ____________________________

## 最让人"哇塞"的功能
____________________________________________________

## 需要进一步探索的
____________________________________________________

## 明日预告：CI/CD 流水线与 DevOps 实践
```

---

## 📚 延伸阅读

- [GitHub Issues & Projects Documentation](https://docs.github.com/en/issues)
- [Stacked PRs Guide](https://github.com/github/gh-stack)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Dependabot Configuration](https://docs.github.com/en/code-security/dependabot)
- [CodeQL Overview](https://docs.github.com/en/code-security/codeql)

---

*明天 Day 6 将学习 CI/CD 流水线 —— GitHub Actions 高级用法，包括 Matrix Build、环境部署审批（2026 新特性）和完整 DevOps 流程。准备好从"开发"进入"交付"阶段！*
