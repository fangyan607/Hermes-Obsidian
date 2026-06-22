---
created: 2026-06-19
module: C
total_pomodoros: 5
tags:
  - Vercel
  - v0
  - AI
  - 代码生成
  - shadcn
  - 教程
---

# 模块C：v0 AI 代码生成（5🍅）

> 目标：掌握 v0——Vercel 出品的 AI 代码生成工具，从提示词工程到组件生成再到生产部署

---

## 🍅16 v0 平台入门与核心概念（25分钟）

### 费曼输入

**v0** 是 Vercel 推出的 AI 代码生成平台（原 v0.dev，2026 年 1 月迁移至 v0.app），专门用于生成 React/Next.js 组件和完整页面。截至 2026 年 6 月，v0 经历了 2026 年 2 月的重大重构，已从"原型玩具"进化为**连接生产代码库的严肃开发工具**。

**核心能力**：
- 用自然语言描述 UI → 生成 React + Tailwind + shadcn/ui 组件
- 截图/设计稿 → 代码（上传 Figma 截图或任意 UI 图片）
- Git 集成：直接在 v0 中创建分支、提交 PR、合并部署
- GitHub 仓库导入：导入现有项目并继续用 AI 开发
- 多模型选择：根据任务复杂度选择不同模型

**v0 模型矩阵**（2026）：

| 模型 | 上下文 | 用途 | 价格 |
|:----|:------|:-----|:----|
| v0-mini | — | 简单组件、快速迭代 | 输入$1/输出$5 /百万token |
| v0-pro | — | 默认模型，平衡速度质量 | 输入$3/输出$15 /百万token |
| v0-max | — | 复杂多步骤任务 | 输入$5/输出$25 /百万token |
| v0-1.5-md | 128K tokens | 基于 Claude Sonnet，日常主力 | — |
| v0-1.5-lg | 512K tokens | 超复杂任务，需谨慎 | — |

### 刻意练习

```bash
# 1. 访问 v0.app 并登录（用 GitHub 账号）
# 2. 了解 Dashboard 布局
#    - Chat 界面：左侧对话，右侧实时预览
#    - 版本历史：每次修改自动保存
#    - Git 面板：分支/PR/提交管理

# 3. 安装 v0 CLI（可选）
npm install -g @vercel/v0

# 4. 用 CLI 初始化项目
v0 init my-v0-project
cd my-v0-project
npm install
npm run dev
```

### ✅ 完成标准

- [ ] 注册 v0.app 并完成 GitHub 登录
- [ ] 了解 v0 各模型和定价
- [ ] 理解 v0 的核心能力范围（UI生成/截图转代码/Git集成）
- [ ] 安装 v0 CLI（可选）

### 📖 费曼三句话

1. v0 是 Vercel 的 AI 前端工程师——你说 UI 长什么样，它生成代码
2. 2026 年 v0 不再是"玩具"了，它能连你的 GitHub 仓库直接干活
3. 不同模型对应不同复杂度：简单组件用 mini，复杂任务用 max

---

## 🍅17 提示词工程与组件生成（25分钟）

### 费曼输入

用好 v0 的关键是写好提示词（Prompt）。好的提示词 = 清晰的描述 + 具体的约束 + 参考示例。

**提示词工程四要素**：

| 要素 | 说明 | 示例 |
|:----|:-----|:-----|
| 角色 | 告诉 v0 它是什么角色 | "你是一个资深 UI/UX 设计师" |
| 需求 | 清晰描述你要什么 | "一个用户资料卡片组件" |
| 约束 | 技术栈/设计限制 | "使用 shadcn/ui Card 组件，响应式" |
| 示例 | 给参考效果 | "类似 Twitter 的个人资料卡" |

**v0 特别技巧**：
- 用 `/component` 专门生成组件
- 用 `/page` 生成完整页面
- 用 `--schema` 附带数据模型定义
- 多轮对话中逐步精炼，不要一次要求太多

### 刻意练习

```markdown
# 练习1：生成一个数据表格组件
提示词：
"创建一个带有搜索、排序和分页功能的数据表格组件。
使用 shadcn/ui 的 Table 组件，TypeScript 类型定义数据。
包含状态列（用 Badge 显示 active/inactive）。
表格数据用模拟数据填充，至少 20 行。"

# 练习2：生成仪表盘页面
提示词：
"生成一个 SaaS 仪表盘页面，包含：
- 左侧边栏导航（仪表盘/分析/设置/用户管理）
- 顶部导航栏（搜索框 + 通知图标 + 用户头像）
- 主要内容区：4 个统计卡片（总收入/活跃用户/转化率/平均响应时间）
- 一个折线图显示最近 30 天趋势
- 最近订单表格
使用 shadcn/ui + Recharts（折线图）"

# 练习3：截图转代码
# 上传一张你喜欢的网站截图或设计稿
# 提示词："把这张截图转换成 React 组件，像素级还原"
```

