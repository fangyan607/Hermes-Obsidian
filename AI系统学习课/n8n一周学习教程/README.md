# 🚀 n8n 工作流自动化 · 一周学习教程

> ⏱ 总学时：56个番茄钟（约24小时）
> 🎯 学习方式：每日8个番茄钟，边读边操作
> 🧠 教学方法：番茄工作法 × 费曼学习法 × 刻意练习
> 📅 创建日期：2026-06-08
> 📹 参考视频：[B站 n8n 入门到精通系列](https://www.bilibili.com/video/BV1EtVm6iEjn/)

---

## 学习目标

- [ ] ✅ 能独立部署 n8n（Docker / Cloud）
- [ ] ✅ 理解核心节点并熟练使用 8 大关键节点
- [ ] ✅ 掌握凭证配置，能调用任意 REST API
- [ ] ✅ 能设计包含条件分支、循环、错误处理的完整工作流
- [ ] ✅ 能用 Webhook 构建 API 服务
- [ ] ✅ 能搭建 AI Agent 智能工作流
- [ ] ✅ 完成一个综合自动化项目

---

## 一周日程概览

| 天数 | 主题 | 番茄数 | 当日产出 |
|:---:|------|:---:|---------|
| Day 1 | 安装部署与界面初探 | 8 | 运行中的 n8n + 第一个工作流 |
| Day 2 | 核心节点与触发器 | 8 | 5 种触发器 + 8 个核心节点的实操 |
| Day 3 | 凭证管理与 API 集成 | 8 | 3 个 API 凭证 + 天气/新闻/AI 调用工作流 |
| Day 4 | 数据处理与工作流模式 | 8 | 批量处理 + 循环 + 错误处理工作流 |
| Day 5 | Webhook 与外部集成 | 8 | 完整的 Webhook API 服务 |
| Day 6 | AI Agent 工作流 | 8 | AI 智能分类 + MCP 集成工作流 |
| Day 7 | 复习与综合实战 | 8 | Obsidian 智能知识管理系统 |

---

## 每日时间安排

```
上午（🍅1-4）：理论 + 跟着做
  🍅1-2  阅读概念，理解原理
  🍅3-4  跟着教程动手操作

下午（🍅5-8）：实践 + 复习
  🍅5-6  自由实践，改造创新
  🍅7    今日复习，概念梳理
  🍅8    输出成果，费曼检测
```

---

## 教程文件索引

| 文件 | 主题 | 链接 |
|------|------|------|
| 总览 | 课程介绍与学习指南 | [[README]] |
| Day 1 | 安装部署与界面初探 | [[Day1-安装部署与界面初探]] |
| Day 2 | 核心节点与触发器 | [[Day2-核心节点与触发器]] |
| Day 3 | 凭证管理与 API 集成 | [[Day3-凭证管理与API集成]] |
| Day 4 | 数据处理与工作流模式 | [[Day4-数据处理与工作流模式]] |
| Day 5 | Webhook 与外部集成 | [[Day5-Webhook与外部集成]] |
| Day 6 | AI Agent 工作流 | [[Day6-AI-Agent工作流]] |
| Day 7 | 复习与综合实战 | [[Day7-复习与综合实战]] |

---

## 核心方法论

### 🍅 番茄工作法

- 一个番茄 = 25 分钟专注 + 5 分钟休息
- 每 4 个番茄后长休息 15-30 分钟
- 番茄钟不可分割——一个番茄开始了就必须完成
- 中断时记录中断类型（内部/外部），不在番茄内处理

### 🧠 费曼学习法四步

| 步骤 | 操作 | 本教程中的应用 |
|------|------|---------------|
| ① 选择概念 | 明确要学什么 | 每日学习目标 |
| ② 教给别人 | 用简单语言解释 | 写「费曼笔记」—— 假装教一个小白 |
| ③ 找出差距 | 发现解释不清的地方 | 实操卡住的地方 = 知识盲区 |
| ④ 简化提炼 | 用类比重新组织 | 写「一句话总结」+「类比记忆」 |

---

## 前置准备

### 1. 获取 API Key（按需准备）

| API | 用途 | 获取地址 | 免费额度 |
|-----|------|----------|----------|
| **OpenAI** | AI Agent / GPT | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) | $5 新用户赠金 |
| **智谱 GLM** | OCR / AI 对话 | [open.bigmodel.cn](https://open.bigmodel.cn/) | 注册送 token |
| **OpenRouter** | 多模型统一接入 | [openrouter.ai/keys](https://openrouter.ai/keys) | 部分模型免费 |
| **Slack** | 消息通知 | [api.slack.com/apps](https://api.slack.com/apps) | 免费版够用 |
| **Notion** | 数据库集成 | [notion.so/my-integrations](https://www.notion.so/my-integrations) | 免费版够用 |
| **OpenWeather** | 天气数据 | [openweathermap.org/api](https://openweathermap.org/api) | 1000次/天免费 |
| **NewsAPI** | 新闻数据 | [newsapi.org](https://newsapi.org/) | 100次/天免费 |

### 2. 安装 Docker

- Windows: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- Mac: `brew install --cask docker`
- Linux: `curl -fsSL https://get.docker.com | sh`

### 3. 确认环境

```bash
docker --version    # 需要 20.10+
docker-compose --version  # 需要 2.0+
```

### 4. 参考已有工作流

- [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 PDF OCR 工作流
- [[30.areas/n8n-Workflow-Automation-Complete-Guide]] - n8n 技术参考手册

---

## 学习成果追踪

- [ ] Day 1：n8n 运行成功，第一个工作流执行通过
- [ ] Day 2：8 个核心节点全部实操一遍
- [ ] Day 3：至少 3 个 API 凭证配置成功
- [ ] Day 4：完成一个包含循环和错误处理的工作流
- [ ] Day 5：Webhook API 服务构建并测试通过
- [ ] Day 6：AI Agent 工作流运行成功
- [ ] Day 7：综合项目完成

---

## 常见问题速查

| 问题 | 解决方案 |
|------|----------|
| Docker 启动失败 | 检查端口 5678 是否被占用：`netstat -ano \| findstr 5678` |
| 节点连接不上 | 确保节点之间有连线，点击节点右侧圆点拖拽连接 |
| API 调用 401 | 检查凭证格式，API Key 是否正确 |
| Webhook 不响应 | 确认 n8n 正在运行，检查 URL 路径 |
| AI Agent 超时 | 检查 API Key 余额，增加超时时间 |

---

## 🚀 开始学习

→ **从 [[Day1-安装部署与界面初探]] 开始！**

> **相关文件：**
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 n8n 工作流参考
> - [[30.areas/n8n-Workflow-Automation-Complete-Guide]] - n8n 技术参考手册
> - [[Script/n8n一周精通教程-番茄费曼学习法]] - 旧版合并教程（已拆分）
