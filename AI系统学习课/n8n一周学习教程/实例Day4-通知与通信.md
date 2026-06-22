# Day 4：通知与通信（3个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建3个通知通信工作流，掌握多渠道推送、邮件处理、机器人集成
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：实例10 · 多渠道通知中心
🍅 番茄3-4：实例11 · 邮件自动分类与回复
🍅 番茄5-6：实例12 · 钉钉/飞书机器人
🍅 番茄7-8：今日复习 + 费曼综合检测
```

---

## 🍅 番茄1-2：实例10 · 多渠道通知中心

### 🎯 场景与目标

**场景**：你的团队同时使用钉钉、Slack、邮件三种沟通工具。每次发通知都要分别打开三个应用手动发送，效率低下且容易遗漏。

**目标**：搭建一个统一通知 API，一次请求就能推送到指定渠道，支持优先级标记和不同平台的格式适配。

```
传统方式：                            统一通知 API：
┌──────────────────────┐             ┌──────────────────────┐
│  发钉钉消息 → 切应用   │             │  POST /notify         │
│  发 Slack  → 切应用   │             │  {                    │
│  发邮件    → 切应用   │             │    channel: "slack",  │
│  三次操作，三种格式    │             │    title: "...",      │
└──────────────────────┘             │    message: "..."     │
                                     │  }                    │
                                     │  → 一键搞定           │
                                     └──────────────────────┘
```

**你将学到**：
- 用 Webhook 搭建统一 API 入口
- 用 Switch 节点做多路由分发
- 不同平台的消息格式适配
- 优先级处理逻辑

---

### 🏗️ 工作流架构图

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Webhook     │    │  Code        │    │  Switch      │
│  Trigger     │───→│  验证输入    │───→│  按 channel  │
│  POST /notify│    │  标准化数据  │    │  路由分发    │
└──────────────┘    └──────────────┘    └──────┬───────┘
                                               │
                    ┌──────────┬──────────┬─────┴─────┐
                    ▼          ▼          ▼           ▼
              ┌──────────┐┌──────────┐┌──────────┐┌──────────┐
              │ HTTP Req ││ HTTP Req ││ HTTP Req ││ HTTP Req │
              │ Slack    ││ 钉钉     ││ Email    ││ 自定义   │
              │ 推送     ││ 推送     ││ 发送     ││ Webhook  │
              └──────────┘└──────────┘└──────────┘└──────────┘
```

---

### 🔑 API/凭证准备

#### Slack Incoming Webhook

| 步骤 | 操作 |
|------|------|
| 1 | 访问 https://api.slack.com/messaging/webhooks |
| 2 | 点击「Create your Slack app」 |
| 3 | 选择「From scratch」，填入 App Name（如 `n8n-notify`），选择 Workspace |
| 4 | 左侧菜单选「Incoming Webhooks」→ 打开开关 |
| 5 | 点击「Add New Webhook to Workspace」 |
| 6 | 选择要发送消息的频道，点击「Allow」 |
| 7 | 复制 Webhook URL（格式：`https://hooks.slack.com/services/T.../B.../xxx`） |

#### 钉钉自定义机器人 Webhook

| 步骤 | 操作 |
|------|------|
| 1 | 打开钉钉群 → 群设置（右上角齿轮） |
| 2 | 智能群助手 → 添加机器人 → 自定义 |
| 3 | 填写机器人名字（如 `通知中心`） |
| 4 | 安全设置三选一（推荐「加签」）：勾选「加签」→ 复制 Secret |
| 5 | 点击完成 → 复制 Webhook URL（格式：`https://oapi.dingtalk.com/robot/send?access_token=xxx`） |

> ⚠️ 钉钉安全设置说明：
> - **自定义关键词**：消息中必须包含指定关键词才能发送
> - **加签**：发送时需计算签名，安全性最高（本教程采用此方式）
> - **IP地址段**：限制来源 IP

#### 邮箱 SMTP（用于邮件发送）

| 步骤 | 操作 |
|------|------|
| 1 | 使用 QQ 邮箱：设置 → 账户 → 开启 SMTP 服务 |
| 2 | 按提示用手机发短信验证 |
| 3 | 获取授权码（不是登录密码） |
| 4 | 记录 SMTP 服务器：`smtp.qq.com`，端口 `465`（SSL） |

---

### 🔧 逐节点配置

#### 节点1：Webhook Trigger

| 配置项 | 值 |
|--------|-----|
| HTTP Method | `POST` |
| Path | `notify` |
| Response Mode | `Last Node` |

请求体示例（发送测试时用）：

```json
{
  "channel": "slack",
  "title": "系统告警",
  "message": "CPU 使用率超过 90%",
  "priority": "urgent"
}
```

#### 节点2：Code（验证输入 & 标准化）

| 配置项 | 值 |
|--------|-----|
| Mode | `Run Once for All Items` |

```javascript
// 获取 Webhook 传入的 body 数据
const body = $input.first().json.body;

// 验证必填字段
const requiredFields = ['channel', 'title', 'message'];
const missing = requiredFields.filter(f => !body[f]);

if (missing.length > 0) {
  return [{
    json: {
      success: false,
      error: `缺少必填字段: ${missing.join(', ')}`,
      required: 'channel, title, message',
      optional: 'priority (urgent/normal/low, 默认 normal)'
    }
  }];
}

// 标准化 channel（兼容中英文）
const channelMap = {
  'slack': 'slack',
  'dingtalk': 'dingtalk',
  '钉钉': 'dingtalk',
  'email': 'email',
  '邮件': 'email',
  'webhook': 'webhook',
  '自定义': 'webhook'
};

const channel = channelMap[body.channel.toLowerCase()] || body.channel.toLowerCase();

// 标准化 priority
const priorityMap = {
  'urgent': 'urgent',
  '紧急': 'urgent',
  'normal': 'normal',
  '普通': 'normal',
  'low': 'low',
  '低': 'low'
};

const priority = priorityMap[body.priority?.toLowerCase()] || 'normal';

// 优先级对应 emoji
const priorityEmoji = {
  'urgent': '🔴',
  'normal': '🟡',
  'low': '🟢'
};

return [{
  json: {
    channel: channel,
    title: body.title,
    message: body.message,
    priority: priority,
    priorityEmoji: priorityEmoji[priority],
    timestamp: new Date().toISOString()
  }
}];
```

#### 节点3：Switch（按 channel 路由）

