# Day 5：Webhook 与外部集成

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：用 Webhook 构建 API 服务，实现双向数据流
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：Webhook 深度理解 + Webhook Trigger 详细配置
🍅 番茄3-4：构建 REST API 服务 + Respond to Webhook 节点
🍅 番茄5-6：安全与最佳实践 + 实战：PDF 转 Markdown Webhook 服务
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：Webhook 深度理解（25分钟）

### 1.1 用大白话理解 Webhook

Webhook 就是「反向 API 调用」——

**传统 API 调用**：你去餐厅，每隔5分钟问一次「饭好了吗？」
**Webhook**：你先留下电话号码，饭做好了餐厅主动打给你

| | 传统 API（轮询） | Webhook（回调） |
|---|---|---|
| 类比 | 你打电话问餐厅 | 餐厅做好了打给你 |
| 谁主动 | 你（客户端） | 服务器 |
| 方式 | 反复请求 | 等通知 |
| 效率 | 低（大部分请求白费） | 高（有事件才通知） |
| 实时性 | 取决于轮询间隔 | 事件发生即通知 |

> 再举一个例子：快递柜
> - **轮询** = 你每隔10分钟下楼看快递到了没有
> - **Webhook** = 快递到了，柜子给你发短信

### 1.2 Webhook 在 n8n 中的角色

n8n 中的 Webhook 让你的工作流变成一个 **HTTP API 服务**——外部系统只要往一个 URL 发请求，就能触发工作流执行。

```
外部世界                     n8n
┌──────────────┐          ┌──────────────────────────┐
│  Python 脚本  │ ──POST──→ │  Webhook Trigger          │
│  前端页面     │ ──POST──→ │  → 处理数据 → 返回结果    │
│  另一个 n8n   │ ──POST──→ │  → 调用 AI → 返回回答    │
│  GitHub      │ ──POST──→ │  → 解析事件 → 发通知      │
└──────────────┘          └──────────────────────────┘
```

**Webhook 的三大用途**：

| 用途 | 说明 | 例子 |
|------|------|------|
| **接收数据** | 外部系统推送数据到 n8n | GitHub push 事件触发部署 |
| **提供 API** | 把工作流变成可调用的服务 | PDF 转 Markdown API |
| **连接系统** | 让不同系统通过 HTTP 互通 | Slack 通知 → n8n → Notion 记录 |

### 1.3 Webhook vs 普通 Trigger

| 触发方式 | 谁触发 | 适合场景 |
|----------|--------|----------|
| Manual Trigger | 你手动点按钮 | 测试、调试 |
| Schedule Trigger | 定时器 | 周期性任务 |
| **Webhook Trigger** | **外部 HTTP 请求** | **事件驱动、API 服务** |
| Email Trigger | 收到邮件 | 邮件自动化 |

> ✋ **费曼自测**：用你自己的话，向不懂技术的人解释 Webhook 是什么，它和普通 API 调用有什么区别。

---

## 番茄钟2：Webhook Trigger 详细配置（25分钟）

### 2.1 添加 Webhook Trigger

1. 创建新工作流，命名为 `Webhook Demo`
2. 点击画布中央 `+`，搜索 `Webhook`，选择 **Webhook Trigger**
3. 观察：节点上会显示一个 **Webhook URL**（生产 URL 和测试 URL）

### 2.2 Webhook 配置详解

点击 Webhook 节点，进入参数面板：

#### 核心配置项

| 配置项 | 选项 | 说明 |
|--------|------|------|
| **HTTP Method** | GET / POST / PUT / DELETE / PATCH | 请求方法 |
| **Path** | 自定义字符串 | API 路径，如 `user-register` |
| **Response Mode** | On Received / Last Node / Using Respond Node | 响应方式 |
| **Authentication** | None / Header Auth / Basic Auth 等 | 安全认证 |

#### HTTP Method 选择指南

| Method | 用途 | 幂等性 | 例子 |
|--------|------|--------|------|
| `GET` | 查询数据 | ✅ 幂等 | 获取用户信息 |
| `POST` | 创建数据 | ❌ 非幂等 | 注册新用户 |
| `PUT` | 全量更新 | ✅ 幂等 | 替换用户资料 |
| `PATCH` | 部分更新 | ❌ 非幂等 | 修改用户昵称 |
| `DELETE` | 删除数据 | ✅ 幂等 | 删除用户 |

#### Response Mode 详解

| 模式 | 行为 | 适用场景 |
|------|------|----------|
| **On Received** | 收到请求立即返回固定响应 | 只需要确认收到（如通知类） |
| **Last Node** | 等工作流执行完，返回最后一个节点的输出 | 简单 API，快速返回结果 |
| **Using 'Respond to Webhook' Node** | 工作流中用专门节点控制响应 | 复杂逻辑，需要自定义响应内容 |

**用大白话理解 Response Mode**：

- **On Received** = 快递员把包裹放下就走，不等你拆
- **Last Node** = 快递员等你拆完包裹，把里面东西告诉他
- **Using Respond to Webhook** = 你写好回信，让快递员带回去

