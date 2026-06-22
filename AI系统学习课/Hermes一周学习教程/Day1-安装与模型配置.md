# Day 1：安装与模型配置

> ⏱ 预计学习时间：10个番茄钟（约4.5小时）
> 🎯 学习目标：完成 Hermes CLI + Desktop App 安装，能正常对话
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Hermes 是什么
🍅 番茄3-4：安装 Hermes CLI
🍅 番茄5-6：配置模型和 API + 首次对话
🍅 番茄7-8：安装 Hermes Desktop 桌面版
🍅 番茄9-10：生态全景 + 复习输出
```

---

## 番茄钟1：理解 Hermes Agent 是什么（25分钟）

### 1.1 用大白话理解 Hermes

**Hermes 是什么？**

想象你有一个**24/7不休息的AI助手**，它不仅会聊天，还能：
- 记住你说过的话（跨会话记忆）
- 学会你教它的技能（Skill系统）
- 同时做多个任务（多Agent并行）
- 连接你的工具和数据库（MCP连接）

**核心思维转变：**

```
传统AI聊天：问一句 → 答一句 → 忘记一切
Hermes Agent：问一句 → 答一句 → 记住你 → 越用越懂你
```

### 1.2 Hermes LLM vs Hermes Agent

| 对比项 | Hermes LLM | Hermes Agent |
|:-------|:-----------|:-------------|
| 是什么 | 一个大语言模型 | 一个AI智能体框架 |
| 能做什么 | 生成文本、回答问题 | 记忆、技能、并行任务 |
| 记忆能力 | 无（每次对话重新开始） | 有（跨会话持久记忆） |
| 工具调用 | 无 | 有（Skill + MCP） |

> ✋ **费曼自测**：用你自己的话向一个非技术人员解释 Hermes Agent 和 ChatGPT 的核心区别。

---

### 1.3 Hermes 核心能力一览

```
┌─────────────────────────────────────────────────────────────┐
│                    Hermes Agent 核心能力                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🧠 记忆系统                                                 │
│  ├── MEMORY.md：长期记忆，跨会话保存                         │
│  ├── USER.md：用户画像、偏好、禁忌                           │
│  └── SOUL.yaml：人格设定、行为模式                           │
│                                                             │
│  ⚡ 技能系统（Skill）                                        │
│  ├── 内置技能：文档处理、代码生成、数据分析                   │
│  ├── 自动生成：执行复杂任务时自动创建新技能                   │
│  └── 手动触发：通过描述匹配技能执行                          │
│                                                             │
│  🔗 外部连接（MCP）                                          │
│  ├── GitHub：自动管理仓库                                    │
│  ├── 数据库：读写数据                                        │
│  └── 自定义：连接任意工具                                    │
│                                                             │
│  🚀 并行执行                                                 │
│  ├── 多Worker：同时运行多个任务                              │
│  ├── Profiles：独立实例隔离                                  │
│  └── Cron：定时任务调度                                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 番茄钟2：支持的模型与 Provider（25分钟）

### 2.1 模型提供商（Provider）

Hermes 支持多种模型提供商：

| Provider | 特点 | 推荐模型 |
|:---------|:-----|:---------|
| **OpenRouter** | 多模型聚合，价格透明 | hermes-4-14b, gpt-4o |
| **OpenAI** | 稳定可靠，生态成熟 | gpt-4o, gpt-4-turbo |
| **Anthropic** | 安全性强，长文本 | claude-sonnet-4 |
| **本地模型** | 隐私保护，免费 | ollama/llama3 |

### 2.2 模型选择建议

**用大白话讲：**

| 使用场景 | 推荐模型 | 原因 |
|:---------|:---------|:-----|
| 日常使用 | hermes-4-14b | 专为Agent优化，性价比高 |
| 复杂推理 | gpt-4o / claude-sonnet-4 | 推理能力强 |
| 预算有限 | gpt-3.5-turbo | 便宜，够用 |
| 隐私要求高 | 本地模型 | 数据不出本地 |