| 配置项 | 值 |
|--------|-----|
| Field to match | `{{ $json.channel }}` |

路由规则：

| Output | Condition | 说明 |
|--------|-----------|------|
| 0 | `slack` | Slack 推送 |
| 1 | `dingtalk` | 钉钉推送 |
| 2 | `email` | 邮件发送 |
| 3 | `webhook` | 自定义 Webhook |

#### 节点4a：HTTP Request（Slack 推送）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `https://hooks.slack.com/services/T.../B.../xxx`（你的 Slack Webhook URL） |
| Authentication | None |
| Body Type | JSON |

Body（Send Body 开启）：

```json
{
  "text": "{{ $json.priorityEmoji }} [{{ $json.priority }}] {{ $json.title }}",
  "blocks": [
    {
      "type": "header",
      "text": {
        "type": "plain_text",
        "text": "{{ $json.priorityEmoji }} {{ $json.title }}"
      }
    },
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "{{ $json.message }}"
      }
    },
    {
      "type": "context",
      "elements": [
        {
          "type": "mrkdwn",
          "text": "优先级: {{ $json.priority }} | 时间: {{ $json.timestamp }}"
        }
      ]
    }
  ]
}
```

> 💡 Slack Block Kit 让消息更美观，参考：https://app.slack.com/block-kit-builder

#### 节点4b：HTTP Request（钉钉推送）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | 需动态拼接签名 URL（见下方 Code 节点处理） |
| Authentication | None |
| Body Type | JSON |

由于钉钉需要签名验证，我们需要一个 **Code 节点** 在 HTTP Request 之前计算签名：

**Code 节点（计算钉钉签名）**：

```javascript
const crypto = require('crypto');

const secret = 'SEC_xxx...'; // 替换为你的钉钉机器人加签 Secret
const timestamp = Date.now();

// 计算签名: timestamp + "\n" + secret → HmacSHA256 → Base64
const stringToSign = `${timestamp}\n${secret}`;
const hmac = crypto.createHmac('sha256', secret);
hmac.update(stringToSign);
const sign = encodeURIComponent(hmac.digest('base64'));

// 拼接完整 Webhook URL
const webhookBase = 'https://oapi.dingtalk.com/robot/send?access_token=xxx'; // 替换为你的 token
const fullUrl = `${webhookBase}&timestamp=${timestamp}&sign=${sign}`;

// 根据优先级选择消息格式
const inputData = $input.first().json;

// Markdown 格式消息
const body = {
  msgtype: 'markdown',
  markdown: {
    title: `${inputData.priorityEmoji} ${inputData.title}`,
    text: `### ${inputData.priorityEmoji} ${inputData.title}\n\n` +
          `${inputData.message}\n\n` +
          `> 优先级: **${inputData.priority}**\n\n` +
          `> 时间: ${inputData.timestamp}`
  }
};

return [{
  json: {
    dingtalkUrl: fullUrl,
    dingtalkBody: body
  }
}];
```

**HTTP Request 节点（钉钉）**：

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `={{ $json.dingtalkUrl }}` |
| Body Type | JSON |
| Body | `={{ $json.dingtalkBody }}` |

#### 节点4c：Send Email（邮件发送）

| 配置项 | 值 |
|--------|-----|
| From | `n8n-notify@xxx.com` |
| To | `team@xxx.com`（你的团队邮箱） |
| Subject | `={{ $json.priorityEmoji }} [{{ $json.priority }}] {{ $json.title }}` |
| Text | `={{ $json.message }}\n\n---\n优先级: {{ $json.priority }}\n时间: {{ $json.timestamp }}` |

Credentials 配置（SMTP）：

| 配置项 | 值 |
|--------|-----|
| Host | `smtp.qq.com` |
| Port | `465` |
| SSL/TLS | 开启 |
| User | 你的 QQ 邮箱 |
| Password | 授权码（非登录密码） |

#### 节点4d：HTTP Request（自定义 Webhook）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | 你的自定义 Webhook URL |
| Body Type | JSON |

```json
{
  "title": "{{ $json.title }}",
  "message": "{{ $json.message }}",
  "priority": "{{ $json.priority }}",
  "timestamp": "{{ $json.timestamp }}"
}
```

---

### 🧪 测试验证

#### 测试1：Slack 通知

```bash
curl -X POST http://localhost:5678/webhook-test/notify \
  -H "Content-Type: application/json" \
  -d '{
    "channel": "slack",
    "title": "系统告警",
    "message": "CPU 使用率超过 90%，请立即处理",
    "priority": "urgent"
  }'
```

**预期**：Slack 频道收到一条带红色标记的格式化消息。

#### 测试2：钉钉通知

```bash
curl -X POST http://localhost:5678/webhook-test/notify \
  -H "Content-Type: application/json" \
  -d '{
    "channel": "dingtalk",
    "title": "部署完成",
    "message": "v2.1.0 已成功部署到生产环境",
    "priority": "normal"
  }'
```

**预期**：钉钉群收到一条 Markdown 格式的通知消息。

#### 测试3：邮件通知

```bash
curl -X POST http://localhost:5678/webhook-test/notify \
  -H "Content-Type: application/json" \
  -d '{
    "channel": "email",
    "title": "周报提醒",
    "message": "请在本周五前提交本周工作周报",
    "priority": "low"
  }'
```

**预期**：邮箱收到一封带绿色标记的提醒邮件。

#### 测试4：缺少必填字段

```bash
curl -X POST http://localhost:5678/webhook-test/notify \
  -H "Content-Type: application/json" \
  -d '{
    "channel": "slack"
  }'
