---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#番茄学习法"
  - "#综合实战"
  - "#RAG"
  - "#Agent"
  - "#部署"
  - "#Day23"
aliases:
  - 综合实战-构建AI系统
  - Day23-全栈实战
---

# Day23：构建你的第一个AI系统——全栈实战

> 🍅 番茄111-115 | Part 6：综合实战与未来

---

## 案件档案

| 字段 | 值 |
|:-----|:---|
| **案件编号** | DAY23-终极探案 |
| **案发时间** | 第23天 |
| **番茄时段** | 111-115 |
| **案发地点** | 从本地到云端 |
| **核心谜题** | 如何把所有学过的知识组合成一个真正可用的AI系统？ |
| **涉案工具** | LangChain、ChromaDB、MCP、Cloudflare Workers、Docker |

---

## 🔪 悬疑开场：侦探的最后一案

你已经走过了22天、110个番茄。

你学过二进制如何变成编程语言，Python如何操作数据，算法如何解决问题——那是你**锻造武器**的日子。

你学过机器学习如何从数据中寻找规律，神经网络如何模拟大脑，Transformer如何让AI理解语言——那是你**学习作案手法**的日子。

你学过Prompt Engineering如何与AI对话，RAG如何让AI拥有知识，Agent如何自主决策——那是你**模拟探案**的日子。

你学过Claude Code如何帮你写代码，n8n如何编排工作流，视频生成如何创造世界——那是你**装备武器库**的日子。

**现在，是时候了。**

就像侦探小说里的最后一章——所有线索汇聚一处，所有伏笔同时引爆。

今天，你要亲手构建一个完整的AI系统。

不是"hello world"，不是一个Jupyter Notebook，不是一个实验脚本——

是一个**真正能上线、能服务用户、能解决实际问题的AI系统**。

这是一个"AI知识库助手"。它能回答关于你公司产品的问题，能查询数据库，能发送邮件，能调用API。

它有一个漂亮的前端界面，一个聪明的RAG大脑，一个能自主使用工具的Agent灵魂。

它运行在云端，24小时在线，有监控，有日志，有评估。

**欢迎来到终极探案。今天没有理论，只有实战。**

---

## 🍅 番茄111：项目规划——我们要做什么

### 犯罪现场：需求分析

想象你是一家电商公司的CTO。你的团队每天被同样的问题淹没：

> "这个订单什么时候发货？"
> "我的退款处理了吗？"
> "你们的产品和XX有什么区别？"
> "你们的退货政策是什么？"

你的客服团队疲于奔命，但回答效率低下。你需要一个**AI知识库助手**。

**功能需求：**

| 需求 | 优先级 | 说明 |
|:-----|:-------|:-----|
| 知识问答 | P0 | 回答产品、政策、FAQ相关问题 |
| 订单查询 | P1 | 查订单状态、物流信息 |
| 退款处理 | P2 | 查询退款进度、发起退款 |
| 邮件通知 | P2 | 自动发送确认邮件 |
| 人工转接 | P1 | 无法回答时转人工 |
| 多轮对话 | P0 | 记住上下文，连续对话 |

### 作案手法：技术选型

```
┌─────────────────────────────────────────────────────────────────────┐
│               AI知识库助手 · 系统架构                              │
│                                                                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────────┐                  │
│  │  用户     │    │  前端     │    │   API网关     │                  │
│  │ (浏览器)  │───▶│ (React)  │───▶│ (FastAPI)    │                  │
│  └──────────┘    └──────────┘    └──────┬───────┘                  │
│                                          │                          │
│         ┌────────────────────────────────┼──────────────────┐       │
│         │               AI 核心层        │                  │       │
│         │                                ▼                  │       │
│         │  ┌─────────────────────────────────────────┐      │       │
│         │  │         Agent 调度器 (LangChain)         │      │       │
│         │  │  ┌──────────┐ ┌──────────┐ ┌────────┐  │      │       │
│         │  │  │  RAG     │ │ 工具调用  │ │ 记忆   │  │      │       │
│         │  │  │  检索    │ │(MCP协议) │ │ 管理   │  │      │       │
│         │  │  └────┬─────┘ └────┬─────┘ └───┬────┘  │      │       │
│         │  └───────┼─────────────┼───────────┼──────┘      │       │
│         └──────────┼─────────────┼───────────┼─────────────┘       │
│                    │             │           │                       │
│                    ▼             ▼           ▼                       │
│  ┌───────────────────┐  ┌──────────┐  ┌──────────┐                │
│  │  向量数据库        │  │  关系数据库│  │  LLM     │                │
│  │  (ChromaDB)       │  │(SQLite)  │  │(Claude) │                │
│  └───────────────────┘  └──────────┘  └──────────┘                │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │  部署 & 监控层                                            │       │
│  │  Docker / Cloudflare Workers / Sentry / Prometheus      │       │
│  └─────────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────────┘
```

**技术栈决策：**

| 组件 | 选择 | 理由 |
|:-----|:-----|:------|
| 语言 | Python 3.12 | AI生态最成熟 |
| Web框架 | FastAPI | 异步+高性能 |
| 前端 | React + Tailwind | 快速构建 |
| LLM | Claude API | 最强推理能力 |
| 向量库 | ChromaDB | 轻量级、嵌入简单 |
| Agent框架 | LangChain | 生态最完善 |
| 工具协议 | MCP | 标准化工具接口 |
| 部署 | Docker + Cloudflare Workers | 成本可控 |

