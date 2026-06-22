# Day 6：AI Agent 工作流

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 n8n 的 AI 节点，构建智能工作流
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：n8n AI 生态全景 + AI Agent 节点深入理解
🍅 番茄3-4：AI + 工作流实战场景 + LangChain 集成
🍅 番茄5-6：MCP 集成 + 自由实践
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：n8n AI 生态全景（25分钟）

### 1.1 用大白话理解 AI Agent

AI Agent 就像一个「带工具箱的实习生」：

- **大脑** = 语言模型（GPT-4、Claude 等）——负责思考和决策
- **工具箱** = 工具节点（HTTP Request、Code、搜索等）——负责执行具体操作
- **笔记本** = 记忆节点（Window Buffer、Summary 等）——负责记住上下文
- **工作手册** = System Prompt——告诉实习生该怎么做、有什么规则

> 举例：你让实习生"帮我查一下明天北京的天气，如果下雨就提醒我带伞"
> 实习生会：① 找到天气查询工具 → ② 调用 API 获取数据 → ③ 分析是否下雨 → ④ 给出建议
> 这就是 AI Agent 的 ReAct 模式：**思考 → 行动 → 观察 → 再思考**

### 1.2 n8n AI 能力全景图

```
n8n AI 能力
├── 🤖 AI Agent 节点
│   ├── ReAct Agent（思考-行动-观察循环）
│   ├── Plan & Execute Agent（先规划再执行）
│   └── Conversational Agent（多轮对话型）
├── 🧠 语言模型节点
│   ├── OpenAI（GPT-4o / GPT-4o-mini）
│   ├── Anthropic（Claude 3.5 Sonnet / Haiku）
│   ├── Google（Gemini Pro）
│   └── Ollama（本地模型，免费私有）
├── 🔧 工具节点
│   ├── HTTP Request Tool（调用任意 API）
│   ├── Code Tool（执行自定义代码）
│   ├── SerpAPI（Google 搜索）
│   ├── Calculator（计算器）
│   └── 自定义工具（任何 n8n 节点都能当工具）
├── 💾 记忆节点
│   ├── Window Buffer Memory（保留最近 N 轮对话）
│   ├── Summary Memory（自动总结历史对话）
│   └── Zep Memory（外部记忆服务）
└── 🔗 LangChain 集成
    ├── LangChain 是 AI 应用开发框架
    ├── n8n 的 AI 节点底层基于 LangChain
    └── 可直接使用 LangChain 的组件
```

### 1.3 AI Agent 三种模式对比

| 模式 | 工作方式 | 适用场景 | 类比 |
|------|----------|----------|------|
| **ReAct** | 思考→行动→观察→再思考 | 需要多步推理+工具调用 | 实习生边想边做 |
| **Plan & Execute** | 先制定完整计划，再逐步执行 | 复杂多步骤任务 | 项目经理先做计划再分配 |
| **Conversational** | 多轮对话，保持上下文 | 聊天机器人、客服 | 有记忆的前台接待 |

> 💡 **新手建议**：从 ReAct Agent 开始，它最灵活，覆盖 90% 的使用场景。

### 1.4 为什么 AI Agent 比普通工作流更强？

| 对比维度 | 普通工作流 | AI Agent 工作流 |
|----------|-----------|----------------|
| 决策方式 | 预设规则（if/else） | AI 自主判断 |
| 灵活性 | 固定流程，输入变化容易出错 | 能理解自然语言，自适应 |
| 工具调用 | 手动连线 | AI 按需选择工具 |
| 错误处理 | 需要手动设计 | AI 能自行重试或换方案 |
| 适用场景 | 规则明确的重复任务 | 需要理解和判断的任务 |

> ✋ **费曼自测**：用你自己的话解释 AI Agent 和普通工作流的区别。为什么说 AI Agent 像一个"带工具箱的实习生"？

---

## 番茄钟2：AI Agent 节点深入理解（25分钟）

### 2.1 AI Agent 节点的四大组件

一个完整的 AI Agent 由四个部分组成，缺一不可：