### 2.3 第一个 Webhook 工作流

创建一个最简单的 Webhook 服务：收到请求 → 返回问候语

```
Webhook Trigger (GET /hello) → Edit Fields (Set)
```

**Webhook 节点配置**：

| 字段 | 值 |
|------|-----|
| HTTP Method | `GET` |
| Path | `hello` |
| Response Mode | `Last Node` |

**Set 节点配置**：

| Name | Value | 类型 |
|------|-------|------|
| `message` | `Hello from n8n Webhook!` | String |
| `time` | `={{ $now.toISO() }}` | String |

**测试方法**：

1. 点击 Webhook 节点上的 **Listen for Test Event** 按钮（重要！否则收不到测试请求）
2. 打开浏览器访问测试 URL

或使用 curl：

```bash
# 测试 URL（点击 Listen for Test Event 后显示）
curl http://localhost:5678/webhook-test/hello

# 生产 URL（工作流激活后可用）
curl http://localhost:5678/webhook/hello
```

**预期响应**：

```json
{
  "message": "Hello from n8n Webhook!",
  "time": "2026-06-08T10:30:00.000Z"
}
```

### 2.4 接收请求数据

Webhook 收到的所有数据都存在节点的输出中：

```
Webhook 输出结构:
{
  "json": {
    "headers": { ... },        ← 请求头
    "params": { ... },         ← URL 查询参数
    "body": { ... },           ← 请求体
    "query": { ... }           ← 同 params（别名）
  },
  "binary": { ... }            ← 上传的文件
}
```

**接收不同类型数据的方式**：

| 数据类型 | 请求方式 | n8n 中访问 |
|----------|----------|------------|
| URL 参数 | `GET /hello?name=张三` | `{{ $json.query.name }}` |
| 表单数据 | `POST` + `application/x-www-form-urlencoded` | `{{ $json.body.name }}` |
| JSON 数据 | `POST` + `application/json` | `{{ $json.body.name }}` |
| 请求头 | 任意 | `{{ $json.headers['x-custom'] }}` |
| 文件上传 | `POST` + `multipart/form-data` | `{{ $binary.file }}` |

**示例：接收查询参数**

将上面的 GET /hello 改造为接收 name 参数：

Set 节点 Value 改为：

| Name | Value |
|------|-------|
| `message` | `={{ "Hello, " + $json.query.name + "!" }}` |

测试：

```bash
curl "http://localhost:5678/webhook-test/hello?name=张三"
```

响应：

```json
{
  "message": "Hello, 张三!"
}
```

> ✋ **费曼自测**：Webhook 的三种 Response Mode 分别是什么？各适合什么场景？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Webhook 是「反向 API 调用」——服务器主动通知，而非客户端轮询
- [ ] Webhook 让 n8n 工作流变成可调用的 HTTP API 服务
- [ ] 三种 Response Mode：On Received / Last Node / Using Respond to Webhook
- [ ] 能区分 query 参数、body 数据、headers、文件上传的访问方式
- [ ] 知道测试 URL（webhook-test）和生产 URL（webhook）的区别

---

## 番茄钟3：构建 REST API 服务（25分钟）

### 3.1 用大白话理解 REST API

REST API 就像「餐厅菜单」——

| REST 概念 | 餐厅类比 | 说明 |
|-----------|----------|------|
| URL 路径 | 菜品编号 | 定位资源，如 `/users/123` |
| HTTP Method | 操作类型 | 点菜（POST）、查单（GET）、改单（PUT）、取消（DELETE） |
| 请求体 | 具体要求 | 「少辣」「加蛋」→ JSON 数据 |
| 响应 | 上菜 | 做好的菜 → JSON 结果 |
| 状态码 | 叫号结果 | 200=上菜成功、404=没这道菜、500=厨房炸了 |

### 3.2 构建「用户注册 API」

创建一个完整的用户注册服务：

```
Webhook (POST /user-register) → Code (验证数据) → IF (数据有效?) → Set (成功响应) → Respond to Webhook
                                                                    └→ Set (错误响应) → Respond to Webhook
```

#### 第一步：Webhook 节点

| 字段 | 值 |
|------|-----|
| HTTP Method | `POST` |
| Path | `user-register` |
| Response Mode | `Using 'Respond to Webhook' Node` |

> 为什么选 Respond to Webhook？因为我们需要根据验证结果返回不同的响应（成功/失败）。

#### 第二步：Code 节点（验证数据）

```javascript
// 获取请求体数据
const body = $input.first().json.body;

// 验证必填字段
const errors = [];
if (!body.name || body.name.trim() === '') {
  errors.push('姓名不能为空');
}
if (!body.email || !body.email.includes('@')) {
  errors.push('邮箱格式不正确');
}
if (!body.age || body.age < 1 || body.age > 150) {
  errors.push('年龄必须在1-150之间');
}

// 生成用户ID
const userId = 'user_' + Date.now();

// 返回验证结果
return {
  json: {
    valid: errors.length === 0,
    errors: errors,
    user: {
      id: userId,
      name: body.name,
      email: body.email,
      age: body.age
    }
  }
};
```

