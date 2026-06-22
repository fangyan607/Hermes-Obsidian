# Day 7：复习与综合实战

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：将6天所学整合为一个完整的 Obsidian 智能知识管理系统
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：Day 1-6 综合复习 + 系统架构设计
🍅 番茄3-4：构建工作流1（RSS→AI摘要→Obsidian）+ 工作流2（邮件→AI分类→多通道通知）
🍅 番茄5-6：构建工作流3（Webhook知识API）+ 子工作流模块化
🍅 番茄7-8：终极费曼测试 + 学习路线图展望
```

---

## 番茄钟1：Day 1-6 综合复习（25分钟）

### 1.1 用大白话理解今天做什么

过去6天，我们学了做菜的各种基本功——刀工、火候、调味、摆盘。今天是**办一桌席**：把所有基本功串起来，做一整套完整的菜。

单独一个工作流是一条「流水线」，但真正的知识管理需要**多条流水线协同工作**——这就是今天的核心任务：设计一个 Obsidian 智能知识管理系统，让信息从采集、处理到归档全自动运转。

### 1.2 Day 1-6 复习总结表

| 天数 | 主题 | 核心概念 | 关键技能 |
|:---:|------|----------|----------|
| Day 1 | 安装部署与界面初探 | n8n 架构、Docker 部署、Item 数据结构 | Docker Compose 启动、画布操作、第一个工作流 |
| Day 2 | 核心节点与触发器 | 5种触发器、8大核心节点 | Manual/Schedule/Webhook Trigger、IF/Switch/Split/Code/Set/Merge 节点 |
| Day 3 | 凭证管理与API集成 | Credential 凭证系统、HTTP Request | API Key 配置、REST API 调用、天气/新闻/AI 工作流 |
| Day 4 | 数据处理与工作流模式 | 批量处理、循环、错误处理 | Split In Batches、Error Trigger、Error Workflow、重试机制 |
| Day 5 | Webhook与外部集成 | Webhook API 服务、响应模式 | Webhook 生产 URL、GET/POST 处理、curl 测试、OAuth |
| Day 6 | AI Agent工作流 | AI Agent、MCP 工具、Prompt 工程 | AI Agent 节点配置、自定义工具、RAG 检索增强 |

### 1.3 核心概念全景速查卡

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| 工作流 (Workflow) | 一系列节点的有序组合 | 一条产线 |
| 节点 (Node) | 执行一个操作的单元 | 一台机器 |
| 触发器 (Trigger) | 启动工作流的入口 | 门铃 / 开关 |
| Item | 数据的基本单位 | 传送带上的包裹 |
| 表达式 (Expression) | `{{ }}` 包裹的动态值 | Excel 公式 |
| 凭证 (Credential) | API 密钥等认证信息 | 酒店房卡 |
| Webhook | 外部系统调用 n8n 的入口 | 前台收件箱 |
| AI Agent | 带工具的智能决策节点 | 有工具箱的AI助手 |
| IF/Switch | 条件分支路由 | 十字路口 |
| Error Workflow | 异常兜底处理 | 安全网 |
| Sub-workflow | 可复用的子流程 | 可替换的零件模块 |
| Split In Batches | 分批处理大量数据 | 分批上菜的传菜员 |

> ✋ **费曼自测**：遮住右侧两列，看着「概念」列，能否用自己的话解释每个概念并给出类比？

---

## 番茄钟2：系统架构设计（25分钟）

### 2.1 用大白话理解系统架构

一个好系统就像一栋楼：

- **输入层** = 大门和窗户（信息从哪里进来）
- **处理层** = 厨房和加工间（信息怎么被处理）
- **输出层** = 餐厅和快递（处理后的信息送到哪里）

每一层独立运作，层与层之间通过「标准接口」连接——这样某一层坏了，不会牵连其他层。

### 2.2 Obsidian 智能知识管理系统架构

```
📥 输入层（多来源采集）
├── Webhook (剪藏/手动提交)
├── Schedule (定时抓取 RSS)
└── App Trigger (Gmail新邮件)

⚙️ 处理层（智能分类+处理）
├── AI Agent (内容摘要+分类)
├── Code (格式转换+数据清洗)
├── IF/Switch (条件路由)
└── Error Handler (异常处理)

📤 输出层（多目标分发）
├── Write File (保存到 Obsidian Vault)
├── Slack/钉钉 (即时通知)
└── HTTP Request (同步到 Notion)
```

### 2.3 三大工作流分工

| 工作流 | 触发方式 | 核心功能 | 输出 |
|--------|----------|----------|------|
| Workflow 1 | Schedule (定时) | RSS 抓取 → AI 摘要 → 保存到 Obsidian | Clippings/ 文件夹下的 Markdown 笔记 |
| Workflow 2 | App Trigger (事件) | Gmail 新邮件 → AI 分类 → 多通道通知 | Slack/钉钉通知 + 邮件归档 |
| Workflow 3 | Webhook (API) | 接收查询 → AI 搜索回答 → 返回结果 | JSON 响应 + 保存到 Vault |

### 2.4 子工作流复用设计

```
公共子工作流
├── sub-format-obsidian  (格式化为 Obsidian Markdown)
├── sub-ai-classify      (AI 分类打标签)
└── sub-error-handler    (统一错误处理+通知)

