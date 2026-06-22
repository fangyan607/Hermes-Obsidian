# Day 3：API集成实战（3个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建3个API集成工作流，掌握 OpenAI、智谱GLM、GitHub API 的调用
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：实例7 · OpenAI智能助手
🍅 番茄3-4：实例8 · GLM-OCR文档转换
🍅 番茄5-6：实例9 · GitHub仓库监控
🍅 番茄7-8：今日复习 + 费曼综合检测
```

---

## 实例7：OpenAI智能助手

### 🎯 场景与目标

**场景**：你想通过一个简单的 HTTP 请求就能调用 GPT 模型，把它作为后端服务嵌入到任何应用中——比如聊天机器人、文档问答、内容生成。

**目标**：搭建一个 Webhook API，接收用户消息，调用 OpenAI Chat Completions API，返回 AI 回复。

**前置知识**：[[Day3-凭证管理与API集成|理论 Day 3]] 的凭证创建和 HTTP Request 配置

---

### 🏗️ 工作流架构图

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────────┐
│   Webhook    │────▶│    Code      │────▶│ HTTP Request │────▶│    Code      │────▶│ Respond to       │
│  POST /chat  │     │  构建消息体   │     │   OpenAI API │     │  提取回复     │     │   Webhook        │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘     └──────────────────┘
      ▲                                                               │
      │                                                               ▼
  外部调用                                                     返回 AI 回复
  (curl/代码)                                              JSON 格式响应
```

**工作流模式**：Webhook API → API 调用 → 响应返回

---

### 🔑 API/凭证准备

#### 获取 OpenAI API Key

