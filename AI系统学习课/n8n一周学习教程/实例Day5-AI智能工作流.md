# Day 5：AI智能工作流（3个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建3个AI工作流，掌握 AI Agent、Chat Trigger、RAG模式
> 🧠 教学方法：费曼学习法 × 刻意练习
> 📹 参考视频：[B站 n8n 实战系列](https://www.bilibili.com/video/BV15zCEBDEfT/)
> 📖 前置理论：[[Day6-AI-Agent工作流]]

---

## 今日学习路径

```
🍅 番茄1-2：实例13 · AI内容生成管道
🍅 番茄3-4：实例14 · AI智能客服
🍅 番茄5-6：实例15 · AI文档问答
🍅 番茄7-8：今日复习 + 费曼综合检测
```

---

# 🍅 番茄钟1-2：实例13 · AI内容生成管道

---

## 实例13：AI内容生成管道

### 🎯 场景与目标

**用大白话理解**：你有一个"写作流水线"——策划师列大纲，写手写初稿，编辑做润色。三个人接力完成一篇文章，每个人都只做自己最擅长的事。

**实际场景**：
- 内容团队需要批量生产文章
- 个人博主想快速生成草稿再微调
- 社交媒体运营需要多风格内容

**你要搭建的**：一个 Webhook API，发送主题和风格，自动生成大纲 → 正文 → 润色 → 保存为 Markdown 文件。

---

### 🏗️ 工作流架构图

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│  Webhook (POST /generate)                                                    │
│       │  接收: { topic, style, length }                                      │
│       ▼                                                                      │
│  Code (构建 Prompt)                                                           │
│       │  根据 style 选择提示词模板                                              │
│       ▼                                                                      │
│  HTTP Request (OpenAI - 生成大纲)                                              │
│       │  输入: topic + style prompt → 输出: outline                           │
│       ▼                                                                      │
│  HTTP Request (OpenAI - 生成正文)                                              │
│       │  输入: outline + topic → 输出: draft content                          │
│       ▼                                                                      │
│  HTTP Request (OpenAI - 润色修改)                                              │
│       │  输入: draft content → 输出: polished content                         │
│       ▼                                                                      │
│  Code (格式化为 Markdown)                                                      │
│       │  添加 frontmatter、标题、分节                                           │
│       ▼                                                                      │
│  Write File (保存)                                                            │
│       │  写入 .md 文件                                                        │
│       ▼                                                                      │
│  Respond to Webhook                                                          │
│       └── 返回: { success, filename, preview }                               │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

**关键设计决策**：为什么用三个 HTTP Request 而不是一个 AI Agent？

| 方案 | 优点 | 缺点 |
|------|------|------|
| **三个 HTTP Request（本方案）** | 流程可控、可单独调试每步、成本可预估 | 节点多、连线复杂 |
| 一个 AI Agent | 配置简单、一个节点搞定 | Agent 可能跳步、难调试、Token 消耗不可控 |

> 初学者建议：先用 HTTP Request 链理解每步逻辑，熟练后再改用 AI Agent。

---

### 🔑 API/凭证准备

#### 1. 获取 OpenAI API Key

1. 访问 [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. 注册/登录 OpenAI 账号
3. 点击 `Create new secret key`
4. 复制 Key（只显示一次！务必保存到安全的地方）
5. 确认账户有余额（至少 $1）

#### 2. 在 n8n 中添加 OpenAI 凭证

1. 左侧边栏 → **Credentials** → **Add Credential**
2. 搜索 `OpenAI API`
3. 填写：
   - **API Key**：粘贴你的 Key
   - **Name**：`OpenAI GPT-4o-mini`（方便识别）
4. 点击 **Save**

#### 3. 验证凭证

添加一个临时 HTTP Request 节点测试：

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

Body：

```json
{
  "model": "gpt-4o-mini",
  "messages": [{"role": "user", "content": "Hello"}],
  "max_tokens": 5
}
```

点击 Execute Node，如果收到 200 响应，说明凭证配置成功。

---

### 🔧 逐节点配置

#### 节点1：Webhook Trigger

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 接收生成请求 |
| Path | `generate` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 工作流结束后返回结果 |

预期请求体：

```json
{
  "topic": "番茄工作法入门",
  "style": "tutorial",
  "length": "medium"
}
```

**style 可选值**：

| style | 说明 | 风格倾向 |
|-------|------|----------|
| `blog` | 博客文章 | 轻松、个人化 |
| `tutorial` | 教程 | 循序渐进、步骤清晰 |
| `story` | 故事叙事 | 情节驱动、有代入感 |
| `social` | 社交媒体 | 短平快、有爆点 |

**length 可选值**：`short`（800字）/ `medium`（1500字）/ `long`（3000字）

---

#### 节点2：Code（构建 Prompt）

命名：`构建风格Prompt`

```javascript
// 获取 Webhook 传入的参数
const body = $input.first().json.body;
const topic = body.topic || '未命名主题';
const style = body.style || 'blog';
const length = body.length || 'medium';

// 风格对应的提示词模板
const stylePrompts = {
  blog: `你是一位资深博主，写作风格轻松自然，善用个人经历和类比。文章需要有吸引力的开头，清晰的分段，以及有共鸣的结尾。`,
  tutorial: `你是一位技术教程作者，写作风格循序渐进，注重实操。每个步骤都要有清晰的标题和具体的操作说明，适当使用代码块和表格辅助说明。`,
  story: `你是一位故事写手，善用叙事手法，将知识点融入故事情节。文章需要有场景描写、人物对话和情节转折，让读者在故事中自然地理解内容。`,
  social: `你是一位社交媒体内容策划师，写作短平快、有爆点。善用 emoji、列表和金句，内容要有传播性，适合快速阅读。`
};

// 长度对应的大致字数
const lengthMap = {
  short: '800字左右',
  medium: '1500字左右',
  long: '3000字左右'
};

// 构建 prompt 组件
const stylePrompt = stylePrompts[style] || stylePrompts.blog;
const lengthDesc = lengthMap[length] || lengthMap.medium;

return {
  json: {
    topic: topic,
    style: style,
    length: lengthDesc,
    stylePrompt: stylePrompt,
    // 组合完整请求参数，供后续节点使用
    requestInfo: `主题: ${topic} | 风格: ${style} | 长度: ${lengthDesc}`
  }
};
```

---

#### 节点3：HTTP Request（生成大纲）

命名：`生成大纲`

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Options → Timeout | `60000`（60秒超时） |

Body（使用表达式引用上游数据）：

```json
{
  "model": "gpt-4o-mini",
  "temperature": 0.5,
  "max_tokens": 1000,
  "messages": [
    {
      "role": "system",
      "content": "={{ $json.stylePrompt }}\n\n你的任务是为一篇文章生成大纲。大纲格式要求：\n- 使用 Markdown 格式\n- 包含3-5个主要章节（## 标题）\n- 每个章节包含2-3个子要点（### 标题或列表）\n- 每个要点用一句话说明要写什么\n- 只输出大纲，不要写正文"
    },
    {
      "role": "user",
      "content": "请为以下主题生成文章大纲：={{ $json.topic }}\n\n目标长度：={{ $json.length }}"
    }
  ]
}
```

> 为什么 Temperature 设为 0.5？大纲需要结构合理但不过于保守，0.5 是一个平衡点。

---

#### 节点4：Code（提取大纲文本）

命名：`提取大纲`

```javascript
// 从 OpenAI 响应中提取大纲文本
const response = $input.first().json;

let outline = '';
if (response.choices && response.choices[0]) {
  outline = response.choices[0].message.content || '';
}

// 同时保留上游的 topic 等信息
const previousData = $('构建风格Prompt').first().json;

return {
  json: {
    topic: previousData.topic,
    style: previousData.style,
    length: previousData.length,
    stylePrompt: previousData.stylePrompt,
    outline: outline
  }
};
```

> 关键技巧：用 `$('节点名')` 引用任意上游节点的数据，而不是只依赖上一个节点的输出。这样可以把 topic 等信息一路传递下去。

---

#### 节点5：HTTP Request（生成正文）

命名：`生成正文`

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Options → Timeout | `120000`（正文生成可能较长，120秒超时） |

Body：

```json
{
  "model": "gpt-4o-mini",
  "temperature": 0.7,
  "max_tokens": 4000,
  "messages": [
    {
      "role": "system",
      "content": "={{ $json.stylePrompt }}\n\n你的任务是严格按照大纲撰写文章正文。要求：\n- 严格按照大纲结构撰写，不要遗漏章节\n- 语言流畅自然，段落过渡自然\n- 适当使用举例和类比\n- 每个章节字数均匀分配\n- 输出完整的 Markdown 格式正文"
    },
    {
      "role": "user",
      "content": "主题：={{ $json.topic }}\n\n目标长度：={{ $json.length }}\n\n以下是文章大纲，请据此撰写正文：\n\n={{ $json.outline }}"
    }
  ]
}
```

> 为什么 Temperature 设为 0.7？写正文需要创意和表达多样性，0.7 让 AI 有适度发挥空间。

---

#### 节点6：Code（提取正文 + 准备润色）

命名：`提取正文`

```javascript
const response = $input.first().json;

let draft = '';
if (response.choices && response.choices[0]) {
  draft = response.choices[0].message.content || '';
}

const previousData = $('提取大纲').first().json;

return {
  json: {
    topic: previousData.topic,
    style: previousData.style,
    length: previousData.length,
    stylePrompt: previousData.stylePrompt,
    outline: previousData.outline,
    draft: draft
  }
};
```

---

#### 节点7：HTTP Request（润色修改）

命名：`润色修改`

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Options → Timeout | `120000` |

Body：

```json
{
  "model": "gpt-4o-mini",
  "temperature": 0.3,
  "max_tokens": 4000,
  "messages": [
    {
      "role": "system",
      "content": "你是一位资深编辑，负责对文章进行润色修改。要求：\n- 修正语法错误和不通顺的表达\n- 优化段落过渡和逻辑衔接\n- 统一术语和风格\n- 适当增加金句或亮点（不超过2处）\n- 不要改变文章的核心观点和结构\n- 不要删减内容，只做优化\n- 输出完整润色后的 Markdown 正文"
    },
    {
      "role": "user",
      "content": "请润色以下文章：\n\n={{ $json.draft }}"
    }
  ]
}
```

> 为什么 Temperature 设为 0.3？润色需要保守，不宜过度发挥。0.3 让 AI 专注于修正而非重写。

---

#### 节点8：Code（格式化为 Markdown）

命名：`格式化Markdown`

```javascript
const response = $input.first().json;
const previousData = $('提取正文').first().json;

let polished = '';
if (response.choices && response.choices[0]) {
  polished = response.choices[0].message.content || '';
}

const topic = previousData.topic;
const style = previousData.style;
const now = new Date();

// 生成 Obsidian 兼容的 frontmatter
const frontmatter = `---
title: "${topic}"
style: ${style}
created: ${now.toISOString()}
generator: n8n-content-pipeline
model: gpt-4o-mini
tags:
  - ai-generated
  - ${style}
---`;

// 组装完整 Markdown
const fullContent = `${frontmatter}

# ${topic}

${polished}

---

> 本文由 AI 内容生成管道自动生成，风格：${style}，生成时间：${now.toLocaleString('zh-CN')}
> 如需修改，请在 Obsidian 中编辑此文件。
`;

// 生成文件名（处理特殊字符）
const safeName = topic.replace(/[^\u4e00-\u9fa5a-zA-Z0-9]/g, '-').substring(0, 30);
const filename = `${safeName}-${now.toISOString().slice(0, 10)}.md`;

return {
  json: {
    filename: filename,
    content: fullContent,
    contentLength: polished.length,
    topic: topic,
    style: style,
    generatedAt: now.toISOString()
  }
};
```

---

#### 节点9：Write File（保存）

命名：`保存文件`

| 字段 | 值 | 说明 |
|------|-----|------|
| File Name | `=/files/generated/{{ $json.filename }}` | 保存路径 |
| Content | `={{ $json.content }}` | Markdown 内容 |

> 如果 n8n 环境中没有 `/files/generated` 目录，需要先创建，或改为你本地存在的路径。

---

#### 节点10：Respond to Webhook

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify({ success: true, filename: $json.filename, topic: $json.topic, style: $json.style, contentLength: $json.contentLength, generatedAt: $json.generatedAt, preview: $json.content.substring(0, 200) + '...' }) }}` |
| Response Code | `200` |

---

### 🧪 测试验证

#### 测试1：教程风格

```bash
curl -X POST http://localhost:5678/webhook-test/generate \
  -H "Content-Type: application/json" \
  -d '{"topic": "番茄工作法入门", "style": "tutorial", "length": "medium"}'