```
┌─────────────────────────────────────────┐
│            AI Agent 节点                │
│                                         │
│  ┌───────────┐  ┌───────────────────┐  │
│  │  🧠 模型   │  │  🔧 工具（可多个）  │  │
│  │  (大脑)    │  │  (工具箱)          │  │
│  └───────────┘  └───────────────────┘  │
│                                         │
│  ┌───────────┐  ┌───────────────────┐  │
│  │  💾 记忆   │  │  📝 System Prompt │  │
│  │  (笔记本)  │  │  (工作手册)        │  │
│  └───────────┘  └───────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

### 2.2 配置 AI Agent 的完整步骤

**第一步：添加 AI Agent 节点**

1. 在画布上点击 `+`
2. 搜索 `AI Agent`
3. 选择 **AI Agent** 节点添加到画布

**第二步：选择 Agent 类型**

| 设置项 | 推荐选择 | 说明 |
|--------|----------|------|
| Agent Type | `ReAct Agent` | 通用型，思考-行动-观察循环 |

**第三步：连接语言模型**

1. 在 AI Agent 节点内，找到 **Language Model** 子节点
2. 点击 `+` 添加模型节点
3. 选择模型提供商（见下方对比表）

**AI 模型选择指南**：

| 模型 | 提供商 | 优点 | 缺点 | 适用场景 |
|------|--------|------|------|----------|
| **GPT-4o-mini** | OpenAI | 便宜、快速、效果好 | 中文偶有瑕疵 | 日常任务首选 |
| **GPT-4o** | OpenAI | 最强推理能力 | 贵（$2.5/1M token） | 复杂推理任务 |
| **Claude 3.5 Sonnet** | Anthropic | 长文本优秀、安全 | 需 Anthropic API | 长文档处理 |
| **Claude 3.5 Haiku** | Anthropic | 快速、便宜 | 推理稍弱 | 简单分类任务 |
| **Gemini Pro** | Google | 免费额度多 | 国内需代理 | 预算有限时 |
| **Qwen/Llama** | Ollama | 完全免费、本地运行 | 需要本地 GPU | 数据敏感场景 |

**第四步：添加工具**

1. 在 AI Agent 节点内，找到 **Tools** 区域
2. 点击 `+` 逐个添加工具节点

常用工具一览：

| 工具节点 | 功能 | 配置要点 |
|----------|------|----------|
| **HTTP Request Tool** | 调用任意 API | 设置 URL、Method、Headers |
| **Code Tool** | 执行 JS/Python 代码 | 写好代码逻辑，定义输入输出描述 |
| **SerpAPI** | Google 搜索 | 需要 SerpAPI Key |
| **Calculator** | 数学计算 | 无需配置 |
| **Wikipedia** | 查维基百科 | 无需配置，选语言 |

> 💡 **关键提示**：每个工具都需要写好 **Description（描述）**！AI 就是靠描述来决定什么时候用哪个工具。描述越清晰，Agent 越聪明。

**第五步：配置记忆**

| 记忆类型 | 配置方式 | 适用场景 |
|----------|----------|----------|
| **Window Buffer Memory** | 设置 Session ID + Session Key | 多轮对话，保留最近几轮 |
| **Summary Memory** | 设置 Session ID + 摘要模型 | 长对话，自动压缩历史 |

**第六步：设置 System Prompt**

System Prompt 是 Agent 的"行为准则"，格式建议：

```markdown
你是一个 [角色描述]。

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

### 2.3 API Key 获取指南

在配置 AI 之前，你需要先获取 API Key：

