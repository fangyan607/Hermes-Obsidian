# 费曼学习法复习文档 & 试卷 — 17-Dify部署与应用

---

## Section A：费曼学习法复习文档（理科场景模板）

### 一、核心概念（一句话说清）

| 概念 | 一句话解释 |
|------|-----------|
| **Dify** | 一个开源的 LLM 应用开发平台，提供从 Agent 构建到 AI Workflow 编排、RAG 检索、模型管理等能力 |
| **Docker Compose** | 一种通过 YAML 文件定义并运行多容器 Docker 应用程序的工具，一条命令启动所有服务 |
| **Chatflow（对话流）** | 专为多轮对话设计的应用编排方式，支持记忆和上下文理解 |
| **Workflow（工作流）** | 面向自动化、批处理等单轮生成任务的应用编排方式，单向生成结果 |
| **Tavily Search** | 一款专为开发者设计的搜索工具，支持文本和图像搜索，可集成到 Dify 工作流中 |
| **SiliconFlow** | 硅基流动提供的基于开源模型的高性价比 GenAI 服务，可在 Dify 中调用 Flux 和 Stable Diffusion 等绘图模型 |
| **MinerU** | PDF 解析工具，能将复杂 PDF（含图表、公式、多栏排版）解析为高质量文本 |

### 二、Dify 五种应用类型

1. **聊天助手** — 基于 LLM 构建对话式交互的助手
2. **文本生成应用** — 面向文本生成类任务（撰写故事、文本分类、翻译等）
3. **Agent** — 能够分解任务、推理思考、调用工具的对话式智能助手
4. **对话流（Chatflow）** — 适用于设计复杂流程的多轮对话场景，支持记忆功能
5. **工作流（Workflow）** — 适用于自动化、批处理等单轮生成类任务

### 三、Dify 部署四步流程

| 步骤 | 命令/操作 | 说明 |
|------|----------|------|
| Step1 | `git clone https://github.com/langgenius/dify.git` | 克隆 Dify 代码仓库 |
| Step2 | `cd dify/docker && cp .env.example .env` | 进入 Docker 目录，复制环境变量模板 |
| Step3 | `docker compose up -d` | 启动 Dify 服务（后台运行） |
| Step4 | 浏览器访问 `http://<IP>/install` → `http://<IP>` | 初始化管理员账户后使用 |

> 关键配置：APP_URL（访问地址）、数据库配置、模型供应商 API Keys（OpenAI、Anthropic、Qwen 等）

### 四、三个实战 CASE 核心逻辑

#### CASE 1：LLM 联网搜索（Workflow）
```
用户输入 → LLM 提取关键字 → TavilySearch 搜索 → LLM 总结整理 → 输出结果
```

#### CASE 2：古诗词文生图（Workflow）
```
用户输入古诗 → LLM 联想画面描述 → LLM 翻译英文（加 "ancient china"）→ Flux 文生图 → 输出图片
```

#### CASE 3：智能客服（Chatflow）
```
用户提问 → 问题分类器 → 分类1：营销→知识检索→LLM回复
                      → 分类2：投诉→关键信息提取→知识检索用户数据→LLM回复
                      → 分类3：其他→直接回复"无法回答"
```

#### CASE 4：智能文档分析助手（MinerU + Workflow）
```
用户上传PDF → MinerU 解析 → LLM 基于解析内容回答 → 返回结果
```

### 五、Chatflow 与 Workflow 核心区别

| 维度 | Chatflow（对话流） | Workflow（工作流） |
|------|-------------------|-------------------|
| 交互方式 | 多轮对话，记忆上下文 | 单轮生成，不维持对话 |
| 典型节点 | Answer（直接在中间步骤流式输出） | 无 Answer 节点 |
| 用户交互 | 开场白、建议问题、文件上传、引用归属 | 偏少 |
| 适用场景 | 智能客服、AI 助教、对话机器人 | 自动化批处理、数据分析 |

### 六、知识库构建关键要点

- **分段标识**：结构不佳的文本预设强分隔符，提升语义完整性
- **长度与重叠**：最大长度匹配模型窗口，重叠平衡点通常 10-20%
- **索引模式**："高质量"模式适合专业内容，但切换需整个知识库重索引
- **Embedding 模型**：选定后更换需整个知识库重新向量化
- **Rerank**：提升相关性排序，但增加延迟和计算成本
- **Score 阈值**：因 Embedding 模型而异，需针对性调优
- **全文检索**：精准命中向量检索可能遗漏的特定术语
- **混合检索**：Dify 支持权重调整

### 七、Dify API 三种端点

| 端点 | 路径 | 特点 |
|------|------|------|
| 聊天应用 | `/chat-messages` | 支持多轮对话（conversation_id），query 字段传参 |
| 完成应用 | `/completion-messages` | 单次完成，不维持对话状态 |
| 工作流应用 | `/workflows/run` | 需先发布工作流，inputs 对象传参 |

### 八、Coze API 调用步骤

1. 获取 API Token（https://www.coze.cn/open/oauth/pats）
2. 从智能体详情页 URL 中获取 Bot ID
3. 使用 `cozepy`（Coze 官方 Python SDK）初始化客户端
4. 支持普通聊天（`create_and_poll`）和流式聊天（`stream`）

