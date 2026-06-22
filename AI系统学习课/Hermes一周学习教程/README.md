# 🚀 Hermes Agent 一周学习教程

> ⏱ 总学时：68个番茄钟（约29小时）
> 🎯 学习方式：每日8-10个番茄钟，边读边操作
> 🧠 教学方法：番茄工作法 × 费曼学习法
> 📅 创建日期：2026-06-06 | 更新日期：2026-06-11

---

## 学习目标

**一周后你能：**
1. ✅ 独立安装和配置 Hermes Agent（CLI + Desktop）
2. ✅ 配置记忆系统（MEMORY.md/USER.md/SOUL.yaml）
3. ✅ 安装、使用和创建 Skill 技能
4. ✅ 使用 Kanban 看板管理任务流程
5. ✅ 通过 Desktop App 可视化操作 Hermes
6. ✅ 运行多Agent并行任务
7. ✅ 将 Hermes 融入你的三层记忆系统

---

## 一周日程概览

| 日期 | 主题 | 番茄钟 | 核心产出 |
|:-----|:-----|:-------|:---------|
| **Day 1** | 安装与模型配置 | 10个 | 完成 CLI + Desktop App 安装 |
| **Day 2** | 目录结构与配置文件 | 8个 | 完成config.yaml配置 |
| **Day 3** | 记忆系统（MEMORY.md/USER.md） | 8个 | AI记住你的偏好 |
| **Day 4** | SOUL.yaml人格配置 | 8个 | 创建专属AI人格 |
| **Day 5** | Skill安装与Kanban工作流 | 10个 | 安装技能 + 搭建看板 |
| **Day 6** | Skill自动生成 | 8个 | 触发Skill自动生成 |
| **Day 7** | 复习与综合实战 | 10个 | 完成知识自动化 + 新特性整合 |

---

## 每日时间安排

```
日常模式：每个番茄钟 = 25分钟专注 + 5分钟休息
扩展模式（Day 1/5/7）：10个番茄钟 = 约4.5小时

上午（番茄1-4）：理论理解 + 建立心智模型
下午（番茄5-8）：实践操作 + 动手练习
晚上（番茄9-10）：复习巩固 + 输出成果（仅扩展日）
```

---

## 教程文件索引

| 文件 | 内容 |
|:-----|:-----|
| [[Day1-安装与模型配置]] | 安装 CLI + Desktop、模型选择、API配置 |
| [[Day2-目录结构与配置文件]] | ~/.hermes/目录、config.yaml、.env |
| [[Day3-记忆系统]] | MEMORY.md、USER.md、策展式写入 |
| [[Day4-人格配置]] | SOUL.yaml、人格模板、效果测试 |
| [[Day5-Skill安装与使用]] | Skill安装、触发、Kanban工作流 |
| [[Day6-Skill自动生成]] | 自动生成原理、实践触发 |
| [[Day7-复习与综合实战]] | 知识整合、Kanban/Desktop生态、自动化流水线 |

---

## 核心方法论

### 番茄工作法（时间结构）

```
🍅 25分钟专注 → 5分钟休息 → 重复
每4个番茄钟后 → 15-30分钟长休息
```

### 费曼学习法（质量保障）

每个核心概念后嵌入「费曼自测」：

| 类型 | 用途 | 示例 |
|:-----|:-----|:-----|
| 复述型 | 检测基本理解 | "用三句话解释X是什么" |
| 对比型 | 检测概念辨析 | "X和Y的区别是什么？" |
| 应用型 | 检测迁移能力 | "举一个会用X的真实例子" |
| 编程型 | 检测实践能力 | "不看书，写一个X的基本用法" |

---

## 前置准备

### 需要准备的资源

1. **API Key**
   - OpenRouter API Key（推荐，支持多模型）
   - 或 OpenAI API Key
   - 或 Anthropic API Key

2. **开发环境**
   - Python 3.8+
   - Node.js 18+（Desktop App 需要）
   - Git

3. **操作系统（Desktop App）**
   - macOS 12+（Intel 或 Apple Silicon）
   - Windows 10/11 64-bit
   - Linux（Ubuntu 20.04+/Fedora 38+）

4. **知识库关联**
   - [[Claude_Memory/Hermes Agent学习计划]] - 原始学习计划
   - [[MEMORY.md]] - 你的三层记忆系统

---

## 学习成果追踪

### 每日自检清单

```markdown
- [ ] Day 1：能运行 `hermes chat` 并打开 Hermes Desktop App
- [ ] Day 2：能解释每个配置文件的作用
- [ ] Day 3：AI能记住你的用户偏好
- [ ] Day 4：创建的AI人格符合预期
- [ ] Day 5：能手动触发Skill执行 + 创建 Kanban 看板
- [ ] Day 6：能触发Skill自动生成
- [ ] Day 7：完成知识自动化流水线，了解 Kanban/Desktop 生态
```

---

## 常见问题速查

| 问题 | 解决方案 |
|:-----|:---------|
| API Key无效 | 检查.env文件格式，确保无多余空格 |
| 记忆不生效 | 会话中途修改需重启 |
| Skill不触发 | 调整触发词，确保描述匹配 |
| 记忆膨胀 | 开启策展式写入 |
| 多Agent冲突 | 使用Profiles隔离 |
| Desktop App无法启动 | 检查 Node.js 版本 ≥ 18 |
| Kanban 看板不显示 | 运行 `hermes kanban init` 初始化 |
| 看板任务卡住 | 使用 `hermes kanban reclaim` 回收超时任务 |
| Web Dashboard 无法访问 | 检查 Gateway 配置和端口占用 |

---

## 开始学习

👉 从 [[Day1-安装与模型配置]] 开始你的学习之旅！

---

> **下一步推荐学习：** 完成本教程后，学习 MCP外部连接和Cron定时任务进阶内容。关注 [Hermes GitHub](https://github.com/NousResearch/hermes-agent) 获取最新版本更新和社区插件。