```

**预期**：返回错误信息，提示缺少 `title` 和 `message` 字段。

---

### 💡 变体与扩展

| 变体 | 说明 |
|------|------|
| **多渠道同时推送** | 去掉 Switch，改用 `channel` 为数组（如 `["slack", "dingtalk"]`），用 Split Out 拆分后并行推送 |
| **定时摘要通知** | 用 Schedule Trigger 替代 Webhook，每天 9:00 汇总昨日告警批量推送 |
| **告警升级** | priority=urgent 时同时推送到所有渠道 + 电话通知 |
| **消息模板** | 在 Code 节点中根据消息类型（告警/通知/日报）选择不同的消息模板 |
| **通知日志** | 在每个渠道节点后加一个 Notion/数据库写入节点，记录所有通知历史 |

---

### ✋ 费曼检测

1. **解释给小白**：用你自己的话解释，这个工作流为什么需要 Code 节点做验证，而不是直接让 Switch 处理？
2. **画图题**：不看书，画出「多渠道同时推送」版本的架构图（去掉 Switch，用 Split Out）。
3. **配置题**：钉钉的签名验证为什么要用 `timestamp + "\n" + secret` 的格式计算 HMAC？不用签名会怎样？
4. **设计题**：如果要加一个企业微信渠道，需要几步？每步做什么？

---

☕ *休息 5 分钟，活动一下身体*

---

## 🍅 番茄3-4：实例11 · 邮件自动分类与回复

### 🎯 场景与目标

**场景**：你每天收到大量邮件——客户咨询、垃圾邮件、新闻通讯、紧急事项混在一起，手动分类和回复耗时耗力。

**目标**：搭建工作流自动读取未读邮件 → AI 分类 → 自动回复 → 标记已处理。

```
原始痛点：                           自动化后：
┌──────────────────────┐             ┌──────────────────────┐
│  打开邮箱 → 50封未读  │             │  每5分钟自动检查      │
│  逐封阅读判断类型     │             │  AI 智能分类          │
│  手动回复常见问题     │             │  自动回复模板         │
│  30分钟才能处理完     │             │  3分钟全部搞定        │
└──────────────────────┘             └──────────────────────┘
```

**你将学到**：
- IMAP 读取邮件 + SMTP 发送邮件
- 调用 OpenAI 做文本分类
- Switch 多路分支处理
- 邮件自动回复模板设计

---

### 🏗️ 工作流架构图

**完整版（有 IMAP/SMTP 环境）**：

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│  Schedule    │   │  IMAP        │   │  Code        │   │  HTTP Req    │
│  Trigger     │──→│  读取未读邮件 │──→│  提取邮件摘要 │──→│  OpenAI 分类  │
│  每5分钟     │   │              │   │              │   │              │
└──────────────┘   └──────────────┘   └──────────────┘   └──────┬───────┘
                                                              │
                                                       ┌──────┴───────┐
                                                       │  Switch      │
                                                       │  按分类路由  │
                                                       └──┬──┬──┬──┬─┘
                                                          │  │  │  │
                        ┌─────────┬──────────┬────────────┘  │  │
                        ▼         ▼          ▼               │  │
                  ┌──────────┐┌──────────┐┌──────────┐      │  │
                  │ Set      ││ Set      ││ Set      │      │  │
                  │ 紧急回复  ││ 普通回复  ││ 垃圾标记  │      │  │
                  └────┬─────┘└────┬─────┘└────┬─────┘      │  │
                       └─────┬─────┘           │            │  │
                             ▼                 │            │  │
                      ┌──────────────┐         │            │  │
                      │  SMTP        │         │            │  │
                      │  发送自动回复 │←────────┘            │  │
                      └──────┬───────┘                      │  │
                             ▼                              │  │
                      ┌──────────────┐         ┌───────────┘  │
                      │  Code        │         │              ▼
                      │  标记已处理  │─────────┤     ┌──────────┐
                      └──────────────┘         └────→│ Set      │
                                                     │ 通讯录  │
                                                     │ 回复    │
                                                     └──────────┘
```

**Webhook 模拟版（无需 IMAP/SMTP）**：

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│  Webhook     │   │  Code        │   │  HTTP Req    │   │  Switch      │
│  POST /email │──→│  模拟邮件数据 │──→│  OpenAI 分类  │──→│  按分类路由  │
└──────────────┘   └──────────────┘   └──────────────┘   └──────┬───────┘
                                                               │
                        ┌──────────┬──────────┬────────────────┘
                        ▼          ▼          ▼
                  ┌──────────┐┌──────────┐┌──────────┐
                  │ Set      ││ Set      ││ Set      │
                  │ 紧急通知  ││ 普通确认  ││ 垃圾忽略  │
                  └────┬─────┘└────┬─────┘└────┬─────┘
                       └─────┬─────┘           │
                             ▼                 │
                      ┌──────────────┐         │
                      │  HTTP Req    │←────────┘
                      │  推送通知    │
                      └──────────────┘
```

---

### 🔑 API/凭证准备

#### OpenAI API Key

| 步骤 | 操作 |
|------|------|
| 1 | 访问 https://platform.openai.com/api-keys |
| 2 | 登录/注册 → 点击「Create new secret key」 |
| 3 | 复制 Key（格式：`sk-...`），只显示一次 |
| 4 | 在 n8n 中：Settings → Credentials → Add → OpenAI API → 粘贴 Key |

#### IMAP/SMTP（可选，完整版需要）

| 邮箱 | IMAP 服务器 | 端口 | SMTP 服务器 | 端口 |
|------|------------|------|------------|------|
| QQ 邮箱 | `imap.qq.com` | 993 | `smtp.qq.com` | 465 |
| 163 邮箱 | `imap.163.com` | 993 | `smtp.163.com` | 465 |
| Gmail | `imap.gmail.com` | 993 | `smtp.gmail.com` | 587 |
| Outlook | `outlook.office365.com` | 993 | `smtp.office365.com` | 587 |

> 💡 如果没有 IMAP/SMTP 环境，请直接使用 Webhook 模拟版，效果相同。

---

### 🔧 逐节点配置（Webhook 模拟版）

#### 节点1：Webhook Trigger

| 配置项 | 值 |
|--------|-----|
| HTTP Method | `POST` |
| Path | `email` |
| Response Mode | `Last Node` |

请求体示例：

```json
{
  "from": "customer@example.com",
  "subject": "紧急：线上支付功能异常",
  "body": "您好，我们的线上支付模块从今天下午2点开始出现无法支付的问题，用户反馈量很大，请尽快处理。"
}
```

#### 节点2：Code（提取 & 标准化邮件摘要）

| 配置项 | 值 |
|--------|-----|
| Mode | `Run Once for All Items` |

```javascript
const input = $input.first().json;
const body = input.body || {};

// 提取邮件信息
const email = {
  from: body.from || 'unknown@example.com',
  subject: body.subject || '(无主题)',
  bodyPreview: (body.body || '').substring(0, 500) // 截取前500字符避免 token 过多
};

