# 🚀 OpenAI Codex CLI 一周精通教程

> ⏱ 总学时：56个番茄钟（约24小时）
> 🎯 学习方式：每日 8 个番茄钟，边学边练
> 🧠 教学方法：番茄工作法 × 费曼学习法 × 刻意练习
> 📅 创建日期：2026-06-11

---

## 为什么学 Codex？

**OpenAI Codex** 是 2026 年增长最快的 AI 编程平台——**500 万周活用户**，覆盖 CLI、桌面 App、Web 云、IDE 扩展四种入口。

- **Codex CLI** — 开源（Apache 2.0，Rust 实现），终端优先，速度碾压竞品
- **Codex Desktop App** — macOS/Windows 原生桌面应用，多 Agent 并行 + 可视化审查 + Computer Use
- **Codex Cloud** — ChatGPT 网页端后台异步任务
- **Codex IDE 扩展** — VS Code / Cursor / Windsurf 嵌入使用

但真正的价值在于：它**不是你已有工具的替代品，而是一种全新的工作范式**。特别是 **Codex App** 的 Worktrees 和 Review UI，重新定义了"人与 AI 协作编码"的交互方式。

> 🎯 **学完这一周，你将拥有"AI 编程三件套"的判断力**——什么任务用 Cursor，什么任务用 Claude Code，什么任务用 Codex CLI/App，信手拈来。

---

## 学习目标

**一周后你能：**
1. ✅ 安装配置 **Codex CLI + Codex Desktop App**，理解四种入口差异
2. ✅ 用 AGENTS.md 掌控项目级 AI 行为
3. ✅ 独立判断 **Codex vs Claude vs Cursor** 的适用场景
4. ✅ 用 Codex CLI 完成一个完整 CLI 工具开发
5. ✅ 用 Codex App 的 **Worktrees / Review UI / Computer Use / Automations** 管理多 Agent 并行
6. ✅ 用 Codex 完成大型代码库分析与重构
7. ✅ 建立自己的 AI 编程工具决策框架

---

## 一周日程概览

| 日期 | 主题 | 番茄钟 | 核心产出 |
|:-----|:-----|:-------|:---------|
| **Day 1** | 入门与基础 | 8个 | 安装 CLI + App，完成首次对话 |
| **Day 2** | 核心功能深入 | 8个 | CLI 精通 + AGENTS.md + Sandbox |
| **Day 3** | Codex vs Claude vs Cursor | 8个 | 输出工具对比决策表 |
| **Day 4** | 实战项目一：CLI 工具开发 | 8个 | 用 Codex 构建一个完整工具 |
| **Day 5** | 高级特性与工作流 | 8个 | **App 深度使用** + SDK + CI/CD |
| **Day 6** | 实战项目二：代码库重构 | 8个 | 大型代码库分析 + 重构 |
| **Day 7** | 精通与生态 | 8个 | Skills 开发 + App 插件 + 综合复习 |

### 🆕 补充资料

| 文件 | 内容 |
|:-----|:------|
| **[[Codex App 完整指南]]** | App 从安装配置到高级运用的全流程指南（独立参考文档） |

---

## 每日时间安排

```
每个番茄钟 = 25分钟专注 + 5分钟休息

上午（番茄1-4）：理论理解 + 建立心智模型
中午（番茄5-6）：实践操作 + 动手练习
下午（番茄7-8）：复习巩固 + 输出成果
```

---

## 教程文件索引

| 文件 | 内容 |
|:-----|:-----|
| [[Day1-入门与基础]] | 安装 CLI + App、配置、首次对话、三种模式初探 |
| [[Day2-核心功能深入]] | AGENTS.md、Sandbox、CLI 命令精通 |
| [[Day3-对比与选型]] | Codex vs Claude Code vs Cursor 深度对比 |
| [[Day4-实战项目1\|Day4-实战项目一CLI工具开发]] | 用 Codex 开发一个 Markdown 批处理工具 |
| [[Day5-高级特性与工作流]] | SDK、多Agent、**App Worktrees/Review UI**、CI/CD 集成 |
| [[Day6-实战项目2\|Day6-实战项目二代码库重构]] | 代码库分析 + 自动重构 + 代码审查 |
| [[Day7-精通与生态]] | 自定义 Skills、**App 插件/Computer Use/Automations**、社区生态 |
| [[Codex App 完整指南]] | **App 独立完整教程**（安装→配置→功能→项目实战） |

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
| 复述型 | 检测基本理解 | "用三句话向朋友解释 Codex CLI" |
| 对比型 | 检测概念辨析 | "Suggest 模式和 Auto Edit 模式的区别" |
| 应用型 | 检测迁移能力 | "举一个适合用 Full Auto 模式的场景" |
| 编程型 | 检测实践能力 | "独立用 Codex 完成一个小功能" |

### 刻意练习（能力提升）

```
明确目标 → 专注练习 → 即时反馈 → 纠正迭代
```

**每日刻意练习任务：**
- 明确的目标（"完成 AGENTS.md 配置"）
- 专注练习（排除干扰，单点突破）
- 即时反馈（检查 Codex 行为是否符合预期）
- 纠正迭代（不满足则修改配置再试）

---

## 前置准备

### 需要准备的资源

1. **环境要求**
   - Node.js 18+（推荐 22+）
   - macOS 或 Linux（Windows 用户需 WSL2）
   - Git

2. **账号**
   - ChatGPT 账号（Plus/Pro 推荐）
   - 或 OpenAI API Key

3. **可选**
   - GitHub 账号（Day 5-7 需要）
   - 一个已有的项目仓库（Day 6 需要）

4. **对比体验（Day 3 需要）**
   - Claude Code（可选安装）
   - Cursor IDE（可选安装）

---

## 学习成果追踪

### 每日自检清单

```markdown
- [ ] Day 1：能运行 `codex` 并完成一次对话
- [ ] Day 2：能解释三种模式的适用场景
- [ ] Day 3：能根据任务类型选择工具
- [ ] Day 4：用 Codex 完成了一个完整项目
- [ ] Day 5：能编写 Codex SDK 脚本
- [ ] Day 6：完成了代码库分析报告
- [ ] Day 7：创建了一个自定义 Skill
```

---

## 常见问题速查

| 问题 | 解决方案 |
|:-----|:---------|
| `codex` 命令找不到 | 确认 `npm install -g @openai/codex` 成功 |
| 认证失败 | 运行 `codex` 选择 "Sign in with ChatGPT" |
| Windows 下无法运行 | 使用 WSL2（官方推荐） |
| Sandbox 阻止操作 | 在沙箱外安装依赖，或在 Suggest 模式下审批 |
| 模型响应慢 | 尝试 `/model o4-mini` 切换更快的模型 |

---

## 开始学习

👉 从 [[Day1-入门与基础]] 开始你的 Codex 精通之旅！

---

> **下一步推荐学习：** 完成本教程后，可以深入学习 Codex Agents SDK、MCP 服务集成、以及自定义 Skills 开发。
