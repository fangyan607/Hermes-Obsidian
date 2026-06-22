# Day 1：Codex CLI 入门与基础

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：完成安装配置，能正常使用 Codex CLI
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Codex CLI 是什么
🍅 番茄3-4：安装与配置
🍅 番茄5-6：首次对话 + 三种模式初探
🍅 番茄7-8：复习输出 + 刻意练习
```

---

## 番茄钟1：什么是 Codex CLI？（25分钟）

### 1.1 用大白话理解 Codex CLI

**Codex CLI 是什么？**

想象你有一个**24/7 随叫随到的超级程序员**，你只需要告诉它你想做什么：

```
你说："帮我写一个 Markdown 转 HTML 的工具"
Codex 会：阅读当前目录 → 规划文件结构 → 写代码 → 运行测试 → 告诉你结果
```

它不像 ChatGPT 那样只"说"不"做"——**Codex 真正动手干活**。

**核心思维转变：**

```
传统聊天式AI：你问 → AI回答 → 你自己动手操作
      Codex CLI：你描述目标 → AI理解代码库 → AI写代码 → AI运行测试 → 完成
```

### 1.2 Codex CLI 不是什么

| 错误认知 | 真相 |
|:---------|:-----|
| "又是一个 IDE 插件" | ❌ 它是**终端优先**的独立 CLI，不依赖任何 IDE |
| "和 ChatGPT 一样" | ❌ 它能读/写文件、执行命令、理解整个项目 |
| "只能给程序员用" | ❌ 20% 用户是非开发者（分析师、设计师、产品经理） |
| "只支持 OpenAI 模型" | ❌ 可通过 `--provider` 使用 Ollama、DeepSeek、Gemini 等 |

### 1.3 它与其他工具的关系

```
架构视角理解 Codex 的位置：

  终端工具              IDE 集成              聊天界面
  ┌────────┐          ┌────────┐            ┌────────┐
  │ Codex  │          │ Cursor │            │ChatGPT │
  │ CLI    │          │ IDE    │            │ 聊天   │
  └───┬────┘          └───┬────┘            └────────┘
      │                    │
      ▼                    ▼
  自动化流水线         日常开发编码
  CI/CD 集成          手动调试审查
  批量任务
```

> ✋ **费曼自测**：用你自己的话向一个非技术人员解释 Codex CLI 和 ChatGPT 的核心区别。

---

## 番茄钟2：Codex CLI 能做什么？（25分钟）

### 2.1 核心能力一览

```
┌─────────────────────────────────────────────────────────────┐
│                    Codex CLI 核心能力                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📖 代码库理解                                               │
│  ├── 扫描整个项目目录                                       │
│  ├── 理解文件结构和依赖关系                                  │
│  └── 根据上下文做精准修改                                   │
│                                                             │
│  ✏️ 文件编辑                                                 │
│  ├── 创建新文件（从零搭建项目）                              │
│  ├── 修改已有文件（重构/加功能）                             │
│  └── 批量处理（大规模替换/格式化）                           │
│                                                             │
│  🚀 命令执行                                                │
│  ├── 运行测试和构建                                         │
│  ├── 安装依赖和执行脚本                                     │
│  └── Git 操作（commit/push/branch）                         │
│                                                             │
│  🔒 安全沙箱                                                │
│  ├── macOS: Apple Seatbelt 文件系统只读                     │
│  ├── Linux: Docker 网络隔离                                 │
│  └── Windows: WSL2 环境                                     │
│                                                             │
│  🧠 项目记忆                                                │
│  ├── AGENTS.md：项目级持久指令                              │
│  ├── ~/.codex/AGENTS.md：个人全局指令                       │
│  └── Skills：可复用的工作流包                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 它能帮你完成什么？

