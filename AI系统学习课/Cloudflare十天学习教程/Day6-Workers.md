# Day 6：Cloudflare Workers 无服务器函数

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 Workers 编写，实现边缘计算
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Workers 原理
🍅 番茄3-4：编写第一个 Worker
🍅 番茄5-6：路由与 KV 存储
🍅 番茄7-8：API 开发 + 复习输出
```

---

## 番茄钟1：理解 Workers

### 1.1 用大白话理解 Workers

**Workers 是什么？**

想象你的代码是**快递员**：

| 传统服务器 | Cloudflare Workers |
|:-----------|:-------------------|
| 快递员坐在中央仓库 | 快递员在每个城市都有 |
| 订单来了从中央出发 | 就近立即响应 |
| 延迟高 | 延迟极低 |

**Workers = 在全球边缘节点运行的 JavaScript/TypeScript 代码**

### 1.2 Workers 的优势

| 优势 | 说明 |
|:-----|:-----|
| **极低延迟** | 代码在离用户最近的节点运行 |
| **无限扩展** | 自动扩展，无需管理服务器 |
| **成本低** | 免费额度 10万次请求/天 |
| **多语言** | JavaScript/TypeScript/Rust/Wasm |
| **全栈能力** | 可以做 API、定时任务、中间件 |

### 1.3 Workers 应用场景

```
┌─────────────────────────────────────────────────────────────┐
│                    Workers 应用场景                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🌐 API 网关                                                 │
│  ├── 请求转发、认证、限流                                    │
│  └── 替代传统 API 网关                                       │
│                                                             │
│  🔄 边缘计算                                                 │
│  ├── A/B 测试                                               │
│  ├── 个性化内容                                              │
│  └── 智能路由                                                │
│                                                             │
│  ⚡ 后端服务                                                  │
│  ├── REST API                                               │
│  ├── GraphQL                                                │
│  └── Webhook 处理                                           │
│                                                             │
│  ⏰ 定时任务                                                  │
│  ├── Cron 触发                                              │
│  └── 数据同步                                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

> ✋ **费曼自测**：解释 Workers 为什么比传统服务器延迟更低。

---

## 番茄钟2：Workers 运行原理

### 2.1 V8 Isolate

**Workers 使用 V8 Isolate 而非容器：**

| 对比 | 传统容器 | Workers |
|:-----|:---------|:--------|
| 启动时间 | 秒级 | 毫秒级 |
| 内存占用 | MB 级 | KB 级 |
| 隔离方式 | 容器 | Isolate |
| 冷启动 | 慢 | 几乎无 |

### 2.2 请求处理流程

```
用户请求
    ↓
最近的边缘节点
    ↓
Worker 执行
    ├── 处理请求
    ├── 调用外部 API
    ├── 读写 KV
    └── 返回响应
    ↓
返回给用户

整个过程 < 50ms
```

### 2.3 Workers 限制

| 限制 | 免费版 | 付费版 |
|:-----|:-------|:-------|
| CPU 时间 | 10ms | 50ms+ |
| 内存 | 128MB | 128MB |
| 请求数 | 10万/天 | 无限 |
| 脚本大小 | 1MB | 10MB |

> ✋ **费曼自测**：Workers 与传统容器有什么区别？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Workers 在边缘节点运行代码
- [ ] 使用 V8 Isolate，启动极快
- [ ] 适合 API、边缘计算、定时任务

---

## 番茄钟3：创建第一个 Worker

### 3.1 通过 Dashboard 创建

```
Workers & Pages → Create → Hello World

1. 输入 Worker 名称：my-worker
2. 点击 "Deploy"
3. 默认代码自动部署
4. 获得访问地址：my-worker.你的账号.workers.dev
```

### 3.2 Worker 代码结构

```javascript
// 最简单的 Worker
export default {
  async fetch(request, env, ctx) {
    return new Response("Hello World!");
  },
};
```

### 3.3 处理不同请求

```javascript
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // 路由处理
    if (url.pathname === "/api/hello") {
      return new Response(JSON.stringify({
        message: "Hello from Worker!"
      }), {
        headers: { "Content-Type": "application/json" }
      });
    }
    
    if (url.pathname === "/api/time") {
      return new Response(JSON.stringify({
        time: new Date().toISOString()
      }), {
        headers: { "Content-Type": "application/json" }
      });
    }
    
    // 404 处理
    return new Response("Not Found", { status: 404 });
  },
};
```

### 3.4 刻意练习任务

```markdown
## 创建第一个 Worker

- [ ] 在 Dashboard 创建 Worker
- [ ] 修改返回内容
- [ ] 访问测试
- [ ] 添加一个 /api/time 路由
```

> ✋ **费曼自测**：创建一个返回当前时间的 Worker。

---

## 番茄钟4：本地开发 Worker

### 4.1 使用 Wrangler

```bash
# 创建项目
npm create cloudflare@latest my-worker

# 选择模板
# - Hello World（简单示例）
# - Router（路由示例）
# - Hono（框架）

# 进入项目
cd my-worker

# 本地开发
wrangler dev
```

### 4.2 项目结构

```
my-worker/
├── src/
│   └── index.js      # Worker 代码
├── wrangler.toml     # 配置文件
└── package.json
```

### 4.3 wrangler.toml 配置