return [{
  json: {
    from: email.from,
    subject: email.subject,
    bodyPreview: email.bodyPreview,
    // 构造给 OpenAI 的分类 prompt
    classifyPrompt: `请对以下邮件进行分类。只返回一个分类词，不要返回其他内容。

可选分类：
- urgent：紧急事项，需要立即处理（如故障、投诉、截止日期）
- normal：普通邮件，需要回复但非紧急（如咨询、协作请求）
- spam：垃圾邮件或广告推广
- newsletter：订阅通讯、周报、资讯摘要

发件人: ${email.from}
主题: ${email.subject}
内容摘要: ${email.bodyPreview}

分类:`
  }
}];
```

#### 节点3：HTTP Request（OpenAI 分类）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | Header Auth |
| Header Name | `Authorization` |
| Header Value | `Bearer sk-...`（你的 OpenAI API Key） |
| Body Type | JSON |

```json
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "你是一个邮件分类助手。只返回分类词（urgent/normal/spam/newsletter），不返回任何解释。"
    },
    {
      "role": "user",
      "content": "{{ $json.classifyPrompt }}"
    }
  ],
  "temperature": 0,
  "max_tokens": 10
}
```

#### 节点4：Code（提取分类结果）

| 配置项 | 值 |
|--------|-----|
| Mode | `Run Once for All Items` |

```javascript
const input = $input.first().json;
const openaiResponse = input.json;

// 从 OpenAI 响应中提取分类
const content = openaiResponse.choices?.[0]?.message?.content?.trim().toLowerCase() || 'normal';

// 验证分类是否合法
const validCategories = ['urgent', 'normal', 'spam', 'newsletter'];
const category = validCategories.includes(content) ? content : 'normal';

// 从上游获取原始邮件信息（跨越节点引用）
const emailData = $('Code').item.json;

return [{
  json: {
    from: emailData.from,
    subject: emailData.subject,
    bodyPreview: emailData.bodyPreview,
    category: category,
    categoryLabel: {
      urgent: '🔴 紧急',
      normal: '🟡 普通',
      spam: '🗑️ 垃圾',
      newsletter: '📰 订阅'
    }[category]
  }
}];
```

#### 节点5：Switch（按分类路由）

| 配置项 | 值 |
|--------|-----|
| Field to match | `{{ $json.category }}` |

路由规则：

| Output | Condition | 说明 |
|--------|-----------|------|
| 0 | `urgent` | 紧急邮件 |
| 1 | `normal` | 普通邮件 |
| 2 | `spam` | 垃圾邮件 |
| 3 | `newsletter` | 订阅通讯 |

#### 节点6a：Set（紧急邮件 → 通知 + 回复模板）

| Name | Value | 类型 |
|------|-------|------|
| `replySubject` | `={{ 'Re: ' + $json.subject }}` | String |
| `replyBody` | `={{ '您好，\n\n我们已收到您的邮件「' + $json.subject + '」并标记为紧急，团队正在加急处理中，预计30分钟内给您回复。\n\n感谢您的耐心等待。' }}` | String |
| `notifyMessage` | `={{ '🔴 紧急邮件\n发件人: ' + $json.from + '\n主题: ' + $json.subject + '\n摘要: ' + $json.bodyPreview.substring(0, 100) }}` | String |

#### 节点6b：Set（普通邮件 → 确认回复模板）

| Name | Value | 类型 |
|------|-------|------|
| `replySubject` | `={{ 'Re: ' + $json.subject }}` | String |
| `replyBody` | `={{ '您好，\n\n感谢您的来信，我们已收到您的邮件「' + $json.subject + '」，将在1个工作日内回复。\n\n祝好！' }}` | String |
| `notifyMessage` | `={{ '🟡 普通邮件\n发件人: ' + $json.from + '\n主题: ' + $json.subject }}` | String |

#### 节点6c：Set（垃圾邮件 → 标记）

| Name | Value | 类型 |
|------|-------|------|
| `replySubject` | `` | String |
| `replyBody` | `` | String |
| `notifyMessage` | `🗑️ 垃圾邮件已自动拦截，无需处理` | String |

#### 节点6d：Set（订阅通讯 → 归档通知）

| Name | Value | 类型 |
|------|-------|------|
| `replySubject` | `` | String |
| `replyBody` | `` | String |
| `notifyMessage` | `={{ '📰 订阅通讯: ' + $json.subject + '\n已归档，可在空闲时阅读' }}` | String |

#### 节点7：HTTP Request（统一推送通知）

将各分支汇合后，统一推送通知结果。可以使用实例10的通知中心来推送：

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `http://localhost:5678/webhook/notify`（引用实例10的通知 API） |
| Body Type | JSON |

```json
{
  "channel": "slack",
  "title": "邮件分类结果",
  "message": "{{ $json.notifyMessage }}",
  "priority": "{{ $json.category === 'urgent' ? 'urgent' : 'normal' }}"
}
```

---

### 🔧 逐节点配置（完整版，有 IMAP/SMTP）

如果你有 IMAP/SMTP 环境，可以替换 Webhook 为以下配置：

#### 替换节点1：Schedule Trigger

| 配置项 | 值 |
|--------|-----|
| Trigger Interval | `Minutes` |
| Minutes | `5` |

#### 替换节点2：IMAP（读取未读邮件）

| 配置项 | 值 |
|--------|-----|
| Credential | 你的 IMAP 凭证 |
| Mailbox | `INBOX` |
| Action | `Get` |
| Post Process Action | `Mark as Read` |

#### 追加节点：SMTP（发送自动回复）

| 配置项 | 值 |
|--------|-----|
| From | `your-email@qq.com` |
| To | `={{ $json.from }}` |
| Subject | `={{ $json.replySubject }}` |
| Text | `={{ $json.replyBody }}` |

---

### 🧪 测试验证

#### 测试1：紧急邮件

```bash
curl -X POST http://localhost:5678/webhook-test/email \
  -H "Content-Type: application/json" \
  -d '{
    "from": "customer@example.com",
    "subject": "紧急：线上支付功能异常",
    "body": "我们的线上支付模块从今天下午2点开始出现无法支付的问题，用户反馈量很大，请尽快处理。"
  }'
```

**预期**：分类结果为 `urgent`，通知带有红色标记。

#### 测试2：垃圾邮件

```bash
curl -X POST http://localhost:5678/webhook-test/email \
  -H "Content-Type: application/json" \
  -d '{
    "from": "promo@spam-shop.com",
    "subject": "限时特惠！全场1折起！",
    "body": "亲爱的用户，我们为您准备了超值优惠活动，全场商品1折起售，仅限今日！点击链接立即抢购..."
  }'
```

