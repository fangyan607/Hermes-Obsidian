---
created: 2026-06-15
tags:
  - "#LoopEngineering"
  - "#AI"
  - "#Agent"
  - "#教程"
  - "#番茄学习法"
  - "#费曼学习法"
  - "#刻意练习"
  - "#3番茄"
aliases:
  - Loop Engineering 教程
  - 循环工程教程
  - 3番茄精通Loop Engineering
---
# 🔄 3番茄精通 Loop Engineering：从 Prompt 写手到 Loop 架构师

> ⏱ 预计学习时间：3个番茄钟（25分钟×3）
> 🎯 学习方式：边读边想，每番茄后有费曼自测，番茄3包含动手练习
> 🧠 教学方法：费曼学习法
> 📅 创建日期：2026-06-15
> 🔗 来源：[[书库/网络文章/Loop Engineering by Addy Osmani]] & 个人实践经验

---

## 先导：你的日常已经是一个 Loop

在进入正文之前，先想一个问题——

你每天早上打开电脑，第一件事是什么？

刷邮件？看消息？检查昨天的部署？

然后呢？根据看到的情况，决定今天做什么。做完了，检查结果。没过关？再改。过了？部署下一个。

这就是一个 **Loop**。

你一直在写 Loop——只不过是用你的脑子当"控制器"。

**Loop Engineering 要做的，就是把这个"用脑子控制"的部分，交给一个系统。**

---

## 番茄钟1：Loop Engineering 的诞生——从 Prompt 到 Loop 的范式转移（25分钟）

### 1.1 为什么是"Loop"，不是"Prompt"？

**用大白话讲：**

2023年，你和 AI 的对话是这样：

```
你：写一个 Python 函数，读取 CSV 文件
AI：[给你代码]
你：加错误处理
AI：[加上了]
你：再优化一下性能
AI：[又改了一版]
```

你是**操作员**——每一步都要你手动推进。这叫 **Human-in-the-Loop**，你是那个 Loop。

2026年，你和 AI 的对话变成了这样：

```
你：我要一个健壮的 CSV 读取模块。条件和质量标准写在这个文档里。
    运行直到所有条件满足。
AI：[自己发现问题→自己修改→自己验证→循环直到达标]
```

你是**架构师**——你设计了一个系统，让 AI 自己跑 Loop。

核心思维转变：

| 旧世界 | 新世界 |
|--------|--------|
| 你写 Prompt → AI 回复 | 你设计 Loop → AI 自我驱动 |
| 你是操作员 | 你是架构师 |
| 每步人工介入 | 自动化迭代直到满足条件 |
| 关注"怎么问" | 关注"怎么设计验证条件" |
| Prompt Engineering | Loop Engineering |

**关键人物的一句话：**

> *"I don't prompt Claude anymore. I have a bunch of loops running that will prompt Claude and decide what to do next on their own. My job is to write loops."*
> — Boris Cherny, Anthropic Claude Code 负责人

> *"You shouldn't be writing prompts for your coding AI anymore. You should design some loops to guide your AI."*
> — Peter Steinberger, OpenClaw 开发者

> *"Build the loop. Stay the engineer."*
> — Addy Osmani, Google Cloud AI 总监

> ✋ **费曼自测**：用你自己的话，向一个不懂技术的朋友解释"为什么 Loop Engineering 不是另一个新概念，而是一个必然趋势"。不超过三句话。

---

### 1.2 四代 AI 工程范式的进化史

Loop Engineering 不是凭空出现的。理解它的位置，需要看这条进化链：

| 时代 | 范式 | 核心问题 | 代表工具 |
|:----:|:-----|:---------|:---------|
| 2023 | **Prompt Engineering** | "怎么写指令才能让 AI 给出想要的结果？" | ChatGPT, GPT-3.5/4 |
| 2024 | **Context Engineering** | "怎么管理 AI 能看到的信息？" | RAG, Claude Projects, GPTs |
| 2025 | **Harness Engineering** | "怎么给 AI 搭一个可靠的工作环境？" | Claude Code, Codex, Cursor |
| 2026 | **Loop Engineering** | "怎么设计一个能自我运行的 AI 系统？" | Claude Code + `/loop`, `/goal`, Codex Agent |

**每一次进化，不是取代上一代，而是建立在上一代之上：**

- Prompt Engineering 让你学会了"怎么和 AI 说话"
- Context Engineering 让你学会了"给 AI 配什么参考资料"
- Harness Engineering 让你学会了"给 AI 搭什么工具箱"
- **Loop Engineering 让你学会了"让 AI 自己去跑"**