1. 访问 [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. 登录账号（如果没有，先注册并绑定付款方式）
3. 点击 **Create new secret key**
4. 输入 Key 名称，如 `n8n-workflow`
5. 点击 **Create secret key**
6. **立即复制** Key（格式：`sk-proj-xxxxxxxxxx`）
7. ⚠️ 关闭窗口后无法再次查看！务必保存到安全位置

> 💡 新用户有 $5 赠金，足够完成本教程的所有测试

#### 在 n8n 中创建凭证

1. 左侧菜单 → **Credentials** → **Add Credential**
2. 搜索 `Header Auth` → 选中
3. 填写：

```
Credential Name: OpenAI-API-Key
Name: Authorization
Value: Bearer sk-proj-你的密钥
```

4. 点击 **Save**

> ⚠️ 注意：`Bearer` 和 `sk-proj-` 之间有一个空格！格式必须是 `Bearer sk-proj-xxxxx`

---

### 🔧 逐节点配置

#### 节点1：Webhook（接收请求）

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 接收 POST 请求 |
| Path | `chat` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 用响应节点返回结果 |

**Webhook URL**：`http://localhost:5678/webhook/chat`

**请求体格式**（调用方发送）：
```json
{
  "message": "用一句话解释量子计算"
}
```

---

#### 节点2：Code（构建消息体）

**Language**: JavaScript
**Mode**: Run Once for All Items

```javascript
// ============================================
// 构建 OpenAI Chat Completions 请求体
// ============================================

// 获取 Webhook 传入的用户消息
const userMessage = $input.first().json.body.message;

if (!userMessage) {
  throw new Error('请求体缺少 message 字段');
}

// 构建消息数组（system + user）
const messages = [
  {
    role: 'system',
    content: '你是一个有帮助的AI助手，回答简洁准确，优先使用中文。'
  },
  {
    role: 'user',
    content: userMessage
  }
];

return [{
  json: {
    messages: messages,
    userMessage: userMessage
  }
}];
```

**节点输出**：
```json
{
  "messages": [
    { "role": "system", "content": "你是一个有帮助的AI助手..." },
    { "role": "user", "content": "用一句话解释量子计算" }
  ],
  "userMessage": "用一句话解释量子计算"
}
```

---

#### 节点3：HTTP Request（调用 OpenAI API）

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://api.openai.com/v1/chat/completions` |
| Authentication | `Generic Credential Type` |
| Generic Auth Type | `Header Auth` |
| Credential for Header Auth | `OpenAI-API-Key` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

**Body**（切换到 JSON 模式，直接输入）：

```json
{
  "model": "gpt-4o-mini",
  "messages": {{ JSON.stringify($json.messages) }},
  "temperature": 0.7,
  "max_tokens": 1000
}
```

**或者使用 Specify Body 方式**（逐字段添加）：

| Parameter Name | Parameter Value |
|----------------|-----------------|
| `model` | `gpt-4o-mini` |
| `messages` | `={{ $json.messages }}` |
| `temperature` | `0.7` |
| `max_tokens` | `1000` |

> 💡 `gpt-4o-mini` 是性价比最高的模型，适合学习和日常使用。如需更强能力可换 `gpt-4o`

**OpenAI API 响应结构**：
```json
{
  "id": "chatcmpl-xxxxx",
  "object": "chat.completion",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "量子计算利用量子叠加和纠缠等原理..."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 25,
    "completion_tokens": 18,
    "total_tokens": 43
  }
}
```

---

#### 节点4：Code（提取回复）

**Language**: JavaScript
**Mode**: Run Once for All Items

```javascript
// ============================================
// 从 OpenAI 响应中提取 AI 回复
// ============================================

const response = $input.first().json;

// 提取回复文本
const aiReply = response.choices?.[0]?.message?.content || '（无回复）';

// 提取 token 使用量
const usage = response.usage || {};

// 获取原始用户消息（从上游节点引用）
const userMessage = $('构建消息体').first().json.userMessage;

return [{
  json: {
    reply: aiReply,
    userMessage: userMessage,
    model: response.model || 'gpt-4o-mini',
    tokensUsed: usage.total_tokens || 0,
    timestamp: new Date().toISOString()
  }
}];
```

**节点输出**：
```json
{
  "reply": "量子计算利用量子叠加和纠缠等原理，让量子比特同时表示0和1，从而实现比经典计算机指数级的并行计算能力。",
  "userMessage": "用一句话解释量子计算",
  "model": "gpt-4o-mini",
  "tokensUsed": 43,
  "timestamp": "2026-06-08T10:30:00.000Z"
}
```

---

#### 节点5：Respond to Webhook（返回响应）

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | 见下方 |

```json
{
  "success": true,
  "reply": "{{ $json.reply }}",
  "model": "{{ $json.model }}",
  "tokensUsed": {{ $json.tokensUsed }}
}
```

---

### 🧪 测试验证

#### 测试1：基本对话

```bash
curl -X POST http://localhost:5678/webhook/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "用一句话解释量子计算"}'
```

**期望输出**：
```json
{
  "success": true,
  "reply": "量子计算利用量子叠加和纠缠等原理，让量子比特同时表示0和1，从而实现指数级的并行计算能力。",
  "model": "gpt-4o-mini",
  "tokensUsed": 43
}
```

#### 测试2：多轮对话思路（扩展）

```bash
curl -X POST http://localhost:5678/webhook/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "请用Python写一个快速排序"}'
```

**验证点**：
- [ ] 返回的 `reply` 包含代码块
- [ ] `tokensUsed` 有合理数值
- [ ] 响应时间 < 10 秒

#### 测试3：错误情况——缺少 message

```bash
curl -X POST http://localhost:5678/webhook/chat \
  -H "Content-Type: application/json" \
  -d '{"text": "这条消息字段名错了"}'
```

**期望结果**：Code 节点抛出错误 `请求体缺少 message 字段`

---

### 💡 变体与扩展

| 变体 | 说明 | 改动点 |
|------|------|--------|
| **多模型切换** | 在请求中传入 `model` 参数 | Code 节点读取 `body.model`，默认 `gpt-4o-mini` |
| **多轮对话** | 传入完整 messages 数组 | Webhook 接收 messages，跳过构建步骤 |
| **流式响应** | 使用 SSE 逐字输出 | 设置 `"stream": true`，需自定义响应处理 |
| **多 Key 轮询** | 避免单 Key 限速 | Code 节点随机选择凭证 |
| **添加记忆** | 保存对话历史到数据库 | 在 Code 节点中查询历史消息拼入 messages |

**多模型切换示例**（修改节点2的 Code）：

```javascript
const body = $input.first().json.body;
const userMessage = body.message;
const model = body.model || 'gpt-4o-mini'; // 允许调用方指定模型

const messages = [
  { role: 'system', content: '你是一个有帮助的AI助手。' },
  { role: 'user', content: userMessage }
];

return [{
  json: {
    messages: messages,
    model: model,
    userMessage: userMessage
  }
}];
```

---

### ✋ 费曼检测

1. **OpenAI API 的认证方式是什么？Header 的格式是什么？**
2. **为什么要在 Code 节点中构建 messages 数组，而不是直接在 HTTP Request 的 Body 中硬编码？**
3. **`choices[0].message.content` 这个路径中，`[0]` 代表什么？为什么是数组？**
4. **如果用户发送空消息，工作流会怎样？如何处理？**
5. **`temperature: 0.7` 改为 `0` 会怎样？改为 `1.5` 呢？**

> 答不出来就回去重读对应部分，直到能用自己的话解释清楚。

---

## 🍅 番茄1-2结束，休息5分钟

**验证清单：**
- [ ] OpenAI API Key 已获取并创建凭证
- [ ] 工作流5个节点全部配置完成
- [ ] curl 测试返回了 AI 回复
- [ ] 理解 messages 数组的结构（system + user）
- [ ] 理解 `choices[0].message.content` 的提取路径

---

## 实例8：GLM-OCR文档转换

### 🎯 场景与目标

**场景**：你有大量 PDF 或图片文档需要转换为 Markdown 格式，存入 Obsidian 知识库。手动 OCR 效率太低，需要一个自动化服务——上传图片/PDF，自动识别文字，格式化为 Obsidian 笔记。

**目标**：搭建一个 Webhook API，接收图片/PDF，调用智谱 GLM-OCR API 识别，格式化为 Obsidian Markdown 并保存。

**参考文档**：[[LLM-Wiki/Projects/n8n+GLM-OCR工作流]]

---

### 🏗️ 工作流架构图

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────────┐
│   Webhook    │────▶│ HTTP Request │────▶│    Code      │────▶│  Write File  │────▶│ Respond to       │
│  POST /ocr   │     │  GLM-OCR API │     │ 格式化MD     │     │ 保存到vault  │     │   Webhook        │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘     └──────────────────┘
      ▲                     │                    │                     │                     │
      │               (图片/PDF            (frontmatter +          (Obsidian            (JSON响应
  外部调用              base64编码)          OCR内容)              converted/)           含文件路径)
```

**工作流模式**：Webhook → OCR API 调用 → 数据转换 → 文件写入 → 响应返回

---

### 🔑 API/凭证准备

#### 获取智谱 GLM API Key

1. 访问 [https://open.bigmodel.cn/](https://open.bigmodel.cn/)
2. 点击 **注册/登录**（支持手机号注册）
3. 登录后进入 **控制台**
4. 左侧菜单点击 **API Keys**
5. 点击 **添加 API Key**
6. 复制生成的 Key（格式：`sk-xxxxxxxxxx`）

> 💡 注册即送 token，足够完成本教程的测试

#### 在 n8n 中创建凭证

1. 左侧菜单 → **Credentials** → **Add Credential**
2. 搜索 `Header Auth` → 选中
3. 填写：

```
Credential Name: GLM-API-Key
Name: Authorization
Value: Bearer sk-你的密钥
```

4. 点击 **Save**

> ⚠️ 格式：`Bearer sk-xxxxx`，Bearer 后有空格

---

### 🔧 逐节点配置

#### 节点1：Webhook（接收图片/PDF）

| 字段 | 值 | 说明 |
|------|-----|------|
| HTTP Method | `POST` | 接收 POST 请求 |
| Path | `ocr` | API 路径 |
| Response Mode | `Using 'Respond to Webhook' Node` | 用响应节点返回结果 |

**支持的调用方式**：

方式A — 通过 URL 发送图片：
```json
{
  "imageUrl": "https://example.com/document.png"
}
```

方式B — 通过 base64 发送图片：
```json
{
  "imageBase64": "data:image/png;base64,iVBORw0KGgo..."
}
```

方式C — 上传文件（multipart/form-data）：
```bash
curl -X POST http://localhost:5678/webhook/ocr \
  -F "file=@document.png"
```

---

#### 节点2：HTTP Request（调用 GLM-OCR API）

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://open.bigmodel.cn/api/paas/v4/ocr` |
| Authentication | `Generic Credential Type` |
| Generic Auth Type | `Header Auth` |
| Credential for Header Auth | `GLM-API-Key` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

**Body**（需要根据输入来源动态构建图片数据）：

对于 URL 方式：
```json
{
  "image": "{{ $json.body.imageUrl }}"
}
```

对于 base64 方式：
```json
{
  "image": "{{ $json.body.imageBase64 }}"
}
```

对于文件上传方式：
```json
{
  "image": "data:{{ $binary.file.mimeType }};base64,{{ $binary.file.data }}"
}
```

> 💡 实际使用时，建议在 HTTP Request 前加一个 Code 节点统一处理三种输入来源，输出标准的 `image` 字段。详见下方的"统一输入处理"。

**统一输入处理的 Code 节点**（可选，插在 Webhook 和 HTTP Request 之间）：

```javascript
// ============================================
// 统一处理三种 OCR 输入来源
// ============================================

const input = $input.first();
let imageData = '';
let sourceType = '';

// 方式1: 图片 URL
if (input.json.body?.imageUrl) {
  imageData = input.json.body.imageUrl;
  sourceType = 'url';
}
// 方式2: base64 编码
else if (input.json.body?.imageBase64) {
  imageData = input.json.body.imageBase64;
  sourceType = 'base64';
}
// 方式3: 文件上传
else if (input.binary?.file) {
  const mimeType = input.binary.file.mimeType;
  const base64Data = input.binary.file.data;
  imageData = `data:${mimeType};base64,${base64Data}`;
  sourceType = 'upload';
}
else {
  throw new Error('请提供 imageUrl、imageBase64 或上传文件');
}

return [{
  json: {
    image: imageData,
    sourceType: sourceType
  }
}];
```

如果使用了这个 Code 节点，HTTP Request 的 Body 简化为：
```json
{
  "image": "{{ $json.image }}"
}
```

**GLM-OCR API 响应结构**：
```json
{
  "data": {
    "content": "# 文档标题\n\n识别出的文本内容...\n\n- 列表项1\n- 列表项2"
  }
}
```

---

#### 节点3：Code（格式化为 Obsidian Markdown）

**Language**: JavaScript
**Mode**: Run Once for All Items

```javascript
// ============================================
// GLM-OCR 结果转换为 Obsidian Markdown 格式
// ============================================

// 获取 OCR API 响应
const ocrResult = $input.first().json;

// 日志（调试用）
console.log('OCR API 响应:', JSON.stringify(ocrResult, null, 2));

// 提取识别文本（适配多种响应格式）
let markdownContent = '';

// 格式1: { data: { content: "..." } }  ← GLM-OCR 标准格式
if (ocrResult.data && ocrResult.data.content) {
  markdownContent = ocrResult.data.content;
}
// 格式2: { choices: [{ message: { content: "..." } }] }  ← 类 OpenAI 格式
else if (ocrResult.choices && ocrResult.choices[0]) {
  markdownContent = ocrResult.choices[0].message?.content || '';
}
// 格式3: 直接文本
else if (ocrResult.text) {
  markdownContent = ocrResult.text;
}
// 格式4: 结果数组
else if (ocrResult.results) {
  markdownContent = ocrResult.results.map(r => r.text || r.content || '').join('\n\n');
}

// 未识别到内容
if (!markdownContent) {
  markdownContent = '> ⚠️ OCR 未识别到文本内容\n\n请检查文件是否清晰。';
}

// 尝试从内容中提取标题
let title = '未命名文档';
const lines = markdownContent.split('\n');
for (const line of lines) {
  const match = line.match(/^#\s+(.+)$/);
  if (match) {
    title = match[1].trim();
    break;
  }
}
// 如果没有标题行，取第一行非空文本
if (title === '未命名文档') {
  for (const line of lines) {
    const trimmed = line.trim();
    if (trimmed.length > 3 && !trimmed.startsWith('>')) {
      title = trimmed.substring(0, 50);
      break;
    }
  }
}

// 清理文件名中的非法字符
title = title.replace(/[\\/:*?"<>|]/g, '_').trim();

// 生成时间信息
const now = new Date();
const dateStr = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
const timeStr = now.toLocaleString('zh-CN');

// Obsidian Frontmatter
const frontmatter = `---
title: ${title}
created: ${now.toISOString()}
date: ${dateStr}
source: OCR 自动转换
tool: n8n + GLM-OCR
tags:
  - ocr
  - pdf-convert
---`;

// Markdown 文档头部
const header = `
# ${title}

> 📅 转换时间: ${timeStr}
> 🔧 工具: n8n + GLM-OCR 自动转换

---

`;

// 组合完整内容
const finalContent = frontmatter + header + markdownContent;

// 生成文件名
const filename = `${title}_${dateStr}.md`;

return [{
  json: {
    content: finalContent,
    filename: filename,
    title: title,
    originalLength: markdownContent.length,
    convertTime: now.toISOString()
  }
}];
```

**节点输出**：
```json
{
  "content": "---\ntitle: 项目报告\ncreated: 2026-06-08T10:30:00.000Z\n...\n---\n\n# 项目报告\n\n> 📅 转换时间: 2026/6/8 10:30:00\n\n---\n\n识别出的文本内容...",
  "filename": "项目报告_2026-06-08.md",
  "title": "项目报告",
  "originalLength": 1234,
  "convertTime": "2026-06-08T10:30:00.000Z"
}
```

---

#### 节点4：Write File（保存到 Obsidian）

| 字段 | 值 |
|------|-----|
| Operation | `Write to file` |
| File Name | `={{ $json.filename }}` |
| Data | `={{ $json.content }}` |
| Destination Folder | `D:\ObsidianVault\ideal\converted` |

> ⚠️ 确保目标文件夹已存在。如果不存在，先手动创建或在工作流前加 Execute Command 节点：
> ```bash
> if not exist "D:\ObsidianVault\ideal\converted" mkdir "D:\ObsidianVault\ideal\converted"
> ```

---

#### 节点5：Respond to Webhook（返回结果）

| 字段 | 值 |
|------|-----|
| Respond With | `JSON` |
| Response Body | 见下方 |

```json
{
  "success": true,
  "filename": "{{ $json.filename }}",
  "title": "{{ $json.title }}",
  "contentLength": {{ $json.originalLength }},
  "savedPath": "converted/{{ $json.filename }}",
  "message": "OCR 转换完成，已保存到 Obsidian"
}
```

---

### 🧪 测试验证

#### 测试1：通过图片 URL 调用

```bash
curl -X POST http://localhost:5678/webhook/ocr \
  -H "Content-Type: application/json" \
  -d '{"imageUrl": "https://example.com/sample-document.png"}'
```

**期望输出**：
```json
{
  "success": true,
  "filename": "文档标题_2026-06-08.md",
  "title": "文档标题",
  "contentLength": 567,
  "savedPath": "converted/文档标题_2026-06-08.md",
  "message": "OCR 转换完成，已保存到 Obsidian"
}
```

#### 测试2：通过 base64 调用

```bash
# 先将图片转为 base64（Linux/Mac）
BASE64_DATA=$(base64 -i test-image.png)

# 发送请求
curl -X POST http://localhost:5678/webhook/ocr \
  -H "Content-Type: application/json" \
  -d "{\"imageBase64\": \"data:image/png;base64,${BASE64_DATA}\"}"
```

#### 测试3：通过文件上传调用

```bash
curl -X POST http://localhost:5678/webhook/ocr \
  -F "file=@test-document.pdf"
```

**验证点**：
- [ ] `converted/` 文件夹中出现了新的 .md 文件
- [ ] .md 文件包含正确的 frontmatter（title, created, tags）
- [ ] OCR 识别的文本内容完整
- [ ] 响应 JSON 包含正确的文件名和路径

#### 常见错误排查

| 错误 | 原因 | 解决 |
|------|------|------|
| `401 Unauthorized` | API Key 格式错误 | 检查 `Bearer sk-xxxxx` 格式 |
| `ENOENT: no such directory` | 输出文件夹不存在 | 手动创建 `converted/` 文件夹 |
| `Request body too large` | 文件超过 API 限制 | 压缩文件或拆分页面 |
| OCR 内容为空 | 图片质量太低 | 使用更清晰的源文件 |

---

### 💡 变体与扩展

| 变体 | 说明 | 改动点 |
|------|------|--------|
| **批量处理** | 监控文件夹自动转换所有 PDF | 参考 [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] 的批量方案 |
| **Obsidian REST API 写入** | 通过 API 直接写入 Vault | 替换 Write File 为 HTTP Request 调用 Obsidian Local REST API |
| **添加 AI 摘要** | OCR 后让 GPT 生成摘要 | 在 Code 节点后加 HTTP Request 调用 OpenAI |
| **Templater 调用** | 在 Obsidian 中一键触发 | 参考 [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] 的 Templater 方案 |
| **错误处理分支** | OCR 失败时通知 | 在 HTTP Request 开启 Continue On Fail，加 IF 节点分流 |

---

### ✋ 费曼检测

1. **GLM-OCR API 的图片数据有哪几种传入方式？每种方式的 `image` 字段值是什么格式？**
2. **Data URL 的格式是什么？`data:image/png;base64,` 后面跟的是什么？**
3. **为什么 Code 节点中要适配多种响应格式（`data.content`、`choices[0].message`）？**
4. **Obsidian 的 frontmatter 有什么作用？如果不用 frontmatter 直接写内容会怎样？**
5. **如果要支持 PDF 文件上传，Webhook 节点需要做什么特殊配置？**

> 答不出来就回去重读对应部分，直到能用自己的话解释清楚。

---

## 🍅 番茄3-4结束，休息5分钟

**验证清单：**
- [ ] 智谱 GLM API Key 已获取并创建凭证
- [ ] 工作流5个节点全部配置完成
- [ ] 至少一种输入方式（URL/base64/上传）测试成功
- [ ] `converted/` 文件夹中有格式正确的 .md 文件
- [ ] 理解 Data URL 格式和 base64 编码

---

## 实例9：GitHub仓库监控

### 🎯 场景与目标

**场景**：你负责维护一个开源项目或团队仓库，需要实时了解仓库的动态——新 Issue、新 PR、代码推送。手动刷新 GitHub 页面效率太低，需要自动监控并推送通知。

**目标**：搭建一个定时工作流，每30分钟检查仓库事件，筛选新的 Issue/PR/Push，推送到钉钉或 Slack。

---

### 🏗️ 工作流架构图

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌────────┐
│  Schedule    │────▶│ HTTP Request │────▶│    Code      │────▶│   IF   │
│  每30分钟     │     │  GitHub API  │     │  筛选新事件   │     │ 有新事件│
└──────────────┘     └──────────────┘     └──────────────┘     └────────┘
                                                                       │
                                            ┌──────────────────────────┘
                                            │ Yes                      No → 结束
                                            ▼
                                     ┌──────────────┐
                                     │    Switch    │
                                     │  事件类型分流  │
                                     └──────────────┘
                                      │      │      │
                              IssuesEvent PR Event  PushEvent
                                      │      │      │
                                      ▼      ▼      ▼
                                   ┌──────────────────┐
                                   │  Set (格式化消息)  │
                                   │  每种类型不同模板   │
                                   └──────────────────┘
                                              │
                                              ▼
                                   ┌──────────────────┐
                                   │ HTTP Request     │
                                   │ 发送到钉钉/Slack  │
                                   └──────────────────┘
```

**工作流模式**：定时触发 → API 查询 → 数据过滤 → 条件分流 → 消息推送

---

### 🔑 API/凭证准备

#### 获取 GitHub Personal Access Token

1. 访问 [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. 点击 **Generate new token** → 选择 **Generate new token (classic)**
3. 填写：

```
Note: n8n-repo-monitor
Expiration: 90 days（或自定义）
Scopes: ✅ repo（完整仓库访问）
        ✅ notifications（读取通知）
```

4. 点击 **Generate token**
5. **立即复制** Token（格式：`ghp_xxxxxxxxxxxx`）
6. ⚠️ 关闭页面后无法再次查看！

#### 在 n8n 中创建凭证

1. 左侧菜单 → **Credentials** → **Add Credential**
2. 搜索 `Header Auth` → 选中
3. 填写：

```
Credential Name: GitHub-Token
Name: Authorization
Value: token ghp_你的token
```

4. 点击 **Save**

> ⚠️ GitHub Token 的格式是 `token ghp_xxxxx`，不是 `Bearer ghp_xxxxx`！注意 `token` 后有空格。

---

### 🔧 逐节点配置

#### 节点1：Schedule Trigger（定时触发）

| 字段 | 值 | 说明 |
|------|-----|------|
| Trigger Interval | `Minutes` | 按分钟触发 |
| Minutes Between Triggers | `30` | 每30分钟执行一次 |

> 💡 开发调试时可以先设为5分钟，确认无误后改为30分钟

---

#### 节点2：HTTP Request（获取仓库事件）

| 字段 | 值 |
|------|-----|
| Method | `GET` |
| URL | `https://api.github.com/repos/{owner}/{repo}/events` |
| Authentication | `Generic Credential Type` |
| Generic Auth Type | `Header Auth` |
| Credential for Header Auth | `GitHub-Token` |

**额外 Headers**（点击 Send Headers 开关）：

| Header Name | Header Value |
|-------------|--------------|
| `Accept` | `application/vnd.github.v3+json` |

**URL 示例**：
```
https://api.github.com/repos/octocat/Hello-World/events
```

> 替换 `{owner}/{repo}` 为你要监控的仓库，如 `vuejs/core`、`facebook/react`

**GitHub Events API 响应结构**（数组，每项一个事件）：
```json
[
  {
    "id": "12345678900",
    "type": "IssuesEvent",
    "actor": {
      "login": "username",
      "avatar_url": "https://avatars.githubusercontent.com/u/xxx"
    },
    "repo": {
      "name": "owner/repo"
    },
    "payload": {
      "action": "opened",
      "issue": {
        "number": 42,
        "title": "Bug: 登录页面报错",
        "html_url": "https://github.com/owner/repo/issues/42",
        "user": { "login": "reporter" }
      }
    },
    "created_at": "2026-06-08T10:00:00Z"
  }
]
```

---

#### 节点3：Code（筛选新事件）

**Language**: JavaScript
**Mode**: Run Once for All Items

```javascript
// ============================================
// 筛选 GitHub 仓库中的新事件
// ============================================

const events = $input.first().json;

if (!Array.isArray(events)) {
  return [{ json: { hasNewEvents: false, events: [] } }];
}

// 只关注这三种事件类型
const TARGET_TYPES = ['IssuesEvent', 'PullRequestEvent', 'PushEvent'];

// 筛选目标事件（最多取最近10条）
const recentEvents = events
  .filter(e => TARGET_TYPES.includes(e.type))
  .slice(0, 10)
  .map(e => ({
    id: e.id,
    type: e.type,
    actor: e.actor?.login || 'unknown',
    repo: e.repo?.name || '',
    createdAt: e.created_at,
    payload: e.payload
  }));

const hasNewEvents = recentEvents.length > 0;

return [{
  json: {
    hasNewEvents: hasNewEvents,
    events: recentEvents,
    count: recentEvents.length,
    checkedAt: new Date().toISOString()
  }
}];
```

> 💡 完整版可加入时间过滤：只返回上次检查之后的新事件。这需要用 n8n 的 Static Data 存储上次检查时间。

**带时间过滤的增强版**：

```javascript
// ============================================
// 筛选新事件（带时间过滤）
// ============================================

const events = $input.first().json;
const workflow = this.getWorkflow();

// 从 Static Data 读取上次检查时间
if (!workflow.staticData.lastCheckTime) {
  workflow.staticData.lastCheckTime = new Date(
    Date.now() - 30 * 60 * 1000  // 首次运行，回溯30分钟
  ).toISOString();
}

const lastCheckTime = new Date(workflow.staticData.lastCheckTime);

const TARGET_TYPES = ['IssuesEvent', 'PullRequestEvent', 'PushEvent'];

const newEvents = events
  .filter(e => {
    const eventTime = new Date(e.created_at);
    return TARGET_TYPES.includes(e.type) && eventTime > lastCheckTime;
  })
  .map(e => ({
    id: e.id,
    type: e.type,
    actor: e.actor?.login || 'unknown',
    repo: e.repo?.name || '',
    createdAt: e.created_at,
    payload: e.payload
  }));

// 更新最后检查时间
workflow.staticData.lastCheckTime = new Date().toISOString();

return [{
  json: {
    hasNewEvents: newEvents.length > 0,
    events: newEvents,
    count: newEvents.length,
    lastCheckTime: lastCheckTime.toISOString()
  }
}];
```

---

#### 节点4：IF（是否有新事件）

| 字段 | 值 |
|------|-----|
| Value 1 | `={{ $json.hasNewEvents }}` |
| Operation | `equal` |
| Value 2 | `true` |

- True 分支 → 继续处理
- False 分支 → 结束（无新事件）

---

#### 节点5：Split Out（拆分事件数组）

| 字段 | 值 |
|------|-----|
| Field to Split Out | `events` |

将事件数组拆分为独立项，每条事件单独处理。

---

#### 节点6：Switch（按事件类型分流）

| 字段 | 值 |
|------|-----|
| Value to match on | `={{ $json.type }}` |

**路由规则**：

| Output | Condition | 说明 |
|--------|-----------|------|
| 0 | `IssuesEvent` | Issue 事件 |
| 1 | `PullRequestEvent` | PR 事件 |
| 2 | `PushEvent` | 推送事件 |
| 3 | (fallback) | 其他事件（忽略） |

---

#### 节点7a：Set（格式化 Issue 消息，输出0）

| 字段 | 值 |
|------|-----|
| eventType | `Issue` |
| message | `={{ '🔴 新Issue: #' + $json.payload.issue.number + ' ' + $json.payload.issue.title + '\n👤 ' + $json.payload.issue.user.login + '\n🔗 ' + $json.payload.issue.html_url }}` |

**输出示例**：
```
🔴 新Issue: #42 Bug: 登录页面报错
👤 reporter
🔗 https://github.com/owner/repo/issues/42
```

---

#### 节点7b：Set（格式化 PR 消息，输出1）

| 字段 | 值 |
|------|-----|
| eventType | `PullRequest` |
| message | `={{ '🟣 新PR: #' + $json.payload.pull_request.number + ' ' + $json.payload.pull_request.title + '\n👤 ' + $json.payload.pull_request.user.login + '\n🔗 ' + $json.payload.pull_request.html_url }}` |

**输出示例**：
```
🟣 新PR: #15 feat: 添加用户登录功能
👤 contributor
🔗 https://github.com/owner/repo/pull/15
```

---

#### 节点7c：Set（格式化 Push 消息，输出2）

| 字段 | 值 |
|------|-----|
| eventType | `Push` |
| message | `={{ '🟢 Push: ' + $json.actor + ' 推送了 ' + ($json.payload.commits || []).length + ' 个提交到 ' + ($json.payload.ref || '').replace('refs/heads/', '') + '\n🔗 https://github.com/' + $json.repo + '/commits/' + ($json.payload.head || '') }}` |

**输出示例**：
```
🟢 Push: developer 推送了 3 个提交到 main
🔗 https://github.com/owner/repo/commits/abc123
```

---

#### 节点8：HTTP Request（发送到钉钉）

**所有分流的消息汇聚到这一个节点发送。**

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://oapi.dingtalk.com/robot/send?access_token=YOUR_TOKEN` |
| Send Body | `ON` |
| Body Content Type | `JSON` |

**Body**：
```json
{
  "msgtype": "markdown",
  "markdown": {
    "title": "GitHub 仓库动态",
    "text": "### GitHub 仓库动态\n\n{{ $json.message }}"
  }
}
```

**获取钉钉 Webhook Token**：
1. 钉钉群 → 设置 → 智能群助手 → 添加机器人 → 自定义
2. 安全设置选「加签」或「自定义关键词」
3. 复制 Webhook URL 中的 `access_token`

**如果用 Slack 替代钉钉**：

| 字段 | 值 |
|------|-----|
| Method | `POST` |
| URL | `https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX` |
| Body Content Type | `JSON` |
| Body | `{ "text": "{{ $json.message }}" }` |

---

### 🧪 测试验证

#### 测试1：直接测试 GitHub API

```bash
curl -H "Authorization: token ghp_你的token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/vuejs/core/events" | head -50
```

**期望输出**：返回 JSON 数组，每个元素包含 `type`、`actor`、`payload` 等字段

#### 测试2：测试钉钉 Webhook

```bash
curl -X POST "https://oapi.dingtalk.com/robot/send?access_token=YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "msgtype": "markdown",
    "markdown": {
      "title": "GitHub 仓库动态",
      "text": "### GitHub 仓库动态\n\n🔴 新Issue: #42 Bug: 登录页面报错\n👤 reporter\n🔗 https://github.com/owner/repo/issues/42"
    }
  }'
```

**期望输出**：
```json
{ "errcode": 0, "errmsg": "ok" }
```

#### 测试3：完整工作流测试

1. 手动点击 **Execute Workflow**
2. 观察 Schedule Trigger → HTTP Request → Code → IF 的数据流
3. 检查 Switch 是否正确分流了不同类型的事件
4. 检查钉钉群是否收到了通知消息

**验证点**：
- [ ] GitHub API 返回了事件列表
- [ ] Code 节点正确筛选了 IssuesEvent / PullRequestEvent / PushEvent
- [ ] IF 节点在无新事件时正确终止
- [ ] Switch 将不同事件类型路由到对应的 Set 节点
- [ ] 消息格式正确且包含关键信息（编号、标题、链接）
- [ ] 钉钉/Slack 收到了通知

---

### 💡 变体与扩展

| 变体 | 说明 | 改动点 |
|------|------|--------|
| **监控多个仓库** | 同时关注多个 repo | Code 节点循环调用多个仓库的 API |
| **邮件通知** | 不用钉钉，用邮件推送 | 替换钉钉 HTTP Request 为 Send Email 节点 |
| **事件去重** | 避免重复通知同一事件 | 用 Static Data 或外部数据库记录已通知的事件 ID |
| **标签过滤** | 只通知带特定标签的 Issue | Code 节点中检查 `payload.issue.labels` |
| **Review 提醒** | PR 请求你 review 时通知 | 检查 `payload.pull_request.requested_reviewers` |
| **统计报表** | 每日生成仓库活动报表 | Schedule Trigger 每天1次，汇总发送 |

**监控多个仓库的 Code 节点**：

```javascript
// 在 Schedule Trigger 后的第一个 Code 节点
const repos = [
  { owner: 'vuejs', repo: 'core' },
  { owner: 'facebook', repo: 'react' },
  { owner: 'vercel', repo: 'next.js' }
];

// 生成多个仓库的 API URL
return repos.map(r => ({
  json: {
    url: `https://api.github.com/repos/${r.owner}/${r.repo}/events`,
    repo: `${r.owner}/${r.repo}`
  }
}));
```

---

### ✋ 费曼检测

1. **GitHub API 的认证 Header 格式是什么？为什么和 OpenAI 的 `Bearer` 不同？**
2. **GitHub Events API 返回的数据结构是什么？`type` 字段有哪些可能的值？**
3. **为什么需要 IF 节点判断 `hasNewEvents`？如果没有会怎样？**
4. **Switch 节点的 fallback 输出是什么意思？为什么不处理其他类型的事件？**
5. **如果要实现事件去重，你需要存储什么信息？存在哪里？**

> 答不出来就回去重读对应部分，直到能用自己的话解释清楚。

---

## 🍅 番茄5-6结束，休息5分钟

**验证清单：**
- [ ] GitHub Personal Access Token 已获取并创建凭证
- [ ] 工作流完整配置完成（Schedule → API → Filter → IF → Switch → Notify）
- [ ] curl 测试 GitHub API 返回了事件数据
- [ ] Switch 正确分流了 IssuesEvent / PullRequestEvent / PushEvent
- [ ] 钉钉/Slack 收到了格式正确的通知消息

---

## 🍅 番茄7：API集成总结（25分钟）

### 7.1 三个实例对比

| 维度 | 实例7 OpenAI | 实例8 GLM-OCR | 实例9 GitHub |
|------|-------------|--------------|-------------|
| **触发方式** | Webhook（被动） | Webhook（被动） | Schedule（主动） |
| **HTTP 方法** | POST | POST | GET |
| **认证方式** | Bearer Token | Bearer Token | Token |
| **请求体** | JSON（messages） | JSON（image） | 无（Query 参数） |
| **核心节点** | Code + HTTP Request | HTTP Request + Code | HTTP Request + Code + Switch |
| **数据流向** | 接收 → 处理 → 返回 | 接收 → 识别 → 写文件 → 返回 | 定时获取 → 过滤 → 通知 |
| **模式分类** | 请求-响应 | 请求-转换-存储 | 定时-查询-推送 |

### 7.2 HTTP 方法速查

```
方法       用途              请求体    典型场景
─────────────────────────────────────────────────────────
GET       获取资源           无       查询数据、读取事件
POST      创建/提交          有       调用API、上传文件
PUT       全量更新           有       修改配置
PATCH     部分更新           有       更新单个字段
DELETE    删除资源           可选     删除记录
```

### 7.3 常见 API 响应模式

| 模式 | 结构 | 示例 |
|------|------|------|
| **直接数据** | `{ data: { ... } }` | GLM-OCR |
| **选项列表** | `{ choices: [{ message: { ... } }] }` | OpenAI Chat |
| **项目数组** | `[{ ... }, { ... }]` | GitHub Events |
| **分页列表** | `{ items: [], total: N, page: P }` | 多数列表 API |
| **错误响应** | `{ error: { code: "xxx", message: "..." } }` | 通用错误格式 |

### 7.4 API Key 安全要点

| 规则 | 说明 |
|------|------|
| **永远不要硬编码** | 使用 n8n 凭证系统存储 |
| **最小权限原则** | GitHub Token 只勾选需要的 scope |
| **定期轮换** | 建议每90天更换一次 |
| **环境隔离** | 开发和生产使用不同的 Key |
| **日志脱敏** | 不要在 console.log 中输出完整 Key |

### 7.5 工作流调试技巧

| 技巧 | 操作 |
|------|------|
| **单节点测试** | 点击节点 → Execute Step |
| **查看输出** | 点击节点 → Output 选项卡 |
| **Console 日志** | Code 节点中使用 `console.log()` |
| **Continue On Fail** | HTTP Request 设置中开启，失败不中断 |
| **手动触发** | 先用 Manual Trigger 替代 Schedule 调试 |

---

### 刻意练习——API 集成实战

**练习目标**：在不看教程的情况下，独立完成三种不同 API 的集成调用和错误处理

**任务序列（重复×3）：**

```
===== 循环 1：3 种 API 调用 =====
分别调用以下 3 种 REST API 并处理响应：
1. OpenWeather API（获取任意城市天气）
2. JSONPlaceholder API（获取 /users 列表）
3. GitHub API（获取任意仓库事件）
验证：三种 API 都返回了有效的 JSON 数据，你能提取出关键字段

