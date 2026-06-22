---
created: 2026-06-19
module: A
total_pomodoros: 5
tags:
  - Vercel
  - Serverless
  - Edge
  - API
  - 教程
---

# 模块A：Vercel Functions 与后端能力（5🍅）

> 目标：掌握 Vercel 的后端能力——从 Serverless Functions 到 Edge Functions、Cron Jobs 和 Fluid Compute

---

## 🍅6 Serverless Functions 基础（Node.js）（25分钟）

### 费曼输入

Vercel Functions 是**无需管理服务器**的后端 API。你在项目中创建 `api/` 文件夹，里面的每个文件自动成为一个 HTTP 端点。Vercel 将其部署为 Serverless 函数——有请求时运行，无请求时休眠，按实际使用计费。

**核心特性**：
- 零配置：`api/hello.ts` → 自动变为 `your-domain.vercel.app/api/hello`
- 支持 Node.js、Python、Go、Ruby 等多种运行时
- Fluid Compute 默认启用：一个实例处理多个并发请求
- 最大超时时间：Hobby 10s / Pro 800s

### 刻意练习

```typescript
// 创建 api/hello.ts
import type { VercelRequest, VercelResponse } from '@vercel/node';

export default function handler(
  request: VercelRequest,
  response: VercelResponse
) {
  const { name } = request.query;

  response.status(200).json({
    message: `Hello ${name || 'World'}!`,
    timestamp: new Date().toISOString(),
    method: request.method
  });
}
```

```bash
# 用 vercel dev 本地测试
vercel dev
# 访问 http://localhost:3000/api/hello?name=Vercel
```

**部署测试**：
```bash
vercel --prod
# 访问 https://你的项目.vercel.app/api/hello
```

### ✅ 完成标准

- [ ] 创建 `api/hello.ts` 并本地测试通过
- [ ] 部署后 API 端点可访问
- [ ] 理解请求对象（query/body/headers）和响应对象（status/json）
- [ ] 了解 Fluid Compute 的基本概念

### 📖 费曼三句话

1. 在项目里创建 api/ 文件夹，里面的文件自动变成 API 接口
2. Serverless = 有请求时运行，没请求时睡觉，只为你用的时间付费
3. `vercel dev` 可以在本地调试 API，体验和线上一样

---

## 🍅7 API 路由与请求处理（25分钟）

### 费曼输入

实际 API 需要处理多种 HTTP 方法（GET/POST/PUT/DELETE）、读取请求体、返回错误等。Vercel Functions 使用标准的 `Request`/`Response` Web API。

### 刻意练习

```typescript
// api/todos.ts — 简易待办 API
type Todo = {
  id: string;
  text: string;
  completed: boolean;
  createdAt: string;
};

let todos: Todo[] = [
  { id: '1', text: '学习 Vercel Functions', completed: false, createdAt: new Date().toISOString() }
];

export default async function handler(req: VercelRequest, res: VercelResponse) {
  switch (req.method) {
    case 'GET':
      // 获取列表
      return res.status(200).json({ todos });

    case 'POST':
      // 创建待办
      const { text } = req.body;
      if (!text) return res.status(400).json({ error: 'text is required' });

      const newTodo: Todo = {
        id: String(Date.now()),
        text,
        completed: false,
        createdAt: new Date().toISOString()
      };
      todos.push(newTodo);
      return res.status(201).json(newTodo);

    case 'PUT':
      // 更新待办
      const { id, completed: isCompleted } = req.body;
      const todo = todos.find(t => t.id === id);
      if (!todo) return res.status(404).json({ error: 'todo not found' });
      todo.completed = isCompleted ?? todo.completed;
      return res.status(200).json(todo);

    case 'DELETE':
      // 删除待办
      const { id: deleteId } = req.body;
      todos = todos.filter(t => t.id !== deleteId);
      return res.status(200).json({ success: true });

    default:
      res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
      return res.status(405).end(`Method ${req.method} Not Allowed`);
  }
}
```

### ✅ 完成标准

