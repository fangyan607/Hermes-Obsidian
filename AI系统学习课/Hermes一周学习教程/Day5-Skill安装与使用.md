# Day 5：Skill 安装与使用

> ⏱ 预计学习时间：10个番茄钟（约4.5小时）
> 🎯 学习目标：掌握 Skill 技能系统，安装和使用技能，用 Kanban 看板编排工作流
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Skill 技能系统
🍅 番茄3-4：安装内置技能
🍅 番茄5-6：使用和触发技能
🍅 番茄7-8：Kanban 看板与工作流编排
🍅 番茄9-10：技能管理 + 复习输出
```

---

## 番茄钟1：理解 Skill 技能系统（25分钟）

### 1.1 用大白话理解 Skill

**Skill 是什么？**

想象你的 AI 助手是一个**智能手机**，Skill 就是**APP**：
- 想要修图？安装修图 APP
- 想要记账？安装记账 APP
- 想要学习？安装学习 APP

**核心思维转变：**

```
没有 Skill：AI 只能聊天，不能执行复杂任务
有了 Skill：AI 可以执行特定领域的复杂任务
```

### 1.2 Skill 的三种类型

| 类型 | 来源 | 示例 |
|:-----|:-----|:-----|
| **内置技能** | Hermes 自带 | 文档处理、代码生成 |
| **社区技能** | 社区贡献 | agentskills.io |
| **自动生成** | 执行复杂任务时自动创建 | 根据你的任务定制 |

### 1.3 Skill 的工作原理

```
用户输入 → 技能匹配器
    ↓
匹配到技能？
    ├── 是 → 执行技能流程
    └── 否 → 普通对话 / 触发自动生成
```

**技能触发方式：**

| 方式 | 示例 |
|:-----|:-----|
| **关键词触发** | "帮我写一个教程" → tutorial-generator |
| **描述匹配** | "整理这些笔记" → note-organizer |
| **手动触发** | `hermes skill run tutorial-generator` |

> ✋ **费曼自测**：Skill 和普通的 AI 对话有什么区别？

---

## 番茄钟2：Skill 目录结构（25分钟）

### 2.1 技能目录结构

```
~/.hermes/skills/
├── built-in/                    # 内置技能
│   ├── document-processor/      # 文档处理
│   │   └── SKILL.md
│   ├── code-generator/          # 代码生成
│   │   └── SKILL.md
│   └── data-analyzer/           # 数据分析
│       └── SKILL.md
│
├── community/                   # 社区技能
│   └── obsidian-helper/
│       └── SKILL.md
│
└── auto-generated/              # 自动生成的技能
    └── custom-workflow-20260606/
        └── SKILL.md
```

### 2.2 SKILL.md 结构

每个技能都有一个 `SKILL.md` 文件：

```markdown
---
name: tutorial-generator
description: 根据主题生成结构化学习教程
triggers:
  - "帮我写.*教程"
  - "生成.*学习文档"
---

# 教程生成器

## 功能
将任意主题转化为结构化学习教程。

## 输入
- 主题名称
- 目标受众（可选）
- 难度级别（可选）

## 输出
- 结构化的学习教程
- 包含费曼自测环节

## 工作流程
1. 分析主题核心概念
2. 设计学习路径
3. 生成教程内容
4. 添加自测问题
```

### 2.3 技能元数据

| 字段 | 作用 | 示例 |
|:-----|:-----|:-----|
| `name` | 技能名称 | tutorial-generator |
| `description` | 技能描述 | 生成学习教程 |
| `triggers` | 触发词（正则） | ["帮我写.*教程"] |

> ✋ **费曼自测**：如果一个技能的触发词是 `["整理.*笔记"]`，用户说什么话可以触发它？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Skill 是 AI 的"APP"
- [ ] 三种类型：内置、社区、自动生成
- [ ] 触发方式：关键词、描述匹配、手动触发

---

## 番茄钟3：安装内置技能（25分钟）

### 3.1 查看可用技能

```bash
# 列出所有可用技能
hermes skill list