#### 第三步：IF 节点

| 字段 | 值 |
|------|-----|
| Condition | `{{ $json.valid }}` equals `true` |

#### 第四步：成功分支 — Set 节点

命名为「成功响应」：

| Name | Value | 类型 |
|------|-------|------|
| `success` | `true` | Boolean |
| `message` | `用户注册成功` | String |
| `userId` | `={{ $json.user.id }}` | String |
| `userName` | `={{ $json.user.name }}` | String |

#### 第五步：失败分支 — Set 节点

命名为「错误响应」：

| Name | Value | 类型 |
|------|-------|------|
| `success` | `false` | Boolean |
| `message` | `注册失败` | String |
| `errors` | `={{ $json.errors }}` | String |

#### 第六步：两个 Respond to Webhook 节点

成功分支的 Respond to Webhook：

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `200` |

失败分支的 Respond to Webhook：

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `400` |

### 3.3 测试用户注册 API

**成功请求**：

```bash
curl -X POST http://localhost:5678/webhook-test/user-register \
  -H "Content-Type: application/json" \
  -d '{"name": "张三", "email": "zhang@test.com", "age": 25}'
```

**预期成功响应（200）**：

```json
{
  "success": true,
  "message": "用户注册成功",
  "userId": "user_1749369000000",
  "userName": "张三"
}
```

**失败请求**（缺少字段）：

```bash
curl -X POST http://localhost:5678/webhook-test/user-register \
  -H "Content-Type: application/json" \
  -d '{"name": "", "email": "invalid", "age": 200}'
```

**预期失败响应（400）**：

```json
{
  "success": false,
  "message": "注册失败",
  "errors": "姓名不能为空,邮箱格式不正确,年龄必须在1-150之间"
}
```

> ✋ **费曼自测**：为什么不使用 Last Node 模式，而选择 Respond to Webhook 模式来构建这个 API？

---

## 番茄钟4：Respond to Webhook 节点深入（25分钟）

### 4.1 Respond to Webhook 的三种响应方式

| 方式 | 配置 | 适用场景 |
|------|------|----------|
| **JSON** | Respond With = JSON，直接写 JSON | 大多数 API 服务 |
| **Text** | Respond With = Text，返回纯文本 | 简单确认消息 |
| **Binary** | Respond With = Binary，返回文件 | 图片/PDF 下载 |
| **Redirect** | Respond With = Redirect，跳转到 URL | 支付回调、OAuth |

### 4.2 JSON 响应的最佳实践

**好的 API 响应结构**：

```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "name": "张三"
  },
  "message": "操作成功",
  "timestamp": "2026-06-08T10:30:00.000Z"
}
```

**好的错误响应结构**：

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "邮箱格式不正确",
    "details": ["email 字段缺少 @ 符号"]
  },
  "timestamp": "2026-06-08T10:30:00.000Z"
}
```

### 4.3 HTTP 状态码速查

| 状态码 | 含义 | 何时使用 |
|--------|------|----------|
| `200` | OK | 请求成功 |
| `201` | Created | 资源创建成功 |
| `400` | Bad Request | 请求数据有误 |
| `401` | Unauthorized | 未认证 |
| `403` | Forbidden | 无权限 |
| `404` | Not Found | 资源不存在 |
| `429` | Too Many Requests | 请求过于频繁 |
| `500` | Internal Server Error | 服务器内部错误 |

### 4.4 用 Code 节点构建响应（推荐方式）

在 Respond to Webhook 之前，用 Code 节点统一组装响应格式：

```javascript
// 统一响应格式
const isSuccess = $input.first().json.valid;

if (isSuccess) {
  return {
    json: {
      success: true,
      data: $input.first().json.user,
      message: '操作成功',
      timestamp: new Date().toISOString()
    }
  };
} else {
  return {
    json: {
      success: false,
      error: {
        code: 'VALIDATION_ERROR',
        message: $input.first().json.errors.join('; '),
        details: $input.first().json.errors
      },
      timestamp: new Date().toISOString()
    }
  };
}
```

然后 Respond to Webhook 节点只需配置：

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `={{ $json.success ? 200 : 400 }}` |

### 4.5 处理文件上传

Webhook 可以接收通过 `multipart/form-data` 上传的文件：

**Webhook 节点配置**：

| 字段 | 值 |
|------|-----|
| HTTP Method | `POST` |
| Path | `upload` |
| Response Mode | `Using 'Respond to Webhook' Node` |

**上传文件测试**：

```bash
curl -X POST http://localhost:5678/webhook-test/upload \
  -F "file=@/path/to/document.pdf" \
  -F "description=测试文件上传"
```

**在 n8n 中访问上传的文件**：

| 表达式 | 含义 |
|--------|------|
| `{{ $binary.file.data }}` | 文件内容（base64） |
| `{{ $binary.file.mimeType }}` | 文件 MIME 类型 |
| `{{ $binary.file.fileName }}` | 原始文件名 |
| `{{ $binary.file.fileSize }}` | 文件大小 |
| `{{ $json.body.description }}` | 其他表单字段 |

**返回文件信息**：

```javascript
const fileInfo = $input.first();
const file = fileInfo.binary?.file;

