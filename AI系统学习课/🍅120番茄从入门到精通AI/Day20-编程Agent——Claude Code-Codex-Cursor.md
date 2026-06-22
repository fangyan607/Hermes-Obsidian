---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#编程Agent"
  - "#ClaudeCode"
  - "#Codex"
  - "#Cursor"
  - "#番茄学习法"
  - "#费曼学习法"
  - "#刻意练习"
  - "#120番茄"
aliases:
  - Day20 编程Agent
  - Claude Code Codex Cursor
  - 120番茄Day20
---

# 🍅 Day20：编程Agent——Claude Code / Codex / Cursor（番茄96-100）

> **PART 5：主流工具与生态——侦探的武器库**
> 
> 前19天你学会了"让AI思考"。从今天开始，你学习"让AI动手"。

---

## 🕵️ 悬疑开场：当AI不再只是"聊天"

**案发时间**：2026年3月，凌晨2:47。

一个知名开源项目的维护者收到了一条奇怪的 PR。不是人提的——是 **Claude Code** 提的。它自己发现了 issue，自己分析了代码库，自己写了修复，自己跑了测试，自己提了 PR。整个流程没有经过任何人类的手。

PR 描述里写着：
> *"Automated fix by Claude Code. Root cause: null pointer exception in line 142. Test coverage added. All existing tests pass."*

维护者看了代码，改了三个字符，修复了一个潜伏六个月的 bug。

他关上电脑，去泡了杯咖啡。回来时，又一条 PR 已经提交了。

---

**这不是科幻小说。这是2026年的日常。**

从这一天开始，"编程"这件事的定义永远改变了：

- **2024年**，AI 是你的**结对编程搭档**——你写代码，它补全
- **2025年**，AI 是你的**高级实习生**——你给任务，它写代码
- **2026年**，AI 是你的**自主 Agent**——你给目标，它自己完成整个开发生命周期

**问题是：你准备好让你的 Agent 干活了吗？**

> **本日核心**：掌握三大编程 Agent——Claude Code、OpenAI Codex、Cursor——的安装、配置和实战，学会在不同场景下选择合适的工具。

---

## 🍅 番茄96（T1）：Claude Code——Anthropic 的编程 Agent

### 1.1 什么是 Claude Code？

Claude Code 是 Anthropic 推出的 **终端原生编程 Agent**。它不是 IDE 插件，不是聊天窗口——它直接跑在你的终端里，能读文件、写代码、跑命令、创建 PR。

**核心定位**：**"AI 工程师 + DevOps + 项目经理"三合一。**

```
┌─────────────────────────────────────────────────────┐
│                  Claude Code                          │
│                                                       │
│  你输入目标 → Claude Code 自主完成：                   │
│  ├─ 理解项目结构（读文件、分析依赖）                   │
│  ├─ 设计方案（思考、规划、记录）                       │
│  ├─ 编写代码（多文件编辑、重构）                       │
│  ├─ 运行测试（执行命令、检查输出）                     │
│  ├─ 调试修复（分析错误、循环改进）                     │
│  └─ 提交 PR（创建分支、提交、推送）                     │
└─────────────────────────────────────────────────────┘
```

### 1.2 安装与配置

```bash
# 安装 Claude Code（需要 Node.js 18+）
npm install -g @anthropic-ai/claude-code

# 验证安装
claude --version

# 首次启动（会引导你配置 API Key）
claude
```

**配置要点**：

| 配置项 | 说明 | 推荐值 |
|:-------|:-----|:-------|
| `ANTHROPIC_API_KEY` | Anthropic API 密钥 | 从 console.anthropic.com 获取 |
| `CLAUDE_CODE_MAX_TOKENS` | 每次回复最大 Token | 64000（默认） |
| `CLAUDE_CODE_MODE` | 运行模式 | `auto`（推荐） |
| `CLAUDE_PROJECT_DIR` | 项目根目录 | 你的代码仓库路径 |

### 1.3 核心命令体系

Claude Code 最强大的能力来自它的命令系统：

