# Day 3：凭证管理与 API 集成

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：学会配置凭证，用 HTTP Request 调用任意 API
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：凭证系统 + 创建3种凭证
🍅 番茄3-4：HTTP Request 节点详解 + 表达式与数据映射
🍅 番茄5-6：实战调用3个API + 自由实践
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：凭证系统（25分钟）

### 1.1 用大白话理解凭证

凭证 = n8n 访问外部服务的「通行证」。它安全地存储 API Key、OAuth Token 等敏感信息，节点通过引用凭证来鉴权。

**类比**：凭证就像酒店的房卡——你不需要知道房卡的技术原理，刷卡就能进门。n8n 帮你保管房卡，你需要时直接用。

**为什么不直接写 API Key 在节点里？**
1. 🔒 安全——凭证加密存储，不会意外暴露
2. 🔄 复用——多个节点/工作流共享同一个凭证
3. 🔄 更新——换 Key 只改一处，不用每个节点都改
4. 👥 协作——团队成员看不到 Key 的明文

### 1.2 凭证类型一览

| 类型 | 适用场景 | 代表服务 |
|------|----------|----------|
| **API Key** | 简单密钥认证 | OpenAI、智谱GLM、天气API |
| **OAuth2** | 第三方授权登录 | Google、GitHub、Notion |
| **Header Auth** | 自定义HTTP头认证 | 自建API、GLM-OCR |
| **Basic Auth** | 用户名+密码 | 内部服务 |
| **Token Auth** | Bearer Token | 多数 REST API |

### 1.3 常用 API Key 获取链接

