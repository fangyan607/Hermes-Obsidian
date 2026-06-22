# Day 6：企业级模式（2个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建2个企业级工作流，掌握审批流、数据同步、子工作流、错误处理
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-4：实例16 · 多级审批工作流
🍅 番茄5-7：实例17 · 跨系统数据同步
🍅 番茄8：今日复习 + 费曼综合检测
```

> 💡 今天只有 2 个实例，但每个都更深入——企业级意味着更复杂的逻辑、更健壮的容错、更完善的日志。慢下来，搞透每一个细节。

---

## 🍅 番茄钟1：实例16 · 多级审批工作流——场景与架构

### 🎯 场景与目标

**企业场景**：公司有采购审批制度——

| 金额范围 | 审批人 | 审批方式 |
|----------|--------|----------|
| < ¥1,000 | 无需审批 | 系统自动通过 |
| ¥1,000 ~ ¥10,000 | 部门经理 | 人工审批 |
| > ¥10,000 | 总监 | 人工审批 |

传统做法：邮件审批→容易遗漏→没有统一记录→无法追踪→无法统计

**用 n8n 做审批流**：
- 统一入口（Webhook API）
- 自动路由（按金额分级）
- 人工审批（Wait 节点暂停等待）
- 全程记录（审计日志）
- 超时保护（24h 未审批自动拒绝）

**学到的企业级模式**：

| 模式 | 本次实例中的体现 |
|------|------------------|
| Human-in-the-Loop | Wait 节点暂停工作流，等待人工决策 |
| 分级路由 | Switch 按金额阈值分配审批人 |
| 超时处理 | Wait 节点设置 24h 超时自动拒绝 |
| 审计日志 | 每次审批决策写入日志 |
| 容错运行 | Continue On Fail 防止通知失败阻塞流程 |

### 🏗️ 工作流架构图

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  Webhook (POST /approval/request)                                          │
│       │                                                                     │
│       ▼                                                                     │
│  Code (验证请求: type, amount, requester)                                    │
│       │                                                                     │
│       ▼                                                                     │
│  Switch (按金额分级)                                                         │
│       │                                                                     │
│       ├── <1000 ──→ Code (自动通过) ──────────────────────┐                 │
│       │                                                    │                 │
│       ├── 1000-10000 ──→ Code (发送经理审批通知)            │                 │
│       │                    │                                │                 │
│       │                    ▼                                │                 │
│       │               Wait Node (等待审批响应)               │                 │
│       │                    │                                │                 │
│       │                    ▼                                │                 │
│       │               IF (已批准?)                           │                 │
│       │                ├── Yes → Code (执行批准操作) ────→ ──┤                │
│       │                └── No  → Code (拒绝通知) ────────→ ──┤                │
│       │                                                    │                 │
│       └── >10000 ──→ Code (发送总监审批通知)                 │                 │
│                         │                                                   │
│                         ▼                                                   │
│                    Wait Node (等待审批响应)                                   │
│                         │                                                   │
│                         ▼                                                   │
│                    IF (已批准?)                                              │
│                     ├── Yes → Code (执行批准操作) ────→ ──┤                  │
│                     └── No  → Code (拒绝通知) ─────────→ ──┤                 │
│                                                           │                  │
│                                                           ▼                  │
│                                                    Code (记录审计日志)       │
│                                                           │                  │
│                                                           ▼                  │
│                                                    Respond to Webhook        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 🔑 API/凭证准备

本实例需要以下凭证：

| 凭证 | 类型 | 获取方式 | 用途 |
|------|------|----------|------|
| Webhook API Key | Header Auth | 自定义密钥 | 保护审批入口 |
| 通知服务 Webhook | 通用 Webhook URL | 钉钉/Slack/飞书机器人 | 发送审批通知 |
| n8n Production URL | n8n 实例地址 | 你的 n8n 部署地址 | Wait 节点回调 |

**创建 Header Auth 凭证**：

1. Settings → Credentials → Add Credential
2. 搜索 `Header Auth`
3. 配置：

| 字段 | 值 |
|------|-----|
| Credential Name | `Approval API Key` |
| Name | `X-API-Key` |
| Value | `sk-approval-secret-2026` |

> ✋ **费曼自测**：为什么审批流需要 Wait 节点？如果没有 Wait 节点，审批请求会怎样？

---

## 🍅 番茄钟2：实例16 · 逐节点配置（上）——触发、验证、路由

### 🔧 逐节点配置

#### 节点1：Webhook Trigger

**配置**：

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 提交审批请求 |
| Path | `approval/request` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 审批完成后才响应 |
| Authentication | `Header Auth` → `Approval API Key` | 保护 API 入口 |

**测试请求体**：

```json
{
  "type": "purchase",
  "title": "采购办公室显示器",
  "amount": 5500,
  "requester": "张三",
  "requesterId": "EMP-001",
  "department": "技术部",
  "description": "为新员工采购 27 寸显示器 2 台",
  "items": [
    { "name": "Dell 27寸显示器", "qty": 2, "unitPrice": 2750 }
  ]
}
```

**金额测试用例**：

| 测试 | amount | 预期路由 |
|------|--------|----------|
| 小额 | 500 | 自动通过 |
| 中额 | 5500 | 经理审批 |
| 大额 | 15000 | 总监审批 |
| 边界1 | 1000 | 经理审批（≥1000） |
| 边界2 | 10000 | 经理审批（<10000） |
| 边界3 | 10001 | 总监审批（>10000） |

#### 节点2：Code —— 验证请求

命名为「验证审批请求」：

```javascript
const body = $input.first().json.body;

// 验证必填字段
const errors = [];

if (!body.type || !['purchase', 'expense', 'travel', 'other'].includes(body.type)) {
  errors.push('type 必须是 purchase/expense/travel/other 之一');
}

if (!body.title || body.title.trim() === '') {
  errors.push('title 不能为空');
}

if (!body.amount || typeof body.amount !== 'number' || body.amount <= 0) {
  errors.push('amount 必须是大于0的数字');
}

if (!body.requester || body.requester.trim() === '') {
  errors.push('requester 不能为空');
}

if (!body.requesterId) {
  errors.push('requesterId 不能为空');
}

if (errors.length > 0) {
  return {
    json: {
      valid: false,
      errors: errors,
      requestId: null
    }
  };
}

// 生成审批请求 ID（用于追踪）
const requestId = 'APR-' + Date.now() + '-' + Math.random().toString(36).substring(2, 8);

// 确定审批级别
let approvalLevel;
if (body.amount < 1000) {
  approvalLevel = 'auto';       // 自动通过
} else if (body.amount < 10000) {
  approvalLevel = 'manager';    // 经理审批
} else {
  approvalLevel = 'director';   // 总监审批
}

// 确定审批人（实际项目中从数据库/配置获取）
const approvers = {
  manager: { id: 'MGR-001', name: '李经理', webhook: 'YOUR_DINGTALK_MANAGER_WEBHOOK' },
  director: { id: 'DIR-001', name: '王总监', webhook: 'YOUR_DINGTALK_DIRECTOR_WEBHOOK' }
};