> ✋ **费曼自测**：如果你想用 Hermes 来管理你的 Obsidian 知识库，你会选择哪个模型？为什么？ *claudian坏的很,hermes支持一切主要大模型,deepseek,qianwen都支持,它写的教程完全没有提到,只是写了些国外的大模型,这段需要谨慎观看.我用的就是deepseek chat 开源便宜好用.*

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Hermes Agent 是一个AI智能体框架（不只是模型）
- [ ] 核心能力：记忆、技能、外部连接、并行执行
- [ ] 推荐使用 OpenRouter 作为 Provider

---

## 番茄钟3：安装 Hermes CLI（25分钟）

### 3.1 安装前的准备

**检查环境：**

```bash
# 检查 Python 版本（需要 3.8+）
python --version

# 检查 pip
pip --version

# 检查 Git
git --version
```

### 3.2 安装方式

**方式一：通过 pip 安装（推荐）**

```bash
pip install hermes-agent
```

**方式二：从源码安装**

```bash
git clone https://github.com/NousResearch/hermes-agent.git
cd hermes
pip install -e .
```

### 3.3 验证安装

```bash
# 查看版本
hermes --version

# 查看帮助
hermes --help

# 查看可用命令
hermes --help-commands
```

> ✋ **费曼自测**：安装完成后，运行 `hermes --version`，截图或记录输出结果。

---

## 番茄钟4：交互式配置（25分钟）

### 4.1 运行 Setup 向导

```bash
hermes setup
```

**Setup 向导会引导你配置：**

1. **选择 Provider**
   ```
   ? Select a model provider:
   > OpenRouter (recommended)
     OpenAI
     Anthropic
     Local (Ollama)
   ```

2. **输入 API Key**
   ```
   ? Enter your OpenRouter API key: sk-or-xxxxxxxx
   ```

3. **选择模型**
   ```
   ? Select a model:
   > hermes-4-14b (recommended)
     gpt-4o
     claude-sonnet-4
   ```

4. **配置记忆**
   ```
   ? Enable curated memory? (recommended): Yes
   ? Max memory tokens: 10000
   ```

### 4.2 配置文件位置

Setup 完成后，配置文件在：

```
~/.hermes/
├── config.yaml      # 主配置文件
├── .env             # API 密钥（敏感信息）
└── auth.json        # OAuth 信息（如有）
```

> ✋ **费曼自测**：Setup 向导配置了哪些核心内容？为什么要分开存储 config.yaml 和 .env？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] `hermes --version` 正常显示版本
- [ ] `hermes setup` 完成交互式配置
- [ ] `~/.hermes/` 目录存在

---

## 番茄钟5：配置 API Key（25分钟）

### 5.1 获取 API Key

**OpenRouter（推荐）：**

1. 访问 https://openrouter.ai
2. 注册账号
3. 进入 Settings → API Keys
4. 创建新的 API Key

**费用说明：**

| 模型 | 输入价格 | 输出价格 |
|:-----|:---------|:---------|
| hermes-4-14b | $0.10/1M tokens | $0.30/1M tokens |
| gpt-4o | $2.50/1M tokens | $10.00/1M tokens |
| claude-sonnet-4 | $3.00/1M tokens | $15.00/1M tokens |

### 5.2 配置 .env 文件

**手动创建 .env：**

```bash
# 进入配置目录
cd ~/.hermes

# 创建 .env 文件
touch .env

# 编辑 .env 文件
nano .env  # 或使用你喜欢的编辑器
```

**.env 文件内容：**

```env
# OpenRouter
OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxxxxxx

# OpenAI (可选)
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx

# Anthropic (可选)
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxxxxx
```

### 5.3 验证 API 配置

```bash
# 列出可用模型
hermes model list  × 没有这个命令
hermes model

# 测试连接
hermes model test × 也没有这个命令
```

> ✋ **费曼自测**：为什么不建议把 API Key 直接写在 config.yaml 里？.env 文件应该添加到 .gitignore 吗？


---

## 番茄钟6：首次对话测试（25分钟）

### 6.1 启动对话

```bash
hermes chat
```

### 6.2 测试对话

```
You: 你好，请介绍一下你自己。

Hermes: 你好！我是 Hermes Agent，一个具有持久记忆和技能学习能力的 AI 助手...
```

### 6.3 测试记忆能力

