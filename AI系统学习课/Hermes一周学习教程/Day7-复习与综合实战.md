# Day 7：复习与综合实战

> ⏱ 预计学习时间：10个番茄钟（约4.5小时）
> 🎯 学习目标：Week 1 知识整合，掌握 Kanban/Desktop 新特性，完成知识自动化流水线
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：Week 1 知识回顾（含新特性）
🍅 番茄3-4：Hermes 新特性生态（Kanban + Desktop App）
🍅 番茄5-6：三层记忆系统整合 + 知识自动化实战
🍅 番茄7-8：综合复习考试 + 能力评估
🍅 番茄9-10：后续学习规划 + Week 1 总结
```

---

## 番茄钟1：Week 1 知识回顾（25分钟）

### 1.1 本周学习内容一览

| 日期 | 主题 | 核心收获 |
|:-----|:-----|:---------|
| **Day 1** | 安装与模型配置 | 完成 Hermes CLI + Desktop App 安装 |
| **Day 2** | 目录结构与配置文件 | 掌握 config.yaml、.env 配置 |
| **Day 3** | 记忆系统 | 配置 MEMORY.md、USER.md |
| **Day 4** | 人格配置 | 创建 SOUL.yaml，多人格切换 |
| **Day 5** | Skill 安装与 Kanban 工作流 | 安装技能，看板编排任务 |
| **Day 6** | Skill 自动生成 | 触发自动生成，创建自定义技能 |

### 1.2 核心概念速查表

| 概念 | 文件/目录 | 作用 |
|:-----|:----------|:-----|
| 主配置 | config.yaml | 控制 Hermes 整体行为 |
| 密钥管理 | .env | 存放 API Key 等敏感信息 |
| 长期记忆 | MEMORY.md | 跨会话持久记忆 |
| 用户画像 | USER.md | 用户偏好、禁忌 |
| AI人格 | SOUL.yaml | AI性格、行为规则 |
| 技能库 | skills/ | 存放所有技能 |
| 看板系统 | kanban/ | SQLite 任务看板数据库 |
| 桌面版 | Hermes Desktop | Electron 图形界面 |

### 1.3 常用命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `hermes setup` | 交互式配置 |
| `hermes chat` | 启动对话 |
| `hermes chat --profile <name>` | 使用指定人格 |
| `hermes memory show` | 查看记忆 |
| `hermes soul show` | 查看人格 |
| `hermes skill list` | 列出技能 |
| `hermes skill run <name>` | 运行技能 |
| `hermes desktop` | 启动桌面版 |
| `hermes dashboard` | 启动 Web Dashboard |
| `hermes kanban init` | 初始化看板 |
| `hermes kanban list` | 列出看板任务 |
| `hermes kanban add "任务"` | 添加看板任务 |
| `hermes kanban dispatcher --detach` | 启动后台调度器 |
| `hermes kanban swarm --workers 4` | 多 Worker 并行 |
| `/goal <目标>` | AI 自动拆解任务 |

> ✋ **费曼自测**：不看笔记，用三句话向朋友介绍 Hermes Agent 的核心能力。

---

## 番茄钟2：配置文件协同工作（25分钟）

### 2.1 配置文件加载顺序

```
启动 Hermes
    ↓
读取 config.yaml（主配置）
    ↓
读取 .env（密钥注入）
    ↓
读取 SOUL.yaml（人格设定）
    ↓
读取 USER.md（用户信息）
    ↓
读取 MEMORY.md（长期记忆）
    ↓
加载 skills/（技能库）
    ↓
准备就绪
```

### 2.2 配置文件协同图

```
┌─────────────────────────────────────────────────────────────┐
│                    配置文件协同工作                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  config.yaml ──→ 控制整体行为                               │
│       ↓                                                     │
│  .env ──→ 注入敏感信息（API Key）                           │
│       ↓                                                     │
│  SOUL.yaml ──→ 定义 AI 是谁、怎么行为                       │
│       ↓                                                     │
│  USER.md ──→ 定义用户是谁、喜欢什么                         │
│       ↓                                                     │
│  MEMORY.md ──→ 存储项目背景、重要经验                       │
│       ↓                                                     │
│  skills/ ──→ 扩展 AI 能力                                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2.3 关键配置项回顾

