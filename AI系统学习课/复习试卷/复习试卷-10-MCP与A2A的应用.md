# MCP与A2A的应用 - 费曼学习法复习文档 & 试卷

---

# Section A：费曼学习法复习文档

---

## 🔬 学习主题

**学科领域**：计算机科学 / AI工程化 / 智能体协议
**核心概念**：MCP（模型上下文协议）与 A2A（Agent间协议）
**材料来源**：课程《10-MCP与A2A的应用.md》

---

## ⏱️ 番茄时钟（100分钟学习）

| 阶段 | 时长 | 任务 |
|------|------|------|
| 🍅 学习 | 25分钟 | 理解MCP与A2A的核心原理、架构、组件 |
| 🍅 提取 | 25分钟 | 找出核心机制、边界条件、两者关系 |
| 🍅 讲解 | 25分钟 | 用简单语言解释MCP和A2A |
| 🍅 验证 | 25分钟 | 做题验证、场景分析、代码理解 |

---

## 🎯 阶段一：原理学习

### 核心概念

| 概念名称                        | 定义                                                 | 我的理解                                             | 为什么重要                       |
| --------------------------- | -------------------------------------------------- | ------------------------------------------------ | --------------------------- |
| MCP（Model Context Protocol） | 由Anthropic于2024年11月推出的开放协议，标准化LLM与外部数据源/工具/服务的交互方式 | AI领域的USB-C接口：一个统一连接标准，让AI可以插上各种"外设"（数据库、API、文件等） | 解决AI与外部系统集成的碎片化问题，一次开发多场景复用 |
| A2A（Agent2Agent）协议          | Google于2025年4月9日发布的开放协议，目的是促进AI Agent之间的协作         | 智能体之间的"通用语言"：让不同AI Agent能互相通信、分工协作               | 实现多智能体协作，让专业Agent组成团队完成任务   |
| Function Calling            | 特定模型实现的功能调用机制，允许AI调用预定义的函数                         | 每个功能单独写代码接入，各自为政                                 | 早期方案，但每加一个功能就要写新的集成代码       |

### MCP与Function Calling的区别

| 维度 | MCP | Function Calling |
|------|-----|-----------------|
| 性质 | 协议（标准） | 功能（实现） |
| 范围 | 通用：多数据源、多功能 | 特定场景：单一数据源或功能 |
| 目标 | 统一接口，实现互操作 | 扩展模型能力 |
| 实现 | 基于标准协议 | 依赖于特定模型实现 |
| 开发复杂度 | 低：通过统一协议实现多源兼容 | 高：需要为每个任务单独开发函数 |
| 复用性 | 高：一次开发，可多场景使用 | 低：函数通常为特定任务设计 |
| 灵活性 | 高：支持动态适配和扩展 | 低：功能扩展需要额外开发 |
| 常见场景 | 复杂场景，如跨平台数据访问与整合 | 简单任务，如天气查询、商品推荐等 |

### MCP架构三组件

- **MCP Host**：运行AI模型的环境（如Claude Desktop、Cursor IDE）
- **MCP Client**：嵌入在Host中的组件，发起请求并与MCP Server通信
- **MCP Server**：轻量级服务，提供特定功能（数据查询、API调用等）

### MCP三大核心能力

- **Resources（资源）**：提供结构化数据（数据库、文档）增强上下文理解
- **Tools（工具）**：允许AI执行外部操作（发送邮件、查询GitHub、调用智能合约）
- **Prompts（提示模板）**：预定义指令模板，优化任务执行

### A2A五大核心原则

1. **拥抱智能体能力**：支持自然、非结构化协作
2. **利用现有标准**：使用HTTP、SSE、JSON-RPC确保兼容性
3. **默认安全**：企业级认证授权，与OpenAPI一致
4. **支持长期任务**：实时反馈、通知和状态更新
5. **多模态支持**：文本、音频、视频流等多模态通信

### A2A关键组件

| 组件 | 描述 |
|------|------|
| Agent Card | 位于 `/.well-known/agent.json`，描述能力、技能、端点URL和认证要求 |
| A2A服务器 | 实现协议方法，管理任务执行 |
| A2A客户端 | 发送 `tasks/send` 或 `tasks/sendSubscribe` 请求，消费A2A服务 |
| 任务（Task） | 核心工作单位，有唯一ID，状态包括submitted、working等 |
| 消息（Message） | 通信单位，角色为user或agent，包含Parts |
| 部分（Part） | 内容单位，包括TextPart、FilePart、DataPart |
| 工件（Artifact） | 任务输出，包含Parts |
| 流式传输 | 使用SSE事件更新长期任务状态 |
| 推送通知 | 通过webhook发送更新 |