| 命令 | 功能 | 使用场景 |
|:-----|:------|:---------|
| `/goal "目标"` | **目标驱动模式**——持续运行直到目标达成 | 修复所有 bug、实现新功能 |
| `/loop 时间 "指令"` | **循环模式**——定时执行指定任务 | 每5分钟检查部署状态 |
| `/plan "任务"` | **计划模式**——先生成方案再执行 | 复杂功能开发 |
| `/review` | **代码审查模式**——分析当前代码 | Pull Request 前的自查 |
| `/explain` | **解释模式**——解释选中的代码 | 阅读不熟悉的代码库 |
| `/skill "名称"` | **加载技能**——加载预设技能包 | 调用已有最佳实践 |

**最强大的两个命令**：

#### `/goal`——目标驱动模式

```
claude> /goal "修复 src/ 下所有的 TypeScript 类型错误"
```

Claude Code 会：
1. 先扫描所有 `.ts` 文件，找出类型错误
2. 逐个分析错误的根因
3. 逐文件修复
4. 运行 `tsc` 验证
5. 如果还有错误，继续修
6. **循环直到所有错误清零**

#### `/loop`——定时循环模式

```
claude> /loop 5m "检查部署状态，如果服务宕机就重启"
```

Claude Code 会：
1. 每5分钟检查一次部署
2. 如果检测到宕机，自动诊断并重启
3. 记录每次检查的结果
4. 在指定次数后或手动终止时停止

### 1.4 项目示例：用 Claude Code 自动修复代码 bug 并创建 PR

**场景**：你的开源项目有一个 issue 报告——"当输入为空列表时，程序崩溃"。

用一个 `/goal` 命令搞定：

```
claude> /goal "修复 Issue #42：空列表导致程序崩溃。需要：1) 定位根因 2) 写修复 3) 加测试 4) 确认所有测试通过 5) 创建 PR"
```

**Claude Code 的实际执行过程**：

```
回合 1：分析
  → 读取 issue 描述
  → 搜索相关代码（grep 搜索空列表相关逻辑）
  → 定位到 utils/processor.py:142 缺少空列表边界检查
  
回合 2：修复
  → 在 processor.py 添加空列表守卫条件
  → 同时检查所有调用方是否也需要修改
  
回合 3：测试
  → 为边缘情况编写测试用例
  → 运行 `pytest` → 发现一个关联测试失败
  → 修复关联测试中的硬编码
  
回合 4：验证
  → 再次 `pytest` → 全部通过
  → `mypy .` → 类型检查通过
  → `ruff check .` → lint 通过
  
回合 5：PR
  → 创建新分支 fix/issue-42
  → 提交改动
  → 推送到远程
  → 创建 PR 并自动填写描述
```

**结果**：从 issue 到 PR，**不到3分钟**。

---

> ✋ **费曼自测**：用一句话向室友解释"Claude Code 的 `/goal` 命令和普通 ChatGPT 有什么本质区别"。
> 
> **答案参考**：ChatGPT 是你问一句它答一句的"对话模式"；`/goal` 是"告诉它一个目标，它会自己想办法、自己动手、自己检查、直到目标达成的自主模式"。前者是"问答"，后者是"执行"。

---

## 🍅 番茄97（T2）：OpenAI Codex——OpenAI 的编程 Agent

### 2.1 什么是 Codex？

OpenAI Codex 是 OpenAI 推出的**编程 Agent 体系**。它不是 GPT 的"写代码模式"，而是一个完整的 Agent——能理解代码库、规划开发步骤、执行多步骤编程任务。

**关键演进**：

| 版本 | 时间 | 能力 |
|:-----|:-----|:-----|
| Codex（原始） | 2023 | 自然语言→代码的转换器 |
| Codex CLI | 2025 | 终端编程 Agent，类似 Claude Code |
| Codex Agent | 2026 | **完整 Agent 模式**：规划→执行→验证→迭代 |

**Codex 的独特优势**：
- **与 OpenAI 生态深度集成**——GPTs、Assistants API、Function Calling
- **多模态理解**——能同时看代码、截图、流程图
- **自动工具调用**——自动决定何时读文件、何时写代码、何时跑命令

### 2.2 Codex CLI 安装与使用

```bash
# 安装 Codex CLI
npm install -g @openai/codex

# 配置 API Key
export OPENAI_API_KEY="sk-xxxx"

# 启动交互模式
codex

# 单次执行模式
codex "创建一个 React 组件，展示用户列表"
```