**config.yaml 核心配置：**

```yaml
model:
  provider: openrouter
  name: hermes-4-14b

memory:
  enabled: true
  curated_write: true      # 关键：策展式写入

skills:
  enabled: true
  auto_generate: true      # 关键：自动生成技能
```

> ✋ **费曼自测**：如果 AI 的回答太"无聊"，应该调整哪个配置项？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [x] 掌握了 6 天的学习内容
- [x] 理解配置文件的加载顺序和协同方式
- [x] 记住了常用命令

---

## 番茄钟3：Hermes 新特性生态 - Kanban 看板（25分钟）

### 3.1 Kanban 看板回顾

**用一句话复习：** Kanban 看板是一个**任务可视化管理系统**，让 Hermes 能并行管理多个任务，自动调度 Worker，超时回收。

**核心特性速记：**

```
Kanban 状态流：Triage → Todo → Ready → Running → Done
                                        ↓
                                     Blocked → → (解除后回 Ready)

核心技术：
├── SQLite WAL 模式数据库（~/.hermes/kanban.db）
├── Dispatcher 调度器（守护进程）
├── Heartbeat 心跳检测（15分钟TTL）
├── Reclaim 回收机制（检测僵尸 Worker）
└── Hallucination Gate（防止 AI 幻觉导致的错误任务）
```

### 3.2 Kanban 核心架构

**四表存储结构：**

| 表名 | 用途 | 关键字段 |
|:-----|:-----|:---------|
| `tasks` | 任务主表 | id, title, status, priority, worker_id |
| `task_links` | 任务依赖关系 | source_id, target_id, link_type |
| `task_comments` | 任务评论 | task_id, content, created_at |
| `task_events` | 操作事件日志 | task_id, event_type, timestamp |

**Atomic Claim 机制：** Worker 通过 compare-and-swap 原子操作领取任务，确保同一任务不会被两个 Worker 同时领取。

### 3.3 Kanban 三大工作区

| 工作区类型 | 命令 | 适用场景 |
|:-----------|:-----|:---------|
| **Scratch**（临时） | 默认 | 快速实验、一次性任务 |
| **Worktree**（隔离） | `--workspace worktree` | 安全隔离、并行开发 |
| **Dir**（指定目录） | `--workspace dir:/path` | 在指定目录执行 |

### 3.4 实战场景：用 Kanban 编排日报流程

```bash
# 1. 创建看板流程
hermes kanban add "抓取 AI 新闻源" --priority high --tags "daily, fetch"
hermes kanban add "生成摘要" --priority high --tags "daily, summarize"
hermes kanban add "格式化日报" --priority medium --tags "daily, format"
hermes kanban add "推送到 Telegram" --priority medium --tags "daily, notify"

# 2. 启动调度器
hermes kanban dispatcher --detach

# 3. 启动多 Worker 并行
hermes kanban swarm --workers 3

# 4. 查看看板状态
hermes kanban stats
# 输出示例：
# Total: 4 | Todo: 1 | Ready: 1 | Running: 2 | Done: 0
# Throughput: 5 tasks/min | Workers: 2/3 active
```

> ✋ **费曼自测**：不用看笔记，解释 Kanban 的 Atomic Claim 机制为什么重要？如果两个 Worker 同时领取同一个任务会发生什么？

---

## 番茄钟4：Hermes 新特性生态 - Desktop App & v0.15.0+（25分钟）

### 4.1 Desktop App 能力全景

Desktop App 不仅仅是 CLI 的"图形化包装"，它有独立的能力：

| 能力 | CLI 实现 | Desktop 实现 |
|:-----|:---------|:-------------|
| 对话 | `hermes chat` | 原生 GUI 对话窗口 |
| Profile 切换 | `--profile` 参数 | 左侧栏可视化切换 |
| 看板操作 | CLI 命令 | 拖拽卡片操作 |
| 多会话 | 终端标签页 | 标签页 + 并发 Profile |
| 模型切换 | 修改 config.yaml | 下拉菜单即时切换 |
| 远程访问 | SSH | Web Dashboard + OAuth Gateway |
| 命令面板 | 无 | Cmd+K 快捷键 |
| 语言支持 | 配置项 | 内置简体中文 |

