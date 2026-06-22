---
created: 2026-06-19
module: E
total_pomodoros: 5
tags:
  - Vercel
  - AI Gateway
  - Workflow
  - Agent
  - eve
  - 教程
---

# 模块E：综合实战与高级应用（5🍅）

> 目标：掌握 Vercel AI 高级基础设施——AI Gateway、Workflow SDK、Agent Stack，完成从 Lovable 到生产的全流程实战

---

## 🍅26 AI Gateway 入门（25分钟）

### 费曼输入

**Vercel AI Gateway** 是 AI 应用的"智能路由器"——它位于你的应用和 AI 模型之间，统一管理模型调用、缓存、速率限制、成本控制和故障转移。

**核心功能**：

```
你的应用 → AI Gateway → 模型A（如 GPT-4）
                    → 模型B（如 Claude）
                    → 模型C（如 Gemini）
                    → 缓存命中（直接返回）
```

**2026 里程碑**：AI Gateway 月处理 token 从 2 万亿增长到 20 万亿，已成为 Vercel AI 基础设施的核心。

**核心能力**：

| 功能 | 说明 | 类比 |
|:----|:-----|:----|
| 统一接口 | 一个 API 对接所有模型 | AI 的万能遥控器 |
| 故障转移 | 模型A 挂了自动切换到 模型B | 备用轮胎 |
| 成本控制 | 简单问题用小模型，复杂问题用大模型 | 智能分流 |
| 缓存 | 相同请求直接返回缓存结果 | 记忆力 |
| 速率限制 | 控制每分钟/每小时调用次数 | 水龙头限流 |
| 监控 | 所有调用日志、延迟、错误率 | 仪表盘 |

### 刻意练习

```bash
# 1. 在 Vercel 中启用 AI Gateway
# Vercel Dashboard → AI Gateway → Enable

# 2. 获取 Gateway 访问凭证
# Settings → API Keys → 创建新 Key

# 3. 用 curl 测试基础调用
curl -X POST https://gateway.vercel.ai/v1/chat/completions \
  -H "Authorization: Bearer 你的GATEWAY_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o",
    "messages": [
      {"role": "user", "content": "用一句话解释什么是 AI Gateway"}
    ]
  }'
```

```typescript
// 4. 用 AI SDK 接入 AI Gateway
// 安装 SDK
// npm install ai @vercel/ai-gateway

import { generateText } from 'ai';
import { createOpenAI } from '@ai-sdk/openai';

const openai = createOpenAI({
  // 指向 AI Gateway 端点
  baseURL: 'https://gateway.vercel.ai/v1',
  apiKey: process.env.GATEWAY_KEY,
});

async function main() {
  const result = await generateText({
    model: openai('gpt-4o'),
    prompt: '用一句话解释什么是 AI Gateway',
  });
  console.log(result.text);
}
```

**成本控制配置**：

```json
// AI Gateway Settings → Cost Controls
{
  "budgets": {
    "monthly": 100,        // 月预算上限 $100
    "per_request": 0.05    // 单次请求上限 $0.05
  },
  "model_routing": {
    "default": "gpt-4o-mini",  // 默认用便宜模型
    "fallback": "claude-3-haiku", // 降级备用
    "escalation": "gpt-4o"      // 复杂问题升级
  },
  "cache": {
    "enabled": true,
    "ttl": 3600  // 缓存1小时
  }
}
```

### ✅ 完成标准

- [ ] 在 Vercel 中启用 AI Gateway
- [ ] 用 curl 成功调用 AI Gateway
- [ ] 理解网关的核心功能（路由/缓存/成本控制）
- [ ] 配置基本的成本控制策略

### 📖 费曼三句话

1. AI Gateway 是"AI 的 API 网关"——统一管理所有 AI 模型调用
2. 它自动做故障转移、缓存和成本优化，你不需要改代码
3. 2026 年月处理 20 万亿 token，说明 AI Gateway 已经是 AI 基础设施标配

---

## 🍅27 Workflow SDK 与持久化 Agent（25分钟）

### 费曼输入

**Workflow SDK**（`@ai-sdk/workflow`）是 Vercel 2026 年推出的 AI Agent 框架，用于构建**持久化、可恢复的 AI Agent**。与传统的"请求-响应"模式不同，Workflow 让 Agent 可以长时间运行、跨步骤持久化状态、等待人工审批。

**核心概念**：

```
'use workflow' 标记的函数 → 每个工具调用是一个持久化步骤
         ↓
步骤失败 → 从断点自动重试（不是从头开始）
         ↓
需要人工 → 挂起等待（可等几小时到几天）
         ↓
继续执行 → 从暂停处恢复
```

**与传统 Agent 的区别**：