| API | 用途 | 获取地址 | 免费额度 |
|-----|------|----------|----------|
| **OpenAI** | GPT-4o / GPT-4o-mini | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) | $5 新用户赠金 |
| **智谱 GLM** | ChatGLM / OCR | [open.bigmodel.cn](https://open.bigmodel.cn/) → 控制台 → API Keys | 注册送 token |
| **Anthropic** | Claude | [console.anthropic.com](https://console.anthropic.com/) → API Keys | $5 新用户赠金 |
| **OpenRouter** | 多模型统一接入 | [openrouter.ai/keys](https://openrouter.ai/keys) | 部分模型免费 |
| **Slack** | 消息通知 | [api.slack.com/apps](https://api.slack.com/apps) → Create New App → Bot Token | 免费版够用 |
| **Notion** | 数据库集成 | [notion.so/my-integrations](https://www.notion.so/my-integrations) → New Integration | 免费版够用 |
| **OpenWeather** | 天气数据 | [openweathermap.org/api](https://openweathermap.org/api) → Get API Key | 1000次/天 |
| **NewsAPI** | 新闻数据 | [newsapi.org](https://newsapi.org/) → Get API Key | 100次/天（开发版） |
| **GitHub** | 代码仓库 | [github.com/settings/tokens](https://github.com/settings/tokens) → Generate new token | 5000次/小时 |
| **Gmail** | 邮件操作 | Google Cloud Console → OAuth2 | 免费版够用 |
| **Telegram Bot** | 机器人消息 | [@BotFather](https://t.me/botfather) → /newbot | 免费 |

> ✋ **费曼自测**：为什么不把 API Key 直接写在节点配置里？凭证系统解决了哪些问题？

---

## 番茄钟2：创建3种凭证（25分钟）

### 2.1 创建 Header Auth 凭证（以 GLM-OCR 为例）

**获取 API Key**：
1. 访问 [open.bigmodel.cn](https://open.bigmodel.cn/)
2. 注册/登录 → 进入控制台
3. 点击左侧「API Keys」→「添加 API Key」
4. 复制生成的 Key（格式：`sk-xxxxxxxxxx`）

**在 n8n 中创建凭证**：

1. 左侧菜单 → **Credentials** → **Add Credential**
2. 搜索 `Header Auth` → 选中
3. 填写：

```
Credential Name: GLM-API-Key
Name: Authorization
Value: Bearer sk-你的密钥
```

> ⚠️ 注意：`Bearer` 和 `sk-` 之间有一个空格！

4. 点击 **Save**

### 2.2 创建 API Key 凭证（以 OpenAI 为例）

**获取 API Key**：
1. 访问 [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. 点击 **Create new secret key**
3. 复制 Key（格式：`sk-proj-xxxxxxxxxx`）
4. ⚠️ 关闭窗口后无法再查看，务必保存！

**在 n8n 中创建凭证**：

1. **Credentials** → **Add Credential**
2. 搜索 `OpenAI API` → 选中
3. 填写：

```
Credential Name: OpenAI-GPT4o
API Key: sk-proj-你的密钥
```

4. 点击 **Save**

### 2.3 创建 Slack 凭证

**获取 Bot Token**：
1. 访问 [api.slack.com/apps](https://api.slack.com/apps)
2. 点击 **Create New App** → **From scratch**
3. 填写 App Name 和选择 Workspace
4. 左侧 **OAuth & Permissions** → 添加 Bot Token Scopes：
   - `chat:write`（发消息）
   - `channels:read`（读取频道）
5. 点击 **Install to Workspace** → 复制 Bot Token（格式：`xoxb-xxxxxx`）

**在 n8n 中创建凭证**：

1. **Credentials** → **Add Credential**
2. 搜索 `Slack API` → 选中
3. 填写：

```
Credential Name: Slack-Bot
Access Token: xoxb-你的token
```

4. 点击 **Save**

> ✋ **费曼自测**：你能在 n8n 中独立创建一个 Header Auth 凭证吗？Bearer Token 的格式是什么？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] 凭证是加密存储的 API Key / OAuth Token
- [ ] 5 种凭证类型：API Key / OAuth2 / Header Auth / Basic Auth / Token Auth
- [ ] 知道常用 API 的 Key 获取地址
- [ ] 能在 n8n 中创建至少 2 种凭证

---

## 番茄钟3：HTTP Request 节点详解（25分钟）

### 3.1 用大白话理解 HTTP Request

HTTP Request = 「万能电话」——不管什么 API，只要你知道号码（URL）和暗号（认证），就能打电话过去获取信息。

### 3.2 基本配置参数

| 参数 | 说明 | 常用值 |
|------|------|--------|
| **Method** | 请求方法 | GET（获取）/ POST（创建）/ PUT（更新）/ DELETE（删除） |
| **URL** | 接口地址 | `https://api.example.com/data` |
| **Authentication** | 认证方式 | None / Generic Credential / Predefined |
| **Send Headers** | 发送自定义请求头 | ON 时可添加 Header 参数 |
| **Send Query** | 发送查询参数 | `?name=value&key=value` |
| **Send Body** | 发送请求体 | POST/PUT 通常需要 |
| **Body Content Type** | 请求体格式 | JSON / Form-Data / Binary |

### 3.3 响应格式选择

| 格式 | 用途 |
|------|------|
| **JSON** | 默认，大多数 API 返回 JSON |
| **String** | 纯文本响应 |
| **Binary** | 文件/图片下载 |
| **First Item** | 只取响应中的第一条 |

### 3.4 HTTP 方法对照表

```
CRUD 操作     HTTP 方法    n8n 用途
────────────────────────────────────────
Create 创建    POST        提交数据、调用API
Read 读取      GET         获取数据、查询
Update 更新    PUT/PATCH   修改数据
Delete 删除    DELETE      删除数据
```

> ✋ **费曼自测**：GET 和 POST 的区别是什么？什么场景用 GET，什么场景用 POST？

---

## 番茄钟4：表达式与数据映射（25分钟）

### 4.1 用大白话理解表达式

表达式就像 Excel 的公式——`$json.name` 相当于 `=A2`，引用了数据中的某个单元格。`$node["HTTP请求"].json.result` 相当于 `=Sheet2!B5`，跨表引用。

### 4.2 核心表达式语法

```javascript
// ① 当前节点的数据
{{ $json }}                          // 当前项所有 JSON 数据
{{ $json.fieldName }}                // 当前项指定字段
{{ $json.nested.field }}             // 嵌套字段

// ② 引用其他节点的数据
{{ $node["节点名"].json.field }}     // 指定节点的数据
{{ $prev.json.field }}               // 上一个节点的数据

// ③ 内置变量
{{ $now }}                           // 当前时间 (DateTime对象)
{{ $today }}                         // 今天日期
{{ $execution.id }}                  // 执行 ID
{{ $workflow.name }}                 // 工作流名称
{{ $env.MY_VAR }}                    // 环境变量

// ④ 输入数据访问
{{ $input.all() }}                   // 所有输入项
{{ $input.first().json }}            // 第一个输入项
{{ $input.item.json }}               // 当前输入项（Each模式）

// ⑤ 二进制数据（文件/图片）
{{ $binary.data.data }}              // base64 内容
{{ $binary.data.mimeType }}          // MIME 类型
{{ $binary.data.fileName }}          // 文件名
```

### 4.3 表达式在节点中的使用

**在 Set 节点中**：
```
Name: message
Value: =用户 {{ $json.name }} 的分数是 {{ $json.score }}
```

**在 HTTP Request 中**：
```
URL: https://api.example.com/users/{{ $json.userId }}
```

**在 IF 条件中**：
```
Value 1: {{ $json.score }}
Operation: greater than
Value 2: {{ $node["配置"].json.passScore }}
```

### 4.4 日期格式化

```javascript
{{ $now.toFormat('yyyy-MM-dd') }}           // 2026-06-08
{{ $now.toFormat('yyyy-MM-dd HH:mm:ss') }} // 2026-06-08 10:30:00
{{ $now.plus({ days: 1 }) }}                // 明天
{{ $now.minus({ hours: 24 }) }}             // 24小时前
```

> ✋ **费曼自测**：`{{ $json.name }}` 和 `{{ $node["Set1"].json.name }}` 有什么区别？什么情况下需要用 `$node["节点名"]` 引用？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 掌握 HTTP Request 的基本配置
- [ ] 理解 GET/POST/PUT/DELETE 的使用场景
- [ ] 能使用 `{{ $json.field }}` 引用数据
- [ ] 理解 `$json` 和 `$node["名"]` 的区别
- [ ] 能使用日期格式化表达式

---

## 番茄钟5：实战调用3个API（25分钟）

### 5.1 实战1：调用天气 API

**API**: [OpenWeatherMap](https://openweathermap.org/api)

**获取 API Key**：
1. 注册 [openweathermap.org](https://openweathermap.org/)
2. 进入 [API Keys 页面](https://home.openweathermap.org/api_keys)
3. 复制你的 Key

**HTTP Request 配置**：

```
Method: GET
URL: https://api.openweathermap.org/data/2.5/weather
Query Parameters:
  - q: Beijing
  - appid: 你的API_KEY
  - units: metric
  - lang: zh_cn
```

**响应示例**：
```json
{
  "name": "Beijing",
  "main": {
    "temp": 28.5,
    "humidity": 45
  },
  "weather": [
    { "description": "晴" }
  ]
}
```

**提取关键信息**（在后续 Set 节点中）：

| 字段 | 表达式 | 输出 |
|------|--------|------|
| 城市 | `{{ $json.name }}` | Beijing |
| 温度 | `{{ $json.main.temp }}` | 28.5 |
| 天气 | `{{ $json.weather[0].description }}` | 晴 |
| 湿度 | `{{ $json.main.humidity }}` | 45 |

### 5.2 实战2：调用新闻 API

**API**: [NewsAPI](https://newsapi.org/)

**获取 API Key**：
1. 注册 [newsapi.org](https://newsapi.org/)
2. 获取 API Key

**HTTP Request 配置**：

```
Method: GET
URL: https://newsapi.org/v2/top-headlines
Query Parameters:
  - country: cn
  - apiKey: 你的API_KEY
  - pageSize: 5
```

### 5.3 实战3：调用 OpenAI API

**API**: OpenAI Chat Completions

**HTTP Request 配置**：

```
Method: POST
URL: https://api.openai.com/v1/chat/completions
Authentication: Generic Credential Type → Header Auth
  (或使用 Predefined Auth → OpenAI API 凭证)
Send Body: ON
Body Content Type: JSON
Body:
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "你是一个有帮助的助手"
    },
    {
      "role": "user",
      "content": "{{ $json.userMessage }}"
    }
  ]
}
```

**提取回复**（在后续 Set 节点中）：

```
AI回复: {{ $json.choices[0].message.content }}
```

> ✋ **费曼自测**：你能独立配置一个 HTTP Request 节点调用天气 API 吗？从获取 Key 到看到响应数据，需要几步？

---

## 番茄钟6：自由实践——每日新闻摘要（25分钟）

### 6.1 项目：创建每日新闻摘要工作流

```
Schedule Trigger (每天8:00)
    ↓
HTTP Request (获取新闻)
    ↓
Code (提取前5条标题和摘要)
    ↓
Set (格式化消息)
    ↓
Slack (发送到频道) 或 HTTP Request (发送到钉钉Webhook)
```

### 6.2 Code 节点：提取新闻

```javascript
const articles = $input.first().json.articles;
const top5 = articles.slice(0, 5);

const summary = top5.map((article, index) => {
  return `${index + 1}. ${article.title}\n   来源: ${article.source.name}\n   摘要: ${(article.description || '').substring(0, 100)}`;
}).join('\n\n');

const today = new Date().toLocaleDateString('zh-CN');

return [{
  json: {
    date: today,
    summary: `📰 每日新闻摘要 - ${today}\n\n${summary}`,
    count: top5.length
  }
}];
```

### 6.3 替代方案：发送到钉钉

如果你没有 Slack，可以使用钉钉群机器人 Webhook：

```
Method: POST
URL: https://oapi.dingtalk.com/robot/send?access_token=YOUR_TOKEN
Body Content Type: JSON
Body:
{
  "msgtype": "text",
  "text": {
    "content": "{{ $json.summary }}"
  }
}
```

**获取钉钉 Webhook**：
1. 钉钉群 → 设置 → 智能群助手 → 添加机器人 → 自定义
2. 复制 Webhook URL 中的 `access_token`

### 6.4 挑战：加入 AI 摘要

```
HTTP Request (获取新闻)
    ↓
Code (提取前5条)
    ↓
HTTP Request (调用 OpenAI 生成中文摘要)
    ↓
Slack / 钉钉 (发送)
```

在 OpenAI 请求中：
```json
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "你是一个新闻编辑，请用简洁的中文总结以下新闻，每条不超过50字。"
    },
    {
      "role": "user",
      "content": "{{ $json.rawArticles }}"
    }
  ]
}
```

> ✋ **费曼自测**：从零开始，你能创建一个完整的工作流：定时获取数据 → AI 处理 → 发送通知吗？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 成功调用天气 API 并获取数据
- [ ] 成功调用新闻 API 并提取信息
- [ ] 成功调用 OpenAI API 并获取回复
- [ ] 完成了每日新闻摘要工作流
- [ ] 知道如何获取常用 API 的 Key

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

| 概念 | 一句话 | 类比 |
|------|--------|------|
| 凭证 | 加密存储的 API Key / Token | 酒店房卡 |
| HTTP Request | 调用任何 REST API | 万能电话 |
| 表达式 | `{{ }}` 包裹的动态值 | Excel 公式 |
| `$json` | 当前节点的数据 | 当前单元格 |
| `$node["名"]` | 指定节点的数据 | 跨工作表引用 |
| Query Parameters | URL 中的 `?key=value` | 查询条件 |
| Request Body | POST 发送的数据 | 寄出的包裹 |

### 7.2 API Key 获取速查

| API | 获取地址 | 免费额度 |
|-----|----------|----------|
| OpenAI | [platform.openai.com/api-keys](https://platform.openai.com/api-keys) | $5 赠金 |
| 智谱 GLM | [open.bigmodel.cn](https://open.bigmodel.cn/) | 注册送 token |
| OpenRouter | [openrouter.ai/keys](https://openrouter.ai/keys) | 部分免费 |
| Slack | [api.slack.com/apps](https://api.slack.com/apps) | 免费 |
| OpenWeather | [openweathermap.org/api](https://openweathermap.org/api) | 1000次/天 |
| NewsAPI | [newsapi.org](https://newsapi.org/) | 100次/天 |
| GitHub | [github.com/settings/tokens](https://github.com/settings/tokens) | 5000次/小时 |

### 7.3 表达式速查卡

```javascript
// 数据引用
{{ $json.field }}              // 当前项字段
{{ $prev.json.field }}         // 上一节点字段
{{ $node["名"].json.field }}   // 指定节点字段

// 日期
{{ $now.toFormat('yyyy-MM-dd') }}
{{ $now.plus({ days: 1 }) }}

// 字符串
{{ $json.name.toUpperCase() }}
{{ $json.email.split('@')[1] }}

// 条件
{{ $json.score >= 60 ? "及格" : "不及格" }}
```

> ✋ **费曼自测**：遮住上面的速查卡，你能写出获取当前日期、引用上一个节点数据、字符串转大写的表达式吗？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——凭证配置与API调用

**练习目标**：在25分钟内完成3轮凭证配置+API调用循环，掌握不同认证方式的集成

**任务序列（重复×3）：**

```
===== 循环 1：配置3种不同类型的凭证 =====
1. 创建 Header Auth 凭证（自定义 Header）
2. 创建 API Key 凭证（如 OpenAI/天气API）
3. 创建 Basic Auth 凭证（用户名+密码）
4. 分别查看三种凭证的配置界面差异
验证：凭证列表中出现3个不同类型的凭证，状态显示已连接

===== 循环 2：用同一API在不同节点类型中调用 =====
1. 用 HTTP Request 节点调用天气 API（GET）
2. 用 Code 节点调用同一个天气 API（JS fetch）
3. 对比两种方式返回的数据结构差异
4. 在 Set 节点中用表达式提取相同字段
验证：两种方式返回相同数据，提取的字段值一致

===== 循环 3：完成一个完整的外部API集成工作流 =====
1. 从零创建新工作流
2. 结构：Schedule Trigger → HTTP Request（天气API）→ Code（处理数据）→ Set（格式化输出）
3. 配置好凭证并通过表达式提取关键字段
4. 执行并验证每个节点的输出
验证：工作流自动获取API数据，关键字段被正确提取和格式化
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 凭证创建与配置 | ⬜ | ⬜ | ⬜ |
| HTTP Request 调用API | ⬜ | ⬜ | ⬜ |
| 表达式引用与数据提取 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Header Auth 和 API Key 两种凭证类型有什么区别？Express 中 `$json` 和 `$node["名"]` 分别在什么场景使用？

### 8.1 今日自检清单

- [ ] ✅ 在 n8n 中创建了至少 2 种凭证
- [ ] ✅ 知道常用 API 的 Key 获取地址
- [ ] ✅ 能配置 HTTP Request 调用 GET / POST 接口
- [ ] ✅ 能使用表达式引用节点数据
- [ ] ✅ 理解 `$json` 和 `$node["名"]` 的区别
- [ ] ✅ 成功调用了至少 2 个外部 API
- [ ] ✅ 完成了每日新闻摘要工作流

### 8.2 费曼一句话总结

> **凭证是 n8n 安全调用外部服务的通行证，HTTP Request 是万能的 API 调用器，表达式是连接节点数据的核心语法。三者配合，n8n 就能连接世界。**

### 8.3 学习笔记

```markdown
## Day 3 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 明天想深入的方向
（为 Day 4 做准备）
```

---

## 🎉 Day 3 完成！

**今日成果：**
- ✅ 创建了 Header Auth / OpenAI / Slack 凭证
- ✅ 掌握了 HTTP Request 节点的完整配置
- ✅ 成功调用了天气、新闻、AI 三个 API
- ✅ 完成了每日新闻摘要工作流
- ✅ 掌握了表达式语法和数据映射

**明天预告：** [[Day4-数据处理与工作流模式]] - 学习数据转换、循环处理、错误处理

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day2-核心节点与触发器]] - 上一天
> - [[Day4-数据处理与工作流模式]] - 下一天
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 HTTP Request + API 调用参考