### 🔍 侦探笔记：架构设计原则

1. **关注点分离**：前端/API/AI核心/数据各层独立
2. **可扩展性**：每个组件都可独立替换
3. **可观测性**：每个环节都有日志和指标
4. **渐进式复杂度**：先跑通核心流程，再添加功能

---

## 🍅 番茄112：数据准备与Embedding

### 犯罪现场：知识从哪里来？

AI系统需要"知识"。但这些知识以各种形式存在：
- 公司内部的Word文档、PDF
- 产品FAQ页面
- 客户服务历史记录
- 内部Wiki/知识库

我们的第一步——把非结构化文档变成AI能理解和检索的格式。

### 作案手法：文档流水线

```
原始文档 → 加载 → 分块 → Embedding → 存储向量库
                         ↓
                   每个块 ≈ 500 tokens
                   块与块重叠 ≈ 50 tokens
                   元数据保留（来源、页码、时间）
```

### 动手实战：完整数据流水线代码

```python
# pipeline.py — 数据准备流水线
# 安装依赖：pip install langchain chromadb tiktoken pypdf

import os
from pathlib import Path
from typing import List

from langchain_community.document_loaders import (
    PyPDFLoader,
    TextLoader,
    UnstructuredMarkdownLoader,
)
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma
from langchain.schema import Document

# ─── 配置 ───────────────────────────────────────
VECTOR_STORE_DIR = "./data/vector_store"
DOCS_DIR = "./data/documents"
CHUNK_SIZE = 500        # 每块大小（tokens）
CHUNK_OVERLAP = 50      # 块之间重叠

# ─── 文档加载器工厂 ─────────────────────────────
def load_document(file_path: str) -> List[Document]:
    """根据文件类型自动选择加载器"""
    ext = Path(file_path).suffix.lower()
    
    if ext == ".pdf":
        loader = PyPDFLoader(file_path)
    elif ext == ".txt":
        loader = TextLoader(file_path, encoding="utf-8")
    elif ext == ".md":
        loader = UnstructuredMarkdownLoader(file_path)
    else:
        raise ValueError(f"不支持的文件类型: {ext}")
    
    return loader.load()

def load_all_documents(docs_dir: str) -> List[Document]:
    """加载目录下所有支持的文档"""
    all_docs = []
    supported = {".pdf", ".txt", ".md"}
    
    for file_path in Path(docs_dir).rglob("*"):
        if file_path.suffix.lower() in supported:
            print(f"  加载: {file_path}")
            docs = load_document(str(file_path))
            all_docs.extend(docs)
    
    return all_docs

# ─── 文档分块 ──────────────────────────────────
def split_documents(documents: List[Document]) -> List[Document]:
    """将文档切分成适合检索的块"""
    splitter = RecursiveCharacterTextSplitter(
        chunk_size=CHUNK_SIZE,
        chunk_overlap=CHUNK_OVERLAP,
        separators=["\n\n", "\n", "。", ".", " ", ""],
        length_function=len,
    )
    
    chunks = splitter.split_documents(documents)
    print(f"  分块完成: {len(documents)} 文档 → {len(chunks)} 块")
    return chunks

# ─── Embedding & 存储 ──────────────────────────
def embed_and_store(chunks: List[Document], persist_dir: str):
    """生成Embedding并存入向量数据库"""
    embedding = OpenAIEmbeddings(
        model="text-embedding-3-small",  # 1536维，性价比最优
    )
    
    vector_store = Chroma.from_documents(
        documents=chunks,
        embedding=embedding,
        persist_directory=persist_dir,
    )
    
    vector_store.persist()
    print(f"  ✓ 向量库已保存: {persist_dir}")
    return vector_store

# ─── 主流水线 ──────────────────────────────────
def run_pipeline():
    """完整数据流水线"""
    print("=" * 50)
    print("📦 AI知识库助手 - 数据流水线")
    print("=" * 50)
    
    # Step 1: 加载文档
    print("\nStep 1/3: 加载文档...")
    docs = load_all_documents(DOCS_DIR)
    print(f"  共加载 {len(docs)} 页/段文档")
    
    # Step 2: 分块
    print("\nStep 2/3: 切分文档...")
    chunks = split_documents(docs)
    
    # Step 3: Embedding + 存储
    print("\nStep 3/3: 生成Embedding并存入...")
    vector_store = embed_and_store(chunks, VECTOR_STORE_DIR)
    
    print("\n" + "=" * 50)
    print("✅ 数据流水线完成！")
    print(f"  - 原始文档: {len(docs)} 段")
    print(f"  - 处理后块: {len(chunks)} 块")
    print(f"  - 向量维度: 1536")
    print(f"  - 存储位置: {VECTOR_STORE_DIR}")
    print("=" * 50)

if __name__ == "__main__":
    run_pipeline()
```

**运行方式：**
```bash
# 设置OpenAI API Key（Embedding用）
export OPENAI_API_KEY="sk-xxx"

# 准备文档
mkdir -p data/documents
# 把 PDF/文档放入 data/documents/

# 运行流水线
python pipeline.py
```

