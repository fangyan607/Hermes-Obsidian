# Day 7：精通与生态 — Skills、社区、综合实战

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 Skills 开发、了解社区生态、完成综合实战项目
> 🧠 教学方法：费曼学习法 × 项目驱动学习 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：Skills 系统深入
🍅 番茄3-4：自定义 Skill 开发实战
🍅 番茄5-6：社区生态与未来趋势
🍅 番茄7-8：综合复习 + 结业项目 + 洞见输出
```

---

## 番茄钟1：Skills 系统深入（25分钟）

### 1.1 用大白话理解 Skills

**Skills 是什么？**

想象你教一个新同事做一件事：

```
没有 Skills：
  每次都要从头教一遍"如何做代码审查"
  "先检查安全，再检查性能，然后..."

有 Skills：
  你写了一份操作手册《代码审查流程》
  以后说"按流程审查"他就懂了
```

**Skills = 可复用的 AI 工作流模板**

**核心思维转变：**

```
AGENTS.md：告诉 AI 你的项目规则（静态的）
Skills：    告诉 AI 如何执行一个具体任务（流程化的）
```

### 1.2 AGENTS.md vs Skills vs SDK

| 对比项 | AGENTS.md | Skills | SDK |
|:-------|:----------|:-------|:-----|
| **本质** | 声明式规则 | 可执行工作流 | 编程 API |
| **用途** | 控制行为规范 | 复用复杂任务 | 自动化集成 |
| **触发** | 自动加载 | 自动匹配 + 手动触发 | 代码调用 |
| **内容** | "用 TypeScript" | "安全检查的步骤是..." | `client.tasks.create()` |
| **共享** | 项目内 | 全局可复用 | 程序调用 |
| **例子** | 编码规范 | 代码审查流程 | CI/CD 脚本 |

### 1.3 Skills 的工作原理

```
用户说："帮我审查这个 PR"
                  │
                  ▼
Codex 扫描可用 Skills → 尝试匹配描述
                  │
                  ├── 匹配成功 → 执行 Skill 中的步骤
                  │
                  └── 匹配失败 → 大模型自主处理
```

**Skill 的定义：**

```markdown
## Skill: review-pull-request
### Description
审查 Pull Request 的代码改动，给出结构化反馈。

### Steps
1. 获取 PR 的 diff 和上下文
2. 检查安全漏洞（SQL 注入、XSS、硬编码密钥）
3. 检查性能问题（N+1 查询、内存泄漏）
4. 检查代码风格一致性
5. 检查测试覆盖
6. 生成结构化审查报告

### Output
Markdown 格式的审查报告，包含安全/性能/风格/测试四个维度的评分
```

> ✋ **费曼自测**：用你自己的话解释 AGENTS.md、Skills、SDK 三者之间的关系。它们分别解决什么问题？

---

## 番茄钟2：Skill 系统架构（25分钟）

### 2.1 Skills 的存储位置

```
~/.codex/
├── skills/
│   ├── review-pr/
│   │   ├── SKILL.md        ← Skill 定义
│   │   ├── review.py       ← 辅助脚本（可选）
│   │   └── template.md     ← 输出模板（可选）
│   ├── release-check/
│   │   └── SKILL.md
│   └── security-audit/
│       └── SKILL.md
├── AGENTS.md               ← 个人全局指令
└── config.yaml             ← 配置文件
```

### 2.2 Skill 的文件结构

```markdown
# ~/.codex/skills/review-pr/SKILL.md

## Skill: review-pr
### Name (required)
Pull Request Review

### Description (required for auto-match)
审查 PR 代码改动，给出安全、性能、风格、测试四个维度的评分和具体建议。

### Triggers (optional, for manual invocation)
- /review-pr
- /review
- 关键词：审查 PR、代码审查、pull request 审查