**v0.16.0 "The Surface Release"（2026-06-05）亮点：**

- ✅ **Desktop App**：Electron + React + Python 后端，全平台支持
- ✅ **Web Dashboard**：管理后台，MCP 目录，凭据管理
- ✅ **Remote Gateway**：OAuth 远程访问
- ✅ **Cmd+K**：命令面板，快速操作
- ✅ **并发多 Profile 会话**：同时运行多个 AI 实例
- ✅ `/undo [N]`：撤销上 N 步操作
- ✅ **MIT 协议**：完全开源

### 4.2 v0.15.0 重大改进

| 改进项 | 改进前 | 改进后 | 提升倍数 |
|:-------|:-------|:-------|:---------|
| 代码库体积 | 16,083 行 | 3,821 行 | **缩减 76%** |
| 冷启动时间 | ~3.5s | **0.8s** | **4x 提升** |
| session_search | ~90s | **20ms** | **4,500x 提升** |
| Bitwarden 集成 | 手动配置 | 原生支持 | — |
| xAI Web Search | 不支持 | 插件支持 | — |

### 4.3 Hermes 生态全景图

```
                    ┌──────────────────────┐
                    │    Hermes 生态全景     │
                    └──────────────────────┘

    ┌─────────────────────────────────────────────────────────┐
    │                    接入方式                              │
    ├────────────┬───────────┬──────────────┬─────────────────┤
    │ CLI 终端   │ Desktop   │ Web Dashboard│ Telegram Bot    │
    │ (本地开发)  │ (日常使用) │ (远程管理)   │ (移动端)        │
    └────────────┴───────────┴──────────────┴─────────────────┘
                            │
    ┌─────────────────────────────────────────────────────────┐
    │                    核心引擎                              │
    ├─────────────────────────────────────────────────────────┤
    │  记忆系统  │  Skill系统  │  Kanban看板  │  多Agent并行   │
    └─────────────────────────────────────────────────────────┘
                            │
    ┌─────────────────────────────────────────────────────────┐
    │                    外部生态                              │
    ├────────────┬──────────────┬──────────────┬──────────────┤
    │ MCP 服务器  │ 社区Skill    │插件市场(90+)  │  Hostinger   │
    │ (工具连接)  │ (agentskills)│              │ (托管服务)   │
    └────────────┴──────────────┴──────────────┴──────────────┘
```

### 4.4 你可以在生态中扮演的角色

| 角色 | 活动 | 价值 |
|:-----|:-----|:-----|
| **用户** | 使用 CLI/Desktop 日常操作 | 提升生产力 |
| **技能作者** | 发布社区 Skill | 帮助他人，积累声望 |
| **插件开发者** | 开发 Desktop 插件 | 扩展 Hermes 生态 |
| **贡献者** | 提交代码/文档 | 参与开源社区 |
| **Hostinger 用户** | 云端托管 Hermes | 无需本地部署 |

> ✋ **费曼自测**：Hermes v0.15.0 最大的改进是什么？为什么 session_search 速度提升了 4500 倍？
>
> 💡 **复习作业**：列出至少 3 个你想用 Kanban 编排的工作流场景，并用 Hermes Desktop App 完成其中 1 个的配置。

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [x] Kanban 看板的状态机和调度机制
- [x] Desktop App 的能力和适用场景
- [x] v0.15.0/v0.16.0 的重大改进
- [x] Hermes 生态全景图

## 番茄钟5：三层记忆系统整合设计（25分钟）

### 5.1 Hermes 记忆 vs Obsidian 记忆

**你的 Obsidian 三层记忆：**

| Layer | 位置 | 用途 |
|:------|:-----|:-----|
| Layer 1 | Context/、Reading/、Script/ | 永久知识 |
| Layer 2 | Claude_Memory/ | 会话记录 |
| Layer 3 | MEMORY.md | 路由指南 |

**Hermes 三层记忆：**