| 任务类型 | 示例 | Codex 表现 |
|:---------|:-----|:-----------|
| 🏗️ 项目脚手架 | "创建一个 FastAPI 项目" | ⭐⭐⭐⭐⭐ |
| 🔧 功能开发 | "添加用户认证模块" | ⭐⭐⭐⭐ |
| 🐛 Bug 修复 | "这个函数在边界值报错" | ⭐⭐⭐ |
| 📝 代码审查 | "审查所有 PR 改动" | ⭐⭐⭐⭐⭐ |
| 🔄 重构优化 | "把 utils.py 拆成模块" | ⭐⭐⭐⭐ |
| 🧪 测试编写 | "给所有 API 写测试" | ⭐⭐⭐⭐⭐ |
| 📚 文档生成 | "为每个函数生成文档字符串" | ⭐⭐⭐⭐⭐ |

### 2.3 2026 年的 Codex CLI 里程碑

| 时间 | 里程碑 |
|:-----|:-------|
| 2025.05 | Codex 研究预览发布 |
| 2025.12 | GPT-5.2-Codex 发布（史上最快采纳的模型） |
| 2026.02 | macOS 桌面应用发布 |
| 2026.03 | Windows 桌面应用发布 |
| 2026.04 | Rust 重写完成，性能提升 3 倍 |
| 2026.05 | 500 万周活用户，20% 是非开发者 |
| 2026.05 | Codex 整合进 ChatGPT 移动端，覆盖 10 亿用户 |
| 2026.06 | Slacks 集成、Sites 功能、Annotations 精准编辑 |

> ✋ **费曼自测**：列出 5 个你工作中可以用 Codex CLI 完成的编码任务。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Codex CLI = 终端优先的 AI 编程代理，不只聊天，而是真正干活
- [ ] 核心能力：代码理解、文件编辑、命令执行、安全沙箱、项目记忆
- [ ] 2026 年已拥有 500 万+ 周活用户

---

## 番茄钟3：安装 Codex CLI + 桌面 App（25分钟）

### 3.1 了解四种入口

Codex 在 2026 年已发展为一个**统一的多入口 AI 代理平台**，核心引擎相同，但各有侧重：

| 入口 | 启动方式 | 界面 | 适合场景 |
|:-----|:---------|:-----|:---------|
| **Codex CLI** 🖥️ | `codex` 终端 | 终端 TUI | 脚本、CI/CD、终端重度用户 |
| **Codex Desktop App** 🖼️ | `codex app` 或 GUI 启动 | 原生桌面 GUI | 多任务并行、可视化审查、GUI 自动化 |
| **Codex Cloud** ☁️ | `chatgpt.com/codex` | Web | 后台异步任务、自动创建 PR |
| **IDE 扩展** 🔌 | VS Code / Cursor 插件 | IDE 内嵌 | 编辑器内使用 |

**核心认知**：所有入口共享同一个 Agent 引擎，只是交互方式不同。你可以从 CLI 无缝切换到 App（`/app` 命令）。

### 3.2 检查环境

```bash
# 检查 Node.js 版本（需要 18+，推荐 22+）
node --version

# 检查 npm
npm --version

# 检查 Git
git --version
```

### 3.3 安装 CLI

**方式一：npm 全局安装（推荐）**

```bash
npm install -g @openai/codex
```

**方式二：Homebrew（macOS）**

```bash
brew install openai/codex
```

### 3.4 安装 Desktop App

**方式一：App Store（macOS 推荐）**

在 **App Store** 搜索 "Codex"，点击「获取」下载安装。

**方式二：Homebrew Cask**

```bash
brew install --cask codex
```

**方式三：Microsoft Store（Windows）**

在 Microsoft Store 搜索 "Codex"，或使用 winget：

```powershell
winget install Codex -s msstore --accept-source-agreements --accept-package-agreements
```

**方式四：官方安装脚本**

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

**方式五：手动下载 DMG/EXE**