### Steps (required)
1. 获取当前分支和 main 分支的 diff
2. 列出所有变更文件
3. 逐文件审查：
   a. 安全：硬编码密钥、注入漏洞、认证缺陷
   b. 性能：N+1 查询、不必要的渲染、大对象
   c. 风格：命名规范、代码格式、最佳实践
   d. 测试：新代码是否有测试、覆盖率是否达标
4. 汇总问题，按严重等级排序
5. 生成结构化审查报告

### Output Format
```markdown
## PR 审查报告

### 变更概览
- 文件数：{files_changed}
- 增删行数：+{insertions}/-{deletions}

### 🚨 安全问题
{security_issues}

### ⚡ 性能问题
{performance_issues}

### 🎨 风格问题
{style_issues}

### 🧪 测试问题
{test_issues}

### 总体评分：{score}/100
```

### Dependencies (optional)
- Node.js 18+
- Git 2.0+

### Environment Variables (optional)
- GITHUB_TOKEN: 用于获取 PR 上下文
```

### 2.3 Skill 触发方式

```bash
# 方式一：自动匹配（根据对话内容）
codex "帮我审查这个 PR"  # Codex 自动匹配到 review-pr Skill

# 方式二：手动触发
/review-pr

# 方式三：别名触发
/review

# 方式四：CLI 参数（计划中）
codex --skill review-pr "审查当前分支"
```

> ✋ **费曼自测**：如果你要创建一个"发布检查"Skill（release-check），它会包含哪些步骤？至少列出 5 步。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Skills = 可复用的工作流模板（比 AGENTS.md 更流程化）
- [ ] 存储位置：`~/.codex/skills/<skill-name>/SKILL.md`
- [ ] 触发方式：自动匹配、手动 `/` 命令、别名

---

## 番茄钟3：自定义 Skill 开发实战（25分钟）

### 3.1 实战项目：创建 3 个实用 Skill

**Skill 1：daily-standup（每日站会助手）**
```markdown
## Skill: daily-standup
### Description
分析昨日代码变动，生成站会报告。

### Steps
1. 获取昨天 9:00 至今的 Git 提交记录
2. 按作者分组
3. 每个作者的提交摘要
4. 列出未完成的 WIP
5. 标记可能阻塞他人的变更

### Output
```markdown
## 每日站会报告

### 昨日完成
- [作者A] 完成了用户认证模块（3 commits）
- [作者B] 修复了登录性能问题（1 commit）

### 今日计划
- [作者A] 开始实现 OAuth 2.0
- [作者B] 代码审查 @作者C 的 PR #42

### 阻塞项
- [作者C] 等待设计稿确认
```
```

**Skill 2：dependency-audit（依赖审计）**
```markdown
## Skill: dependency-audit
### Description
检查项目依赖的安全性和健康度。

### Steps
1. 读取 package.json（或 requirements.txt, Cargo.toml 等）
2. 检查每个依赖的最新版本
3. 标注有安全更新的依赖
4. 检查已弃用的包
5. 计算依赖树深度
6. 生成审计报告

### Output
依赖审计报告，包含安全更新建议和依赖健康评分
```

**Skill 3：code-migration（代码迁移）**
```markdown
## Skill: code-migration
### Description
将一个代码模块从旧模式迁移到新模式（如 JS → TS、Callback → Async）。

### Steps
1. 分析源代码，理解迁移范围
2. 创建迁移方案
3. 逐步执行迁移（保持功能不变）
4. 更新测试
5. 验证迁移后功能正确

### Input
- source: 源文件或目录
- target: 目标模式或语言
```

### 3.2 用 Codex 创建 Skill

```bash
# 让 Codex 帮你创建 Skill
mkdir -p ~/.codex/skills/daily-standup

codex -a auto-edit "
在 ~/.codex/skills/daily-standup/SKILL.md 创建每日站会 Skill
"

# 验证
codex "运行 daily-standup"  # 应该自动匹配到新 Skill
```

### 3.3 Skill 最佳实践

```
✅ 好的 Skill：
  • 单一职责：一个 Skill 只做一件事
  • 步骤清晰：每一步都可以独立验证
  • 有输出格式：用户知道会得到什么
  • 有触发词：方便手动调用
  • 版本控制：Skill 也值得放在 Git 中