```toml
name = "my-worker"
main = "src/index.js"
compatibility_date = "2024-01-01"

# 路由绑定
routes = [
  { pattern = "api.example.com/*", zone_name = "example.com" }
]

# KV 绑定
[[kv_namespaces]]
binding = "MY_KV"
id = "xxx"

# 环境变量
[vars]
API_KEY = "xxx"
```

### 4.4 部署 Worker

```bash
# 部署到生产环境
wrangler deploy

# 查看日志
wrangler tail
```

> ✋ **费曼自测**：使用 Wrangler 本地开发并部署一个 Worker。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] Worker 创建成功
- [ ] 本地开发环境配置完成
- [ ] 成功部署

---

## 番茄钟5：路由配置

### 5.1 自定义域名绑定

```
Workers → 选择 Worker → Settings → Triggers

添加路由：
- 路由：api.example.com/*
- 区域：example.com

或添加自定义域名：
- 域名：api.example.com
```

### 5.2 路由模式

| 模式 | 匹配规则 | 示例 |
|:-----|:---------|:-----|
| 精确匹配 | `api.example.com/hello` | 只匹配这个路径 |
| 通配符 | `api.example.com/*` | 匹配所有子路径 |
| 参数匹配 | `api.example.com/:id` | 捕获路径参数 |

### 5.3 使用框架简化路由

**Hono 框架示例：**

```javascript
import { Hono } from 'hono';

const app = new Hono();

app.get('/hello', (c) => {
  return c.json({ message: 'Hello!' });
});

app.get('/user/:id', (c) => {
  const id = c.req.param('id');
  return c.json({ userId: id });
});

app.post('/data', async (c) => {
  const body = await c.req.json();
  return c.json({ received: body });
});

export default app;
```

> ✋ **费曼自测**：配置一个自定义域名绑定到你的 Worker。

---

## 番茄钟6：KV 存储使用

### 6.1 创建 KV 命名空间

```
Workers → KV → Create namespace

输入名称：my-kv
```

### 6.2 绑定 KV 到 Worker

```
Workers → 选择 Worker → Settings → Variables

KV Namespace Bindings:
- 变量名：MY_KV
- KV 命名空间：my-kv
```

### 6.3 在代码中使用 KV

```javascript
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // 读取数据
    if (url.pathname === "/get") {
      const value = await env.MY_KV.get("my-key");
      return new Response(value || "Not found");
    }
    
    // 写入数据
    if (url.pathname === "/set") {
      await env.MY_KV.put("my-key", "Hello KV!");
      return new Response("Saved!");
    }
    
    return new Response("Use /get or /set");
  },
};
```

### 6.4 KV 操作命令

| 操作 | 方法 | 示例 |
|:-----|:-----|:-----|
| 读取 | `get(key)` | `await kv.get("key")` |
| 写入 | `put(key, value)` | `await kv.put("key", "value")` |
| 删除 | `delete(key)` | `await kv.delete("key")` |
| 列表 | `list()` | `await kv.list()` |

### 6.5 刻意练习任务

```markdown
## KV 存储实践

- [ ] 创建 KV 命名空间
- [ ] 绑定到 Worker
- [ ] 实现 /set 和 /get 接口
- [ ] 测试数据读写
```

> ✋ **费曼自测**：实现一个简单的计数器 API（每次访问 +1）。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 自定义域名绑定成功
- [ ] KV 存储读写正常

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**Workers 速记：**

```
Workers = 边缘运行的 JavaScript

特点：
- 极低延迟（边缘执行）
- 无限扩展（自动扩容）
- 成本低（免费10万次/天）

核心组件：
- 请求处理
- 路由配置
- KV 存储
- 环境变量
```

### 7.2 代码模板

```javascript
// 基本 Worker 模板
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // 路由处理
    if (url.pathname === "/api/hello") {
      return new Response("Hello!");
    }
    
    // KV 操作
    const value = await env.MY_KV.get("key");
    
    return new Response(value || "Not found");
  },
};
```

### 7.3 常用命令

| 命令 | 功能 |
|:-----|:-----|
| `wrangler dev` | 本地开发 |
| `wrangler deploy` | 部署 |
| `wrangler tail` | 查看日志 |
| `wrangler kv:key put` | 写入 KV |
| `wrangler kv:key get` | 读取 KV |

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 6

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
Workers 让代码在边缘节点运行，实现极低延迟的 Serverless 服务。

## 关键要点

### 1. Workers 原理
- V8 Isolate 隔离
- 毫秒级启动
- 边缘执行

### 2. 开发部署
- Wrangler CLI
- 本地开发
- 一键部署

### 3. 数据存储
- KV 键值存储
- 全局复制
- 低延迟访问

## 明日计划
- 学习 GitHub Actions 联动
- 实现 CI/CD 自动部署
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 Workers 原理
- [ ] **番茄3-4**：创建并部署 Worker
- [ ] **番茄5-6**：配置路由和 KV
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 6 完成！

**今日成果：**
- ✅ 理解 Workers 原理
- ✅ 创建并部署 Worker
- ✅ 掌握 KV 存储

**明天预告：** [[Day7-GitHub联动]] - 学习 GitHub Actions 自动部署

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day5-Pages部署]] - 上一天内容