访问 [OpenAI Codex 官方页面](https://openai.com/codex/download) 下载安装包。

> **系统要求：**
> - macOS 14+ (Apple Silicon M1-M4 推荐；Intel Mac 需 x86 二进制)
> - Windows 11 推荐（Windows 10 v1809+ 支持但有差异）
> - 内存 8GB+（推荐 16GB）
> - 需要 ChatGPT Plus ($20/月)、Pro ($200/月) 或 Business/Enterprise 订阅

### 3.5 验证安装

```bash
# 查看版本
codex --version

# 查看帮助
codex --help

# 启动桌面 App
codex app
```

**预期输出：**
```
$ codex --version
0.137.0

$ codex --help
OpenAI Codex CLI - AI-powered coding assistant

Usage: codex [options] [prompt]

Options:
  -m, --model <model>         Model to use
  -a, --approval-mode <mode>  Approval mode (suggest|auto-edit|full-auto)
  -q, --quiet                 Non-interactive mode
  --notify                    Show notifications on completion
  --version                   Show version
  -h, --help                  Show help
```

### 3.4 常见安装问题

| 问题 | 原因 | 解决方案 |
|:-----|:-----|:---------|
| `npm install 失败` | 网络问题 | 使用代理或镜像源 |
| `codex 命令找不到` | PATH 问题 | 确认 npm global bin 在 PATH 中 |
| `权限错误` | 权限不足 | macOS/Linux 加 `sudo` |
| `Windows 报错` | 不支持原生 Windows | 安装 WSL2 |

> ✋ **费曼自测**：运行 `codex --version`，确认安装成功。

---

## 番茄钟4：认证与配置（25分钟）

### 4.1 首次运行认证

```bash
# 在项目目录中启动
codex
```

**首次运行会引导你认证：**

```
? How would you like to authenticate?
> Sign in with ChatGPT (recommended)
  Use OpenAI API Key
```

**选项一：ChatGPT 账号登录（推荐）**
- 选择后浏览器会打开 ChatGPT 登录页
- 登录成功后，控制台自动识别
- 使用额度包含在你的 ChatGPT 订阅中（Plus $20/月）

**选项二：API Key**
```bash
export OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxx"
```

### 4.2 全局配置文件

配置文件位置：`~/.codex/config.yaml`

```yaml
model: o4-mini
approvalMode: suggest
fullAutoErrorMode: ask-user
notify: true
```

| 配置项 | 说明 | 默认值 |
|:-------|:-----|:-------|
| `model` | 默认模型 | o4-mini |
| `approvalMode` | 审批模式 | suggest |
| `fullAutoErrorMode` | Full Auto 错误处理 | ask-user |
| `notify` | 完成通知 | true |

### 4.3 支持的模型

| 模型 | 特点 | 速度 | 适用场景 |
|:-----|:-----|:-----|:---------|
| **o4-mini**（默认） | 快速、经济 | ⭐⭐⭐⭐⭐ | 日常开发、简单任务 |
| **GPT-5.5** | 最强推理 | ⭐⭐⭐ | 复杂重构、架构决策 |
| **o3** | 平衡型 | ⭐⭐⭐⭐ | 一般任务 |

切换模型：
```bash
# 启动时指定
codex -m gpt-5.5

# 会话中切换
/model gpt-5.5
```

> ✋ **费曼自测**：完成认证后，运行 `codex` 并确保进入交互模式。记录你用的认证方式。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] `codex --version` 正常显示版本号
- [ ] `codex` 首次运行完成认证
- [ ] `~/.codex/config.yaml` 配置文件存在

---

## 番茄钟5：首次对话（25分钟）

### 5.1 交互模式基础操作

```bash
# 进入项目目录并启动 Codex
cd ~/my-project
codex
```

**界面说明：**
```
Codex CLI 0.137.0                    ← 版本信息
Model: o4-mini (Suggest mode)        ← 当前模式
Working in: /Users/you/my-project    ← 工作目录

You:                                  ← 输入提示符
```

### 5.2 第一次对话

```markdown
You: 这个项目是做什么的？请阅读代码并给我一个概述。

Codex: [扫描目录后] 这是一个 Node.js 项目...
```

```markdown
You: 请帮我创建一个 README.md 文件，包含项目描述和安装说明。
```

```markdown
You: 检查一下代码中是否有潜在的安全问题。
```

### 5.3 核心命令速查