if (!file) {
  return {
    json: {
      success: false,
      error: { code: 'NO_FILE', message: '未收到文件' }
    }
  };
}

return {
  json: {
    success: true,
    data: {
      fileName: file.fileName,
      mimeType: file.mimeType,
      fileSize: file.fileSize
    },
    message: '文件上传成功'
  }
};
```

### 4.6 多种编程语言调用 Webhook 示例

**Python**：

```python
import requests

# GET 请求
response = requests.get("http://localhost:5678/webhook/hello", params={"name": "张三"})
print(response.json())

# POST JSON 数据
response = requests.post(
    "http://localhost:5678/webhook/user-register",
    json={"name": "张三", "email": "zhang@test.com", "age": 25}
)
print(response.json())

# POST 上传文件
with open("document.pdf", "rb") as f:
    response = requests.post(
        "http://localhost:5678/webhook/upload",
        files={"file": f},
        data={"description": "测试文件"}
    )
print(response.json())
```

**JavaScript (Node.js)**：

```javascript
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

// GET 请求
const getResult = await axios.get('http://localhost:5678/webhook/hello', {
  params: { name: '张三' }
});
console.log(getResult.data);

// POST JSON 数据
const postResult = await axios.post(
  'http://localhost:5678/webhook/user-register',
  { name: '张三', email: 'zhang@test.com', age: 25 }
);
console.log(postResult.data);

// POST 上传文件
const form = new FormData();
form.append('file', fs.createReadStream('./document.pdf'));
form.append('description', '测试文件');

const uploadResult = await axios.post(
  'http://localhost:5678/webhook/upload',
  form,
  { headers: form.getHeaders() }
);
console.log(uploadResult.data);
```

> ✋ **费曼自测**：Webhook 收到上传文件后，如何获取文件名和文件内容？HTTP 状态码 400 和 500 分别表示什么？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 能构建包含验证逻辑的 REST API 服务
- [ ] 理解 Respond to Webhook 的四种响应方式
- [ ] 知道如何统一 API 响应格式
- [ ] 能用 curl / Python / JavaScript 调用 Webhook
- [ ] 理解文件上传的处理方式

---

## 番茄钟5：Webhook 安全与最佳实践（25分钟）

### 5.1 用大白话理解 Webhook 安全

Webhook 就像「你家大门」——

| 安全措施 | 类比 | 防什么 |
|----------|------|--------|
| API Key 认证 | 门锁 + 钥匙 | 陌生人随意进入 |
| 签名验证 | 防伪标签 | 伪造请求 |
| IP 白名单 | 小区门禁 | 外部人员 |
| 限流 | 排队取号 | 暴力攻击 |

没有安全措施的 Webhook = 敞开的大门，任何人都可以往你的 API 发请求！

### 5.2 安全措施一：API Key 认证

**步骤 1：创建 Header Auth 凭证**

1. 进入 Settings → Credentials → Add Credential
2. 搜索 `Header Auth`
3. 配置：

| 字段 | 值 |
|------|-----|
| Credential Name | `Webhook API Key` |
| Name | `X-API-Key` |
| Value | `sk-your-secret-key-here` |

**步骤 2：Webhook 节点启用认证**

| 字段 | 值 |
|------|-----|
| Authentication | `Header Auth` |
| Credential for Header Auth | `Webhook API Key` |

**步骤 3：调用时带上 Key**

```bash
# 无 Key 的请求 → 401 Unauthorized
curl http://localhost:5678/webhook/user-register \
  -H "Content-Type: application/json" \
  -d '{"name": "张三"}'

# 带 Key 的请求 → 200 OK
curl http://localhost:5678/webhook/user-register \
  -H "Content-Type: application/json" \
  -H "X-API-Key: sk-your-secret-key-here" \
  -d '{"name": "张三"}'
```

**Python 调用带认证的 Webhook**：

```python
import requests

headers = {
    "Content-Type": "application/json",
    "X-API-Key": "sk-your-secret-key-here"
}

response = requests.post(
    "http://localhost:5678/webhook/user-register",
    json={"name": "张三", "email": "zhang@test.com", "age": 25},
    headers=headers
)
print(response.json())
```

### 5.3 安全措施二：签名验证

当第三方平台（如 GitHub、Stripe）发送 Webhook 时，它们会在请求头中附带签名，你可以验证签名来确保请求来自可信来源。

**在 Code 节点中验证签名**：

```javascript
const crypto = require('crypto');

// 获取请求头中的签名
const signature = $input.first().json.headers['x-signature'] || '';
const body = $input.first().json.body;

// 用共享密钥计算签名
const secret = 'your-webhook-secret';
const expectedSignature = crypto
  .createHmac('sha256', secret)
  .update(JSON.stringify(body))
  .digest('hex');

// 比对签名
const isValid = signature === expectedSignature;

if (!isValid) {
  // 签名验证失败，可以抛出错误或返回 401
  throw new Error('签名验证失败');
}

