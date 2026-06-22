# M6：Profile 多实例与多 Agent

> ⏱ **番茄钟**：🍅21-24（共4个番茄 = 100分钟专注 + 20分钟休息）
> 🎯 **学习目标**：掌握 Profile 多实例管理，理解多 Agent 并行协作
> 🧠 **教学方法**：费曼学习法 × B站剪藏辅助理解

---

## 🍅 番茄21：Profile 是什么（25分钟）

### 21.1 用"双卡双待手机"类比

> 本类比来自 B站视频 [[Clippings/Bilibili/2026-06-22-Hermes 分身术：Profile]]：

想象你有**双卡双待手机**：
- **工作号** → Work Profile：连接公司 API，记忆全是项目上下文
- **生活号** → Play Profile：连接个人 API，记忆全是业余爱好
- **测试号** → Test Profile：随便折腾新配置，搞崩了也不影响主力

两个号码（Profile）互不干扰，各自有自己的通讯录（记忆）、套餐（配置）、聊天记录（会话）。

**Profile 的本质 = 给 Hermes 创建多个独立"分身"，每个分身有独立的记忆、配置、技能。**

### 21.2 Profile 隔离什么

```
Profile 隔离的是"大脑"：
├── config.yaml     ✅ 独立配置
├── .env            ✅ 独立 API Key
├── MEMORY.md       ✅ 独立记忆
├── USER.md         ✅ 独立用户画像
├── SOUL.yaml       ✅ 独立人格
├── skills/         ✅ 独立技能
└── 会话历史        ✅ 独立对话记录

Profile 不隔离的是"身体"：
├── 文件系统        ⛔ 共享（所有 Profile 可读写同一目录）
├── 网络            ⛔ 共享
└── 终端            ⛔ 共享
```

### 21.3 什么时候需要多个 Profile？

| 场景 | 一个 Profile 够吗 | 建议 |
|:-----|:-----------------|:-----|
| 日常个人使用 | ✅ 够 | 默认 default 即可 |
| 工作和个人分开 | ❌ 需要 | Work + Personal Profile |
| 多个项目并行 | ❌ 需要 | 每个项目一个 Profile |
| 测试新配置 | ❌ 建议 | Main + Test Profile |
| 不同模型配置 | ❌ 建议 | 每个 Profile 用不同模型 |

> ✋ **费曼自测**：为什么说 Profile 是"双卡双待"？它隔离了什么、共享了什么？

---

## 🍅 番茄22：Profile 命令实战（25分钟）

### 22.1 查看 Profile

```bash
# 列出所有 Profile
hermes profile list
```

示例输出：
```
Profile      Status     Model
───────────  ─────────  ─────────────────
default      Running    deepseek/deepseek-v4-flash
work         Stopped    claude-sonnet-4-20250514
test         Stopped    (not configured)
```

### 22.2 创建 Profile

```bash
# 创建一个新 Profile
hermes profile create <profile-name>

# 例如：创建 work Profile
hermes profile create work

# 从已有 Profile 克隆（继承配置）
hermes profile create bilibili --from default
```

> 创建 Profile 时，Hermes 会自动：
> 1. 在 `~/.hermes/profiles/<name>/` 下创建独立目录
> 2. 同步内置 Skill
> 3. 在 `~/.local/bin/` 下创建快捷启动命令

### 22.3 查看 Profile 详情

```bash
# 查看指定 Profile 信息
hermes profile show <profile-name>

# 示例输出：
# Name:     work
# Path:     ~/.hermes/profiles/work
# Model:    claude-sonnet-4-20250514
# Running:  yes
# Skills:   89
# .env:     exists
# SOUL.md:  exists
```

### 22.4 配置 Profile 模型

```bash
# 给指定 Profile 配置模型
hermes -p <profile-name> setup

# 或直接配置模型
hermes -p <profile-name> model
```

### 22.5 使用 Profile 启动

```bash
# 使用 work Profile 启动
hermes -p work chat

# 或者使用快捷命令（创建 Profile 时自动生成）
work chat

# 切换默认 Profile
hermes profile use <profile-name>
```

### 22.6 Profile 管理命令

```bash
# 重命名
hermes profile rename <old-name> <new-name>

# 删除
hermes profile delete <profile-name>

# 导出（迁移到其他机器）
hermes profile export <profile-name>

# 导入
hermes profile import <file-path>
```

> ✋ **费曼自测**：你想创建哪几个 Profile？分别配置什么模型和记忆内容？

---

## 🍅 番茄23：多 Agent 并行执行（25分钟）

### 23.1 为什么需要多 Agent？

一个 Agent 做一件事很擅长，但要同时做多件事怎么办？

```
单 Agent：顺序执行
  任务A → 完成 → 任务B → 完成 → 任务C → 完成
  总时间 = 25分钟

多 Agent：并行执行
  任务A ──→ 完成
  任务B ──→ 完成    ← 同时进行
  任务C ──→ 完成
  总时间 = 10分钟
```

### 23.2 Hermes 的多 Agent 模型

> 参考 [[Clippings/Bilibili/2026-06-22-把Hermes爆改成超强主 Agent]]