**OpenAI**：
1. 访问 [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. 注册/登录 OpenAI 账号
3. 点击 `Create new secret key`
4. 复制 Key（只显示一次，务必保存）
5. 在 n8n 中：Credentials → Add Credential → OpenAI API → 粘贴 Key

**Anthropic（Claude）**：
1. 访问 [console.anthropic.com](https://console.anthropic.com/)
2. 注册/登录账号
3. 进入 API Keys 页面 → `Create Key`
4. 复制 Key
5. 在 n8n 中：Credentials → Add Credential → Anthropic API → 粘贴 Key

**OpenRouter（推荐新手）**：
1. 访问 [openrouter.ai/keys](https://openrouter.ai/keys)
2. 注册/登录
3. 创建 API Key
4. **优势**：一个 Key 访问所有模型（GPT、Claude、Gemini、开源模型）
5. 在 n8n 中：使用 OpenAI 兼容模式，Base URL 设为 `https://openrouter.ai/api/v1`

**Ollama（完全免费本地运行）**：
1. 访问 [ollama.com](https://ollama.com/) 下载安装
2. 安装后运行命令拉取模型：
   ```bash
   ollama pull qwen2.5:7b      # 拉取通义千问 7B
   ollama pull llama3.1:8b     # 拉取 Llama 3.1 8B
   ```
3. 在 n8n 中：添加 Ollama 模型节点，Base URL 设为 `http://host.docker.internal:11434`（Docker 环境下）
4. **优势**：不需要 API Key，数据完全本地

### 2.4 在 n8n 中添加 AI 凭证

以 OpenAI 为例的完整流程：

1. 左侧边栏 → **Credentials** → **Add Credential**
2. 搜索 `OpenAI API`
3. 填写：
   - **API Key**：粘贴你的 Key
   - **Name**：`OpenAI GPT-4o`（方便识别）
4. 点击 **Save**
5. 回到 AI Agent 的模型子节点，选择刚创建的凭证

> ✋ **费曼自测**：不看上面的步骤，你能说出配置一个完整 AI Agent 需要哪四个组件？每个组件的作用是什么？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] AI Agent = 大脑（模型）+ 工具箱（工具）+ 笔记本（记忆）+ 工作手册（Prompt）
- [ ] ReAct Agent 是最通用的 Agent 类型
- [ ] 工具的 Description 决定了 AI 能否正确选择工具
- [ ] OpenRouter 可以用一个 Key 访问多个模型
- [ ] Ollama 可以完全本地运行 AI 模型

---

## 番茄钟3：AI + 工作流实战场景（25分钟）

### 3.1 场景一：智能邮件分类器

**用大白话理解**：你有一个助手，每次收到邮件就自动读一遍，判断是"工作邮件"还是"个人邮件"还是"垃圾邮件"，然后放到不同的文件夹。

**工作流设计**：

```
Gmail Trigger → AI Agent（分类）→ Switch（分流）→ Gmail Label / Slack / 忽略
```

**详细配置步骤**：

**第一步：添加 Gmail Trigger**

1. 添加 **Gmail Trigger** 节点
2. 配置 Gmail 凭证（OAuth2 授权）
3. 设置：
   - Poll Times: `Every Minute`
   - Label: `INBOX`（只收件箱的新邮件）

**第二步：配置 AI Agent**

1. 添加 **AI Agent** 节点
2. Agent Type: `ReAct Agent`
3. 添加 **OpenAI Model** 子节点：
   - Model: `gpt-4o-mini`
   - Temperature: `0.1`（分类任务需要确定性，温度要低）
4. System Prompt：
   ```markdown
   你是一个邮件分类助手。根据邮件内容，将邮件分为以下类别之一：
   
   - WORK：工作相关（项目、会议、任务、同事沟通）
   - PERSONAL：个人生活（家人、朋友、购物、订阅）
   - SPAM：垃圾邮件（广告、推广、诈骗）
   - URGENT：紧急邮件（截止日期、紧急通知、系统告警）
   
   只输出类别名称（WORK/PERSONAL/SPAM/URGENT），不要输出其他内容。
   ```
5. 输入映射（在 AI Agent 的输入中）：
   - 将 Gmail 的邮件内容传递给 Agent

**第三步：添加 Switch 节点**

1. 添加 **Switch** 节点
2. 配置路由规则：

| Output | Condition | 目标动作 |
|--------|-----------|----------|
| 0 (WORK) | `{{ $json.output }}` equals `WORK` | 添加工作标签 |
| 1 (PERSONAL) | `{{ $json.output }}` equals `PERSONAL` | 添加个人标签 |
| 2 (SPAM) | `{{ $json.output }}` equals `SPAM` | 移到垃圾箱 |
| 3 (URGENT) | `{{ $json.output }}` equals `URGENT` | 发 Slack 通知 |
| Fallback | 以上都不匹配 | 添加待处理标签 |

**第四步：添加各分支的处理节点**

- WORK 分支 → **Gmail** 节点（Add Label: Work）
- PERSONAL 分支 → **Gmail** 节点（Add Label: Personal）
- SPAM 分支 → **Gmail** 节点（Move to Trash）
- URGENT 分支 → **Slack** 节点（发送紧急通知）

### 3.2 场景二：AI 内容生成流水线

**用大白话理解**：你有一个写作团队——一个负责列大纲，一个负责写正文，一个负责润色修改。他们接力完成一篇文章。

**工作流设计**：

```
Webhook（接收主题）→ AI Agent 1（列大纲）→ AI Agent 2（写正文）→ AI Agent 3（润色）→ 写入文件
```

**详细配置步骤**：

**第一步：添加 Webhook Trigger**

1. 添加 **Webhook** 节点
2. HTTP Method: `POST`
3. Path: `generate-content`
4. Response Mode: `Last Node`

测试请求体：
```json
{
  "topic": "n8n AI Agent 入门指南",
  "style": "教程风格",
  "length": "1500字"
}
```

**第二步：AI Agent 1 - 大纲生成**

1. 添加 **AI Agent** 节点，命名为 `大纲生成`
2. Model: `gpt-4o-mini`，Temperature: `0.5`
3. System Prompt：
   ```markdown
   你是一个内容策划师。根据给定的主题，生成一篇文章大纲。
   
   要求：
   - 大纲包含 3-5 个主要章节
   - 每个章节包含 2-3 个子要点
   - 考虑文章的风格和目标长度
   - 使用 Markdown 格式输出
   ```
4. Input：将 Webhook 传来的 `topic`、`style`、`length` 传入

**第三步：AI Agent 2 - 正文撰写**

1. 添加 **AI Agent** 节点，命名为 `正文撰写`
2. Model: `gpt-4o-mini`，Temperature: `0.7`（写正文需要更多创意）
3. System Prompt：
   ```markdown
   你是一个专业写手。根据提供的大纲，撰写完整的文章正文。
   
   要求：
   - 严格按照大纲结构撰写
   - 语言流畅自然
   - 适当使用举例和类比
   - 每个章节字数均匀分配
   ```
4. Input：将大纲生成 Agent 的输出作为输入

**第四步：AI Agent 3 - 润色修改**

1. 添加 **AI Agent** 节点，命名为 `润色修改`
2. Model: `gpt-4o-mini`，Temperature: `0.3`（润色需要保守，不宜过度发挥）
3. System Prompt：
   ```markdown
   你是一个资深编辑。对文章进行润色修改。
   
   要求：
   - 修正语法错误和不通顺的表达
   - 优化段落过渡
   - 统一术语和风格
   - 不要改变文章的核心观点和结构
   - 输出最终版本
   ```
4. Input：将正文撰写 Agent 的输出作为输入

**第五步：写入文件**

1. 添加 **Write Binary File** 或 **HTTP Request** 节点
2. 将润色后的内容写入 Markdown 文件
3. 或者用 **Gmail** / **Slack** 发送给指定人

> ✋ **费曼自测**：在内容生成流水线中，为什么三个 AI Agent 的 Temperature 设置不同？如果都设成 0.9 会怎样？

---

## 番茄钟4：LangChain 集成与更多场景（25分钟）

### 4.1 用大白话理解 LangChain

LangChain 就像「AI 应用的乐高积木」：

- 普通开发者要从零搭建 AI 应用 → 困难
- LangChain 提供了标准化的积木块（模型、工具、记忆、链）→ 拼装即可
- n8n 的 AI 节点底层就是用 LangChain 构建的

### 4.2 n8n 中的 LangChain 集成

n8n 已经把 LangChain 的核心组件封装成了可视化节点：

| LangChain 概念 | n8n 节点 | 说明 |
|----------------|----------|------|
| ChatModel | OpenAI / Anthropic / Ollama 模型节点 | 对话模型 |
| Tool | HTTP Request Tool / Code Tool / SerpAPI | 工具 |
| Memory | Window Buffer / Summary Memory | 记忆 |
| Agent | AI Agent 节点 | Agent 编排 |
| Chain | 多个 AI Agent 节点串联 | 链式调用 |
| Output Parser | Code 节点辅助解析 | 结构化输出 |

### 4.3 场景三：AI 知识助手

**用大白话理解**：你有一个"万事通"助手，问它任何问题，它会先搜索相关信息，然后整理成结构化的答案给你。

**工作流设计**：

```
Webhook（接收问题）→ AI Agent（带搜索工具）→ Code（格式化）→ Write File / 返回结果
```

**详细配置步骤**：

**第一步：添加 Webhook Trigger**

1. 添加 **Webhook** 节点
2. HTTP Method: `POST`
3. Path: `ask-ai`
4. 测试请求体：
   ```json
   {
     "question": "什么是 MCP 协议？",
     "format": "markdown"
   }
   ```

**第二步：配置 AI Agent（带搜索工具）**

1. 添加 **AI Agent** 节点
2. Agent Type: `ReAct Agent`
3. 添加 **OpenAI Model** 子节点：
   - Model: `gpt-4o-mini`
   - Temperature: `0.3`
4. 添加 **SerpAPI Tool** 子节点：
   - Description: `当你需要搜索最新信息、查找事实、获取当前数据时使用此工具`
   - SerpAPI 凭证配置
5. System Prompt：
   ```markdown
   你是一个知识助手。用户会问你各种问题，你需要：
   
   1. 如果问题涉及最新信息或实时数据，使用搜索工具查找
   2. 如果是你的知识范围内的问题，直接回答
   3. 回答时要：
      - 结构清晰，使用标题和列表
      - 提供来源（如果是搜索结果）
      - 如果不确定，明确说明
   
   输出格式：Markdown
   ```

**第三步：Code 节点格式化**

1. 添加 **Code** 节点
2. 代码：
   ```javascript
   const answer = $input.item.json.output;
   const question = $('Webhook').item.json.body.question;
   
   return {
     json: {
       question: question,
       answer: answer,
       timestamp: new Date().toISOString(),
       wordCount: answer.length
     }
   };
   ```

**第四步：写入文件**

1. 添加 **Write Binary File** 节点
2. File Name: `/files/qa-{{ $now.toFormat('yyyy-MM-dd-HHmmss') }}.md`
3. 内容：将格式化后的结果写入

### 4.4 AI Agent 配置参数速查表

| 参数 | 推荐值 | 说明 |
|------|--------|------|
| **Temperature** | 分类: 0.1 / 写作: 0.7 / 润色: 0.3 | 越低越确定，越高越创意 |
| **Max Tokens** | 1000-4000 | 控制输出长度 |
| **Agent Type** | ReAct | 通用首选 |
| **Memory Session Key** | `={{ $json.userId }}` | 区分不同用户的对话 |
| **Memory Window Size** | 10 | 保留最近 10 轮对话 |

> ✋ **费曼自测**：在知识助手场景中，为什么 AI Agent 需要 SerpAPI 工具？如果去掉这个工具，Agent 会有什么局限？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 能说出 AI Agent 的四个核心组件
- [ ] 理解 Temperature 参数对输出的影响
- [ ] 至少完成一个实战场景的配置
- [ ] 理解 n8n AI 节点与 LangChain 的关系
- [ ] 知道如何为 AI Agent 添加工具和记忆

---

## 番茄钟5：MCP (Model Context Protocol) 集成（25分钟）

### 5.1 用大白话理解 MCP

MCP（Model Context Protocol）是 Anthropic 提出的一个开放协议，让 AI 能访问外部工具和数据。

**类比理解**：

```
没有 MCP 的 AI = 关在办公室里的实习生
  → 只能用脑子想，不能上网、不能打电话、不能翻文件

有了 MCP 的 AI = 装备齐全的实习生
  → 可以搜索网络（SerpAPI MCP Server）
  → 可以读写文件（Filesystem MCP Server）
  → 可以查数据库（Database MCP Server）
  → 可以调用各种 API（Custom MCP Server）
```

MCP 的核心概念：

```
MCP 架构
├── MCP Host（宿主）    → 运行 AI 的应用（如 n8n）
├── MCP Client（客户端） → Host 内部与 Server 通信的组件
└── MCP Server（服务端） → 提供具体能力的独立服务
    ├── Tools（工具）    → AI 可以调用的函数
    ├── Resources（资源）→ AI 可以读取的数据
    └── Prompts（提示）  → 预设的提示模板
```

### 5.2 n8n 中的 MCP 集成

n8n 从较新版本开始支持 MCP 集成，配置步骤如下：

**方式一：通过 MCP Tool 节点**

1. 在 AI Agent 的 Tools 区域，添加 **MCP Tool** 节点
2. 配置 MCP Server 连接信息：
   - **Transport Type**: `stdio` 或 `SSE`
   - **Command**: MCP Server 的启动命令
   - **Environment Variables**: 需要的环境变量

**方式二：通过 HTTP Request Tool 模拟**

如果 MCP Tool 节点不可用，可以用 HTTP Request Tool 手动对接 MCP Server：

1. 添加 **HTTP Request Tool** 节点
2. 配置：
   - Method: `POST`
   - URL: MCP Server 的 SSE 端点
   - Headers: 按需设置认证
3. Description 写清楚：`调用 MCP Server 的 XXX 功能`

### 5.3 常用 MCP Server 示例

| MCP Server | 功能 | 安装/启动命令 |
|------------|------|--------------|
| **Filesystem** | 读写本地文件 | `npx @modelcontextprotocol/server-filesystem /path/to/dir` |
| **SerpAPI** | Google 搜索 | `npx @modelcontextprotocol/server-serpapi` |
| **GitHub** | 操作 GitHub 仓库 | `npx @modelcontextprotocol/server-github` |
| **PostgreSQL** | 查询 PostgreSQL 数据库 | `npx @modelcontextprotocol/server-postgres` |
| **Slack** | 发送/读取 Slack 消息 | `npx @modelcontextprotocol/server-slack` |
| **Google Drive** | 读写 Google Drive 文件 | `npx @modelcontextprotocol/server-gdrive` |

### 5.4 配置 MCP Server 的实操步骤

以 Filesystem MCP Server 为例：

**第一步：确保 Node.js 环境**

```bash
node --version    # 需要 18+
npm --version
```

**第二步：在 n8n 中配置 MCP Tool**

1. 添加 AI Agent 节点
2. 在 Tools 区域添加 **MCP Tool** 节点
3. 配置：
   - Transport Type: `stdio`
   - Command: `npx`
   - Arguments: `@modelcontextprotocol/server-filesystem /files`
   - Environment Variables: （无需额外变量）

**第三步：测试 MCP 工具**

在 AI Agent 的 System Prompt 中加入：

```markdown
你可以使用文件系统工具来读写文件。当用户要求保存内容时，使用文件系统工具将内容写入文件。
```

然后通过 Webhook 发送测试请求：

```json
{
  "message": "请创建一个文件 hello.txt，内容是 Hello from MCP!"
}
```

AI Agent 会自动调用 MCP 的文件系统工具来创建文件。

### 5.5 MCP vs 传统工具节点

| 对比维度 | 传统工具节点 | MCP Server |
|----------|-------------|------------|
| 配置方式 | 每个工具单独配置 | 一个 Server 提供多个工具 |
| 可扩展性 | 需要等 n8n 更新 | 社区随时开发新 Server |
| 标准化 | n8n 自定义格式 | 统一协议，跨平台通用 |
| 调试 | n8n 界面内 | 需要查看 Server 日志 |
| 适用场景 | n8n 内置节点够用时 | 需要更多外部能力时 |

> ✋ **费曼自测**：用你自己的话解释 MCP 是什么。MCP Server 和 n8n 的工具节点有什么区别？

---

## 番茄钟6：自由实践——打造你自己的 AI Agent（25分钟）

### 6.1 练习1：AI 日程助手

创建一个 AI Agent，能根据自然语言描述创建日程：

```
Webhook → AI Agent（理解意图+提取信息）→ Google Calendar（创建事件）
```

**AI Agent 配置要点**：
- System Prompt：`你是一个日程助手。从用户的自然语言中提取事件名称、日期、时间、地点。输出 JSON 格式。`
- Temperature: `0.1`（提取信息需要精确）
- 输出格式要求：
  ```json
  {
    "title": "团队周会",
    "date": "2026-06-10",
    "time": "14:00",
    "duration": "60分钟",
    "location": "3号会议室"
  }
  ```

**测试用例**：
```json
{ "message": "下周三下午2点在3号会议室开团队周会，大概一个小时" }
```

### 6.2 练习2：AI 翻译管道

创建一个多语言翻译管道：

```
Webhook → AI Agent（检测语言）→ Switch → AI Agent（翻译为英文）→ AI Agent（翻译为日文）→ 汇总输出
```

**配置要点**：
- 第一个 Agent：检测输入语言，输出语言代码（zh/en/ja/...）
- Switch：根据语言代码路由到不同的翻译 Agent
- 翻译 Agent：System Prompt 中指定目标语言和翻译风格

### 6.3 练习3（挑战）：带记忆的 AI 客服

创建一个有记忆的 AI 客服，能记住之前的对话：

```
Chat Trigger → AI Agent（带 Window Buffer Memory）→ 输出
```

**配置要点**：
1. 添加 **Chat Trigger** 节点（n8n 内置的对话界面）
2. AI Agent 配置：
   - Agent Type: `Conversational Agent`
   - Memory: `Window Buffer Memory`
     - Session ID: `={{ $json.sessionId }}`
     - Window Size: `10`
3. System Prompt：
   ```markdown
   你是一个友好的客服助手。帮助用户解决产品使用问题。
   
   ## 常见问题
   - 如何重置密码？→ 点击登录页面的"忘记密码"
   - 如何升级套餐？→ 进入设置→订阅管理→选择新套餐
   - 如何联系人工客服？→ 转接关键词：人工、投诉、退款
   
   ## 规则
   - 友好耐心
   - 不确定时诚实回答
   - 需要人工介入时明确提示
   ```

**测试步骤**：
1. 先问："你好，我忘记密码了" → 检查回复
2. 再问："还有什么方法吗？" → 检查是否记住了上下文（密码问题）
3. 最后问："我要投诉" → 检查是否提示转人工

> ✋ **费曼自测**：不看教程，你能从零配置一个带记忆的 AI Agent 吗？记忆节点的 Session ID 有什么作用？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 理解 MCP 是什么，为什么需要它
- [ ] 知道如何在 n8n 中配置 MCP Server
- [ ] 至少完成一个自由实践练习
- [ ] 理解记忆节点 Session ID 的作用
- [ ] 能独立配置一个完整的 AI Agent 工作流

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| AI Agent | 有大脑、工具、记忆的智能节点 | 带工具箱的实习生 |
| ReAct Agent | 思考→行动→观察循环 | 边想边做的实习生 |
| Language Model | Agent 的大脑 | 实习生的脑力 |
| Tool | Agent 可以调用的能力 | 实习生的工具箱 |
| Memory | Agent 的上下文记忆 | 实习生的笔记本 |
| System Prompt | Agent 的行为准则 | 实习生的工作手册 |
| Temperature | 控制输出随机性 | 实习生发挥创意的程度 |
| MCP | AI 访问外部工具/数据的协议 | 实习生的对外联络通道 |
| MCP Server | 提供具体能力的外部服务 | 实习生可以拨打的专线电话 |
| LangChain | AI 应用开发框架 | AI 应用的乐高积木 |

### 7.2 AI 模型对比表

| 模型 | 提供商 | 价格（输入/输出 per 1M token） | 中文能力 | 推荐用途 |
|------|--------|------|----------|----------|
| GPT-4o-mini | OpenAI | $0.15 / $0.60 | 良好 | 日常任务首选 |
| GPT-4o | OpenAI | $2.50 / $10.00 | 优秀 | 复杂推理 |
| Claude 3.5 Sonnet | Anthropic | $3.00 / $15.00 | 优秀 | 长文本/安全场景 |
| Claude 3.5 Haiku | Anthropic | $0.80 / $4.00 | 良好 | 快速分类 |
| Qwen2.5 (Ollama) | 本地 | 免费 | 优秀 | 数据敏感/离线 |
| Llama3.1 (Ollama) | 本地 | 免费 | 一般 | 英文场景/测试 |

### 7.3 AI Agent 配置参考卡

```
AI Agent 配置清单
━━━━━━━━━━━━━━━━━━━━━━━━━━━
☐ 1. 选择 Agent 类型
    └→ ReAct（通用）/ Conversational（对话）

☐ 2. 连接语言模型
    └→ 选模型 → 配凭证 → 设 Temperature

☐ 3. 添加工具（至少一个）
    └→ HTTP Request Tool / Code Tool / SerpAPI
    └→ 关键：写好每个工具的 Description！

☐ 4. 配置记忆（可选）
    └→ Window Buffer / Summary Memory
    └→ 设 Session ID 区分对话

☐ 5. 写 System Prompt
    └→ 角色描述 + 职责 + 规则 + 输出格式

☐ 6. 测试与调试
    └→ 简单输入 → 检查工具调用 → 检查输出
    └→ 逐步增加复杂度
━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 7.4 Temperature 选择参考

```
Temperature 值选择指南

0.0 ──── 0.2 ──── 0.5 ──── 0.8 ──── 1.0
 │         │         │         │         │
精确       保守       平衡       创意       随机
分类       提取       对话       写作       头脑风暴
翻译       润色       建议       故事       创意
JSON输出   摘要       问答       脚本       实验
```

> ✋ **费曼自测**：把上面的表格遮住，你能回忆出每个概念的一句话解释吗？AI Agent 的四个核心组件分别是什么？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——AI 节点配置与模型对比

**练习目标**：在25分钟内完成3轮 AI Agent 配置循环，深入理解模型和工具的使用差异

**任务序列（重复×3）：**

```
===== 循环 1：用3种不同模型配置 AI 节点 =====
1. 创建一个 AI Agent，配置 OpenAI（GPT-4o-mini）模型
2. 复制工作流，将模型改为 Anthropic（Claude 3.5 Haiku）
3. 再复制一份，配置 OpenRouter 接入其他模型
4. 用同一 Prompt 测试三个模型的输出
验证：三个模型都能正常运行，输出结果各具特色

===== 循环 2：测试同一提示词在不同模型下的输出差异 =====
1. 准备一个固定提示词："请用一句话解释什么是 AI Agent"
2. 分别用 GPT-4o-mini 和 Claude 3.5 Haiku 运行
3. 设置 Temperature 分别设为 0.1、0.5、0.9 各运行一次
4. 对比不同模型和不同 Temperature 下的输出差异
验证：Temperature 越低输出越稳定，越高输出越多样；不同模型风格不同

===== 循环 3：构建 AI + 工具调用的完整 Agent 工作流 =====
1. 从零创建新工作流
2. 结构：Webhook → AI Agent（带 HTTP Request Tool）→ Code（格式化）→ Respond to Webhook
3. AI Agent 配置 ReAct 模式，System Prompt 明确工具使用规则
4. 工具 Description 写清楚何时使用该工具
5. 用 curl 发送需要调用工具的复杂查询
验证：AI Agent 能根据查询内容自动判断是否需要调用工具，并正确使用工具获取信息
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 多模型配置与切换 | ⬜ | ⬜ | ⬜ |
| Temperature 参数调优 | ⬜ | ⬜ | ⬜ |
| Agent + 工具调用工作流 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：GPT-4o-mini 和 Claude 3.5 Haiku 在回答同一问题时风格有何不同？Temperature 从 0.1 调到 0.9 发生了什么变化？

### 8.1 今日自检清单

完成以下所有项才算通过 Day 6：

- [ ] ✅ 能说出 AI Agent 的四个核心组件及其作用
- [ ] ✅ 能解释 ReAct Agent 的工作流程
- [ ] ✅ 至少配置了一个 AI 模型凭证（OpenAI / OpenRouter / Ollama）
- [ ] ✅ 完成了智能邮件分类器或内容生成流水线的配置
- [ ] ✅ 理解 Temperature 参数对输出的影响
- [ ] ✅ 知道如何为 AI Agent 添加工具和记忆
- [ ] ✅ 能解释 MCP 是什么及其作用
- [ ] ✅ 至少完成了一个自由实践练习

### 8.2 费曼一句话总结

> **AI Agent 是 n8n 中最强大的节点类型，它由大脑（语言模型）、工具箱（工具节点）、笔记本（记忆节点）和工作手册（System Prompt）四部分组成。AI Agent 能像实习生一样自主思考和行动，根据任务需要选择合适的工具，完成普通工作流无法处理的智能任务。MCP 协议则进一步扩展了 AI 访问外部世界的能力。**

### 8.3 学习笔记

```markdown
## Day 6 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 明天想深入的方向
（为 Day 7 做准备）
```

---

## 🎉 Day 6 完成！

**今日成果：**
- ✅ 理解了 n8n AI 生态全景
- ✅ 掌握了 AI Agent 节点的配置方法
- ✅ 完成了 3 个实战场景（邮件分类/内容生成/知识助手）
- ✅ 了解了 MCP 协议及其集成方式
- ✅ 完成了自由实践练习

**明天预告：** [[Day7-复习与综合实战]] - 7 天知识大盘点 + 构建 Obsidian 智能知识管理系统

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day5-Webhook与外部集成]] - 上一天
> - [[Day7-复习与综合实战]] - 下一天