> ✋ **费曼自测**：Prompt Engineering、Context Engineering、Harness Engineering、Loop Engineering 这四者的关系是什么？用一句话说明每代的"核心关注点"。

---

### 1.3 一张图理解 Loop Engineering 的位置

```
Prompt Engineering (2023)     "怎么写指令"
        ↓
Context Engineering (2024)    "给什么上下文"
        ↓
Harness Engineering (2025)    "搭什么环境"
        ↓
Loop Engineering (2026)       "设计什么系统让它自己跑"
        ↓
??? (未来)                     "？？？"
```

**关键洞察**：每一层都是对上一层的"自动化"。你从"手动写每一条指令"一路升级到"设计一个自动运行的智能系统"。

---

### 🍅 番茄钟1结束，休息5分钟

**番茄1核心回顾：**
- ✅ Loop Engineering 的本质：从手动 Prompt 到设计自动循环系统
- ✅ 四代范式进化：Prompt → Context → Harness → Loop
- ✅ 核心转变：人从"操作员"变成"架构师"
- ✅ 三位关键人物：Boris Cherny、Peter Steinberger、Addy Osmani

---

## 番茄钟2：Loop 的六块积木——拆解一个完整循环（25分钟）

### 2.1 Loop 的骨架：ReAct 循环

任何 Loop 的底层都是一个 **ReAct（Reason + Act）模式**：

```
  ┌──────────┐     ┌──────────┐     ┌──────────┐
  │ 感知环境  │ ──→ │ 推理决策  │ ──→ │ 执行动作  │
  │ Gather    │     │ Reason   │     │ Act      │
  └──────────┘     └──────────┘     └──────────┘
        ↑                                    │
        └────────── 验证结果 ←───────────────┘
                   Verify
```

**这个循环一直跑，直到满足停止条件。**

停止条件可以是：
- "所有测试通过，lint 干净"
- "收到了用户确认"
- "达到了最大迭代次数"
- "运行了指定时间"

> ✋ **费曼自测**：用"做饭"打一个比方，解释 ReAct 循环。提示：尝一口→觉得淡→加盐→再尝一口……

---

### 2.2 六块积木：一个完整 Loop 的组件

Addy Osmani 总结了一个完整 Loop 需要 **5个组件 + 1个粘合剂**：

| # | 组件 | 中文 | 一句话 | 真实例子 |
|:-:|:-----|:-----|:-------|:---------|
| 1 | **Automations** | 自动化触发器 | 定时检查和发现任务 | cron job, GitHub Actions 定时触发 |
| 2 | **Worktrees** | 工作树隔离 | 让并行 Agent 互不干扰 | `git worktree`, 临时分支 |
| 3 | **Skills** | 技能知识库 | 给 Agent 写好的"入职手册" | SKILL.md, CLAUDE.md |
| 4 | **Plugins/Connectors** | 插件连接器 | 让 Agent 能操作真实工具 | MCP 协议, GitHub API |
| 5 | **Sub-agents** | 子代理分工 | 写代码的和检查代码的分开 | Maker vs Checker 模式 |
| 6 | **Memory/State** | 持久化记忆 | Agent 会忘，文件不会 | Linear Board, Markdown 状态文件 |

#### 自动化（Automations）——循环的心跳

没有自动化的 Loop 不是 Loop——只是一个手动流程。

```
定时触发器（cron） → 检查条件 → 满足 → 启动 Agent
                              → 不满足 → 等待下一个周期
```

**实际例子**：每天早上8点，自动检查 GitHub Issues 列表，把无人认领的 bug 自动分配给最合适的 Agent。

#### 工作树（Worktrees）——并行不打架

当多个 Agent 同时工作时，最怕冲突——你改了 A 文件，我改了同一份。

Worktree = 给每个 Agent 一个**独立的文件系统副本**。各改各的，最后合并。

```
主分支 main
  ├── worktree/agent-1  ← Agent 1 在这里工作
  ├── worktree/agent-2  ← Agent 2 在这里工作
  └── worktree/agent-3  ← Agent 3 在这里工作
```

#### 技能（Skills）——减少猜测成本

SKILL.md = 给 Agent 的"入职手册"。

不加 SKILL 的 Loop：Agent 每次都要猜测"这个项目的代码风格是什么？测试怎么写？"

加 SKILL 后：Agent 第一次就读到规则，不再猜测。