**配置选项**：

```bash
# 指定模型
codex --model o3

# 指定工作目录
codex --workdir ./my-project

# agent 模式（最强大）
codex --agent "重构整个 auth 模块，使用 JWT 替代 session"
```

### 2.3 Codex Agent 模式深度解析

Codex Agent 模式是其最强功能。它使用**循环推理-行动**模式：

```
Agent 循环：
  Input: "创建用户认证模块"
  
  Step 1: 理解需求
  → 分析项目现有结构
  → 检查 package.json 已有依赖
  → 理解项目代码风格
  
  Step 2: 规划
  → 列出需要创建的文件
  → 确定技术方案（JWT, bcrypt, middleware）
  → 估算风险点
  
  Step 3: 执行
  → 创建 authRoutes.js
  → 创建 authMiddleware.js
  → 创建 userModel.js
  → 更新 app.js 注册路由
  
  Step 4: 验证
  → 检查语法错误
  → 检查 import 路径
  → 检查类型一致性
  
  Step 5: 迭代
  → 发现问题？→ 回到 Step 3
  → 全部通过？→ 输出完成报告
```

### 2.4 项目示例：用 Codex 从描述生成完整 React 组件

**Prompt**：

```
codex --agent "创建一个完整的 UserDashboard 组件：
- 从 API 获取用户数据（使用 fetch）
- 显示用户信息卡片（头像、姓名、邮箱、角色）
- 支持搜索和筛选
- 加载状态和错误状态处理
- 使用 Tailwind CSS 样式
- 包含单元测试"
```

**Codex 的输出**：

```
┌─ 分析需求 ─────────────────────────────────────┐
│ 检测到项目使用 React 18 + Tailwind CSS + Jest  │
│ 已有 API 基础路径: /api/v1                     │
│ 组件位置: src/components/                      │
└────────────────────────────────────────────────┘

┌─ 创建文件 ─────────────────────────────────────┐
│ 1. src/components/UserDashboard.jsx     ✅     │
│ 2. src/components/UserCard.jsx          ✅     │
│ 3. src/hooks/useUsers.js                ✅     │
│ 4. src/components/__tests__/Dashboard.test.jsx ✅│
└────────────────────────────────────────────────┘

┌─ 验证 ─────────────────────────────────────────┐
│ npm test → 5 tests passed                      │
│ ESLint → no errors                             │
└────────────────────────────────────────────────┘
```

**生成的 useUsers 钩子**：

```javascript
// useUsers.js - 由 Codex 自动生成
import { useState, useEffect, useMemo } from 'react';

export function useUsers() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [search, setSearch] = useState('');
  const [roleFilter, setRoleFilter] = useState('all');

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setLoading(true);
        const res = await fetch('/api/v1/users');
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();
        setUsers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchUsers();
  }, []);

  const filteredUsers = useMemo(() => {
    return users.filter(user => {
      const matchSearch = user.name.toLowerCase().includes(search.toLowerCase()) ||
                         user.email.toLowerCase().includes(search.toLowerCase());
      const matchRole = roleFilter === 'all' || user.role === roleFilter;
      return matchSearch && matchRole;
    });
  }, [users, search, roleFilter]);

  return { users: filteredUsers, loading, error, search, setSearch, roleFilter, setRoleFilter };
}
```

> ✋ **费曼自测**：Codex CLI 的 `--agent` 模式和普通的"让 ChatGPT 写代码"有什么不同？用"项目管理"打个比方。

---

## 🍅 番茄98（T3）：Cursor——AI 原生 IDE

### 3.1 什么是 Cursor？

Cursor 是一个**从零开始为 AI 设计的 IDE**。它不是 VS Code 加 AI 插件，而是把 AI 嵌入到了编辑器的每一个毛孔里。

**一句话定位**：**Cursor 是 AI 的"专属驾驶舱"，而你坐在副驾驶。**

```
传统 IDE + AI 插件：    VS Code + Copilot → "AI 辅助你写代码"
Cursor（AI 原生）：      Cursor → "你和 AI 一起写代码"
Claude Code（终端Agent）： 终端 → "AI 自主写代码，你审核"
```

### 3.2 Cursor 的核心功能矩阵