# 查看内置技能
hermes skill list --type built-in

# 查看已安装技能
hermes skill list --installed
```

### 3.2 安装技能

**方式一：安装内置技能**

```bash
# 安装单个技能
hermes skill install document-processor

# 安装多个技能
hermes skill install document-processor code-generator data-analyzer
```

**方式二：从社区安装**

```bash
# 从 agentskills.io 安装
hermes skill install --from-community obsidian-helper

# 从 GitHub 安装
hermes skill install --from-github user/skill-name
```

**方式三：本地安装**

```bash
# 从本地目录安装
hermes skill install --from-local ./my-skill
```

### 3.3 验证安装

```bash
# 查看已安装技能
hermes skill list --installed

# 查看技能详情
hermes skill show document-processor
```

> ✋ **费曼自测**：安装 3 个内置技能，并查看安装结果。

---

## 番茄钟4：常用内置技能（25分钟）

### 4.1 内置技能列表

| 技能名 | 功能 | 触发词 |
|:-------|:-----|:-------|
| `document-processor` | 文档处理、格式转换 | "处理这个文档" |
| `code-generator` | 代码生成、优化 | "生成代码" |
| `data-analyzer` | 数据分析、可视化 | "分析这些数据" |
| `note-organizer` | 笔记整理、归档 | "整理笔记" |
| `web-scraper` | 网页抓取、提取 | "抓取网页" |
| `translation` | 翻译、本地化 | "翻译这段话" |

### 4.2 技能使用示例

**示例一：文档处理**

```
You: 帮我处理这个文档，转成 Markdown 格式。

Hermes: [触发 document-processor 技能]
正在处理文档...
转换为 Markdown 格式...
完成！结果如下：
```

**示例二：代码生成**

```
You: 生成一个 Python 脚本，用于批量重命名文件。

Hermes: [触发 code-generator 技能]
分析需求...
生成代码...
添加注释...
完成！

```python
import os

def batch_rename(directory, prefix):
    """批量重命名文件"""
    for i, filename in enumerate(os.listdir(directory)):
        new_name = f"{prefix}_{i+1}{os.path.splitext(filename)[1]}"
        os.rename(os.path.join(directory, filename),
                  os.path.join(directory, new_name))
```
```

### 4.3 安装推荐技能包

```bash
# 安装推荐技能包（适合知识管理）
hermes skill install --bundle knowledge-manager

# 包含：document-processor, note-organizer, translation
```

> ✋ **费曼自测**：使用 `note-organizer` 技能整理一段笔记。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 安装了 3+ 个内置技能
- [ ] 理解各技能的功能
- [ ] 成功触发技能执行

---

## 番茄钟5：手动触发技能（25分钟）

### 5.1 手动触发命令

```bash
# 手动运行技能
hermes skill run <skill-name>

# 带参数运行
hermes skill run tutorial-generator --topic "Python基础"

# 交互式运行
hermes skill run document-processor --interactive
```

### 5.2 技能参数传递

```bash
# JSON 格式参数
hermes skill run data-analyzer --params '{"file": "data.csv", "type": "bar"}'

# 命令行参数
hermes skill run translation --from en --to zh --text "Hello World"
```

### 5.3 查看技能帮助

```bash
# 查看技能帮助
hermes skill help document-processor

# 查看技能参数说明
hermes skill show document-processor --params
```

> ✋ **费曼自测**：手动运行一个技能，并传递参数。

---

## 番茄钟6：对话中触发技能（25分钟）

### 6.1 自然语言触发

```
You: 帮我把这段英文翻译成中文。