return {
  json: {
    valid: true,
    requestId: requestId,
    type: body.type,
    title: body.title,
    amount: body.amount,
    requester: body.requester,
    requesterId: body.requesterId,
    department: body.department || '未指定',
    description: body.description || '',
    items: body.items || [],
    approvalLevel: approvalLevel,
    approver: approvalLevel === 'auto' ? null : approvers[approvalLevel],
    createdAt: new Date().toISOString(),
    errors: []
  }
};
```

**关键设计点**：
- 生成唯一 `requestId` 用于追踪整个审批链路
- 在验证阶段就确定 `approvalLevel`，下游节点直接使用
- 审批人信息集中管理，方便扩展

#### 节点3：IF —— 请求是否有效

| 字段 | 值 |
|------|-----|
| Condition | `{{ $json.valid }}` equals `true` |

- **True 分支** → Switch（路由审批级别）
- **False 分支** → Code（格式化错误）→ Respond to Webhook（400）

**错误响应 Code 节点**：

```javascript
return {
  json: {
    success: false,
    error: {
      code: 'VALIDATION_ERROR',
      message: '审批请求验证失败',
      details: $input.first().json.errors
    },
    timestamp: new Date().toISOString()
  }
};
```

**错误 Respond to Webhook**：

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `400` |

#### 节点4：Switch —— 按金额路由

| 输出编号 | 条件 | 说明 |
|----------|------|------|
| 0 | `{{ $json.approvalLevel }}` equals `auto` | 小额，自动通过 |
| 1 | `{{ $json.approvalLevel }}` equals `manager` | 中额，经理审批 |
| 2 | `{{ $json.approvalLevel }}` equals `director` | 大额，总监审批 |

> ✋ **费曼自测**：为什么要在 Code 节点中计算 `approvalLevel`，而不是在 Switch 中直接判断 `amount`？如果金额阈值需要经常调整，哪种方式更好维护？

---

## 🍅 番茄钟3：实例16 · 逐节点配置（下）——审批、等待、回调

### 🔧 逐节点配置（续）

#### 节点5：Code —— 自动通过分支

命名为「自动通过」：

```javascript
const data = $input.first().json;

return {
  json: {
    ...data,
    status: 'approved',
    approvedBy: 'SYSTEM',
    approvedAt: new Date().toISOString(),
    approvalMethod: 'auto',
    reason: `金额 ¥${data.amount} < ¥1,000，自动通过`
  }
};
```

#### 节点6：Code —— 发送审批通知

命名为「发送审批通知」：

```javascript
const data = $input.first().json;

// 构建审批通知内容
const notification = {
  msgtype: 'markdown',
  markdown: {
    title: `审批请求: ${data.title}`,
    text: [
      `## 审批请求`,
      ``,
      `**请求ID**: ${data.requestId}`,
      `**类型**: ${data.type}`,
      `**标题**: ${data.title}`,
      `**金额**: ¥${data.amount.toLocaleString()}`,
      `**申请人**: ${data.requester} (${data.department})`,
      `**说明**: ${data.description}`,
      `**提交时间**: ${data.createdAt}`,
      ``,
      `---`,
      ``,
      `请点击以下链接进行审批：`,
      ``,
      `[批准](${data.callbackUrl}/approval/respond?action=approve&requestId=${data.requestId})`,
      ``,
      `[拒绝](${data.callbackUrl}/approval/respond?action=reject&requestId=${data.requestId})`,
      ``,
      `> 24小时内未审批将自动拒绝`
    ].join('\n')
  }
};

return {
  json: {
    ...data,
    notification: notification,
    notificationTarget: data.approver.webhook
  }
};
```

> 💡 实际项目中，审批链接应该指向一个前端页面，而不是直接调用 API。这里简化为直接链接。

#### 节点7：HTTP Request —— 发送通知到钉钉/Slack

| 字段 | 值 | 说明 |
|------|-----|------|
| Method | `POST` | 发送通知 |
| URL | `={{ $json.notificationTarget }}` | 审批人的 Webhook 地址 |
| Send Body | `ON` | |
| Body Content Type | `JSON` | |
| Body | `={{ JSON.stringify($json.notification) }}` | 通知内容 |
| Continue On Fail | `ON` | 通知失败不阻塞审批流程 |

> ⚠️ **Continue On Fail** 是企业级工作流的关键设置！通知失败不应阻止审批流程继续——即使钉钉/Slack 挂了，审批请求仍然可以被处理。

#### 节点8：Wait Node —— 等待审批响应（核心！）

**这是整个审批流的灵魂节点。** Wait 节点让工作流暂停，等待外部事件（人工审批）触发后继续执行。

**Wait 节点配置**：

| 字段 | 值 | 说明 |
|------|-----|------|
| Resume | `Using Webhook` | 通过 Webhook 恢复执行 |
| Webhook Path | `approval/respond` | 审批回调路径 |
| HTTP Method | `GET` | 审批链接用 GET 请求 |
| Response Mode | `On Received` | 收到审批立即确认 |

**Wait 节点的高级配置**：

| 字段 | 值 | 说明 |
|------|-----|------|
| Timeout | `ON` | 启用超时 |
| Timeout Value | `24` | |
| Timeout Unit | `Hours` | 24小时超时 |
| On Timeout | `Continue` | 超时后继续执行（走拒绝逻辑） |

**Wait 节点输出的数据结构**：

当审批人点击审批链接时，Wait 节点会收到如下数据：

```json
{
  "query": {
    "action": "approve",
    "requestId": "APR-1749369000000-a1b2c3"
  },
  "headers": { ... }
}
```

**超时时 Wait 节点的输出**：

```json
{
  "timedOut": true
}
```

> 💡 **理解 Wait 节点的工作原理**：
> 1. 工作流执行到 Wait 节点时**暂停**，状态保存到数据库
> 2. n8n 监听 Wait 节点配置的 Webhook 路径
> 3. 当外部请求到达该 Webhook 时，工作流**恢复**执行
> 4. 如果超过 24h 没有请求到达，触发超时逻辑

#### 节点9：Code —— 判断审批结果

命名为「判断审批结果」：

```javascript
const waitOutput = $input.first().json;

// 检查是否超时
if (waitOutput.timedOut) {
  return {
    json: {
      status: 'rejected',
      rejectedBy: 'SYSTEM',
      rejectedAt: new Date().toISOString(),
      rejectionReason: '审批超时（24小时未响应），自动拒绝',
      timedOut: true
    }
  };
}

// 正常审批响应
const action = waitOutput.query.action;

if (action === 'approve') {
  return {
    json: {
      status: 'approved',
      approvedBy: waitOutput.query.approverId || 'MANUAL',
      approvedAt: new Date().toISOString(),
      approvalMethod: 'manual',
      timedOut: false
    }
  };
} else if (action === 'reject') {
  return {
    json: {
      status: 'rejected',
      rejectedBy: waitOutput.query.approverId || 'MANUAL',
      rejectedAt: new Date().toISOString(),
      rejectionReason: waitOutput.query.reason || '审批人拒绝',
      timedOut: false
    }
  };
} else {
  return {
    json: {
      status: 'rejected',
      rejectedBy: 'SYSTEM',
      rejectedAt: new Date().toISOString(),
      rejectionReason: `未知审批动作: ${action}`,
      timedOut: false
    }
  };
}
```

#### 节点10：IF —— 是否批准

| 字段 | 值 |
|------|-----|
| Condition | `{{ $json.status }}` equals `approved` |

**True 分支** → Code（执行批准操作）
**False 分支** → Code（拒绝通知）

#### 节点11：Code —— 执行批准操作

命名为「执行批准操作」：

```javascript
const originalData = $('验证审批请求').first().json;
const approvalResult = $input.first().json;