### 🔍 侦探笔记：为什么这样做？

| 决策 | 为什么 |
|:-----|:-------|
| `RecursiveCharacterTextSplitter` | 智能分割，优先在段落/句子边界切割 |
| 块大小500 tokens | 既保留上下文，又足够精准 |
| 重叠50 tokens | 避免关键信息刚好在边界被切断 |
| `text-embedding-3-small` | 性价比最高的Embedding模型 |

---

## 🍅 番茄113：检索与生成流水线

### 犯罪现场：从提问到回答

用户问："你们支持退货吗？"

这个简单的问题背后，AI需要完成：

1. **理解问题**：用户想知道退货政策
2. **检索知识**：从向量库中找到相关文档块
3. **组装上下文**：把检索到的知识拼成上下文
4. **生成回答**：基于上下文+用户问题，生成自然回答

这就是 **RAG（Retrieval-Augmented Generation）**。

### 作案手法：RAG查询引擎

```
用户问题 "你们支持退货吗？"
       │
       ▼
┌──────────────────┐
│  Step 1: Query   │  "退货政策" → Embedding → 向量检索
│    Embedding     │
└────────┬─────────┘
         │ top_k = 5 个相关块
         ▼
┌──────────────────┐
│  Step 2: 检索    │  向量库 → 返回最相似的文档块
│   相似度搜索     │  附带相似度分数
└────────┬─────────┘
         │ 文档块 + 分数
         ▼
┌──────────────────┐
│  Step 3: Context │  模板化组装：
│   组装           │  "根据以下信息回答：\n{chunks}"
└────────┬─────────┘
         │ 完整 Prompt
         ▼
┌──────────────────┐
│  Step 4: LLM     │  Claude API → 生成最终回答
│   生成           │  带引用来源
└────────┬─────────┘
         │ 最终回答
         ▼
┌──────────────────┐
│  Step 5: 输出    │  "当然！我们支持30天内无理由退货...
│    + 引用        │  来源：退货政策文档 §2.1"
└──────────────────┘
```

### 动手实战：RAG查询引擎代码

```python
# rag_engine.py — RAG查询引擎

from typing import List, Tuple, Optional
from dataclasses import dataclass

from langchain_community.vectorstores import Chroma
from langchain_community.embeddings import OpenAIEmbeddings
from langchain_community.chat_models import ChatOpenAI  # 可用 Claude API 替代
from langchain.prompts import ChatPromptTemplate
from langchain.schema import Document

# ─── 数据结构 ──────────────────────────────────
@dataclass
class RetrievalResult:
    """检索结果"""
    answer: str
    sources: List[dict]
    confidence: float

@dataclass
class QueryConfig:
    """查询配置"""
    vector_store_dir: str = "./data/vector_store"
    embedding_model: str = "text-embedding-3-small"
    llm_model: str = "gpt-4o"  # 或 "claude-3-opus"
    top_k: int = 5
    similarity_threshold: float = 0.6
    temperature: float = 0.3
    max_tokens: int = 1024

# ─── 提示词模板 ───────────────────────────────
SYSTEM_PROMPT = """你是一个专业的AI知识库助手。
你的任务是基于提供的参考信息，准确回答用户问题。

## 核心原则
1. **只基于提供的参考信息回答**
2. **如果参考信息不足以回答，明确说不知道**
3. **引用信息来源**
4. **用清晰、友好的语言回答**

## 参考信息
{context}
"""

def build_rag_prompt(query: str, chunks: List[Document]) -> str:
    """构建RAG提示词"""
    # 组装上下文
    context_parts = []
    for i, chunk in enumerate(chunks, 1):
        source = chunk.metadata.get("source", "未知来源")
        context_parts.append(
            f"[来源{i}] (来自: {source})\n{chunk.page_content}\n"
        )
    
    context = "\n---\n".join(context_parts)
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", SYSTEM_PROMPT),
        ("human", "问题: {query}\n\n请基于参考信息回答。")
    ])
    
    return prompt.format_messages(context=context, query=query)

# ─── RAG引擎 ──────────────────────────────────
class RAGEngine:
    """RAG查询引擎"""
    
    def __init__(self, config: Optional[QueryConfig] = None):
        self.config = config or QueryConfig()
        
        # 初始化Embedding
        self.embedding = OpenAIEmbeddings(
            model=self.config.embedding_model,
        )
        
        # 初始化向量库
        self.vector_store = Chroma(
            persist_directory=self.config.vector_store_dir,
            embedding_function=self.embedding,
        )
        
        # 初始化LLM
        self.llm = ChatOpenAI(
            model=self.config.llm_model,
            temperature=self.config.temperature,
            max_tokens=self.config.max_tokens,
        )
        
        print(f"  ✓ RAG引擎初始化完成")
        print(f"  - 向量库: {self.config.vector_store_dir}")
        print(f"  - Embedding: {self.config.embedding_model}")
        print(f"  - LLM: {self.config.llm_model}")
    
    def retrieve(self, query: str) -> List[Tuple[Document, float]]:
        """检索相关文档"""
        results = self.vector_store.similarity_search_with_relevance_scores(
            query,
            k=self.config.top_k,
        )
        
        # 过滤低相关度结果
        filtered = [
            (doc, score) for doc, score in results
            if score >= self.config.similarity_threshold
        ]
        
        return filtered
    
    def answer(self, query: str) -> RetrievalResult:
        """完整RAG查询→回答流程"""
        # Step 1: 检索
        results = self.retrieve(query)
        
        if not results:
            return RetrievalResult(
                answer="抱歉，我没有找到与您问题相关的信息。请尝试换个方式提问，或联系人工客服。",
                sources=[],
                confidence=0.0,
            )
        
        # Step 2: 提取文档
        chunks = [doc for doc, _ in results]
        scores = [score for _, score in results]
        avg_confidence = sum(scores) / len(scores)
        
        # Step 3: 构建提示词
        messages = build_rag_prompt(query, chunks)
        
        # Step 4: LLM生成
        response = self.llm.invoke(messages)
        
        # Step 5: 组装结果
        sources = [
            {
                "content": doc.page_content[:200] + "...",
                "source": doc.metadata.get("source", "未知"),
                "relevance": round(score, 3),
            }
            for doc, score in results[:3]  # 最多3条引用
        ]
        
        return RetrievalResult(
            answer=response.content,
            sources=sources,
            confidence=round(avg_confidence, 3),
        )

# ─── 使用示例 ──────────────────────────────────
def demo():
    print("=" * 50)
    print("🤖 AI知识库助手 - RAG查询引擎DEMO")
    print("=" * 50)
    
    engine = RAGEngine()
    
    test_queries = [
        "你们支持退货吗？多久能退款？",
        "产品质保期是多久？",
        "怎么联系人工客服？",
    ]
    
    for query in test_queries:
        print(f"\n\n📝 用户: {query}")
        print("-" * 40)
        
        result = engine.answer(query)
        
        print(f"\n🤖 助手: {result.answer}")
        print(f"\n📊 置信度: {result.confidence}")
        
        if result.sources:
            print("\n📚 参考来源:")
            for src in result.sources:
                print(f"  - {src['source']} (相关度: {src['relevance']})")
    
    print("\n" + "=" * 50)

if __name__ == "__main__":
    demo()
```