Hermes: [触发 translation 技能]
正在翻译...
```

### 6.2 触发词匹配规则

| 触发词正则 | 匹配示例 |
|:-----------|:---------|
| `翻译.*` | "翻译这段话" |
| `帮我写.*教程` | "帮我写Python教程" |
| `分析.*数据` | "分析这些销售数据" |
| `整理.*笔记` | "整理今天的笔记" |

### 6.3 技能执行流程

```
用户输入 → 匹配触发词 → 选择技能
    ↓
检查参数 → 执行技能 → 返回结果
    ↓
更新记忆（可选）
```

### 6.4 技能链式调用

```
You: 抓取这个网页的内容，然后翻译成中文，最后整理成笔记。

Hermes: [触发技能链]
1. web-scraper: 抓取网页内容
2. translation: 翻译成中文
3. note-organizer: 整理成笔记
完成！
```

> ✋ **费曼自测**：在对话中触发一个技能，观察 AI 如何执行。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [x] 能手动触发技能
- [x] 能通过对话触发技能
- [x] 理解技能触发匹配规则

---

## 番茄钟7：Kanban 看板是什么（25分钟）

### 7.1 用大白话理解 Kanban

**Kanban 看板是什么？**

想象你有一个**任务白板**，上面贴着各种便签：

```
┌──────────┬──────────┬──────────┬──────────┬──────────┐
│ 待办(Todo)│ 就绪(Ready)│执行(Running)│完成(Done) │阻塞(Block)│
├──────────┼──────────┼──────────┼──────────┼──────────┤
│          │          │          │          │          │
│  📝 任务A │  ⚡ 任务C │  🚀 任务E │  ✅ 任务G │  ❌ 任务H │
│  📝 任务B │  ⚡ 任务D │          │  ✅ 任务F │          │
│          │          │          │          │          │
└──────────┴──────────┴──────────┴──────────┴──────────┘
```

**Hermes Kanban 就是把这个白板搬到了你的终端和 Desktop App 里**，而且全自动：
- AI 自动把复杂任务拆成看板卡片
- 多 Worker 并行执行任务
- 任务卡住时自动检测回收
- 支持拖拽操作（Desktop App）

**谁需要 Kanban？**

| 场景 | 没看板时 | 有看板时 |
|:-----|:---------|:---------|
| 同时处理 5 个任务 | 手动记录，容易遗漏 | 看板清晰展示所有任务状态 |
| 多步骤工作流 | 一步步手动执行 | AI 自动按顺序执行 |
| 团队协作 | 不知道别人在做什么 | 看板实时同步进度 |

### 7.2 Kanban 状态机

Hermes Kanban 使用标准的状态流转：

```
                    ┌────────────┐
                    │  Triage    │ ← 新任务进入
                    └─────┬──────┘
                          │ 分类评估
                          ▼
                    ┌────────────┐
          ┌────────→│    Todo    │ ← 待办
          │         └─────┬──────┘
          │               │ 准备就绪
          │               ▼
          │         ┌────────────┐
          │         │   Ready    │ ← 可执行
          │         └─────┬──────┘
          │               │ 领取执行
          │               ▼
          │         ┌────────────┐
          │         │  Running   │ ← 执行中
          │         └────┬──┬───┘
          │              │  │
          │         ┌────┘  └────┐
          │         ▼            ▼
          │   ┌──────────┐ ┌──────────┐
          │   │  Blocked  │ │   Done   │
          │   │  (阻塞)   │ │  (完成)  │
          │   └─────┬────┘ └──────────┘
          │         │
          └─────────┘ (解除阻塞后回到 Ready)
          
                    ┌────────────┐
                    │ Archived   │ ← 归档历史
                    └────────────┘