| 功能 | 说人话版本 | 为什么重要 |
|:-----|:-----------|:-----------|
| **Tab 补全** | 你打字时 AI 预测下一个代码块 | 减少 40% 的键盘输入 |
| **Composer** | 多文件编辑面板，一次修改多个文件 | 跨文件重构的救星 |
| **Agent 模式** | AI 自主完成复杂任务：分析→规划→执行 | 从"补全代码"到"完成任务" |
| **Chat** | 内嵌对话窗口，理解当前代码上下文 | 不用切换窗口提问 |
| **Plan 模式** | AI 先出方案再执行 | 大型变更的风险控制 |
| **上下文理解** | AI 知道整个项目结构 | 不再是"单文件"瞎子 |

### 3.3 Composer——AI 的多文件手术刀

Composer 是 Cursor 最独特的功能之一。它让你在一个面板里同时编辑多个文件，AI 自动处理文件间的依赖关系。

**典型场景**：添加一个新功能需要创建组件、更新路由、添加状态管理——Composer 一次性完成全部。

**使用方式**：

```
1. 按 Ctrl/Cmd + I 打开 Composer
2. 输入需求："添加一个暗黑模式切换按钮，保存用户偏好到 localStorage"
3. Cursor 会：
   ├─ 创建 DarkModeToggle.jsx（按钮组件）
   ├─ 创建 useDarkMode.js（自定义钩子）
   ├─ 修改 App.jsx（集成 Provider）
   └─ 修改 index.css（添加暗黑模式变量）
4. 你预览所有变更 → 点击 Accept All
```

### 3.4 Agent 模式——最强的 Cursor 能力

**Agent 模式让 Cursor 从一个"编辑器"变成一个"编程搭档"**：

```
Normal Mode:                     Agent Mode:
你写代码，AI 补全                  你描述任务，AI 自主完成
↓                                  ↓
逐行                              整体
被动补全                          主动规划
单文件                            多文件
你负责决策                        你负责审核
```

**如何启动 Agent 模式**：
```
Composer 右下角 → 切换到 Agent 模式
```

**Agent 模式的典型工作流**：

```
你：Agent，帮我重构这个古老的 jQuery 代码
    改成 React 组件，保持功能完全一致

Agent：
  Step 1: 分析
    → 读取整个 jQuery 文件（500行）
    → 理解所有功能：搜索、排序、分页、筛选
  
  Step 2: 规划
    → 拆分为 3 个组件：SearchBar, DataTable, Pagination
    → 设计数据流：父组件管理状态
  
  Step 3: 执行
    → 创建 SearchBar.jsx
    → 创建 DataTable.jsx  
    → 创建 Pagination.jsx
    → 创建 useTableData.js 自定义钩子
  
  Step 4: 报告
    "重构完成。3个组件已创建，jQuery 依赖已移除。
     功能完全保持一致。请 Review 确认。"

你：Review → 发现一个小 Bug → 反馈

Agent：修复 → 再次提交
```

### 3.5 `.cursorrules`——让 AI 懂你的"潜规则"

`.cursorrules` 是 Cursor 的"文化手册"。它告诉 AI 你的项目规范、代码风格、技术栈偏好。

**示例：一个 React 项目的 `.cursorrules`**

```
你是一个资深的 React 工程师。请遵守以下规则：

## 技术栈
- 框架: Next.js 14, App Router
- 样式: Tailwind CSS
- 状态: Zustand
- 请求: React Query
- 类型: TypeScript strict mode

## 编码规范
- 使用函数组件 + hooks，不使用 class 组件
- 组件文件使用 PascalCase，钩子使用 camelCase
- 每个组件必须包含 PropTypes 或 TypeScript 接口定义
- 导出默认组件使用 default export，工具函数使用 named export
- 错误边界必须覆盖每个数据获取组件

## 命名规则
- 组件文件: UserProfile.tsx
- 钩子文件: useUserProfile.ts
- 类型文件: user.types.ts
- 工具函数: formatDate.ts

## 禁止事项
- 不使用 any 类型
- 不使用内联样式（用 Tailwind）
- 不在组件内定义嵌套函数
- 不使用 console.log（用 logger 工具）

## 测试要求
- 每个组件必须有对应的测试文件
- 测试覆盖率不低于 80%
- 优先测试用户交互场景
```

