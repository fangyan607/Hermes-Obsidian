# RAG / GBrain / LLM_WIKI 知识库 —— 5番茄对比学习

> ⏱ 预计学习时间：5个番茄钟（25分钟×5）
> 🎯 学习方式：边读边操作，每个知识点后跟着做
> 🧠 教学方法：费曼学习法
> 📅 创建日期：2026-06-10

---

## 番茄钟1：三个"大脑"是什么？（25分钟）

### 1.1 用一句话说清每个概念

**RAG** —— 像图书馆查书：你提问，它去知识库检索相关段落，拼给你看。

**GBrain** —— 像私人秘书+笔记本：不仅帮你查，还帮你记、帮你关联、帮你整理，半夜还在帮你理笔记。

**LLM_WIKI** —— 像维基百科编辑者：LLM 既能从知识库"读"，也能"写"回去，越用越聪明。

**用大白话讲：**

想象你要回答一个问题："张三投资了哪些公司？"

| 系统 | 它怎么做 | 比喻 |
|------|----------|------|
| **RAG** | 搜索"张三"，返回含"张三"的文档片段 | 去图书馆翻书，找到相关页 |
| **GBrain** | 找到"张三"的页面，沿着 `invested_in` 边遍历，返回关联公司 | 查张三的名片夹，看到他投了啥 |
| **LLM_WIKI** | 先查到张三的信息，发现新投资没记录，**写回去**，下次直接有 | 一边翻书一边往笔记本上补充 |

> ✋ **费曼自测**：用自己的话向一个非技术朋友解释，RAG 和 LLM_WIKI 最大的区别是什么？（提示：想想"读"和"写"）

---

### 1.2 它们从哪来？——起源故事

**RAG**（2020年）
- 全称：Retrieval-Augmented Generation（检索增强生成）
- 由 Facebook AI Research 的 Lewis 等人提出
- 解决的核心问题：大模型"不知道最新的事"和"会编答案"
- 关键论文：*"Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"*