// 实际项目中，这里会：
// 1. 更新数据库中的审批状态
// 2. 触发后续业务流程（如：发起采购订单）
// 3. 通知申请人审批已通过

const result = {
  requestId: originalData.requestId,
  status: 'approved',
  title: originalData.title,
  amount: originalData.amount,
  requester: originalData.requester,
  approvedBy: approvalResult.approvedBy,
  approvedAt: approvalResult.approvedAt,
  approvalMethod: approvalResult.approvalMethod,
  nextSteps: []
};

// 根据审批类型决定后续动作
if (originalData.type === 'purchase') {
  result.nextSteps.push('自动创建采购订单');
  result.nextSteps.push('通知采购部门');
} else if (originalData.type === 'travel') {
  result.nextSteps.push('自动创建差旅申请');
  result.nextSteps.push('通知行政部门');
} else if (originalData.type === 'expense') {
  result.nextSteps.push('自动创建报销单');
  result.nextSteps.push('通知财务部门');
}

return { json: result };
```

#### 节点12：Code —— 拒绝通知

命名为「拒绝通知」：

```javascript
const originalData = $('验证审批请求').first().json;
const rejectResult = $input.first().json;

return {
  json: {
    requestId: originalData.requestId,
    status: 'rejected',
    title: originalData.title,
    amount: originalData.amount,
    requester: originalData.requester,
    rejectedBy: rejectResult.rejectedBy,
    rejectedAt: rejectResult.rejectedAt,
    rejectionReason: rejectResult.rejectionReason || '审批人拒绝',
    timedOut: rejectResult.timedOut || false
  }
};
```

#### 节点13：Code —— 记录审计日志

命名为「记录审计日志」：

```javascript
// 无论批准还是拒绝，都记录审计日志
const data = $input.first().json;

const auditLog = {
  logId: 'LOG-' + Date.now(),
  requestId: data.requestId,
  action: data.status === 'approved' ? 'APPROVE' : 'REJECT',
  actor: data.approvedBy || data.rejectedBy,
  timestamp: data.approvedAt || data.rejectedAt,
  details: {
    title: data.title,
    amount: data.amount,
    requester: data.requester,
    reason: data.rejectionReason || null,
    timedOut: data.timedOut || false,
    nextSteps: data.nextSteps || []
  }
};

// 实际项目中，写入数据库或日志系统
// 这里用 console.log 模拟
console.log('[AUDIT LOG]', JSON.stringify(auditLog, null, 2));

return {
  json: {
    success: true,
    requestId: data.requestId,
    status: data.status,
    message: data.status === 'approved'
      ? `审批已通过。后续步骤: ${(data.nextSteps || []).join('、')}`
      : `审批已拒绝。原因: ${data.rejectionReason || '审批人拒绝'}`,
    auditLogId: auditLog.logId
  }
};
```

#### 节点14：Respond to Webhook

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `={{ $json.status === 'approved' ? 200 : 200 }}` |

> 💡 审批拒绝也返回 200——因为 API 调用本身是成功的，业务结果通过 `status` 字段区分。

### 🧪 测试验证

**测试1：小额自动通过**

```bash
curl -X POST http://localhost:5678/webhook-test/approval/request \
  -H "Content-Type: application/json" \
  -H "X-API-Key: sk-approval-secret-2026" \
  -d '{
    "type": "purchase",
    "title": "采购笔记本",
    "amount": 500,
    "requester": "张三",
    "requesterId": "EMP-001",
    "department": "技术部"
  }'
```

**预期响应**（立即返回，无需等待）：

```json
{
  "success": true,
  "requestId": "APR-1749369000000-a1b2c3",
  "status": "approved",
  "message": "审批已通过。后续步骤: 自动创建采购订单、通知采购部门",
  "auditLogId": "LOG-1749369001000"
}
```

**测试2：中额需要经理审批**

```bash
curl -X POST http://localhost:5678/webhook-test/approval/request \
  -H "Content-Type: application/json" \
  -H "X-API-Key: sk-approval-secret-2026" \
  -d '{
    "type": "purchase",
    "title": "采购显示器",
    "amount": 5500,
    "requester": "张三",
    "requesterId": "EMP-001",
    "department": "技术部",
    "description": "为新员工采购 27 寸显示器 2 台"
  }'
```

**预期行为**：工作流暂停在 Wait 节点，等待经理审批。

**模拟经理审批**：

```bash
# 批准
curl "http://localhost:5678/webhook-test/approval/respond?action=approve&requestId=APR-1749369000000-a1b2c3"

# 拒绝
curl "http://localhost:5678/webhook-test/approval/respond?action=reject&requestId=APR-1749369000000-a1b2c3"
```

**测试3：无效请求**

```bash
curl -X POST http://localhost:5678/webhook-test/approval/request \
  -H "Content-Type: application/json" \
  -H "X-API-Key: sk-approval-secret-2026" \
  -d '{"type": "invalid_type", "title": "", "amount": -100}'
```

**预期响应**（400）：

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "审批请求验证失败",
    "details": [
      "type 必须是 purchase/expense/travel/other 之一",
      "title 不能为空",
      "amount 必须是大于0的数字",
      "requester 不能为空",
      "requesterId 不能为空"
    ]
  }
}
```

### ✋ 费曼检测

1. Wait 节点的 `Resume` 设置为 `Using Webhook` 意味着什么？工作流在 Wait 节点处发生了什么？
2. 为什么要给 Wait 节点设置 24 小时超时？如果不设置超时会怎样？
3. Continue On Fail 用在了哪个节点？为什么审批通知的节点需要这个设置？
4. 如果金额阈值从 10000 改为 50000，你需要修改几个地方？（提示：对比在 Code 中集中计算 vs 在 Switch 中直接判断的区别）

---

## 🍅 番茄钟4结束，休息5分钟

**核心概念回顾：**
- [ ] Wait 节点可以让工作流暂停，等待外部事件恢复
- [ ] Switch 节点可以按业务规则分级路由
- [ ] Continue On Fail 保证关键流程不被非关键节点阻塞
- [ ] 审计日志是企业级工作流的标配
- [ ] 超时保护防止工作流永远挂起

---

## 🍅 番茄钟4：实例16 · 变体与扩展

### 💡 变体与扩展

#### 变体1：多级串行审批

金额 > ¥50,000 时，需要经理审批通过后，再由总监审批：

```
Switch (>50000)
  → 经理审批 → Wait → IF (经理批准?)
      ├── Yes → 总监审批 → Wait → IF (总监批准?)
      │                 ├── Yes → 执行批准
      │                 └── No  → 拒绝通知
      └── No → 拒绝通知
```

**核心改变**：用串行 Wait 节点实现多级审批链——上一级通过后才进入下一级。

#### 变体2：会签审批（多人同时审批）

金额 > ¥100,000 时，需要 3 位总监中的 2 位批准：