| Layer | 位置 | 用途 |
|:------|:-----|:-----|
| Layer 1 | MEMORY.md、USER.md | 持久记忆 |
| Layer 2 | 外部 Provider | 可选扩展 |
| Layer 3 | 会话上下文 | 临时记忆 |

### 5.2 整合方案设计

```
┌─────────────────────────────────────────────────────────────┐
│                    Hermes + Obsidian 整合                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Hermes MEMORY.md ←同步→ Obsidian MEMORY.md                │
│         ↓                         ↓                         │
│  项目背景、学习进度         知识库路由、操作规则            │
│                                                             │
│  Hermes USER.md ←同步→ Obsidian/Context/用户身份与偏好     │
│         ↓                         ↓                         │
│  用户偏好、禁忌             用户画像、品牌定位              │
│                                                             │
│  Hermes Claude_Memory/（独立）                             │
│         ↓                                                   │
│  会话记录、临时洞见                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 5.3 整合配置示例

**更新 Hermes MEMORY.md：**

```markdown
# Hermes 长期记忆

> 与 Obsidian MEMORY.md 同步
> 最后更新：2026-06-06

---

## 知识库路由

### Obsidian 三层记忆
- Layer 1（永久）：Context/、Reading/、Script/
- Layer 2（临时）：Claude_Memory/
- Layer 3（路由）：MEMORY.md

### 核心文件夹
- Context/：身份、品牌、规则
- Clippings/：剪藏素材
- Script/：创作内容
- Reading/：读书笔记
- 书库/：专业书籍

---

## 项目背景

### ideal 知识库
- 用途：个人知识管理 + 内容创作
- 结构：三层记忆系统

### Hermes 学习进度
- [x] Week 1：基础掌握
- [ ] Week 2：进阶实践
```

> ✋ **费曼自测**：设计你的 Hermes + Obsidian 整合方案。

---

## 番茄钟6：知识自动化目标（25分钟）

### 6.1 知识自动化愿景

**用大白话讲：**

想象有一条**知识流水线**：

```
原始素材 → 处理 → 编译 → 归档 → 输出
   ↓          ↓        ↓        ↓       ↓
 剪藏文章   提取要点  结构化   知识库   日报/报告
```

**目标：让这条流水线自动运转，24/7 不休息。**

### 6.2 自动化场景设计

| 场景 | 输入 | 处理 | 输出 |
|:-----|:-----|:-----|:-----|
| **热点追踪** | RSS/网站 | 抓取→分析→摘要 | 日报 |
| **知识编译** | Clippings/ | 提取→结构化→链接 | Reading/ |
| **内容生产** | 主题研究 | 调研→整理→创作 | Script/ |
| **学习辅导** | 课程资料 | 分析→自测→笔记 | 学习记录 |

### 6.3 今日实战目标

**完成：知识自动化流水线 v1.0**

```
输入：Clippings/ 下的剪藏文章
处理：Hermes 自动编译
输出：结构化笔记 → Reading/
      学习日报 → Claude_Memory/
```

> ✋ **费曼自测**：描述你想要实现的知识自动化场景。

---

## 🍅 番茄钟5-6结束，休息5分钟

**核心概念回顾：**
- [ ] 设计了 Hermes + Obsidian 整合方案
- [ ] 明确了知识自动化目标

---

## 番茄钟7：创建知识编译 Skill（25分钟）

### 7.1 Skill 需求分析

**知识编译器需要做什么？**

| 步骤 | 动作 | 输出 |
|:-----|:-----|:-----|
| 1 | 扫描 Clippings/ | 文件列表 |
| 2 | 分析内容类型 | 分类标签 |
| 3 | 提取核心信息 | 摘要、关键词 |
| 4 | 生成结构化笔记 | Markdown 文件 |
| 5 | 归档到 Reading/ | 知识库文件 |
| 6 | 更新索引 | 索引文件 |

### 7.2 创建知识编译 Skill

```bash
# 创建 Skill 目录
mkdir -p ~/.hermes/skills/custom/knowledge-compiler
```

**SKILL.md 内容：**

```markdown
---
name: knowledge-compiler
description: 将剪藏内容编译成结构化知识笔记
triggers:
  - "编译.*知识"
  - "处理.*剪藏"
  - "知识.*编译"
  - "整理.*剪藏"
