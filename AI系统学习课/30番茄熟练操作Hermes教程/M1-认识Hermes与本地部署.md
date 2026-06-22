# M1：认识 Hermes + 本地部署

> ⏱ **番茄钟**：🍅1-4（共4个番茄 = 100分钟专注 + 20分钟休息）
> 🎯 **学习目标**：理解 Hermes Agent 是什么，完成本地安装并开始首次对话
> 🧠 **教学方法**：费曼学习法 × 刻意练习

---

## 🍅 番茄1：Hermes Agent 到底是什么（25分钟）

### 1.1 用大白话理解 Hermes

**Hermes Agent** 不是你想象中的又一个聊天机器人。

想象你的生活中有两种助手：

| 类型 | 类比 | 特点 |
|:----|:-----|:-----|
| 🤖 **聊天机器人** | 一个很聪明的朋友 | 问一句答一句，下次见面不记得你 |
| 🦾 **Agent（智能体）** | 一个24/7的私人助理 | 记住你的偏好，帮你执行任务，越用越懂你 |

**Hermes Agent = 私人助理，不是聊天机器人。**

> "聊天机器人告诉你如何订航班，Agent 则会实际动手帮你订好航班。" — Jack Roberts

### 1.2 核心能力全景

```
┌─────────────────────────────────────────────────────────────┐
│                    Hermes Agent 核心能力                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🧠 记忆系统                                                 │
│  ├── 跨会话记忆：今天聊的，明天还记得                          │
│  ├── 用户画像：知道你的偏好和禁忌                             │
│  └── AI人格：自定义说话风格和行为模式                          │
│                                                             │
│  ⚡ 技能系统（Skill）                                        │
│  ├── 内置技能：开箱即用                                      │
│  ├── 自动生成：执行复杂任务时自动创建新技能                    │
│  └── 社区技能：从 agentskills.io 安装                        │
│                                                             │
│  🔗 外部连接（MCP）                                          │
│  ├── 连接 GitHub、数据库、API                                 │
│  └── 万能遥控器——标准化连接任意工具                           │
│                                                             │
│  🚀 多Agent并行                                              │
│  ├── 同时运行多个任务                                        │
│  ├── Profile 隔离不同场景                                    │
│  └── Cron 定时任务自动化                                     │
│                                                             │
│  📱 一脑多用                                                 │
│  ├── CLI 终端 / Desktop App / Web面板                        │
│  ├── Telegram / Discord / Slack 消息平台                     │
│  └── 22+ 个访问入口，共享同一个大脑                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 1.3 一句话说清

> **Hermes Agent = 开源 AI 智能体框架，有记忆、有技能、能执行任务、跨平台访问、越用越聪明。**

### 1.4 Hermes 不是什么

| 误以为 | 正解 |
|:------|:-----|
| Hermes 是一个大模型 | ❌ Hermes 是框架，可以用不同模型驱动 |
| Hermes 只能命令行 | ❌ 有 Desktop App、Web 面板、Telegram 等多种入口 |
| Hermes 需要云服务器 | ❌ 本地电脑就能跑，云服务器只是更稳定 |
| Hermes = 另一个 ChatGPT | ❌ ChatGPT 是聊天机器人，Hermes 是能执行任务的 Agent |

> ✋ **费曼自测**：用三句话向一个不懂技术的朋友解释 Hermes Agent 是什么。试着用"私人助理"或"管家"的类比。

---

## 🍅 番茄2：支持的模型与部署方式（25分钟）

### 2.1 模型提供商一览

Hermes 框架本身不绑定任何大模型，你可以自由选择：

| Provider | 特点 | 适合场景 |
|:---------|:-----|:---------|
| **OpenRouter** ⭐推荐 | 聚合200+模型，统一计费 | 日常使用，一个Key访问所有模型 |
| **OpenAI** | GPT系列，稳定可靠 | 需要强推理能力时 |
| **Anthropic** | Claude系列，安全性强 | 长文本、复杂分析 |
| **DeepSeek** | 国产开源，价格极低 | 预算有限，性价比优先 |
| **通义千问** | 阿里云，国内直连 | 国内网络友好 |
| **本地模型（Ollama）** | 数据不出本地，完全免费 | 隐私敏感场景 |

> 💡 **关于 DeepSeek**：DeepSeek v4 flash 模型性价比极高，性能达 GPT-4 的 95%，成本仅 1%。OpenRouter 上可以找到 deepseek/deepseek-v4-flash。

### 2.2 三种部署方式对比

| 部署方式 | 成本 | 稳定性 | 隐私性 | 适合人群 |
|:---------|:----|:------|:------|:--------|
| 🖥️ **本地部署** | 免费 | 关电脑就停 | ⭐⭐⭐⭐⭐ | 尝鲜、学习、开发测试 |
| ☁️ **云服务器** | ¥30-50/月 | 24/7 在线 | ⭐⭐⭐ | 生产环境、24h Agent |
| 🏠 **本地服务器** | 电费 | 24/7 在线 | ⭐⭐⭐⭐⭐ | 隐私优先的生产环境 |

**本模块先学本地部署，M4 再学云服务器部署。**

> ✋ **费曼自测**：你当前的使用场景适合哪种部署方式？为什么？

---

## 🍅 番茄3：安装 Hermes CLI 并配置（25分钟）

### 3.1 环境检查

```bash
# 检查 Python 版本（需要 3.8+，推荐 3.11）
python --version