| 维度 | 传统 Agent | Workflow Agent |
|:----|:----------|:--------------|
| 状态管理 | 内存中，丢失即失 | 持久化，进程重启也不丢 |
| 错误处理 | 整个重试 | 从失败步骤重试 |
| 人工介入 | 不支持 | 原生支持（needsApproval） |
| 运行时长 | 受限于请求超时 | 可持续数天 |
| 可观测性 | 日志 | 可视化步骤仪表盘 |

### 刻意练习

```typescript
// 1. 安装 Workflow SDK
// npm install @ai-sdk/workflow

// 2. 创建一个持久化 Agent
import { openai } from '@ai-sdk/openai';
import { WorkflowAgent } from '@ai-sdk/workflow';

// 定义一个"市场调研 Agent"
export async function POST(req: Request) {
  const agent = new WorkflowAgent({
    model: openai('gpt-4o'),
    maxSteps: 50,
    persistSteps: true,  // 持久化每个步骤
  });

  // 添加工具（标记为持久化步骤）
  agent.addTool('search_web', {
    description: '搜索网络获取信息',
    parameters: { query: { type: 'string' } },
    execute: async ({ query }) => {
      // 这是一个持久化步骤
      // 如果失败，下次从这步重试
      const result = await fetch(`https://api.search.com?q=${query}`);
      return result.json();
    }
  });

  agent.addTool('generate_report', {
    description: '生成调研报告',
    needsApproval: true,  // 需要人工审核后才执行
    execute: async ({ data }) => {
      return { report: data };
    }
  });

  // 3. 运行 Agent
  const result = await agent.run(
    '调研 AI 编程工具市场，分析 v0、Lovable、Cursor 的优劣势，生成对比报告'
  );

  return Response.json(result);
}
```

**Workflow 可视化**：

```
Vercel Dashboard → Workflows → 查看运行中的 Agent
  ├── Step 1: search_web "v0.dev 市场数据" ✓ (120ms)
  ├── Step 2: search_web "Lovable 市场数据" ✓ (95ms)
  ├── Step 3: search_web "Cursor 市场数据" ✓ (110ms)
  ├── Step 4: analyze_data ⏳ 运行中...
  └── Step 5: generate_report 🔒 等待审批
```

### ✅ 完成标准

- [ ] 理解 Workflow SDK 的"持久化步骤"概念
- [ ] 创建一个带工具的 Workflow Agent
- [ ] 体验"needsApproval"人工审批流程
- [ ] 理解与传统 Agent 的区别

### 📖 费曼三句话

1. Workflow SDK 让 AI Agent 可以跑几小时甚至几天，不怕进程重启
2. 失败后从断点恢复，不用从头开始——像游戏存档一样
3. 需要人类确认的步骤可以挂起等待，审批后自动继续

---

## 🍅28 Vercel Agent Stack 与 eve 框架（25分钟）

### 费曼输入

2026 年 6 月的 **Vercel Ship** 大会上，Vercel 发布了完整的 **Agent Stack**——一套端到端的 AI Agent 构建工具集。

**Vercel Agent Stack 组件**：

```
┌─────────────────────────────────┐
│        Vercel Agent Stack        │
├─────────────────────────────────┤
│ AI SDK      — 底层 AI 调用库     │
│ AI Gateway  — 模型路由与管理      │
│ Workflow SDK — 持久化 Agent      │
│ Sandbox     — 安全代码执行       │
│ Chat SDK    — 聊天 UI 组件       │
│ Vercel Connect — 第三方 API 凭证 │
│ eve         — 高级 Agent 框架    │
└─────────────────────────────────┘
```

**eve 框架**（"Next.js for Agents"）：
eve 是 2026 年 6 月新发布的开源 Agent 框架，将 Agent 视为一个**目录结构**（类似 Next.js 的文件系统路由）：

```
my-agent/
├── agent.ts          # 入口：定义 Agent 行为
├── tools/            # 工具目录
│   ├── search.ts
│   ├── code-exec.ts
│   └── send-email.ts
├── skills/           # 技能目录
│   └── expert.ts
├── workflow.ts       # 工作流定义
└── vercel.json       # 部署配置
```

### 刻意练习

```typescript
// 使用 AI SDK 构建一个简单的客服 Agent

// 1. 安装 AI SDK
// npm install ai @ai-sdk/openai

// 2. 创建客服 Agent
import { generateText, tool } from 'ai';
import { openai } from '@ai-sdk/openai';
import { z } from 'zod';