Hermes 的多 Agent 协作有三种模式：

| 模式 | 描述 | 适用场景 |
|:-----|:-----|:---------|
| **看板模式** | 任务队列，Worker 逐个执行 | 批量任务处理 |
| **Profile 隔离** | 多个独立实例并行运行 | 不同项目同时进行 |
| **Sub-Agent 协同** | 主 Agent 调度子 Agent | 复杂任务分解 |

### 23.3 看板模式（Kanban）

```bash
# 查看看板状态
hermes kanban

# 初始化看板
hermes kanban init

# 添加任务
hermes kanban add "任务描述"

# 查看任务进度
hermes kanban status
```

**看板任务的生命周期：**
```
Pending → Running → Completed
              ↓ (超时)
           Blocked → 自动重试
```

### 23.4 Sub-Agent 协同架构

> 参考视频 [[Clippings/Bilibili/2026-06-22-Hermes四角色架构OPC模式]]

高级用户可以将 Hermes 配置为 **Agent Team**：

```
                    ┌──────────────────┐
                    │  Coordinator     │ ← 主 Agent（调度中心）
                    │  协调者          │
                    └──────┬───────────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
    ┌──────▼──────┐ ┌──────▼──────┐ ┌──────▼──────┐
    │  Researcher │ │   Writer    │ │   Builder   │
    │  研究员     │ │   写作者    │ │   构建者    │
    └─────────────┘ └─────────────┘ └─────────────┘
           │               │               │
           └───────────────┼───────────────┘
                           │
                    ┌──────▼──────┐
                    │  Wiki 知识库 │ ← 共享知识
                    └─────────────┘
```

**四个角色的分工：**

| 角色 | 职责 | 特点 |
|:-----|:-----|:-----|
| **Coordinator** | 任务拆解、路由、调度 | 不直接执行，只分配 |
| **Researcher** | 收集证据、对比来源 | 不做结论，只提供证据 |
| **Writer** | 结构搭建、内容转化 | 写完有四重质检 |
| **Builder** | 实现、测试、调试 | 卡住时五步自救流程 |

> 这个架构解决了三个核心问题：
> 1. **幻觉** — Researcher 提供确凿证据
> 2. **记忆污染** — 各角色记忆隔离
> 3. **角色混乱** — 每个 Agent 只做一件事

> ✋ **费曼自测**：多 Agent 并行执行的三个模式分别适合什么场景？你当前最想用哪种？

---

## 🍅 番茄24：Profile + 多 Agent 练习（25分钟）

### 24.1 三级练习

```
===== 循环 1：入门任务 =====
1. 查看当前 Profile 列表：`hermes profile list`
2. 创建一个新 Profile（如 personal）
3. 配置新 Profile 的模型
4. 切换到新 Profile 对话
✅ 验证方式：两个 Profile 使用不同模型，互不干扰

===== 循环 2：进阶任务 =====
1. 创建 work 和 personal 两个 Profile
2. 配置不同模型和 API Key
3. 在两个 Profile 之间切换使用
4. 验证各自的记忆独立
✅ 验证方式：Profile 间记忆不共享

===== 循环 3：挑战任务 =====
1. 使用看板模式提交3个任务
2. 观察任务执行状态
3. 尝试使用后台模式执行任务
4. （可选）设计一个简单的 Sub-Agent 协作流程
✅ 验证方式：能够管理看板任务，理解多 Agent 工作流
```

### 24.2 Profile 管理的实用场景

**示例：为不同场景创建 Profile**

```bash
# 场景1：学习模式
hermes profile create learning
hermes -p learning setup

# 场景2：写作模式
hermes profile create writing
hermes -p writing setup

# 场景3：编程模式
hermes profile create coding
hermes -p coding setup

# 快速切换
learning chat  # 启动学习模式
writing chat   # 启动写作模式
```

### 📋 自检清单

- [ ] **番茄21**：理解 Profile 的本质（独立"分身"）
- [ ] **番茄22**：能熟练使用 Profile 管理命令
- [ ] **番茄23**：理解三种多 Agent 模式
- [ ] **番茄24**：创建了至少2个可用的 Profile

---

## 🎯 M6 核心命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `hermes profile list` | 列出所有 Profile |
| `hermes profile create <name>` | 创建 Profile |
| `hermes profile show <name>` | 查看 Profile 详情 |
| `hermes profile delete <name>` | 删除 Profile |
| `hermes profile export <name>` | 导出 Profile |
| `hermes -p <name> chat` | 使用指定 Profile 对话 |
| `hermes kanban` | 查看看板状态 |
| `hermes kanban add "任务"` | 添加看板任务 |

---

👉 **下一步：** [[M7-综合实战与知识库构建]]

> **关联资料：**
> - [[Clippings/Bilibili/2026-06-22-Hermes 分身术：Profile]] — Profile 视频教程
> - [[Clippings/Bilibili/2026-06-22-把Hermes爆改成超强主 Agent]] — Sub-Agent 调度
> - [[Clippings/Bilibili/2026-06-22-Hermes四角色架构OPC模式]] — Agent Team 架构