### 🔍 侦探笔记：RAG前世今生

RAG最早由Lewis等人在2020年提出（论文《Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks》），本质上是用**检索**弥补**生成模型知识有限**的缺陷。

传统LLM的局限：
- 知识截止于训练数据时间点
- 无法访问私有知识库
- 会产生"幻觉"（胡编乱造）

RAG的解决方案：
- 不依赖模型记住所有知识
- 实时从向量库检索最新信息
- 答案可追溯、可验证

---

## 🍅 番茄114：Agent化——给知识库加上工具

### 犯罪场景：AI不能只是"知道"，还要能"做"

用户问："帮我查一下订单OD20240615001的状态。"

仅仅"知道"不够——你需要去数据库查。

用户问："能把这个退款申请的确认邮件发给我吗？"

仅仅"知道"不够——你需要调用邮件API。

**知识库助手 → AI Agent**：从被动回答到主动行动。

### 作案手法：Function Calling + MCP协议

Function Calling（函数调用）是让LLM能够调用外部工具的机制。核心流程：

```
用户: "查订单OD20240615001""
       │
       ▼
┌────────────────────────────┐
│  LLM：意图识别              │
│  "用户要查询订单"           │
│  匹配到工具: query_order()  │
└──────────┬─────────────────┘
           │ 返回函数调用请求
           ▼
┌────────────────────────────┐
│  Agent调度器：执行函数      │
│  query_order("OD20240615001")│
│  → 返回订单状态             │
└──────────┬─────────────────┘
           │ 函数执行结果
           ▼
┌────────────────────────────┐
│  LLM：生成回答              │
│  "订单OD20240615001当前    │
│   状态为：已发货，预计     │
│   6月18日到达"              │
└────────────────────────────┘
```

**MCP协议**（Model Context Protocol）是Anthropic推出的标准化工具协议。它定义了AI和外部工具之间的统一接口，让工具可插拔、可复用。

### 动手实战：MCP工具定义与Agent实现