---

# 知识编译器

## 功能
将 Clippings/ 目录下的剪藏内容编译成结构化的知识笔记，存入 Reading/ 目录。

## 工作流程

### 1. 扫描剪藏目录
- 读取 Clippings/ 下所有 .md 文件
- 提取文件元信息（名称、日期、来源）

### 2. 分析内容类型
- 识别文章类型（技术/人文/商业/...）
- 提取主题和关键词
- 判断重要性等级

### 5. 提取核心信息
- 生成 200 字摘要
- 提取 3-5 个核心观点
- 识别关键术语

### 4. 生成结构化笔记
- 使用 Obsidian Markdown 格式
- 添加 YAML frontmatter
- 添加标签和链接
- 关联相关笔记

### 5. 归档输出
- 存入 Reading/对应主题/
- 更新 Reading/索引文件
- 移动原文件到 Archive/

## 输入参数
- input_dir: 输入目录（默认 Clippings/）
- output_dir: 输出目录（默认 Reading/）
- max_files: 最大处理文件数（默认 10）

## 输出格式

```markdown
---
title: 文章标题
date: 2026-06-06
tags: [标签1, 标签2]
source: 来源链接
---

# 文章标题

> 一句话摘要

## 核心观点
1. 观点1
2. 观点2
3. 观点3

## 关键内容
[结构化内容]

## 相关链接
- [[相关笔记1]]
- [[相关笔记2]]
```

## 权限
- read: Clippings/, Reading/
- write: Reading/, Claude_Memory/
```

### 7.3 注册并测试

```bash
# 注册 Skill
hermes skill register knowledge-compiler

# 验证 Skill
hermes skill validate knowledge-compiler

# 测试 Skill
hermes skill run knowledge-compiler --params '{"max_files": 1}'
```

> ✋ **费曼自测**：创建并注册知识编译 Skill。

---

## 番茄钟8：运行知识自动化流水线（25分钟）

### 8.1 准备测试数据

```bash
# 在 Clippings/ 创建测试文件
mkdir -p Clippings/test

cat > Clippings/test/sample-article.md << 'EOF'
# AI Agent 技术发展趋势

来源：https://example.com/ai-agent-trends
日期：2026-06-05

## 摘要
本文探讨了 AI Agent 技术的最新发展趋势...

## 主要内容
1. 多模态 Agent 正在兴起
2. 记忆系统成为核心竞争力
3. 技能自动化是未来方向
EOF
```

### 8.2 运行知识编译

```
You: 编译 Clippings/test 目录下的知识。

Hermes: [触发 knowledge-compiler 技能]

正在扫描 Clippings/test/...
发现 1 个文件：sample-article.md

正在分析内容...
- 类型：技术文章
- 主题：AI Agent
- 重要性：高

正在提取核心信息...
- 摘要：AI Agent 技术发展趋势分析
- 核心观点：多模态、记忆系统、技能自动化

正在生成结构化笔记...
- 创建 Reading/AI/sample-article-compiled.md
- 更新索引

完成！
```

### 8.3 验证输出

```bash
# 查看生成的笔记
cat Reading/AI/sample-article-compiled.md

# 查看更新的索引
cat Reading/AI/索引.md
```

### 8.4 批量处理

```
You: 编译 Clippings/ 目录下所有的剪藏内容。

Hermes: [触发 knowledge-compiler 技能]

正在扫描 Clippings/...
发现 15 个文件

正在批量处理...
[1/15] article1.md - 完成
[2/15] article2.md - 完成
...
[15/15] article15.md - 完成