```

**预期响应**：

```json
{
  "success": true,
  "filename": "番茄工作法入门-2026-06-08.md",
  "topic": "番茄工作法入门",
  "style": "tutorial",
  "contentLength": 1523,
  "generatedAt": "2026-06-08T10:30:00.000Z",
  "preview": "---\ntitle: \"番茄工作法入门\"\nstyle: tutorial\ncreated: 2026-06-08T10:30:00.000Z\n...\n\n# 番茄工作法入门\n\n## 什么是番茄工作法..."
}
```

#### 测试2：社交媒体风格

```bash
curl -X POST http://localhost:5678/webhook-test/generate \
  -H "Content-Type: application/json" \
  -d '{"topic": "5个提升效率的AI工具", "style": "social", "length": "short"}'
```

#### 测试3：故事风格

```bash
curl -X POST http://localhost:5678/webhook-test/generate \
  -H "Content-Type: application/json" \
  -d '{"topic": "一个程序员的自我救赎", "style": "story", "length": "long"}'
```

#### 调试技巧

| 问题 | 排查方向 |
|------|----------|
| 401 错误 | OpenAI API Key 无效或余额不足 |
| 大纲很空 | 检查 `$json.stylePrompt` 是否正确传递 |
| 正文偏离大纲 | 检查生成正文节点的 prompt 是否包含大纲内容 |
| 润色改动太大 | 降低润色节点的 Temperature |
| 超时 | 增加 Timeout 设置，或减少 max_tokens |

---

### 💡 变体与扩展

| 变体 | 思路 | 新增节点 |
|------|------|----------|
| **多语言生成** | 在构建 Prompt 时加入目标语言参数 | 修改 Code 节点 |
| **SEO 优化** | 润色后增加一步 SEO 分析（标题/描述/关键词） | HTTP Request + Code |
| **配图生成** | 生成正文后，用 DALL-E 为每章生成配图 | HTTP Request (DALL-E) |
| **发布到博客** | 保存后自动发布到 WordPress/Ghost | HTTP Request |
| **批量生成** | 用 Split In Batches 节点处理多个主题 | Split In Batches |
| **风格混合** | 同时生成多种风格，让用户选择 | Split + Merge |

---

### ✋ 费曼检测

1. **为什么三个 AI 调用的 Temperature 分别是 0.5、0.7、0.3？如果都设成 0.9 会怎样？**
2. **上游的 topic 信息是怎么从 Webhook 一路传递到最后的格式化节点的？如果不用 `$('节点名')` 方式，还有什么方法？**
3. **如果用户传入的 style 值不在预设列表中（如 style: "poetry"），当前代码会怎么处理？你会怎么改进？**

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] AI 内容管道 = 大纲 → 正文 → 润色，三步链式调用
- [ ] Temperature 参数：大纲 0.5 / 正文 0.7 / 润色 0.3
- [ ] 使用 `$('节点名')` 在任意节点引用上游数据
- [ ] Code 节点是"胶水"——提取 AI 输出、传递上下文、格式化结果
- [ ] Webhook API 让外部系统可以触发 AI 生成

---

# 🍅 番茄钟3-4：实例14 · AI智能客服

---

## 实例14：AI智能客服

### 🎯 场景与目标

**用大白话理解**：你有一个"永不休息的客服"——它知道产品知识，能查库存、算折扣，还能记住刚才聊了什么。当它搞不定时，会礼貌地转人工。

**实际场景**：
- 电商网站 7x24 小时自动客服
- SaaS 产品使用指导
- 常见问题自动应答

**你要搭建的**：一个带工具和记忆的 AI 客服，能查商品、算价格，还记住上下文。

---

### 🏗️ 工作流架构图

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                  │
│  Chat Trigger（n8n 内置聊天界面）                                  │
│       │  接收用户消息                                              │
│       ▼                                                          │
│  AI Agent (ReAct Agent)                                          │
│       │                                                          │
│       ├── 🧠 模型: OpenAI gpt-4o-mini                           │
│       │                                                          │
│       ├── 🔧 工具1: HTTP Request Tool（查商品数据库）              │
│       │      Description: 当用户询问商品信息、价格、库存时使用     │
│       │                                                          │
│       ├── 🔧 工具2: Code Tool（计算折扣价格）                      │
│       │      Description: 当用户询问折扣、优惠、满减时使用         │
│       │                                                          │
│       ├── 💾 记忆: Window Buffer Memory（保留最近5轮对话）         │
│       │                                                          │
│       └── 📝 System Prompt: 客服人设 + 产品知识 + 行为规则         │
│                                                                  │
│       ▼                                                          │
│  自动回复用户                                                     │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

**核心概念**：AI Agent 的"ReAct 模式"——**思考 → 行动 → 观察 → 再思考**

```
用户: "蓝牙耳机有货吗？打8折多少钱？"
  ↓