```python
# agent.py — 基于MCP的AI Agent

import json
from typing import Any, Callable, Dict, List, Optional
from dataclasses import dataclass, field

# ─── MCP工具定义 ──────────────────────────────
@dataclass
class MCPTool:
    """MCP工具定义"""
    name: str
    description: str
    parameters: Dict[str, Any]  # JSON Schema格式
    handler: Callable  # 实际执行函数

class MCPRegistry:
    """MCP工具注册中心"""
    
    def __init__(self):
        self._tools: Dict[str, MCPTool] = {}
    
    def register(self, tool: MCPTool):
        """注册工具"""
        self._tools[tool.name] = tool
        print(f"  ✓ 工具已注册: {tool.name}")
    
    def get_tool(self, name: str) -> Optional[MCPTool]:
        return self._tools.get(name)
    
    def get_tools_schema(self) -> List[Dict]:
        """返回OpenAI Function Calling格式的工具定义"""
        return [
            {
                "type": "function",
                "function": {
                    "name": tool.name,
                    "description": tool.description,
                    "parameters": tool.parameters,
                },
            }
            for tool in self._tools.values()
        ]
    
    def execute(self, name: str, arguments: Dict) -> Any:
        """执行工具"""
        tool = self.get_tool(name)
        if not tool:
            raise ValueError(f"未知工具: {name}")
        return tool.handler(**arguments)

# ─── 数据库工具 ────────────────────────────────
# 模拟数据库
FAKE_DB = {
    "OD20240615001": {"status": "已发货", "eta": "2026-06-18", "items": ["AI教程套餐"]},
    "OD20240615002": {"status": "处理中", "eta": "2026-06-20", "items": ["会员订阅"]},
    "OD20240614005": {"status": "已签收", "eta": "2026-06-14", "items": ["电子书套装"]},
    "RF2024060001": {"status": "审核中", "amount": 299, "submit_date": "2026-06-13"},
    "RF2024060002": {"status": "已退款", "amount": 159, "submit_date": "2026-06-10"},
}

def query_order(order_id: str) -> str:
    """查询订单状态"""
    order = FAKE_DB.get(order_id.upper())
    if not order:
        return json.dumps({"error": "订单不存在"})
    return json.dumps(order)

def query_refund(refund_id: str) -> str:
    """查询退款进度"""
    refund = FAKE_DB.get(refund_id.upper())
    if not refund:
        return json.dumps({"error": "退款申请不存在"})
    return json.dumps(refund)

def send_email(to: str, subject: str, body: str) -> str:
    """发送邮件（模拟）"""
    print(f"\n  📧 [模拟] 发送邮件:")
    print(f"     收件人: {to}")
    print(f"     主题: {subject}")
    print(f"     内容: {body[:100]}...")
    return json.dumps({"status": "sent", "to": to})

# ─── Agent系统 ────────────────────────────────
class Agent:
    """AI Agent - 带工具调用的智能体"""
    
    def __init__(self, rag_engine, llm_client):
        self.rag_engine = rag_engine
        self.llm = llm_client
        self.mcp = MCPRegistry()
        self._register_default_tools()
        
        # 对话历史
        self.conversation_history = []
    
    def _register_default_tools(self):
        """注册默认工具"""
        self.mcp.register(MCPTool(
            name="query_order",
            description="查询订单状态和物流信息",
            parameters={
                "type": "object",
                "properties": {
                    "order_id": {
                        "type": "string",
                        "description": "订单编号，格式如 OD20240615001",
                    }
                },
                "required": ["order_id"],
            },
            handler=query_order,
        ))
        
        self.mcp.register(MCPTool(
            name="query_refund",
            description="查询退款进度",
            parameters={
                "type": "object",
                "properties": {
                    "refund_id": {
                        "type": "string",
                        "description": "退款编号，格式如 RF2024060001",
                    }
                },
                "required": ["refund_id"],
            },
            handler=query_refund,
        ))
        
        self.mcp.register(MCPTool(
            name="send_email",
            description="发送邮件给用户",
            parameters={
                "type": "object",
                "properties": {
                    "to": {"type": "string", "description": "收件人邮箱"},
                    "subject": {"type": "string", "description": "邮件主题"},
                    "body": {"type": "string", "description": "邮件正文"},
                },
                "required": ["to", "subject", "body"],
            },
            handler=send_email,
        ))
    
    def _build_agent_prompt(self, user_query: str) -> str:
        """构建Agent提示词"""
        # 先通过RAG检索相关知识
        rag_results = self.rag_engine.retrieve(user_query)
        
        context = ""
        if rag_results:
            chunks = [doc.page_content for doc, _ in rag_results]
            context = "\n".join(chunks)
        
        return f"""你是AI知识库助手，拥有以下能力：

## 核心能力
1. **知识问答**：基于知识库回答产品、政策相关问题
2. **订单查询**：使用 query_order 工具查订单
3. **退款查询**：使用 query_refund 工具查退款
4. **发送邮件**：使用 send_email 工具发送邮件

## 使用规则
- 对于知识类问题，基于以下参考信息回答
- 对于需要查询的问题，使用对应的工具
- 如果需要调用工具，在回答中明确说明

## 参考信息
{context if context else "(无相关参考信息)"}

## 对话历史
{chr(10).join(self.conversation_history[-6:])}

## 用户问题
{user_query}
"""
    
    def chat(self, user_query: str) -> str:
        """处理用户消息"""
        print(f"\n  🤔 Agent 思考中...")
        
        prompt = self._build_agent_prompt(user_query)
        
        # 调用LLM（这里用模拟）
        response = self._call_llm_with_tools(prompt, user_query)
        
        # 记录历史
        self.conversation_history.append(f"用户: {user_query}")
        self.conversation_history.append(f"助手: {response}")
        
        return response
    
    def _call_llm_with_tools(self, prompt: str, user_query: str) -> str:
        """模拟LLM调用+工具执行（实际用OpenAI/Claude API）"""
        # 在实际系统中，这里会调用LLM的Function Calling接口
        # LLM会决定是否调用工具以及调用哪个工具
        
        # 这里模拟LLM的逻辑判断
        if "订单" in user_query:
            # 提取订单ID（模拟）
            import re
            match = re.search(r'OD\d+', user_query)
            if match:
                result = self.mcp.execute("query_order", {"order_id": match.group()})
                data = json.loads(result)
                if "error" in data:
                    return f"⚠️ 未找到订单 {match.group()}"
                return (
                    f"📦 订单 {match.group()} 查询结果：\n"
                    f"  - 状态：{data['status']}\n"
                    f"  - 预计送达：{data['eta']}\n"
                    f"  - 商品：{', '.join(data['items'])}"
                )
        
        if "退款" in user_query:
            match = re.search(r'RF\d+', user_query)
            if match:
                result = self.mcp.execute("query_refund", {"refund_id": match.group()})
                data = json.loads(result)
                if "error" in data:
                    return f"⚠️ 未找到退款申请 {match.group()}"
                return (
                    f"💰 退款 {match.group()} 进度：\n"
                    f"  - 状态：{data['status']}\n"
                    f"  - 金额：¥{data['amount']}\n"
                    f"  - 提交时间：{data['submit_date']}"
                )
        
        # 默认：RAG知识回答
        rag_result = self.rag_engine.answer(user_query)
        return rag_result.answer


# ─── 启动Agent系统 ────────────────────────────
def start_agent():
    """启动Agent交互式对话"""
    print("=" * 50)
    print("🤖 AI知识库助手 (Agent模式)")
    print("  输入 'exit' 退出")
    print("=" * 50)
    
    # 初始化（实际用真实RAG引擎）
    engine = RAGEngine()
    agent = Agent(engine, llm_client=None)
    
    while True:
        user_input = input("\n👤 你: ").strip()
        if user_input.lower() in ["exit", "quit", "q"]:
            print("👋 再见！")
            break
        
        response = agent.chat(user_input)
        print(f"\n🤖 助手:\n{response}")


if __name__ == "__main__":
    start_agent()
```