// 定义工具
const tools = {
  searchKnowledgeBase: tool({
    description: '搜索知识库获取答案',
    parameters: z.object({
      query: z.string().describe('搜索关键词'),
    }),
    execute: async ({ query }) => {
      // 在实际应用中，这里连接向量数据库
      return `关于"${query}"的搜索结果...`;
    },
  }),

  createTicket: tool({
    description: '创建客服工单',
    parameters: z.object({
      subject: z.string(),
      priority: z.enum(['low', 'medium', 'high']),
    }),
    execute: async ({ subject, priority }) => {
      return { ticketId: 'TKT-' + Date.now(), status: 'created' };
    },
  }),

  escalateToHuman: tool({
    description: '转接人工客服',
    parameters: z.object({
      reason: z.string(),
    }),
    execute: async ({ reason }) => {
      return { message: '已转接人工客服，预计等待时间 2 分钟' };
    },
  }),
};

// 3. 运行 Agent
async function handleCustomerQuery(userMessage: string) {
  const result = await generateText({
    model: openai('gpt-4o'),
    tools,
    maxSteps: 5,
    prompt: `你是客服 AI 助手。请处理以下用户问题：
    ${userMessage}
    如果需要查资料用 searchKnowledgeBase，
    如果无法解决用 escalateToHuman 转人工。`,
  });

  return result.text;
}

// 4. 部署为 Vercel Function
// api/chat.ts
export async function POST(req: Request) {
  const { message } = await req.json();
  const response = await handleCustomerQuery(message);
  return Response.json({ response });
}
```

### ✅ 完成标准

- [ ] 了解 Vercel Agent Stack 的完整组件
- [ ] 理解 eve 框架的"目录即 Agent"理念
- [ ] 用 AI SDK 构建一个带工具的 Agent
- [ ] 部署 Agent 为 Vercel Function

### 📖 费曼三句话

1. Vercel Agent Stack 是构建 AI Agent 的"全栈工具包"——从底层 SDK 到高级框架
2. eve 是"Next.js for Agents"——像管理页面一样管理 Agent
3. 用 AI SDK + Tools 几分钟就能构建并部署一个 AI Agent

---

## 🍅29 全流程实战：Lovable → Vercel → AI 增强（25分钟）

### 费曼输入

这是本教程的**终极实战**：串联所有模块学到的知识，完成一个从零到上线的完整 AI 应用。

**实战项目**：AI 客服助手

整体流程：

```
1. Lovable 构建前端（注册/登录 + 聊天界面 + 历史记录）→ 带 Supabase 数据库
2. 同步到 GitHub
3. 部署到 Vercel
4. 添加 AI 后端（AI SDK + AI Gateway + Workflow SDK）
5. 生产配置（域名 + Analytics + 监控）
```

### 刻意练习

```bash
# 阶段一：用 Lovable 构建前端
# 在 Lovable 中创建项目，提示词：
"
创建一个 AI 客服聊天应用：
1. 用户注册/登录页面（Supabase Auth）
2. 聊天页面：消息列表 + 输入框 + 发送按钮
3. 历史记录页面：按日期分组的聊天记录
4. 消息数据保存到 Supabase 数据库
5. 使用 shadcn/ui 组件
"

# 阶段二：同步到 GitHub
# Lovable → Settings → GitHub → 确认同步

# 阶段三：部署到 Vercel
# Vercel → Add New → Project → 导入 GitHub 仓库
# 设置环境变量：
VITE_SUPABASE_URL=...
VITE_SUPABASE_PUBLISHABLE_KEY=...
VITE_APP_URL=https://你的项目.vercel.app
GATEWAY_KEY=你的AI_GATEWAY_KEY

# 阶段四：添加 AI 后端
```

```typescript
// api/chat.ts — AI 客服 API
import { openai } from '@ai-sdk/openai';
import { generateText, tool } from 'ai';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.VITE_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_KEY!  // 服务端使用 service_role key
);

