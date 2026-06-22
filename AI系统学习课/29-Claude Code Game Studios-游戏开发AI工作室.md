---
created: 2026-06-19
tags:
  - AI系统学习
  - SKILL
  - Claude-Code
  - 游戏开发
  - 番茄费曼
  - 刻意练习
source: https://github.com/Donchitos/Claude-Code-Game-Studios
updated: 2026-06-19
---

# 🍅 Claude Code Game Studios — 游戏开发AI工作室

> **2个番茄 · 费曼学习法 × 刻意练习**
> 把一个 Claude Code 会话变成一整个游戏开发工作室

---

## 📋 学习目标

| 项目 | 内容 |
|------|------|
| **学习主题** | Claude Code Game Studios（CCGS）—— 基于 Claude Code 的游戏开发 AI 代理系统 |
| **掌握程度** | □ 了解 → ✅ 理解 → □ 应用 → □ 教授他人 |
| **学习方法** | 番茄工作法 🍅 + 费曼学习法 📝 + 刻意练习 🎯 |
| **总时长** | 2个番茄 = 50分钟专注 + 10分钟休息 |

---

## ⏱️ 番茄规划总览

```
🍅 番茄1 (25min) → 理解核心架构（学什么、为什么、怎么组织的）
🥤 休息  (5min)
🍅 番茄2 (25min) → 上手实战路径（从克隆到第一次/start）
```

---

# 🍅 番茄1：理解核心架构（25分钟）

> **费曼阶段**：学习输入 → 核心提取
> **刻意练习**：用自己的话复述49Agent三级层级结构

---

## 🔰 1.1 这是什么？（费曼三句话热身）

| 你问 | 费曼回答 |
|------|----------|
| **它是什么？** | 一套开箱即用的 Claude Code 配置模板，让你的 AI 编程助手从"一个人干活"变成"一整个游戏工作室协作" |
| **为什么需要它？** | 单人用 AI 做游戏容易写出硬编码、跳过设计文档、没有 QA——CCGS 用 49 个专业 Agent 模拟真实工作室的分工、审核流程和质量门禁 |
| **怎么做到的？** | 通过 .claude/agents（49个Agent定义）+ .claude/skills（73个斜杠命令）+ .claude/hooks（12个自动化钩子）+ .claude/rules（11个路径规则）四层架构实现 |

---

## 🏗️ 1.2 核心架构（刻意练习·层级复述）

### 整体结构

```
CLAUDE.md ← 主配置文件，一切从这里开始
└── .claude/
    ├── agents/         ← 49个AI代理定义
    ├── skills/         ← 73个斜杠命令（/start、/brainstorm、/dev-story...）
    ├── hooks/          ← 12个自动化钩子（提交验证、资产检查、会话钩子）
    ├── rules/          ← 11个路径作用域代码规范
    └── docs/
        ├── workflow-catalog.yaml  ← 七阶段流水线定义
        └── templates/             ← 41个文档模板

src/          ← 游戏源代码
assets/       ← 美术/音频/VFX
design/       ← GDD、叙事文档、关卡设计
docs/         ← 技术文档和ADR
tests/        ← 测试套件（单元/集成/性能/试玩）
prototypes/   ← 可抛弃的原型
production/   ← 冲刺计划、里程碑、发布追踪
```

### 🧠 刻意练习任务（复述49Agent三级层级）

**用自己的话复述——遮住右边，试着回忆左边：**

| 层级 | 角色 | 负责什么 | 回忆 ✅ |
|------|------|----------|---------|
| **Tier 1 · 总监 (Opus)** | creative-director | 守护游戏愿景 | □ |
| | technical-director | 守护技术架构 | □ |
| | producer | 跨部门协调、排期 | □ |
| **Tier 2 · 部门主管 (Sonnet)** | game-designer | 游戏设计方向 | □ |
| | lead-programmer | 编程主管 | □ |
| | art-director | 美术方向 | □ |
| | audio-director | 音效方向 | □ |
| | narrative-director | 叙事方向 | □ |
| | qa-lead | 质量保证 | □ |
| | release-manager | 发布管理 | □ |
| | localization-lead | 本地化 | □ |
| **Tier 3 · 专家 (Sonnet/Haiku)** | gameplay-programmer | 游戏玩法 | □ |
| | engine-programmer | 引擎开发 | □ |
| | ai-programmer | AI编程 | □ |
| | network-programmer | 网络 | □ |
| | ui-programmer | UI | □ |
| | level-designer | 关卡设计 | □ |
| | sound-designer | 音效设计 | □ |
| | writer | 写作 | □ |
| | qa-tester | 测试 | □ |
| | ... | （共 35+ 个专家角色） | □ |

> 💡 **协作原则**：总监→主管→专家 垂直委派；同层可横向咨询；冲突上报共同上级；Producer 协调跨部门变更。

### 🎮 引擎专项 Agent

| 引擎 | 主管Agent | 子专家 |
|------|-----------|--------|
| **Godot 4** | godot-specialist | GDScript / Shaders / GDExtension |
| **Unity** | unity-specialist | DOTS-ECS / Shaders-VFX / Addressables / UI Toolkit |
| **Unreal 5** | unreal-specialist | GAS / Blueprints / Replication / UMG-CommonUI |

