# Day 2：Codex CLI 核心功能深入

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 AGENTS.md、Sandbox 机制、CLI 命令精通
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：AGENTS.md — 用文件控制 AI 行为
🍅 番茄3-4：Sandbox 安全机制详解
🍅 番茄5-6：CLI 命令精通 + 配置进阶
🍅 番茄7-8：复习输出 + 刻意练习
```

---

## 番茄钟1：AGENTS.md — AI 的"项目宪法"（25分钟）

### 1.1 用大白话理解 AGENTS.md

**AGENTS.md 是什么？**

想象你给一个**新同事**一份"团队工作手册"：

```
没有 AGENTS.md：
  你每次都要说"用 TypeScript 严格模式"
  你每次都要提醒"用 Vitest 写测试"

有了 AGENTS.md：
  Codex 自己读手册，自动遵守规则
  你说一次，它永远记住
```

**核心思维转变：**

```
传统方式：上下文中的隐式约定 → 每次需要重复
AGENTS.md：文件中的显式规则 → 一次配置永久生效
```

### 1.2 AGENTS.md 的加载位置

Codex 按以下优先级加载 AGENTS.md：

```
1. ~/.codex/AGENTS.md          ← 你的个人全局指令（最高优先级）
2. <repo-root>/AGENTS.md        ← 项目共享指令
3. <cwd>/AGENTS.md              ← 子目录特定指令（当前目录）
```

**合并规则：** 所有层级合并，越具体越优先。

### 1.3 必须写的 AGENTS.md 内容

一个好的 AGENTS.md 应该包含：

```markdown
## Project Overview
简短描述项目是什么。

## Build/Test/Dev Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
- Dev server: `npm run dev`

## Code Style Guidelines
- TypeScript strict mode
- Prefer functional components with hooks
- Use Vitest for unit tests
- All API calls through src/api/client.ts
- Import order: React → Third-party → Internal

## Git Conventions
- Branch naming: feature/xxx, fix/xxx, chore/xxx
- Commit messages: conventional commits (feat:, fix:, chore:, docs:)
- Always create feature branches for new work

## Review Expectations
- No PR without tests
- 80%+ code coverage
- No console.log in production code
- Error boundaries for all new components
```

### 1.4 个人全局 AGENTS.md

```markdown
# ~/.codex/AGENTS.md

## Personal Preferences
- Prefer functional programming patterns
- Use async/await over .then()
- Write self-documenting code (minimal comments)
- Always handle errors with try/catch
- Use pnpm over npm

## Security
- Never commit API keys or secrets
- Never ignore .gitignore
- Flag any hardcoded credentials

## Communication
- When explaining code, use simple language
- Show diff before and after changes
- Flag breaking changes explicitly
```

> ✋ **费曼自测**：AGENTS.md 和直接在对话中说的提示词有什么本质区别？为什么说它是"持久化"的？

---

## 番茄钟2：AGENTS.md 实战（25分钟）

### 2.1 实战：为你的项目创建 AGENTS.md

```bash
# 在项目根目录创建 AGENTS.md
codex "为这个项目创建一个 AGENTS.md，包含构建命令、代码规范和测试要求"
```

或者手动创建：

```markdown
# AGENTS.md

## Project
Markdown blog generator

## Commands
- Build: `npm run build`
- Test: `npm test`
- Dev: `npm run dev`
- Format: `npx prettier --write .`

## Tech Stack
- Node.js 22
- TypeScript 5.x strict mode
- React 19 with Next.js 15
- Tailwind CSS v4
- Vitest for testing
- pnpm as package manager

## Code Standards
- Barrel exports for all modules
- Path aliases: @/ = src/
- React Server Components by default
- Client components marked with 'use client'
- No default exports (named exports only)

## Testing
- Unit tests next to source files (*.test.ts)
- Integration tests in tests/
- E2E tests in e2e/

## Security
- Validate all user input with Zod
- No raw HTML rendering
- Rate limiting on all API routes
```

### 2.2 Skills 简介（Day 7 深入）

Skills 是 AGENTS.md 的升级版——可重复使用的工作流包：

```markdown
## Skill: release-check
- Run full test suite
- Check for console.log statements
- Verify CHANGELOG is updated
- Bump version in package.json
- Create git tag
```

**AGENTS.md vs Skills：**

| 对比项 | AGENTS.md | Skills |
|:-------|:----------|:-------|
| 用途 | 持久规则 | 可重复工作流 |
| 触发方式 | 自动加载 | 手动或自动触发 |
| 内容 | 声明式规则 | 步骤式流程 |
| 共享 | 项目内 | 全局复用 |

### 2.3 最佳实践

**✅ 应该做的：**
- AGENTS.md 中放**不变**的规则（语言、框架、约定）
- 每次 Prompt 中放**变化**的指令（具体任务）
- 定期 review AGENTS.md，保持更新

**❌ 避免做的：**
- 不要放敏感信息（API Key、密码）
- 不要放已经过时的规则
- 不要把 AGENTS.md 当 To-Do List 用

> ✋ **费曼自测**：创建一个最小可用的 AGENTS.md，包含构建命令和代码规范。解释为什么工具版本号（如 TypeScript 5.x）也很重要。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] AGENTS.md = 控制 Codex 行为的"项目宪法"
- [ ] 三个层级：个人全局 → 项目根 → 子目录
- [ ] 放不变规则，变的部分放 Prompt

---

## 番茄钟3：Sandbox 安全机制（25分钟）

### 3.1 用大白话理解 Sandbox

**Sandbox 是什么？**

想象 Codex 在一个**完全透明的玻璃房间**里工作：

```
没有 Sandbox：
  Codex 可以访问你的整个电脑
  它删除文件你也没办法