Agent 思考: 用户问了两个问题，需要查商品信息和计算折扣
  ↓
Agent 行动1: 调用"查商品"工具 → 获得：蓝牙耳机 ¥299，库存32件
  ↓
Agent 观察: 知道原价和库存了
  ↓
Agent 行动2: 调用"算折扣"工具 → 获得：299 × 0.8 = ¥239.2
  ↓
Agent 回复: "蓝牙耳机目前有货（库存32件），原价¥299，8折后¥239.2。需要帮您下单吗？"
```

---

### 🔑 API/凭证准备

| 凭证 | 用途 | 获取方式 |
|------|------|----------|
| **OpenAI API Key** | AI Agent 的大脑 | [[Day6-AI-Agent工作流]] 中已有详细步骤 |
| **无需其他 API** | 商品数据用 Code 模拟 | — |

> 本实例用 Code 模拟商品数据库，不需要真实数据库。实际项目中替换为 HTTP Request 调用真实 API 即可。

---

### 🔧 逐节点配置

#### 节点1：Chat Trigger

1. 创建新工作流，命名为 `AI智能客服`
2. 点击画布 `+`，搜索 `Chat Trigger`
3. 选择 **Chat Trigger** 节点添加到画布

**Chat Trigger 配置**：

| 字段 | 值 | 说明 |
|------|-----|------|
| Initial Messages | （可选）欢迎语 | 用户进入聊天时显示 |

Initial Messages 示例：

```json
[
  {
    "role": "assistant",
    "content": "你好！我是智能客服小助，有什么可以帮你的？你可以问我商品信息、价格折扣、订单问题等。"
  }
]
```

> Chat Trigger 是 n8n 内置的聊天界面触发器。激活工作流后，点击 Chat Trigger 节点上的聊天图标即可打开聊天窗口。

---

#### 节点2：AI Agent

1. 在 Chat Trigger 后面添加 **AI Agent** 节点
2. Agent Type 选择：**ReAct Agent**

##### 2a. 连接语言模型

在 AI Agent 节点内，找到 **Language Model** 区域，点击 `+` 添加：

| 设置项 | 值 |
|--------|-----|
| 节点类型 | **OpenAI Chat Model** |
| Credential | 选择之前创建的 OpenAI 凭证 |
| Model | `gpt-4o-mini` |
| Temperature | `0.3`（客服需要稳定一致的回答） |
| Max Tokens | `2000` |

##### 2b. 添加工具1：HTTP Request Tool（查商品）

在 AI Agent 节点的 **Tools** 区域，点击 `+` 添加 **HTTP Request Tool**：

| 字段 | 值 |
|------|-----|
| Name | `查询商品信息` |
| Description | `当用户询问商品的价格、库存、规格、描述等商品信息时使用此工具。输入参数：商品名称（keyword）。返回商品的详细信息。` |
| Method | `GET` |
| URL | `http://localhost:5678/webhook/product-query` |

> 等等，我们还没搭建商品查询 API！这里先用 Code Tool 模拟，后面再替换。**先跳到 2c，用 Code Tool 模拟商品查询。**

##### 2c. 添加工具1（替代方案）：Code Tool（查商品）