---

## ⚡ 1.3 73个斜杠命令速览（刻意练习·分类记忆）

> 不是要全部背下来，而是知道**哪类问题找哪类命令**：

| 类别 | 代表命令 | 什么时候用 |
|------|----------|-----------|
| 🚀 **启动导航** | `/start` `/help` `/setup-engine` | 刚克隆项目、迷路了 |
| 💡 **游戏设计** | `/brainstorm` `/design-system` `/map-systems` | 构思玩法、设计系统 |
| 🎨 **美术** | `/art-bible` `/asset-spec` `/asset-audit` | 制定美术风格、审核资产 |
| 📐 **UX设计** | `/ux-design` `/ux-review` | 设计/评审界面 |
| 🏗️ **架构** | `/create-architecture` `/architecture-decision` | 决定技术架构 |
| 📋 **开发任务** | `/create-epics` `/create-stories` `/dev-story` `/story-done` | 史诗→故事→开发→完成 |
| 🔍 **审核分析** | `/code-review` `/design-review` `/perf-profile` `/balance-check` | 代码审查、性能分析、平衡性 |
| 🧪 **QA测试** | `/qa-plan` `/smoke-check` `/regression-suite` | 制定测试计划、冒烟测试 |
| 📦 **发布** | `/release-checklist` `/launch-checklist` `/changelog` | 发布前检查清单 |
| 👥 **团队协作** | `/team-combat` `/team-narrative` `/team-ui` `/team-qa` | 多Agent协作完成复杂功能 |

> 🔑 **最常用的5个**：`/start` → `/brainstorm` → `/create-epics` → `/dev-story` → `/story-done`

---

## 🔄 1.4 协作协议（非自治系统）

**重要：这不是自动驾驶系统。** 每个 Agent 遵循"询问→展示选项→你决定→草稿→批准"的五步协作协议：

```
Agent: "我有几个方案..."
    ↓
Agent: "方案A的优点是...方案B的优点是..."
    ↓
👤 你: "选方案A"
    ↓
Agent: "这是方案A的草稿，你看..."
    ↓
👤 你: "批准，开始执行"
```

> 🧠 **刻意练习要点**：记住——你永远是决策者。Agent 提供结构化和专业建议，但**方向盘在你手里**。

---

### ☕ 番茄1结束 · 休息5分钟

✅ 番茄1完成确认：
- [ ] 我能说出 CCGS 是什么（49个Agent + 73个技能 + 12个钩子 + 11条规则）
- [ ] 我能复述三级层级结构（总监→主管→专家）
- [ ] 我知道最常用的5个命令
- [ ] 我理解协作协议（不是自动驾驶，你说了算）

---

# 🍅 番茄2：上手实战路径（25分钟）

> **费曼阶段**：简化解释 → 复盘验证
> **刻意练习**：从零到第一次 /start 的决策树

---

## 🚀 2.1 五分钟上手（费曼式简化）

用最简单的话说，怎么开始用 CCGS：

### 步骤1：环境准备

```bash
# 你需要三样东西
1. Git          → 装好了吗？
2. Claude Code  → npm install -g @anthropic-ai/claude-code
3. jq（可选）    → 用于钩子验证，没有也不影响

# Windows 用户注意：主测试平台是 Windows 10 + Git Bash
# macOS/Linux 大部分功能兼容
```

### 步骤2：克隆项目

```bash
git clone https://github.com/Donchitos/Claude-Code-Game-Studios.git my-game
cd my-game
```

### 步骤3：启动 Claude Code

```bash
claude
```

### 步骤4：运行 /start

```
在 Claude Code 中打 /start
→ 系统会问你：你的项目处在哪个阶段？
   (A) 没有想法
   (B) 模糊概念
   (C) 清晰设计
   (D) 已有项目
→ 根据回答，系统引导你到正确的工作流
```

### 步骤5：开始创作

```
/brainstorm      → 头脑风暴游戏创意
/setup-engine    → 配置引擎（Godot/Unity/Unreal）
/create-epics    → 创建史诗任务
/dev-story       → 开始开发一个故事
```

---

## 🧭 2.2 启动决策树（刻意练习·模拟决策）

**刻意练习任务**：用费曼方式画出启动决策树

```
你输入 /start
     ↓
系统问："你的项目处于什么阶段？"
     ↓
┌─ (A) 没有想法 ─────────────┐
│  → /brainstorm               │
│  → 探索游戏创意              │
│  → 然后回到 /start           │
└─────────────────────────────┘

┌─ (B) 模糊概念 ─────────────┐
│  → /brainstorm               │
│  → /design-system            │
│  → 把概念变成设计文档        │
└─────────────────────────────┘

┌─ (C) 清晰设计 ─────────────┐
│  → /create-architecture      │
│  → /create-epics             │
│  → /sprint-plan              │
│  → 开始开发                  │
└─────────────────────────────┘

┌─ (D) 已有项目 ─────────────┐
│  → /project-stage-detect     │
│  → /adopt                    │
│  → 系统分析现有项目结构      │
└─────────────────────────────┘
```