| 命令 | 功能 | 示例 |
|:-----|:-----|:-----|
| `/model <name>` | 切换模型 | `/model gpt-5.5` |
| `/permissions` | 切换审批模式 | `/permissions auto-edit` |
| `/status` | 查看会话状态 | `/status` |
| `/help` | 查看帮助 | `/help` |
| `/clear` | 清屏 | `/clear` |
| `/review` | 审查当前变更 | `/review` |
| `/diff` | 查看代码差异 | `/diff` |
| `/plan` | 先规划再执行 | `/plan "添加认证模块"` |
| `/fork` | 创建 Worktree 分支 | `/fork` |
| `/side` | 侧边模式 | `/side` |
| `/app` | 切换到桌面 App | `/app` |
| `Ctrl+C` | 取消当前操作 | — |
| `exit` | 退出会话 | — |

### 5.4 非交互模式（Quiet Mode）

```bash
# 一次性任务，完成后退出
codex -q "阅读代码库，总结架构"

# 非交互 + 指定模型
codex -q -m gpt-5.5 "重构 src/utils.ts 为模块化结构"

# 执行后通知
codex -q --notify "运行测试并报告结果"
```

> ✋ **费曼自测**：启动 `codex`，向它提问一个关于你项目的简单问题，记录它做了什么。

---

## 番茄钟6：理解三种操作模式（25分钟）

### 6.1 三种模式对比

| 模式 | 权限级别 | 文件编辑 | 命令执行 | 适用场景 |
|:-----|:---------|:---------|:---------|:---------|
| **Suggest**（默认） | 低 | 提议，等你确认 | 提议，等你确认 | 新项目、不熟悉的代码库 |
| **Auto Edit** | 中 | 自动应用 | 提议，等你确认 | 日常开发、信任的项目 |
| **Full Auto** | 高 | 自动应用 | 自动执行 | 信任的项目、CI/CD、批量任务 |

### 6.2 什么时候用什么模式？

**适合 Suggest 模式的场景：**
- ❓ 你对代码库还不熟悉
- 🔬 你在探索新的技术栈
- 📝 你在做代码审查
- ⚠️ 你在生产环境仓库上工作

**适合 Auto Edit 模式的场景：**
- 🏗️ 你在本地开发分支上工作
- 🔧 你熟悉这个代码库
- ✅ 你有良好的 Git 习惯（方便回退）

**适合 Full Auto 模式的场景：**
- 🤖 CI/CD 流水线中
- 📦 批量代码格式化/重构
- 🧪 大规模测试生成
- 🏠 个人项目，不介意风险

### 6.3 如何切换模式

```bash
# 启动时指定
codex -a suggest
codex -a auto-edit
codex -a full-auto

# 会话中切换
/permissions full-auto
```

### 6.4 安全机制

```
                  用户批准
                     ▲
    Suggest ─────── Auto Edit ─────── Full Auto
    每步需确认        文件自动        完全自主
                    命令需确认         沙箱隔离
```

**Full Auto 模式的安全保障：**
- macOS：Apple Seatbelt 沙箱（文件系统只读、网络隔离）
- Linux：Docker 容器 + iptables 防火墙
- 意外处理：`fullAutoErrorMode: ask-user`（出错时询问用户）

> ✋ **费曼自测**：说出 Suggest 模式和 Full Auto 模式的四个核心区别。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] `codex` 交互模式能正常对话
- [ ] 能用 `/model` 切换模型
- [ ] 能用 `/permissions` 切换模式
- [ ] 理解三种模式的差异

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

**用大白话总结今天学到的内容：**

1. **Codex CLI 是什么？**
   - 终端优先的 AI 编程代理，不只是聊天，而是真正动手写代码
   - 能理解代码库、编辑文件、执行命令

2. **和 ChatGPT 有什么区别？**
   - ChatGPT：你说 → 它答 → 你动手
   - Codex：你说目标 → 它理解项目 → 它写代码 → 它测试 → 完成

3. **三种模式怎么选？**
   - 不熟悉 → Suggest（每步确认）
   - 日常开发 → Auto Edit（文件自动，命令确认）
   - 自动化 → Full Auto（完全自主，沙箱保护）