**好的 SKILL 包含**：
- 项目结构说明
- 代码风格指南
- 测试规范
- 常见陷阱
- 决策优先级的规则

#### 插件/连接器——让 Agent 接触真实世界

一个只读文本的 Agent 做不了多少事。需要给它工具：

| 连接器 | 用途 |
|:-------|:-----|
| GitHub MCP | 读 Issue, 提 PR, Review 代码 |
| Linear MCP | 管理任务, 更新状态 |
| Slack MCP | 发通知, 收集反馈 |
| DB MCP | 查询数据库, 执行迁移 |
| Filesystem MCP | 读写项目文件 |

#### 子代理（Sub-agents）——分工与制衡

**关键原则：Maker 和 Checker 不能是同一个人（或同一个 Agent）。**

```
主 Agent（架构师/管理者）
    ├── Maker Agent（写代码的）—— 关注"产出速度"
    └── Checker Agent（验证的）—— 关注"质量标准"
```

Maker 写完后，Checker 独立验证，如果不通过 → 返回 Maker 修改。

这个分离是**质量保障的底线**。一个 Agent 自己写的代码让它自己检查，它会觉得自己写得很好。

#### 记忆/状态——让 Loop 有"记忆力"

Agent 没有长期记忆。每次新会话都是"失忆"状态。

所以状态必须存在**外部**：

```
状态存储方案：
├── Markdown 文件（最简单，可读）
├── JSON/YAML（结构化，可解析）
├── Linear/Jira Board（可追踪，可协作）
└── 数据库（复杂场景）
```

**状态文件内容示例**：
```markdown
# Loop State - Issue #42

## 当前状态
- 分析阶段：✅ 完成
- 实现阶段：🔄 进行中（60%）
- 测试阶段：⏳ 等待

## 已尝试的方案
1. 方案A：因性能问题被否决
2. 方案B：实现中

## 已知问题
- 边缘情况：空列表时的处理
```

> ✋ **费曼自测**：不看书，写出 Loop 的六块积木名称，并解释为什么"Maker 和 Checker 必须分开"。

---

### 2.3 六块积木的协作流程图

```
                    ┌─────────────────────────┐
                    │    Automation (定时触发)  │
                    │    每天早上8点 / PR创建时  │
                    └───────────┬─────────────┘
                                │
                    ┌───────────▼─────────────┐
                    │    Worktree 隔离环境     │
                    │    agent-1, agent-2 ...  │
                    └───────────┬─────────────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
    ┌─────────▼─────────┐ ┌───▼───────────┐ ┌───▼───────────┐
    │    Skills 加载     │ │  Connectors   │ │  Memory 读取   │
    │  SKILL.md 规则    │ │  GitHub MCP   │ │  状态文件      │
    └───────────────────┘ └───────────────┘ └───────────────┘
              │
    ┌─────────▼─────────┐
    │    Sub-agents      │
    │  Maker → Checker   │
    │  (写)    (验)      │
    └─────────┬─────────┘
              │
    ┌─────────▼─────────┐
    │  验证通过？        │
    │  YES → 合并/部署   │
    │  NO  → 返回 Maker  │
    └───────────────────┘
```

---

### 🍅 番茄钟2结束，休息5分钟

**番茄2核心回顾：**
- ✅ Loop 的底层 = ReAct（感知→推理→执行→验证）
- ✅ 六块积木：Automations, Worktrees, Skills, Connectors, Sub-agents, Memory
- ✅ Maker/Checker 分离是质量生命线
- ✅ 状态必须存在外部，不能依赖 Agent 的记忆

---

## 番茄钟3：动手搭你的第一个 Loop——从理论到实战（25分钟）

### 3.1 实战场景：用 Loop 自动处理 GitHub Issue 中的 Bug 报告

**场景描述：**

你的开源项目有一个 Issue 模板。用户提交 bug 报告后，你希望 Agent 自动：
1. 读 Issue 内容
2. 尝试复现（读代码分析）
3. 定位根因
4. 写修复方案
5. 验证修复
6. 提交 PR

**不用 Loop 之前**：你手动把 Issue 内容粘贴给 Claude，让它分析，拿到建议后再手动改代码，手动测试，手动提 PR。

**用 Loop 之后**：你设计一个 Loop，这些步骤自动完成。你做的是"审核"。

---

### 3.2 设计你的 Loop

#### Step 1：定义停止条件