### 🔍 侦探笔记：MCP协议的价值

MCP（Model Context Protocol）是Anthropic在2024年底推出的开放协议，它统一了AI和外部工具的交互方式：

```
传统方式：每个工具一个自定义接口 → 维护地狱
MCP方式：统一协议 → 即插即用

MCP工具 = 工具名称 + 描述 + JSON Schema参数 + 执行函数
```

优势：
- **标准化**：所有工具遵循同一接口
- **可发现**：LLM通过描述自动识别合适的工具
- **安全**：工具执行与LLM推理分离
- **可组合**：多个工具可以链式调用

---

## 🍅 番茄115：部署与监控——让系统跑起来

### 犯罪现场：从本地到生产

代码在本地跑得很好。但用户要的是——**7×24小时在线服务**。

部署不是把代码上传到服务器那么简单。你需要考虑：
- 如何保证服务不中断？（高可用）
- 如何应对流量高峰？（弹性伸缩）
- 如何知道系统出问题了？（监控）
- 如何快速定位问题？（日志）
- 如何评估回答质量？（评估）

### 作案手法：Docker部署 + 监控体系

#### 方案一：Docker部署

```dockerfile
# Dockerfile
FROM python:3.12-slim

WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制代码
COPY . .

# 下载向量库（生产环境从云存储拉取）
# RUN aws s3 cp s3://my-bucket/vector_store/ ./data/vector_store/ --recursive

# 暴露端口
EXPOSE 8000

# 启动
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - LOG_LEVEL=INFO
    volumes:
      - ./data:/app/data
    restart: always
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  chromadb:
    image: chromadb/chroma:latest
    ports:
      - "8001:8000"
    volumes:
      - ./chroma_data:/chroma/chroma
    environment:
      - IS_PERSISTENT=TRUE

  # 仅用于开发
  # vector-updater:
  #   build: .
  #   command: python pipeline.py
  #   volumes:
  #     - ./data:/app/data
```

```yaml
# requirements.txt
fastapi==0.111.0
uvicorn[standard]==0.29.0
langchain==0.2.0
langchain-community==0.2.0
chromadb==0.5.0
openai==1.30.0
pypdf==4.2.0
sentence-transformers==2.7.0
python-multipart==0.0.9
prometheus-client==0.20.0
sentry-sdk==2.3.0
```

```python
# main.py — FastAPI主应用
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import logging
import time

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
)
logger = logging.getLogger("knowledge-agent")

app = FastAPI(title="AI知识库助手 API")

# 全局RAG引擎实例（实际从配置加载）
# engine = RAGEngine()
# agent = Agent(engine, llm_client=...)

# ─── 数据模型 ────────────────────────────────
class QueryRequest(BaseModel):
    query: str
    user_id: str = "anonymous"
    conversation_id: str = ""

class QueryResponse(BaseModel):
    answer: str
    sources: list
    confidence: float
    processing_time_ms: float

# ─── API端点 ──────────────────────────────────
@app.get("/health")
async def health_check():
    """健康检查端点"""
    return {"status": "healthy", "timestamp": time.time()}

@app.post("/api/query", response_model=QueryResponse)
async def query(request: QueryRequest):
    """核心查询端点"""
    start_time = time.time()
    logger.info(f"Query from {request.user_id}: {request.query[:50]}...")
    
    try:
        # result = agent.chat(request.query)
        # 模拟处理
        result = {
            "answer": f"这是关于「{request.query}」的回答（模拟）",
            "sources": [
                {"source": "产品文档", "relevance": 0.92},
                {"source": "FAQ", "relevance": 0.85},
            ],
            "confidence": 0.88,
        }
        
        processing_time = (time.time() - start_time) * 1000
        logger.info(f"Query completed in {processing_time:.0f}ms")
        
        return QueryResponse(
            answer=result["answer"],
            sources=result["sources"],
            confidence=result["confidence"],
            processing_time_ms=round(processing_time, 2),
        )
        
    except Exception as e:
        logger.error(f"Query failed: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error")

@app.post("/api/feedback")
async def feedback(query_id: str, rating: int, comment: str = ""):
    """用户反馈收集"""
    logger.info(f"Feedback: query={query_id}, rating={rating}")
    return {"status": "recorded"}
```