- [ ] 实现 GET/POST/PUT/DELETE 四种方法处理
- [ ] 理解请求体验证和错误处理
- [ ] 用 `curl` 或 Postman 测试所有端点
- [ ] 理解 400/404/405 等状态码的使用场景

### 📖 费曼三句话

1. API 的核心就是"收到请求 → 处理数据 → 返回响应"这个循环
2. 不同 HTTP 方法（GET/POST/PUT/DELETE）对应不同的操作（查/增/改/删）
3. 好的 API 要有正确的状态码和错误信息，让调用方知道发生了什么

---

## 🍅8 Edge Functions 入门（25分钟）

### 费曼输入

Edge Functions 在 Vercel 的**全球边缘节点**运行，离用户最近，延迟最低。适合轻量级、对速度敏感的逻辑：

- 请求重写/重定向
- A/B 测试
- 认证检查
- 个性化（根据地理位置定制内容）
- 机器人检测

**Edge vs Serverless 对比**：

| 维度 | Serverless Functions | Edge Functions |
|:-----|:--------------------|:---------------|
| 运行位置 | 区域数据中心 | 全球边缘节点(100+位置) |
| 运行时 | Node.js (完整 API) | Edge Runtime (Web API 子集) |
| 超时时间 | 10s(Hobby) ~ 800s(Pro) | 30s |
| 适用场景 | 数据库操作、重计算 | 轻量请求处理、中间件 |
| 并发 | Fluid Compute | 单实例单请求 |

### 刻意练习

```typescript
// middleware.ts — 在项目根目录创建
// 这个中间件在每个请求到达页面之前执行
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const country = request.geo?.country || 'unknown';
  const city = request.geo?.city || 'unknown';

  // 添加响应头
  const response = NextResponse.next();
  response.headers.set('X-Country', country);
  response.headers.set('X-City', city);

  // A/B 测试：50% 用户看到新版
  if (request.nextUrl.pathname === '/') {
    const ab = Math.random() > 0.5 ? 'a' : 'b';
    response.headers.set('X-Ab-Test', ab);
  }

  return response;
}

export const config = {
  matcher: ['/', '/api/:path*']  // 匹配的路径
};
```

### ✅ 完成标准

- [ ] 理解 Edge Functions 和 Serverless Functions 的区别
- [ ] 创建中间件添加自定义响应头
- [ ] 理解 `matcher` 配置控制哪些路径经过中间件
- [ ] 知道 Edge Functions 适合哪些场景

### 📖 费曼三句话

1. Edge Functions 在"离用户最近的地方"运行，延迟极低
2. 适合轻量任务：重定向、A/B测试、认证——不适合数据库操作
3. middleware.ts 是每个请求都经过的"安检门"

---

## 🍅9 Fluid Compute 与性能优化（25分钟）

### 费曼输入

**Fluid Compute** 是 Vercel 2025 年推出的新计算模型，现在是所有 Vercel Functions 的默认模式。

传统 Serverless：每个请求启动一个独立实例 → 并发请求 → 多个实例
Fluid Compute：一个实例处理多个并发请求 → 减少冷启动 → 节省成本

**定价模式变化**：
- 以前：按实例运行时间计费
- Fluid：按 Active CPU 时长计费（CPU 实际工作时间）
- 等待 I/O（数据库查询、网络请求）不计费 → 成本降低 30-70%

### 刻意练习

```typescript
// 验证 Fluid Compute 的并发处理
// api/fluid-demo.ts
export default async function handler(
  request: VercelRequest,
  response: VercelResponse
) {
  const start = Date.now();

  // 模拟数据库查询（I/O 等待）
  await new Promise(resolve => setTimeout(resolve, 2000));

  const duration = Date.now() - start;
  response.status(200).json({
    message: 'Fluid Compute demo',
    instanceId: process.env.VERCEL_INSTANCE_ID || 'unknown',
    duration: `${duration}ms`
  });
}
```

**性能优化最佳实践**：