```
Switch (>100000)
  → Split Out (3位总监)
    → 并行发送3个审批通知
    → Wait (等待所有审批响应)
    → Code (统计批准数量)
    → IF (批准数 ≥ 2?)
        ├── Yes → 执行批准
        └── No  → 拒绝通知
```

**核心改变**：用 Split Out 将审批人拆分，并行发送通知，最后汇总统计。

#### 变体3：带修改意见的审批

审批人可以「批准」「拒绝」「退回修改」：

```
Wait (等待审批响应)
  → Switch (action: approve / reject / revise)
      ├── approve → 执行批准
      ├── reject  → 拒绝通知
      └── revise  → Code (通知申请人修改) → Webhook (等待重新提交)
```

**核心改变**：增加「退回修改」分支，Wait 节点后用 Switch 替代 IF 处理多种审批动作。

#### 变体4：审批加签

审批人可以将审批转给其他人：

```
Wait (等待审批响应)
  → Switch (action: approve / reject / delegate)
      ├── approve  → 执行批准
      ├── reject   → 拒绝通知
      └── delegate → Code (查找被转签审批人) → 发送审批通知 → Wait (等待新审批人)
```

**核心改变**：`delegate` 分支重新进入审批流程，形成循环。

#### 企业级审批流功能清单

| 功能 | 实现难度 | 优先级 | 说明 |
|------|----------|--------|------|
| 金额分级路由 | 低 | P0 | 本实例已实现 |
| 人工审批 + Wait | 中 | P0 | 本实例已实现 |
| 超时自动拒绝 | 低 | P0 | 本实例已实现 |
| 审计日志 | 低 | P0 | 本实例已实现 |
| Continue On Fail | 低 | P1 | 本实例已实现 |
| 多级串行审批 | 中 | P1 | 变体1 |
| 会签审批 | 高 | P2 | 变体2 |
| 退回修改 | 中 | P2 | 变体3 |
| 加签/转签 | 高 | P3 | 变体4 |
| 审批催办 | 低 | P2 | 定时发送提醒 |
| 审批撤回 | 中 | P3 | 申请人主动撤回 |
| 审批统计看板 | 中 | P2 | 每周审批报表 |

### ✋ 费曼检测

1. 多级串行审批和会签审批的核心区别是什么？分别适合什么场景？
2. 如果要实现「审批催办」，你会在工作流中增加什么节点？怎么实现「每隔6小时提醒一次」？
3. 退回修改和拒绝的区别是什么？对工作流的影响是什么？

---

## 🍅 番茄钟4结束，休息5分钟

**验证清单：**
- [ ] 完成了多级审批工作流的搭建
- [ ] 理解 Wait 节点的完整配置（Webhook 恢复 + 超时）
- [ ] 理解 Continue On Fail 的使用场景
- [ ] 测试了自动通过、人工审批、验证失败三种场景
- [ ] 理解了多级串行审批和会签审批的设计思路

---

## 🍅 番茄钟5：实例17 · 跨系统数据同步——场景与架构

### 🎯 场景与目标

**企业场景**：公司有两个系统——

| 系统 | 角色 | 数据格式 |
|------|------|----------|
| System A（CRM） | 客户管理系统 | 自定义 JSON |
| System B（ERP） | 企业资源系统 | 标准化 JSON |

每天有大量客户数据在 System A 中更新，需要同步到 System B。手动同步→容易遗漏→格式不一致→数据冲突→无法追踪

**用 n8n 做数据同步**：
- 定时拉取（每小时检查一次）
- 智能检测变更（只同步有变化的数据）
- 格式转换（A 的格式 → B 的格式）
- 差异化操作（新增/更新/删除分别处理）
- 完整日志（每次同步都有记录）
- 子工作流错误处理（出错不影响整体）

**学到的企业级模式**：

| 模式 | 本次实例中的体现 |
|------|------------------|
| ETL 管道 | Extract → Transform → Load |
| 变更检测 | Hash 对比 / 时间戳对比 |
| 差异化操作 | Switch 区分 create/update/delete |
| 子工作流 | 错误处理抽取为独立子工作流 |
| 幂等性 | 安全重试，重复执行结果一致 |
| 监控告警 | 同步失败自动通知 |

### 🏗️ 工作流架构图

**主工作流**：

```
┌────────────────────────────────────────────────────────────────────────────┐
│                                                                            │
│  Schedule Trigger (每小时)                                                  │
│       │                                                                    │
│       ▼                                                                    │
│  Code (记录同步开始)                                                         │
│       │                                                                    │
│       ▼                                                                    │
│  HTTP Request (从 System A 拉取数据)                                        │
│       │                                                                    │
│       ▼                                                                    │
│  Code (转换数据格式 A→B)                                                     │
│       │                                                                    │
│       ▼                                                                    │
│  Code (检测变更: 对比上次同步)                                                │
│       │                                                                    │
│       ▼                                                                    │
│  IF (有变更?)                                                                │
│       │                                                                    │
│       ├── No → Code (记录无变更) ────────────────────────────────┐          │
│       │                                                          │          │
│       └── Yes → Split Out (拆分每条变更)                          │          │
│                    │                                             │          │
│                    ▼                                             │          │
│               Switch (操作类型)                                   │          │
│                    │                                             │          │
│                    ├── create → HTTP Request (System B POST)     │          │
│                    ├── update → HTTP Request (System B PUT)      │          │
│                    └── delete → HTTP Request (System B DELETE)   │          │
│                             │                                    │          │
│                             ▼                                    │          │
│                    Code (记录每条同步结果)                          │          │
│                             │                                    │          │
│                             ▼                                    │          │
│                    Code (汇总同步结果 + 错误通知) ────────────────┘          │
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘
```

**子工作流 —— sub-error-handler**：

```
┌──────────────────────────────────────────┐
│                                          │
│  Error Trigger                           │
│       │                                  │
│       ▼                                  │
│  Code (格式化错误信息)                     │
│       │                                  │
│       ▼                                  │
│  HTTP Request (发送告警通知)               │
│       │                                  │
│       ▼                                  │
│  Code (记录错误日志)                       │
│                                          │
└──────────────────────────────────────────┘
```

### 🔑 API/凭证准备

| 凭证 | 类型 | 获取方式 | 用途 |
|------|------|----------|------|
| System A API Key | Header Auth | CRM 系统管理员 | 拉取客户数据 |
| System B API Key | Header Auth | ERP 系统管理员 | 写入同步数据 |
| 告警通知 Webhook | 通用 URL | 钉钉/Slack/飞书 | 同步失败告警 |

**Mock API 说明**：

本实例使用 Mock API 进行演示。如果你没有真实的 CRM/ERP 系统，可以用以下方式模拟：

```javascript
// 在 Code 节点中模拟 System A 返回数据
const mockData = [
  { id: 'CRM-001', name: '张三', email: 'zhang@test.com', status: 'active', updatedAt: '2026-06-08T10:00:00Z' },
  { id: 'CRM-002', name: '李四', email: 'li@test.com', status: 'active', updatedAt: '2026-06-08T09:30:00Z' },
  { id: 'CRM-003', name: '王五', email: 'wang@test.com', status: 'inactive', updatedAt: '2026-06-07T15:00:00Z' }
];
```

> ✋ **费曼自测**：ETL 的三个字母分别代表什么？为什么数据同步需要「变更检测」而不是每次全量同步？