4. **2026 年的 Codex？**
   - 500 万+ 周活用户，20% 是非开发者
   - 已整合进 ChatGPT（移动端、桌面端）
   - 开源（Apache 2.0，Rust 实现）

### 7.2 命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `npm install -g @openai/codex` | 安装 Codex CLI |
| `brew install --cask codex` | 安装 Codex Desktop App（macOS） |
| `winget install Codex` | 安装 Codex Desktop App（Windows） |
| `codex --version` | 查看版本 |
| `codex` | 启动 CLI 交互模式 |
| `codex app` | 启动桌面 App |
| `codex -q "prompt"` | 静默模式（一次性任务） |
| `codex -m gpt-5.5` | 指定模型启动 |
| `codex -a full-auto` | 指定审批模式 |
| `/model <name>` | 会话中切换模型 |
| `/permissions <mode>` | 会话中切换模式 |
| `/app` | CLI 会话中切换到桌面 App |
| `/fork` | 创建 Worktree 分支 |
| `/review` | 审查当前变更 |
| `exit` | 退出会话 |

### 7.3 关键决策点

| 决策 | 建议 |
|:-----|:-----|
| 认证方式 | ChatGPT 登录（推荐，额度包含在订阅中） |
| 默认模型 | o4-mini（速度快，性价比最高） |
| 默认模式 | Suggest（先在安全模式下熟悉） |
| 配置文件 | 设置 `notify: true`，后台任务完成有通知 |

---

## 番茄钟8：输出成果 + 复习作业（25分钟）

### 8.1 创建学习笔记

```markdown
# Codex CLI 学习笔记 - Day 1

> 日期：2026-06-11
> 完成状态：✅

---

## 核心结论
Codex CLI 是一个终端优先的 AI 编程代理，与 ChatGPT 的核心区别是它能"动手干活"（读文件、写代码、执行命令）。

## 关键要点

### 1. 概念理解
- Codex CLI ≠ 聊天机器人，它是能执行任务的 AI 代理
- 三种模式：Suggest（安全）→ Auto Edit（日常）→ Full Auto（自动化）

### 2. 实践成果
- [x] 安装 Codex CLI
- [x] 完成认证（ChatGPT 登录）
- [x] 首次对话成功
- [x] 了解三种操作模式

### 3. 遇到的问题
- 问题：____
- 解决：____

## 明日计划
- 深入学习 AGENTS.md 配置
- 掌握更多 CLI 命令和参数
- 理解 Sandbox 安全机制
```

### 8.2 今日复习作业

**作业 1：概念复述**
用你自己的话回答以下问题：
1. Codex CLI 的工作方式和 ChatGPT 有何本质不同？
2. Suggest、Auto Edit、Full Auto 三种模式分别适合什么场景？
3. 为什么说 Codex CLI 是"终端优先"的工具？

**作业 2：实践操作**
完成以下操作序列：
```
- [ ] 在一个空目录中启动 codex
- [ ] 让 Codex 创建一个 "Hello World" Python 程序
- [ ] 让 Codex 运行这个程序并输出结果
- [ ] 截图或记录输出
```

**作业 3：思考题**
```
如果你今天在工作中只能用 Codex CLI（不能用 IDE），
你能否完成一天的工作？哪些任务可以，哪些不行？
```

### 8.3 今日自检清单

- [ ] **番茄1-2**：能解释 Codex CLI 和 ChatGPT 的区别
- [ ] **番茄3-4**：安装成功，`codex --version` 有输出
- [ ] **番茄5-6**：完成首次对话，理解三种模式差异
- [ ] **番茄7-8**：创建学习笔记，完成复习作业

---

## 🎉 Day 1 完成！

**今日成果：**
- ✅ 理解 Codex CLI 核心概念
- ✅ 完成 CLI 安装和认证
- ✅ 首次对话测试成功
- ✅ 理解三种操作模式

**明天预告：** [[Day2-核心功能深入]] - AGENTS.md、Sandbox、CLI 命令精通

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day3-对比与选型]] - Codex vs Claude vs Cursor 对比