在 AI Agent 节点的 **Tools** 区域，点击 `+` 添加 **Code Tool**：

| 字段 | 值 |
|------|-----|
| Name | `查询商品信息` |
| Description | `当用户询问商品的价格、库存、规格、描述等商品信息时使用此工具。输入参数：keyword（商品名称或关键词，字符串类型）。返回匹配商品的详细信息。` |

Code：

```javascript
// 模拟商品数据库
const products = [
  {
    id: 'P001',
    name: '蓝牙耳机 Pro',
    price: 299,
    stock: 32,
    category: '数码配件',
    description: '高品质蓝牙5.3耳机，续航30小时，支持主动降噪',
    specs: { '颜色': '星空黑/云雾白', '重量': '5.2g', '续航': '30小时' }
  },
  {
    id: 'P002',
    name: '机械键盘 K8',
    price: 459,
    stock: 15,
    category: '数码配件',
    description: '87键热插拔机械键盘，Gateron红轴，RGB背光',
    specs: { '轴体': 'Gateron红轴/茶轴', '配列': '87键', '连接': '有线/蓝牙双模' }
  },
  {
    id: 'P003',
    name: '便携充电宝',
    price: 129,
    stock: 58,
    category: '数码配件',
    description: '20000mAh大容量，支持22.5W快充，LED电量显示',
    specs: { '容量': '20000mAh', '快充': '22.5W', '重量': '380g' }
  },
  {
    id: 'P004',
    name: '智能手环 S7',
    price: 199,
    stock: 0,
    category: '穿戴设备',
    description: '血氧检测+心率监测，50米防水，14天超长续航',
    specs: { '屏幕': '1.47英寸AMOLED', '防水': '50米', '续航': '14天' }
  },
  {
    id: 'P005',
    name: '桌面台灯 L3',
    price: 89,
    stock: 120,
    category: '家居',
    description: '无频闪护眼台灯，三档色温调节，触控开关',
    specs: { '色温': '3000K-6500K', '功率': '12W', '调光': '无极调光' }
  }
];

// 获取工具输入参数
const input = $input.first().json;
const keyword = (input.keyword || input.query || '').toLowerCase();

if (!keyword) {
  return {
    json: {
      result: '请提供商品名称或关键词',
      found: false
    }
  };
}

// 模糊搜索
const results = products.filter(p =>
  p.name.toLowerCase().includes(keyword) ||
  p.category.toLowerCase().includes(keyword) ||
  p.description.toLowerCase().includes(keyword)
);

if (results.length === 0) {
  return {
    json: {
      result: `没有找到与"${keyword}"相关的商品。我们目前有：蓝牙耳机 Pro、机械键盘 K8、便携充电宝、智能手环 S7、桌面台灯 L3。`,
      found: false
    }
  };
}

// 格式化商品信息
const formatted = results.map(p => {
  const stockStatus = p.stock > 0 ? `有货（库存${p.stock}件）` : '暂时缺货';
  return `【${p.name}】¥${p.price} | ${stockStatus}\n分类：${p.category}\n介绍：${p.description}\n规格：${Object.entries(p.specs).map(([k,v]) => `${k}: ${v}`).join(', ')}`;
}).join('\n\n');

return {
  json: {
    result: formatted,
    found: true,
    count: results.length
  }
};
```

##### 2d. 添加工具2：Code Tool（计算折扣）

在 AI Agent 节点的 **Tools** 区域，点击 `+` 添加 **Code Tool**：

| 字段 | 值 |
|------|-----|
| Name | `计算折扣价格` |
| Description | `当用户询问折扣价、优惠价、打折后的价格、满减活动时使用此工具。输入参数：originalPrice（原价，数字类型），discount（折扣率，如0.8表示8折，数字类型），quantity（购买数量，默认1，数字类型）。返回折扣后的总价。` |

Code：

```javascript
const input = $input.first().json;
const originalPrice = Number(input.originalPrice) || 0;
const discount = Number(input.discount) || 1;
const quantity = Number(input.quantity) || 1;

if (originalPrice <= 0) {
  return { json: { result: '原价必须大于0', calculated: false } };
}

if (discount <= 0 || discount > 1) {
  return { json: { result: '折扣率应在0-1之间（如0.8表示8折）', calculated: false } };
}

const discountedPrice = originalPrice * discount;
const total = discountedPrice * quantity;
const saved = (originalPrice - discountedPrice) * quantity;

// 满减规则
let extraDiscount = 0;
let promotionMsg = '';
if (total >= 500) {
  extraDiscount = 50;
  promotionMsg = ' | 满500减50';
} else if (total >= 300) {
  extraDiscount = 20;
  promotionMsg = ' | 满300减20';
}

const finalPrice = total - extraDiscount;

return {
  json: {
    result: `原价: ¥${originalPrice}\n折扣: ${discount * 10}折\n折后单价: ¥${discountedPrice.toFixed(2)}\n数量: ${quantity}\n小计: ¥${total.toFixed(2)}${promotionMsg}\n最终价格: ¥${finalPrice.toFixed(2)}\n节省: ¥${(saved + extraDiscount).toFixed(2)}`,
    calculated: true,
    originalPrice: originalPrice,
    discountedPrice: discountedPrice,
    quantity: quantity,
    total: total,
    finalPrice: finalPrice
  }
};
```

##### 2e. 配置记忆

在 AI Agent 节点内，找到 **Memory** 区域，点击 `+` 添加 **Window Buffer Memory**：

| 字段 | 值 | 说明 |
|------|-----|------|
| Session ID | `={{ $json.sessionId }}` | 区分不同用户的对话 |
| Session Key | `chat` | 存储键名 |
| Window Size | `5` | 保留最近5轮对话 |

> Session ID 的作用：就像酒店房间号——不同用户有不同的 ID，记忆不会串台。同一个用户的前后对话会被记住。

##### 2f. 设置 System Prompt

在 AI Agent 节点的 **System Prompt** 字段中：

```markdown
你是「小助」，一个友好、专业的智能客服。你代表"数码好物"电商平台。

## 你的职责
- 回答商品相关问题（价格、库存、规格）
- 帮助计算折扣价格
- 处理常见售后问题

## 商品知识
- 我们主营数码配件、穿戴设备、家居产品
- 目前有5款商品：蓝牙耳机Pro(¥299)、机械键盘K8(¥459)、便携充电宝(¥129)、智能手环S7(¥199)、桌面台灯L3(¥89)
- 满减活动：满300减20，满500减50

## 工具使用规则
- 当用户问商品信息时，使用"查询商品信息"工具
- 当用户问折扣/优惠时，先用"查询商品信息"查原价，再用"计算折扣价格"算折扣
- 不要凭记忆回答价格，一定要用工具查询确认

## 行为规则
- 友好、耐心、专业
- 如果不确定，诚实回答"我需要确认一下"
- 如果用户要求退款、投诉、转人工，回复："我理解您的需求，正在为您转接人工客服，请稍候..."
- 不要编造不存在的商品
- 不要承诺具体的配送时间（交给人工处理）

## 回复风格
- 简洁明了，用列表或分段组织信息
- 适当使用表情增加亲和力，但不要过度
- 关键信息（价格、库存）用醒目方式呈现
```