return $input.first();
```

**发送带签名的请求**：

```python
import hmac
import hashlib
import json
import requests

secret = "your-webhook-secret"
payload = {"name": "张三", "email": "zhang@test.com"}

# 计算签名
signature = hmac.new(
    secret.encode(),
    json.dumps(payload).encode(),
    hashlib.sha256
).hexdigest()

# 发送请求
response = requests.post(
    "http://localhost:5678/webhook/user-register",
    json=payload,
    headers={"X-Signature": signature}
)
print(response.json())
```

### 5.4 安全措施三：IP 白名单

在 docker-compose.yml 中配置环境变量，限制 Webhook 只接受来自特定 IP 的请求：

```yaml
environment:
  - N8N_ALLOWED_WEBHOOK_IPS=127.0.0.1,192.168.1.0/24,10.0.0.0/8
```

修改后需要重启 n8n：

```bash
docker-compose down && docker-compose up -d
```

### 5.5 安全措施四：Basic Auth

**创建 Basic Auth 凭证**：

| 字段 | 值 |
|------|-----|
| Credential Name | `Webhook Basic Auth` |
| User | `admin` |
| Password | `your-password` |

**Webhook 节点配置**：

| 字段 | 值 |
|------|-----|
| Authentication | `Basic Auth` |
| Credential | `Webhook Basic Auth` |

**调用方式**：

```bash
curl http://localhost:5678/webhook/user-register \
  -u admin:your-password \
  -H "Content-Type: application/json" \
  -d '{"name": "张三"}'
```

### 5.6 Webhook 最佳实践

#### 1. 幂等性设计

**用大白话**：同一个请求发多次，结果应该和发一次一样。就像按电梯按钮，按1次和按10次效果相同。

**实现方式**：使用请求 ID 去重

```javascript
const requestId = $input.first().json.headers['x-request-id'] || '';
const body = $input.first().json.body;

// 用 Code 节点记录已处理的请求 ID
// 实际生产中应使用 Redis 或数据库
const processedIds = {};  // 临时存储

if (processedIds[requestId]) {
  return {
    json: {
      success: true,
      message: '请求已处理过（幂等）',
      duplicate: true
    }
  };
}

processedIds[requestId] = true;

// 正常处理逻辑
return {
  json: {
    success: true,
    message: '处理成功',
    data: body
  }
};
```

#### 2. 超时处理

Webhook 默认超时时间有限，长时间任务应使用异步响应：

| 策略 | 做法 | 适用场景 |
|------|------|----------|
| **同步响应** | 处理完直接返回 | 处理时间 < 10秒 |
| **异步响应** | 先返回任务 ID，再轮询结果 | 处理时间 > 10秒 |

**异步响应示例**：

```
Webhook (POST /task) → Code (生成 taskId) → Respond to Webhook (返回 taskId)
                                          → [后台继续处理] → 保存结果
```

```javascript
// Code 节点：生成任务 ID 并启动异步处理
const taskId = 'task_' + Date.now();

// 返回任务 ID 给调用者
return {
  json: {
    taskId: taskId,
    status: 'processing',
    message: '任务已接收，请稍后查询结果',
    pollUrl: `http://localhost:5678/webhook/task-status?taskId=${taskId}`
  }
};
```

#### 3. 日志记录

在每个关键步骤添加日志：

```javascript
// Code 节点中的日志
console.log(`[${new Date().toISOString()}] Webhook 收到请求:`, JSON.stringify($input.first().json.body));
console.log(`处理结果:`, JSON.stringify(result));
```

在 n8n 中查看日志：

```bash
docker-compose logs -f n8n
```

#### 4. 限流

在 Code 节点中实现简单的限流（生产环境建议使用 Nginx 或 API Gateway）：

```javascript
// 简易限流（基于内存，重启后失效）
if (!global.rateLimiter) {
  global.rateLimiter = {};
}

const clientIp = $input.first().json.headers['x-forwarded-for'] || 'unknown';
const now = Date.now();
const windowMs = 60000; // 1分钟窗口
const maxRequests = 10;  // 每分钟最多10次

if (!global.rateLimiter[clientIp]) {
  global.rateLimiter[clientIp] = [];
}

// 清除过期记录
global.rateLimiter[clientIp] = global.rateLimiter[clientIp].filter(t => now - t < windowMs);

// 检查是否超限
if (global.rateLimiter[clientIp].length >= maxRequests) {
  throw new Error('请求过于频繁，请稍后再试 (429)');
}

global.rateLimiter[clientIp].push(now);

return $input.first();
```

#### 5. 错误处理

为 Webhook 工作流添加错误处理分支：

```
Webhook → Code (处理) → IF (成功?)
                        ├── Yes → Respond to Webhook (200)
                        └── No → Code (格式化错误) → Respond to Webhook (400)