> ✋ **费曼自测**：`.cursorrules` 和普通的 README 有什么本质区别？为什么前者对 AI 的"工作效率"提升远超后者？

### 3.6 项目示例：在 Cursor 中用 Agent 模式重构老旧代码库

**场景**：一个 3 年历史的 jQuery + PHP 项目，需要迁移到现代 React 栈。

**操作步骤**：

```
1. 在项目根目录创建 .cursorrules
   → 描述目标技术栈和规范
   → 指定迁移策略（渐进式，模块化）

2. 打开 Composer → Agent 模式
   → 输入任务："将 js/legacy-table.js (800行)
      从 jQuery 迁移到 React + TanStack Table"

3. Cursor Agent 执行：
   ├─ 分析 legacy-table.js 的所有功能点
   ├─ 创建新的 React 组件树
   ├─ 处理事件绑定（jQuery .on → React 事件）
   ├─ 处理 DOM 操作（jQuery .append → React 渲染）
   ├─ 处理 AJAX 请求（$.ajax → React Query)
   └─ 更新相关文件引用

4. Review → 测试 → 合并
```

---

## 🍅 番茄99（T4）：GitHub Copilot 与 Aider——其他重要编程伴侣

### 4.1 GitHub Copilot——AI 编程的"老兵"

Copilot 是 AI 编程工具的"开创者"。虽然现在不是最前沿的，但它的市场覆盖率和成熟度依然无与伦比。

**Copilot 的演进**：

| 年代 | 版本 | 核心能力 |
|:-----|:-----|:---------|
| 2023 | Copilot | 代码补全（Tab 触发） |
| 2024 | Copilot Chat | 内嵌对话，支持代码上下文 |
| 2025 | Copilot Workspace | 从 Issue 到 PR 的完整工作流 |
| 2026 | Copilot Agent | Agent 模式，多文件自主编辑 |

**Copilot 的独特优势**：
- **GitHub 深度集成**——直接在 Issue、PR 中工作
- **企业级安全**——IP 合规、企业数据隔离
- **多 IDE 覆盖**——VS Code、JetBrains、Neovim、Visual Studio

**实战技巧**：

```markdown
# Copilot 的"隐形指令"
- 用注释描述意图：// 实现一个 LRU 缓存
- 用函数名表达行为：async function fetchUserWithRetry()
- 用类型注释约束：function sort<T>(items: T[], key: keyof T)
- 用 TODO 触发上下文：// TODO: 需要事务支持
```

### 4.2 Aider——开源编程 Agent 之王

Aider 是 **完全开源**的终端编程 Agent。如果你不想用付费服务，Aider 是最佳选择。

**安装与配置**：

```bash
# 安装
pip install aider-chat

# 配置 API Key
export ANTHROPIC_API_KEY="sk-xxx"
# 或
export OPENAI_API_KEY="sk-xxx"

# 启动
aider
```

**Aider 的独特能力**：

| 能力 | 说明 | 为什么重要 |
|:-----|:------|:-----------|
| **多文件编辑** | 一次修改多个文件，自动处理依赖 | 大型重构的基础 |
| **Git 自动管理** | 每次修改后自动创建 git commit | 试错安全网 |
| **架构图生成** | 自动绘制代码库的架构图 | 理解遗留系统 |
| **多模型** | 支持 Claude、GPT、DeepSeek 等 | 不被绑定 |
| **本地模型** | 支持 ollama 本地模型 | 数据安全 |

### 4.3 项目示例：用 Aider 实现多文件重构

**场景**：你将一个 monolithic 的 `utils.py`（2000行）拆分为有组织的模块。

**操作**：

```bash
# 1. 启动 Aider，告诉它你的目标
aider

# 2. 在 Aider 对话中输入：
> 我需要将 utils.py 拆分为以下模块：
> - src/utils/strings.py（字符串处理函数）
> - src/utils/dates.py（日期时间函数）  
> - src/utils/io.py（文件 I/O 函数）
> - src/utils/validators.py（验证函数）
> - src/utils/__init__.py（统一导出）
> 
> 拆分后，更新所有引用了 utils.py 的文件。
> 确保每个新文件有独立的测试。

# 3. Aider 会：
#    ├─ 分析 utils.py 找出所有函数和它们的依赖
#    ├─ 拆分成 5 个文件
#    ├─ 搜索整个项目中所有 import utils 的地方
#    ├─ 更新 import 路径
#    ├─ 运行测试确认一切正常
#    └─ 每步自动 git commit（方便回滚）

# 4. 你可以随时：aider --diff 查看变更
#                      aider --commit 手动提交
```