批量处理完成！
- 成功：13
- 失败：2
- 详情见日志
```

> ✋ **费曼自测**：运行知识编译流水线，处理至少 3 个文件。

---

## 🍅 番茄钟7-8结束，休息5分钟

**实战成果：**
- [ ] 创建了知识编译 Skill
- [ ] 成功运行知识自动化流水线
- [ ] 生成了结构化笔记

---

## 番茄钟9：Week 1 成果验收（25分钟）

### 9.1 学习成果自检

**基础技能：**

- [ ] 能独立安装和配置 Hermes（CLI + Desktop）
- [ ] 能解释每个配置文件的作用
- [ ] 能配置 MEMORY.md 和 USER.md
- [ ] 能创建和切换 AI 人格
- [ ] 能安装和使用 Skill
- [ ] 能触发 Skill 自动生成

**Kanban & 工作流：**

- [ ] 能初始化 Kanban 看板并启动 Dispatcher
- [ ] 能使用 Kanban 命令管理任务（添加、移动、完成）
- [ ] 能设计 Skill + Kanban 工作流编排
- [ ] 理解 /goal 命令和 Checkpoints 机制

**Desktop & 新特性：**

- [ ] Desktop App 安装完成并能正常使用
- [ ] 了解 Web Dashboard 管理后台功能
- [ ] 了解 v0.15.0/v0.16.0 的重大改进

**进阶成果：**

- [ ] 完成了 Hermes + Obsidian 整合设计
- [ ] 创建了知识编译 Skill
- [ ] 运行了知识自动化流水线

### 9.2 能力评估

| 能力 | 1分（未掌握） | 3分（基本掌握） | 5分（熟练） |
|:-----|:--------------|:----------------|:------------|
| 安装配置（含Desktop） | [ ] | [ ] | [ ] |
| 记忆系统 | [ ] | [ ] | [ ] |
| 人格配置 | [ ] | [ ] | [ ] |
| 技能系统 | [ ] | [ ] | [ ] |
| Kanban 看板 | [ ] | [ ] | [ ] |
| 自动化实战 | [ ] | [ ] | [ ] |

**评分标准：**
- 6-12分：需要继续练习
- 13-24分：基本掌握
- 25-30分：熟练掌握

### 9.3 遇到的问题与解决方案

| 问题 | 解决方案 |
|:-----|:---------|
| | |
| | |

---

## 番茄钟10：后续学习规划（25分钟）

### 10.1 Week 2 学习预告

| 日期 | 主题 | 目标 |
|:-----|:-----|:-----|
| **Day 8** | 外部记忆 Provider | 配置 Mem0/Pinecone |
| **Day 9** | 多 Agent 并行 | 运行批量任务 |
| **Day 10** | Profiles 多实例 | 创建独立实例 |
| **Day 11** | MCP 外部连接 | 连接 GitHub/数据库 |
| **Day 12** | Cron 定时任务 | 配置定时日报 |
| **Day 13** | 三层记忆集成 | 完成整合部署 |
| **Day 14** | 综合实战 | 完整自动化系统 |

### 10.2 进阶学习路径

```
Week 1（已完成）→ 基础掌握
    ↓
Week 2 → 进阶实践
    ↓
持续优化 → 知识自动化系统
    ↓
日常使用 → 让 AI 越用越聪明
```

### 10.3 学习笔记模板

```markdown
# Hermes Agent 学习笔记 - Day 7

> 日期：2026-06-06
> 完成状态：✅ Week 1 完成！

---

## 核心结论
Week 1 学习完成，掌握了 Hermes Agent 核心功能 + Kanban 看板工作流 + Desktop App 图形界面，并实现了知识自动化流水线 v1.0。

## Week 1 总结

### 掌握的技能
1. 安装配置 Hermes CLI + Desktop App
2. 配置记忆系统和 AI 人格
3. 安装和使用 Skill
4. Kanban 看板任务编排
5. Skill + Kanban 工作流实战
6. Hermes 生态全景认知（CLI/Desktop/Web/Telegram）

### 实战成果
- 知识编译 Skill：knowledge-compiler
- Kanban 工作流：日报自动化流程
- 整合方案：Hermes + Obsidian
- 自动化流水线：Clippings → Reading

### 能力自评
- 安装配置（含Desktop）：__/5
- 记忆系统：__/5
- 人格配置：__/5
- 技能系统：__/5
- Kanban 看板：__/5
- 自动化实战：__/5