export async function POST(req: Request) {
  const { message, userId } = await req.json();

  // 工具：查询历史对话
  const getHistory = tool({
    description: '获取用户的历史对话记录',
    parameters: { userId: { type: 'string' } },
    execute: async ({ userId }) => {
      const { data } = await supabase
        .from('chat_history')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', { ascending: false })
        .limit(10);
      return data;
    },
  });

  // 使用 AI SDK 生成回答
  const result = await generateText({
    model: openai('gpt-4o'),
    tools: { getHistory },
    prompt: message,
  });

  // 保存到数据库
  await supabase.from('messages').insert([
    { user_id: userId, role: 'user', content: message },
    { user_id: userId, role: 'assistant', content: result.text },
  ]);

  return Response.json({ reply: result.text });
}
```

**完整部署检查清单**：

```
☐ Lovable 应用构建完成，功能测试通过
☐ GitHub 仓库同步正常
☐ Vercel 部署成功，页面可访问
☐ Supabase 环境变量配置正确
☐ AI Gateway 已启用，API Key 已配置
☐ AI 后端 API 正常工作
☐ 自定义域名绑定（可选）
☐ Vercel Analytics 已开启
☐ 压力测试通过
```

### ✅ 完成标准

- [ ] 用 Lovable 构建完整的 AI 客服前端
- [ ] 创建 AI 后端 API 并集成到前端
- [ ] 全链路调试：前端 → Vercel → AI Gateway → 响应
- [ ] 完成生产部署检查清单

### 📖 费曼三句话

1. 完整链路：AI 聊天界面（Lovable）→ 部署（Vercel）→ AI 能力（AI SDK + Gateway）
2. 每个模块学到的技能在这个实战中全部串联起来
3. 有了这套流程，从想法到上线的 AI 应用只需要几小时而不是几周

---

## 🍅30 总结与知识体系构建（25分钟）

### 费曼输入

这是本教程最后一个番茄。回顾整个 30🍅 旅程，构建你的 Vercel + AI 知识体系。

### 知识全景图

```
30番茄速通Vercel教程 — 知识体系
│
├── 🏗️ 基础部署（模块0）
│   ├── 账号注册 & CLI 安装
│   ├── Git 仓库导入 & CI/CD
│   ├── vercel.json 配置
│   └── 环境变量 & 域名管理
│
├── 🔧 后端能力（模块A）
│   ├── Serverless Functions（api/目录）
│   ├── Edge Functions + Middleware
│   ├── Fluid Compute（按 CPU 计费）
│   └── Cron Jobs（定时任务）
│
├── ☁️ 云开发环境（模块B）
│   ├── Sandbox 创建 & CLI 操作
│   ├── SDK 编程 & 持久化/快照
│   ├── 网络策略 & 安全隔离
│   └── AI 代码安全执行
│
├── 🤖 AI 代码生成（模块C）
│   ├── v0 提示词工程
│   ├── shadcn/ui 设计系统
│   ├── Git 集成 & 生产部署
│   └── Agent 模式 & 高级用法
│
├── 🚀 全栈 AI 开发（模块D）
│   ├── Lovable 三大模式
│   ├── Supabase 后端集成
│   ├── GitHub 双向同步
│   └── Vercel 部署迁移
│
└── 🧠 AI 基础设施（模块E）
    ├── AI Gateway（模型路由/缓存/成本）
    ├── Workflow SDK（持久化 Agent）
    ├── Agent Stack & eve 框架
    └── 全流程实战
```

### 决策框架

**什么时候用什么工具？**

| 你要做什么 | 用什么 | 模块 |
|:----------|:------|:----:|
| 部署前端项目 | Vercel CLI / Git 导入 | 0 |
| 写后端 API | Serverless / Edge Functions | A |
| 安全执行 AI 代码 | Sandbox | B |
| 生成 React 组件/页面 | v0 | C |
| 构建完整全栈应用 | Lovable | D |
| 加 AI 模型调用 | AI Gateway | E |
| 构建 AI Agent | Workflow SDK / eve | E |
| 定时任务 | Cron Jobs | A |
| 本地模拟线上环境 | `vercel dev` | 0 |

### 刻意练习

```markdown
# 最终练习：自我测试

## 🧠 费曼输出挑战
用三句话向一个完全不懂技术的人解释 Vercel：



## 🛠 综合挑战
能否不翻笔记完成以下操作？
1. 用 `vercel` 命令部署一个项目 □
2. 在 `api/` 下创建一个 API 端点 □
3. 用 Sandbox 执行一段代码 □
4. 在 v0 中生成一个 shadcn/ui 组件 □
5. 用 Lovable 创建一个带数据库的应用 □
6. 配置 AI Gateway □

## 📖 我的 30🍅 费曼三句话
1. 
2. 
3. 
```

### 后续学习路径

| 方向 | 推荐资源 |
|:----|:--------|
| 深入学习 Next.js | Next.js 官方文档 + App Router 教程 |
| Vercel 企业级部署 | Vercel Enterprise 文档 + Team 功能 |
| AI SDK 深入 | Vercel AI SDK 文档 + 示例项目 |
| Supabase 深入 | Supabase 官方文档 + 认证/存储/RLS |
| eve Agent 框架 | eve GitHub 仓库 + Vercel Ship 2026 录像 |
| v0 高级技巧 | v0 官方提示词指南 + 社区模板 |

### 📖 费曼三句话

_——这一格留给你来填，写下你的 30🍅 学习总结_


## 🍅 模块E 综合考核

1. 在 AI Gateway 中配置模型路由（默认 mini，降级 haiku，升级 gpt-4o）
2. 用 Workflow SDK 创建一个"每日新闻摘要"Agent（搜索 → 总结 → 发送邮件）
3. 完成全流程实战：Lovable 前端 + Vercel 部署 + AI Gateway 后端
4. 在模块E末尾写上你的"30🍅费曼三句话"学习总结

**预期耗时**：45-60分钟（2个番茄）
**完成标准**：能独立使用 Vercel 全栈 AI 基础设施构建和部署 AI 应用