### A2A与MCP的关系

- **MCP = 工具说明书**：让Agent能访问数据和工具（数据库、Slack、GitHub等）
- **A2A = 电话簿**：让Agent之间能协作处理数据和任务
- **两者互补**：Agent通过MCP调用工具获取数据，通过A2A与其他Agent协作分析
- **Agent Card = 身份证/服务菜单**：描述Agent能力，在MCP注册后可被其他Agent发现调用

---

## 💡 阶段二：机制提取

### 核心问题链

**1. MCP是什么？**
MCP（Model Context Protocol）是Anthropic于2024年11月推出的开放协议标准，用于标准化LLM与外部数据源、工具及服务之间的交互方式。被广泛类比为"AI领域的USB-C接口"。

**2. MCP怎么运作？**
采用客户端-服务器架构：Host（AI运行环境）→ Client（请求发起者）→ Server（功能提供者）。Server通过Resources/Tools/Prompts三种方式扩展AI能力。

**3. A2A是什么？**
A2A（Agent2Agent）协议是Google于2025年4月发布的开放协议，目的是促进AI Agent之间的协作，适用于大规模多智能体部署。

**4. A2A怎么运作？**
5步工作流：① 客户端获取Agent Card（能力发现）→ ② 发送任务请求（tasks/send或tasks/sendSubscribe）→ ③ 服务器处理任务 → ④ 可选交互（状态为input-required时）→ ⑤ 完成（completed/failed/canceled）

**5. MCP和A2A的关系是什么？**
互补关系。MCP专注标准化能力调用（类似微服务/应用商店），A2A专注动态协作（类似聊天/微信群聊）。Agent Card是连接两者的桥梁——在MCP注册能力描述，通过A2A实现Agent间协作。

**6. 边界条件有哪些？**
- Fetch MCP不能处理动态加载网页和robots.txt禁止抓取的页面
- A2A任务状态中包含input-required需要客户端提供更多输入
- MCP Server需要API Key等认证信息

**7. 实际应用时如何选择？**
- 需要工具/数据访问 → MCP（如高德地图MCP获取天气数据）
- 需要Agent间协作 → A2A（如WeatherAgent + BasketBallAgent联动）
- 两者都用：Agent通过MCP查数据，通过A2A与其他Agent协作分析

### 机制图解

```
MCP机制：
┌─────────────┐   请求    ┌─────────────┐   调用    ┌─────────────┐
│  MCP Host   │ ────────→ │  MCP Client │ ────────→ │  MCP Server │
│ (Cursor等)  │ ←──────── │ (嵌入Host) │ ←──────── │ (功能提供)  │
└─────────────┘   响应    └─────────────┘   返回    └─────────────┘
                                                          │
                                              ┌───────────┼───────────┐
                                              ▼           ▼           ▼
                                        Resources    Tools      Prompts
                                        (知识扩展)  (工具调用)  (提示模板)

A2A机制：
┌────────────────┐    1.获取Agent Card    ┌─────────────────┐
│                │ ──────────────────────→ │                 │
│  A2A客户端     │ ←────────────────────── │  A2A服务器      │
│ (BasketBall    │    2.tasks/send请求     │ (WeatherAgent)  │
│  Agent)        │ ──────────────────────→ │                 │
│                │ ←────────────────────── │                 │
└────────────────┘    3.返回任务结果       └─────────────────┘

MCP + A2A协作流：
Agent A (MCP调用数据库) → 获取数据 → Agent A (A2A请求Agent B) → Agent B (A2A返回分析结果)
        ↑                      ↑                         ↑
    MCP = 能力执行器     Agent Card = 能力目录      A2A = 协作总线
```

---

## 🗣️ 阶段三：简化讲解

### 给新人讲解版