---

## 🍅 番茄钟6：实例17 · 逐节点配置

### 🔧 逐节点配置

#### 节点1：Schedule Trigger

| 字段 | 值 | 说明 |
|------|-----|------|
| Trigger Rules | `Every Hour` | 每小时执行一次 |
| Minute | `0` | 整点触发 |

> 💡 实际生产中，同步频率取决于业务需求：实时性要求高用 5 分钟，一般用 1 小时，夜间批量用 1 天。

#### 节点2：Code —— 记录同步开始

命名为「记录同步开始」：

```javascript
// 记录本次同步任务信息
const syncTask = {
  syncId: 'SYNC-' + Date.now(),
  startTime: new Date().toISOString(),
  status: 'running',
  source: 'SystemA-CRM',
  target: 'SystemB-ERP',
  stats: {
    total: 0,
    created: 0,
    updated: 0,
    deleted: 0,
    unchanged: 0,
    errors: 0
  }
};

// 保存上次同步时间（实际项目中从数据库/文件读取）
// 这里用静态变量模拟
if (!global.lastSyncTime) {
  global.lastSyncTime = new Date(Date.now() - 3600000).toISOString(); // 默认1小时前
}

return {
  json: {
    ...syncTask,
    lastSyncTime: global.lastSyncTime
  }
};
```

#### 节点3：HTTP Request —— 从 System A 拉取数据

| 字段 | 值 |
|------|-----|
| Method | `GET` |
| URL | `https://your-crm-api.com/api/customers` |
| Authentication | `Header Auth` → `System A API Key` |
| Query Parameters | |

| Parameter Name | Parameter Value |
|----------------|-----------------|
| `updated_since` | `={{ $json.lastSyncTime }}` |
| `include_deleted` | `true` |

**Mock 替代方案**（用 Code 节点模拟）：

```javascript
// 模拟 System A CRM 返回的数据
const mockData = [
  {
    id: 'CRM-001',
    name: '张三',
    email: 'zhang@test.com',
    phone: '138-0001-0001',
    company: 'ABC科技',
    status: 'active',
    updatedAt: '2026-06-08T10:30:00Z',
    deleted: false
  },
  {
    id: 'CRM-002',
    name: '李四',
    email: 'li@test.com',
    phone: '138-0002-0002',
    company: 'XYZ贸易',
    status: 'active',
    updatedAt: '2026-06-08T10:15:00Z',
    deleted: false
  },
  {
    id: 'CRM-003',
    name: '王五',
    email: 'wang@test.com',
    phone: '138-0003-0003',
    company: '旧公司',
    status: 'inactive',
    updatedAt: '2026-06-08T09:00:00Z',
    deleted: true    // 标记为已删除
  },
  {
    id: 'CRM-004',
    name: '赵六',
    email: 'zhao@test.com',
    phone: '138-0004-0004',
    company: '新公司',
    status: 'active',
    updatedAt: '2026-06-07T20:00:00Z',
    deleted: false
  }
];

const syncInfo = $input.first().json;

return {
  json: {
    ...syncInfo,
    sourceData: mockData,
    sourceCount: mockData.length
  }
};
```

#### 节点4：Code —— 转换数据格式 A→B

命名为「格式转换 A→B」：

```javascript
const data = $input.first().json;
const sourceData = data.sourceData;

// System A 格式 → System B 格式的映射
const transformedData = sourceData.map(item => {
  // CRM 格式转 ERP 格式
  return {
    // 字段映射
    externalId: item.id,                      // CRM ID 作为外部ID
    customerName: item.name,                   // name → customerName
    contactEmail: item.email,                  // email → contactEmail
    contactPhone: item.phone || '',            // phone → contactPhone
    organization: item.company || '',          // company → organization

    // 状态映射
    active: item.status === 'active',          // status → active (boolean)

    // 变更检测用字段
    contentHash: createHash(JSON.stringify({
      name: item.name,
      email: item.email,
      phone: item.phone,
      company: item.company,
      status: item.status
    })),
    sourceUpdatedAt: item.updatedAt,
    deleted: item.deleted || false
  };
});

// 简单 hash 函数（实际项目用 crypto.createHash）
function createHash(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash; // Convert to 32bit integer
  }
  return Math.abs(hash).toString(16);
}

return {
  json: {
    ...data,
    transformedData: transformedData,
    transformedCount: transformedData.length
  }
};
```

> 💡 **为什么需要 contentHash？** 用于变更检测——如果 hash 值和上次同步时一样，说明数据没有变化，不需要更新。这比逐字段对比更高效。

#### 节点5：Code —— 检测变更

命名为「检测变更」：

```javascript
const data = $input.first().json;
const transformedData = data.transformedData;

// 获取上次同步的状态快照（实际项目从数据库读取）
if (!global.syncSnapshot) {
  global.syncSnapshot = {};  // 首次同步，快照为空
}

const changes = [];

for (const item of transformedData) {
  const previousItem = global.syncSnapshot[item.externalId];

  if (item.deleted && previousItem) {
    // 源系统中已删除 → 标记为 DELETE
    changes.push({
      ...item,
      operation: 'delete'
    });
  } else if (!previousItem) {
    // 新快照中没有此记录 → 标记为 CREATE
    changes.push({
      ...item,
      operation: 'create'
    });
  } else if (item.contentHash !== previousItem.contentHash) {
    // hash 不一致 → 标记为 UPDATE
    changes.push({
      ...item,
      operation: 'update',
      previousHash: previousItem.contentHash
    });
  }
  // hash 一致 → 无变化，跳过
}

// 更新快照（只保存未删除的记录）
for (const item of transformedData) {
  if (!item.deleted) {
    global.syncSnapshot[item.externalId] = item;
  } else {
    delete global.syncSnapshot[item.externalId];
  }
}

return {
  json: {
    ...data,
    changes: changes,
    changeCount: changes.length,
    hasChanges: changes.length > 0,
    changeSummary: {
      create: changes.filter(c => c.operation === 'create').length,
      update: changes.filter(c => c.operation === 'update').length,
      delete: changes.filter(c => c.operation === 'delete').length
    }
  }
};
```

**变更检测逻辑对比**：

| 方法 | 原理 | 优点 | 缺点 |
|------|------|------|------|
| **Hash 对比** | 计算内容哈希值比较 | 高效、准确 | 需要额外计算 hash |
| **时间戳对比** | 比较 `updatedAt` 字段 | 简单 | 依赖源系统时间戳准确 |
| **版本号对比** | 比较版本号字段 | 精确 | 需要源系统支持版本号 |
| **全量对比** | 逐字段比较 | 最准确 | 性能差 |

> 💡 **本实例使用 Hash 对比**——不依赖源系统的时间戳准确性，通过内容本身判断是否变化。

#### 节点6：IF —— 是否有变更

| 字段 | 值 |
|------|-----|
| Condition | `{{ $json.hasChanges }}` equals `true` |

**False 分支** → Code（无变更记录）：

```javascript
const data = $input.first().json;

// 更新同步时间
global.lastSyncTime = new Date().toISOString();

return {
  json: {
    syncId: data.syncId,
    status: 'completed',
    message: '无数据变更，跳过同步',
    startTime: data.startTime,
    endTime: new Date().toISOString(),
    stats: {
      total: data.sourceCount,
      created: 0,
      updated: 0,
      deleted: 0,
      unchanged: data.sourceCount,
      errors: 0
    }
  }
};
```