---

### 🧪 测试验证

#### 测试步骤

1. 点击 **Chat Trigger** 节点上的聊天图标
2. 在弹出的聊天窗口中逐条测试：

**测试1：基础问候**

```
你: 你好
预期: 友好的欢迎回复，介绍自己能做什么
```

**测试2：查商品**

```
你: 蓝牙耳机有货吗？
预期: 调用查询工具，返回蓝牙耳机Pro的信息、价格和库存
```

**测试3：算折扣**

```
你: 蓝牙耳机打8折多少钱？
预期: 先查商品获得原价299，再计算8折=239.2
```

**测试4：上下文记忆**

```
你: 蓝牙耳机打8折多少钱？
（等待回复后）
你: 如果买两个呢？
预期: Agent 记住刚才在聊蓝牙耳机8折，计算 239.2 × 2 = 478.4，可能还提示满300减20
```

**测试5：缺货商品**

```
你: 智能手环有货吗？
预期: 调用查询工具，返回库存0，提示暂时缺货
```

**测试6：转人工**

```
你: 我要退款
预期: 提示正在转接人工客服
```

**测试7：不存在的商品**

```
你: 有iPhone吗？
预期: 调用查询工具，返回没有找到，列出现有商品
```

---

### 💡 变体与扩展

| 变体 | 思路 | 改动点 |
|------|------|--------|
| **对接真实数据库** | 把 Code Tool 换成 HTTP Request Tool | 指向你的商品 API |
| **多客服人设** | 根据 Chat Trigger 的 initialMessage 动态切换 System Prompt | IF 节点 + 多个 Agent |
| **订单查询工具** | 新增 Code Tool，模拟订单数据库 | 新增工具节点 |
| **情绪识别** | 在 System Prompt 中加入情绪判断规则 | 修改 System Prompt |
| **多语言客服** | System Prompt 中加入多语言支持 | 修改 System Prompt |
| **接入钉钉/飞书** | 把 Chat Trigger 换成对应 Trigger | 替换触发器 |

---

### ✋ 费曼检测

1. **AI Agent 的四个核心组件是什么？本实例中分别对应什么？**
2. **工具的 Description 为什么很重要？如果把"查询商品信息"的 Description 写成"查东西"，Agent 会怎样？**
3. **Window Buffer Memory 的 Window Size 设为 5，意味着什么？如果一个用户聊了 10 轮，第 1-5 轮的内容还能被记住吗？**
4. **为什么 System Prompt 里强调"不要凭记忆回答价格，一定要用工具查询"？**

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] AI Agent = 模型 + 工具 + 记忆 + System Prompt
- [ ] Chat Trigger 提供 n8n 内置聊天界面
- [ ] 工具的 Description 决定 Agent 能否正确选择工具
- [ ] Window Buffer Memory 让 Agent 记住最近 N 轮对话
- [ ] ReAct 模式：思考 → 行动 → 观察 → 再思考

---

# 🍅 番茄钟5-6：实例15 · AI文档问答

---

## 实例15：AI文档问答（RAG简化版）

### 🎯 场景与目标

**用大白话理解**：你有一个"读了很多文档的助手"——你提问，它先在文档里搜索相关内容，然后基于找到的内容回答你，还会告诉你答案来自哪份文档。这就是 RAG（检索增强生成）。

**RAG 是什么？**

```
没有 RAG 的 AI = 考试时不让翻书，只凭记忆答题
  → 可能答错，可能编造（幻觉问题）

有了 RAG 的 AI = 考试时可以翻书（开卷考试）
  → 先找到相关段落，再基于事实回答
  → 能引用来源，答案更可靠
```

**完整 RAG 架构**：

```
文档 → 切分 → 向量化 → 存入向量数据库 → 查询时检索 → 传给 AI → 回答
```

**本实例的"穷人版 RAG"**：

```
文档（硬编码在 Code 节点） → 关键词匹配 → 传给 AI → 回答
```

> 不用向量数据库！关键词匹配够用。理解 RAG 思路后，再升级为向量检索。

---

### 🏗️ 工作流架构图

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│  Webhook (POST /ask)                                                     │
│       │  接收: { question }                                               │
│       ▼                                                                  │
│  HTTP Request (OpenAI - 提取关键词)                                        │
│       │  输入: question → 输出: keywords                                  │
│       ▼                                                                  │
│  Code (搜索知识库)                                                        │
│       │  用关键词匹配文档 → 输出: matched docs                             │
│       ▼                                                                  │
│  Code (构建上下文)                                                        │
│       │  将匹配的文档拼成 context → 输出: context + question               │
│       ▼                                                                  │
│  HTTP Request (OpenAI - 基于上下文回答)                                    │
│       │  输入: context + question → 输出: answer                          │
│       ▼                                                                  │
│  Code (格式化答案+来源)                                                    │
│       │  添加来源引用 → 输出: formatted answer                             │
│       ▼                                                                  │
│  Respond to Webhook                                                      │
│       └── 返回: { answer, sources, confidence }                          │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

---

### 🔑 API/凭证准备

| 凭证 | 用途 | 备注 |
|------|------|------|
| **OpenAI API Key** | 关键词提取 + 问答生成 | 与实例13共用 |

---

### 🔧 逐节点配置

#### 节点1：Webhook Trigger

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 接收问题 |
| Path | `ask` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 异步返回 |

预期请求体：

```json
{
  "question": "n8n 怎么部署？"
}
```

---

#### 节点2：HTTP Request（提取关键词）

命名：`提取关键词`

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

Body：

```json
{
  "model": "gpt-4o-mini",
  "temperature": 0.1,
  "max_tokens": 200,
  "messages": [
    {
      "role": "system",
      "content": "你是一个关键词提取器。从用户的问题中提取2-5个搜索关键词，用于在知识库中检索相关文档。只输出关键词，用逗号分隔，不要输出其他内容。例如：用户问"n8n怎么安装"，输出"n8n,安装,部署""
    },
    {
      "role": "user",
      "content": "={{ $json.body.question }}"
    }
  ]
}
```

> Temperature 设为 0.1：关键词提取需要精确、稳定，不需要创意。

---

#### 节点3：Code（搜索知识库）

命名：`搜索知识库`

```javascript
// ===== 模拟知识库（实际项目中替换为向量数据库或真实 API） =====
const knowledgeBase = [
  {
    id: 'doc-001',
    title: 'n8n 安装部署指南',
    content: `n8n 支持多种安装方式：

1. Docker 部署（推荐）
   docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n

2. Docker Compose 部署
   创建 docker-compose.yml 文件，配置端口映射和数据卷持久化，运行 docker-compose up -d。