===== 循环 2：3 种错误处理 =====
为同一个 API 调用依次添加：
1. Continue On Fail + IF 判断 HTTP 状态码
2. Code 节点中 Try-Catch 捕获异常
3. HTTP Request 节点的 Retry On Fail（最大 3 次）
验证：故意使用错误 URL，确认每种机制都能正确拦截并记录错误

===== 循环 3：多 API 集成工作流 =====
构建一个依赖多个 API 的完整工作流：
Webhook 接收城市名 → OpenWeather API 获取天气
→ Code 分析穿衣建议 → 推送到钉钉/Slack
验证：curl 测试返回了包含天气分析和建议的响应
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| REST API 调用与参数配置 | ⬜ | ⬜ | ⬜ |
| API 响应数据解析 | ⬜ | ⬜ | ⬜ |
| 错误处理（重试/回退） | ⬜ | ⬜ | ⬜ |
| 多 API 串联工作流 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：如果用户报告"我的 HTTP Request 节点返回 401 错误"，你会怎么一步步引导他排查问题？列出你的排查步骤。

---

## 🍅 番茄8：费曼综合检测（25分钟）

### 8.1 今日自检清单

- [ ] ✅ 实例7：OpenAI 智能助手工作流运行成功
- [ ] ✅ 实例8：GLM-OCR 文档转换工作流运行成功
- [ ] ✅ 实例9：GitHub 仓库监控工作流运行成功
- [ ] ✅ 理解 Bearer Token 和 Token 两种认证格式的区别
- [ ] ✅ 理解 GET（获取）和 POST（提交）的使用场景
- [ ] ✅ 能独立获取 OpenAI、智谱、GitHub 三种 API Key
- [ ] ✅ 能在 Code 节点中提取 API 响应中的目标字段
- [ ] ✅ 理解 Webhook（被动）和 Schedule（主动）两种触发模式