主工作流通过 Execute Workflow 节点调用子工作流
→ 修改格式只需改一处，所有工作流自动生效
```

> ✋ **费曼自测**：不看上面的架构图，你能画出这个系统的三层架构吗？每一层有哪些组件？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] 能回忆 Day 1-6 每天的核心主题和关键技能
- [ ] 理解三层架构：输入层 → 处理层 → 输出层
- [ ] 明白子工作流复用的好处：改一处，处处生效
- [ ] 清楚今天要构建的三大工作流各自的职责

---

## 番茄钟3：构建工作流1 — RSS → AI 摘要 → Obsidian（25分钟）

### 3.1 用大白话理解这个工作流

想象你有一个「私人秘书」：
1. 每天早上自动去各大新闻站收报纸（Schedule + RSS）
2. 读完后给你写一份摘要卡片（AI Agent）
3. 把摘要卡片整理好放进你的档案柜（Code + Write File）

### 3.2 工作流全景图

```
Schedule Trigger → HTTP Request (RSS Feed) → XML → Code (解析RSS)
    → AI Agent (摘要+分类) → Code (Obsidian Markdown格式化)
    → Write File (保存到Vault)
```

### 3.3 节点配置详解

**① Schedule Trigger**

| 参数 | 值 |
|------|-----|
| Trigger Rule | Every Day |
| Hour | 8 |
| Minute | 0 |

含义：每天早上 8 点自动执行。

**② HTTP Request — 获取 RSS**

| 参数 | 值 |
|------|-----|
| Method | GET |
| URL | `https://hnrss.org/newest?points=100` |
| Response Format | String |

> 💡 也可以替换为你喜欢的任何 RSS 源，如 `https://feeds.feedburner.com/ruanyifeng`、`https://www.zhihu.com/rss` 等。

**③ Code — 解析 RSS XML**

```javascript
// 将 RSS XML 解析为结构化数据
const xml = $input.item.json.data;
const items = [];

// 简易 XML 解析（实际项目可用 xml2js 库）
const itemRegex = /<item>([\s\S]*?)<\/item>/g;
let match;

while ((match = itemRegex.exec(xml)) !== null) {
  const itemXml = match[1];

  const getTitle = (s) => {
    const m = s.match(/<title><!\[CDATA\[(.*?)\]\]><\/title>/) ||
             s.match(/<title>(.*?)<\/title>/);
    return m ? m[1] : '';
  };

  const getLink = (s) => {
    const m = s.match(/<link>(.*?)<\/link>/);
    return m ? m[1] : '';
  };

  const getDesc = (s) => {
    const m = s.match(/<description><!\[CDATA\[(.*?)\]\]><\/description>/) ||
             s.match(/<description>(.*?)<\/description>/);
    return m ? m[1] : '';
  };

  const getPubDate = (s) => {
    const m = s.match(/<pubDate>(.*?)<\/pubDate>/);
    return m ? m[1] : '';
  };

  items.push({
    json: {
      title: getTitle(itemXml),
      link: getLink(itemXml),
      description: getDesc(itemXml).substring(0, 500), // 截取前500字
      pubDate: getPubDate(itemXml)
    }
  });
}

// 只取前5条，避免 API 调用过多
return items.slice(0, 5);
```

**④ AI Agent — 摘要与分类**

| 参数 | 值 |
|------|-----|
| Agent Type | Conversational Agent |
| Text | `={{ $json.title }}\n\n{{ $json.description }}` |
| System Message | 见下方 |

System Message：
```
你是一个内容摘要与分类助手。对于用户给你的每篇文章，你需要：

1. 用中文写一段 50-100 字的摘要
2. 从以下分类中选择一个：技术、设计、商业、科学、文化、其他
3. 给出 3 个标签关键词

请严格按以下 JSON 格式输出，不要输出任何其他内容：
{
  "summary": "摘要内容",
  "category": "分类",
  "tags": ["标签1", "标签2", "标签3"]
}
```

**⑤ Code — Obsidian Markdown 格式化**

这是最关键的节点——把 AI 的输出转为 Obsidian 可用的 Markdown 文件：

```javascript
const aiOutput = JSON.parse($input.item.json.output);
const originalItem = $('Code').item.json; // 引用上游 Code 节点的数据

const title = originalItem.title.replace(/[\\/:*?"<>|]/g, '_'); // 清理文件名非法字符
const date = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
const time = new Date().toTimeString().split(' ')[0]; // HH:MM:SS

// 生成 Frontmatter
const frontmatter = `---
title: "${originalItem.title}"
source: "${originalItem.link}"
category: "${aiOutput.category}"
tags:
${aiOutput.tags.map(t => `  - ${t}`).join('\n')}
date: "${date} ${time}"
type: "clipping"
status: "unread"
---`;

// 生成完整 Markdown 内容
const markdown = `${frontmatter}

## 摘要

${aiOutput.summary}

## 原文内容

${originalItem.description}

---

> 🔗 原文链接: [${originalItem.title}](${originalItem.link})
> 📅 采集时间: ${date} ${time}
> 🏷️ 分类: ${aiOutput.category} | 标签: ${aiOutput.tags.join(', ')}
`;

return {
  json: {
    fileName: `${date}-${title.substring(0, 50)}.md`,
    content: markdown,
    category: aiOutput.category,
    tags: aiOutput.tags
  }
};
```

**⑥ Write File — 保存到 Obsidian Vault**

| 参数 | 值 |
|------|-----|
| File Name | `=/files/ObsidianVault/ideal/Clippings/{{ $json.fileName }}` |
| Content | `={{ $json.content }}` |
| Append | false |

> 💡 路径 `/files/` 映射到 `docker-compose.yml` 中配置的 `./local-files:/files`，需要确保该目录存在且有写入权限。

