---
created: 2026-06-16
tags: ["#Hermes", "#AI-Agent", "#番茄教程"]
aliases: [2番茄通关Hermes]
cssclass: "learning-day"
total_pomodoros: 2
current_pomodoros: "0/2"
---

# 🍅 2番茄通关Hermes Agent：从零搭建你的24/7 AI智能体大军

> **悬疑开场：** 如果你的AI能在你睡觉的时候——自己学会新技能、自己整理记忆、自己跟其他AI协作——第二天早上你醒来时，它已经变强了。这不是未来。这是Hermes Agent已经在做的事。

**目标读者：** 你已经用过Claude Code或Codex，想拥有一个**24/7在线、能自我进化、能协作**的AI Agent。

**前置要求：** 会SSH连服务器，知道API Key是什么

**总时长：** 2个番茄钟（50分钟阅读+动手）

**参考来源：**
- David Ondrej《Hermes Agent 7 Levels》（45分钟实战教程）
- [[LLM-Wiki/Hermes看板功能完整指南]]
- [[hermes-skills-完整清单]]
- NousResearch官方文档 & 社区橙皮书

---

## 🍅 1：部署与基建——给你自己一个24/7的AI员工

> 目标：一台VPS → 一个能聊天的Hermes → 接入Discord → 让它自己管好自己的技能

### 1.1 买一台VPS（5分钟）

Hermes需要一台**永远开机**的电脑。推荐配置：

| 配置项 | 最低要求 | 推荐 |
|:-------|:---------|:-----|
| CPU | 1核 | 2核 |
| 内存 | 2GB | 4GB |
| 硬盘 | 20GB | 40GB SSD |
| 系统 | Ubuntu 22.04 | Ubuntu 24.04 |

**为什么不用本地电脑？** Hermes要24小时在线，关笔记本它就不动了。VPS是你的AI的"专属公寓"。

### 1.2 一键安装Hermes（5分钟）

SSH连上VPS后，运行官方一键安装：

```bash
# 从GitHub复制最新的快速安装命令
# 当前(v0.14+) 推荐：
curl -fsSL https://hermes-agent.sh/install | bash
```

安装脚本会：
- 安装Python依赖
- 下载Hermes核心
- 创建配置文件目录 `~/.hermes/`

安装完成后运行快速设置：

```bash
hermes quickstart
```