3. npm 全局安装
   npm install n8n -g
   然后运行 n8n start

4. 桌面应用
   从 n8n.io 下载桌面版安装包。

推荐使用 Docker 部署，便于升级和管理。数据默认保存在 /home/node/.n8n 目录。`,
    tags: ['n8n', '安装', '部署', 'docker', 'npm']
  },
  {
    id: 'doc-002',
    title: 'n8n 工作流基础',
    content: `n8n 工作流由节点(Node)和连接(Connection)组成：

- 节点：执行具体操作的单元，如 HTTP Request、Code、IF 等
- 连接：节点之间的数据流向
- 触发器(Trigger)：工作流的入口，决定什么时候执行

常见触发器类型：
- Manual Trigger：手动点击执行
- Schedule Trigger：定时执行
- Webhook Trigger：接收外部请求触发

数据在节点间以 JSON 格式传递，使用 {{ $json.field }} 访问数据。`,
    tags: ['n8n', '工作流', '节点', '触发器', '基础']
  },
  {
    id: 'doc-003',
    title: 'n8n Webhook 配置',
    content: `Webhook 让 n8n 工作流变成 API 服务：

配置步骤：
1. 添加 Webhook Trigger 节点
2. 设置 HTTP Method（GET/POST/PUT/DELETE）
3. 设置 Path（如 user-register）
4. 选择 Response Mode：
   - On Received：收到请求立即返回
   - Last Node：等工作流执行完返回
   - Using Respond Node：用专用节点控制响应

安全措施：
- API Key 认证（Header Auth）
- 签名验证（Code 节点中实现）
- IP 白名单（环境变量配置）

测试 URL：http://localhost:5678/webhook-test/路径
生产 URL：http://localhost:5678/webhook/路径`,
    tags: ['n8n', 'webhook', 'api', '配置', '安全']
  },
  {
    id: 'doc-004',
    title: 'n8n AI Agent 使用',
    content: `AI Agent 是 n8n 中最强大的节点类型，由四个部分组成：

1. 语言模型（大脑）：GPT-4o-mini / Claude / Gemini / Ollama
2. 工具（工具箱）：HTTP Request Tool / Code Tool / SerpAPI
3. 记忆（笔记本）：Window Buffer Memory / Summary Memory
4. System Prompt（工作手册）：角色设定和行为规则

ReAct Agent 工作流程：
思考(Reason) → 行动(Act) → 观察(Observe) → 再思考

工具的 Description 是关键——AI 靠描述来决定用哪个工具。

Temperature 参数：
- 0.1-0.2：精确任务（分类、提取）
- 0.3-0.5：平衡任务（对话、问答）
- 0.7-0.9：创意任务（写作、故事）`,
    tags: ['n8n', 'ai', 'agent', '智能', '工具']
  },
  {
    id: 'doc-005',
    title: 'Obsidian 与 n8n 集成',
    content: `n8n 可以与 Obsidian 深度集成：

1. 文件系统访问
   n8n 的 Read/Write File 节点可以直接读写 Obsidian Vault 中的 .md 文件。

2. Webhook API
   在 Obsidian 中使用 Templater 插件，通过 HTTP 请求调用 n8n 的 Webhook API。

3. 自动整理笔记
   工作流：Webhook 接收笔记 → AI 分类 → 写入对应文件夹

4. 知识库问答
   工作流：Webhook 接收问题 → 搜索 Obsidian 笔记 → AI 回答

5. 剪藏自动化
   工作流：Webhook 接收网页内容 → AI 提取摘要 → 保存为 Obsidian 笔记

推荐使用 Local REST API 插件让 Obsidian 暴露 API 接口。`,
    tags: ['obsidian', 'n8n', '集成', '笔记', '知识库']
  }
];

// ===== 关键词搜索 =====
// 从上一个节点获取关键词
const response = $input.first().json;
let keywords = '';

if (response.choices && response.choices[0]) {
  keywords = response.choices[0].message.content || '';
}

// 解析关键词
const keywordList = keywords.split(/[,，\s]+/).filter(k => k.length > 0);

if (keywordList.length === 0) {
  return {
    json: {
      matchedDocs: [],
      keywords: [],
      matchCount: 0,
      message: '未能提取到有效关键词'
    }
  };
}

// 在知识库中搜索（关键词匹配）
const scored = knowledgeBase.map(doc => {
  let score = 0;
  const docText = (doc.title + ' ' + doc.content + ' ' + doc.tags.join(' ')).toLowerCase();

  keywordList.forEach(keyword => {
    const kw = keyword.toLowerCase();
    // 标题匹配（权重最高）
    if (doc.title.toLowerCase().includes(kw)) score += 3;
    // 标签匹配（权重高）
    if (doc.tags.some(t => t.toLowerCase().includes(kw))) score += 2;
    // 内容匹配（基础权重）
    const contentMatches = (docText.match(new RegExp(kw, 'gi')) || []).length;
    score += Math.min(contentMatches, 5); // 最多计5次
  });

  return { ...doc, score };
});

// 筛选有匹配的文档，按分数排序
const matched = scored
  .filter(doc => doc.score > 0)
  .sort((a, b) => b.score - a.score)
  .slice(0, 3); // 最多返回3篇

return {
  json: {
    matchedDocs: matched,
    keywords: keywordList,
    matchCount: matched.length,
    question: $('Webhook').first().json.body.question
  }
};
```

---

#### 节点4：Code（构建上下文）

命名：`构建上下文`

```javascript
const data = $input.first().json;
const matchedDocs = data.matchedDocs || [];
const question = data.question;

// 构建上下文文本
let context = '';
const sources = [];

if (matchedDocs.length === 0) {
  context = '知识库中没有找到与问题相关的文档。请基于你的通用知识回答，但要在回答中说明这不是基于特定文档的回答。';
} else {
  context = matchedDocs.map((doc, index) => {
    sources.push({
      id: doc.id,
      title: doc.title,
      relevanceScore: doc.score
    });
    return `[文档${index + 1}] ${doc.title}\n${doc.content}`;
  }).join('\n\n---\n\n');
}

return {
  json: {
    question: question,
    context: context,
    sources: sources,
    keywords: data.keywords,
    hasRelevantDocs: matchedDocs.length > 0
  }
};
```

---

#### 节点5：HTTP Request（基于上下文回答）

命名：`基于上下文回答`

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Predefined Credential Type` → `OpenAI API` |
| Send Body | `ON` |
| Body Content Type | `JSON` |
| Options → Timeout | `60000` |

Body：

```json
{
  "model": "gpt-4o-mini",
  "temperature": 0.3,
  "max_tokens": 2000,
  "messages": [
    {
      "role": "system",
      "content": "你是一个文档问答助手。根据提供的参考文档内容回答用户的问题。\n\n规则：\n1. 只基于参考文档内容回答，不要编造信息\n2. 如果文档中没有相关信息，明确说明\n3. 回答时引用来源（如"根据文档1..."）\n4. 回答要完整、准确、有条理\n5. 使用 Markdown 格式"
    },
    {
      "role": "user",
      "content": "参考文档：\n\n={{ $json.context }}\n\n---\n\n我的问题：={{ $json.question }}"
    }
  ]
}
```