```

### 7.3 Kanban 核心概念

| 概念 | 说明 | 类比 |
|:-----|:-----|:-----|
| **看板** | 任务管理面板 | 项目白板 |
| **列（Column）** | 任务状态分组 | 白板上的分区 |
| **卡片（Card）** | 单个任务单元 | 便签条 |
| **Worker** | 执行任务的进程 | 干活的人 |
| **Dispatcher** | 任务调度器 | 分配任务的经理 |
| **Claim** | 领取任务 | 说"这个我来做" |
| **Heartbeat** | 心跳检测（15分钟TTL） | 定时汇报"我还活着" |
| **Reclaim** | 回收超时任务 | 换人做 |

> ✋ **费曼自测**：用大白话向朋友解释 Kanban 看板是做什么的。如果任务执行者挂了（比如电脑关机），Kanban 会怎么处理？

---

## 番茄钟8：Kanban 实战操作（25分钟）

### 8.1 初始化看板

```bash
# 创建看板数据库（SQLite，WAL模式）
hermes kanban init

# 查看看板状态
hermes kanban status

# 输出示例：
# Kanban: active
# Tasks: 0 total
# Columns: triage(0) → todo(0) → ready(0) → running(0) → done(0) | blocked(0)
```

### 8.2 启动调度器

```bash
# 前台启动 Dispatcher（任务调度器）
hermes kanban dispatcher

# 后台守护进程模式
hermes kanban dispatcher --detach

# 查看 Dispatcher 状态
hermes kanban dispatcher --status

# 停止 Dispatcher
hermes kanban dispatcher --stop
```

### 8.3 看板操作命令

```bash
# 添加任务
hermes kanban add "编写项目文档" --priority high
hermes kanban add "修复登录页面bug" --priority urgent --tags "bug, frontend"

# 查看任务
hermes kanban list                    # 列出所有任务
hermes kanban list --status ready     # 按状态筛选
hermes kanban list --priority urgent  # 按优先级筛选

# 移动任务状态
hermes kanban move <task-id> --to ready
hermes kanban move <task-id> --to running
hermes kanban move <task-id> --to done

# 领取任务（带 Worker 分配）
hermes kanban claim <task-id>
hermes kanban claim <task-id> --worker "worker-1"

# 阻塞/取消阻塞
hermes kanban block <task-id> --reason "等待API密钥"
hermes kanban unblock <task-id>

# 完成任务并归档
hermes kanban done <task-id>
hermes kanban archive <task-id>

# 查看任务详情
hermes kanban show <task-id>

# 查看看板统计
hermes kanban stats
```

### 8.4 Skill + Kanban 工作流

**Skill 和 Kanban 如何协作？**

```
┌─────────────────────────────────────────────────────────────┐
│                    Skill + Kanban 工作流                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  用户: "帮我整理剪藏并生成日报"                              │
│       ↓                                                     │
│  Hermes 将任务拆分为多个看板卡片：                            │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐    │
│  │ 1. 扫描  │→│ 2. 提取  │→│ 3.编译  │→│ 4.生成  │    │
│  │ Clippings│  │ 核心观点 │  │ 结构化  │  │ 日报    │    │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘    │
│       ↓              ↓            ↓            ↓            │
│  skill: scan    skill: extract  skill: compile skill: gen   │
│                                                             │
│  Worker-1 ────── Worker-2 ──── Worker-1 ──── Worker-2      │
│  (可并行)        (可并行)       (依赖)        (依赖)        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**工作流编排脚本示例：**

```json
// 在 Kanban 中定义工作流
{
  "workflow": "knowledge-pipeline",
  "tasks": [
    {
      "title": "扫描 Clippings 目录",
      "skill": "document-processor",
      "dependencies": [],
      "assign_to": "worker-1"
    },
    {
      "title": "提取核心观点",
      "skill": "knowledge-compiler",
      "dependencies": ["扫描 Clippings 目录"],
      "assign_to": "worker-2"
    },
    {
      "title": "生成结构化笔记",
      "skill": "note-organizer",
      "dependencies": ["提取核心观点"],
      "assign_to": "worker-1"
    }
  ]
}
```

```bash
# 从工作流文件导入
hermes kanban import-workflow --file workflow.json

# 查看工作流依赖图
hermes kanban graph <workflow-id>
```