---

## Section B：复习试卷

### 一、选择题（每题 4 分，共 40 分）

**1. Dify 是一个什么类型的平台？**
A. 数据库管理平台
B. 开源 LLM 应用开发平台
C. 容器编排平台
D. 代码托管平台

**2. Dify 官方推荐的部署方式是什么？**
A. 源代码直接运行
B. Docker Compose 部署
C. Kubernetes 部署
D. 手动安装依赖

**3. 以下哪个不属于 Dify 提供的五种应用类型？**
A. 聊天助手
B. 文本生成应用
C. 数据可视化应用
D. Agent

**4. Chatflow（对话流）相比 Workflow（工作流）独有的节点是什么？**
A. LLM 节点
B. 知识检索节点
C. Answer（回复）节点
D. 开始节点

**5. 在"LLM 联网搜索"工作流中，使用了哪个外部搜索工具？**
A. Google Search
B. Bing Search
C. TavilySearch
D. Baidu Search

**6. 在 Dify 中调用 Flux 绘图模型，通常需要先配置哪个外部服务？**
A. OpenAI
B. SiliconFlow
C. Hugging Face
D. Anthropic

**7. 在 Dify 知识库配置中，段落重叠的常见平衡点是多少？**
A. 0-5%
B. 10-20%
C. 30-40%
D. 50-60%

**8. 在"智能文档分析助手"CASE 中，用于解析 PDF 的工具是？**
A. PyPDF2
B. MinerU
C. PDFPlumber
D. Tesseract

**9. Dify 聊天应用 API 的端点路径是什么？**
A. `/completion-messages`
B. `/workflows/run`
C. `/chat-messages`
D. `/api/chat`

**10. Coze 官方提供的 Python SDK 叫什么？**
A. coze-sdk
B. cozepy
C. pycoze
D. coze-api

---

### 二、填空题（每空 2 分，共 20 分）

**1.** Dify 的本地化部署主要有两种方式：\____________ 部署（推荐）和源代码部署。

**2.** 克隆 Dify 代码仓库的命令是：`git clone \__________________________`。

**3.** 在 `dify/docker` 目录下启动 Dify 服务的命令是：`\____________ up -d`。

**4.** Dify 提供五种应用类型：聊天助手、文本生成应用、\________、Chatflow 和 Workflow。

**5.** Chatflow 适用于\__________________ 场景，Workflow 适用于自动化、批处理等单次任务。

**6.** 在"LLM 联网搜索"工作流中，第一个 LLM 节点的作用是：对用户问题\__________________。

**7.** 在"古诗词文生图"工作流中，LLM 节点将画面描述翻译成英文时，前面要加上 "\__________________"。

**8.** Dify 本身不直接提供绘图工具，但可以通过\__________________ 工具来实现绘图功能。

**9.** 在知识库配置中，Embedding 模型选定后若想更换，整个知识库需\__________________。

**10.** Dify API 的认证方式使用 \____________ Token。

---

### 三、问答题（每题 20 分，共 40 分）

**1. 请完整描述使用 Docker Compose 在本地部署 Dify 的四个步骤（含关键命令和配置要点）。**

**2. 对比 Chatflow（对话流）和 Workflow（工作流）在交互方式、核心节点、用户交互功能和适用场景四个方面的区别。**

---

### 四、参考答案

#### 选择题答案
| 题号 | 答案 |
|------|------|
| 1 | B |
| 2 | B |
| 3 | C |
| 4 | C |
| 5 | C |
| 6 | B |
| 7 | B |
| 8 | B |
| 9 | C |
| 10 | B |

#### 填空题答案

1. Docker Compose
2. https://github.com/langgenius/dify.git
3. docker compose
4. Agent
5. 多轮对话
6. 提取关键字（多个关键字用空格隔开）
7. ancient china
8. 外部
9. 重新向量化
10. Bearer

#### 问答题参考答案

**第 1 题：**

1. **克隆仓库**：`git clone https://github.com/langgenius/dify.git`
2. **进入 Docker 目录并配置环境变量**：`cd dify/docker` → `cp .env.example .env` → 修改 `.env` 文件中的 APP_URL、数据库配置和模型供应商 API Keys（如 OpenAI、Anthropic、Qwen 等）
3. **启动服务**：`docker compose up -d`（`-d` 表示后台运行）
4. **访问 Dify**：首次访问 `http://<IP>/install` 设置管理员账户，初始化完成后访问 `http://<IP>` 即可使用

**第 2 题：**

| 维度 | Chatflow（对话流） | Workflow（工作流） |
|------|-------------------|-------------------|
| 交互方式 | 多轮对话，支持记忆上下文，可根据之前交流回应 | 单轮生成，不维持对话状态，单向生成结果 |
| 核心节点 | 拥有专属 Answer 节点，可在流程中间步骤流式输出文本 | 无 Answer 节点，最终结果一次性输出 |
| 用户交互 | 包含开场白、下一步问题建议、文件上传、引用归属等增强体验功能 | 用户交互功能较少 |
| 适用场景 | 智能客服、语义搜索、AI 助教、需要引导用户完成特定任务的对话机器人 | 自动化批处理、复杂数据处理、内容生成、与外部系统集成的任务 |