❌ 不好的 Skill：
  • 太宽泛："帮我改进代码"
  • 步骤不明确："然后处理所有问题"
  • 没有输出："检查一下"
```

> ✋ **费曼自测**：创建一个你工作场景中需要的 Skill（无论多小），写出它的 Steps 和 Output。哪一步最难定义？

---

## 番茄钟4：Skill 进阶技巧（25分钟）

### 4.1 组合多个 Skill

```markdown
## Skill: release-ship
### Description
发布流程：代码审查 → 测试 → 打包 → 部署

### Steps
1. 运行 review-pr Skill：代码审查
2. 运行 full-test Skill：全量测试
3. 运行 build-package Skill：打包
4. 运行 deploy-staging Skill：部署预发布
5. 运行 smoke-test Skill：冒烟测试
6. 运行 deploy-production Skill：部署生产

### Dependencies
- review-pr
- full-test
- build-package
- deploy-staging
- smoke-test
- deploy-production
```

### 4.2 条件分支 Skill

```markdown
## Skill: conditional-refactor
### Description
根据代码分析结果决定是否需要重构。

### Steps
1. 运行 code-analysis Skill 获取质量报告
2. 检查圈复杂度 > 10 的函数
3. 如果在，执行 refactor-function Skill
4. 检查文件行数 > 200 的文件
5. 如果在，执行 split-module Skill
6. 生成最终报告

### Condition
Only run if code-analysis finds issues with severity >= 🟡
```

### 4.3 共享社区 Skills

**Codex Skill 生态正在形成（类似 VSCode 扩展市场）：**

| 社区 Skill 类型 | 示例 | 适用场景 |
|:----------------|:-----|:---------|
| **安全审计** | security-scan | 每周安全检查 |
| **性能优化** | perf-analyze | 性能瓶颈定位 |
| **文档生成** | doc-gen | 自动生成文档 |
| **测试生成** | test-writer | 补全测试覆盖 |
| **迁移工具** | js-to-ts | 代码语言迁移 |
| **DevOps** | docker-optimize | Docker 优化 |
| **数据库** | sql-review | SQL 审查 |
| **API 设计** | api-design-review | API 规范检查 |

> ✋ **费曼自测**：你工作中最常遇到的重复性任务是什么？把它做成一个 Skill 能节省多少时间？

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] 单一职责、步骤清晰、有输出格式 = 好 Skill
- [ ] 多个 Skill 可以组合成更复杂的工作流
- [ ] 社区 Skill 生态正在形成

---

## 番茄钟5：社区生态与未来趋势（25分钟）

### 5.1 Codex 2026 生态全景

```
Codex 生态
┌─────────────────────────────────────────────────────────┐
│                                                         │
│  🎯 核心产品                                            │
│  ├── Codex CLI（开源 Rust）                              │
│  ├── ChatGPT 集成（移动端 + 桌面端）                     │
│  └── 桌面 App（macOS + Windows）                        │
│                                                         │
│  🔧 开发者生态                                          │
│  ├── Codex SDK（Python）                                 │
│  ├── Plugin 系统（100+ 插件）                            │
│  ├── Multi-Provider（8+ 模型）                           │
│  └── Skills 系统（社区共享）                              │
│                                                         │
│  🏢 企业能力                                            │
│  ├── Slack 集成                                          │
│  ├── Sites（即时网页应用）                                │
│  ├── Annotations（精准编辑）                             │
│  └── Role-based Plugins（6 种职业插件）                  │
│                                                         │
│  🔗 第三方生态                                          │
│  ├── @cometix/codex（社区增强版）                        │
│  ├── @just-every/code（Every Code 分支）                │
│  ├── Codex + Ollama（本地模型）                          │
│  └── Codex + Warp（终端集成）                            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 5.2 社区分支与增强版