### 3.4 文件命名规范

```
Clippings/
├── 2026-06-08-GPT-5发布引发行业震动.md
├── 2026-06-08-Rust2.0正式版发布.md
└── 2026-06-08-深度学习在药物研发中的应用.md
```

命名规则：`{日期}-{标题前50字}.md`，避免特殊字符。

### 3.5 生成的 Markdown 示例

```markdown
---
title: "GPT-5发布引发行业震动"
source: "https://example.com/gpt5-release"
category: "技术"
tags:
  - GPT-5
  - AI
  - 大模型
date: "2026-06-08 08:15:30"
type: "clipping"
status: "unread"
---

## 摘要

OpenAI正式发布GPT-5模型，在多模态推理和长文本理解方面取得重大突破，参数量达到万亿级别，同时推理成本降低80%。

## 原文内容

OpenAI today announced GPT-5...

---

> 🔗 原文链接: [GPT-5发布引发行业震动](https://example.com/gpt5-release)
> 📅 采集时间: 2026-06-08 08:15:30
> 🏷️ 分类: 技术 | 标签: GPT-5, AI, 大模型
```

> ✋ **费曼自测**：不看上面的步骤，你能说出 RSS → Obsidian 工作流包含哪些节点吗？每个节点的作用是什么？

---

## 番茄钟4：构建工作流2 — Email → AI 分类 → 多通道通知（25分钟）

### 4.1 用大白话理解这个工作流

想象你有一个「邮件管家」：
1. 每封新邮件进来就自动拆开看（Gmail Trigger）
2. AI 助手读完告诉你：这是商务合作/技术问题/垃圾邮件（AI Agent 分类）
3. 根据类别走不同通道通知你——重要的发 Slack，一般发钉钉，垃圾直接归档（Switch + 多输出）

### 4.2 工作流全景图

```
Gmail Trigger → AI Agent (邮件分类) → Switch (按类别路由)
    ├── 商务合作 → Slack (即时通知) + Write File (保存到Vault)
    ├── 技术问题 → 钉钉 (通知) + HTTP Request (创建GitHub Issue)
    ├── 通知/订阅 → Set (标记低优先级)
    └── 垃圾邮件 → Gmail (移动到垃圾箱)
```

### 4.3 节点配置详解

**① Gmail Trigger**

| 参数 | 值 |
|------|-----|
| Label | INBOX |
| Poll Times | Every Minute |

> 💡 需要先在 Credentials 中配置 Gmail OAuth 凭证。

**② Code — 提取邮件核心信息**

```javascript
const email = $input.item.json;

return {
  json: {
    subject: email.subject || '(无主题)',
    from: email.from?.[0]?.address || 'unknown',
    fromName: email.from?.[0]?.name || '',
    body: (email.text || email.snippet || '').substring(0, 1000),
    date: email.date,
    threadId: email.threadId
  }
};
```

**③ AI Agent — 邮件分类**

System Message：
```
你是一个邮件分类助手。根据邮件的主题和内容，将邮件分为以下类别之一：

- **business**: 商务合作、客户沟通、商务邀请
- **technical**: 技术问题、Bug报告、技术讨论
- **notification**: 通知、订阅、系统邮件、营销邮件
- **spam**: 垃圾邮件、广告、钓鱼邮件

请严格按以下 JSON 格式输出：
{
  "category": "类别",
  "priority": "high/medium/low",
  "reason": "分类理由（一句话）",
  "suggestedAction": "建议操作"
}
```

Text：
```
={{ $json.subject }}

发件人: {{ $json.fromName }} <{{ $json.from }}>

{{ $json.body }}
```

**④ Switch — 按类别路由**

| 输出 | 条件 | 目标节点 |
|------|------|----------|
| Output 0 | `{{ $json.category }}` equals `business` | Slack 通知 + 保存 |
| Output 1 | `{{ $json.category }}` equals `technical` | 钉钉通知 + GitHub Issue |
| Output 2 | `{{ $json.category }}` equals `notification` | 低优先级标记 |
| Output 3 | `{{ $json.category }}` equals `spam` | 移动到垃圾箱 |

**⑤ Slack — 商务邮件通知**

| 参数 | 值 |
|------|-----|
| Channel | `#business` |
| Text | 见下方 |

```
📧 *新商务邮件*

*主题:* {{ $('Code').item.json.subject }}
*发件人:* {{ $('Code').item.json.fromName }} ({{ $('Code').item.json.from }})
*优先级:* {{ $json.priority }}
*分类理由:* {{ $json.reason }}
*建议操作:* {{ $json.suggestedAction }}

⚡ 请尽快处理！
```

**⑥ Code — 生成 Obsidian 商务邮件笔记**

```javascript
const email = $('Code').item.json;
const classify = $input.item.json;
const date = new Date().toISOString().split('T')[0];

const frontmatter = `---
title: "商务邮件: ${email.subject}"
from: "${email.fromName} <${email.from}>"
category: "${classify.category}"
priority: "${classify.priority}"
date: "${date}"
type: "email"
status: "pending"
---`;

const content = `${frontmatter}

## 邮件信息

- **发件人**: ${email.fromName} <${email.from}>
- **主题**: ${email.subject}
- **日期**: ${email.date}
- **优先级**: ${classify.priority}

## 邮件内容

${email.body}

## AI 分析

- **分类**: ${classify.category}
- **理由**: ${classify.reason}
- **建议操作**: ${classify.suggestedAction}

---