### 8.2 费曼综合检测题

**用自己的话回答，不要背定义：**

1. **向一个不懂技术的朋友解释**：API 是什么？为什么需要 API Key？
2. **场景题**：你要给团队搭建一个"每日AI新闻摘要"服务，每天8点自动获取 Hacker News 前10条，让 GPT 生成中文摘要，发到钉钉群。画出工作流架构图。
3. **排错题**：调用 OpenAI API 时返回 `401 Unauthorized`，可能的原因有哪些？逐一排查。
4. **设计题**：如果要在实例9的基础上增加"只在有紧急 Issue 时电话通知"功能，怎么实现？
5. **对比题**：Webhook 触发和 Schedule 触发各适合什么场景？各举2个例子。

### 8.3 费曼一句话总结

> **API 集成的核心就是三步：拿钥匙（凭证）、打电话（HTTP Request）、听回复（解析响应）。三种触发模式（Webhook/Schedule/Manual）决定了谁主动、谁被动，而 Code 节点负责把 API 的"方言"翻译成你的工作流能理解的"普通话"。**

### 8.4 学习笔记模板

```markdown
## Day 3 实例训练笔记

### 今天最大的收获
（用你自己的话写）

### 三个工作流的架构对比
| | 实例7 OpenAI | 实例8 GLM-OCR | 实例9 GitHub |
|---|---|---|---|
| 触发方式 | | | |
| HTTP方法 | | | |
| 认证格式 | | | |
| 核心逻辑 | | | |

### 还没搞懂的地方
（记录费曼检测中答不上来的问题）

### 想改造的变体
（记录你自己的扩展想法）

### 明天想深入的方向
（为 Day 4 做准备）
```

---

## 🎉 Day 3 完成！

**今日成果：**
- ✅ 实例7：OpenAI 智能助手 —— 掌握了 Bearer Token 认证 + Chat Completions API
- ✅ 实例8：GLM-OCR 文档转换 —— 掌握了 base64 图片编码 + Data URL 格式 + Obsidian Markdown 生成
- ✅ 实例9：GitHub 仓库监控 —— 掌握了 Token 认证 + 事件过滤 + Switch 分流 + 钉钉通知
- ✅ 理解了三种 API 认证格式（Bearer / Token / Header Auth）
- ✅ 理解了 Webhook（被动）和 Schedule（主动）两种触发模式
- ✅ 能独立获取和使用 OpenAI、智谱 GLM、GitHub 三种 API Key

**明天预告：** [[实例Day4-通知与通信]] - 多渠道通知中心、邮件自动分类、钉钉机器人

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[实例Day2-数据处理管道]] - 上一天
> - [[实例Day4-通知与通信]] - 下一天
> - [[Day3-凭证管理与API集成]] - 理论 Day 3
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - GLM-OCR 完整工作流参考