### 8.5 /goal 命令与 Checkpoints

**/goal：设定高层次目标，AI 自动拆解为看板任务**

```
You: /goal 创建一个 AI 新闻日报系统，每天自动抓取、摘要、归档

Hermes: 已理解目标，正在拆解为看板任务...

✅ 创建看板项目：AI 新闻日报系统
├── 📝 [Triage] 步骤1: 配置 RSS 源
├── 📝 [Triage] 步骤2: 创建抓取 Skill
├── 📝 [Triage] 步骤3: 创建摘要 Skill
├── 📝 [Triage] 步骤4: 配置 Cron 定时
└── 📝 [Triage] 步骤5: 设置输出格式

总共 5 个任务，是否开始执行？(y/n)
```

**Checkpoints：在每个重要步骤后保存快照**

```
You: 创建一个检查点

Hermes: ✅ 检查点已保存：checkpoint-20260611-01
可通过 `hermes kanban restore <checkpoint-id>` 回滚到此状态
```

### 8.6 Kanban Swarm（v0.15.0+）

同时使用多个 Worker 并行执行任务：

```bash
# 启动 Swarm 模式（多 Worker 并行）
hermes kanban swarm --workers 4

# 指定 Worker 类型
hermes kanban swarm --workers 3 --type agent

# 查看 Swarm 状态
hermes kanban swarm --status

# 输出示例：
# Swarm: active
# Workers: 4 (3 idle, 1 busy)
# Throughput: 12 tasks/min
```

> ✋ **费曼自测**：创建一个包含 3 个以上步骤的工作流，用 Kanban 导入并执行。
>
> 💡 **复习作业**：设计一个"Obsidian 知识日报"工作流，用 Kanban 编排，至少包含 4 个任务节点和 2 个并行任务。

---

## 🍅 番茄钟7-8结束，休息5分钟

**验证清单：**
- [x] 初始化看板并启动 Dispatcher
- [x] 掌握了 Kanban 基本命令
- [x] 理解了 Skill + Kanban 工作流编排

---

## 番茄钟9：技能管理（25分钟）

### 9.1 技能管理命令

| 命令 | 功能 |
|:-----|:-----|
| `hermes skill list` | 列出技能 |
| `hermes skill install <name>` | 安装技能 |
| `hermes skill uninstall <name>` | 卸载技能 |
| `hermes skill update <name>` | 更新技能 |
| `hermes skill run <name>` | 运行技能 |
| `hermes skill show <name>` | 查看技能详情 |
| `hermes skill enable <name>` | 启用技能 |
| `hermes skill disable <name>` | 禁用技能 |

### 9.2 技能配置

在 `config.yaml` 中配置技能：

```yaml
skills:
  enabled: true
  auto_generate: true
  path: ~/.hermes/skills

  # 技能触发设置
  trigger:
    match_threshold: 0.7    # 匹配阈值
    max_suggestions: 3      # 最大建议数

  # 自动生成设置
  auto_generation:
    enabled: true
    min_complexity: 3       # 最小复杂度（1-5）
```

### 9.3 技能权限管理

```yaml
# 在 SKILL.md 中配置权限
permissions:
  - read: ~/.hermes/
  - write: ~/.hermes/skills/
  - execute: python, bash
```

> ✋ **费曼自测**：禁用一个技能，然后尝试触发它，观察结果。

---

## 番茄钟10：输出成果（25分钟）

### 10.1 刻意练习——Skill安装与使用

**练习目标**：在30分钟内完成 Skill 安装→使用→组合的3轮循环

**任务序列（重复×3）：**