#### 方案二：Cloudflare Workers部署（无服务器）

```javascript
// worker.js — Cloudflare Workers 部署
// 轻量级AI Agent，适用于边缘部署

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    
    // CORS
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type',
        },
      });
    }
    
    // 健康检查
    if (url.pathname === '/health') {
      return Response.json({ status: 'ok' });
    }
    
    // 查询接口
    if (url.pathname === '/api/query' && request.method === 'POST') {
      const { query } = await request.json();
      
      // 调用向量数据库（通过Cloudflare Vectorize或D1）
      const vectorResult = await env.VECTORIZE.query(query, { topK: 5 });
      
      // 构建Prompt
      const context = vectorResult.matches
        .map(m => m.metadata.text)
        .join('\n');
      
      // 调用Workers AI
      const aiResult = await env.AI.run('@cf/meta/llama-3-8b-instruct', {
        messages: [
          { role: 'system', content: `基于以下信息回答：\n${context}` },
          { role: 'user', content: query },
        ],
      });
      
      return Response.json({
        answer: aiResult.response,
        sources: vectorResult.matches.map(m => m.metadata.source),
      }, {
        headers: { 'Access-Control-Allow-Origin': '*' },
      });
    }
    
    return new Response('Not Found', { status: 404 });
  },
};
```

#### 监控体系

```python
# monitoring.py — 监控与评估

import time
import json
from collections import defaultdict
from dataclasses import dataclass, field
from typing import Optional

@dataclass
class MetricPoint:
    """单个指标点"""
    timestamp: float
    value: float
    labels: dict = field(default_factory=dict)

class MetricsCollector:
    """指标收集器"""
    
    def __init__(self):
        self.metrics = defaultdict(list)
    
    def record(self, name: str, value: float, labels: dict = None):
        """记录指标"""
        self.metrics[name].append(MetricPoint(
            timestamp=time.time(),
            value=value,
            labels=labels or {},
        ))
    
    def get_average(self, name: str, window_seconds: float = 300) -> Optional[float]:
        """获取最近window_seconds的平均值"""
        now = time.time()
        points = [
            p for p in self.metrics[name]
            if now - p.timestamp <= window_seconds
        ]
        if not points:
            return None
        return sum(p.value for p in points) / len(points)


# ─── LLM回答质量评估 ──────────────────────────
class AnswerEvaluator:
    """评估回答质量"""
    
    @staticmethod
    def evaluate(answer: str, query: str, context: str) -> dict:
        """多维评估"""
        scores = {}
        
        # 1. 相关性：回答是否针对问题
        scores["relevance"] = AnswerEvaluator._check_relevance(answer, query)
        
        # 2. 忠实度：是否基于上下文（而非幻觉）
        scores["faithfulness"] = AnswerEvaluator._check_faithfulness(answer, context)
        
        # 3. 完整性：是否完整回答了问题
        scores["completeness"] = AnswerEvaluator._check_completeness(answer, query)
        
        # 4. 有用性：是否提供了有用信息
        scores["helpfulness"] = AnswerEvaluator._check_helpfulness(answer)
        
        # 综合得分
        scores["overall"] = sum(scores.values()) / len(scores)
        
        return scores
    
    @staticmethod
    def _check_relevance(answer: str, query: str) -> float:
        """检查相关性（简化版，实际可用NLI模型）"""
        # 检查回答是否包含问题中的关键词
        query_keywords = set(query.lower().split()) - {"的", "了", "是", "在", "有", "吗"}
        answer_lower = answer.lower()
        
        matches = sum(1 for kw in query_keywords if kw in answer_lower)
        if len(query_keywords) == 0:
            return 0.5
        return min(matches / len(query_keywords) * 0.8 + 0.2, 1.0)
    
    @staticmethod
    def _check_faithfulness(answer: str, context: str) -> float:
        """检查忠实度（简化版）"""
        if not context:
            return 0.5
        # 检查是否有与上下文矛盾的信息
        # 实际可用事实一致性模型
        return 0.85  # 简化返回
    
    @staticmethod
    def _check_completeness(answer: str, query: str) -> float:
        """检查完整性"""
        # 简单版本：看回答长度是否合理
        if len(answer) < 10:
            return 0.3
        if len(answer) > 500:
            return 1.0
        return len(answer) / 500
    
    @staticmethod
    def _check_helpfulness(answer: str) -> float:
        """检查有用性"""
        # 简单的规则：是否包含具体信息
        indicators = ["是", "否", "可以", "不行", "因为", "所以", "建议", "注意"]
        matches = sum(1 for ind in indicators if ind in answer)
        return min(matches / 3, 1.0)


# ─── 启动评估 ────────────────────────────────
def run_evaluation():
    """运行评估测试集"""
    test_cases = [
        {"query": "退货政策是什么？", "expected_topics": ["退货", "退款", "30天"]},
        {"query": "怎么联系客服？", "expected_topics": ["电话", "邮箱", "在线"]},
    ]
    
    metrics = MetricsCollector()
    evaluator = AnswerEvaluator()
    
    for case in test_cases:
        # 模拟回答
        answer = f"关于「{case['query']}」的回答..."
        context = "退货政策：支持30天内无理由退货..."
        
        scores = evaluator.evaluate(answer, case["query"], context)
        
        metrics.record("relevance", scores["relevance"])
        metrics.record("faithfulness", scores["faithfulness"])
        metrics.record("completeness", scores["completeness"])
        metrics.record("overall", scores["overall"])
        
        print(f"  Query: {case['query']}")
        print(f"  Scores: {json.dumps(scores, indent=2)}")
    
    print(f"\n📊 综合质量评分: {metrics.get_average('overall')}")


if __name__ == "__main__":
    run_evaluation()
```