```typescript
// v0 生成的示例组件结构
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';

// v0 会自动引入 shadcn/ui 组件
// 生成的代码开箱即用，零配置
```

### ✅ 完成标准

- [ ] 掌握 v0 提示词四要素
- [ ] 成功生成一个带搜索排序的表格组件
- [ ] 成功生成一个完整的仪表盘页面
- [ ] 尝试截图转代码功能

### 📖 费曼三句话

1. 给 v0 写提示词就像给设计师提需求——越具体越准确
2. 角色 + 需求 + 约束 + 示例 = 完美的 v0 提示词公式
3. v0 默认生成 shadcn/ui 组件，开箱即用不用改

---

## 🍅18 shadcn/ui 设计系统与 v0（25分钟）

### 费曼输入

**shadcn/ui** 是 v0 默认使用的组件库，它不是传统的 npm 包，而是一个"复制粘贴"式的组件集合。v0 生成的代码直接使用 shadcn/ui 组件，确保风格统一、无障碍可用。

**shadcn/ui 核心特点**：
- 不是 npm 依赖，而是直接复制源码到你的项目中
- 基于 Tailwind CSS + Radix UI（无障碍原生）
- 支持主题定制（亮色/暗色/自定义主题）
- 组件包括：Button、Card、Dialog、Dropdown、Table、Form、Badge 等 50+

**v0 + shadcn/ui 工作流**：

```
v0 生成组件 → init shadcn/ui → 复制组件代码 → 定制主题 → 集成使用
```

### 刻意练习

```bash
# 1. 在项目中初始化 shadcn/ui
npx shadcn@latest init

# 按照提示选择：
# - 样式: Default（或 New York）
# - 基础色: 选你喜欢的（默认 Zinc）
# - CSS 变量: 是
# - 全局 CSS: 是
# - React 服务器组件: 否（Vite 项目）
# - 组件导入路径: @/components

# 2. 安装 v0 生成的代码需要的组件
npx shadcn@latest add button card table badge input

# 3. 定制主题
# 编辑 app/globals.css 中的 CSS 变量
:root {
  --primary: 222.2 47.4% 11.2%;
  --primary-foreground: 210 40% 98%;
  /* ... 更多变量 */
}

.dark {
  --primary: 210 40% 98%;
  --primary-foreground: 222.2 47.4% 11.2%;
}
```

```typescript
// 主题定制示例 — 公司品牌色
// 在 globals.css 中覆盖
:root {
  --primary: 221.2 83.2% 53.3%;  /* 蓝色主题 */
  --primary-foreground: 210 40% 98%;
  --radius: 0.5rem;  /* 圆角统一 */
}
```

**v0 风格选择**：
- v0 支持两种 shadcn/ui 风格：**Default**（经典）和 **New York**（现代）
- 在 v0 设置中可以切换默认风格
- 生成的组件代码自动适配你选择的风格

### ✅ 完成标准

- [ ] 成功在项目中初始化 shadcn/ui
- [ ] 安装并使用至少 5 个 shadcn/ui 组件
- [ ] 理解 v0 与 shadcn/ui 的协作关系
- [ ] 能自定义主题颜色

### 📖 费曼三句话

1. shadcn/ui 是 v0 的"默认设计语言"——所有组件都用它
2. 它像乐高积木一样，按需把组件源码"复制"到你的项目里
3. 改 CSS 变量就能换主题，不需要改组件代码

---

## 🍅19 v0 Git 集成与生产部署（25分钟）

### 费曼输入

2026 年 v0 最大的更新是 **Git 集成**。现在你可以在 v0 中完成从开发到部署的完整工作流，而不需要离开浏览器。

**Git 工作流**：

```
v0 Chat 中开发 → 创建分支 → 提交变更 → 创建 PR → 合并到 main → 自动部署到 Vercel
```

**GitHub 仓库导入**：
v0 可以导入任意 GitHub 仓库，在 Sandbox 中运行并编辑。它会自动拉取环境变量和 Vercel 配置，代码写完后直接提交回你的仓库。

### 刻意练习

```bash
# 方案1：从 v0 直接部署到 Vercel
# 1. 在 v0 中完成组件开发
# 2. 点击 "Deploy to Vercel" 按钮
# 3. 选择项目名称和团队
# 4. 自动完成部署

# 方案2：Git 工作流
# 1. 在 v0 中链接 GitHub 仓库
# 2. 创建新分支 feature/new-dashboard
# 3. 开发仪表盘页面
# 4. 提交变更 → 创建 PR
# 5. 在 GitHub 上 Review → Merge
# 6. Vercel 自动部署

# 方案3：CLI + v0 API
# 生成组件代码到本地
v0 generate "创建一个联系表单组件" --output ./components/contact-form.tsx

# 同步项目
v0 sync  # 同步 v0 项目和本地代码
```

**v0 + Vercel 部署配置**：