```

在 Webhook 节点的 Settings 选项卡中开启 `Continue On Fail`，可以防止错误导致工作流中断。

> ✋ **费曼自测**：什么是幂等性？为什么 Webhook API 需要考虑幂等性？列举三种 Webhook 安全措施。

---

## 番茄钟6：实战——PDF 转 Markdown Webhook 服务（25分钟）

### 6.1 目标

将已有的 [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] 从手动触发改为 Webhook API 服务，让外部系统可以通过 HTTP 请求调用 PDF 转 Markdown 功能。

### 6.2 工作流设计

```
Webhook (POST /pdf-convert) → Code (验证请求) → IF (请求有效?)
  ├── Yes → HTTP Request (GLM-OCR) → Code (格式化 Markdown) → Respond to Webhook (200 + 结果)
  └── No → Respond to Webhook (400 + 错误信息)
```

### 6.3 步骤详解

#### 第一步：创建工作流

1. 创建新工作流，命名为 `PDF to Markdown API`
2. 添加 **Webhook Trigger** 节点

**Webhook 节点配置**：

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 接收文件上传 |
| Path | `pdf-convert` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 异步返回结果 |

#### 第二步：Code 节点（验证请求）

命名为「验证请求」：

```javascript
// 验证上传的文件
const input = $input.first();
const hasFile = input.binary && input.binary.file;

if (!hasFile) {
  return {
    json: {
      valid: false,
      error: '请上传 PDF 文件（字段名: file）'
    }
  };
}

const mimeType = input.binary.file.mimeType || '';
const isPdf = mimeType === 'application/pdf' || input.binary.file.fileName?.endsWith('.pdf');

if (!isPdf) {
  return {
    json: {
      valid: false,
      error: `仅支持 PDF 文件，收到: ${mimeType}`
    }
  };
}

return {
  json: {
    valid: true,
    fileName: input.binary.file.fileName,
    fileSize: input.binary.file.fileSize
  },
  binary: input.binary  // 保留文件数据
};
```

#### 第三步：IF 节点

| 字段 | 值 |
|------|-----|
| Condition | `{{ $json.valid }}` equals `true` |

#### 第四步：HTTP Request 节点（GLM-OCR）

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://open.bigmodel.cn/api/paas/v4/ocr` |
| Authentication | `Generic Credential Type` → `Header Auth` → `GLM-API-Key` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

Body Parameters：

| Parameter Name | Parameter Value |
|----------------|-----------------|
| `image` | `=data:application/pdf;base64,{{ $binary.file.data }}` |

> 注意：这里用 `$binary.file.data` 而非 `$binary.data.data`，因为 Webhook 上传的文件字段名是 `file`。

#### 第五步：Code 节点（格式化 Markdown）

命名为「格式化结果」：

```javascript
// 获取 OCR 结果
const ocrResult = $input.first().json;

// 提取识别文本（适配多种 API 响应格式）
let markdownContent = '';

if (ocrResult.data && ocrResult.data.content) {
  markdownContent = ocrResult.data.content;
} else if (ocrResult.choices && ocrResult.choices[0]) {
  markdownContent = ocrResult.choices[0].message?.content || '';
} else if (ocrResult.text) {
  markdownContent = ocrResult.text;
}

if (!markdownContent) {
  markdownContent = '> OCR 未识别到文本内容';
}

// 生成 Obsidian 格式
const now = new Date();
const frontmatter = `---
source: PDF OCR Webhook API
created: ${now.toISOString()}
tool: n8n + GLM-OCR
tags:
  - pdf-convert
  - ocr
---`;

const filename = `pdf_converted_${Date.now()}.md`;

return {
  json: {
    success: true,
    filename: filename,
    content: frontmatter + '\n\n' + markdownContent,
    contentLength: markdownContent.length,
    convertTime: now.toISOString()
  }
};
```

#### 第六步：成功 — Respond to Webhook

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `200` |

#### 第七步：失败 — Respond to Webhook

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify({ success: false, error: $json.error }) }}` |
| Response Code | `400` |

### 6.4 完整工作流图

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│  Webhook (POST /pdf-convert)                                        │
│       │                                                             │
│       ▼                                                             │
│  Code (验证请求)                                                     │
│       │                                                             │
│       ▼                                                             │
│  IF (请求有效?)                                                      │
│       │                                                             │
│       ├── Yes ──→ HTTP Request (GLM-OCR) ──→ Code (格式化)          │
│       │                                            │                 │
│       │                                            ▼                 │
│       │                               Respond to Webhook (200 OK)    │
│       │                                                             │
│       └── No ──→ Respond to Webhook (400 Bad Request)               │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.5 测试 Webhook API

**点击 Webhook 节点的 Listen for Test Event 按钮！**

**上传 PDF 文件**：

```bash
curl -X POST http://localhost:5678/webhook-test/pdf-convert \
  -F "file=@/path/to/document.pdf"
```

**预期成功响应**：

```json
{
  "success": true,
  "filename": "pdf_converted_1749369000000.md",
  "content": "---\nsource: PDF OCR Webhook API\ncreated: 2026-06-08T10:30:00.000Z\n...\n\n识别出的文本内容",
  "contentLength": 1234,
  "convertTime": "2026-06-08T10:30:00.000Z"
}
```

**不上传文件（测试错误处理）**：

```bash
curl -X POST http://localhost:5678/webhook-test/pdf-convert \
  -H "Content-Type: application/json" \
  -d '{"test": "no file"}'