> 今天我要给你讲两个很酷的东西，叫做MCP和A2A。
>
> **MCP是什么**：简单说，MCP就像是你电脑上的USB-C接口。以前每买一个新设备，都需要一根特殊的线才能连接。MCP就是AI领域的USB-C标准——任何AI只要支持MCP，就可以"插上"各种工具和服务（比如查天气、搜地图、看数据库），不用为每个工具单独写代码。
>
> **A2A是什么**：A2A就像一个"群聊系统"，让不同的AI Agent可以在群里互相@对方干活。一个Agent会说"我负责查天气"，另一个说"我负责安排活动"，它们通过A2A在群里沟通协作。
>
> **MCP怎么工作**：想象你去一个"AI工具商店"（MCP Server列表），你告诉店员（AI）你想做什么，店员去商店里拿对应的工具（通过MCP调用Server）来帮你完成任务。
>
> **A2A怎么工作**：想象你在一个项目群里——WeatherAgent说"明天要下雨"，BasketBallAgent看到后说"那取消篮球活动吧"。这就是A2A：Agent们通过标准化消息协作。
>
> **举个例子**：你问AI"上海明天适合打篮球吗？"→ AI通过MCP调用天气预报服务获取数据 → AI通过A2A问活动安排Agent是否适合 → 最终告诉你答案。
>
> **为什么重要**：因为现在互联网上有成千上万个工具和服务，MCP和A2A让AI可以统一地使用它们，还能让多个AI协作完成复杂任务。

### 可视化类比表

| 抽象概念 | 具体类比 | 为什么这样类比 |
|----------|----------|---------------|
| MCP协议 | AI领域的USB-C接口 | 一个统一标准连接各种外设，无需为每个外设定制线缆 |
| MCP Host | 电脑主机 | AI模型运行的地方 |
| MCP Server | USB设备/软件服务 | 接入的特定功能（地图、天气、数据库） |
| A2A协议 | 微信群聊 | 多个智能体用统一语言沟通协作 |
| Agent Card | 群成员名片/个人资料 | 写明"我会修图""我会翻译"，方便群里@你干活 |
| A2A任务 | 群里发任务 | 发一个任务（查天气），对方处理后回复 |
| MCP调用 | 用工具干活 | 直接使用某个工具完成操作 |
| A2A通信 | 分工协作 | 一个Agent查数据，另一个Agent分析数据 |
| MCP vs A2A | 工具说明书 vs 电话簿 | MCP说"怎么用工具"，A2A说"谁是干这个的" |
| MCP + A2A集成 | 智能体在群里@你，你用工具干活 | A2A找到人，MCP提供干活工具 |

---

## ✅ 阶段四：验证练习

### 基础题

**题目1**：MCP的三个核心组件是什么？分别描述它们的作用。

> 解答：
> 1. **MCP Host**：运行AI模型的环境，如Claude Desktop、Cursor IDE
> 2. **MCP Client**：嵌入在Host中的组件，负责发起请求并与MCP Server通信
> 3. **MCP Server**：轻量级服务，提供特定功能（数据查询、API调用等），供AI模型调用

**题目2**：MCP提供的三种关键能力是什么？

> 解答：
> 1. **Resources（资源）**：提供结构化数据以增强AI的上下文理解
> 2. **Tools（工具）**：允许AI执行外部操作
> 3. **Prompts（提示模板）**：预定义的指令模板优化AI任务执行

**题目3**：A2A协议的典型工作流程包含哪5个步骤？

> 解答：
> 1. **发现**：客户端从 `/.well-known/agent.json` 获取Agent Card
> 2. **启动**：客户端发送任务请求（tasks/send或tasks/sendSubscribe）
> 3. **处理**：服务器处理任务，可能涉及流式更新或直接返回结果
> 4. **交互（可选）**：若任务状态为input-required，客户端可发送更多消息
> 5. **完成**：任务达到终端状态（completed、failed或canceled）

### 变式题

**题目4**：比较MCP和Function Calling在"复用性"和"灵活性"两个维度上的区别。

> 解答：
> - **复用性**：MCP高（一次开发多场景使用），Function Calling低（函数通常为特定任务设计）
> - **灵活性**：MCP高（支持动态适配和扩展），Function Calling低（功能扩展需要额外开发）

**题目5**：在"安排篮球活动"CASE中，WeatherAgent和BasketBallAgent分别扮演什么角色？它们是如何通信的？

> 解答：
> - **WeatherAgent**：提供天气预报服务，通过FastAPI实现，暴露 `/api/tasks/weather` 端点
> - **BasketBallAgent**：负责篮球活动安排的智能体，是A2A客户端
> - **通信方式**：BasketBallAgent通过A2A协议，先获取WeatherAgent的Agent Card（包含端点信息），然后发送tasks/send请求查询天气，根据返回的天气条件（是否含"雨"或"雪"）决定是否安排活动