**预期**：分类结果为 `spam`，垃圾邮件已拦截。

#### 测试3：订阅通讯

```bash
curl -X POST http://localhost:5678/webhook-test/email \
  -H "Content-Type: application/json" \
  -d '{
    "from": "newsletter@techweekly.com",
    "subject": "本周技术周刊 #128",
    "body": "本周精选：1. React 19 新特性解读 2. Rust 在后端的实践 3. AI 编程助手对比评测..."
  }'
```

**预期**：分类结果为 `newsletter`，已归档通知。

---

### 💡 变体与扩展

| 变体 | 说明 |
|------|------|
| **自定义分类** | 添加 `invoice`（发票）、`meeting`（会议邀请）等分类 |
| **分级回复** | urgent → 立即推送到所有渠道 + 拨打电话；normal → 只推送到 Slack |
| **学习功能** | 将人工修正的分类结果存入数据库，逐步提高准确率 |
| **附件处理** | 增加 Code 节点解析邮件附件，将 PDF 发送给 OCR 工作流 |
| **多语言支持** | 在 OpenAI prompt 中添加语言检测指令，自动切换回复语言 |
| **Escalation** | 紧急邮件 15 分钟内未人工处理，自动升级通知到上级 |

---

### ✋ 费曼检测

1. **解释给小白**：为什么要在 Code 节点中截取邮件正文前 500 字符？不截取会怎样？
2. **设计题**：如果 OpenAI 的分类结果不在四个预定义分类中（比如返回了 "important"），你的代码会怎么处理？为什么？
3. **配置题**：完整版中 IMAP 的 `Post Process Action` 设为 `Mark as Read` 有什么作用？如果设为其他选项会怎样？
4. **优化题**：如何避免同一封邮件被重复处理？（提示：考虑去重机制）

---

☕ *休息 5 分钟，活动一下身体*

---

## 🍅 番茄5-6：实例12 · 钉钉/飞书机器人

### 🎯 场景与目标

**场景**：团队在钉钉群中日常沟通，经常需要查询天气、看新闻、问 AI 问题。每次都要切换到不同应用，打断工作节奏。

**目标**：搭建一个群聊机器人，支持斜杠命令交互，在群内直接获取信息。

```
传统方式：                            机器人方式：
┌──────────────────────┐             ┌──────────────────────┐
│  看天气 → 打开天气 App │             │  /weather 北京        │
│  看新闻 → 打开新闻 App │             │  → 北京: 晴 28°C     │
│  问 AI  → 打开 ChatGPT│             │  /news 今日热点       │
│  三个应用，来回切换    │             │  → 3条新闻摘要        │
│                      │             │  /ai 解释量子计算     │
│                      │             │  → AI 回答...         │
│                      │             │  一个群聊搞定          │
└──────────────────────┘             └──────────────────────┘
```

**你将学到**：
- 钉钉自定义机器人的完整配置
- 安全设置（加签验证）
- 三种消息类型（text / markdown / action card）
- 斜杠命令解析与分发

---

### 🏗️ 工作流架构图

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Webhook     │    │  Code        │    │  Switch      │
│  POST /bot   │───→│  签名验证 +  │───→│  命令路由    │
│              │    │  解析命令    │    │              │
└──────────────┘    └──────────────┘    └──────┬───────┘
                                               │
                  ┌──────────┬──────────┬──────┴──────┐
                  ▼          ▼          ▼             ▼
            ┌──────────┐┌──────────┐┌──────────┐┌──────────┐
            │ /help    ││ /weather ││ /news    ││ /ai      │
            │ 帮助信息  ││ 天气查询  ││ 新闻摘要  ││ AI 对话   │
            └────┬─────┘└────┬─────┘└────┬─────┘└────┬─────┘
                 │           │           │            │
                 ▼           ▼           ▼            ▼
            ┌─────────────────────────────────────────────┐
            │            Code（格式化钉钉消息）             │
            └────────────────────┬────────────────────────┘
                                 ▼
                          ┌──────────────┐
                          │  HTTP Req    │
                          │  发送钉钉消息 │
                          └──────────────┘
```

---

### 🔑 API/凭证准备

#### 钉钉自定义机器人创建

| 步骤 | 操作 | 截图位置 |
|------|------|----------|
| 1 | 打开钉钉 PC 端，进入目标群聊 | - |
| 2 | 点击群右上角「群设置」齿轮图标 | 群聊右上角 |
| 3 | 智能群助手 → 添加机器人 → 自定义 | 群设置弹窗 |
| 4 | 机器人名称：`智能助手` | 添加机器人弹窗 |
| 5 | 安全设置：勾选「加签」→ 复制 Secret（SEC_ 开头） | 安全设置区域 |
| 6 | 点击「完成」→ 复制 Webhook URL | 结果页面 |

**关键信息记录**：

```
Webhook URL: https://oapi.dingtalk.com/robot/send?access_token=xxxx
Secret: SEC_xxxxxxxxxxxxxxxx
```

#### 天气 API（OpenWeather）

| 步骤 | 操作 |
|------|------|
| 1 | 访问 https://openweathermap.org/api |
| 2 | 注册账号 → 进入 API Keys 页面 |
| 3 | 复制 API Key |

#### OpenAI API Key

（同实例11，如已有可复用）

---

### 🔧 逐节点配置

#### 节点1：Webhook Trigger

| 配置项 | 值 |
|--------|-----|
| HTTP Method | `POST` |
| Path | `bot` |
| Response Mode | `On Received` |

> 💡 Response Mode 选 `On Received`，因为钉钉只需要知道我们收到了请求，不需要等处理结果。处理完成后我们主动发消息回去。

钉钉发送的请求体格式：

```json
{
  "msgtype": "text",
  "text": {
    "content": "/weather 北京"
  },
  "msgId": "msg_xxx",
  "createAt": "1686123456789",
  "conversationType": "2",
  "conversationId": "cid_xxx",
  "senderId": "user_xxx",
  "senderNick": "张三",
  "chatbotUserId": "bot_xxx"
}
```

#### 节点2：Code（签名验证 + 命令解析）

| 配置项 | 值 |
|--------|-----|
| Mode | `Run Once for All Items` |

```javascript
const crypto = require('crypto');