```

**预期错误响应**：

```json
{
  "success": false,
  "error": "请上传 PDF 文件（字段名: file）"
}
```

### 6.6 用 Python 调用 PDF 转 Markdown API

```python
import requests

def pdf_to_markdown(pdf_path, output_path=None):
    """调用 n8n Webhook 将 PDF 转为 Markdown"""
    url = "http://localhost:5678/webhook/pdf-convert"

    with open(pdf_path, 'rb') as f:
        files = {'file': f}
        response = requests.post(url, files=files)

    if response.status_code == 200:
        result = response.json()
        if result.get('success'):
            # 保存 Markdown 文件
            if output_path is None:
                output_path = result['filename']
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(result['content'])
            print(f"转换成功: {output_path}")
            return result
    else:
        print(f"转换失败: {response.text}")
        return None

# 使用
pdf_to_markdown("D:/Documents/report.pdf", "D:/ObsidianVault/ideal/converted/report.md")
```

### 6.7 用 JavaScript 调用 PDF 转 Markdown API

```javascript
const FormData = require('form-data');
const fs = require('fs');
const axios = require('axios');

async function pdfToMarkdown(pdfPath, outputPath) {
  const url = 'http://localhost:5678/webhook/pdf-convert';

  const form = new FormData();
  form.append('file', fs.createReadStream(pdfPath));

  try {
    const response = await axios.post(url, form, {
      headers: form.getHeaders()
    });

    const result = response.data;

    if (result.success) {
      const outPath = outputPath || result.filename;
      fs.writeFileSync(outPath, result.content, 'utf-8');
      console.log(`转换成功: ${outPath}`);
      return result;
    } else {
      console.error('转换失败:', result.error);
      return null;
    }
  } catch (error) {
    console.error('请求失败:', error.message);
    return null;
  }
}

// 使用
pdfToMarkdown('./document.pdf', './output.md');
```

> ✋ **费曼自测**：如果把已有的 Manual Trigger 工作流改为 Webhook API，核心区别是什么？文件数据在 Webhook 中如何访问？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 能为 Webhook 添加 API Key 认证
- [ ] 理解签名验证、IP 白名单、限流等安全措施
- [ ] 理解幂等性和异步响应的概念
- [ ] 能将已有工作流改造为 Webhook API 服务
- [ ] 能用 curl / Python / JavaScript 调用 Webhook API

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| Webhook | 反向 API 调用，服务器主动通知 | 餐厅做好了打给你 |
| Webhook Trigger | n8n 中接收 HTTP 请求的触发器 | 大门口 |
| HTTP Method | 请求操作类型 | 点菜方式（看/点/改/删） |
| Response Mode | Webhook 如何返回响应 | 快递员的送货方式 |
| Respond to Webhook | 专门控制响应内容的节点 | 回信 |
| API Key | 请求身份验证的密钥 | 门钥匙 |
| 签名验证 | 验证请求来源真实性 | 防伪标签 |
| 幂等性 | 同一请求多次执行结果一致 | 按电梯按钮 |
| 限流 | 限制单位时间内的请求次数 | 排队取号 |
| 异步响应 | 先返回任务 ID，再查询结果 | 取餐号 |

### 7.2 Webhook vs 传统 API 对比

| 维度 | 传统 API | n8n Webhook |
|------|----------|-------------|
| **定义方式** | 写代码（Express/Flask） | 拖拽节点 |
| **开发速度** | 较慢（写代码+部署） | 很快（拖拽即可） |
| **灵活性** | 极高 | 中高（Code 节点补齐） |
| **维护成本** | 高（代码维护） | 低（可视化调试） |
| **适合场景** | 复杂业务逻辑 | 快速构建 API 原型、自动化集成 |
| **数据处理** | 自己写 | 400+ 节点即插即用 |
| **AI 集成** | 需要接入 SDK | 原生 AI 节点 |

### 7.3 Webhook 配置速查表

```
Webhook Trigger:
  HTTP Method:    GET / POST / PUT / DELETE / PATCH
  Path:           自定义路径（如 user-register）
  Response Mode:  On Received / Last Node / Respond to Webhook
  Authentication: None / Header Auth / Basic Auth

Respond to Webhook:
  Respond With:   JSON / Text / Binary / Redirect
  Response Body:  ={{ JSON.stringify($json) }}
  Response Code:  200 / 201 / 400 / 401 / 404 / 500

数据访问:
  URL 参数:    {{ $json.query.paramName }}
  请求体:      {{ $json.body.fieldName }}
  请求头:      {{ $json.headers['header-name'] }}
  上传文件:    {{ $binary.file.data }}
  文件名:      {{ $binary.file.fileName }}
  MIME类型:    {{ $binary.file.mimeType }}
```

### 7.4 curl 命令参考卡

```bash
# GET 请求（查询）
curl "http://localhost:5678/webhook/hello?name=张三"

# POST JSON 数据
curl -X POST http://localhost:5678/webhook/user-register \
  -H "Content-Type: application/json" \
  -d '{"name": "张三", "email": "zhang@test.com"}'