#### 节点7：Split Out —— 拆分每条变更

| 字段 | 值 |
|------|-----|
| Field to Split Out | `changes` |

将 `changes` 数组拆分为多条记录，每条记录单独处理。

#### 节点8：Switch —— 按操作类型路由

| 输出编号 | 条件 | 说明 |
|----------|------|------|
| 0 | `{{ $json.operation }}` equals `create` | 新增 |
| 1 | `{{ $json.operation }}` equals `update` | 更新 |
| 2 | `{{ $json.operation }}` equals `delete` | 删除 |

#### 节点9-1：HTTP Request —— System B 创建 (POST)

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://your-erp-api.com/api/customers` |
| Authentication | `Header Auth` → `System B API Key` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Body | 见下方 |

Body：

```json
{
  "externalId": "{{ $json.externalId }}",
  "customerName": "{{ $json.customerName }}",
  "contactEmail": "{{ $json.contactEmail }}",
  "contactPhone": "{{ $json.contactPhone }}",
  "organization": "{{ $json.organization }}",
  "active": {{ $json.active }}
}
```

**Retry on Fail 设置**（在 Settings 选项卡中）：

| 字段 | 值 | 说明 |
|------|-----|------|
| Retry On Fail | `ON` | 失败自动重试 |
| Max Tries | `3` | 最多重试 3 次 |
| Wait Between Tries | `5000` | 每次重试间隔 5 秒 |

#### 节点9-2：HTTP Request —— System B 更新 (PUT)

| 字段 | 值 |
|------|-----|
| Method | `PUT` |
| URL | `https://your-erp-api.com/api/customers/{{ $json.externalId }}` |
| 其余配置同 POST | |

#### 节点9-3：HTTP Request —— System B 删除 (DELETE)

| 字段 | 值 |
|------|-----|
| Method | `DELETE` |
| URL | `https://your-erp-api.com/api/customers/{{ $json.externalId }}` |
| 其余配置同 POST | |

#### 节点10：Code —— 记录每条同步结果

命名为「记录同步结果」：

```javascript
const operationData = $('Split Out').item.json;
const httpResponse = $input.first().json;

const isSuccess = httpResponse.statusCode >= 200 && httpResponse.statusCode < 300;

return {
  json: {
    externalId: operationData.externalId,
    operation: operationData.operation,
    success: isSuccess,
    httpStatus: httpResponse.statusCode || 'N/A',
    timestamp: new Date().toISOString(),
    error: isSuccess ? null : (httpResponse.message || 'Unknown error')
  }
};
```

#### 节点11：Code —— 汇总同步结果

命名为「汇总同步结果」：

```javascript
// 从所有「记录同步结果」节点收集结果
const results = $input.all();

const stats = {
  total: results.length,
  created: results.filter(r => r.json.operation === 'create' && r.json.success).length,
  updated: results.filter(r => r.json.operation === 'update' && r.json.success).length,
  deleted: results.filter(r => r.json.operation === 'delete' && r.json.success).length,
  unchanged: 0,
  errors: results.filter(r => !r.json.success).length
};

const failedItems = results
  .filter(r => !r.json.success)
  .map(r => `${r.json.externalId} (${r.json.operation}): ${r.json.error}`);

// 如果有错误，发送告警通知
if (stats.errors > 0) {
  // 调用子工作流处理错误
  // 实际使用 Execute Workflow 节点调用 sub-error-handler
  console.log('[SYNC ERROR]', JSON.stringify({
    syncId: $('记录同步开始').first().json.syncId,
    failedItems: failedItems,
    errorCount: stats.errors
  }));
}

// 更新最后同步时间
global.lastSyncTime = new Date().toISOString();

return {
  json: {
    syncId: $('记录同步开始').first().json.syncId,
    status: stats.errors > 0 ? 'completed_with_errors' : 'completed',
    startTime: $('记录同步开始').first().json.startTime,
    endTime: new Date().toISOString(),
    stats: stats,
    failedItems: failedItems.length > 0 ? failedItems : null,
    message: stats.errors > 0
      ? `同步完成（有${stats.errors}条失败）`
      : `同步完成，共处理${stats.total}条变更`
  }
};
```

### 🧪 测试验证

**测试1：首次同步（全量新增）**

首次运行时，所有记录都会被标记为 `create`。

**预期日志**：

```
[SYNC] syncId: SYNC-1749369000000
[SYNC] status: running
[SYNC] changes detected: 4 items
  - CRM-001: create
  - CRM-002: create
  - CRM-003: create
  - CRM-004: create
[SYNC] status: completed
[SYNC] stats: { total: 4, created: 4, updated: 0, deleted: 0, errors: 0 }
```

**测试2：增量同步（部分更新）**

修改 Mock 数据中某条记录（如改变张三的 email），再次运行。

**预期日志**：

```
[SYNC] syncId: SYNC-1749372600000
[SYNC] changes detected: 1 item
  - CRM-001: update (hash changed)
[SYNC] stats: { total: 1, created: 0, updated: 1, deleted: 0, errors: 0 }
```

**测试3：删除同步**

在 Mock 数据中将某条记录标记为 `deleted: true`，再次运行。

**预期日志**：

```
[SYNC] changes detected: 1 item
  - CRM-003: delete
[SYNC] stats: { total: 1, created: 0, updated: 0, deleted: 1, errors: 0 }
```

**测试4：无变更**

不做任何修改，再次运行。

**预期日志**：

```
[SYNC] no changes detected, skipping
```

### ✋ 费曼检测

1. 变更检测中，Hash 对比和时间戳对比各有什么优缺点？
2. 为什么 Split Out 节点要放在 IF（有变更）之后，而不是之前？
3. 如果 System B 的 API 创建了一条记录但返回超时，重试会导致重复创建吗？如何保证幂等性？

---

## 🍅 番茄钟6结束，休息5分钟

**核心概念回顾：**
- [ ] ETL 管道 = Extract（拉取）→ Transform（转换）→ Load（写入）
- [ ] 变更检测：Hash 对比比时间戳更可靠
- [ ] Split Out + Switch 实现差异化操作
- [ ] Retry On Fail + Continue On Fail 保证健壮性

---

## 🍅 番茄钟7：实例17 · 子工作流、扩展与费曼检测

### 🔧 子工作流配置 —— sub-error-handler

子工作流是独立的错误处理器，任何工作流出错时都可以调用它。

**创建子工作流**：

1. 新建工作流，命名为 `sub-error-handler`
2. 添加以下节点：

#### 节点1：Error Trigger

这是子工作流的入口——当其他工作流出错时自动触发。

> 💡 Error Trigger 只在作为子工作流被调用时生效。它接收的输入包含完整的错误信息。

#### 节点2：Code —— 格式化错误信息