```
目标：Issue #42 的 bug 被修复
停止条件（全部满足）：
  □ 修复方案通过了 code review（Checker 验证）
  □ 新增的测试覆盖了 bug 场景
  □ 所有已有测试仍然通过
  □ PR 已经创建在 GitHub 上
```

#### Step 2：配置六块积木

```yaml
# loop-config.yaml  (不是真实的配置文件，是设计蓝图)
loop:
  name: "auto-bug-fix"
  trigger:
    type: "webhook"
    event: "github.issue.opened"
    filter: "labels includes 'bug'"
  
  workspace:
    type: "worktree"
    base_branch: "main"
    isolation: "per-agent"
  
  skills:
    - "SKILL.md"           # 项目规则
    - "CONTRIBUTING.md"    # 贡献指南
    - "TESTING.md"         # 测试规范
  
  connectors:
    - "github-mcp"         # 读 Issue, 提 PR
    - "filesystem-mcp"     # 读写项目文件
  
  agents:
    maker:
      role: "分析代码 → 定位 bug → 实现修复"
      model: "claude-sonnet"
    checker:
      role: "验证修复是否正确 → 检查测试覆盖 → 确认风格合规"
      model: "claude-opus"   # 验证用更强的模型
  
  memory:
    type: "markdown-file"
    path: ".loop-state/issue-42.md"
  
  max_iterations: 5  # 防止无限循环
```

#### Step 3：ReAct 循环的实际运转

```
回合 1（Maker）：
  读 Issue → 分析相关代码 → 定位到 utils.py 第42行 → 写出修复 → 写出测试
  → 状态更新："修复完成，等待验证"

回合 1（Checker）：
  读修复 → 发现缺少边缘情况处理（空列表） → 返回 Maker + 反馈
  
回合 2（Maker）：
  读反馈 → 补充边缘情况处理 → 更新测试
  → 状态更新："已修复边缘情况，重新提交验证"

回合 2（Checker）：
  读修复 → 全部通过 → 验证确认
  → 状态更新："验证通过"

→ 停止条件满足 → 自动创建 PR
```

> ✋ **费曼自测**：用你自己的项目举个例子——如果给这个项目配一个 Loop，你会让它自动处理什么？画出它的六块积木分别是什么。

---

### 3.3 你已经在用的 Loop 工具

你可能已经在用 Loop Engineering 了，只是没意识到：

| 工具 / 功能 | 本质是什么 Loop |
|:-----------|:----------------|
| **Claude Code 的 `/loop` 命令** | 定时运行的循环——每 N 分钟执行一次指定 prompt |
| **Claude Code 的 `/goal` 命令** | 目标驱动的循环——运行直到满足条件 |
| **GitHub Actions 定时任务** | Automation 组件——定时触发 |
| **Codex Agent 的持续模式** | 多步 ReAct Loop——Agent 自我迭代 |
| **Cursor Agent 的自动修复** | Maker-Checker Loop——写完自动检查 |
| **n8n / Zapier 工作流** | 可视化的 Loop——触发→处理→验证→下一个 |

**重点**：Loop Engineering 不是一个"新产品"，而是对这些已有模式的**抽象和命名**。

---

### 3.4 警惕：Loop Engineering 的四条红线

Addy Osmani 在文章中特别强调了四个风险：

| 风险 | 表现 | 怎么避免 |
|:-----|:-----|:---------|
| 🔴 **代币成本失控** | Loop 跑了一夜，账单吓人 | 设 `max_iterations`，设预算上限 |
| 🔴 **验证失效** | Loop 在跑但没人检查结果 | Checker 必须独立且可审计 |
| 🔴 **理解债务** | AI 写了你读不懂的代码 | 强制每次 PR 都人工 Review |
| 🔴 **认知投降** | "AI 这么写的，就信它吧" | 永远保留否决权，定期参与 Loop 设计 |

**最重要的原则：**

> *"Build the loop. But build it like someone who still intends to be an engineer, not like someone just responsible for hitting the 'start' button."*
> — Addy Osmani

---

### 3.5 你作为"方老登"的 Loop 实践

从你今天的日记中我注意到一句话：

> *"现在AI智能体是Loop时代了，相对来说prompt和context都落后了。循环自检让AI的能力超过了提示词和上下文。至于SKILL, 我是这么理解的, loop也最终变成SKILL, 成为Agent的一部分。"*

你这个理解非常精准！让我帮你把这个直觉翻译成 Loop Engineering 的语言：