**Aider 的架构图功能**：

```
> /arch

src/
├── utils/
│   ├── __init__.py      ← 统一导出
│   ├── strings.py       ← 12个字符串函数
│   ├── dates.py         ← 8个日期函数
│   ├── io.py            ← 6个文件函数
│   └── validators.py    ← 15个验证函数
├── models/
│   └── user.py          ← 引用了 validators.py
├── api/
│   └── routes.py        ← 引用了 strings.py, dates.py
└── tests/
    ├── test_strings.py  ← 新增
    ├── test_dates.py    ← 新增
    ├── test_io.py       ← 新增
    └── test_validators.py ← 新增
```

### 4.4 编程 Agent 的横向对比

| 维度 | Claude Code | Codex | Cursor | Copilot | Aider |
|:-----|:-----------|:------|:-------|:--------|:------|
| **类型** | 终端 Agent | 终端 Agent | AI IDE | IDE 插件 | 终端 Agent |
| **开源** | 否 | 否 | 否 | 否 | **是** |
| **模型** | Claude 系列 | GPT/O 系列 | 多模型 | GPT-4o | 多模型 |
| **价格** | API 按量付费 | API 按量付费 | $20/月 | $10/月 | API 按量付费 |
| **上下文** | 100K | 128K | 1M+ | 64K | 视模型而定 |
| **Agent 模式** | ✅ /goal | ✅ --agent | ✅ Composer | ✅ Copilot Agent | ✅ 默认 |
| **多文件编辑** | ✅ 原生 | ✅ 原生 | ✅ Composer | ✅ Workspace | ✅ git 管理 |
| **终端命令** | ✅ 原生 | ✅ 原生 | ❌ | ❌ | ✅ 审核模式 |
| **PR 创建** | ✅ 自动 | ✅ 自动 | ✅ GitHub MCP | ✅ 原生 | ✅ git 管理 |
| **本地模型** | ❌ | ❌ | ❌ | ❌ | ✅ Ollama |

> ✋ **费曼自测**：Claude Code 和 Aider 都是终端 Agent，它们最大的不同是什么？什么场景下你会选 Aider 而不是 Claude Code？

---

## 🍅 番茄100（T5）：对比总结——什么时候用哪个？

### 5.1 选择框架：四象限决策模型

```
                    ┌── 任务复杂度 ──┐
                    │                 │
              简单任务              复杂任务
    ┌─────────────────────────────────────────┐
    │                    │                     │
    │  单文件   │  Copilot Tab    │  Cursor    │
    │           │  快速补全      │  Composer  │
    │           │  日常编码      │  多文件修改 │
    │           │                │            │
——─┼───────────┼────────────────┼────────────┼─── 项目规模
    │           │                │            │
    │           │  Copilot Chat  │ Claude Code│
    │  多文件   │  Aider 单次   │  /goal      │
    │           │  小范围修改    │  Codex Agent│
    │           │                │  大项目     │
    └─────────────────────────────────────────┘
```

### 5.2 场景化推荐

| 你正在做的事 | 推荐工具 | 原因 |
|:------------|:---------|:-----|
| **日常编码**，写函数、修 bug | Copilot / Cursor Tab | 最低侵入性，Tab 即用 |
| **添加新功能**，涉及多个文件 | Cursor Composer | 多文件编辑最顺手 |
| **大型重构**，从 A 架构到 B 架构 | Claude Code `/goal` | 自主规划+循环验证 |
| **从零开始的项目** | Codex Agent | 从描述生成完整项目 |
| **开源项目贡献** | Aider | 开源、免费、支持本地模型 |
| **代码审核 PR** | Copilot Workspace | 原生 GitHub 集成 |
| **自动化 CI/CD 管道** | Claude Code `/loop` | 定时循环+自主修复 |
| **敏感数据项目** | Aider + Ollama | 全本地，数据不出网 |

### 5.3 学习路线图：如何一步步成为编程 Agent 高手