```javascript
const errorInfo = $input.first().json;

const formattedError = {
  errorId: 'ERR-' + Date.now(),
  workflowId: errorInfo.workflow?.id || 'unknown',
  workflowName: errorInfo.workflow?.name || 'unknown',
  executionId: errorInfo.execution?.id || 'unknown',
  nodeName: errorInfo.execution?.error?.node?.name || 'unknown',
  nodeType: errorInfo.execution?.error?.node?.type || 'unknown',
  errorMessage: errorInfo.execution?.error?.message || 'Unknown error',
  timestamp: new Date().toISOString(),
  severity: 'high'
};

// 根据错误类型判断严重程度
const message = formattedError.errorMessage.toLowerCase();
if (message.includes('timeout') || message.includes('econnrefused')) {
  formattedError.severity = 'critical';
  formattedError.suggestion = '目标服务不可达，检查网络和服务状态';
} else if (message.includes('401') || message.includes('403')) {
  formattedError.severity = 'high';
  formattedError.suggestion = '认证失败，检查 API Key 是否过期';
} else if (message.includes('429')) {
  formattedError.severity = 'medium';
  formattedError.suggestion = '请求频率超限，考虑降低同步频率';
} else if (message.includes('500')) {
  formattedError.severity = 'high';
  formattedError.suggestion = '目标服务内部错误，联系对方技术支持';
}

return { json: formattedError };
```

#### 节点3：HTTP Request —— 发送告警通知

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `YOUR_ALERT_WEBHOOK_URL` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Body | 见下方 |

Body：

```json
{
  "msgtype": "markdown",
  "markdown": {
    "title": "=同步错误告警 [{{ $json.severity }}]",
    "text": "=## 工作流错误告警\n\n**错误ID**: {{ $json.errorId }}\n**工作流**: {{ $json.workflowName }}\n**出错节点**: {{ $json.nodeName }} ({{ $json.nodeType }})\n**错误信息**: {{ $json.errorMessage }}\n**严重程度**: {{ $json.severity }}\n**时间**: {{ $json.timestamp }}\n\n**建议**: {{ $json.suggestion }}"
  }
}
```

#### 节点4：Code —— 记录错误日志

```javascript
const errorData = $input.first().json;

// 实际项目中，写入错误日志数据库
console.log('[ERROR LOG]', JSON.stringify(errorData, null, 2));

return {
  json: {
    logged: true,
    errorId: errorData.errorId,
    severity: errorData.severity,
    timestamp: errorData.timestamp
  }
};
```

#### 在主工作流中调用子工作流

在主工作流中，将汇总结果中的错误处理替换为 **Execute Workflow** 节点：

| 字段 | 值 |
|------|-----|
| Source | `Database` |
| Workflow ID | 选择 `sub-error-handler` |
| Mode | `Wait for Sub-Workflow` |

> 💡 Execute Workflow 节点可以将错误处理逻辑复用到所有工作流中——这就是子工作流的核心价值。

### 💡 变体与扩展

#### 变体1：实时同步（Webhook 驱动）

将 Schedule Trigger 替换为 Webhook Trigger，由 System A 主动推送变更事件：

```
Webhook (System A 推送变更事件) → Code (解析事件) → Switch (事件类型)
  ├── created → Code (转换格式) → HTTP Request (System B POST)
  ├── updated → Code (转换格式) → HTTP Request (System B PUT)
  └── deleted → HTTP Request (System B DELETE)
```

**优势**：实时性更高（秒级 vs 小时级）
**劣势**：依赖源系统支持 Webhook 推送

#### 变体2：批量写入优化

当变更数量很大时，逐条写入太慢，可以批量写入：

```
Code (按操作类型分组，每50条一批) → Split Out → HTTP Request (批量 API)
```

**关键点**：检查 System B 是否支持批量 API（如 `POST /api/customers/batch`）

#### 变体3：双向同步

双向同步增加了冲突检测：

```
System A → Code (检测变更A) ─────────────────→ Code (合并变更)
                                                    │
System B → Code (检测变更B) ─────────────────→ ─────┘
                                                    │
                                                    ▼
                                            Code (冲突检测)
                                                    │
                                           ┌── 无冲突 → 分别写入
                                           └── 有冲突 → Code (冲突策略)
                                                            │
                                                   ┌── 最后修改优先
                                                   ├── 指定来源优先
                                                   └── 人工决策
```

**冲突策略**：

| 策略 | 说明 | 适用场景 |
|------|------|----------|
| 最后修改优先 | updatedAt 更新的胜出 | 大多数场景 |
| 指定来源优先 | System A 的数据优先 | 有主从关系的场景 |
| 人工决策 | 冲突时发通知让人决定 | 关键数据不容自动覆盖 |

#### 变体4：幂等性保证

确保重复执行同步不会产生副作用：

```javascript
// 在写入 System B 之前，先检查是否已存在
// 如果已存在且内容一致，跳过写入
const existingRecord = await checkSystemB(externalId);

if (operation === 'create' && existingRecord) {
  // 记录已存在，跳过创建（幂等）
  return { json: { skipped: true, reason: 'record already exists' } };
}

if (operation === 'update' && existingRecord?.contentHash === newHash) {
  // 内容一致，跳过更新（幂等）
  return { json: { skipped: true, reason: 'content unchanged' } };
}
```

#### 企业级数据同步功能清单

| 功能 | 实现难度 | 优先级 | 说明 |
|------|----------|--------|------|
| 定时拉取 | 低 | P0 | 本实例已实现 |
| 格式转换 | 低 | P0 | 本实例已实现 |
| 变更检测 (Hash) | 中 | P0 | 本实例已实现 |
| 差异化操作 | 中 | P0 | 本实例已实现 |
| 子工作流错误处理 | 中 | P1 | 本实例已实现 |
| 重试机制 | 低 | P0 | HTTP Request 内置 |
| 实时同步 (Webhook) | 中 | P1 | 变体1 |
| 批量写入 | 中 | P2 | 变体2 |
| 双向同步 + 冲突检测 | 高 | P3 | 变体3 |
| 完整幂等性 | 中 | P1 | 变体4 |
| 死信队列 | 高 | P2 | 多次重试失败的记录单独处理 |
| 同步看板 | 中 | P2 | 可视化同步状态 |

### ✋ 费曼检测

1. 子工作流 (sub-error-handler) 的优势是什么？为什么不直接在主工作流中处理错误？
2. 幂等性是什么意思？为什么数据同步必须考虑幂等性？举例说明非幂等操作的危害。
3. 双向同步的核心难点是什么？为什么单向同步比双向同步简单得多？
4. 如果 System A 的 API 返回了 10000 条变更，逐条写入 System B 会很慢。你会如何优化？

---

## 🍅 番茄钟7结束，休息5分钟

**验证清单：**
- [ ] 完成了跨系统数据同步工作流的搭建
- [ ] 理解 ETL 管道的三个阶段
- [ ] 掌握了 Hash 对比变更检测方法
- [ ] 理解了 Split Out + Switch 实现差异化操作
- [ ] 创建了子工作流 sub-error-handler
- [ ] 理解了幂等性的概念和实现方式
- [ ] 测试了首次同步、增量同步、无变更三种场景

---

## 🍅 番茄钟8：今日复习 + 费曼综合检测

### 企业级模式对比表