**GBrain**（2026年4月）
- 创始人：Garry Tan（YC 总裁兼 CEO）
- GitHub：[github.com/garrytan/gbrain](https://github.com/garrytan/gbrain)（⭐ 21,900+）
- 起因：Garry 管理几百个创始人和上千家公司的历史决策，每次开新对话 AI 啥都不记得
- 24小时 GitHub Stars 破 5000，核心创新：知识图谱 + 混合检索 + 梦境循环

**LLM_WIKI**（2023年起）
- 思想源头：Andrej Karpathy 的 "LLM as Operating System" 演讲
- 核心类比：LLM = 操作系统内核，上下文窗口 = RAM，Wiki = 文件系统
- 最忠实实现：MemGPT/Letta（[github.com/cpacker/MemGPT](https://github.com/cpacker/MemGPT)，⭐ 13,000+）
- 关键洞见：**操作系统不仅需要 `read()`，还需要 `write()`**

> ✋ **费曼自测**：RAG 解决了"不知道"的问题，GBrain 和 LLM_WIKI 各自额外解决了什么问题？

---

### 1.3 核心思维转变

| 认知层级 | 旧理解 | 新理解 |
|----------|--------|--------|
| RAG | "给AI装个搜索引擎" | RAG 是"只读"管道——检索→拼接→生成，知识库本身不变 |
| GBrain | "增强版RAG" | GBrain 是**活的图谱**——知识自动关联、自动维护、自我进化 |
| LLM_WIKI | "RAG+写入" | LLM_WIKI 是**读写闭环**——LLM 从知识消费者变成知识管理者 |

---

### 🍅 番茄钟1结束，休息5分钟

**核心概念回顾：**
- RAG = 检索增强生成（只读管道）
- GBrain = 知识图谱+混合检索+梦境循环（自动进化的大脑）
- LLM_WIKI = 读写兼备的知识库（LLM 可写回知识）
- 三者的本质区别在于**知识流的方向**：单向读取 vs 双向读写 vs 自动生长

---

## 番茄钟2：架构大比拼（25分钟）

### 2.1 RAG 架构：线性管道

```
文档 → 切块(Chunking) → 嵌入(Embedding) → 向量数据库(Vector DB)
                                                    ↓
用户提问 → 问题嵌入 → 向量检索(Top-K) → 上下文拼接 → LLM生成 → 答案
```

**五层核心组件：**

| 组件 | 作用 | 常用工具 |
|------|------|----------|
| 文档加载 | 读取 PDF/MD/DOCX | LangChain Loader, LlamaIndex |
| 文本切片 | 按长度/语义分割 | RecursiveCharacterTextSplitter |
| 嵌入模型 | 文本→向量 | BGE-M3, text-embedding-v4 |
| 向量数据库 | 存储和检索向量 | FAISS, Chroma, Milvus |
| 检索编排 | 检索+重排+拼接 | LangChain Chain, LlamaIndex Engine |

**关键特征：** 数据从知识库流向 LLM，**永远不回流**。知识库是静态的。

---

### 2.2 GBrain 架构：活的图谱系统

```
         ┌─────────────────────────────────────┐
         │        GBrain 检索管道              │
         │                                     │
         │  意图分类 → 查询扩展 → 混合搜索    │
         │     ├── 向量检索 (HNSW/pgvector)    │
         │     ├── 关键词检索 (BM25/tsvector)  │
         │     ├── 关系检索 (图谱遍历)          │
         │     └── RRF融合 → Top 30            │
         │                                     │
         │  → 图增强(种子节点遍历类型化边)     │
         │  → 重排序(zerank-2 cross-encoder)   │
         │  → Token预算强制 → 去重 → 结果     │
         └─────────────────────────────────────┘

信号 → 检索 → 回答 → 写入 → 自动关联 → 同步
(每条    (brain优先  (基于    (页面+   (类型化边    (cron
 消息)    检索)      上下文)  时间线)  +反向链接)   保持新鲜)
```

**四策略协同：**

| 策略 | 原理 | 解决什么问题 |
|------|------|-------------|
| 向量搜索 | 语义相似性 | "说的不一样但意思相近" |
| BM25关键词 | 词法精确匹配 | "精确关键词必须出现" |
| RRF融合 | 合并两路排名 | 综合语义+词法优势 |
| 知识图遍历 | 沿类型化边行走 | "张三投了哪些公司"这类关系查询 |

> ✋ **费曼自测**：为什么纯向量搜索不够，还需要 BM25 和知识图谱？各举一个纯向量搜索搞不定的场景。

---

### 2.3 LLM_WIKI 架构：三层记忆

```
┌──────────────────────────────────────────┐
│           Core Memory（核心记忆）         │
│   始终在上下文窗口中，类似 CPU L1 缓存    │
│   容量小但速度快，存放身份和关键信息       │
├──────────────────────────────────────────┤
│           Recall Memory（回忆记忆）       │
│   对话历史，类似 RAM                      │
│   可搜索、可回溯，但窗口有限              │
├──────────────────────────────────────────┤
│          Archival Memory（归档记忆）      │
│   无限持久化存储，类似硬盘/Wiki           │
│   通过 archival_memory_insert() 写入      │
│   通过 archival_memory_search() 检索      │
└──────────────────────────────────────────┘
```

**关键函数调用：**

| 函数 | 作用 | 类比 |
|------|------|------|
| `archival_memory_insert(text)` | 写入长期记忆 | 往笔记本上写新内容 |
| `archival_memory_search(query)` | 检索长期记忆 | 在笔记本里搜索 |
| `core_memory_replace(old, new)` | 更新核心记忆 | 修改自己的名片信息 |
| `conversation_search(query)` | 搜索对话历史 | 翻聊天记录 |

---

### 2.4 三者架构对比表

| 维度 | RAG | GBrain | LLM_WIKI |
|------|-----|--------|----------|
| **知识流向** | 单向（只读） | 双向+自动生长 | 双向（读写） |
| **核心存储** | 向量数据库 | Postgres+pgvector+图谱 | 三层记忆系统 |
| **检索方式** | 向量搜索 | 向量+BM25+图谱+RRF | 语义搜索+函数调用 |
| **知识关联** | 无（扁平chunk） | 类型化边（自动建图） | 隐式（LLM自主管理） |
| **自动维护** | 无 | 梦境循环(Dream Cycle) | LLM自主写入更新 |
| **知识形态** | 静态chunk | 活页面+边+时间线 | 流动记忆 |

---

### 🍅 番茄钟2结束，休息5分钟

**架构核心洞见：**
- RAG = "查字典"（查完就走）
- GBrain = "用脑子查"（查的时候脑中自动关联）
- LLM_WIKI = "边查边记"（查完还往笔记本上补充）
- GBrain 的**知识图谱**是其+31%精度提升的"承重墙"

---

## 番茄钟3：配置与部署（25分钟）

### 3.1 RAG 搭建（最简单）

**最小化部署（3步跑通）：**

```python
# Step1: 安装依赖
pip install langchain chromadb sentence-transformers

# Step2: 构建知识库
from langchain.document_loaders import DirectoryLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma

loader = DirectoryLoader("./my_docs/", glob="**/*.md")
docs = loader.load()

splitter = RecursiveCharacterTextSplitter(chunk_size=800, chunk_overlap=150)
chunks = splitter.split_documents(docs)

embeddings = HuggingFaceEmbeddings(model_name="BAAI/bge-small-zh-v1.5")
vectordb = Chroma.from_documents(chunks, embeddings, persist_directory="./db")

# Step3: 查询
results = vectordb.similarity_search("你的问题", k=3)
```

**推荐Embedding模型选择：**

| 场景 | 推荐模型 | 维度 | 大小 |
|------|----------|------|------|
| 中文通用 | bge-small-zh-v1.5 | 512 | 90MB |
| 中英混合 | BGE-M3 | 1024 | 2.2GB |
| 跨语言长文档 | gte-Qwen2-1.5B-instruct | 1536 | 3GB |
| 轻量实时 | all-MiniLM-L6-v2 | 384 | 80MB |

> ✋ **费曼自测**：为什么法律文档和文学小说应该用不同的切块参数？（提示：法条完整性 vs 剧情完整性）

---

### 3.2 GBrain 部署（中等复杂度）

**安装（2秒初始化）：**

```bash
# 安装 Bun 运行时
curl -fsSL https://bun.sh/install | bash

# 安装 GBrain
bun install -g github:garrytan/gbrain

# 初始化大脑（PGLite，无需 Docker）
gbrain init --pglite

# 健康检查
gbrain doctor
```

**连接 AI Agent：**

```bash
# Claude Code
claude mcp add gbrain -- gbrain serve

# Codex
codex mcp add gbrain -- gbrain serve
```

**API Key 配置：**

```bash
export ZEROENTROPY_API_KEY=ze-...     # 默认 embedding + reranker
export OPENAI_API_KEY=sk-...          # 向量搜索回退 + 聊天模型
export ANTHROPIC_API_KEY=sk-ant-...   # 可选，改善查询扩展质量
```

**核心配置文件：**

| 文件 | 作用 |
|------|------|
| `gbrain.yml` | 定义 db_tracked（版本控制目录）和 db_only（数据库持久化目录） |
| `~/.gbrain/config.json` | 本地运行时配置（API keys、搜索模式等） |

**搜索模式：**

| 模式 | Token预算 | 查询扩展 | 关系检索 | 适用场景 |
|------|-----------|----------|----------|----------|
| conservative | 4,000 | 关 | 关 | 简单问答 |
| balanced | 12,000 | 关 | 开 | 日常使用 |
| tokenmax | 无限制 | 开 | 开 | 深度研究 |

**Cron 定时任务：**

```bash
# 每15分钟同步
*/15 * * * * gbrain sync --repo ~/brain && gbrain embed --stale

# 每晚梦境循环
0 2 * * * gbrain dream

# 每周健康检查
0 9 * * 1 gbrain doctor --json && gbrain embed --stale
```

---

### 3.3 LLM_WIKI 部署（以 MemGPT/Letta 为例）

**安装：**

```bash
pip install pymemgpt
# 或使用 Letta（新版）
pip install letta
letta server  # 启动服务
```

**核心配置：**

```python
from memgpt import create_client

client = create_client()

# 创建带记忆的 Agent
agent = client.create_agent(
    name="知识助手",
    system="你是一个能读写知识库的助手..."
)

# 发送消息（Agent 自主决定是否读写记忆）
response = client.send_message(
    agent_id=agent.id,
    message="记住：张三投资了公司A",
    role="user"
)
```

**Khoj（面向个人用户，支持 Obsidian）：**

```bash
# Docker 部署
docker run -d \
  -p 42110:42110 \
  -v ~/khoj-data:/root/.khoj/ \
  ghcr.io/khoj-ai/khoj:latest

# 连接 Obsidian 笔记
# 在 Khoj Web UI → Settings → Content → 添加 Obsidian Vault 路径
```

---

### 3.4 部署复杂度对比

| 维度 | RAG | GBrain | LLM_WIKI (MemGPT) |
|------|-----|--------|-------------------|
| **安装时间** | 5分钟 | 2分钟 | 10分钟 |
| **依赖** | Python + 向量DB | Bun + PGLite | Python + DB |
| **需要Docker** | 可选 | 不需要 | 推荐 |
| **API Key** | 可选（本地模型） | 需要 | 需要 |
| **适合场景** | 单一知识库问答 | 个人/团队知识大脑 | 长期对话型助手 |

> ✋ **费曼自测**：如果你的 Obsidian 知识库有5000本MD书，你会选哪个方案？为什么？

---

### 🍅 番茄钟3结束，休息5分钟

**配置核心洞见：**
- RAG 最简单，5分钟跑通，但只解决"查"
- GBrain 开箱即用（PGLite零配置），但需要 API Key
- LLM_WIKI 最灵活，但需要理解三层记忆模型
- **选择建议：先跑通RAG理解原理 → 再上GBrain体验图谱 → 最后试LLM_WIKI做读写闭环**

---

## 番茄钟4：使用方法与实战场景（25分钟）

### 4.1 RAG 实战：本地知识库问答

**典型工作流：**

```
1. 收集文档 → 2. 切块向量化 → 3. 用户提问 → 4. 检索相关片段 → 5. LLM生成答案
```

**适用场景：**
- 📚 企业知识库（政策文档、产品手册）
- 📊 投研报告问答
- 🎓 学术论文检索
- 🏥 医疗/法律专业问答

**RAG 进阶技巧（从课程笔记提炼）：**

| 优化方向 | 方法 | 效果 |
|----------|------|------|
| 解析质量 | Docling/MinerU 替代 PyPDF2 | 表格、公式保留更好 |
| 切片策略 | 按文档类型差异化切块 | 法律800-1200 token，文学400-600 token |
| 检索质量 | 混合搜索 + Rerank | 精度提升30%+ |
| 生成质量 | CoT + 结构化输出 + 指令细化 | 幻觉大幅减少 |
| 查询路由 | 多数据库+路由器 | 搜索范围缩小100倍 |

---

### 4.2 GBrain 实战：个人知识大脑

**日常使用命令：**

```bash
# 写入知识
gbrain put-page "张三" --content "张三投资了公司A和B"

# 搜索
gbrain search "张三投资了什么"
# 返回：张三 → invested_in → 公司A, 公司B

# 图谱查询（多跳遍历）
gbrain graph-query "张三" --depth 2
# 返回：张三 → invested_in → 公司A → founded_by → 李四

# 梦境循环（夜间自动维护）
gbrain dream

# 自动驾驶模式
gbrain autopilot --install
```

**12步检索流水线逐步拆解：**

| 步骤 | 动作 | 说明 |
|------|------|------|
| 1 | 意图分类 | 判断查询是事实型、关系型还是列表型 |
| 2 | 查询扩展 | 可选：用LLM重写查询 |
| 3 | 向量检索 | HNSW搜索语义相似chunk |
| 4 | BM25检索 | 精确关键词匹配 |
| 5 | 关系检索 | 沿图谱边遍历 |
| 6 | RRF融合 | 合并三路结果，取Top30 |
| 7 | 图增强 | 从种子节点遍历类型化边 |
| 8 | 重排序 | zerank-2 cross-encoder精排 |
| 9 | Token预算 | 按模式裁剪上下文长度 |
| 10 | 去重 | 同slug不同chunk保留最优 |
| 11 | 上下文组装 | 拼接最终context |
| 12 | LLM生成 | 基于增强上下文生成答案 |

**GBrain 的"魔法"——Dream Cycle（梦境循环）：**

```
Dream Cycle 8阶段：
1. 实体扫描 → 发现新人物/组织
2. 引用修复 → 修复断裂的wikilink
3. 记忆巩固 → 将短期信息固化为长期知识
4. 跨会话模式检测 → 发现重复出现的主题
5. 对话综合 → 将对话精华提炼为页面
6. 矛盾检测 → 标记互相矛盾的信息
7. 显著度评分 → 给知识排优先级
8. 明日任务准备 → 为下次使用做准备
```

> Garry Tan 的原话："I wake up smarter than when I went to bed" —— 每天早上起来，大脑比昨晚更聪明了。

> ✋ **费曼自测**：GBrain 的 Dream Cycle 和人类睡眠中的"记忆巩固"有什么相似之处？

---

### 4.3 LLM_WIKI 实战：读写兼备的知识管理

**MemGPT 使用示例：**

```python
# 1. Agent 自主决定写入记忆
# 用户: "记住：项目X的截止日期是6月30日"
# Agent: 调用 archival_memory_insert("项目X截止日期：6月30日")

# 2. Agent 自主搜索记忆
# 用户: "项目X什么时候截止？"
# Agent: 调用 archival_memory_search("项目X截止日期")
# 返回: "项目X截止日期：6月30日"

# 3. Agent 自主更新记忆
# 用户: "项目X延期到7月15日"
# Agent: 调用 core_memory_replace("6月30日", "7月15日")
```

**Khoj + Obsidian 实战：**

```markdown
# Khoj 连接 Obsidian 工作流

1. 安装 Khoj → Docker 部署
2. Settings → Content → 添加 Vault 路径
3. Khoj 自动索引你的笔记
4. 对话时，Khoj 自动检索相关笔记
5. Khoj 可以写回新笔记到 Vault（实验性功能）
```

**与你的 ideal 知识库的关系：**

当前 ideal 的 `CLAUDE.md + MEMORY.md + Claude_Memory/` 三层系统已经是 LLM_WIKI 思想的轻量实现：
- `MEMORY.md` = Core Memory（始终在上下文中）
- `Claude_Memory/` = Archival Memory（持久化存储）
- 对话历史 = Recall Memory

---

### 4.4 三者使用场景对比

| 场景 | 最佳选择 | 原因 |
|------|----------|------|
| "帮我在公司政策文档中查一下报销流程" | **RAG** | 简单检索，不需要写回 |
| "帮我管理几千条人脉关系，查谁投了谁" | **GBrain** | 关系查询是图谱的强项 |
| "帮我在长期对话中记住所有项目细节" | **LLM_WIKI** | 需要持续写入+更新 |
| "搭建企业级知识问答系统" | **RAG + Rerank** | 成熟、可控、可扩展 |
| "个人知识大脑，越用越聪明" | **GBrain** | 自动建图+梦境循环 |
| "AI助手需要记住我说过的所有事" | **LLM_WIKI** | 三层记忆架构 |

> ✋ **费曼自测**：如果你是 YC 的总裁，管理4000+创始人档案，为什么选 GBrain 而不是 RAG？

---

### 🍅 番茄钟4结束，休息5分钟

**实战核心洞见：**
- RAG 适合"一问一答"的检索场景
- GBrain 适合"关系密集"的知识管理场景
- LLM_WIKI 适合"需要记忆"的长期交互场景
- 三者不是替代关系，而是**互补关系**

---

## 番茄钟5：综合对比与选型指南（25分钟）

### 5.1 GitHub 仓库与生态

| 项目 | GitHub | Stars | 语言 | 许可证 |
|------|--------|-------|------|--------|
| RAG（框架） | LangChain, LlamaIndex 等 | 各10k-90k | Python | MIT |
| GBrain | [garrytan/gbrain](https://github.com/garrytan/gbrain) | 21,900+ | TypeScript | MIT |
| MemGPT/Letta | [cpacker/MemGPT](https://github.com/cpacker/MemGPT) | 13,000+ | Python | Apache 2.0 |
| Khoj | [khoj-ai/khoj](https://github.com/khoj-ai/khoj) | 26,000+ | Python | AGPL |

---

### 5.2 终极对比表（7维度）

| 维度 | RAG | GBrain | LLM_WIKI |
|------|-----|--------|----------|
| **核心理念** | 检索增强生成 | 个人知识大脑 | LLM读写记忆 |
| **知识流向** | 只读(Read-Only) | 读写+自动进化 | 读写(Read-Write) |
| **检索精度** | 中（纯向量/混合） | 高（+31% P@5） | 中（依赖记忆管理） |
| **知识关联** | 无（扁平chunk） | 自动知识图谱 | 隐式关联 |
| **自动维护** | 无 | Dream Cycle | LLM自主管理 |
| **部署难度** | ⭐ | ⭐⭐ | ⭐⭐⭐ |
| **学习曲线** | 平缓 | 中等 | 陡峭 |
| **适用规模** | 小-大 | 个人-团队 | 个人 |
| **中文支持** | 好（BGE系列） | 一般（英文优先） | 好（依赖LLM） |
| **Obsidian集成** | 无原生 | 支持wikilink | Khoj支持 |

---

### 5.3 消融实验：GBrain 为什么比纯RAG高31%？

BrainBench 基准测试结果（240页语料）：

| 策略 | P@5 | R@5 | 说明 |
|------|-----|-----|------|
| 纯 BM25 | ~18 | ~75 | 精确词法匹配 |
| 纯向量 RAG | ~18 | ~80 | 标准RAG实现 |
| 混合+RRF（无图） | ~18 | ~85 | GBrain禁用图 |
| **GBrain全栈** | **49.1** | **97.9** | **图+提取质量** |

**关键发现：**
- 纯向量 vs 纯BM25：差异不大！
- 混合检索：召回率提升，但精度仍低
- **知识图谱是精度跃升的关键**——从18到49.1，翻了近3倍
- 图不是边际特性，而是**承重墙**

---

### 5.4 选型决策树

```
你需要什么？
│
├─ "我只是想查文档，不需要AI记住什么"
│  └─ ✅ 选 RAG（简单、成熟、可控）
│
├─ "我需要管理大量关联知识，越用越聪明"
│  ├─ 关系密集（人脉、投资、组织）
│  │  └─ ✅ 选 GBrain
│  └─ 长期对话记忆
│     └─ ✅ 选 LLM_WIKI (MemGPT)
│
├─ "我需要企业级部署"
│  └─ ✅ 选 RAG + Milvus/Chroma + Rerank
│
└─ "我想从零开始，轻量实现"
   └─ ✅ RAG（LangChain + FAISS + 本地Embedding）
```

---

### 5.5 最佳实践清单

**✅ 应该做的：**
- 先从 RAG 入门，理解"检索→增强→生成"的管道
- 切块策略根据文档类型调整（法律≠文学≠代码）
- 混合搜索（向量+BM25）是 RAG 的标配优化
- GBrain 的 Dream Cycle 一定要开，这是"复利增长"的来源
- LLM_WIKI 的 Core Memory 不要塞太多，留给最关键的信息
- 中文场景优先用 BGE 系列 Embedding
- 定期评估检索质量（GBrain 的 eval 工具很好用）

**❌ 避免做的：**
- 不要用固定字符数切法律文档（法条会断裂）
- 不要期望 RAG 能"记住"你上次说了什么（它是无状态的）
- 不要忽略 Rerank——这是精度提升最便宜的优化
- 不要在 GBrain 里手动建图（自动建图才是正道）
- 不要把所有知识塞进一个向量库（按分类拆子库）
- 不要忽略 API 成本——LLM 重排序虽然效果好但贵

---

### 🍅 番茄钟5结束，休息5分钟

**终极洞见：**
- RAG 是基础，所有知识库方案都包含 RAG 的核心管道
- GBrain = RAG + 知识图谱 + 梦境循环（RAG的超集）
- LLM_WIKI = RAG + 写回能力（不同方向的扩展）
- 三者的未来趋势是**融合**：RAG 加图谱能力、GBrain 加写回能力、LLM_WIKI 加图谱
- **你的 ideal 知识库** 已经具备 LLM_WIKI 的雏形（三层记忆），未来可集成 GBrain 的图谱能力

---

## 附录A：命令速查卡

### RAG 常用命令

| 命令/操作 | 功能 |
|-----------|------|
| `pip install langchain chromadb` | 安装基础依赖 |
| `RecursiveCharacterTextSplitter(chunk_size=800)` | 文本切块 |
| `Chroma.from_documents(docs, embeddings)` | 构建向量库 |
| `vectordb.similarity_search(query, k=3)` | 相似度搜索 |
| `load_qa_chain(llm, chain_type="stuff")` | 加载问答链 |

### GBrain 常用命令

| 命令 | 功能 |
|------|------|
| `gbrain init --pglite` | 初始化大脑 |
| `gbrain doctor` | 健康检查 |
| `gbrain search "query"` | 搜索知识 |
| `gbrain put-page "title" --content "..."` | 写入页面 |
| `gbrain graph-query "entity" --depth 2` | 图谱查询 |
| `gbrain dream` | 梦境循环 |
| `gbrain sync --repo ~/brain` | 同步知识 |
| `gbrain serve` | 启动MCP服务 |

### LLM_WIKI (MemGPT) 常用函数

| 函数 | 功能 |
|------|------|
| `archival_memory_insert(text)` | 写入长期记忆 |
| `archival_memory_search(query)` | 检索长期记忆 |
| `core_memory_replace(old, new)` | 更新核心记忆 |
| `conversation_search(query)` | 搜索对话历史 |

---

## 附录B：技术栈速查

| 层 | RAG | GBrain | LLM_WIKI |
|----|-----|--------|----------|
| 运行时 | Python | Bun + TypeScript | Python |
| 数据库 | FAISS/Chroma/Milvus | PGLite/Postgres+pgvector | 自定义存储 |
| 向量搜索 | 各Embedding模型 | HNSW (pgvector) | 语义搜索 |
| 关键词搜索 | BM25（可选） | BM25 (tsvector) | 无 |
| 知识图谱 | 无 | 自动建图 | 无 |
| 重排序 | Jina/bge-reranker | zerank-2 | 无 |
| Agent集成 | LangChain/LlamaIndex | MCP Server | 自定义 |

---

## 附录C：相关课程笔记

- [[AI系统学习课/复习试卷/5-RAG技术与应用|5-RAG技术与应用]]
- [[AI系统学习课/复习试卷/6-RAG高级技术与实践|6-RAG高级技术与实践]]
- [[AI系统学习课/复习试卷/25-项目实战：企业知识库|25-项目实战：企业知识库]]
- [[Clippings/Bilibili/2026-06-10-GBrain本地部署+实操演示，从零跑通YC总裁同款AI知识引擎，12步检索流水线+知识图谱构建+夜间自动维护 比传统RAG精度高出31个百分点|GBrain本地部署+实操演示]]
- [[Hermes接入自建MD海量书库全流程方案（从LLM知识库组件→完整落地，适配数千本MD格式藏书：心理_地缘_法律_文学_写作_影视）|Hermes接入自建MD海量书库全流程方案]]

---

## 学习自检清单

- [ ] **番茄1：** 能用一句话说清 RAG、GBrain、LLM_WIKI 各自是什么
- [ ] **番茄1：** 能解释 RAG 是"只读"的，LLM_WIKI 是"读写"的
- [ ] **番茄2：** 能画出 RAG 的线性管道架构
- [ ] **番茄2：** 能说出 GBrain 四策略协同的检索方式
- [ ] **番茄2：** 能解释 LLM_WIKI 的三层记忆模型
- [ ] **番茄3：** 能独立搭建一个基础 RAG 系统
- [ ] **番茄3：** 能配置 GBrain 的 PGLite 初始化和 API Key
- [ ] **番茄4：** 能说出 GBrain Dream Cycle 的8个阶段
- [ ] **番茄4：** 能根据场景选择合适的知识库方案
- [ ] **番茄5：** 能解释 GBrain 为什么比纯 RAG 精度高31%
- [ ] **番茄5：** 能使用选型决策树做出技术选型决策

---

> **下一步推荐学习：**
> - 深入实践：[[AI系统学习课/复习试卷/6-RAG高级技术与实践|RAG高级技术]]
> - 动手部署：[[Clippings/Bilibili/2026-06-10-GBrain本地部署+实操演示，从零跑通YC总裁同款AI知识引擎，12步检索流水线+知识图谱构建+夜间自动维护 比传统RAG精度高出31个百分点|GBrain本地部署实操]]
> - 知识图谱入门：学习 Neo4j 或 pgvector 的图谱功能