## Week 2 计划
- [ ] Day 8：外部记忆 Provider
- [ ] Day 9：多 Agent 并行
- [ ] Day 10：Profiles 多实例
- [ ] Day 11：MCP 外部连接
- [ ] Day 12：Cron 定时任务
- [ ] Day 13：三层记忆集成
- [ ] Day 14：综合实战
```

---

### 10.4 刻意练习——复习与综合实战

**练习目标**：在30分钟内完成从 Skill 创建到 Kanban 编排再到执行完成的完整闭环

**任务序列（重复×3）：**

```
===== 循环 1：入门任务 =====
1. 在终端中完成3个不同操作任务的快速切换
2. 任务A：运行 `hermes skill list` 查看已安装技能
3. 任务B：运行 `hermes config show` 查看当前配置
4. 任务C：运行 `hermes kanban status` 查看看板状态
验证方式：3个命令均正常输出，且理解每个命令的含义

===== 循环 2：进阶任务 =====
1. 配置一个 Kanban 工作流：包含至少4个任务节点
2. 设计依赖关系（至少2个任务需要前序任务完成才能执行）
3. 启动 Dispatcher 并执行工作流
验证方式：工作流按设计的依赖顺序正确执行，所有任务到达 Done 状态

===== 循环 3：挑战任务 =====
1. 完成一个完整闭环：Skill 创建 → Kanban 编排 → 执行完成
2. 创建或找到一个已有 Skill（如 knowledge-compiler）
3. 将其拆解为 Kanban 看板任务并设置依赖
4. 启动 Dispatcher 和 Swarm 模式执行
验证方式：完整闭环从开始到结束无人工干预，输出成果符合预期
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 终端操作命令 | ⬜ | ⬜ | ⬜ |
| Kanban 工作流编排 | ⬜ | ⬜ | ⬜ |
| 完整闭环执行 | ⬜ | ⬜ | ⬜ |
| 综合排错能力 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Week 1 学完后，你能用 Hermes 完成一个什么样的自动化任务？向朋友描述你的知识自动化流水线方案。

---

## 🎉 Day 7 完成！Week 1 毕业！

**本周成果：**
- ✅ 掌握 Hermes Agent 核心功能
- ✅ 完成配置和记忆系统设置
- ✅ 使用 Kanban 看板编排任务工作流
- ✅ 安装和配置 Hermes Desktop 桌面版
- ✅ 掌握 v0.15.0/v0.16.0 新特性
- ✅ 创建知识自动化流水线
- ✅ 实现 Hermes + Obsidian 整合

**下周预告：** Week 2 进阶实践 - 外部记忆、多 Agent、MCP、定时任务

---

## 附录：Week 1 知识卡片

### 知识卡片 1：Hermes 核心概念

```
Hermes Agent = AI智能体框架
├── 记忆系统：跨会话记忆
├── 技能系统：可扩展能力
├── 人格系统：可定制性格
└── 并行执行：多任务处理
```

### 知识卡片 2：配置文件关系

```
config.yaml → 主配置
.env → 密钥
MEMORY.md → 长期记忆
USER.md → 用户画像
SOUL.yaml → AI人格
```

### 知识卡片 3：Skill 系统

```
Skill = AI 的 APP
├── 安装：hermes skill install
├── 触发：关键词 / 手动
├── 自动生成：复杂任务
└── 自定义：SKILL.md
```

### 知识卡片 4：Kanban 看板

```
Kanban = 任务可视化管理系统
├── 状态机：Triage→Todo→Ready→Running→Done/Blocked
├── Dispatcher：任务调度守护进程
├── Heartbeat：15分钟TTL心跳检测
├── Reclaim：超时任务自动回收
└── Swarm：多Worker并行执行
```

### 知识卡片 5：Desktop App & 新特性

```
Hermes Desktop App（v0.16.0）
├── Electron + React + Python
├── macOS / Windows / Linux
├── Web Dashboard 管理后台
├── Remote Gateway OAuth
├── Cmd+K 命令面板
├── 并发多Profile会话
└── MIT 完全开源

v0.15.0 重大改进
├── 代码库缩减 76%（16K→3.8K行）
├── 冷启动 0.8s（4x提升）
├── session_search 20ms（4500x提升）
├── Bitwarden 原生集成
└── xAI Web Search 插件
```

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day6-Skill自动生成]] - 上一天内容
> - [[Claude_Memory/Hermes Agent学习计划]] - 原始学习计划