> 📧 邮件自动归档 | 分类: ${classify.category} | 优先级: ${classify.priority}
`;

return {
  json: {
    fileName: `${date}-商务-${email.subject.replace(/[\\/:*?"<>|]/g, '_').substring(0, 40)}.md`,
    content: content
  }
};
```

**⑦ HTTP Request — 创建 GitHub Issue（技术邮件）**

| 参数 | 值 |
|------|-----|
| Method | POST |
| URL | `https://api.github.com/repos/{owner}/{repo}/issues` |
| Authentication | GitHub Credential |
| Body (JSON) | 见下方 |

```json
{
  "title": "={{ $('Code').item.json.subject }}",
  "body": "={{ $('Code').item.json.body }}\n\n---\n*Auto-created from email by n8n*\n*From: {{ $('Code').item.json.from }}*\n*AI Category: {{ $json.category }}*",
  "labels": ["automated", "={{ $json.category }}"]
}
```

> ✋ **费曼自测**：如果一封邮件被 AI 分类为 `business`，它经过了哪些节点？每个节点对它做了什么？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] Workflow 1 (RSS → Obsidian) 节点配置完成
- [ ] 理解 Code 节点如何生成 Obsidian Markdown 格式
- [ ] Workflow 2 (Email → 多通道) Switch 路由逻辑清晰
- [ ] 能解释 Frontmatter 中每个字段的用途

---

## 番茄钟5：构建工作流3 — Webhook 知识 API（25分钟）

### 5.1 用大白话理解这个工作流

想象你有一个「知识问答窗口」：
1. 别人（或你自己）发一个查询到这个窗口（Webhook 接收）
2. AI 助手搜索知识库并回答问题（AI Agent + RAG）
3. 回答的同时自动存档到你的 Obsidian（Write File）
4. 把答案返回给查询者（Respond to Webhook）

### 5.2 工作流全景图

```
Webhook (接收查询) → Code (参数校验) → AI Agent (知识检索+回答)
    → Code (格式化保存) → Write File (存档到Vault)
    → Code (构建响应) → Respond to Webhook (返回结果)
```

### 5.3 节点配置详解

**① Webhook**

| 参数 | 值 |
|------|-----|
| HTTP Method | POST |
| Path | `knowledge-query` |
| Response Mode | Using 'Respond to Webhook' Node |

> 这样 Webhook 不会立即返回，而是等处理完后由 Respond to Webhook 返回结果。

**② Code — 参数校验**

```javascript
const body = $input.item.json.body || {};

// 校验必填字段
if (!body.query || typeof body.query !== 'string') {
  throw new Error('Missing required field: query (string)');
}

if (body.query.length > 500) {
  throw new Error('Query too long. Maximum 500 characters.');
}

return {
  json: {
    query: body.query.trim(),
    source: body.source || 'api',
    timestamp: new Date().toISOString()
  }
};
```

**③ AI Agent — 知识检索与回答**

System Message：
```
你是一个知识管理助手。用户会向你提问，你需要：

1. 根据你的知识给出详细、准确的回答
2. 如果不确定，明确说明
3. 在回答末尾列出 3-5 个相关关键词
4. 用中文回答

回答格式：
## 回答

（你的详细回答）

## 相关关键词
- 关键词1
- 关键词2
- 关键词3
```

Text：
```
={{ $json.query }}
```

**④ Code — 格式化保存到 Obsidian**

```javascript
const query = $('Code').item.json.query; // 原始查询
const answer = $input.item.json.output;   // AI 回答
const date = new Date().toISOString().split('T')[0];
const time = new Date().toTimeString().split(' ')[0];

// 从回答中提取关键词
const keywordMatch = answer.match(/## 相关关键词\n([\s\S]*?)$/);
const tags = keywordMatch
  ? keywordMatch[1].match(/[-*]\s+(.+)/g)?.map(t => t.replace(/^[-*]\s+/, '').trim()) || []
  : ['知识查询'];

const frontmatter = `---
title: "知识查询: ${query.substring(0, 50)}"
type: "knowledge-query"
tags:
${tags.map(t => `  - ${t}`).join('\n')}
date: "${date} ${time}"
source: "${$('Code').item.json.source}"
---`;

const content = `${frontmatter}

## 问题

${query}

${answer}

---

> 🔍 查询时间: ${date} ${time}
> 📡 来源: ${$('Code').item.json.source}
`;

return {
  json: {
    fileName: `${date}-查询-${query.substring(0, 30).replace(/[\\/:*?"<>|\s]/g, '_')}.md`,
    content: content,
    answer: answer,
    query: query,
    tags: tags
  }
};
```

**⑤ Write File — 保存到 Vault**

| 参数 | 值 |
|------|-----|
| File Name | `=/files/ObsidianVault/ideal/Clippings/{{ $json.fileName }}` |
| Content | `={{ $json.content }}` |
| Append | false |

**⑥ Code — 构建响应**

```javascript
return {
  json: {
    status: 'success',
    query: $input.item.json.query,
    answer: $input.item.json.answer,
    tags: $input.item.json.tags,
    savedTo: `Clippings/${$input.item.json.fileName}`,
    timestamp: new Date().toISOString()
  }
};
```

**⑦ Respond to Webhook**

| 参数 | 值 |
|------|-----|
| Respond With | JSON |
| Response Body | `={{ JSON.stringify($json) }}` |
| Status Code | 200 |

### 5.4 用 curl 测试

```bash
curl -X POST http://localhost:5678/webhook/knowledge-query \
  -H "Content-Type: application/json" \
  -d '{
    "query": "n8n 中 AI Agent 和普通的 HTTP Request 调用 AI API 有什么区别？",
    "source": "curl-test"
  }'