**题目6**：说明Fetch MCP不能处理哪些类型的网页，以及原因。

> 解答：
> 1. **动态加载的网页**：页面内容通过JavaScript异步加载，初始HTML不包含完整内容
> 2. **robots.txt禁止抓取的网页**：网站通过robots.txt声明不允许爬虫抓取

### 理解度自评

| 能力 | 自评（1-4）| 证据 |
|------|-----------|------|
| 能解释MCP核心架构 | /4 | |
| 能比较MCP与Function Calling | /4 | |
| 能描述A2A工作流程 | /4 | |
| 能说明MCP与A2A的关系 | /4 | |

---

# Section B：复习试卷

---

## 一、选择题（每题2分，共20分）

**1. MCP（Model Context Protocol）是由哪家公司推出的？**
- A. Google
- B. OpenAI
- C. Anthropic
- D. Microsoft

**2. MCP被广泛类比为什么？**
- A. AI领域的USB-C接口
- B. AI领域的WIFI协议
- C. AI领域的蓝牙标准
- D. AI领域的HDMI接口

**3. 以下哪个不是MCP的核心组件？**
- A. MCP Host
- B. MCP Client
- C. MCP Router
- D. MCP Server

**4. MCP与Function Calling相比，以下描述正确的是？**
- A. MCP复用性低，Function Calling复用性高
- B. MCP灵活性高，Function Calling灵活性低
- C. MCP开发复杂度高，Function Calling开发复杂度低
- D. MCP适用于简单任务，Function Calling适用于复杂场景

**5. A2A（Agent2Agent）协议是由哪家公司发布的？**
- A. Anthropic
- B. Google
- C. OpenAI
- D. Meta

**6. Agent Card在A2A协议中位于什么路径？**
- A. /api/agent.json
- B. /.well-known/agent.json
- C. /.config/agent.json
- D. /agent/card.json

**7. 在A2A工作流程中，如果需要处理长期任务，客户端应使用哪个请求？**
- A. tasks/send
- B. tasks/fetch
- C. tasks/sendSubscribe
- D. tasks/stream

**8. MCP和A2A的关系是什么？**
- A. 互斥关系，只能选择其一
- B. 替代关系，A2A将取代MCP
- C. 互补关系，MCP管工具调用，A2A管Agent协作
- D. 相同关系，只是名称不同

**9. 在桌面TXT统计器CASE中，使用什么装饰器将Python函数暴露给AI模型？**
- A. @mcp.server()
- B. @mcp.tool()
- C. @mcp.function()
- D. @mcp.api()

**10. MCP的三种关键能力不包括以下哪项？**
- A. Resources（资源）
- B. Tools（工具）
- C. Prompts（提示模板）
- D. Routes（路由）

---

## 二、填空题（每题2分，共20分）

**1.** MCP的全称是_____________，由Anthropic于________年11月推出。

**2.** MCP采用_____________架构，包含Host、Client和Server三个核心组件。

**3.** MCP Tools的关键能力是允许AI执行_____________操作。

**4.** A2A协议的全称是_____________，由________于2025年4月发布。

**5.** Agent Card位于_____________路径，用于描述智能体的能力和认证要求。

**6.** A2A任务的核心工作单位是___________，有唯一ID和状态跟踪。

**7.** 在A2A工作流程的第一步___________中，客户端获取Agent Card了解智能体能力。

**8.** MCP与A2A的关系被比喻为：MCP是__________________，A2A是电话簿。

**9.** 在桌面TXT统计器CASE中，通过_____________装饰器将函数注册为工具供AI调用。

**10.** MCP Inspector是一个专为MCP Server设计的_____________工具，默认访问地址为http://localhost:5173。

---

## 三、问答题（每题10分，共20分）

**1. 请详细说明MCP的架构组成（Host/Client/Server）和三种关键能力（Resources/Tools/Prompts），并分别举例说明每种能力的应用场景。**

答：

---

**2. 请对比MCP和A2A两种协议：它们分别解决什么问题？它们的核心区别是什么？在实际应用中如何配合使用？请用"安排篮球活动"案例中的具体实现来说明。**

答：

---

## 参考答案

### 一、选择题答案