```
===== 循环 1：入门任务 =====
1. 安装3个不同类别的 Skill（文档处理、代码生成、数据分析）
2. 分别测试每个 Skill 能否正常触发和执行
3. 使用 `hermes skill list --installed` 确认安装状态
验证方式：3个 Skill 均能正常执行并输出结果

===== 循环 2：进阶任务 =====
1. 用同一个输入任务测试2个不同 Skill 的输出（如"分析这段文字"）
2. 比较不同 Skill 对同一输入的处理方式和输出差异
3. 记录各自的优缺点
验证方式：能解释不同 Skill 的适用场景差异

===== 循环 3：挑战任务 =====
1. 设计一个2个 Skill 组合的工作流（如"抓取网页→翻译→整理笔记"）
2. 手动按顺序执行这个工作流
3. 将工作流导入 Kanban 看板并启动 Dispatcher 执行
验证方式：组合工作流能自动按顺序完成所有步骤
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Skill 安装与测试 | ⬜ | ⬜ | ⬜ |
| Skill 对比分析 | ⬜ | ⬜ | ⬜ |
| 工作流组合 | ⬜ | ⬜ | ⬜ |
| Kanban 编排执行 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：解释 Skill 和普通对话的区别，以及什么场景适合用 Skill + Kanban 组合？

### 10.2 今日自检清单

- [ ] **番茄1-2**：理解 Skill 系统的工作原理
- [ ] **番茄3-4**：安装 3+ 个技能并测试
- [ ] **番茄5-6**：能手动触发和对话触发技能
- [ ] **番茄7-8**：初始化看板，掌握 Kanban 基础命令和状态机
- [ ] **番茄9-10**：掌握技能管理和 Kanban 命令速查

### 10.3 已安装技能清单

| 技能名 | 功能 | 触发词 |
|:-------|:-----|:-------|
| document-processor | 文档处理 | "处理文档" |
| note-organizer | 笔记整理 | "整理笔记" |
| translation | 翻译 | "翻译" |

### 10.4 Kanban 命令速查

| 命令 | 功能 |
|:-----|:-----|
| `hermes kanban init` | 初始化看板 |
| `hermes kanban status` | 查看看板状态 |
| `hermes kanban add "任务"` | 添加任务 |
| `hermes kanban list` | 列出任务 |
| `hermes kanban move <id> --to <state>` | 移动任务状态 |
| `hermes kanban claim <id>` | 领取任务 |
| `hermes kanban block <id> --reason "原因"` | 阻塞任务 |
| `hermes kanban unblock <id>` | 解除阻塞 |
| `hermes kanban done <id>` | 完成任务 |
| `hermes kanban dispatcher --detach` | 启动后台调度器 |
| `hermes kanban swarm --workers 4` | 启动多Worker并行 |
| `hermes kanban stats` | 查看看板统计 |
| `hermes kanban graph <workflow-id>` | 查看工作流依赖图 |
| `hermes kanban import-workflow --file` | 导入工作流 |

### 10.5 学习笔记模板

```markdown
# Hermes Agent 学习笔记 - Day 5

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
掌握了 Skill 技能系统和 Kanban 看板工作流，可以扩展 AI 能力并编排多步骤任务。

## 关键要点

### 1. Skill 类型
- 内置技能：Hermes 自带
- 社区技能：agentskills.io
- 自动生成：执行复杂任务时创建

### 2. 触发方式
- 关键词触发
- 描述匹配
- 手动触发

### 3. Kanban 看板
- 状态机：triage → todo → ready → running → done/blocked
- Dispatcher 调度器自动分配任务
- Swarm 模式多 Worker 并行
- /goal 自动拆解为看板任务

### 4. 已安装技能
- document-processor
- note-organizer
- translation

## 明日计划
- 学习 Skill 自动生成
- 创建自定义技能
```

---

## 🎉 Day 5 完成！

**今日成果：**
- ✅ 理解 Skill 技能系统
- ✅ 安装 3+ 个技能
- ✅ 掌握触发和管理技能
- ✅ 初始化 Kanban 看板
- ✅ 掌握 Skill + Kanban 工作流编排

**明天预告：** [[Day6-Skill自动生成]] - 学习技能自动生成机制

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day4-人格配置]] - 上一天内容