> 🧠 **刻意练习**：遮住右侧，只看选项(A)-(D)，回忆每个选项对应的第一步命令。

---

## ⚙️ 2.3 自动化安全网（12个Hooks）

| Hook | 触发时机 | 干什么 |
|------|---------|--------|
| `validate-commit.sh` | 每次 Git 提交 | 检查硬编码值、TODO格式、JSON合法性 |
| `validate-push.sh` | 每次 Git 推送 | 推送到保护分支时警告 |
| `validate-assets.sh` | 写/编辑资产文件 | 验证命名规范和JSON结构 |
| `session-start.sh` | 会话启动 | 显示当前分支和最近提交 |
| `detect-gaps.sh` | 会话启动 | 检测新项目建议 /start |
| `pre-compact.sh` | 会话压缩前 | 保存进度笔记 |
| `post-compact.sh` | 会话压缩后 | 恢复会话状态 |
| `notify.sh` | 通知事件 | Windows 弹窗通知 |
| `session-stop.sh` | 会话结束 | 归档活跃笔记 |
| `log-agent.sh` | Agent 生成 | 审计追踪开始 |
| `log-agent-stop.sh` | Agent 结束 | 审计追踪完成 |
| `validate-skill-change.sh` | 修改 Skill | 建议运行 /skill-test |

---

## 🎯 2.4 路径规范（代码质量自动门禁）

| 路径 | 强制规范 |
|------|---------|
| `src/gameplay/**` | 数据驱动值、Delta Time、无UI引用 |
| `src/core/**` | 热路径零分配、线程安全、API稳定 |
| `src/ai/**` | 性能预算、可调试性、数据驱动 |
| `src/ui/**` | 不拥有游戏状态、本地化就绪、无障碍 |
| `design/gdd/**` | 8个必需章节、公式格式、边缘案例 |
| `tests/**` | 测试命名、覆盖率、固件模式 |
| `prototypes/**` | 宽松标准、需要README、记录假设 |

---

## 🧪 2.5 费曼三句话复盘（刻意练习·强制输出）

> **规则**：不看资料，用三句话向一个不懂技术的人解释 CCGS

| 我的三句话 | 自评 |
|------------|------|
| ① CCGS 是一个让 AI 帮你做游戏的工具包，它把一个 AI 变成了一整个游戏公司的团队——有导演、主管、程序员、美术师、测试员 | ✅ / ❌ |
| ② 你只需要装好 Claude Code，克隆项目，打一个 `/start` 命令，系统就会根据你的项目情况引导你一步步从创意到发布 | ✅ / ❌ |
| ③ 整个过程你说了算，AI 只给建议和方案，你来做决定——它帮你保持规范、避免犯错，但游戏是你的 | ✅ / ❌ |

### 深度复盘问题

| 问题 | 我的答案 |
|------|----------|
| CCGS 和普通 Claude Code 会话最大的区别是什么？ | ＿ |
| 如果我的游戏想法从模糊变清晰了，流程怎么演进？ | ＿ |
| 三个引擎（Godot/Unity/Unreal）的 Agent 支持有什么不同？ | ＿ |
| hooks 听起来很重，会影响性能吗？（答案：不会，无关操作立即退出） | ＿ |

---

## 📚 2.6 延伸学习路径

| 阶段 | 行动 | 预计番茄 |
|------|------|---------|
| 🍅 3-4 | 实际克隆项目，运行 /start 体验流程 | 2-4 🍅 |
| 🍅 5-6 | 选择一个引擎，运行 /setup-engine 配置 | 2 🍅 |
| 🍅 7-10 | 用 /brainstorm + /design-system 设计一个小游戏 | 4 🍅 |
| 🍅 11-20 | 用 /create-epics + /dev-story + /story-done 开发核心玩法 | 10 🍅 |
| 🍅 21-22 | 用 /code-review + /qa-plan 做质量检测 | 2 🍅 |

---

## 📝 番茄记录

### 番茄1：理解核心架构
- [x] 阅读 README 理解 CCGS 是什么
- [x] 掌握 49Agent 三级层级结构
- [ ] 自己复述一遍三级层级（刻意练习）
- [x] 了解 73 个斜杠命令分类
- [x] 理解协作协议（你永远是决策者）

### 番茄2：上手实战路径
- [x] 掌握 5 步上手流程
- [x] 能画出启动决策树
- [x] 知道 12 个 hooks 的作用
- [x] 完成费曼三句话复盘

---

## 🔗 相关链接

- [[Claude_Memory/CCGS学习洞见-2026-06-19]] — 学习洞见和深度思考
- [[AI系统学习课/番茄工作法完整指南-Obsidian实践版]] — 🍅 番茄工作法指南
- [[AI系统学习课/费曼学习法模板.md]] — 📝 费曼学习法模板
- [[AI系统学习课/30天高效学习计划.md]] — 系统学习计划
- [GitHub: Donchitos/Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
- [[日记/2026-06-19]] — 学习记录日记