# POST 上传文件
curl -X POST http://localhost:5678/webhook/upload \
  -F "file=@document.pdf" \
  -F "description=测试文件"

# 带 API Key 认证
curl -X POST http://localhost:5678/webhook/user-register \
  -H "Content-Type: application/json" \
  -H "X-API-Key: sk-your-secret-key" \
  -d '{"name": "张三"}'

# 带 Basic Auth 认证
curl -X POST http://localhost:5678/webhook/user-register \
  -u admin:password \
  -H "Content-Type: application/json" \
  -d '{"name": "张三"}'

# 测试 URL vs 生产 URL
# 测试: http://localhost:5678/webhook-test/path  （需先点击 Listen for Test Event）
# 生产: http://localhost:5678/webhook/path       （需先激活工作流）
```

> ✋ **费曼自测**：遮住上面的表格，你能回忆出每个概念的一句话解释吗？你能写出 curl 调用 Webhook 的三种常见方式吗？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——Webhook 接收处理与响应

**练习目标**：在25分钟内完成3轮 Webhook 实操循环，掌握从接收到响应的完整流程

**任务序列（重复×3）：**

```
===== 循环 1：创建3个不同触发方式的 Webhook =====
1. 创建 GET 方法 Webhook（路径 /hello），返回问候语
2. 创建 POST 方法 Webhook（路径 /data），接收 JSON 数据
3. 创建 DELETE 方法 Webhook（路径 /remove），模拟删除操作
4. 用 curl 分别测试三种方法
验证：三种 HTTP 方法都能正确响应，返回不同结果

===== 循环 2：用 Webhook 接收不同格式数据 =====
1. 配置一个 POST Webhook，接收 JSON 格式数据
2. 用 curl 发送 JSON 请求，在 n8n 中查看 body 内容
3. 配置另一个 Webhook 接收 form-data 格式
4. 对比两种格式在 n8n 中的访问方式
验证：JSON 通过 $json.body 访问，form-data 同样通过 $json.body 访问

===== 循环 3：构建完整的 Webhook 请求→处理→响应流程 =====
1. 从零创建 Webhook API 服务
2. 结构：Webhook（POST）→ Code（验证数据）→ IF（判断有效性）
   ├→ True → Set（构建成功响应）→ Respond to Webhook（200）
   └→ False → Set（构建错误响应）→ Respond to Webhook（400）
3. 用 curl 测试成功和失败两种场景
4. 添加 API Key 认证后再次测试
验证：成功请求返回200带数据，失败请求返回400带错误信息，无 Key 返回401
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Webhook 节点配置与测试 | ⬜ | ⬜ | ⬜ |
| 多种数据格式接收与处理 | ⬜ | ⬜ | ⬜ |
| 完整 API 服务构建（含安全认证） | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：三种 Response Mode 分别在什么场景使用？为什么构建 API 服务时通常选择 "Using Respond to Webhook" 模式？

### 8.1 今日自检清单

完成以下所有项才算通过 Day 5：

- [ ] 能用大白话解释 Webhook 和传统 API 的区别
- [ ] 能正确配置 Webhook Trigger（Method、Path、Response Mode）
- [ ] 理解三种 Response Mode 的区别和适用场景
- [ ] 能用 Respond to Webhook 节点返回 JSON 响应
- [ ] 能为 Webhook 添加 API Key 认证
- [ ] 理解签名验证、IP 白名单、限流等安全措施
- [ ] 理解幂等性、异步响应等最佳实践
- [ ] 能将已有工作流改造为 Webhook API 服务
- [ ] 能用 curl 测试 Webhook 接口
- [ ] 能用 Python / JavaScript 调用 Webhook API
- [ ] 知道测试 URL 和生产 URL 的区别

### 8.2 费曼一句话总结

> **Webhook 是 n8n 的「大门」——外部系统通过 HTTP 请求触发工作流，让 n8n 从被动等待变成主动服务。配置好 Method、Path、Response Mode 和安全认证，你的工作流就是一个可调用的 API。**

### 8.3 学习笔记

```markdown
## Day 5 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 实战项目想法
（想想你还可以把什么工作流变成 Webhook API）

### 明天想深入的方向
（为 Day 6 做准备）
```

---

## 🎉 Day 5 完成！

**今日成果：**
- 理解了 Webhook 的本质——反向 API 调用
- 掌握了 Webhook Trigger 的完整配置
- 构建了用户注册 REST API 服务
- 学会了 Respond to Webhook 的多种响应方式
- 掌握了 API Key、签名验证、IP 白名单等安全措施
- 理解了幂等性、异步响应、限流等最佳实践
- 将 GLM-OCR 工作流成功改造为 Webhook API 服务
- 能用 curl / Python / JavaScript 调用 Webhook

**明天预告：** [[Day6-AI-Agent工作流]] - 搭建 AI Agent 智能工作流，让 n8n 拥有 AI 大脑

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day4-数据处理与工作流模式]] - 前一天
> - [[Day6-AI-Agent工作流]] - 下一天
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 n8n 工作流参考