```
Level 1：入门（1周）
├─ 安装 Cursor，体验 Tab 补全
├─ 安装 Claude Code，跑一次 /goal
└─ 安装 Copilot，日常编码中感受"预测"的威力

Level 2：熟练（2周）
├─ 掌握 Cursor Composer，多文件编辑
├─ 创建第一个 .cursorrules
├─ 用 Claude Code 完成一次完整的 bug 修复→PR 流程
└─ 用 Codex Agent 从描述生成一个小项目

Level 3：精通（1个月）
├─ 设计复杂的 /goal 目标（含多条件停止标准）
├─ 结合 MCP 工具扩展编程 Agent 的能力
├─ 建立自己的 Agent 工作流模板
└─ 掌握 Aider 的多文件重构技巧

Level 4：大师（3个月+）
├─ 设计多 Agent 协作系统（Maker/Checker 分离）
├─ 编写自定义 Skill，让 Agent 遵循团队规范
├─ 构建 CI/CD 管道中的 Agent 自动化
└─ 教会团队其他成员使用编程 Agent
```

### 5.4 明天的预告

> **Day21 预告**：你学会了让 AI 写代码——但如果 AI 能直接操作你的浏览器、数据库、支付系统、云服务呢？MCP 协议 + OpenClaw + n8n 即将揭晓。
>
> 暗器已经就位。明天，你的 AI 将不再只是一个"编程工具"——它将成为你的整个"数字分身"。

### 5.5 本日核心回顾

| 番茄 | 核心收获 | 掌握程度 |
|:-----|:---------|:---------|
| 🍅96 | Claude Code 的安装、`/goal`、`/loop` 命令 | □ 了解 □ 掌握 ☑ 熟练 |
| 🍅97 | Codex CLI + Agent 模式，从描述生成组件 | □ 了解 □ 掌握 ☑ 熟练 |
| 🍅98 | Cursor 的 Composer、Agent 模式、.cursorrules | □ 了解 □ 掌握 ☑ 熟练 |
| 🍅99 | Copilot 实战技巧 + Aider 多文件重构 | □ 了解 □ 掌握 ☑ 熟练 |
| 🍅100 | 四象限决策 + 场景化推荐 + 学习路线图 | □ 了解 □ 掌握 ☑ 熟练 |

---

## 📌 刻意练习

### 练习1（模仿）：用 Claude Code 完成一次完整修复
1. 找一个你项目中的 open issue 或已知 bug
2. 用 `/goal` 命令让 Claude Code 自主修复
3. 观察它的执行过程，记录它的规划方式
4. 对比它写的修复和你手动修复的区别

### 练习2（变式）：用 Cursor Composer 跨文件重构
1. 找一个老项目或你的实验项目
2. 在 `.cursorrules` 中写下你的编码规范
3. 用 Cursor Agent 模式重构一个功能模块（从 class 到 hooks，或从 jQuery 到 React）
4. 观察 Composer 如何处理跨文件依赖

### 练习3（创造）：建立你的"编程 Agent 选择清单"
为你当前的项目或工作流，创建一个决策清单：

```markdown
我的项目类型：[Web 应用 / 脚本工具 / 开源库 / ...]
技术栈：[React / Python / Go / ...]

日常编码 → [ ] Cursor Tab（单文件补全）
新功能开发 → [ ] Cursor Composer（多文件编辑）
Bug 修复 → [ ] Claude Code /goal（自主修复→PR）
大型重构 → [ ] Aider（开源+安全）
从零搭建 → [ ] Codex Agent（描述→项目）
```

---

## 🔗 关联知识

- [[AI系统学习课/🍅3番茄精通Loop Engineering-循环工程]] — Loop Engineering 是编程 Agent 的底层哲学
- [[AI系统学习课/🍅番茄1-AI Agent生态与智能体工具链]] — Agent 生态全景
- [[AI系统学习课/🍅120番茄从入门到精通AI/Day21-OpenClaw-n8n-MCP创意工具与自动化]] — 下一站：MCP + 自动化
- [[书库/人工智能/AIGC：智能创作时代]] — AI 创作工具的发展

---

*创建日期：2026-06-15 | 番茄数：5（96-100）| 学习方法：番茄&费曼*