> Temperature 设为 0.3：问答需要基于事实回答，不需要太多创意，但也不能太死板。

---

#### 节点6：Code（格式化答案+来源）

命名：`格式化答案`

```javascript
const response = $input.first().json;
const previousData = $('构建上下文').first().json;

let answer = '';
if (response.choices && response.choices[0]) {
  answer = response.choices[0].message.content || '';
}

const sources = previousData.sources || [];
const keywords = previousData.keywords || [];
const hasRelevantDocs = previousData.hasRelevantDocs;

// 格式化来源信息
const sourceInfo = sources.map((s, i) => {
  return `${i + 1}. ${s.title}（相关度: ${'★'.repeat(Math.min(Math.ceil(s.relevanceScore / 3), 5))}${'☆'.repeat(Math.max(5 - Math.ceil(s.relevanceScore / 3), 0))}）`;
}).join('\n');

// 置信度评估
let confidence = 'low';
if (sources.length >= 2 && sources[0].relevanceScore >= 5) {
  confidence = 'high';
} else if (sources.length >= 1 && sources[0].relevanceScore >= 3) {
  confidence = 'medium';
}

return {
  json: {
    question: previousData.question,
    answer: answer,
    sources: sourceInfo,
    sourceDetails: sources,
    keywords: keywords,
    confidence: confidence,
    hasRelevantDocs: hasRelevantDocs,
    timestamp: new Date().toISOString()
  }
};
```

---

#### 节点7：Respond to Webhook

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | `={{ JSON.stringify($json) }}` |
| Response Code | `200` |

---

### 🧪 测试验证

#### 测试1：精确匹配

```bash
curl -X POST http://localhost:5678/webhook-test/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "n8n怎么部署？"}'
```

**预期响应**：

```json
{
  "question": "n8n怎么部署？",
  "answer": "根据文档1，n8n支持多种安装方式：\n\n1. **Docker部署（推荐）**：`docker run -it --rm --name n8n -p 5678:5678 ...`\n2. **Docker Compose**：创建 docker-compose.yml 配置文件\n3. **npm全局安装**：`npm install n8n -g` 后运行 `n8n start`\n4. **桌面应用**：从 n8n.io 下载\n\n推荐使用Docker部署，便于升级和管理。",
  "sources": "1. n8n 安装部署指南（相关度: ★★★★★）",
  "confidence": "high",
  "hasRelevantDocs": true,
  "keywords": ["n8n", "部署", "安装"]
}
```

#### 测试2：跨文档查询

```bash
curl -X POST http://localhost:5678/webhook-test/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "AI Agent的Temperature参数怎么设置？"}'
```

**预期**：匹配到 `doc-004 n8n AI Agent 使用`，回答关于 Temperature 的说明。

#### 测试3：无匹配文档

```bash
curl -X POST http://localhost:5678/webhook-test/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "Python怎么写爬虫？"}'
```

**预期**：知识库无匹配，AI 基于通用知识回答但标注"非基于文档"。

#### 测试4：模糊查询

```bash
curl -X POST http://localhost:5678/webhook-test/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "怎么让n8n和笔记软件联动？"}'
```

**预期**：匹配到 `doc-005 Obsidian 与 n8n 集成`。

---

### 💡 变体与扩展

| 变体 | 思路 | 升级方向 |
|------|------|----------|
| **向量检索** | 用嵌入模型把文档向量化，存入 Pinecone/Weaviate | 替换 Code 搜索节点 |
| **文档自动导入** | 用 Webhook 接收文档 → 自动切片 → 向量化 → 存库 | 新增预处理流程 |
| **对话式问答** | 把 Webhook 换成 Chat Trigger + Memory | 多轮追问 |
| **Obsidian 笔记问答** | Code 节点直接读取 Vault 中的 .md 文件 | Read File 节点 |
| **多语言问答** | System Prompt 支持多语言 | 修改 Prompt |
| **答案评分** | 让 AI 自评回答质量 | 新增评分步骤 |

**升级路径：穷人版 RAG → 标准版 RAG**

```
穷人版 RAG（本实例）：
  Code 硬编码文档 → 关键词匹配 → AI 回答

标准版 RAG：
  文档切片 → OpenAI Embedding → Pinecone 存储向量
  → 查询时向量搜索 → Top-K 结果 → AI 回答

升级要改的：
  1. 搜索知识库节点 → 换成 Pinecone 查询节点
  2. 新增：文档导入 + Embedding 工作流
  3. 提取关键词节点 → 换成 Embedding 查询
```

---

### ✋ 费曼检测

1. **用你自己的话解释 RAG 是什么，为什么需要 RAG？没有 RAG 的 AI 有什么问题？**
2. **本实例的"穷人版 RAG"和标准版 RAG 的核心区别是什么？**
3. **为什么先提取关键词再搜索，而不是直接把问题丢给 AI 让它回答？**
4. **如果知识库有 10000 篇文档，关键词匹配会有什么问题？你会怎么改进？**

---

## 🍅 番茄钟5-6结束，休息5分钟

**核心概念回顾：**
- [ ] RAG = 检索增强生成，让 AI 基于事实回答而非编造
- [ ] 穷人版 RAG：关键词匹配代替向量检索
- [ ] 两步 AI 调用：提取关键词 → 基于上下文回答
- [ ] 来源引用是 RAG 的关键特征——答案可溯源
- [ ] 升级路径：关键词匹配 → 向量检索（Embedding + Pinecone）

---

# 🍅 番茄钟7：今日复习

---

## 7.1 AI 工作流模式对比

| 模式 | 核心思路 | 适用场景 | 难度 |
|------|----------|----------|------|
| **链式调用** | 多个 AI 调用串行执行，上一步输出是下一步输入 | 内容生成管道、翻译链 | ⭐⭐ |
| **AI Agent** | 一个 Agent 自主选择工具、决策执行路径 | 客服、助手、自动化 | ⭐⭐⭐ |
| **RAG** | 先检索相关文档，再让 AI 基于文档回答 | 知识问答、文档查询 | ⭐⭐⭐ |
| **Agent + RAG** | Agent 可以调用检索工具 | 复杂知识助手 | ⭐⭐⭐⭐ |

## 7.2 Prompt Engineering 速查

### System Prompt 模板

```markdown
你是 [角色描述]。

## 你的职责
- [职责1]
- [职责2]

## 工具使用规则
- [什么时候用工具A]
- [什么时候用工具B]

## 输出格式
- [期望的输出格式]

## 限制
- [不能做的事情]
```

### Prompt 优化技巧