```
You: 请记住，我使用 Obsidian 进行知识管理，我的知识库叫 ideal。

Hermes: 好的，我会记住这个信息。你的知识库名称是 ideal，使用 Obsidian 进行管理...

You: （新会话）我的知识库叫什么？

Hermes: 根据我的记忆，你的知识库叫 ideal，使用 Obsidian 进行管理。
```

### 6.4 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|:-----|:---------|:---------|
| `API Key invalid` | Key格式错误 | 检查.env文件，确保无多余空格 |
| `Model not found` | 模型名称错误 | 运行 `hermes model list` 确认 |
| `Connection timeout` | 网络问题 | 检查代理设置 |
| `Rate limited` | 请求过快 | 等待后重试 |

> ✋ **费曼自测**：启动一个新会话，测试 Hermes 是否能记住你在上一个会话中告诉它的信息。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] API Key 配置成功
- [ ] `hermes model list` 显示可用模型
- [ ] `hermes chat` 能正常对话

---

## 番茄钟7：安装 Hermes Desktop 桌面版（25分钟）

### 7.1 用大白话理解 Desktop App

**Hermes Desktop 是什么？**

想象 Hermes CLI 是**汽车的仪表盘**——功能强大但全是按钮和命令行。Hermes Desktop App 是**中控大屏**——同样的功能，但可视化、可点击、更直观。

Desktop App 用 Electron + React 构建，支持 macOS、Windows、Linux，让你：
- 通过图形界面管理对话和任务
- 可视化看板拖拽操作
- 多 Profile 并发会话
- 内置 Web Dashboard 管理后台

### 7.2 安装前提

Desktop App 安装器会自动处理所有依赖，你只需要：

```bash
# 确认系统满足基本要求
# Windows 10/11、macOS 12+、或主流 Linux 发行版

# 可选：检查是否已有 Hermes CLI
hermes --version
```

> 💡 如果已安装 Hermes CLI，Desktop App 会自动检测并共享同一数据目录（`~/.hermes`），包括所有会话、技能和记忆。

### 7.3 安装 Desktop App

**方式一：从官网下载安装包（推荐，全平台通用）**

访问 https://hermes-agent.nousresearch.com/desktop，下载对应平台的安装器：
- **macOS**：`Hermes-Setup.dmg`
- **Windows**：`Hermes-Setup.exe`
- **Linux**：通过 CLI 脚本安装（见方式二）

安装器会自动处理所有依赖，下载后双击运行即可。

**方式二：通过 CLI 安装和启动（需要先安装 Hermes CLI）**

如果你已安装 Hermes CLI，直接运行以下命令即可安装并启动 Desktop App：

```bash
# 安装并启动 Desktop App
hermes desktop
```

**方式三：全新安装（CLI + Desktop 一步到位）**

如果还没安装 Hermes CLI，使用官方安装脚本（会自动安装 CLI + Desktop）：

```bash
# macOS / Linux / WSL2
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

# Windows（PowerShell）
iex (irm https://hermes-agent.nousresearch.com/install.ps1)
```

> ⚠️ **注意事项**：
> - 安装器不是代码签名的，Windows SmartScreen 可能会警告 → 点击"更多信息"→"仍要运行"
> - 国内用户如果下载慢，可尝试使用代理或镜像站
> - 官方 GitHub 仓库：https://github.com/NousResearch/hermes-agent

### 7.4 验证 Desktop App

```bash
# 方法一：如果通过 CLI 安装
hermes desktop

# 方法二：如果通过安装包安装，在应用程序目录启动
# macOS: 应用程序 → Hermes
# Windows: 开始菜单 → Hermes Desktop

# 启动后你应该看到：
# 1. 主窗口：对话界面
# 2. 左侧栏：Profile 列表
# 3. 顶部：Cmd+K 命令面板入口
# 4. 设置页：模型选择、API 配置
```

> ✋ **费曼自测**：对比 CLI 和 Desktop App 的启动方式，它们各自的优势是什么？
>
> 📖 **官方资料来源**：本安装说明基于 Hermes Agent v0.16.0（v2026.6.5）官方文档。最新安装方式请参考：
> - 官方安装文档：https://hermes-agent.nousresearch.com/docs/
> - GitHub Releases：https://github.com/NousResearch/hermes-agent/releases
> - 桌面版下载：https://hermes-agent.nousresearch.com/desktop