// ====== 第一步：签名验证（安全检查） ======
const input = $input.first().json;
const headers = input.headers || {};
const body = input.body || {};

// 钉钉加签验证
const secret = 'SEC_xxxxxxxxxxxxxxxx'; // 替换为你的 Secret
const timestamp = headers['timestamp'];
const sign = headers['sign'];

if (timestamp && sign) {
  const stringToSign = `${timestamp}\n${secret}`;
  const hmac = crypto.createHmac('sha256', secret);
  hmac.update(stringToSign);
  const expectedSign = encodeURIComponent(hmac.digest('base64'));

  if (sign !== expectedSign) {
    return [{
      json: {
        command: 'error',
        error: '签名验证失败',
        message: '非法请求'
      }
    }];
  }
}

// ====== 第二步：解析命令 ======
const content = (body.text?.content || '').trim();

// 解析斜杠命令
const commandPattern = /^\/(\w+)\s*(.*)/;
const match = content.match(commandPattern);

if (!match) {
  return [{
    json: {
      command: 'unknown',
      rawContent: content,
      args: '',
      sender: body.senderNick || '未知用户',
      error: '无法识别的命令，输入 /help 查看帮助'
    }
  }];
}

const command = match[1].toLowerCase();
const args = match[2].trim();

return [{
  json: {
    command: command,
    rawContent: content,
    args: args,
    sender: body.senderNick || '未知用户',
    conversationId: body.conversationId || '',
    secret: secret  // 传递给后续节点用于签名
  }
}];
```

#### 节点3：Switch（命令路由）

| 配置项 | 值 |
|--------|-----|
| Field to match | `{{ $json.command }}` |

路由规则：

| Output | Condition | 说明 |
|--------|-----------|------|
| 0 | `help` | 帮助信息 |
| 1 | `weather` | 天气查询 |
| 2 | `news` | 新闻摘要 |
| 3 | `ai` | AI 对话 |

#### 节点4a：Code（/help 帮助信息）

```javascript
const inputData = $input.first().json;

const helpText = `## 🤖 智能助手使用指南

支持的命令：

| 命令 | 说明 | 示例 |
|------|------|------|
| /help | 显示帮助信息 | /help |
| /weather | 查询天气预报 | /weather 北京 |
| /news | 获取新闻摘要 | /news 科技 |
| /ai | AI 智能问答 | /ai 什么是量子计算 |

> 输入命令即可使用，无需额外配置`;

return [{
  json: {
    ...inputData,
    messageType: 'markdown',
    title: '帮助信息',
    content: helpText
  }
}];
```

#### 节点4b：HTTP Request（/weather 天气查询）

| 配置项 | 值 |
|--------|-----|
| Method | `GET` |
| URL | `https://api.openweathermap.org/data/2.5/weather?q={{ $json.args }}&appid=YOUR_API_KEY&units=metric&lang=zh_cn` |

在 HTTP Request 后面加一个 Code 节点格式化天气信息：

```javascript
const inputData = $input.first().json;
const weather = inputData.json;

if (weather.cod && weather.cod !== 200) {
  return [{
    json: {
      ...$('Code').item.json,
      messageType: 'text',
      content: `❌ 查询失败：${weather.message || '城市未找到'}，请检查城市名称`
    }
  }];
}

const desc = weather.weather?.[0]?.description || '未知';
const temp = Math.round(weather.main?.temp || 0);
const feelsLike = Math.round(weather.main?.feels_like || 0);
const humidity = weather.main?.humidity || 0;
const wind = weather.wind?.speed || 0;
const city = weather.name || $('Code').item.json.args;

const content = `## 🌤️ ${city} 天气预报

| 项目 | 数据 |
|------|------|
| 天气 | ${desc} |
| 温度 | ${temp}°C |
| 体感温度 | ${feelsLike}°C |
| 湿度 | ${humidity}% |
| 风速 | ${wind} m/s |

> 数据来源: OpenWeather`;

return [{
  json: {
    ...$('Code').item.json,
    messageType: 'markdown',
    title: `${city} 天气`,
    content: content
  }
}];
```

#### 节点4c：HTTP Request（/news 新闻摘要）

| 配置项 | 值 |
|--------|-----|
| Method | `GET` |
| URL | `https://newsapi.org/v2/top-headlines?country=cn&category={{ $json.args || 'general' }}&pageSize=5&apiKey=YOUR_NEWS_API_KEY` |

格式化新闻的 Code 节点：

```javascript
const inputData = $input.first().json;
const articles = inputData.json?.articles || [];

if (articles.length === 0) {
  return [{
    json: {
      ...$('Code').item.json,
      messageType: 'text',
      content: '📰 暂无相关新闻'
    }
  }];
}

const newsList = articles.slice(0, 5).map((a, i) => {
  return `${i + 1}. [${a.title}](${a.url})\n   ${a.description || ''}`;
}).join('\n\n');

const content = `## 📰 今日热点

${newsList}

> 数据来源: NewsAPI`;

return [{
  json: {
    ...$('Code').item.json,
    messageType: 'markdown',
    title: '今日热点',
    content: content
  }
}];
```

#### 节点4d：HTTP Request（/ai AI 对话）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | Header Auth |
| Header Name | `Authorization` |
| Header Value | `Bearer sk-...` |
| Body Type | JSON |

```json
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "你是一个简洁实用的AI助手。用中文回答，回答控制在200字以内，使用 Markdown 格式。"
    },
    {
      "role": "user",
      "content": "{{ $('Code').item.json.args }}"
    }
  ],
  "temperature": 0.7,
  "max_tokens": 500
}
```

格式化 AI 回复的 Code 节点：

```javascript
const inputData = $input.first().json;
const aiReply = inputData.json?.choices?.[0]?.message?.content || '抱歉，AI 暂时无法回答';
const originalArgs = $('Code').item.json.args;

const content = `## 🤖 AI 回答

**问题**: ${originalArgs}

${aiReply}

> Powered by GPT-4o-mini`;

return [{
  json: {
    ...$('Code3').item.json, // 引用命令解析节点
    messageType: 'markdown',
    title: 'AI 回答',
    content: content
  }
}];
```

#### 节点5：Code（格式化钉钉消息）

将各命令分支的输出汇合，统一格式化为钉钉消息格式：