### 🔍 侦探笔记：生产环境检查清单

```
☐ 安全性
  ☐ API Key轮换
  ☐ 速率限制（Rate Limiting）
  ☐ 输入过滤（防止Prompt Injection）
  ☐ HTTPS启用

☐ 可靠性
  ☐ 健康检查端点
  ☐ 自动重启
  ☐ 优雅关闭
  ☐ 重试机制（指数退避）

☐ 可观测性
  ☐ 结构化日志（JSON格式）
  ☐ 请求追踪（Trace ID）
  ☐ 性能指标（延迟、QPS）
  ☐ 错误告警

☐ 评估
  ☐ 测试集（50-100条QA对）
  ☐ 质量评分流水线
  ☐ 用户反馈收集
  ☐ A/B测试框架

☐ 成本控制
  ☐ LLM Token使用统计
  ☐ API调用配额
  ☐ Embedding缓存
  ☐ 答案缓存（相同问题不重复计算）
```

---

## 🧠 费曼大复习（番茄112-115总复习）

### 30秒讲给外行听

> **番茄111**：我们规划了一个"AI知识库助手"的完整架构——前端、API、RAG引擎、Agent、数据库、监控，像设计一栋大楼的蓝图。
>
> **番茄112**：我们把公司文档（PDF、Word）切成小块（chunk），用AI模型转成数学向量（Embedding），存入专门的知识库（向量数据库）。
>
> **番茄113**：当用户提问时，系统像侦探一样去知识库里搜索最相关的信息，然后让LLM基于这些信息生成回答——这就是RAG。
>
> **番茄114**：我们给AI装上了"手"——通过MCP协议，AI能查数据库、发邮件、调API，从"知道"变成"能做到"。
>
> **番茄115**：最后用Docker把整套系统打包部署到云端，加上监控日志和评估体系，保证7×24小时稳定运行。

### 知识连线

```
今日实战          对应学过的知识          现实应用
───────          ─────────────         ────────
文档分块     ←    Day03 算法思维      →  搜索引擎
Embedding    ←    Day13 Transformer   →  语义搜索
RAG流水线    ←    Day17 RAG深度       →  企业知识库
Agent工具    ←    Day18 Agent架构     →  智能客服
MCP协议      ←    Day21 MCP生态       →  工具集成
Docker部署   ←    Day01 编程思维      →  云原生
```

---

## ❓ 悬疑追问

1. 如果LLM回答错误，Agent应该"承认不知道"还是"主动搜索更多信息"？这个边界在哪儿？
2. MCP协议 vs 传统REST API——前者到底解决了什么核心问题？是技术问题还是标准问题？
3. 你认为RAG系统最大的安全隐患是什么？——提示注入？数据泄露？还是幻觉导致的错误决策？
4. 当一个AI系统能查数据库、发邮件、调用API——它和"真人员工"的边界在哪里？需要什么样的监管？

---

## 📌 刻意练习

### 练习1：扩展你的知识库

**任务**：本地的知识库数据导入
1. 从网络中找一份产品文档或FAQ（任何产品均可）
2. 用今天学的`pipeline.py`导入到ChromaDB
3. 运行`rag_engine.py`测试至少3个问题

### 练习2：自定义MCP工具

**任务**：给Agent添加天气查询工具
1. 找一个免费天气API（如wttr.in）
2. 按照MCPTool格式定义工具
3. 注册到Agent中
4. 测试："今天北京的天气怎么样？"

### 练习3：评估你的系统

**任务**：建立质量评估流水线
1. 准备10个QA测试用例
2. 运行AnswerEvaluator获取质量评分
3. 找出评分最低的2个问题，分析原因
4. 改进知识库或Prompt，让评分提升

### 练习4：部署挑战（可选）

**任务**：部署到生产环境
1. 用Docker Compose启动完整系统
2. 配置健康检查和自动重启
3. 发送10次API请求，查看指标
4. 分享你的部署截图

---

> **下一案预告**：AI能写诗、编程、看病、开车——但它也引发了失业、偏见、深度伪造。这个潘多拉魔盒，我们打开它是对的吗？
>
> 明天是最后一课，也是最重要的一课。不是技术课——是思考课。
>
> 📖 [[Day24-AI安全伦理与未来-毕业大戏]]