---

## 番茄钟8：Desktop App 配置与 Web Dashboard（25分钟）

### 8.1 Desktop App 首次启动配置

启动 Desktop App 后，跟随引导完成配置：

1. **选择 Profile**（默认或创建新 Profile）
2. **配置 API Key**（自动读取 ~/.hermes/.env）
3. **选择模型**（在下拉菜单中直接选择）
4. **设置语言**（支持简体中文！）

**Desktop App 界面功能区：**

```
┌─────────────────────────────────────────────────────────────┐
│  Hermes Desktop                      [Cmd+K] [⚙️] [👤]     │
├──────────┬──────────────────────────────────────────────────┤
│          │                                                  │
│ 📋 会话  │  你好！我是 Hermes，有什么可以帮你的？             │
│ 💬 对话  │                                                  │
│ 📊 看板  │  > 请列出我的 Profile 配置                       │
│ 🔌 MCP   │                                                  │
│ ⚡ 技能  │  你的当前 Profile：default                       │
│          │  - 模型：hermes-4-14b                            │
│          │  - 记忆：已开启，策展式写入                      │
│          │  - 技能：3 个已安装                              │
│          │                                                  │
│ [Profile: default ▼]                                       │
├──────────┴──────────────────────────────────────────────────┤
│  Status: Connected  |  Model: hermes-4-14b                  │
└─────────────────────────────────────────────────────────────┘
```

### 8.2 Web Dashboard 管理后台

Desktop App 内置 Web Dashboard，通过浏览器访问：

```bash
# 启动 Web Dashboard（在 Desktop App 设置中开启）
# 默认地址：http://localhost:3000

# 也可以通过 CLI 启动
hermes dashboard

# 指定端口
hermes dashboard --port 4000
```

**Web Dashboard 功能：**

| 功能 | 说明 |
|:-----|:------|
| MCP 目录 | 浏览和安装 MCP 服务器 |
| 凭据管理 | 可视化配置 API Key 和 OAuth |
| 消息通道 | 配置 Telegram/ Slack 通知 |
| 网关设置 | 远程访问 OAuth 配置 |
| 用户管理 | 多用户权限管理 |

### 8.3 CLI vs Desktop App 对比

| 对比项 | CLI | Desktop App |
|:-------|:----|:------------|
| 启动速度 | 快（0.8s 冷启动） | 中等（Electron 加载） |
| 操作方式 | 命令行 | 图形界面 |
| 可视化 | 文本输出 | 看板拖拽、图表 |
| 多会话 | 终端标签页 | 标签页 + 并发 Profile |
| 远程访问 | SSH | Web Dashboard + Gateway |
| 资源占用 | 极低 | 中等 |
| 适用场景 | 开发、自动化脚本 | 日常使用、管理后台 |

### 8.4 四大接入方式

| 方式 | 适用场景 | 启动方式 |
|:-----|:---------|:---------|
| **CLI 终端** | 开发、脚本、自动化 | `hermes chat` |
| **Desktop App** | 日常图形化操作 | `hermes desktop` |
| **Web Dashboard** | 远程管理、团队协作 | `hermes dashboard` |
| **Telegram Bot** | 移动端、快捷操作 | Hostinger 托管 |

> ✋ **费曼自测**：根据你的使用习惯，什么场景会用 CLI？什么场景会用 Desktop App？
>
> 💡 **复习作业**：完成 Desktop App 安装，截图启动界面，记录 CLI 和 Desktop 两种方式的使用体验差异。

---

## 🍅 番茄钟7-8结束，休息5分钟

**验证清单：**
- [ ] Desktop App 安装完成
- [ ] 启动后能看到主界面
- [ ] 理解 CLI 和 Desktop 的区别和使用场景

---

## 番茄钟9：今日复习（25分钟）

### 9.1 Day 1 核心概念回顾

**用大白话总结今天学到的内容：**

1. **Hermes Agent 是什么？**
   - 一个AI智能体框架，不只是聊天模型
   - 核心能力：记忆、技能、外部连接、并行执行