```

预期响应：
```json
{
  "status": "success",
  "query": "n8n 中 AI Agent 和普通的 HTTP Request 调用 AI API 有什么区别？",
  "answer": "## 回答\n\nAI Agent 和 HTTP Request 调用 AI API 的核心区别在于...",
  "tags": ["AI Agent", "n8n", "工作流", "API"],
  "savedTo": "Clippings/2026-06-08-查询-n8n中AIAgent和普通.md",
  "timestamp": "2026-06-08T08:30:00.000Z"
}
```

> ✋ **费曼自测**：如果 Webhook 收到一个没有 `query` 字段的请求，会发生什么？为什么我们需要参数校验节点？

---

## 番茄钟6：子工作流模块化（25分钟）

### 6.1 用大白话理解子工作流

子工作流就像「可替换的零件」：

- 你的车换轮胎，不需要重新造一辆车
- 你修改 Markdown 格式，不需要改每个工作流的 Code 节点
- 只需要改「格式化子工作流」，所有调用它的工作流自动生效

### 6.2 为什么要模块化？

| 问题 | 不用子工作流 | 用子工作流 |
|------|-------------|-----------|
| 修改 Markdown 格式 | 改 3 个工作流中的 Code 节点 | 改 1 个子工作流 |
| 添加新的通知渠道 | 每个工作流分别加 | 改通知子工作流即可 |
| 错误处理逻辑变更 | 每个工作流分别改 | 改错误处理子工作流 |
| 调试格式化问题 | 不知道是哪个工作流的问题 | 直接去子工作流调试 |

### 6.3 创建子工作流1：sub-format-obsidian

**新建一个工作流**，命名为 `sub-format-obsidian`：

```
Manual Trigger → Code (接收参数+格式化)
```

Code 节点：
```javascript
// 接收来自父工作流的参数
const title = $input.item.json.title || '未命名';
const content = $input.item.json.content || '';
const category = $input.item.json.category || '其他';
const tags = $input.item.json.tags || ['未分类'];
const source = $input.item.json.source || '';
const type = $input.item.json.type || 'clipping';

const date = new Date().toISOString().split('T')[0];
const time = new Date().toTimeString().split(' ')[0];