| 题号 | 答案 | 解析 |
|------|------|------|
| 1 | C | MCP由Anthropic于2024年11月推出 |
| 2 | A | MCP被广泛类比为"AI领域的USB-C接口" |
| 3 | C | MCP核心组件为Host、Client、Server，无Router组件 |
| 4 | B | MCP灵活性高（支持动态适配扩展），Function Calling灵活性低（扩展需额外开发） |
| 5 | B | A2A协议由Google于2025年4月9日发布 |
| 6 | B | Agent Card位于 `/.well-known/agent.json` |
| 7 | C | tasks/sendSubscribe用于处理长期任务，通过SSE发送更新 |
| 8 | C | MCP与A2A互补：MCP管工具调用，A2A管Agent协作 |
| 9 | B | 使用 `@mcp.tool()` 装饰器将Python函数暴露为工具 |
| 10 | D | MCP的三种能力是Resources、Tools、Prompts，Routes不属于MCP核心能力 |

### 二、填空题答案

1. **Model Context Protocol**（模型上下文协议），**2024**
2. **客户端-服务器**（Client-Server）
3. **外部**（或：具体业务）
4. **Agent2Agent协议**，**Google**
5. **`/.well-known/agent.json`**
6. **任务**（Task）
7. **发现**（Discovery）
8. **工具说明书**（或：能力执行器/应用商店）
9. **`@mcp.tool()`**
10. **开源调试**（或：调试）

### 三、问答题答案要点

**1. MCP架构组成与三种关键能力：**

**架构组成：**
- **MCP Host**：运行AI模型的环境，如Claude Desktop、Cursor IDE。它是AI的工作台。
- **MCP Client**：嵌入在Host中的组件，负责发起请求并与MCP Server通信，充当"翻译官"。
- **MCP Server**：轻量级服务，提供特定功能。每个Server专注于一个领域（如地图查询、文件操作）。

**三种关键能力：**
- **Resources（资源/知识扩展）**：提供结构化数据增强AI上下文理解。例如：旅游攻略MCP中，高德地图提供POI数据、路线规划等资源，帮助AI生成详细的行程规划。
- **Tools（工具调用）**：允许AI执行外部操作。例如：桌面TXT统计器中，通过count_desktop_txt_files()函数统计桌面txt文件数量；Fetch MCP中抓取网页内容。
- **Prompts（提示模板）**：预定义指令模板优化任务执行。例如：预置"以表格形式输出"、"用Markdown格式输出"等模板指导AI输出格式。

**2. MCP与A2A对比与配合：**

**各自解决的问题：**
- **MCP**：解决AI与外部工具/数据源的标准连接问题。让AI能够统一地访问数据库、API、文件等资源。
- **A2A**：解决多个AI Agent之间的协作通信问题。让不同专业领域的Agent能分工合作完成复杂任务。

**核心区别：**
- MCP专注**能力调用**（类似微服务/应用商店），是工具层标准化
- A2A专注**Agent间通信**（类似微信群聊），是协作层标准化
- Agent Card是连接两者的桥梁：通过MCP注册能力，通过A2A通信协作

**"安排篮球活动"案例中的配合：**

```
MCP层面（工具调用）：
WeatherAgent 通过MCP调用天气数据源获取指定日期的天气预报数据
（实际代码中使用FastAPI实现，通过HTTP端点提供天气数据）

A2A层面（Agent协作）：
1. BasketBallAgent 获取 WeatherAgent 的 Agent Card（能力发现）
   - Agent Card声明了WeatherAgent提供"指定日期天气数据查询"能力
   - 包含端点URL、输入格式、认证方式等信息

2. BasketBallAgent 通过A2A协议向WeatherAgent发送 tasks/send 请求
   - 包含目标日期参数
   
3. WeatherAgent 处理请求，模拟返回天气数据（如"雷阵雨"）

4. BasketBallAgent 判断天气条件：
   - "雷阵雨"含"雨"字 → 取消活动（2025年5月8日）
   - "多云转晴"不含"雨""雪" → 确认活动（2025年5月10日）

5. BasketBallAgent 向用户返回最终决策

MCP + A2A协同：Agent通过MCP获取数据（天气），
通过A2A实现Agent间协作（天气Agent→篮球Agent），
Agent Card作为"服务目录"连接两个协议层。
```

---

*学习主题：MCP与A2A的应用*
*试卷生成日期：2026-06-05*