有 Sandbox（Full Auto 模式）：
  Codex 在玻璃房间里工作
  它看的到你的代码
  但它改不了系统文件、上不了网（除了 API）
  每次操作你都能看到
```

### 3.2 各平台的 Sandbox 实现

| 平台 | 技术 | 限制 |
|:-----|:-----|:-----|
| **macOS** | Apple Seatbelt（`sandbox-exec`） | 文件系统只读，网络隔离 |
| **Linux** | Docker + iptables/ipset | 容器隔离，仅允许 OpenAI API 出站 |
| **Windows** | WSL2 环境 | 通过 WSL2 使用 Linux sandbox |

### 3.3 不同模式的沙箱行为

```
Suggest 模式：无沙箱限制（你审批每步操作）
Auto Edit 模式：无沙箱限制（文件自动，命令你审批）
Full Auto 模式：沙箱启用（完全隔离）
```

### 3.4 沙箱限制对开发的影响

| 操作 | 沙箱中？ | 替代方案 |
|:-----|:---------|:---------|
| 安装 npm 包 | ❌ 网络被禁 | 在沙箱外先装好 |
| 写文件 | ✅ | 自动权限 |
| 读文件 | ✅ | 自动权限 |
| 运行已有命令 | ✅ | 自动权限 |
| 访问外部 API | ❌ 网络被禁 | 使用 Suggest/Auto Edit 模式 |
| Git push | ❌ 网络被禁 | 使用 Suggest/Auto Edit 模式 |

**实际影响：**
```bash
# 在 Suggest 模式下先安装依赖
codex -a suggest "安装 lodash 和 axios"

# 切换到 Full Auto 执行批量任务
codex -a full-auto "给所有工具函数写单元测试"
```

> ✋ **费曼自测**：为什么 Full Auto 模式需要沙箱？用一句话解释 Sandbox 解决的核心安全问题。

---

## 番茄钟4：多 Provider 支持（25分钟）

### 4.1 不仅仅是 OpenAI

Codex CLI 支持多种模型提供商：

```bash
# 使用 Ollama 本地模型
codex --oss
codex --oss -m gpt-oss:120b

# 通过环境变量使用其他提供商
export OPENAI_BASE_URL="https://api.openai.com/v1"  # 默认

# DeepSeek
export OPENAI_BASE_URL="https://api.deepseek.com"

# Ollama 本地
export OPENAI_BASE_URL="http://localhost:11434/v1"
```

### 4.2 支持的 Provider 一览

| Provider | 配置方式 | 优势 |
|:---------|:---------|:-----|
| **OpenAI**（默认） | 无需配置 | 最稳定，功能最全 |
| **OpenRouter** | `--provider openrouter` | 多模型聚合，价格透明 |
| **Ollama** | `--oss` 或 `OPENAI_BASE_URL` | 本地运行，隐私保护 |
| **Azure** | `--provider azure` | 企业合规 |
| **DeepSeek** | `OPENAI_BASE_URL` | 性价比高 |
| **Gemini** | `--provider gemini` | Google 生态 |
| **Mistral** | `--provider mistral` | 欧洲，隐私优先 |
| **Groq** | `--provider groq` | 极快推理速度 |

### 4.3 Provider 切换注意事项

```yaml
# ~/.codex/config.yaml 配置默认 provider
model: o4-mini
provider: openai  # 可选：openrouter, azure, ollama 等
```

**切换 Provider 的核心影响：**
- **能力不匹配**：不是所有模型都支持 Function Calling
- **速度差异**：本地模型慢 10-100 倍
- **成本差异**：DeepSeek 可能便宜 90%
- **上下文长度**：不同模型支持不同 token 数

> ✋ **费曼自测**：如果你在做隐私敏感的项目（医疗数据），你会选哪个 Provider？为什么？

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] Full Auto 模式下 Sandbox 提供安全隔离
- [ ] 不同平台（macOS/Linux/Windows）沙箱机制不同
- [ ] 沙箱内网络被禁，需提前安装依赖
- [ ] Codex 支持 8+ 种模型提供商

---

## 番茄钟5：CLI 命令精通（25分钟）

### 5.1 所有 CLI 参数详解

```bash
# ===== 基础用法 =====
codex                          # 交互模式
codex "解释这个项目"           # 带初始 Prompt 的交互模式
codex -q "运行测试"            # 静默模式（一次性执行后退出）