// 清理文件名非法字符
const safeTitle = title.replace(/[\\/:*?"<>|]/g, '_').substring(0, 50);

// 生成 Frontmatter
const frontmatter = `---
title: "${title}"
source: "${source}"
category: "${category}"
tags:
${tags.map(t => `  - ${t}`).join('\n')}
date: "${date} ${time}"
type: "${type}"
status: "unread"
---`;

// 生成完整 Markdown
const markdown = `${frontmatter}

## 内容

${content}

---

> 🔗 来源: ${source}
> 📅 创建时间: ${date} ${time}
> 🏷️ 分类: ${category} | 标签: ${tags.join(', ')}
`;

return {
  json: {
    fileName: `${date}-${safeTitle}.md`,
    content: markdown,
    category: category,
    tags: tags
  }
};
```

### 6.4 创建子工作流2：sub-ai-classify

**新建一个工作流**，命名为 `sub-ai-classify`：

```
Manual Trigger → AI Agent (分类) → Code (解析输出)
```

AI Agent 的 System Message：
```
你是一个内容分类助手。根据用户提供的内容，进行分类和打标签。

可选分类：技术、设计、商业、科学、文化、生活、其他

请严格按以下 JSON 格式输出：
{
  "category": "分类",
  "tags": ["标签1", "标签2", "标签3"],
  "priority": "high/medium/low",
  "summary": "一句话摘要"
}
```

Code 节点（解析 AI 输出）：
```javascript
try {
  const aiOutput = JSON.parse($input.item.json.output);
  return {
    json: {
      category: aiOutput.category || '其他',
      tags: aiOutput.tags || ['未分类'],
      priority: aiOutput.priority || 'medium',
      summary: aiOutput.summary || ''
    }
  };
} catch (e) {
  // AI 输出解析失败时的兜底
  return {
    json: {
      category: '其他',
      tags: ['未分类'],
      priority: 'low',
      summary: 'AI 分类失败，请手动处理',
      error: e.message
    }
  };
}
```

### 6.5 创建子工作流3：sub-error-handler

**新建一个工作流**，命名为 `sub-error-handler`：

```
Manual Trigger → Code (格式化错误信息) → Slack (发送通知)
```

Code 节点：
```javascript
const error = $input.item.json;

return {
  json: {
    workflowName: error.workflow?.name || '未知工作流',
    nodeName: error.execution?.error?.node?.name || '未知节点',
    errorMessage: error.execution?.error?.message || '未知错误',
    executionId: error.execution?.id || '',
    timestamp: new Date().toISOString(),
    severity: error.severity || 'error'
  }
};
```

Slack 通知：
```
🚨 *n8n 工作流错误*

*工作流*: {{ $json.workflowName }}
*错误节点*: {{ $json.nodeName }}
*错误信息*: {{ $json.errorMessage }}
*执行ID*: {{ $json.executionId }}
*时间*: {{ $json.timestamp }}

请尽快检查！
```

### 6.6 在主工作流中调用子工作流

使用 **Execute Workflow** 节点：

| 参数 | 值 |
|------|-----|
| Source | Database |
| Workflow ID | 选择 `sub-format-obsidian` |
| Mode | Wait for Sub-Workflow to Finish |

传入参数的方式——在 Execute Workflow 节点前加一个 Set 节点：

```javascript
// Set 节点中准备传给子工作流的参数
{
  "title": "={{ $json.title }}",
  "content": "={{ $json.content }}",
  "category": "={{ $json.category }}",
  "tags": "={{ $json.tags }}",
  "source": "={{ $json.link }}",
  "type": "clipping"
}
```

### 6.7 模块化后的 Workflow 1 改造版

```
Schedule Trigger → HTTP Request (RSS) → Code (解析RSS)
    → Execute Workflow (sub-ai-classify)
    → Execute Workflow (sub-format-obsidian)
    → Write File (保存到Vault)
```

对比原来的版本，AI 分类和格式化都变成了子工作流调用——代码更简洁，维护更方便。

> ✋ **费曼自测**：子工作流和普通工作流有什么区别？为什么子工作流要用 Manual Trigger 而不是其他触发器？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] Workflow 3 (Webhook 知识 API) 能接收查询并返回结果
- [ ] 创建了至少 1 个子工作流
- [ ] 理解 Execute Workflow 节点如何调用子工作流
- [ ] 知道子工作流适合封装哪些逻辑

---

## 番茄钟7：终极费曼测试（25分钟）

### 7.1 六项实战任务

这是对你一周学习成果的终极检验。每完成一项，在前面打勾。

**任务1：从零部署 n8n**

- [ ] 编写 `docker-compose.yml` 并启动 n8n
- [ ] 在浏览器中访问 `http://localhost:5678`
- [ ] 确认数据持久化（重启容器后工作流仍在）

**验收标准**：`docker-compose ps` 显示 n8n 运行中，且重启后工作流不丢失。

---

**任务2：创建包含 Webhook + AI Agent + IF + Code 的完整工作流**

```
Webhook → Code (校验) → AI Agent (处理) → IF (判断质量) → Code (格式化)
```

- [ ] Webhook 接收 POST 请求
- [ ] Code 节点校验输入参数
- [ ] AI Agent 处理内容
- [ ] IF 节点判断输出质量（如：回答长度 > 100 字）
- [ ] Code 节点格式化输出

**验收标准**：用 curl 发送请求后，收到格式化的 JSON 响应。

---

**任务3：配置至少一个 API 凭证**

- [ ] 在 Credentials 中添加一个 API 凭证（OpenAI / 智谱 GLM / OpenRouter 均可）
- [ ] 在工作流中使用该凭证
- [ ] 成功调用 API

**验收标准**：API 调用返回 200 状态码。

---

**任务4：实现错误处理**

- [ ] 在 Settings → Error Workflow 中配置 Error Workflow
- [ ] 创建 Error Workflow，包含通知节点（Slack/邮件/HTTP Request）
- [ ] 在主工作流中故意制造一个错误（如：访问不存在的 API）
- [ ] 验证 Error Workflow 被触发

**验收标准**：主工作流出错时，Error Workflow 自动执行并发送通知。

---

**任务5：用 curl 测试 Webhook**

```bash
# 测试 GET
curl http://localhost:5678/webhook-test/knowledge-query

# 测试 POST
curl -X POST http://localhost:5678/webhook/knowledge-query \
  -H "Content-Type: application/json" \
  -d '{"query": "测试查询", "source": "curl-test"}'
```

- [ ] GET 测试返回正确响应
- [ ] POST 测试返回 AI 回答
- [ ] 测试异常输入（空 query）时返回错误信息

**验收标准**：三种测试场景均有正确的响应。

---

**任务6：保存结果为 Obsidian Markdown**

- [ ] Code 节点生成包含 Frontmatter 的 Markdown
- [ ] Write File 节点保存到 Vault 对应文件夹
- [ ] 在 Obsidian 中打开文件，确认格式正确、标签可点击

**验收标准**：Obsidian 中能看到格式正确的笔记，Frontmatter 属性面板正常显示。

### 7.2 任务评分标准

| 任务 | 完成度 | 分值 |
|------|--------|:----:|
| 任务1：部署 n8n | 能独立完成 | 15分 |
| 任务2：完整工作流 | Webhook+AI+IF+Code 全部跑通 | 25分 |
| 任务3：API 凭证 | 至少配置1个并成功调用 | 10分 |
| 任务4：错误处理 | Error Workflow 触发成功 | 15分 |
| 任务5：curl 测试 | 三种场景测试通过 | 15分 |
| 任务6：Obsidian Markdown | 格式正确、可打开 | 20分 |
| **总计** | | **100分** |

> 90+ = 大师级 | 70-89 = 熟练级 | 50-69 = 入门级 | <50 = 需要回顾复习

> ✋ **费曼自测**：不查资料，你能独立完成以上6项任务吗？哪一项你最没把握？

---

## 番茄钟8：精通自评与学习路线图（25分钟）

### 8.1 精通度自评表

对自己一周的学习成果进行评分（1-5分）：

| 天数 | 主题 | 核心技能 | 自评(1-5) |
|:---:|------|----------|:---------:|
| Day 1 | 安装部署与界面初探 | Docker 部署、画布操作、数据结构 | ⬜ |
| Day 2 | 核心节点与触发器 | 5种触发器、8大节点实操 | ⬜ |
| Day 3 | 凭证管理与API集成 | API Key 配置、REST API 调用 | ⬜ |
| Day 4 | 数据处理与工作流模式 | 批量处理、循环、错误处理 | ⬜ |
| Day 5 | Webhook与外部集成 | Webhook API 服务、curl 测试 | ⬜ |
| Day 6 | AI Agent工作流 | AI Agent 配置、MCP 工具、Prompt | ⬜ |
| Day 7 | 复习与综合实战 | 系统架构、三大工作流、子工作流 | ⬜ |

**评分标准**：
- **1分**：概念模糊，无法独立操作
- **2分**：理解概念，需要看教程才能操作
- **3分**：能独立完成基本操作
- **4分**：熟练操作，能解决常见问题
- **5分**：精通，能举一反三、教别人

> 💡 如果某天评分低于3，建议回去复习那天的内容并增加练习。

### 8.2 终极参考卡

```
┌─────────────────────────────────────────────────────────┐
│                  n8n 一周速查卡                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  🚀 部署                                                │
│  docker-compose up -d       # 启动                      │
│  docker-compose down        # 停止                      │
│  docker-compose logs -f     # 日志                      │
│  http://localhost:5678      # 访问                      │
│                                                         │
│  🔗 数据流                                               │
│  Item → Item → Item        # 节点间传递基本单位          │
│  $input.item.json          # 当前项数据                  │
│  $('NodeName').item.json   # 引用上游节点                │
│  {{ $json.field }}         # 表达式引用                  │
│                                                         │
│  🔑 凭证                                                 │
│  Credentials → Add → 选择类型 → 填写 API Key             │
│  节点中 Credential 下拉选择已配置的凭证                    │
│                                                         │
│  🔀 控制流                                               │
│  IF: 条件二选一            Switch: 条件多选一             │
│  Loop Over Items: 遍历     Split In Batches: 分批        │
│  Merge: 合并多路数据       Execute Workflow: 调子流程     │
│                                                         │
│  🌐 Webhook                                              │
│  Test URL: /webhook-test/  # 测试用(需在编辑界面)        │
│  Prod URL: /webhook/       # 生产用(需激活工作流)        │
│  Response Mode: On Receive / Respond Node                │
│                                                         │
│  🤖 AI Agent                                             │
│  System Message = 角色设定 + 输出格式要求                 │
│  Text = 实际输入内容                                     │
│  Tools = 可选工具（搜索引擎、代码执行等）                  │
│                                                         │
│  ⚠️ 错误处理                                             │
│  Settings → Error Workflow  # 绑定错误处理工作流         │
│  Error Trigger → 通知节点   # 错误时自动触发              │
│  Continue On Fail = true    # 节点失败不中断              │
│                                                         │
│  📝 Obsidian 集成                                        │
│  Code → 生成 Frontmatter + Markdown                     │
│  Write File → 保存到 Vault 映射目录                      │
│  文件名: {日期}-{标题}.md                                │
│  存放: Clippings/ 文件夹                                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 8.3 进阶学习路线图

完成这7天只是入门，以下是5个深入方向：

**方向1：自定义节点开发 (TypeScript)**

```
n8n 自定义节点开发
├── 学习 TypeScript 基础
├── 了解 n8n 节点开发框架
│   ├── INodeType 接口
│   ├── INodeProperties 属性定义
│   └── IExecuteFunction 执行逻辑
├── 开发你的第一个自定义节点
│   └── 例如: Obsidian Write 节点
└── 发布到 n8n 社区
```

推荐资源：
- [n8n 官方节点开发文档](https://docs.n8n.io/integrations/creating-nodes/)
- [n8n-nodes-starter 模板](https://github.com/n8n-io/n8n-nodes-starter)

**方向2：企业级部署 (K8s + Redis + PostgreSQL)**

```
n8n 企业部署架构
├── Kubernetes 集群部署
│   ├── Helm Chart 配置
│   ├── 多副本 + 负载均衡
│   └── 自动扩缩容
├── Redis 队列模式
│   ├── 多 Worker 并发执行
│   └── 任务队列管理
├── PostgreSQL 数据库
│   ├── 替代默认 SQLite
│   └── 数据备份与恢复
└── 监控与日志
    ├── Prometheus + Grafana
    └── ELK 日志分析
```

**方向3：AI 深度探索 (Multi-Agent + RAG + 向量数据库)**

```
n8n + AI 深度整合
├── Multi-Agent 编排
│   ├── 多个 AI Agent 协作
│   ├── Agent 间通信与协调
│   └── 复杂任务分解与调度
├── RAG 检索增强生成
│   ├── 文档切片与向量化
│   ├── 向量数据库集成 (Pinecone/Milvus)
│   └── 语义检索 + 上下文注入
├── MCP 工具扩展
│   ├── 自定义 MCP Server
│   └── 更多工具集成
└── 本地模型部署
    ├── Ollama + n8n
    └── 私有化 AI 方案
```

**方向4：数据管道 (ETL + 数据库同步 + 数据仓库)**

```
n8n 数据工程
├── ETL 管道
│   ├── 多源数据抽取 (API/DB/File)
│   ├── 数据清洗与转换
│   └── 加载到目标 (数据仓库/BI)
├── 数据库同步
│   ├── 增量同步策略
│   ├── 变更检测 (CDC)
│   └── 多数据库协同
└── 定时报表
    ├── 数据聚合与计算
    ├── 自动生成报表
    └── 推送到 Slack/邮件
```

**方向5：n8n + Obsidian 深度集成**

```
n8n ↔ Obsidian 双向联动
├── 自动化输入
│   ├── Web 剪藏 → Markdown → Vault
│   ├── 语音/图片 → AI 处理 → 笔记
│   └── 邮件/消息 → 分类归档
├── 智能处理
│   ├── AI 自动打标签 + 链接
│   ├── 内容摘要 + 知识图谱
│   └── 定期回顾提醒
├── 双向同步
│   ├── Obsidian → n8n (文件监听)
│   ├── n8n → Obsidian (写入笔记)
│   └── 属性变更触发工作流
└── 知识库运维
    ├── 孤立笔记检测
    ├── 标签统计与清理
    └── 定期备份与归档
```

### 8.4 学习优先级建议

| 优先级 | 方向 | 适合人群 | 预计用时 |
|:------:|------|----------|----------|
| ⭐⭐⭐ | 方向5: n8n+Obsidian 深度集成 | 所有 Obsidian 用户 | 2-4 周 |
| ⭐⭐⭐ | 方向3: AI 深度探索 | 对 AI 感兴趣者 | 4-8 周 |
| ⭐⭐ | 方向4: 数据管道 | 有数据处理需求者 | 3-6 周 |
| ⭐⭐ | 方向2: 企业级部署 | 团队使用 / 生产环境 | 2-4 周 |
| ⭐ | 方向1: 自定义节点 | 想贡献社区 / 特殊需求 | 4-8 周 |

> ✋ **费曼自测**：你能向一个完全不懂 n8n 的人，用一分钟说清楚 n8n 是什么、能做什么、为什么值得学吗？

---

## 🍅 番茄钟7-8结束

---

### 刻意练习——7天技能综合串联

**练习目标**：在40分钟内完成3轮综合挑战，检验和巩固7天全部技能

**任务序列（重复×3）：**

```
===== 循环 1：30分钟内完成一个完整工作流（限时挑战） =====
1. 设置计时器，限时30分钟
2. 从零构建一个 Webhook → AI Agent → Code → Respond to Webhook 的 API 服务
3. 必须包含：凭证配置、表达式引用、数据格式化
4. 用 curl 测试通过并返回正确响应
验证：30分钟内完成，curl 测试返回200，数据格式正确

===== 循环 2：排查3个预设的工作流故障 =====
1. 故意在一个工作流中制造3个以下故障之一：
   - 凭证未配置导致 API 401 错误
   - 表达式引用错误的节点名导致数据为空
   - Webhook 未点击 Listen 导致收不到请求
2. 逐个排查并修复每个故障
3. 记录每个故障的排查思路和修复方法
验证：3个故障全部定位并修复，工作流正常执行

===== 循环 3：从零设计一个自动化方案并实现 =====
1. 选一个你实际工作或生活中的场景（如：自动备份、定时汇总、消息通知等）
2. 画出工作流架构图（输入→处理→输出）
3. 从零创建工作流并实现
4. 测试通过并展示运行结果
验证：设计方案合理，工作流按预期运行，产生有实际价值的输出
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 限时完整工作流构建 | ⬜ | ⬜ | ⬜ |
| 工作流故障排查与修复 | ⬜ | ⬜ | ⬜ |
| 从零设计并实现自动化方案 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：限时挑战中哪个环节最卡壳？故障排查时你的第一步是什么？从零设计方案时你是怎么确定工作流结构的？

## 今日自检清单

完成以下所有项才算通过 Day 7：

- [ ] ✅ 能回忆 Day 1-6 每天的核心主题
- [ ] ✅ 理解三层架构设计（输入→处理→输出）
- [ ] ✅ Workflow 1 (RSS → AI → Obsidian) 搭建完成
- [ ] ✅ Workflow 2 (Email → AI 分类 → 多通道) 搭建完成
- [ ] ✅ Workflow 3 (Webhook 知识 API) 搭建完成
- [ ] ✅ 至少创建了 1 个子工作流
- [ ] ✅ 终极费曼测试 6 项任务完成
- [ ] ✅ 精通度自评表填写完成
- [ ] ✅ 确定了下一步学习方向

## 费曼一句话总结

> **n8n 是一个开源的工作流自动化平台，它通过「触发器→处理→输出」的三层架构，把数据采集、智能处理和多通道分发串成自动流水线。子工作流实现模块化复用，AI Agent 赋予工作流智能决策能力，最终构建出 Obsidian 智能知识管理系统——信息自动进来、自动分类、自动归档，你的第二大脑自动运转。**

## 学习笔记

```markdown
## Day 7 学习笔记

### 今天最大的收获
（用你自己的话写）

### 一周学习总结
（回顾7天的学习历程，写下你的感受和成长）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 下一步学习计划
（根据进阶路线图，选择你的方向）
```

---

## 🎉 Day 7 完成！

**今日成果：**
- ✅ 完成了 Day 1-6 全部核心概念的复习
- ✅ 设计了 Obsidian 智能知识管理系统的三层架构
- ✅ 构建了 3 个完整的实战工作流
- ✅ 掌握了子工作流模块化设计
- ✅ 通过了终极费曼测试
- ✅ 明确了下一步进阶方向

**一周总成就：**
- ✅ 7天、56个番茄钟、约24小时的学习投入
- ✅ 从零到能独立搭建自动化工作流
- ✅ 掌握了 n8n 核心功能：部署、节点、触发器、凭证、API、Webhook、AI Agent
- ✅ 构建了 Obsidian 智能知识管理系统
- ✅ 获得了进阶到企业级/深度 AI 应用的基础

**恭喜你完成了 n8n 一周学习教程！** 🎊

这只是开始，真正的能力在实践中成长。去构建你自己的自动化系统吧！

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day6-AI-Agent工作流]] - 前一天
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 n8n 工作流参考
> - [[30.areas/n8n-Workflow-Automation-Complete-Guide]] - n8n 技术参考手册