```javascript
const inputData = $input.first().json;
const messageType = inputData.messageType || 'text';
const title = inputData.title || '通知';
const content = inputData.content || '';

// 根据消息类型构造钉钉消息体
let dingtalkBody;

if (messageType === 'markdown') {
  dingtalkBody = {
    msgtype: 'markdown',
    markdown: {
      title: title,
      text: content
    }
  };
} else if (messageType === 'actionCard') {
  dingtalkBody = {
    msgtype: 'actionCard',
    actionCard: {
      title: title,
      text: content,
      btnOrientation: '0',
      singleTitle: '查看详情',
      singleURL: inputData.actionUrl || 'https://www.dingtalk.com'
    }
  };
} else {
  // 默认 text 类型
  dingtalkBody = {
    msgtype: 'text',
    text: {
      content: content
    }
  };
}

// 计算签名
const crypto = require('crypto');
const secret = inputData.secret;
const timestamp = Date.now();
const stringToSign = `${timestamp}\n${secret}`;
const hmac = crypto.createHmac('sha256', secret);
hmac.update(stringToSign);
const sign = encodeURIComponent(hmac.digest('base64'));

const webhookBase = 'https://oapi.dingtalk.com/robot/send?access_token=YOUR_TOKEN';
const fullUrl = `${webhookBase}&timestamp=${timestamp}&sign=${sign}`;

return [{
  json: {
    dingtalkUrl: fullUrl,
    dingtalkBody: dingtalkBody
  }
}];
```

#### 节点6：HTTP Request（发送钉钉消息）

| 配置项 | 值 |
|--------|-----|
| Method | `POST` |
| URL | `={{ $json.dingtalkUrl }}` |
| Body Type | JSON |
| Body | `={{ $json.dingtalkBody }}` |

---

### 🧪 测试验证

#### 测试1：/help 命令

```bash
curl -X POST http://localhost:5678/webhook-test/bot \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "text",
    "text": {
      "content": "/help"
    },
    "senderNick": "测试用户"
  }'
```

**预期**：钉钉群收到 Markdown 格式的帮助信息。

#### 测试2：/weather 命令

```bash
curl -X POST http://localhost:5678/webhook-test/bot \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "text",
    "text": {
      "content": "/weather Beijing"
    },
    "senderNick": "测试用户"
  }'
```

**预期**：钉钉群收到北京天气预报卡片。

#### 测试3：/ai 命令

```bash
curl -X POST http://localhost:5678/webhook-test/bot \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "text",
    "text": {
      "content": "/ai 什么是微服务架构"
    },
    "senderNick": "测试用户"
  }'
```

**预期**：钉钉群收到 AI 的 Markdown 格式回答。

#### 测试4：未知命令

```bash
curl -X POST http://localhost:5678/webhook-test/bot \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "text",
    "text": {
      "content": "你好"
    },
    "senderNick": "测试用户"
  }'
```

**预期**：提示输入 /help 查看可用命令。

---

### 💡 变体与扩展

| 变体 | 说明 |
|------|------|
| **飞书机器人** | 将钉钉 Webhook 替换为飞书 Webhook，消息格式改用飞书卡片 |
| **多轮对话** | 用 Redis/数据库存储对话上下文，实现连续问答 |
| **图片生成** | 添加 `/image` 命令，调用 DALL-E 生成图片并发送 |
| **审批操作** | 使用 Action Card 消息类型，按钮触发审批流程 |
| **定时播报** | Schedule Trigger + 机器人，每天早上自动发送天气+新闻+待办 |
| **权限控制** | 根据 senderId 判断权限，限制敏感命令的使用者 |

---

### ✋ 费曼检测

1. **解释给小白**：钉钉机器人为什么需要签名验证？不验证会怎样？
2. **配置题**：钉钉的三种安全设置（关键词/加签/IP）各自的优缺点是什么？什么场景选哪个？
3. **设计题**：如果要添加一个 `/todo` 命令（添加待办事项），工作流需要怎么改？数据存在哪里？
4. **消息格式题**：钉钉的 `text`、`markdown`、`actionCard` 三种消息类型分别适合什么场景？各举一个例子。

---

☕ *休息 5 分钟，活动一下身体*

---

## 🍅 番茄7：今日复习 · 通知通信参考手册

### 通知渠道对比表

| 渠道 | Webhook 格式 | 消息类型 | 速率限制 | 适用场景 |
|------|-------------|----------|----------|----------|
| **钉钉** | `https://oapi.dingtalk.com/robot/send?access_token=xxx` | text / markdown / actionCard / feedCard | 20条/分钟 | 国内团队日常通知 |
| **飞书** | `https://open.feishu.cn/open-apis/bot/v2/hook/xxx` | text / post / interactive | 100条/分钟 | 飞书团队通知 |
| **Slack** | `https://hooks.slack.com/services/T.../B.../xxx` | text / blocks / attachments | 1条/秒 | 国际团队通知 |
| **企业微信** | `https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=xxx` | text / markdown / image / news | 20条/分钟 | 微信生态团队 |
| **Telegram** | `https://api.telegram.org/bot{token}/sendMessage` | text / markdown / HTML | 30条/秒 | 个人/国际通知 |
| **Discord** | `https://discord.com/api/webhooks/xxx/yyy` | text / embed | 5条/秒 | 社区/开发通知 |
| **邮件** | SMTP 协议 | 纯文本 / HTML | 取决于服务商 | 正式/长内容通知 |

### Webhook URL 格式速查

```
钉钉:    https://oapi.dingtalk.com/robot/send?access_token={token}&timestamp={ts}&sign={sign}
飞书:    https://open.feishu.cn/open-apis/bot/v2/hook/{hook_id}
Slack:   https://hooks.slack.com/services/{workspace}/{channel}/{token}
企业微信: https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key={key}
Telegram: https://api.telegram.org/bot{bot_token}/sendMessage?chat_id={chat_id}&text={text}
```

### 钉钉消息类型参考

#### text 类型

```json
{
  "msgtype": "text",
  "text": {
    "content": "这是一条文本消息"
  }
}
```

#### markdown 类型

```json
{
  "msgtype": "markdown",
  "markdown": {
    "title": "消息标题",
    "text": "## 标题\n\n**加粗** *斜体*\n\n> 引用\n\n[链接](https://example.com)"
  }
}
```

#### actionCard 类型

```json
{
  "msgtype": "actionCard",
  "actionCard": {
    "title": "审批通知",
    "text": "![图片](https://example.com/img.png)\n## 请审批以下申请\n申请人: 张三\n金额: ¥5000",
    "btnOrientation": "0",
    "singleTitle": "去审批",
    "singleURL": "https://approval.example.com/123"
  }
}
```