# ===== 模型控制 =====
codex -m o4-mini               # 使用 o4-mini 模型（默认，速度快）
codex -m gpt-5.5               # 使用 GPT-5.5（更强推理）
codex -m o3                    # 使用 o3（平衡型）

# ===== 审批模式 =====
codex -a suggest               # Suggest 模式（默认）
codex -a auto-edit             # Auto Edit 模式
codex -a full-auto             # Full Auto 模式

# ===== 高级选项 =====
codex --notify                 # 启用完成通知（macOS）
codex --oss                    # 使用开源模型（Ollama）
codex --provider openrouter    # 指定 Provider
codex --version                # 显示版本

# ===== Shell 补全 =====
codex completion bash          # 生成 Bash 补全脚本
codex completion zsh           # 生成 Zsh 补全脚本
codex completion fish          # 生成 Fish 补全脚本
```

### 5.2 实用快捷方式

```bash
# 作为 "codex" 缩写
alias cx='codex'

# 用 cx 快速提问
cx -q "这个项目有哪些依赖？"

# 用 cx 快速重构
cx -q -m gpt-5.5 "把 main.js 拆成模块"
```

### 5.3 会话内命令

| 命令 | 功能 | 示例 |
|:-----|:-----|:-----|
| `/model <name>` | 切换模型 | `/model gpt-5.5` |
| `/permissions <mode>` | 切换审批模式 | `/permissions auto-edit` |
| `/status` | 查看当前状态 | `/status` |
| `/help` | 查看帮助 | `/help` |
| `/clear` | 清屏 | `/clear` |
| `exit` | 退出 | `exit` |

### 5.4 配置文件完整选项

```yaml
# ~/.codex/config.yaml
model: o4-mini                    # 默认模型
approvalMode: suggest             # 默认审批模式
fullAutoErrorMode: ask-user       # Full Auto 错误处理
notify: true                      # 完成后通知
provider: openai                  # 模型提供商
temperature: 0.7                  # 温度参数（0-1）
maxTokens: 4096                   # 最大生成 token 数
```

> ✋ **费曼自测**：不看书，写出一条 `codex` 命令：用静默模式、GPT-5.5 模型、Full Auto 审批模式，重构 src/ 目录。

---

## 番茄钟6：Codex 集成工作流（25分钟）

### 6.1 典型工作流

**场景一：新功能开发**
```bash
# 1. 先理解现有的代码
codex -q "阅读 src/ 目录，解释当前的认证逻辑"

# 2. 创建新功能
codex -a auto-edit "添加 OAuth 2.0 登录功能，参考现有的 JWT 认证模式"

# 3. 补测试
codex -a auto-edit "给新的 OAuth 功能写单元测试"

# 4. 审查改动
codex -q "审查最近的改动，找出潜在问题"
```

**场景二：代码审查**
```bash
# 审查 PR 改动
git diff main...HEAD | codex -q "审查这些改动，关注安全问题和边界情况"
```

**场景三：Bug 修复**
```bash
# 先让 Codex 理解问题
codex -q "用户反馈登录后跳转 404，阅读代码找出可能的原因"

# 修复
codex -a auto-edit "修复登录后跳转 404 的问题"

# 验证
codex -q "检查修改是否正确，运行相关测试"
```

### 6.2 善用 Git 分支

```bash
# 在分支上使用 Codex
git checkout -b feature/codex-refactor
codex -a auto-edit "重构用户服务模块"

# 审查改动
git diff