| 模式 | 实例16（审批流） | 实例17（数据同步） | 通用场景 |
|------|------------------|-------------------|----------|
| **触发方式** | Webhook（事件驱动） | Schedule（定时驱动） | 按需 vs 定期 |
| **状态管理** | requestId 追踪 | contentHash + syncSnapshot | 追踪 + 快照 |
| **路由逻辑** | Switch 按金额分级 | Switch 按操作类型分流 | 规则路由 |
| **暂停等待** | Wait 节点等审批 | 无（同步是自动的） | 人机交互场景 |
| **容错** | Continue On Fail | Retry On Fail + 子工作流 | 非关键 vs 可重试 |
| **审计** | 审批日志 | 同步结果日志 | 合规 + 追踪 |
| **超时** | 24h 超时自动拒绝 | HTTP 请求超时 | 防挂起 |
| **幂等性** | requestId 去重 | contentHash 跳过 | 安全重试 |

### 错误处理决策树

```
错误发生了
  │
  ├── 这个错误是否影响主流程？
  │     │
  │     ├── 否（如：通知发送失败）
  │     │     └── Continue On Fail = ON
  │     │         └── 记录错误日志，流程继续
  │     │
  │     └── 是（如：数据写入失败）
  │           │
  │           ├── 是否可能临时故障？
  │           │     │
  │           │     ├── 是（网络超时、服务短暂不可用）
  │           │     │     └── Retry On Fail = ON (3次, 间隔5秒)
  │           │     │
  │           │     └── 否（数据格式错误、权限不足）
  │           │           └── 记录错误 + 发送告警
  │           │
  │           ├── 是否需要统一错误处理？
  │           │     │
  │           │     ├── 是 → 调用子工作流 sub-error-handler
  │           │     │
  │           │     └── 否 → IF 分支处理
  │           │
  │           └── 重试后仍然失败？
  │                 │
  │                 ├── 关键数据 → 发送高优先级告警 + 人工介入
  │                 └── 非关键数据 → 记录到死信队列 + 继续处理其他数据
```

### 企业级工作流监控清单

| 监控项 | 检查方式 | 告警阈值 | 处理动作 |
|--------|----------|----------|----------|
| **执行频率** | 查看 Executions 列表 | 连续 3 次未执行 | 检查 Trigger 配置 |
| **执行时长** | 查看执行耗时 | 超过正常值 3 倍 | 检查是否有阻塞节点 |
| **错误率** | 统计失败/成功比 | 错误率 > 10% | 检查上游 API 状态 |
| **Wait 队列** | 查看 Waiting Executions | 积压 > 50 条 | 检查审批响应是否正常 |
| **API 响应时间** | HTTP Request 节点耗时 | 平均 > 5 秒 | 检查目标服务性能 |
| **数据量** | 每次同步的变更数 | 突增 10 倍 | 检查是否有批量操作 |
| **凭证有效期** | 手动检查 | 即将过期 | 提前续期 API Key |
| **磁盘空间** | 服务器监控 | > 80% | 清理执行日志 |

### 费曼综合检测

**请用自己的话回答以下问题**（不要翻看上面的内容）：

1. **Wait 节点**：请解释 Wait 节点是如何实现「暂停等待」的。当审批人点击审批链接时，n8n 是怎么找到对应的工作流执行实例并恢复的？

2. **变更检测**：如果你需要同步 100 万条数据，每条数据有 50 个字段，你会如何设计变更检测策略来保证性能？

3. **错误处理三件套**：Continue On Fail、Retry On Fail、子工作流——请分别解释它们的使用场景，以及为什么不能只用一种。

4. **幂等性**：以下操作哪些是幂等的，哪些不是？
   - `POST /api/customers`（创建客户）
   - `PUT /api/customers/123`（更新客户 123）
   - `DELETE /api/customers/123`（删除客户 123）
   - `POST /api/orders`（创建订单）

5. **架构选择**：什么时候用 Webhook Trigger，什么时候用 Schedule Trigger？请各举 2 个例子。

---

### 刻意练习——企业级模式

**练习目标**：为工作流添加完整的企业级容错机制（错误处理 + 监控 + 重试）

**任务序列（重复×3）：**

```
===== 循环 1：3 种错误处理策略 =====
为一个 HTTP Request 节点依次添加以下 3 种错误处理：
1. Continue On Fail + IF 状态码判断
2. Retry On Fail（最大 3 次，间隔 5 秒）
3. Error Trigger 子工作流（记录错误并发送通知）
验证：故意使用无效 URL，确认每种策略都能正确拦截错误

===== 循环 2：监控与日志 =====
在已有工作流中添加完整监控：
1. Code 节点记录执行日志（含时间戳和关键数据快照）
2. 每次执行完成后发送状态通知（成功/失败/耗时）
3. 在关键节点添加 console.log 调试输出
验证：工作流执行后能查看完整的日志链路

===== 循环 3：企业级容错工作流 =====
构建带完整容错机制的工作流：
Webhook → 数据验证（IF）→ 核心处理
→ 成功分支：记录日志 → 返回结果
→ 失败分支：Error Handler（记录 + 通知）+ 自动重试
验证：故意制造错误，确认容错机制全部按预期生效
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Continue On Fail 与 Retry | ⬜ | ⬜ | ⬜ |
| Error Trigger 子工作流 | ⬜ | ⬜ | ⬜ |
| 执行日志与监控配置 | ⬜ | ⬜ | ⬜ |
| 完整容错架构设计 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：企业级工作流和普通工作流的核心区别是什么？如果一个工作流没有任何容错机制就直接上生产，最坏情况下会发生什么？

---

### 今日自检清单

完成以下所有项才算通过 Day 6：

- [ ] 搭建了多级审批工作流，理解 Wait 节点的工作原理
- [ ] 实现了按金额分级路由（Switch 节点）
- [ ] 理解超时处理和 Continue On Fail 的使用场景
- [ ] 搭建了跨系统数据同步工作流，理解 ETL 管道
- [ ] 实现了 Hash 对比变更检测
- [ ] 理解了 Split Out + Switch 实现差异化操作
- [ ] 创建了子工作流 sub-error-handler
- [ ] 理解了幂等性的概念和实现方式
- [ ] 能根据错误处理决策树选择合适的容错策略
- [ ] 能解释企业级工作流与普通工作流的核心区别

### 费曼一句话总结

> **企业级工作流和普通工作流的区别在于「可靠性设计」——Wait 节点实现人机协作、Hash 对比实现增量同步、Continue On Fail 保证流程不中断、子工作流统一错误处理、幂等性保证安全重试。这些模式让你的工作流从「能跑」变成「敢上生产」。**

### 学习笔记

```markdown
## Day 6 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 可以应用到工作中的场景
（想想你的公司有哪些审批流或数据同步需求）

### 明天想深入的方向
（为 Day 7 做准备）
```

---

## 🎉 Day 6 完成！

**今日成果：**
- 搭建了多级审批工作流（Webhook + Wait + Switch + Continue On Fail）
- 掌握了 Wait 节点的完整配置（Webhook 恢复 + 超时保护）
- 搭建了跨系统数据同步工作流（ETL + Hash 变更检测 + 差异化操作）
- 创建了子工作流 sub-error-handler（统一错误处理）
- 理解了企业级工作流的核心模式：可靠性设计

**明天预告：** [[实例Day7-Obsidian深度集成]] - 3 个 Obsidian 工作流，让你的知识库自动化运转

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[实例Day5-AI智能工作流]] - 上一天
> - [[实例Day7-Obsidian深度集成]] - 下一天