系统会问：
1. **推理提供商（LLM Provider）**：选 `openrouter`（最灵活，可换任何模型）
2. **API Key**：去 [OpenRouter](https://openrouter.ai/keys) 创建，充$10起步
3. **默认模型**：选 `openai/gpt-4o` 或 `anthropic/claude-sonnet-4`（别用小模型，会变笨）

> **⚠️ 铁律：别省模型钱。** Hermes的复杂度要求强模型。用便宜小模型 = 买了一台法拉利却加地沟油。

### 1.3 验证安装（3分钟）

```bash
hermes chat
# 输入：你好，检查一下是否正常运行
# 预期：Hermes回复，并列出当前可用的内置技能
```

如果看到回复——恭喜，你的个人AI已经在VPS上跑起来了。

### 1.4 接入Discord/Telegram（10分钟）

Hermes最强的设计之一：**你可以用日常聊天工具跟它对话**，不用SSH。

```bash
hermes gateway setup
```

选 `discord`，然后：

1. 打开 [Discord Developer Portal](https://discord.com/developers/applications)
2. 创建新应用 → 取名 → 创建Bot → 复制Token
3. 在终端粘贴Token
4. 打开 **Privileged Gateway Intents**（三个全开）
5. 设置Bot权限：发送消息、阅读历史、嵌入链接
6. 在OAuth2 URL生成器选 `bot` + `applications.commands`
7. 用生成的URL把Bot邀请到你的私人服务器

```bash
# 终端输入你的Discord用户ID
# 主频道可以留空
# 安装为系统服务：选 Yes
```

验证：在Discord频道发 `@Hermes hi`，看到 👀 表情 → 收到回复 → **完成。**

> **💡 为什么接Discord？** 因为你的手机上有Discord。等于你口袋里有了一个AI员工——随时问、随时安排任务。

### 1.5 Curator——让Hermes自己打扫房间（5分钟）

Hermes有一个"自我改进循环"——它会从对话中学习并创建新技能。但技能多了会膨胀。

**Curator = 技能管家**：自动标记和清理长期不用的技能。

```bash
# 确认已启用
hermes curator status

# 默认规则（已是最优）：
# - 30天未用 → 标记过期
# - 90天未用 → 自动删除
```

**为什么重要？** 上下文腐烂（Context Rot）是AI Agent最大的隐形杀手——无用技能占据上下文窗口，让模型变"笨"。Curator自动解决这个问题。

> **💡 经验之谈：** David Ondrej说他因为没开Curator，几千美元白白浪费在无用的技能token上。开它就是省钱。

### 1.6 更新到最新版本

```bash
hermes update
```

Hermes团队更新极快（几乎隔天发布），养成定期更新的习惯。

---

> ### ✅ 费曼三句话（番茄1）
> 1. Hermes Agent = 一个运行在VPS上、通过聊天工具跟你对话、能自己学新技能的AI员工——它不需要你盯着它干活。
> 2. 安装的核心链路是：VPS → 一键安装 → 配LLM API → 接聊天工具。最难的部分只是"第一次配API Key"。
> 3. 如果你没用Curator管理技能，你的Hermes会像堆满旧衣服的房间——越来越笨，越来越贵。

> ### ❓ 悬疑追问
> 一个能聊天的AI没什么稀奇的。但如果它能**自己安排任务、同时管理多个子AI、记住你几个月前的对话**——它还是"聊天机器人"吗？

> ### 📌 连线笔记
> 你在用的Claude Code/Codex是"对话式Agent"——你问一句它答一句。Hermes是"后台式Agent"——你给它一个目标，它自己规划、执行、汇报。想一下，你日常哪些重复任务可以交给它？

---

## 🍅 2：进阶威力——从自动备份到多Agent军团

> 目标：定时任务 → 看板管理多Agent → 永久记忆 → 让Hermes成为其他Agent的MCP后端

### 2.1 定时任务——让Hermes自动干活（8分钟）

Cron任务让Hermes按计划自动执行工作。最实用的例子：**每天自动备份到GitHub。**

**Step 1：创建GitHub私有仓库**
```bash
# 在GitHub上创建一个私有仓库，比如 hermes-backup
# 设置 → 开发者设置 → 个人访问令牌 → Fine-grained tokens
# 权限：Contents (read+write)
```

**Step 2：设置环境变量**
```bash
hermes config set GITHUB_TOKEN "你的_personal_access_token"
```

**Step 3：一句话让Hermes自己搞定**

在Discord/终端对Hermes说：

> "对整个 ~/.hermes 文件夹进行每日凌晨3点的备份，备份到我的私有仓库 hermes-backup。Token 在环境变量 GITHUB_TOKEN 里。先跑一次测试。"

Hermes会：
1. ✅ 配置Git身份
2. ✅ Clone目标仓库
3. ✅ 创建Cron任务（每天凌晨3点）
4. ✅ 立刻跑一次验证

```bash
# 查看已创建的定时任务
hermes cron list
```

**定时任务的想象力：**
- 每天早上8点 → 抓取Hacker News + 生成AI新闻摘要 → 发到Discord
- 每周一 → 检查服务器磁盘空间 + 清理日志
- 每月1号 → 分析API消费账单 + 给出优化建议

### 2.2 看板——指挥你的AI军团（10分钟）

这可能是Hermes最被低估的功能。**看板（Kanban）让你同时管理多个AI Worker。** 每个Worker可以有不同的模型、不同的人格、不同的任务。

**一句话安装：**

告诉Hermes：
> "我要设置最新的看板多Agent功能。这是发布链接：[GitHub Release URL]。帮我在VPS上配好。"

Hermes会自己：
1. 📥 读取Release Notes
2. 🔧 配置Worker配置文件
3. 🚀 启动看板服务（本地localhost）
4. 🔗 给你SSH隧道命令

```bash
# SSH隧道（在本地电脑运行）
ssh -L 3000:localhost:3000 root@你的VPS_IP
```

打开浏览器访问 `http://localhost:3000` → 你会看到一个看板界面。

**看板四角色（默认）**

| 角色 | 职责 | 模型建议 |
|:-----|:------|:---------|
| 🔬 **研究员** | 搜索、阅读、分析 | Claude Sonnet |
| ✍️ **写手** | 起草、改写、编辑 | GPT-4o |
| ✅ **审校** | 质量检查、事实核查 | Claude Opus |
| 🎨 **设计师** | 视觉创意 | GPT-4o Vision |

**实战：内容调研看板**

> "在默认面板上创建一个4任务看板流程：
> 任务1：研究员 → 搜索 '2026年AI Agent趋势'
> 任务2：写手 → 基于调研草拟3个视频选题
> 任务3：审校 → 检查事实准确性
> 任务4：设计师 → 为每个选题生成封面图概念"

看板上你会看到任务从"待办 → 进行中 → 阻塞 → 完成"自动流转。不需要你手动分配——Worker自己认领任务。

> **💡 关键区别：** 没有看板，Hermes也能多任务。但有了看板，你作为人类能看到"四个AI同时在干嘛"——这是从"单线程"到"指挥家"的跃迁。

### 2.3 全息记忆——让Hermes永不忘记（8分钟）

默认情况下，Hermes有短期记忆（当前会话），但会话结束后会丢失。**Holographic Memory** 是一种本地、结构化、图式的长期记忆系统。

```bash
hermes memory setup
```

选 `holographic`（本地、免费、不泄露数据）。

**配置要点：**
- **会话结束时提取事实** → 启用
- **新事实默认信任分数** → 0.4（默认即可）
- **存储路径** → 默认 `~/.hermes/memory/`

配置好后重启网关：
```bash
hermes gateway restart
```

**验证记忆生效：**
> "检查一下Holographic记忆是否在运行。读取我之前的会话记录，把关于我的重要信息存入记忆。"

Hermes会从历史会话中提取结构化事实并存入图数据库。

**实用的记忆用例：**
- 📹 追踪YouTube视频项目：赞助商、截止日期、内容方向
- 💰 记录API消费趋势：每月花了多少钱、哪个模型最贵
- 🖥️ 记住VPS配置：磁盘空间、内存使用、健康状态
- 🔗 自动发现矛盾："你之前说每5天发一个视频，但另一条记录说每3天——哪条是对的？"

> **💡 为什么不用RAG？** 向量相似性搜索回答不了"我分配了什么任务"这种结构化问题。Holographic用图结构存储事实，比RAG更适合Agent的记忆场景。

### 2.4 MCP服务器——让Hermes成为你的Agent后端（10分钟）

**这是Hermes七层的最高层。** 把Hermes暴露为一个MCP（Model Context Protocol）服务器，让其他Agent（Claude Code、Codex、OpenCode）通过MCP协议与Hermes交互。

**为什么需要这个？**

| 场景 | 没有MCP | 有MCP |
|:-----|:--------|:------|
| Claude Code要删除数据库 | 直接执行（危险） | 通过Hermes发审批到手机 |
| 长时间重构 | 你得守着电脑 | 合上笔记本，手机上收进度 |
| 跨Agent通信 | 各自为政 | Hermes统一调度和审批 |

**一句话配置：**

> "通过MCP把你的Hermes暴露给Claude Code。这样Claude Code能通过Hermes读取Discord消息、发送消息、获取任务状态。要求：MCP服务器暴露工具包括get_channels、read_messages、send_message。"

Hermes会自动：
1. 🔧 配置MCP工具端点
2. 🔌 在VPS上启动MCP服务器
3. ✅ 测试工具是否可用

**验证：**
```bash
# 在VPS上装Claude Code
# 配置MCP指向Hermes
# 测试：让Claude Code通过Hermes读取你的Discord消息
claude -p "通过Hermes MCP读取我最近的Discord消息，总结一下"
```

**三层核心应用：**

1. **远程审批门**：Claude Code要执行危险操作（删除、清库）→ 卡住 → 通过Hermes推送到你的手机 → 你点"允许/拒绝"
2. **放手模式**：启动Claude Code重构 → 合上笔记本 → 手机收到进度通知 → 回复"继续"或"改方向"
3. **跨Agent枢纽**：Discord收到Bug报告 → Hermes自动创建任务 → Claude Code拉取任务 → 修完推PR → Hermes通知你

---

> ### ✅ 费曼三句话（番茄2）
> 1. Hermes的强大不在于"能聊天"，而在于四个核心能力：**定时任务（自动化）、看板（多Agent编排）、全息记忆（永久上下文）、MCP（跨Agent枢纽）**——这四件套构成一个完整的AI后台系统。
> 2. 看板和MCP是"乘法效应"——看板让你同时指挥多个AI，MCP让不同AI框架互相调用。单独任何一件都强，合起来是质变。
> 3. 大多数人只用Hermes的第一层（聊天），但真正产生价值的在第四层以上（自动化+编排+记忆+互操作）。差距不在技术，在"想到了什么可以交给它"。

> ### ❓ 悬疑追问
> 当你的AI能自己创建定时任务、指挥其他AI干活、记住几个月前的对话、还能让Claude Code和Codex通过它交流——你还是"用户"吗？你更像是**一个AI公司的CEO**。

> ### 📌 连线笔记
> 回到第一层那个问题——你日常哪些重复任务可以交给Hermes？现在有了看板+记忆+MCP，答案变了。不是"一个任务"，而是"一整套工作流"。画出你目前最耗时的工作流程，圈出可以AI化的环节。

---

## 🔥 阵营试炼——你的第一个Hermes实战

### 试炼一（模仿）：搭建并接入Discord

跟着🍅 1的步骤走一遍：
1. 买VPS（Hostinger或任意服务商）
2. 一键安装Hermes
3. 配OpenRouter API Key
4. 接Discord
5. 验证能聊天

**成功标准：** 你在Discord发消息，Hermes回复了。

### 试炼二（变式）：创建你的第一个定时任务

不要备份GitHub——做一个对你有实际用途的定时任务。比如：
- 每天早上抓取你的行业新闻摘要
- 每周分析你的AI API费用
- 每小时检查你的服务器健康状态

**提示：** 用自然语言告诉Hermes你想做什么——它自己会配置Cron。

### 试炼三（创造）：设计你的多Agent看板流程

设计一个至少3个Worker协作的看板流程。例如：
- **内容创作者流程**：研究员（找选题）→ 写手（出草稿）→ 审校（核事实）
- **代码开发流程**：架构师（定方案）→ 开发者（写代码）→ QA（跑测试）
- **个人助理流程**：收集者（整理信息）→ 分析师（提炼要点）→ 汇报者（生成报告）

在Discord用自然语言告诉Hermes你的流程设计，让它帮你建看板。

---

## 🗺️ Hermes七层全景图

```
第七层 ─── MCP服务器（跨Agent枢纽）
     ┌─ 远程审批门
     ├─ 放手模式
     └─ 跨Agent通信
第六层 ─── 全息记忆（永久上下文）
     ┌─ 图结构事实存储
     ├─ 跨会话记忆
     └─ 矛盾自动检测
第五层 ─── 看板系统（多Agent编排）
     ┌─ 多Worker并行
     ├─ 任务认领与交接
     └─ 可视化进度
第四层 ─── 定时任务（自动化）
     ┌─ Cron调度
     ├─ 自动执行
     └─ 条件触发
第三层 ─── Curator（技能管理）
     ┌─ 自动标记过期技能
     ├─ 上下文保护
     └─ Token成本优化
第二层 ─── 消息网关（聊天集成）
     ┌─ Discord/Telegram/Slack
     ├─ 手机端控制
     └─ 多平台接入
第一层 ─── VPS + 核心安装（地基）
     ┌─ 专用服务器
     ├─ 一键安装
     └─ LLM API配置
```

**每一层都在前一层的基础上叠加威力。** 第一层只能聊天。第五层可以指挥一个AI团队。第七层是整个AI生态的枢纽。

---

## 📚 推荐资源

| 资源 | 说明 | 链接 |
|:-----|:------|:------|
| 官方GitHub | NousResearch/hermes-agent | [GitHub](https://github.com/NousResearch/hermes-agent) |
| 官方文档 | 安装/配置/CLI/网关 | [hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com/docs/) |
| 橙皮书（中文） | 从入门到精通的社区指南 | [GitHub: alchaincyf/hermes-agent-orange-book](https://github.com/alchaincyf/hermes-agent-orange-book) |
| 精华技能清单 | 116个内置技能说明 | [[hermes-skills-完整清单]] |
| 看板完整指南 | Hermes多Agent看板配置 | [[LLM-Wiki/Hermes看板功能完整指南]] |
| 优化指南（英文） | 24篇深度优化教程 | [GitHub: OnlyTerp/hermes-optimization-guide](https://github.com/OnlyTerp/hermes-optimization-guide) |
| Awesome列表 | 工具/技能/集成大全 | [GitHub: 0xNyk/awesome-hermes-agent](https://github.com/0xNyk/awesome-hermes-agent) |

---

> **下一站：** 学完Hermes，你才真正理解了"Agent"这个词的重量。它不是ChatGPT的加强版——它是一种**新的计算范式**：把目标交给AI，让AI自己规划、执行、进化。
>
> 如果你想更深入，推荐看 [[LLM-Wiki/Hermes看板功能完整指南]] 和尝试把Hermes接入你的 [[LLM-Wiki/Projects/基于Hermes Agent的多人格专属资料库AI问答应用部署计划书|项目管理流程]]。

Sources:
- [Hermes Agent Official Docs](https://hermes-agent.nousresearch.com/docs/)
- [Hermes Agent GitHub](https://github.com/NousResearch/hermes-agent)
- [Orange Book (Chinese Guide)](https://github.com/alchaincyf/hermes-agent-orange-book)
- [Awesome Hermes Agent](https://github.com/0xNyk/awesome-hermes-agent)
- [Optimization Guide](https://github.com/OnlyTerp/hermes-optimization-guide)
- [Community Docs](https://github.com/mudrii/hermes-agent-docs)