2. **为什么要用它？**
   - 跨会话记忆：AI记住你
   - 技能学习：越用越聪明
   - 自动化：24/7 不休息

3. **如何安装？**
   - `pip install hermes-agent`
   - `hermes setup` 交互式配置
   - 配置 .env 存储 API Key

### 9.2 命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `hermes --version` | 查看版本 |
| `hermes setup` | 交互式配置 |
| `hermes chat` | 启动对话 |
| `hermes --help` | 查看帮助 |
| `hermes desktop` | 启动 Desktop App |
| `hermes dashboard` | 启动 Web Dashboard |

---

## 番茄钟10：输出成果（25分钟）

### 10.1 创建学习笔记

在 `Claude_Memory/` 创建今日学习笔记：

```markdown
# Hermes Agent 学习笔记 - Day 1

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
今天完成了 Hermes CLI + Desktop App 的安装和配置，能通过命令行和桌面两种方式使用 Hermes。

## 关键要点

### 1. 概念理解
- Hermes Agent = AI智能体框架（有记忆、能学习）
- 与 ChatGPT 的区别：跨会话记忆 + 技能系统
- CLI 适合开发/自动化，Desktop App 适合日常图形化操作

### 2. 实践成果
- [x] 安装 Hermes CLI
- [x] 安装 Hermes Desktop App
- [x] 配置 OpenRouter API Key
- [x] 测试对话成功

### 3. 遇到的问题
- 问题：____
- 解决：____

## 明日计划
- 学习 ~/.hermes/ 目录结构
- 理解 config.yaml 配置项
```

### 10.2 今日自检清单

- [ ] **番茄1-2**：能解释 Hermes Agent 和 ChatGPT 的区别
- [ ] **番茄3-4**：`hermes --version` 正常显示
- [ ] **番茄5-6**：`hermes chat` 能正常对话
- [ ] **番茄7-8**：Desktop App 安装完成，能正常启动
- [ ] **番茄9-10**：创建了今日学习笔记

### 10.3 刻意练习——安装与模型配置

**练习目标**：在30分钟内完成 Hermes 安装、模型配置和首次对话的完整流程3次

**任务序列（重复×3）：**

```
===== 循环 1：入门任务 =====
1. 在 `/tmp/test-hermes-1` 目录下安装 Hermes CLI
2. 运行 `hermes --version` 验证安装
3. 运行 `hermes setup` 完成基本配置
4. 确认 `~/.hermes/` 目录已创建
验证方式：`hermes --version` 和 `hermes config show` 均正常输出

===== 循环 2：进阶任务 =====
1. 修改 config.yaml 切换3种不同模型（hermes-4-14b → gpt-4o → claude-sonnet-4）
2. 每次切换后运行 `hermes chat` 发送"你好"确认模型能正常响应
3. 观察并记录不同模型对同一问题的回答风格差异
验证方式：记录3个模型的回答，至少发现2个不同点

===== 循环 3：挑战任务 =====
1. 完成一个完整对话流程：启动对话 → 执行3轮问答 → 退出会话
2. 重新启动 Hermes，确认记忆系统保存了之前的对话内容
3. 完成 Desktop App 的安装和首次启动
验证方式：新会话中 Hermes 能回忆起上一轮会话的关键信息
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Hermes CLI 安装 | ⬜ | ⬜ | ⬜ |
| 模型配置与切换 | ⬜ | ⬜ | ⬜ |
| 首次对话测试 | ⬜ | ⬜ | ⬜ |
| Desktop App 安装 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：不看教程，能否独立完成 Hermes 从安装到首次对话的完整流程？

---

## 🎉 Day 1 完成！

**今日成果：**
- ✅ 理解 Hermes Agent 核心概念
- ✅ 完成 CLI 安装
- ✅ 完成 Desktop App 安装
- ✅ 配置 API Key
- ✅ 测试对话成功
- ✅ 了解四大接入方式（CLI/Desktop/Web/Telegram）

**明天预告：** [[Day2-目录结构与配置文件]] - 深入理解配置文件的作用

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Claude_Memory/Hermes Agent学习计划]] - 原始学习计划