**@cometix/codex 社区版增强功能：**
- 状态栏：显示模型名、推理强度、用量百分比
- `/translate` 命令：实时翻译推理过程（15+ 模型提供商）
- 人格系统：所有模型都支持人格设定
- 线程管理：支持删除和重新排序

**Every Code 分支（@just-every/code）：**
- Auto Drive：自愈多 Agent 任务编排
- Auto Review：后台幽灵提交监视器
- Code Bridge：Sentry 风格的调试桥
- 浏览器 CDP 集成
- MCP 主题系统

### 5.3 🆕 App 插件系统与 Computer Use 生态（补充）

> **前置条件：** 已安装 Codex Desktop App（详见 [[Codex App 完整指南]]）

#### App 插件（90+ 官方插件）

2026 年 Codex 拥有 **90+ 官方插件**，通过 App 的 Plugin Marketplace 安装：

| 类别 | 插件 | 典型用途 |
|:-----|:------|:---------|
| **开发者工具** | GitHub, GitLab Issues, CircleCI, JIRA | CI/CD、Issue 管理 |
| **设计与创意** | Figma, Canva, Shutterstock | 设计稿→代码、素材处理 |
| **生产力** | Slack, Notion, Gmail, Google Sheets | 自动化办公 |
| **数据分析** | Snowflake, Databricks, Tableau | 数据查询→可视化 |
| **销售** | Salesforce, HubSpot, Outreach | CRM 自动分析 |

**安装方式：** App → Settings → Plugins → Browse Marketplace

#### 6 大角色插件包（2026.06 重磅更新）

OpenAI 面向非技术用户推出了 **6 个职业插件包**：

| 角色 | 核心集成 | 一句话能力 |
|:-----|:---------|:-----------|
| 📊 **数据分析师** | Snowflake + Tableau | "帮我分析 Q2 销售数据，生成可视化报告" |
| 🎨 **创意/营销** | Figma + Canva | "把这篇博客转成社交媒体图文" |
| 💼 **销售** | Salesforce + HubSpot | "找出本月流失风险最高的 10 个客户" |
| 🏗️ **产品设计** | Figma + PRD 模板 | "根据需求文档生成交互式原型" |

> 这意味着 Codex 已从"程序员工具"拓展为"全员 AI 工作台"——20% 用户已是非开发者。

#### Computer Use 生态

**Computer Use** 让 Codex App 能"看见"并操作你的电脑屏幕：

```
你： "打开浏览器，测试登录页面的注册流程"
Codex：截图→识别按钮→模拟点击/输入→截图验证→报告结果
```

**三大开源增强项目：**

| 项目 | GitHub | 功能 |
|:-----|:-------|:------|
| **open-codex-computer-use** | iFurySt/open-codex-computer-use | MCP 服务包装，跨平台 |
| **codex-computer-use-windows** | ezpzai/codex-computer-use-windows | Windows 桌面控制 |
| **codex++-computer-use** | TheAndersMadsen/codex-plusplus-computer-use | 解锁地区限制 |

**实际应用场景：**
- UI 自动化测试（自动填表、截图对比）
- 跨应用操作（从 Figma 取色 → 写 CSS 变量）
- Bug 复现（模拟用户操作步骤）
- 软件配置（自动设置系统偏好）

#### Awesome Codex Skills 社区

