# 🔧 n8n 一周实例训练 · 从零搭建 22 个工作流

> ⏱ 总学时：56个番茄钟（约24小时）
> 🎯 学习方式：每日8个番茄钟，每天搭建2-3个完整工作流
> 🧠 教学方法：番茄工作法 × 费曼学习法 × 刻意练习
> 📅 创建日期：2026-06-08
> 📹 参考视频：[B站 n8n 实战系列](https://www.bilibili.com/video/BV15zCEBDEfT/)
> 📖 前置课程：[[README|n8n 一周学习教程（理论篇）]]

---

## 训练目标

- [ ] ✅ 完成 22 个真实工作流的搭建与调试
- [ ] ✅ 每个实例都能独立运行，输出正确结果
- [ ] ✅ 掌握从「需求分析→节点选择→配置→调试」的完整流程
- [ ] ✅ 能举一反三，改造实例为自己的自动化项目

---

## 一周实例概览

| 天数 | 主题 | 实例数 | 实例列表 |
|:---:|------|:---:|---------|
| Day 1 | 基础自动化 | 3 | 每日天气播报 · RSS新闻聚合 · 定时数据备份 |
| Day 2 | 数据处理管道 | 3 | 用户数据清洗 · CSV格式转换 · 批量文件处理 |
| Day 3 | API集成实战 | 3 | OpenAI智能助手 · GLM-OCR文档转换 · GitHub仓库监控 |
| Day 4 | 通知与通信 | 3 | 多渠道通知中心 · 邮件自动分类 · 钉钉机器人 |
| Day 5 | AI智能工作流 | 3 | AI内容生成管道 · AI智能客服 · AI文档问答 |
| Day 6 | 企业级模式 | 2 | 多级审批流 · 跨系统数据同步 |
| Day 7 | Obsidian深度集成 | 3 | 剪藏自动化 · 笔记自动整理 · 知识库API服务 |

---

## 每个实例的标准结构

```
📋 实例名称
├── 🎯 场景与目标 —— 为什么要做这个？
├── 🏗️ 工作流架构图 —— 整体长什么样？
├── 🔑 API/凭证准备 —— 需要什么钥匙？
├── 🔧 逐节点配置 —— 每个节点怎么配？
├── 🧪 测试验证 —— 怎么确认跑通了？
├── 💡 变体与扩展 —— 还能怎么改？
└── ✋ 费曼检测 —— 你真的会了吗？
```

---

## 教程文件索引

| 文件 | 主题 | 链接 |
|------|------|------|
| 总览 | 实例训练介绍 | [[实例训练-README]] |
| Day 1 | 基础自动化（3个实例） | [[实例Day1-基础自动化]] |
| Day 2 | 数据处理管道（3个实例） | [[实例Day2-数据处理管道]] |
| Day 3 | API集成实战（3个实例） | [[实例Day3-API集成实战]] |
| Day 4 | 通知与通信（3个实例） | [[实例Day4-通知与通信]] |
| Day 5 | AI智能工作流（3个实例） | [[实例Day5-AI智能工作流]] |
| Day 6 | 企业级模式（2个实例） | [[实例Day6-企业级模式]] |
| Day 7 | Obsidian深度集成（3个实例） | [[实例Day7-Obsidian深度集成]] |

---

## 前置准备

### API Key 准备清单

| API | 获取地址 | 用到的实例 | 免费额度 |
|-----|----------|-----------|----------|
| **OpenAI** | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) | Day3/5/7 | $5赠金 |
| **智谱 GLM** | [open.bigmodel.cn](https://open.bigmodel.cn/) | Day3/5 | 注册送token |
| **OpenRouter** | [openrouter.ai/keys](https://openrouter.ai/keys) | Day5(备选) | 部分免费 |
| **OpenWeather** | [openweathermap.org/api](https://openweathermap.org/api) | Day1 | 1000次/天 |
| **NewsAPI** | [newsapi.org](https://newsapi.org/) | Day1 | 100次/天 |
| **GitHub** | [github.com/settings/tokens](https://github.com/settings/tokens) | Day3/6 | 5000次/小时 |
| **Slack** | [api.slack.com/apps](https://api.slack.com/apps) | Day4 | 免费 |
| **钉钉机器人** | 群设置→机器人→自定义 | Day4/5 | 免费 |

### 前置课程

确保你已完成 [[README|n8n 一周学习教程（理论篇）]] 的 Day 1-2，或具备以下能力：
- [ ] n8n 已部署并能访问
- [ ] 会添加、连接、配置节点
- [ ] 理解表达式 `{{ $json.field }}` 的基本用法

---

## 学习成果追踪

- [ ] Day 1：3个基础自动化工作流运行成功
- [ ] Day 2：3个数据处理管道运行成功
- [ ] Day 3：3个API集成工作流运行成功
- [ ] Day 4：3个通知通信工作流运行成功
- [ ] Day 5：3个AI工作流运行成功
- [ ] Day 6：2个企业级工作流运行成功
- [ ] Day 7：3个Obsidian集成工作流运行成功

---

## 🚀 开始训练

→ **从 [[实例Day1-基础自动化]] 开始！**

> **相关文件：**
> - [[README]] - 理论教程总览
> - [[Day1-安装部署与界面初探]] - 理论 Day 1
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有工作流参考
> - [[30.areas/n8n-Workflow-Automation-Complete-Guide]] - 技术参考手册