# 检查 pip
pip --version

# 检查 Git
git --version
```

### 3.2 一键安装（推荐）

```bash
# macOS / Linux 一键安装
curl -fsSL https://hermes-agent.sh/install | bash
```

> ⚠️ **国内用户**：如果一键安装遇到 GitHub 拉取超时，使用镜像加速：
> ```bash
> # 方法1：使用 ghproxy 镜像
> export INSTALL_URL="https://ghproxy.com/https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh"
> 
> # 方法2：先配置 Git 镜像（推荐，后续所有 git 操作都加速）
> git config --global url."https://ghproxy.com/https://github.com/".insteadOf "https://github.com/"
> ```

### 3.3 pip 安装（备选）

```bash
# 通过 pip 安装
pip install hermes-agent
```

### 3.4 源码安装（兜底方案）

> 如果一键安装和 pip 都失败，使用源码手动部署：

```bash
# 1. 克隆源码
git clone https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# 2. 安装依赖
pip install -e .
```

### 3.5 验证安装

```bash
# 查看版本
hermes --version

# 查看帮助
hermes --help
```

> ✅ **验证标准**：看到版本号输出即安装成功。

### 3.6 配置 OpenRouter API Key

```bash
# 运行交互式配置向导
hermes setup
```

配置过程会引导你：
1. 选择 Provider → **OpenRouter**（推荐）
2. 输入 API Key → 粘贴你在 OpenRouter 官网创建的 Key
3. 选择模型 → **deepseek/deepseek-v4-flash**（性价比之选）
4. 配置记忆 → 开启策展式写入（推荐）

**获取 OpenRouter API Key：**
1. 访问 https://openrouter.ai
2. 注册 → Settings → API Keys
3. 创建 Key → 充值 $5-10
4. 复制 Key（格式：`sk-or-v1-xxxxxxxx`）

> ⚠️ **安全提示**：
> - API Key 通过 `~/.hermes/.env` 管理，不要在聊天中直接输入 Key
> - 不要将 .env 文件提交到 Git 仓库

> ✋ **费曼自测**：为什么要把 API Key 放在 .env 中，而不是直接写在 config.yaml 或聊天里？

---

## 🍅 番茄4：首次对话测试 + 练习（25分钟）

### 4.1 启动对话

```bash
hermes chat
```

### 4.2 测试对话

```
You: 你好！请用中文介绍一下你自己。

Hermes: 你好！我是 Hermes Agent，一个具有持久记忆和技能学习能力的 AI 助手...

You: 请记住，我使用 Obsidian 进行知识管理，我的知识库叫 ideal。
```

### 4.3 测试记忆能力

退出会话（Ctrl+C），重新启动一个新会话：

```bash
hermes chat
```

```
You: 我的知识库叫什么名字？

Hermes: 根据我的记忆，你的知识库叫 ideal，使用 Obsidian 进行管理。
```

✅ **验证成功**：Hermes 记住了上一个会话的信息！

### 4.4 启动 Web 面板（可选）

```bash
# 启动 Web 管理面板
hermes dashboard
```

浏览器访问 `http://localhost:18789` 即可看到 Web 界面。

### 4.5 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|:-----|:---------|:---------|
| `API Key invalid` | Key格式错误 | 检查.env文件，确保格式正确 |
| `Model not found` | 模型名称错误 | `hermes model` 查看可用模型 |
| `Connection timeout` | 网络问题 | 检查代理设置 |
| `hermes 命令找不到` | 未激活环境 | 执行 `source ~/.bashrc` 或重启终端 |
| 记忆没更新 | 会话中途修改 | 重启会话 |

### 💪 刻意练习——安装与首次对话

**练习目标**：在20分钟内完成 Hermes 安装、配置和首次对话的完整流程 **3次**

```
===== 循环 1：入门任务 =====
1. 运行 `hermes --version` 确认安装成功
2. 运行 `hermes setup` 配置模型
3. 运行 `hermes chat` 发送"你好"
✅ 验证方式：Hermes 正常回复

===== 循环 2：进阶任务 =====
1. 告诉 Hermes 一个关于你的信息
2. 退出会话，重新启动
3. 问 Hermes 是否还记得
✅ 验证方式：Hermes 在新会话中记住了信息

===== 循环 3：挑战任务 =====
1. 启动 Web 面板：`hermes dashboard`
2. 浏览器访问面板
3. 在 Web 面板中测试一次对话
✅ 验证方式：CLI 和 Web 面板都能对话
```

### 📋 自检清单

- [ ] **番茄1**：能用大白话解释 Hermes Agent 是什么
- [ ] **番茄2**：了解支持的模型和部署方式
- [ ] **番茄3**：`hermes --version` 正常显示
- [ ] **番茄4**：`hermes chat` 能正常对话，记忆生效

---

## 🎯 M1 核心命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `hermes --version` | 查看版本 |
| `hermes setup` | 交互式配置向导 |
| `hermes chat` | 启动对话 |
| `hermes dashboard` | 启动 Web 面板 |
| `hermes --help` | 查看全部命令 |
| `hermes model` | 查看/切换模型 |

---

👉 **下一步：** [[M2-核心配置与目录结构]]

> **关联资料：**
> - [[Clippings/Bilibili/2026-06-22-Hermes AI Agent 核心概念详解]] — 21个核心概念视频
> - [[日记/2026-06-20]] — 阿里云部署时的安装记录