**GitHub 仓库：** [ComposioHQ/awesome-codex-skills](https://github.com/ComposioHQ/awesome-codex-skills)

数百个社区贡献的 Skills，覆盖：

| 类别 | Skills 示例 |
|:-----|:------------|
| **开发** | code review、migration audit、PR review + CI fix loop、Sentry triage |
| **生产力** | meeting notes、invoice organizing、email drafting、changelog generation |
| **数据** | spreadsheet formulas、Datadog log analysis、lead research |
| **设计** | brand guidelines、canvas design、image enhancement、GIF creation |

#### 学习路径建议

```
如果你今天刚开始学 Codex App：

1. 先通读 [[Codex App 完整指南]]（6 番茄）
2. 重点掌握：Thread 系统 → Worktree → Review UI
3. 进阶学习：Computer Use → Automations → Plugins
4. 实战：用 App 完成一个多 Agent 并行项目
```

---

### 5.4 2026-2027 趋势预测

```
短中期趋势（6-12 个月）：

1. 工具融合
   Cursor 的 IDE 体验 + Claude Code 的推理 + Codex 的速度
   → 一个终端能调用三个引擎

2. Skill 市场
   类似 VSCode 扩展市场，Skills 成为可买卖的数字资产
   → 企业发布私有 Skills，社区贡献公共 Skills

3. 多 Agent 成为标配
   不再是"一个 AI 帮你写代码"
   而是"一群 AI 协作完成项目"
   → 项目经理配置 Agent 团队，技术 Lead 审查输出

4. 移动端 CI/CD
   手机提交 GitHub Issue → Codex 自动分析 → 自动修复 → 提交 PR
   → 你在地铁上 review 最终结果

5. AI 编程的民主化
   20% 的 Codex 用户是非开发者（2026.05）
   → "用自然语言编程"不再是口号
```

### 5.4 角色插件——Codex 的行业拓展

2026 年 5 月发布的 6 个职业插件：

| 角色 | 集成工具 | 使用场景 |
|:-----|:---------|:---------|
| 📊 数据分析师 | Snowflake, Databricks, Tableau | 数据查询、可视化 |
| 🎨 创意制作 | Figma, Canva, Shutterstock | 设计稿生成、素材处理 |
| 💼 销售 | Salesforce, HubSpot, Slack | 客户数据分析 |
| 🏗️ 产品设计 | Figma, Canva | 原型设计、规范编写 |
| 📈 投行研究 | Moody's, FactSet, S&P | 财务建模、报告生成 |
| 🏥 医疗 | EHR 系统 | 病历分析、合规检查 |

> ✋ **费曼自测**：Codex 正在从"程序员工具"变成"所有人的工作助手"。你觉得这个趋势对你的职业意味着什么？

---

## 番茄钟6：未来工作方式展望（25分钟）

### 6.1 AI 编程工具的三种范式

```
范式一：补全（2018-2023）
  Tab → Tab → Tab
  AI 帮你写下一行
  代表：GitHub Copilot、Codeium

范式二：对话（2023-2025）
  聊天 → 生成代码 → 复制粘贴
  AI 帮你写函数/模块
  代表：ChatGPT、Claude

范式三：代理（2025-至今）
  描述目标 → AI 理解 → AI 执行 → AI 验证
  AI 帮你完成项目
  代表：Codex CLI、Claude Code、Cursor Composer
```

### 6.2 开发者角色的转变

```
传统开发者：100% 手动编码
  ┌─────────────────────────────────────┐
  │ 70% 写代码                          │
  │ 20% 调试                            │
  │ 10% 设计                            │
  └─────────────────────────────────────┘

AI 辅助开发者：50% 协作编码
  ┌─────────────────────────────────────┐
  │ 30% 写 Prompt + 审查 AI 输出        │
  │ 20% 架构设计                        │
  │ 20% 代码审查                        │
  │ 20% 调试复杂问题                    │
  │ 10% 学习新东西                      │
  └─────────────────────────────────────┘

AI 原生开发者：30% 策略 + 70% 自动化
  ┌─────────────────────────────────────┐
  │ 30% 需求分析 + 架构设计             │
  │ 20% 审查 AI 输出                    │
  │ 20% 配置和优化 AI 工作流            │
  │ 15% 调试 AI 解决不了的问题          │
  │ 15% 构建 Skills + AGENTS.md         │
  └─────────────────────────────────────┘
```

### 6.3 给你的建议

```
作为一个 2026 年的开发者，你应该：

🚀 立刻做的：
  1. 学会判断"什么任务给 AI，什么任务自己做"
  2. 建立自己的 AGENTS.md 和 Skills
  3. 至少掌握 Cursor + Claude Code + Codex 中的两个

📈 半年内：
  1. 把重复性工作全部 Skill 化
  2. 建立团队的 AI 编程规范
  3. 探索 AI 原生的工作流设计

🔮 一年内：
  1. 能够用自然语言"描述"一个系统
  2. 具备多 Agent 工作流的编排能力
  3. 对 AI 的输出有准确的判断力

💡 最重要的：
  工具在变，但"做出好产品"的本质没变
  理解业务、理解用户、做出好决策——这些是 AI 替代不了的
```

> ✋ **费曼自测**：你觉得 3 年后，开发者的日常工作会是什么样的？哪些技能会更有价值，哪些会贬值？

---

## 🍅 番茄钟5-6结束，休息5分钟

**核心概念回顾：**
- [ ] Codex 生态：核心产品 + 开发者工具 + 企业能力 + 第三方
- [ ] 趋势：工具融合、Skill 市场、多 Agent、编程民主化
- [ ] 开发者角色从"写代码的人"到"配置 AI 工作流的人"

---

## 番茄钟7：综合复习（25分钟）

### 7.1 一周知识图谱

```
Day 1 ─── 安装配置──→ 三种模式 ──→ 首次对话
                        │
Day 2 ─── AGENTS.md ──→ Sandbox ──→ CLI 精通
                        │
Day 3 ─── Codex vs Claude vs Cursor ──→ 决策框架
                        │
Day 4 ─── 项目一：CLI 工具开发（md-tidy）
                        │
Day 5 ─── SDK ──→ 多 Agent ──→ CI/CD 集成
                        │
Day 6 ─── 代码分析 ──→ 重构规划 ──→ 执行重构
                        │
Day 7 ─── Skills 开发 ──→ 社区生态 ──→ 未来趋势
```

### 7.2 核心能力自检

| 能力 | 掌握度 | 说明 |
|:-----|:-------|:-----|
| 🟢 安装配置 | ✅ | 能独立安装并完成认证 |
| 🟢 三种模式 | ✅ | 知道 Suggest/Auto Edit/Full Auto 的适用场景 |
| 🟢 AGENTS.md | ✅ | 能创建项目级和个人级配置 |
| 🟢 对话技巧 | ✅ | 能写出结构清晰的 Prompt |
| 🟡 CLI 命令 | ✅ | 掌握所有参数和会话内命令 |
| 🟡 Sandbox | ✅ | 理解隔离机制和限制 |
| 🟡 工具对比 | ✅ | 能根据任务选择 Cursor/Claude/Codex |
| 🟠 SDK | 🌀 练习中 | 需要更多编码实践 |
| 🟠 多 Agent | 🌀 练习中 | 理解概念，需要项目经验 |
| 🟠 Skills | 🌀 练习中 | 能创建基础 Skills |
| 🔴 工作流设计 | 🌀 练习中 | 需要更多实战 |
| 🔴 社区贡献 | ❌ 未开始 | 下一步目标 |

### 7.3 命令速查总表

| 类别 | 命令 | 功能 |
|:-----|:-----|:-----|
| **基础** | `codex` | 启动交互模式 |
| | `codex -q "..."` | 静默模式 |
| | `codex -m gpt-5.5` | 指定模型 |
| | `codex -a full-auto` | 指定审批模式 |
| **配置** | `~/.codex/config.yaml` | 全局配置 |
| | `~/.codex/AGENTS.md` | 个人全局指令 |
| | `<project>/AGENTS.md` | 项目指令 |
| **会话内** | `/model <name>` | 切换模型 |
| | `/permissions <mode>` | 切换模式 |
| | `/status` | 查看状态 |
| | `/help` | 帮助 |
| **SDK** | `client.tasks.create()` | 创建任务 |
| | `task.wait()` | 等待结果 |
| | `client.tasks.list()` | 列出任务 |
| **Skills** | `~/.codex/skills/*/SKILL.md` | Skill 定义 |
| | `/<skill-name>` | 手动触发 |

### 7.4 决策框架最终版

```
任务类型 → 工具选择 → 模式选择 → 执行

新功能开发：
  Cursor → Auto Edit → Composer 多文件编辑

复杂重构/棘手 Bug：
  Claude Code → Suggest → 深度分析 → 逐步执行

批量任务/CI/CD/测试：
  Codex CLI → Full Auto → 沙箱执行 → 自动验证

代码审查：
  Codex CLI（快速批量）或 Claude Code（深度审查）

学习新技术：
  Cursor（IDE 探索体验好）

安全审计：
  Claude Code（深度）或 Codex CLI（沙箱隔离）
```

> ✋ **费曼自测**：在一周前，你对 Codex 的认知是什么？现在你的认知发生了哪些变化？用三句话总结你的最大收获。

---

## 番茄钟8：结业项目 + 洞见输出（25分钟）

### 8.1 结业项目

**项目名称：构建你的个人 AI 编程工作流**

要求：
1. 创建一个个人 `AGENTS.md`（Day 2）
2. 创建一个自定义 Skill（Day 7）
3. 设计一个多 Agent 工作流方案（Day 5）
4. 完成一个代码分析 + 一个小重构（Day 6）
5. 写出你的"Codex vs Claude vs Cursor"决策树（Day 3）

**交付物清单：**
```markdown
- [ ] ~/.codex/AGENTS.md 配置完成
- [ ] ~/.codex/skills/your-skill/SKILL.md 创建完成
- [ ] 工作流设计方案（Markdown）
- [ ] 代码库分析报告（Markdown）
- [ ] 工具选择决策树（Markdown 或图表）
```

### 刻意练习——Skill 开发完整流程

**练习目标**：独立完成从 Skill 构思、创建、测试到分享的完整闭环

**任务序列（重复×3）：**

```
===== 循环 1：创建 3 个不同用途的 Skill =====
1. 创建一个"代码审查"Skill（review-pr）
2. 创建一个"每日站会"Skill（daily-standup）
3. 创建一个"依赖审计"Skill（dependency-audit）
验证方式：每个 Skill 都能通过 `/skill-name` 手动触发

===== 循环 2：组合多个 Skill 形成工作流 =====
1. 创建一个"发布流程"Skill（release-ship），组合 review-pr + full-test + deploy
2. 测试组合 Skill 的调用链是否正常
3. 添加条件分支逻辑（如测试失败则终止发布）
验证方式：组合 Skill 能正确调用子 Skill 并按顺序执行

===== 循环 3：分享 Skill 到社区 =====
1. 选择一个你最有信心的 Skill，完善文档和示例
2. 按照社区规范格式化 SKILL.md
3. 准备提交到 Awesome Codex Skills 仓库（或团队内部共享）
验证方式：一个完整的、可直接被他人使用的 Skill 包
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 创建 SKILL.md 文件 | ⬜ | ⬜ | ⬜ |
| 组合多 Skill 工作流 | ⬜ | ⬜ | ⬜ |
| 共享和发布 Skill | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Skill 开发和传统脚本开发有什么本质区别？如果把你的日常工作"Skill 化"，哪些任务最适合先做成 Skill？

### 8.2 结业自检清单

```
📋 Codex 一周精通 · 最终自检

□ 安装使用
  □ 能独立安装 Codex CLI
  □ 理解三种操作模式
  □ 能写出结构化 Prompt

□ 核心功能
  □ 会配置 AGENTS.md
  □ 理解 Sandbox 机制
  □ 掌握所有 CLI 参数

□ 工具对比
  □ 理解 Codex vs Claude vs Cursor 的差异
  □ 能根据任务选择工具

□ 实战能力
  □ 用 Codex 完成过一个项目
  □ 用 Codex 做过代码分析
  □ 用 Codex 执行过重构

□ 高级特性
  □ 理解 SDK 基础
  □ 理解多 Agent 概念
  □ 能创建自定义 Skill

□ 知识体系
  □ 理解 AI 编程范式演进
  □ 有自己的工具决策框架
  □ 能向他人解释"什么时候用什么工具"
```

### 8.3 继续学习的资源

| 资源 | 说明 |
|:-----|:-----|
| [Codex GitHub](https://github.com/openai/codex) | 开源仓库，阅读源码 |
| [OpenAI 官方文档](https://platform.openai.com) | 最新 API 和功能 |
| Codex SDK 文档 | 编程集成指南 |
| Codex 社区 Discord | 交流最佳实践 |
| Skills 分享市场 | 发现他人创建的 Skills |

### 8.4 输出洞见到 MEMORY.md

在 [[MEMORY.md]] 中记录以下洞见：

```markdown
### Codex 一周学习洞见 (2026-06-11)

#### 项目背景
用番茄&费曼学习法完成 OpenAI Codex CLI 一周精通教程，包含工具对比、实战项目和 Skills 开发。

#### 文件索引
| 文件 | 位置 | 内容 |
|------|------|------|
| README | [[AI系统学习课/Codex一周学习教程/README]] | 教程总览 |
| Day 1 | [[AI系统学习课/Codex一周学习教程/Day1-入门与基础]] | 安装、三种模式 |
| Day 2 | [[AI系统学习课/Codex一周学习教程/Day2-核心功能深入]] | AGENTS.md、Sandbox |
| Day 3 | [[AI系统学习课/Codex一周学习教程/Day3-对比与选型]] | 三工具对比 |
| Day 4 | [[AI系统学习课/Codex一周学习教程/Day4-实战项目一CLI工具开发]] | CLI 工具实战 |
| Day 5 | [[AI系统学习课/Codex一周学习教程/Day5-高级特性与工作流]] | SDK、多Agent、CI/CD |
| Day 6 | [[AI系统学习课/Codex一周学习教程/Day6-实战项目二代码库重构]] | 代码重构实战 |
| Day 7 | [[AI系统学习课/Codex一周学习教程/Day7-精通与生态]] | Skills、生态、趋势 |

#### 四大洞见

1. **速度与深度的不可兼得**：Codex CLI 速度是 Claude Code 的 2.4 倍，但推理深度在复杂 Bug 和架构决策上仍有差距。"高速批量→Codex，深度推理→Claude"应成为默认策略。

2. **AGENTS.md 是 AI 时代的 .gitignore**：如果说 .gitignore 定义了"什么不该进版本控制"，AGENTS.md 则定义了"AI 应该怎么和你协作"。这个文件的成熟度决定了 AI 协作效率的上限。

3. **工具组合 > 单一工具信仰**：SWE-bench 第一（Claude）和 Terminal-Bench 第一（Codex）不是同一个工具。2026 年最聪明的开发者用 2-3 个工具，按任务匹配而非品牌忠诚度。

4. **Skills 是新型"脚本语言"**：传统脚本是"人写给机器执行的指令"，Skills 是"人写给 AI 理解的流程"。Skill 化 = 把你的专业知识编码成 AI 可复用的工作流，这是元技能的体现。
```

---

## 🎉 🎉 🎉 恭喜完成一周课程！🎉 🎉 🎉

**一周成果总览：**
- ✅ 安装并配置 Codex CLI
- ✅ 掌握三种操作模式和 AGENTS.md
- ✅ 理解 Codex vs Claude vs Cursor 的区别
- ✅ 完成两个实战项目（CLI 工具 + 代码重构）
- ✅ 掌握 SDK、多 Agent、CI/CD 集成
- ✅ 创建自定义 Skills
- ✅ 输出 4 大洞见记录到 MEMORY.md

---

> **下一步推荐学习：**
> - 深入研究 Codex Agents SDK
> - 探索 MCP（Model Context Protocol）服务集成
> - 学习 Claude Code 的 Agent Teams 高级编排
> - 尝试 Cursor 的 Bugbot 和 Cloud Agents
> - 参与 Codex 社区，贡献 Skills