# 不满意就回退
git checkout .
```

### 6.3 效率技巧

| 技巧 | 说明 |
|:-----|:------|
| **先读后改** | 先让 Codex 理解代码库，再让它动手改 |
| **从小到大的权限** | Suggest → Auto Edit → Full Auto，逐步信任 |
| **任务分解** | 复杂任务拆成多个小 Prompt，比一个大 Prompt 效果好 |
| **善用 AGENTS.md** | 项目规则放 AGENTS.md，避免每轮重复 |
| **Git 是你的朋友** | 每次 Codex 改动前先 commit，方便回退 |

> ✋ **费曼自测**：你会怎么设计一个"Codex 配合 Git"的工作流？画出你的流程。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 熟悉所有 CLI 参数和会话内命令
- [ ] 能用静默模式执行一次性任务
- [ ] 理解 Codex + Git 的工作流搭配

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

1. **AGENTS.md**
   - AI 的"项目宪法"，持久控制 Codex 行为
   - 三个层级：个人全局 → 项目 → 子目录
   - 放不变的规则，变的部分放 Prompt

2. **Sandbox 机制**
   - Full Auto 模式启用沙箱（macOS Seatbelt / Linux Docker）
   - 沙箱内文件读允许、写允许、网络禁止
   - 需要网络的操作在 Suggest 模式下先完成

3. **多 Provider**
   - 8+ 种模型提供商，通过 `--provider` 或 `OPENAI_BASE_URL` 切换
   - Ollama 本地模型用 `--oss` 参数

4. **CLI 命令**
   - 核心参数：`-m`（模型）、`-a`（审批模式）、`-q`（静默）
   - 会话内：`/model`、`/permissions`、`/status`
   - 最佳实践：先读后改 + 任务分解 + Git 配合

### 7.2 命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `codex -m gpt-5.5` | 指定模型启动 |
| `codex -a full-auto` | 指定审批模式 |
| `codex -q "prompt"` | 静默模式执行 |
| `codex --oss` | 使用开源模型 |
| `codex --notify` | 启用完成通知 |
| `codex completion zsh` | 生成 Zsh 补全 |
| `codex --provider openrouter` | 指定 provider |
| `/model <name>` | 会话内切换模型 |
| `/permissions <mode>` | 会话内切换模式 |

### 7.3 关键对比

| 概念 | 类比 | 一句话理解 |
|:-----|:-----|:-----------|
| AGENTS.md | 项目宪法 | 告诉 Codex 你的项目规则，一次配置永久生效 |
| Sandbox | 玻璃房间 | Full Auto 时的安全隔离，能看能写但上不了网 |
| Suggest | 每步汇报 | 所有操作等你批准 |
| Auto Edit | 半自主 | 文件自动改，命令需确认 |
| Full Auto | 全自主 | 自己在沙箱里干活 |

---

## 番茄钟8：输出成果 + 复习作业（25分钟）

### 8.1 创建学习笔记

```markdown
# Codex CLI 学习笔记 - Day 2

> 日期：2026-06-11
> 完成状态：✅

---

## 核心结论
AGENTS.md 是控制 Codex 行为的关键文件，Sandbox 在 Full Auto 模式下提供安全隔离。

## 关键要点

### 1. AGENTS.md
- 三层加载：个人全局 → 项目根 → 子目录
- 放不变的规则，具体的指令放 Prompt

### 2. Sandbox
- Full Auto 启用，macOS/Linux 实现不同
- 网络被禁，需提前安装依赖

### 3. CLI 精通
- `-m` 选模型，`-a` 选模式，`-q` 静默
- 先读后改，任务分解，Git 配合

## 实践成果
- [ ] 创建了项目 AGENTS.md
- [ ] 体验了三种审批模式
- [ ] 用静默模式完成了一次任务

## 明日计划
- 学习 Codex vs Claude vs Cursor 对比
- 建立工具选型决策框架
```

### 8.2 今日复习作业

**作业 1：AGENTS.md 实战**
为一个真实项目（或新建一个练习项目）创建 AGENTS.md：
```markdown
- [ ] 包含项目描述
- [ ] 包含所有构建/测试/开发命令
- [ ] 包含代码风格规范
- [ ] 包含 Git 约定
- [ ] 启动 codex 验证配置是否生效
```

**作业 2：Sandbox 体验**
```markdown
- [ ] 在 Full Auto 模式下运行 codex
- [ ] 让它尝试 `npm install` 一个包
- [ ] 观察 Sandbox 阻止了什么
- [ ] 在 Suggest 模式下完成同样的操作
- [ ] 对比两种模式的差异
```

**作业 3：思考题**
```
AGENTS.md 和 CLAUDE.md 的职责有什么异同？
如果你的项目同时有 CLAUDE.md（Claude Code）和 AGENTS.md（Codex CLI），
你觉得应该合并还是分开维护？为什么？
```

### 8.3 今日自检清单

- [ ] **番茄1-2**：理解 AGENTS.md 的三层结构和作用
- [ ] **番茄3-4**：理解 Sandbox 机制和 Provider 切换
- [ ] **番茄5-6**：掌握所有 CLI 参数和常用工作流
- [ ] **番茄7-8**：创建学习笔记，完成复习作业

---

## 🎉 Day 2 完成！

**今日成果：**
- ✅ 掌握 AGENTS.md 配置
- ✅ 理解 Sandbox 安全机制
- ✅ CLI 命令精通
- ✅ 掌握多 Provider 配置

**明天预告：** [[Day3-对比与选型]] - Codex vs Claude Code vs Cursor 深度对比

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[AI系统学习课/Hermes一周学习教程/Day2-目录结构与配置文件]] - 类似概念参考