```json
// vercel.json — v0 项目的推荐配置
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "vite",
  "cleanUrls": true,
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

### ✅ 完成标准

- [ ] 理解 v0 的 Git 集成工作流
- [ ] 从 v0 直接部署项目到 Vercel
- [ ] 体验"创建分支 → 提交 → PR → 合并"完整流程
- [ ] 会使用 v0 CLI 生成和同步代码

### 📖 费曼三句话

1. 2026 年的 v0 有了 Git 集成——从聊天到 PR 到部署，全程在浏览器完成
2. 导入 GitHub 仓库 → AI 开发 → 提交 PR → 合并上线，形成完整闭环
3. CI/CD 全自动：PR 合并到 main 后 Vercel 自动构建部署

---

## 🍅20 v0 Agent 模式与高级用法（25分钟）

### 费曼输入

v0 的 **Agent 模式** 是 2026 年的高级功能，让 AI 不仅能生成组件，还能自主规划、调试和多步骤构建完整功能。

**Agent 模式可处理的任务**：
- 多文件重构：同时修改多个组件和文件
- 自动修复：运行代码后检测错误并自动修复
- 数据库集成：生成 API 路由 + 数据库查询代码
- 全功能开发：从描述到完整功能（前端 + API + 数据流）

**v0 的限制（2026）**：

| 限制 | 说明 | 替代方案 |
|:----|:-----|:--------|
| 不擅长 Auth 逻辑 | 生成登录 UI 但不处理 session/JWT | 用 Supabase Auth |
| 复杂状态管理 | 多步表单/实时订阅生成不完整 | 手动补充逻辑 |
| 仅 React/Next.js | Vue/Svelte 支持有限 | 这类项目用 Bolt.new |
| Vercel 锁定 | 一键部署只对齐 Vercel | 代码可导出，但部分优化丢失 |

### 刻意练习

```typescript
// Agent 模式实战：构建一个完整的 "待办应用"
// 提示词模板（一次性描述整个功能）

// 提示词：
// "创建一个完整的待办应用，包含：
// 1. 前端 UI：输入框 + 添加按钮 + 待办列表（已完成/未完成切换）
// 2. 每个待办项有：复选框（标记完成）、文本、删除按钮
// 3. 数据存储：使用 localStorage 持久化
// 4. 底部统计：显示总数/已完成数/未完成数
// 5. 过滤功能：全部/已完成/未完成
// 6. 添加动画过渡效果
// 使用 React + TypeScript + shadcn/ui +
// 把数据逻辑封装到自定义 hook useTodos()"

// Tip: 用 /agent 前缀触发 Agent 模式
// "/agent 创建一个完整的博客系统..."
```

```typescript
// v0 Agent 生成的 Hook 示例
import { useState, useEffect } from 'react';

type Todo = {
  id: string;
  text: string;
  completed: boolean;
  createdAt: Date;
};

export function useTodos() {
  const [todos, setTodos] = useState<Todo[]>(() => {
    const saved = localStorage.getItem('todos');
    return saved ? JSON.parse(saved) : [];
  });

  useEffect(() => {
    localStorage.setItem('todos', JSON.stringify(todos));
  }, [todos]);

  const addTodo = (text: string) => { /* ... */ };
  const toggleTodo = (id: string) => { /* ... */ };
  const deleteTodo = (id: string) => { /* ... */ };
  const clearCompleted = () => { /* ... */ };

  return { todos, addTodo, toggleTodo, deleteTodo, clearCompleted };
}
```

**v0 最佳实践总结**：

| 场景 | 推荐做法 | 不推荐做法 |
|:----|:--------|:----------|
| 新组件 | 一次性描述清晰 | 一步步挤牙膏改 |
| Bug 修复 | 提供错误信息 + 截图 | 只说"不好用" |
| 页面生成 | 描述布局结构 + 数据来源 | 说"做个漂亮的页面" |
| 多轮修改 | 每次聚焦一个方面 | 一次改 10 件事 |
| 性能优化 | 完成后手动优化 | 期望 v0 自动优化 |


### ✅ 完成标准

- [ ] 理解 Agent 模式的能力范围和限制
- [ ] 用 Agent 模式完成一个完整功能开发
- [ ] 掌握 v0 的局限和对应的替代方案
- [ ] 总结 v0 使用最佳实践

### 📖 费曼三句话

1. Agent 模式下 v0 可以自主规划并完成多步骤开发任务
2. 一次说清楚完整需求比多次修改效率高得多
3. v0 擅长前端 UI 生成，复杂后端逻辑需要手动补充

---

## 🍅 模块C 综合考核

1. 用 v0 生成一个完整的"个人博客"首页（导航 + 文章列表 + 侧边栏）
2. 将生成的代码部署到 Vercel（通过 v0 直接部署或 Git 工作流）
3. 自定义 shadcn/ui 主题，改成你喜欢的配色
4. 用 Agent 模式添加暗色模式切换功能
5. 写三句话总结 v0 最适合做什么、不适合做什么

**预期耗时**：45-60分钟（2个番茄）
**完成标准**：一个用 v0 生成的完整页面部署上线，包含自定义主题