| 策略 | 方法 | 效果 |
|:-----|:-----|:-----|
| 减少冷启动 | 使用 Node.js 运行时（比 Python 更快） | 启动时间 <100ms |
| 连接复用 | 在模块层面创建数据库连接 | 避免每次请求新建连接 |
| 缓存 | 用 `Cache-Control` 头做响应缓存 | 减少重复计算 |
| 最小化包 | 只引入需要的依赖 | 减小部署包大小 |
| 函数配置 | 调整 memory 和 maxDuration | 匹配实际需求 |

### ✅ 完成标准

- [ ] 理解 Fluid Compute 的工作原理和定价优势
- [ ] 部署一个验证并发处理的函数
- [ ] 了解至少 3 个性能优化策略
- [ ] 能配置函数的 memory 和 maxDuration

### 📖 费曼三句话

1. Fluid Compute = 一个函数实例同时服务多个请求，省去了"每人开一台服务器"的浪费
2. 按 CPU 实际工作时间付费，等数据库的时候不扣钱
3. 减少冷启动和做缓存是提升性能最有效的两个手段

---

## 🍅10 Cron Jobs 定时任务（25分钟）

### 费曼输入

Cron Jobs 允许你定时触发 Vercel Functions，就像 Linux 的 crontab。适用于：

- 每天发送日报/周报邮件
- 定时数据备份
- 定期清理过期数据
- 定时抓取外部数据

### 刻意练习

```typescript
// api/cron/daily-report.ts
export default async function handler(
  request: VercelRequest,
  response: VercelResponse
) {
  // 验证请求来源（安全：检查 cron 密钥）
  const authHeader = request.headers.authorization;
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return response.status(401).json({ error: 'Unauthorized' });
  }

  // 执行定时任务
  console.log('📊 Daily report generated at:', new Date().toISOString());

  // 模拟发送报告
  // await sendEmailReport();

  response.status(200).json({ success: true, timestamp: new Date().toISOString() });
}
```

```json
// 在 vercel.json 中添加 cron 配置
{
  "crons": [
    { "path": "/api/cron/daily-report", "schedule": "0 8 * * *" },
    { "path": "/api/cron/cleanup", "schedule": "0 2 * * 0" },
    { "path": "/api/cron/health-check", "schedule": "*/5 * * * *" }
  ]
}
```

**Cron 语法速查**：

```
* * * * *
│ │ │ │ │
│ │ │ │ └── 星期(0-7, 0/7=周日)
│ │ │ └──── 月份(1-12)
│ │ └────── 日期(1-31)
│ └──────── 小时(0-23)
└────────── 分钟(0-59)
```

| 示例 | 说明 |
|:----|:-----|
| `*/5 * * * *` | 每 5 分钟 |
| `0 8 * * *` | 每天早上 8 点 |
| `0 9 * * 1-5` | 工作日早上 9 点 |
| `0 0 1 * *` | 每月 1 号凌晨 |
| `0 */6 * * *` | 每 6 小时 |

### ✅ 完成标准

- [ ] 理解 Cron 表达式语法
- [ ] 创建带认证验证的 Cron 函数
- [ ] 在 vercel.json 中配置 cron 任务
- [ ] 部署后验证定时任务触发

### 📖 费曼三句话

1. Cron Jobs 就是 Vercel 上的"闹钟"——到点了自动执行函数
2. 五个星号分别表示：分钟/小时/日期/月份/星期
3. 一定要加认证验证，防止别人恶意触发你的定时任务

---

## 🍅 模块A 综合考核

1. 创建一个完整的 RESTful API（CRUD），主题自选（博客/备忘录/收藏夹）
2. 添加一个 Edge Middleware 做访问日志记录
3. 配置一个每天上午 9 点的 Cron Job 执行数据统计
4. 写三句话总结 Serverless Functions 和 Edge Functions 的选择策略

**预期耗时**：45-60分钟（2个番茄）
**完成标准**：一个完整的 API 项目，包含 CRUD + 中间件 + 定时任务