| 技巧 | 说明 | 示例 |
|------|------|------|
| **角色设定** | 给 AI 一个明确身份 | "你是一位资深编辑" |
| **结构化指令** | 用标题和列表组织 prompt | "## 职责 / ## 规则 / ## 限制" |
| **少样本示例** | 给出输入输出示例 | "输入：n8n安装 → 输出：n8n,安装,部署" |
| **限制输出格式** | 明确要求输出格式 | "只输出关键词，用逗号分隔" |
| **防幻觉指令** | 要求基于事实回答 | "只基于提供的文档内容回答" |
| **思维链** | 让 AI 先思考再回答 | "先分析问题，再给出答案" |

### 关键词 vs 自然语言 Prompt

| 风格 | 适用 | 示例 |
|------|------|------|
| **关键词提取型** | 需要结构化输出 | "提取2-5个搜索关键词，用逗号分隔" |
| **自然语言对话型** | 开放式问答 | "基于以下文档回答用户的问题" |
| **指令型** | 精确任务 | "只输出类别名称，不要输出其他内容" |

## 7.3 模型选择指南

| 场景 | 推荐模型 | Temperature | 理由 |
|------|----------|-------------|------|
| 分类/提取 | gpt-4o-mini | 0.1 | 需要确定性 |
| 客服对话 | gpt-4o-mini | 0.3 | 平衡稳定与自然 |
| 内容生成 | gpt-4o-mini | 0.5-0.7 | 需要创意 |
| 润色修改 | gpt-4o-mini | 0.3 | 保守修改 |
| 复杂推理 | gpt-4o | 0.3 | 需要强推理 |
| 长文本处理 | Claude 3.5 Sonnet | 0.3 | 长上下文优势 |
| 数据敏感 | Ollama (Qwen) | 0.3 | 本地运行 |

## 7.4 三个实例的关联图

```
实例13: AI内容生成管道          实例14: AI智能客服
  (链式调用模式)                  (Agent 模式)
       │                              │
       │  共同点：多步 AI 调用          │  共同点：AI 自主决策
       │  区别：流程固定               │  区别：流程动态
       │                              │
       └──────────┬───────────────────┘
                  │
                  ▼
         实例15: AI文档问答
           (RAG 模式)
         共同点：AI + 外部数据
         区别：先检索后生成
                  │
                  ▼
          融合：Agent + RAG
          AI Agent 拥有检索工具
          既能自主决策，又能基于事实
```

---

### 刻意练习——AI 智能工作流

**练习目标**：用 3 种不同 Prompt 风格控制 AI 输出，构建 AI + 决策的完整工作流

**任务序列（重复×3）：**

```
===== 循环 1：3 种 Prompt 风格 =====
用同一个问题测试以下三种 Prompt 风格：
1. 简短指令型：「用一句话回答」
2. 角色设定型：「你是一个资深科学家...」
3. 结构化输出型：要求返回 JSON 格式
验证：三种风格输出的格式和内容明显不同

===== 循环 2：AI 输出结构化解析 =====
构建工作流：HTTP Request（OpenAI）→ Code（解析响应）→ Set（结构化字段）
让 AI 生成一段产品描述，Code 节点解析提取：名称、价格、特点
验证：输出的 JSON 包含结构化的字段而非原始文本片段

===== 循环 3：AI + 决策完整工作流 =====
构建 AI + 决策的完整工作流：
Webhook 接收用户消息 → OpenAI 分类（紧急/普通/咨询）
→ Switch 按分类路由到不同处理分支
验证：不同类别的消息被正确路由到对应分支
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| Prompt 工程与风格控制 | ⬜ | ⬜ | ⬜ |
| AI 输出结构化解析 | ⬜ | ⬜ | ⬜ |
| Temperature 参数调优 | ⬜ | ⬜ | ⬜ |
| AI + 条件决策整合 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Temperature 从 0 到 1 分别适合什么任务？如果让 AI 做分类任务，应该用高 Temperature 还是低 Temperature？为什么？

---

# 🍅 番茄钟8：费曼综合检测

---

## 8.1 今日自检清单

完成以下所有项才算通过 Day 5 实例训练：

- [ ] 实例13：AI内容生成管道运行成功
- [ ] 理解链式调用：大纲 → 正文 → 润色
- [ ] 理解 Temperature 参数对每步 AI 调用的影响
- [ ] 理解 `$('节点名')` 跨节点引用数据的方法
- [ ] 实例14：AI智能客服运行成功
- [ ] 理解 AI Agent 的四个核心组件
- [ ] 理解工具 Description 的重要性
- [ ] 理解 Window Buffer Memory 的工作方式
- [ ] 实例15：AI文档问答运行成功
- [ ] 理解 RAG 的核心思路
- [ ] 理解穷人版 RAG 和标准版 RAG 的区别
- [ ] 能说出三种 AI 工作流模式的区别

## 8.2 费曼一句话总结

> **AI 工作流有三种核心模式：链式调用让 AI 像流水线一样分步完成任务，AI Agent 让 AI 像带工具箱的实习生一样自主决策，RAG 让 AI 像开卷考试一样基于事实回答。三种模式可以融合——Agent + RAG 是最强组合。**

## 8.3 费曼综合检测

请用自己的话回答以下问题（不看教程）：

1. **向一个不懂技术的人解释 RAG 是什么，为什么需要它。**
2. **AI Agent 的工具为什么需要写 Description？如果不写会怎样？**
3. **在内容生成管道中，为什么生成大纲用 Temperature 0.5，生成正文用 0.7，润色用 0.3？调换会怎样？**
4. **穷人版 RAG 和标准版 RAG 的区别是什么？升级需要改什么？**
5. **如果你想搭建一个"AI 学习助手"——用户输入知识点，AI 从 Obsidian 笔记中搜索相关内容并回答，你会用哪种模式？画出工作流架构。**

## 8.4 学习笔记

```markdown
## Day 5 实例训练 学习笔记

### 今天最大的收获
（用你自己的话写）

### 三个实例中哪个最有用？为什么？

### 还没搞懂的地方
（记录费曼检测中答不上来的问题）

### 我想用 AI 工作流做的项目
（结合你的实际需求，想想还能用这些模式做什么）

### 为 Day 6 做准备
（企业级模式：多级审批流 + 跨系统数据同步）
```

---

## 🎉 Day 5 完成！

**今日成果：**
- 搭建了 AI 内容生成管道（链式调用模式）
- 搭建了 AI 智能客服（Agent 模式）
- 搭建了 AI 文档问答（RAG 简化版）
- 掌握了 Temperature 参数、工具 Description、记忆配置
- 理解了链式调用 / Agent / RAG 三种模式

**明天预告：** [[实例Day6-企业级模式]] - 多级审批流 + 跨系统数据同步

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[实例Day4-通知与通信]] - 上一天
> - [[实例Day6-企业级模式]] - 下一天
> - [[Day6-AI-Agent工作流]] - AI Agent 理论篇
> - [[Day5-Webhook与外部集成]] - Webhook 理论篇