#### feedCard 类型（多图列表）

```json
{
  "msgtype": "feedCard",
  "feedCard": {
    "links": [
      {
        "title": "文章1",
        "messageURL": "https://example.com/1",
        "picURL": "https://example.com/img1.png"
      },
      {
        "title": "文章2",
        "messageURL": "https://example.com/2",
        "picURL": "https://example.com/img2.png"
      }
    ]
  }
}
```

### 钉钉安全设置对比

| 安全方式 | 配置难度 | 安全性 | 适用场景 | 注意事项 |
|----------|---------|--------|----------|----------|
| 自定义关键词 | 低 | 低 | 简单通知 | 消息必须包含指定关键词 |
| 加签 | 中 | 高 | 生产环境 | 需要代码计算签名 |
| IP 地址段 | 低 | 中 | 固定 IP 服务器 | 需要知道 n8n 服务器出口 IP |

### 邮件分类 OpenAI Prompt 模板

```
系统提示：
你是一个邮件分类助手。只返回分类词（urgent/normal/spam/newsletter），不返回任何解释。

用户提示：
请对以下邮件进行分类。只返回一个分类词，不要返回其他内容。

可选分类：
- urgent：紧急事项，需要立即处理（如故障、投诉、截止日期）
- normal：普通邮件，需要回复但非紧急（如咨询、协作请求）
- spam：垃圾邮件或广告推广
- newsletter：订阅通讯、周报、资讯摘要

发件人: {from}
主题: {subject}
内容摘要: {bodyPreview}

分类:
```

> 💡 **Prompt 优化技巧**：
> - `temperature: 0` 确保分类结果稳定一致
> - `max_tokens: 10` 限制输出长度，节省 token
> - 明确列出分类词，避免 AI 自创分类
> - 添加 Code 节点做兜底验证，防止 AI 返回非预期结果

---

### 刻意练习——通知与通信

**练习目标**：配置至少 3 种通知渠道并构建条件通知工作流

**任务序列（重复×3）：**

```
===== 循环 1：3 种通知渠道 =====
分别配置并测试以下 3 种通知渠道：
1. 钉钉机器人 Webhook（含加签签名计算）
2. Slack Incoming Webhook
3. Email（SMTP 发送）
验证：每种渠道都成功收到了测试消息，格式正确

===== 循环 2：条件通知路由 =====
构建条件通知工作流：
IF 节点判断消息优先级（urgent/normal/low）
→ urgent：所有渠道同时推送
→ normal：仅 Slack 推送
→ low：仅记录日志，不推送
验证：三种优先级消息被正确路由到对应渠道

===== 循环 3：完整通知自动化 =====
构建含通知的完整自动化工作流：
Schedule Trigger（每 30 分钟）→ HTTP Request（检查 GitHub Issues）
→ IF（有新 Issue ？）→ 推送到钉钉群
验证：有新 Issue 时钉钉群收到通知，无新 Issue 时不推送
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Webhook 推送配置 | ⬜ | ⬜ | ⬜ |
| 钉钉签名验证 | ⬜ | ⬜ | ⬜ |
| 条件路由分发 | ⬜ | ⬜ | ⬜ |
| 通知 + 自动化整合 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：钉钉的三种安全设置（关键词/加签/IP）分别适合什么场景？如果你要给客户的钉钉群配置机器人，你会推荐哪种？为什么？

---

## 🍅 番茄8：费曼综合检测 + 学习笔记

### 综合自测

#### 基础理解（必须全对）

1. **Webhook 通知**：为什么实例10用 POST 而不是 GET 来发送通知？GET 可以吗？
2. **输入验证**：Code 节点做验证的目的是什么？如果不验证，最坏情况是什么？
3. **Switch 路由**：Switch 节点和 If 节点在多路由场景下，哪个更合适？为什么？

#### 配置实操（能独立完成）

4. **钉钉签名**：写出钉钉加签的计算步骤（timestamp、secret、HmacSHA256、Base64、URL Encode）。
5. **消息格式**：钉钉 markdown 消息中，`title` 和 `text` 的区别是什么？`title` 显示在哪里？
6. **邮件分类**：如果要让分类支持「发票」类别，需要修改哪些地方？

#### 设计思考（没有标准答案）

7. **多渠道广播**：如何设计一个工作流，让一条消息同时推送到所有渠道（而不是只选一个）？
8. **失败重试**：如果某个渠道（如 Slack）推送失败，应该怎么处理？设计一个重试机制。
9. **安全性**：如何防止外部恶意调用你的通知 API？至少提出两种方案。

---

### 费曼总结

用你自己的话，向一个不懂技术的人解释以下概念（每个不超过3句话）：

| 概念 | 你的解释 |
|------|----------|
| Webhook | _（填写）_ |
| 签名验证 | _（填写）_ |
| 邮件分类 | _（填写）_ |
| 斜杠命令 | _（填写）_ |
| Switch 路由 | _（填写）_ |

---

### 学习笔记模板

```markdown
## Day 4 学习笔记

### 今日收获
-

### 遇到的问题
-

### 解决方案
-

### 待深入的方向
-

### 与之前知识的关联
- 实例10 与 [[Day5-Webhook与外部集成]] 的关联：
- 实例11 与 [[Day6-AI-Agent工作流]] 的关联：
- 实例12 与 [[Day3-凭证管理与API集成]] 的关联：
```

---

### 今日 Checklist

- [ ] 实例10：多渠道通知中心运行成功
- [ ] 实例11：邮件自动分类与回复运行成功
- [ ] 实例12：钉钉/飞书机器人运行成功
- [ ] 费曼检测全部通过
- [ ] 学习笔记已填写

---

## 🎉 Day 4 完成！

今天你搭建了3个通知通信工作流，掌握了：
- 统一通知 API 的设计与实现
- AI 驱动的邮件自动分类
- 钉钉机器人的完整搭建流程
- 多种消息类型的格式化方法
- 签名验证的安全实践

**明天预告**：[[实例Day5-AI智能工作流]] —— 我们将进入 AI 深度集成，搭建 AI 内容生成管道、AI 智能客服和 AI 文档问答系统！

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[实例Day3-API集成实战]] - 上一篇
> - [[实例Day5-AI智能工作流]] - 下一篇