```
你的洞察                    → Loop Engineering 对应概念
─────────────────────────────────────────────────
"prompt落后了"              → 从 Prompt Engineering 升级到 Loop Engineering
"循环自检"                  → ReAct 循环中的 Verify 环节
"SKILL 最终变成 Loop"       → Skill 是 Loop 的"知识注入"组件
"SKILL 成为 Agent 的一部分" → Skill + Connector + Memory 组成 Agent 的"人格"
```

**你的 SKILL 本质上就是一个"封装好的 Loop"**——每次你调用一个 SKILL，你就在执行一个预设计的小循环。

---

### 🍅 番茄钟3结束，教程完成

**番茄3核心回顾：**
- ✅ 实战场景：GitHub Issue Bug 自动修复 Loop
- ✅ Loop 设计的三个步骤：定义停止条件 → 配置积木 → 启动 ReAct
- ✅ 你已经在用 Loop（/loop, /goal, GitHub Actions, n8n）
- ✅ 四条红线：成本、验证、债务、投降
- ✅ 你的"SKILL=Loop"直觉完全正确

---

## 附录：Loop Engineering 速查卡

### 核心概念速查

| 概念 | 一句话 |
|:-----|:-------|
| Loop Engineering | 设计一个自动运行的 AI 系统，而不是手动输入每条 Prompt |
| ReAct 循环 | 感知(Gather)→ 推理(Reason) → 执行(Act) → 验证(Verify) → 循环 |
| 停止条件 | Loop 何时结束的判定标准（"所有测试通过"） |
| Human-in-the-Loop | 人在循环中（手动每一步） |
| Human-as-Architect | 人设计循环系统（自动运行） |
| Maker/Checker | 写代码的 Agent 和验证代码的 Agent 分开 |

### 六块积木速查

| 组件 | 一句话 | 工具举例 |
|:-----|:-------|:---------|
| Automation | 定时/事件触发 | cron, GitHub Actions webhook |
| Worktree | 隔离工作环境 | `git worktree`, 临时分支 |
| Skill | Agent 的入职手册 | SKILL.md, CLAUDE.md |
| Connector | 连接外部工具 | MCP 协议, GitHub API |
| Sub-agent | 分工与制衡 | Maker-Checker 模式 |
| Memory | 持久化状态 | Markdown, Linear, JSON |

### 常用命令速查

| 命令 | 功能 | 平台 |
|:-----|:-----|:-----|
| `/loop 5m "check deploy"` | 每5分钟检查一次部署 | Claude Code |
| `/goal "fix all lint errors"` | 运行直到 lint 全通过 | Claude Code |
| `cron("0 9 * * 1-5")` | 工作日早9点定时任务 | Claude Code |
| `git worktree add` | 创建工作树隔离环境 | Git |

---

## 学习自检清单

- [ ] **番茄1：** 能用自己的话解释"为什么 Loop Engineering 是必然趋势"
- [ ] **番茄1：** 能说出四代范式的名称和每个的核心问题
- [ ] **番茄2：** 能不看书列出 Loop 的六块积木
- [ ] **番茄2：** 能解释"Maker 和 Checker 为什么要分开"
- [ ] **番茄2：** 能说明为什么状态不能存在 Agent 的记忆里
- [ ] **番茄3：** 能为自己当前的项目设计一个简单的 Loop
- [ ] **番茄3：** 能说出 Loop Engineering 的四条红线
- [ ] **番茄3：** 能用自己的话向别人解释"SKILL 和 Loop 的关系"

---

## 刻意练习任务

### 练习1：识别你身边的 Loop
观察你24小时内与 AI 的所有交互——哪些是 "manual prompting"，哪些已经是 "loop"？列出来。

### 练习2：设计一个微 Loop
选一个你日常重复的 AI 任务（比如"帮我 review 这段代码"），用六块积木的方法给它设计一个最小 Loop。

### 练习3：费曼教学
找一个不了解 Loop Engineering 的朋友（或未来的自己），用不超过2分钟的时间解释清楚：
1. Loop Engineering 是什么
2. 为什么它比 Prompt Engineering 更先进
3. 一个现实中的例子

---

> **下一步推荐学习：**
> - 实践 Claude Code 的 `/loop` 和 `/goal` 命令
> - 阅读 Addy Osmani 原文：[Loop Engineering](https://addyosmani.com/blog/loop-engineering/)
> - 创建一个你自己的 SKILL.md，然后想想它怎么变成一个 Loop
>
> *"Build the loop. Stay the engineer."*
