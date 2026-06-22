---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#深度学习"
  - "#Transformer"
  - "#自注意力"
  - "#BERT"
  - "#GPT"
  - "#番茄学习法"
  - "#120番茄"
  - "#Day13"
  - "#Part3"
aliases:
  - Day13 Transformer革命
  - 注意力即一切
  - 番茄61-65
---

# Day13：Transformer革命——注意力即一切 ⚡

> **番茄61-65 · Part 3 深度学习与神经网络**
>
> 🕵️ **悬疑开场**：2017年，一篇叫"Attention Is All You Need"的论文出现——一切都被改变了。
>
> 2017年6月12日，Google的研究团队在arXiv上发布了一篇论文。标题很狂妄：**"注意力就是你所需要的一切"**（Attention Is All You Need）。
>
> 当时没人意识到——这篇论文像一颗原子弹，炸平了之前所有的序列模型。
>
> 不到5年时间：
> - **RNN？** 过时了。
> - **LSTM？** 过时了。
> - **Seq2Seq+Attention？** 过时了。
>
> 取而代之的是一个叫 **Transformer** 的架构。到今天，GPT、BERT、Claude、LLaMA——所有你看得见的AI——都是Transformer的孩子。
>
> **如果你的生命只够理解一个现代AI架构，那就是Transformer。**

---

## 📋 今日番茄概览

| 番茄 | 主题 | 类型 |
|:----:|:----|:----:|
| 🍅61 | Transformer架构全景 | 核心概念 |
| 🍅62 | 自注意力机制——QKV三部曲 | 理论深度 |
| 🍅63 | BERT——双向编码器的力量 | 方法+应用 |
| 🍅64 | GPT系列——单向解码器的进化 | 历史+趋势 |
| 🍅65 | 思维导图+Transformer代码解读 | 实战项目 |

---

## 🍅61 Transformer架构全景——Encoder+Decoder、多头注意力、位置编码

### 🔪 犯罪现场：RNN的"死刑判决书"

> 2017年之前，所有序列模型都依赖RNN或其变体。RNN有一个**本质缺陷**——它是顺序处理的。
>
> 来比较一下：
>
> ```
> RNN处理"我爱北京天安门"：
> "我" → 等待 → "爱" → 等待 → "北京" → 等待 → "天安门"
> ↑ 必须等前一个字处理完，才能处理下一个！
> ↑ 无法并行！
> ↑ 大白鲨的速度，法拉利的胃口！
>
> Transformer处理"我爱北京天安门"：
> "我" "爱" "北京" "天安门"
>  ↑    ↑    ↑      ↑
>  └────┴────┴──────┘
>  ← 同时处理！同时看到所有词！
> ```
>
> **这就是Transformer的第一项革命：并行计算。**

### Transformer架构全景

```
                       输出概率
                          ▲
                          │
                     [Linear + Softmax]
                          ▲
                          │
                    ┌─────────────┐
                    │  Add & Norm  │ ← 残差连接 + 层归一化
                    ├─────────────┤
                    │   FFN(前馈)  │ ← 两层全连接
                    ├─────────────┤
                    │  Add & Norm  │
                    ├─────────────┤
                    │多头注意力层   │ ← 解码器自注意力
                    ├─────────────┤
                    │  Add & Norm  │
                    ├─────────────┤
                    │交叉注意力层   │ ← 关注编码器的输出
               ┌───▶├─────────────┤◀───┐
               │    │  Add & Norm  │    │
               │    ├─────────────┤    │
               │    │   FFN(前馈)  │    │
               │    ├─────────────┤    │
               │    │  Add & Norm  │    │
               │    ├─────────────┤    │
               │    │多头注意力层   │    │
               │    ├─────────────┤    │
               │    │ 位置编码     │    │
               │    ├─────────────┤    │
               │    │  输入嵌入    │    │
               │    └─────────────┘    │
               │         ▲             │
               │         │             │
           输入序列    输出序列(右移)   │
                                        │
               └─── 交叉注意力 ─────────┘
               (编码器全部输出都可用)
```

### Transformer的三大革命性设计

#### 1. 取消RNN，只用注意力

| 设计 | 解决的问题 |
|:-----|:-----------|
| 自注意力（Self-Attention） | 每个词看到所有词，捕获全局依赖 |
| 并行计算 | 所有位置同时处理，训练速度提升100-1000倍 |
| 长程依赖 | 任意两个词之间只有一步之遥（vs RNN的N步） |

#### 2. 位置编码（Positional Encoding）

RNN天然有"位置感"——因为它是顺序处理的。但Transformer同时看所有词——它怎么知道"我"在"爱"前面？

**答案**：给每个词加一个"位置信号"。

```python
import torch
import torch.nn as nn
import math

class PositionalEncoding(nn.Module):
    """
    位置编码：给每个位置的词注入"位置信息"

    使用不同频率的正弦和余弦波：
    - 偶数位置用 sin
    - 奇数位置用 cos

    为什么用正弦波？
    - 可以外推到更长的序列（训练时没见过1000个词，但推理时可以处理）
    - 相邻位置编码相似（位置1和位置2的编码接近）
    - 遥远位置编码不同（位置1和位置100的编码差异明显）
    """
    def __init__(self, d_model, max_len=5000):
        """
        参数:
            d_model: 嵌入维度（Transformer中通常为512或768）
            max_len: 最大序列长度
        """
        super().__init__()

        # 创建位置编码矩阵 [max_len, d_model]
        pe = torch.zeros(max_len, d_model)

        # 位置索引 [0, 1, 2, ..., max_len-1]
        position = torch.arange(0, max_len, dtype=torch.float).unsqueeze(1)

        # 不同维度的频率
        div_term = torch.exp(torch.arange(0, d_model, 2).float() *
                           -(math.log(10000.0) / d_model))

        # 偶数维：sin；奇数维：cos
        pe[:, 0::2] = torch.sin(position * div_term)   # 偶数位置
        pe[:, 1::2] = torch.cos(position * div_term)   # 奇数位置

        # 注册为buffer（不是模型参数，但会随模型移动设备）
        self.register_buffer('pe', pe)

    def forward(self, x):
        """
        参数:
            x: 输入张量 [batch, seq_len, d_model]
        返回:
            加上位置编码后的张量 [batch, seq_len, d_model]
        """
        # 把位置编码加到输入上
        x = x + self.pe[:x.size(1), :]
        return x
```

#### 3. 多头注意力（Multi-Head Attention）

一个注意力头只能学一种"关系模式"。多个头可以学不同的关系：

```
多头注意力 = 用多组QKV并行计算，然后拼接

头1：语法关系（"吃" → "苹果"）          ← 主谓宾关系
头2：指代关系（"它" → "猫"）            ← 代词指代
头3：位置关系（"左" → "右"）            ← 空间关系
头4：语义关系（"医生" → "医院"）        ← 语义关联
...
```

---

### ✅ 费曼三句话（🍅61）

> 1. **Transformer = 把RNN彻底扔掉，只用注意力+位置编码**——每个词同时看到所有词，所有位置并行计算，训练速度飞升。
> 2. **位置编码是给"没有顺序感"的Transformer注入位置信息**——用sin/cos波让模型知道"我在第几个位置"。
> 3. **多头注意力像多个侦探同时查看案情**——一个看时间线，一个看人物关系，一个看动机——然后合并分析结果。

---

## 🍅62 自注意力机制——QKV三部曲

### 🔍 破案突破：每个词都在问"谁和我有关？"

> 自注意力（Self-Attention）是Transformer的心脏。
>
> 想象你在参加一场宴会。你的注意力不是均匀分布在每个人身上——你会关注有趣的人，忽略无聊的人。
>
> 自注意力就是让序列中的每个词做同样的事：**找出序列中"谁"和自己最相关。**

### 自注意力的数学全流程

```python
import torch
import torch.nn as nn
import torch.nn.functional as F
import math

class SelfAttention(nn.Module):
    """
    缩放点积自注意力（Scaled Dot-Product Attention）

    三步走：
    Step 1: 每个词计算 Query, Key, Value
    Step 2: Query × Key → 注意力分数 → softmax → 注意力权重
    Step 3: 注意力权重 × Value → 加权输出
    """
    def __init__(self, d_model=512, d_k=64, d_v=64):
        """
        参数:
            d_model: 模型维度（Transformer中=512）
            d_k: Query/Key的维度（= d_model / num_heads）
            d_v: Value的维度（通常=d_k）
        """
        super().__init__()
        self.d_k = d_k

        # Q, K, V 的线性投影（把d_model映射到d_k/d_v）
        # 每个输入词通过这三个矩阵，得到它的Q、K、V
        self.W_Q = nn.Linear(d_model, d_k)
        self.W_K = nn.Linear(d_model, d_k)
        self.W_V = nn.Linear(d_model, d_v)

    def forward(self, x):
        """
        参数:
            x: 输入序列 [batch, seq_len, d_model]

        返回:
            output: 注意力后的输出 [batch, seq_len, d_v]
        """
        # ---- Step 1: 计算Q, K, V ----
        Q = self.W_Q(x)  # [batch, seq_len, d_k]
        K = self.W_K(x)  # [batch, seq_len, d_k]
        V = self.W_V(x)  # [batch, seq_len, d_v]

        # ---- Step 2: 计算注意力分数 ----
        # Q × K^T：每个词和其他所有词的"相关性"
        # 结果矩阵中 (i,j) = 词i的Query和词j的Key的点积
        # 点积越大 → 词i和词j越相关

        # 为什么要除以 sqrt(d_k) ——缩放？
        # 点积的大小和维度有关。维度越高，点积越大。
        # 如果不缩放，softmax会进入梯度极小的区域。
        # 除以 sqrt(d_k) 让点积的方差稳定在1左右。
        attention_scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(self.d_k)
        # attention_scores: [batch, seq_len, seq_len]
        # 第(i,j)个元素 = 词i"注意"词j的程度（未归一化）

        # ---- Step 3: Softmax归一化为权重 ----
        # 对每一行做softmax：每个词对所有词的注意力权重之和=1
        attention_weights = F.softmax(attention_scores, dim=-1)
        # attention_weights: [batch, seq_len, seq_len]
        # 第(i,j)个元素 = 词i分配给词j的注意力比例

        # ---- Step 4: 加权求和 ----
        # 每个词的输出 = 所有词的V × 对应注意力权重
        # 即：词i的最终表示 = Σ_j (词i对词j的注意力 × 词j的V)
        output = torch.matmul(attention_weights, V)
        # output: [batch, seq_len, d_v]

        return output

# ---- 可视化自注意力 ----
# 句子："The cat sat on the mat because it was tired."
#
# 当我们计算"it"的注意力时：
#
# The:  0.02
# cat:  0.35  ← "it" 最关注 "cat"（指代关系）
# sat:  0.10
# on:   0.03
# the:  0.02
# mat:  0.08
# because: 0.05
# it:  0.15  ← 也看自己
# was:  0.08
# tired:0.12
#
# "it" 的最终表示 ≈ 0.35×"cat" + 0.15×"it" + 0.12×"tired" + ...
# → 模型理解了 "it" 指代 "cat"
```

### 多头注意力（Multi-Head Attention）

```python
class MultiHeadAttention(nn.Module):
    """
    多头注意力 = h个自注意力并行计算，结果拼接

    为什么多头有效？
    单头：只能学到一种关系模式
    多头：每个头关注不同方面的关系

    以"it"为例：
    头1: it → cat（指代关系）
    头2: it → was（语法依赖）
    头3: it → tired（语义关联）
    头4: ...（其他关系）
    """
    def __init__(self, d_model=512, num_heads=8):
        super().__init__()
        self.num_heads = num_heads
        self.d_k = d_model // num_heads  # 每个头的维度
        self.d_model = d_model

        # Q, K, V 的线性投影（一次投影所有头）
        # 输出维度依然是 d_model，然后拆分成 num_heads 份
        self.W_Q = nn.Linear(d_model, d_model)
        self.W_K = nn.Linear(d_model, d_model)
        self.W_V = nn.Linear(d_model, d_model)

        # 输出投影
        self.fc = nn.Linear(d_model, d_model)

    def forward(self, x):
        batch_size, seq_len, _ = x.shape

        # 1. 线性投影 + 拆分成多头的形状
        Q = self.W_Q(x).view(batch_size, seq_len,
                             self.num_heads, self.d_k).transpose(1, 2)
        K = self.W_K(x).view(batch_size, seq_len,
                             self.num_heads, self.d_k).transpose(1, 2)
        V = self.W_V(x).view(batch_size, seq_len,
                             self.num_heads, self.d_k).transpose(1, 2)
        # Q: [batch, num_heads, seq_len, d_k] — 每个头独立计算

        # 2. 每个头独立计算注意力
        # 缩放点积注意力（批量版本）
        scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(self.d_k)
        weights = F.softmax(scores, dim=-1)
        head_output = torch.matmul(weights, V)
        # head_output: [batch, num_heads, seq_len, d_k]

        # 3. 拼接所有头的输出
        concat = head_output.transpose(1, 2).contiguous().view(
            batch_size, seq_len, self.d_model
        )
        # concat: [batch, seq_len, d_model]

        # 4. 最终线性投影
        output = self.fc(concat)

        return output
```

### 自注意力 vs RNN：一张表说清

| 对比维度 | RNN/LSTM | 自注意力 |
|:---------|:---------|:---------|
| **计算方式** | 顺序（依赖前一步结果） | 并行（所有位置同时） |
| **词间距离** | 距离=词数差（越远越弱） | 恒为1步（直接连接） |
| **长程依赖** | ❌ 难以捕获 | ✅ 天然擅长 |
| **计算复杂度** | O(n) 顺序 | O(n²) 并行 |
| **n=100时** | 100步顺序 | 10,000次计算但全并行 |
| **可解释性** | 隐藏状态难解读 | 注意力权重可直接可视化 |
| **图灵完备性** | ✅ 是 | ❌ 需要额外位置编码 |

> **自注意力用O(n²)的计算换来了O(1)的路径长度。**
>
> 对于长序列，这非常有利——远距离依赖不再是问题。Transformer-XL等后续工作通过改进解决了O(n²)的复杂度问题。

---

### ✅ 费曼三句话（🍅62）

> 1. **自注意力就是让每个词"看一遍全部词，找出谁和自己有关"**——Q是"我在找什么"，K是"我有什么"，V是"我分享什么信息"。
> 2. **缩放因子 √d_k 是个精妙的数学技巧**——防止点积值过大把softmax推向极端，让梯度保持良好。
> 3. **多头注意力让模型同时从多个角度理解关系**——一个头看指代，一个头看语法，一个头看语义——构成了丰富的表示。

---

## 🍅63 BERT——双向编码器的力量

### 🔍 悬疑转折：BERT的"猜词"游戏

> 2018年10月，Google发布BERT（Bidirectional Encoder Representations from Transformers）。
>
> 它是Transformer的编码器部分——但做了两件关键的事：
>
> 1. **双向（Bidirectional）**：不像传统语言模型只从左到右看，BERT同时从左右两个方向看
> 2. **Masked Language Model（MLM）**：随机遮盖15%的词，让模型猜——相当于给模型做"完形填空"

### BERT的"侦探训练法"

```
传统语言模型（单向）：
"我__北京天安门" → 只能看到左边的"我" → 猜不出"爱"
"我爱北京__安门" → 只能看到左边的"北京" → 可能猜"天"

BERT（双向）：
"MASK 爱北京天安门" → 能看到右边"爱北京天安门" → 猜"MASK"="我"
"我MASK北京天安门" → 看到左边"我"和右边"北京天安门" → 猜"MASK"="爱"
"我爱北京MASK安门" → 看到两边 → 猜"MASK"="天"
```

**BERT的预训练 = 做海量的完形填空**

```python
# BERT的Masked Language Model (MLM) 示意

# 输入句子：
original = "I love Beijing Tiananmen"

# 随机遮盖15%的词：
masked = "I [MASK] Beijing [MASK]"
#                                                                     
# BERT的任务：基于上下文，预测被遮盖的词
# [MASK] 位置1 → "love"    (基于 I, Beijing, Tiananmen)  
# [MASK] 位置2 → "Tiananmen" (基于 I, love, Beijing)
#
# 这就是"双向"的含义：
# "love" 的预测依赖于右边的 "Beijing" 和左边的 "I"
```

### BERT的第二个训练任务：下一句预测（NSP）

除了完形填空，BERT还训练了一个"句子关系"任务：

```python
# 输入：
# [CLS] 我 爱 北京 天安门 [SEP] 北京 是 中国 的 首都 [SEP]
# 标签：IsNextSentence (1)

# [CLS] 我 爱 北京 天安门 [SEP] 企鹅 生活在 南极 [SEP]  
# 标签：NotNextSentence (0)
#
# [CLS] 特殊标记 → 它的输出被用来做分类任务
```

### BERT的应用：迁移学习的新范式

```python
# ---- 用Hugging Face加载BERT做文本分类 ----
# pip install transformers

from transformers import BertTokenizer, BertForSequenceClassification
import torch

# 一行代码加载预训练BERT（110M参数的基础版）
# 它会自动下载在数十亿文本上预训练好的权重
tokenizer = BertTokenizer.from_pretrained('bert-base-chinese')
model = BertForSequenceClassification.from_pretrained(
    'bert-base-chinese',
    num_labels=2  # 二分类：正面/负面
)

# 输入文本
texts = ["这个电影太好看啦！", "真的很无聊..."]
inputs = tokenizer(texts, padding=True, truncation=True, return_tensors='pt')

# 推理
with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.softmax(outputs.logits, dim=1)

print(predictions)
# tensor([[0.02, 0.98],   ← 第一条：98%正面
#         [0.95, 0.05]])  ← 第二条：95%负面
```

### BERT的影响

| 指标 | BERT之前的SOTA | BERT之后 |
|:-----|:--------------:|:--------:|
| GLUE（综合NLP任务） | 82.3 | 86.4 (+4.1) |
| SQuAD 1.1（阅读理解） | 87.4 | 93.2 (+5.8) |
| SWAG（推理） | 65.0 | 86.3 (+21.3) |

**BERT证明了：双向预训练+微调 = NLP的通用解决方案。**

### BERT家族的进化

```
BERT (2018) ── 110M参数，双向Transformer编码器
  │
  ├── RoBERTa (2019) ── 训练更久、更大、去掉NSP任务
  ├── ALBERT (2019) ── 参数共享，更轻量
  ├── DistilBERT (2019) ── 蒸馏版，速度提升60%，保留97%性能
  ├── ELECTRA (2020) ── 替换检测代替MLM，更高效
  └── DeBERTa (2020) ── 解耦注意力，提升表示能力
```

---

### ✅ 费曼三句话（🍅63）

> 1. **BERT是"双向完形填空大师"**——遮盖15%的词让它猜，同时看左右上下文，学会了每个词的深层语境表示。
> 2. **BERT用'迁移学习'的方式改变了NLP**——先在数十亿文本上做预训练（学通用语言知识），然后微调（适应具体任务）。
> 3. **BERT是编码器（理解型模型）**——它擅长理解而非生成。GPT则是解码器（生成型模型）——擅长生成而非理解。

---

## 🍅64 GPT系列——单向解码器的进化

### 🔍 悬疑转折：OpenAI的方向与Google不同

> 同样是2018年，OpenAI发布了GPT（Generative Pre-trained Transformer）。
>
> 和BERT不同，GPT只用Transformer的**解码器**——也就是**单向的**。
>
> 当时很多人认为"单向"是GPT的弱点——因为它只能从左到右看，不能看到整个上下文。
>
> 但GPT证明了：**如果你有足够多的数据和足够的参数，"单向生成"本身就是一种超级力量。**

### GPT的"单向"为什么反而成了优势？

```
BERT (编码器 → 理解):
"我今天[____]北京天安门" → 看到"今天"和"北京天安门"
→ 猜"去"或"到"或"在"
→ 用途：分类、标注、问答

GPT (解码器 → 生成):
"我今天..." → 只能看到"我今天"
→ 猜下一个词 → "去"
→ "我今天去" → 猜下一个 → "北京"
→ "我今天去北京" → 猜下一个 → "天安门"
→ ...
→ 用途：文本生成、对话、创作

理解是"填空"——有限制。
生成是"续写"——无限可能。
```

### GPT进化史：从GPT-1到GPT-4

```python
# GPT进化一览（用代码注释的形式）

# ---- GPT-1 (2018.06) ----
# 参数: 117M
# 训练数据: BookCorpus (约7000本书)
# 能力: 能生成连贯的短文本
# 意义: 证明了"生成式预训练"的有效性
# 局限: 还不具备惊艳的能力

# ---- GPT-2 (2019.02) ----
# 参数: 1.5B （比GPT-1大13倍）
# 训练数据: WebText (800万网页, 40GB文本)
# 能力: 能生成极其流畅的长文本，甚至能写"假新闻"
# 影响: OpenAI因为"太危险"推迟了完整版本的发布
# 名句: 1.5B参数的"键盘侠"

# ---- GPT-3 (2020.05) ----
# 参数: 175B （比GPT-2大117倍！）
# 训练数据: CommonCrawl + WebText2 + Books (约570GB)
# 能力: 少样本学习（few-shot learning）
# 你不需要微调，只需给几个例子，它就能完成任务
# 突破: 翻译、编程、对话、写诗——全都能做
# 新概念: "涌现能力"——小模型没有，大模型突然出现的能力
# 名句: "规模就是一切"

# ---- GPT-3.5 / InstructGPT (2022) ----
# 参数: 175B
# 新训练方法: RLHF (Reinforcement Learning from Human Feedback)
#   1. 人类标注：哪些输出"好"
#   2. 训练奖励模型：模仿人类偏好
#   3. PPO强化学习：让GPT朝人类偏好的方向优化
# 能力: 更对齐人类偏好，更少有毒输出
# 产品: ChatGPT (2022.11) — AI进入主流视野的引爆点

# ---- GPT-4 (2023.03) ----
# 参数: 未知（估计1.7T）
# 训练数据: 多模态（文本+图像）
# 能力:
#   - 通过律师资格考试（90%分位）
#   - 生物奥林匹克竞赛（99%分位）
#   - 多模态理解：能"看"图
# 影响: 全球4亿用户，AI真正进入大众生活
# 名句: 很多专家的领域知识天花板被击穿

# ---- GPT-4o (2024) ----
# 原生多模态：文本、图像、音频统一处理
# 实时语音对话
# 速度大幅提升
```

### GPT的核心组件

```python
# GPT的解码器架构（简化版）

import torch
import torch.nn as nn
import torch.nn.functional as F
import math

class GPTBlock(nn.Module):
    """
    GPT的一个Transformer解码器块

    和标准Transformer解码器的区别：
    1. 没有编码器-解码器交叉注意力（因为GPT没有编码器）
    2. 只有因果掩码自注意力（Masked Self-Attention）
    3. 后续接了前馈网络

    因果掩码：每个词只能看到自己和前面的词
    """
    def __init__(self, d_model=768, num_heads=12):
        super().__init__()

        # 层归一化（Pre-LN结构，GPT-2之后的标准做法）
        self.ln1 = nn.LayerNorm(d_model)
        self.ln2 = nn.LayerNorm(d_model)

        # 因果自注意力（带掩码）
        self.attn = nn.MultiheadAttention(d_model, num_heads,
                                          batch_first=True)

        # 前馈网络 (FFN)
        self.ffn = nn.Sequential(
            nn.Linear(d_model, d_model * 4),  # 扩展4倍
            nn.GELU(),                        # GPT用的激活函数
            nn.Linear(d_model * 4, d_model)   # 压缩回来
        )

    def forward(self, x):
        """
        参数:
            x: [batch, seq_len, d_model]

        返回:
            [batch, seq_len, d_model]
        """
        # 因果掩码（Causal Mask）
        # 上三角矩阵：让当前位置只能看到自己和之前位置
        # 比如 seq_len=4:
        # [[1, 0, 0, 0],   ← 位置0 只能看自己
        #  [1, 1, 0, 0],   ← 位置1 能看位置0,1
        #  [1, 1, 1, 0],   ← 位置2 能看位置0,1,2
        #  [1, 1, 1, 1]]   ← 位置3 能看所有前面
        seq_len = x.size(1)
        causal_mask = torch.triu(
            torch.ones(seq_len, seq_len, device=x.device) * float('-inf'),
            diagonal=1
        )

        # 自注意力 + 残差连接
        attn_out, _ = self.attn(x, x, x, attn_mask=causal_mask)
        x = x + attn_out
        x = self.ln1(x)

        # 前馈网络 + 残差连接
        ffn_out = self.ffn(x)
        x = x + ffn_out
        x = self.ln2(x)

        return x
```

### GPT的关键创新总结

| 创新 | 说明 | 影响 |
|:-----|:----|:-----|
| **因果掩码** | 每个词只能看到自己和前面的词 | 让模型是"生成式"的 |
| **规模扩展** | 从117M到1.7T参数 | 涌现了不可预测的新能力 |
| **In-Context Learning** | 不微调，给例子就能学 | 改变了AI应用范式 |
| **RLHF** | 人类反馈强化学习 | 让AI对齐人类价值观 |
| **思维链** | 让模型一步步推理 | 解决了复杂推理问题 |

---

### ✅ 费曼三句话（🍅63 & 64）

> 1. **BERT是"双向理解器"（编码器），GPT是"单向生成器"（解码器）**——BERT擅长填空和分类，GPT擅长续写和创作。
> 2. **GPT的规模定律令人震惊**——模型越大，涌现的能力越多。翻译、编程、推理——这些在GPT-1上不存在，但在GPT-3上"突然出现"。
> 3. **RLHF是GPT-3.5的关键升级**——不是让模型更聪明，而是让模型的输出更符合人类的期望和价值观。

---

## 🍅65 思维导图 + Transformer代码解读

### 🔍 悬疑收尾：Attention Is All You Need——这是真的吗？

> 2017年的论文标题说"注意力就是你所需要的一切"。到2026年的今天，这个说法依然成立吗？
>
> 是的——而且比以往更成立。
>
> - GPT-4o: Transformer解码器
> - Claude 4: Transformer解码器
> - Gemini: Transformer编码器-解码器
> - LLaMA: Transformer解码器优化
> - 所有多模态模型: Transformer + 视觉编码器
>
> **你学的每一个概念——QKV、多头注意力、掩码、位置编码——都在今天最先进的AI里运行。**

### Part 3 · 番茄61-65 知识全景思维导图

```
┌─────────────────────────────────────────────────────────────┐
│             ⚡ Transformer革命 · 知识全景图                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🍅61 Transformer架构                                         │
│  ├─ 输入：词嵌入 + 位置编码                                  │
│  ├─ 编码器：自注意力 → FFN（×N层）                          │
│  ├─ 解码器：掩码自注意力 → 交叉注意力 → FFN（×N层）         │
│  └─ 输出：Linear → Softmax                                  │
│                                                             │
│  🍅62 自注意力机制 (Scaled Dot-Product Attention)             │
│  ├─ Q = Query: "我在找什么"                                  │
│  ├─ K = Key: "我有什么特征"                                  │
│  ├─ V = Value: "我分享什么信息"                              │
│  ├─ Score = Q @ K^T / √d_k                                   │
│  ├─ Weight = Softmax(Score)                                  │
│  ├─ Output = Weight @ V                                      │
│  └─ 多头 = h个注意力并行 → 拼接                              │
│                                                             │
│  🍅63 BERT (编码器)                                           │
│  ├─ 双向：同时看左右上下文                                    │
│  ├─ MLM：完形填空预训练                                      │
│  ├─ NSP：下一句预测                                          │
│  └─ 用途：分类、NER、QA — "理解型"                           │
│                                                             │
│  🍅64 GPT (解码器)                                            │
│  ├─ 单向：从左到右生成                                       │
│  ├─ 因果掩码：只看过去                                       │
│  ├─ 规模定律：越大越强                                      │
│  ├─ In-Context Learning：给例子就学                          │
│  └─ RLHF：人类反馈对齐                                      │
│                                                             │
│  🍅65 代码解读 + 全景                                      │
│  └─ 从零实现小Transformer                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 从零实现一个微型Transformer

```python
# ---- 完整的小型Transformer用于字符级语言建模 ----
# 
# 目标：用约200行代码，实现一个可训练的小型Transformer
# 麻雀虽小，五脏俱全

import torch
import torch.nn as nn
import torch.nn.functional as F
import math

class MiniTransformer(nn.Module):
    """
    微型Transformer（约5M参数）
    
    架构：嵌入层 → 位置编码 → N个解码器块 → LayerNorm → Linear

    和完整的Transformer区别：
    1. 只有解码器（像GPT）
    2. 没有编码器-解码器交叉注意力（因为是语言模型，不是翻译）
    3. 使用Pre-LN（归一化在注意力/FFN之前）——GPT-2后的标准做法
    """
    def __init__(self, vocab_size, d_model=256, num_heads=4,
                 num_layers=4, max_len=512, dropout=0.1):
        super().__init__()

        # 词嵌入
        self.token_embedding = nn.Embedding(vocab_size, d_model)

        # 位置编码（可学习的，区别于原版Transformer的固定编码）
        self.position_embedding = nn.Embedding(max_len, d_model)

        # Dropout（正则化）
        self.dropout = nn.Dropout(dropout)

        # Transformer解码器块堆叠
        self.blocks = nn.ModuleList([
            TransformerBlock(d_model, num_heads, dropout)
            for _ in range(num_layers)
        ])

        # 最终层归一化
        self.ln = nn.LayerNorm(d_model)

        # 输出投影（词表概率）
        self.fc = nn.Linear(d_model, vocab_size)

    def forward(self, x):
        """
        参数:
            x: 输入字符ID [batch, seq_len]

        返回:
            logits: 每个位置下一个字符的概率 [batch, seq_len, vocab]
        """
        batch_size, seq_len = x.shape

        # 创建位置索引 [0, 1, 2, ..., seq_len-1]
        positions = torch.arange(seq_len, device=x.device).unsqueeze(0)
        positions = positions.expand(batch_size, -1)

        # 词嵌入 + 位置嵌入
        x = self.token_embedding(x) + self.position_embedding(positions)
        x = self.dropout(x)

        # 通过所有Transformer块
        for block in self.blocks:
            x = block(x)

        # 最终归一化 + 输出投影
        x = self.ln(x)
        logits = self.fc(x)

        return logits

    def generate(self, idx, max_new_tokens=100, temperature=1.0):
        """自回归生成"""
        self.eval()
        for _ in range(max_new_tokens):
            # 只取最后max_len个token（防止超出位置编码范围）
            idx_cond = idx[:, -self.position_embedding.weight.shape[0]:]

            # 预测
            with torch.no_grad():
                logits = self(idx_cond)  # [batch, seq_len, vocab]
                logits = logits[:, -1, :]  # 只取最后一个位置的预测

            # 温度采样
            logits = logits / temperature
            probs = F.softmax(logits, dim=-1)
            next_token = torch.multinomial(probs, num_samples=1)

            # 拼接新token
            idx = torch.cat((idx, next_token), dim=1)

        return idx


class TransformerBlock(nn.Module):
    """一个Transformer解码器块"""
    def __init__(self, d_model, num_heads, dropout):
        super().__init__()

        # Pre-LN：先归一化，再计算注意力/FFN
        self.ln1 = nn.LayerNorm(d_model)
        self.ln2 = nn.LayerNorm(d_model)

        # 因果自注意力
        self.attn = nn.MultiheadAttention(d_model, num_heads,
                                          dropout=dropout,
                                          batch_first=True)

        # 前馈网络（FFN）
        self.ffn = nn.Sequential(
            nn.Linear(d_model, d_model * 4),
            nn.GELU(),
            nn.Dropout(dropout),
            nn.Linear(d_model * 4, d_model),
            nn.Dropout(dropout)
        )

    def forward(self, x):
        # 因果掩码
        seq_len = x.size(1)
        mask = torch.triu(
            torch.ones(seq_len, seq_len, device=x.device) * float('-inf'),
            diagonal=1
        )

        # 自注意力 + 残差
        attn_out, _ = self.attn(x, x, x, attn_mask=mask)
        x = x + attn_out

        # FFN + 残差
        x = x + self.ffn(self.ln2(x))

        return x


# ---- 训练一个MiniTransformer ----
# 1. 准备数据
# from torch.utils.data import Dataset
# 
# class TextDataset(Dataset):
#     def __init__(self, text, seq_len=64):
#         # 构建字符映射表
#         chars = sorted(list(set(text)))
#         self.stoi = {ch: i for i, ch in enumerate(chars)}
#         self.itos = {i: ch for i, ch in enumerate(chars)}
#         self.vocab_size = len(chars)
#         # 编码
#         data = torch.tensor([self.stoi[c] for c in text])
#         self.x = data[:-1]
#         self.y = data[1:]
#         self.seq_len = seq_len
# 
#     def __len__(self):
#         return len(self.x) // self.seq_len
# 
#     def __getitem__(self, i):
#         start = i * self.seq_len
#         end = start + self.seq_len
#         return self.x[start:end], self.y[start:end]
# 
# # 2. 创建模型
# model = MiniTransformer(
#     vocab_size=65,  # 如莎士比亚字符集大小
#     d_model=256,
#     num_heads=4,
#     num_layers=4,
#     max_len=512
# )
# 
# # 3. 训练
# optimizer = torch.optim.AdamW(model.parameters(), lr=3e-4)
# 
# for epoch in range(100):
#     for x, y in dataloader:
#         logits = model(x)
#         loss = F.cross_entropy(logits.view(-1, 65), y.view(-1))
#         loss.backward()
#         optimizer.step()
#     print(f'Epoch {epoch}: Loss = {loss.item():.4f}')
# 
# # 4. 生成
# context = torch.tensor([[stoi['\n']]])
# output = model.generate(context, max_new_tokens=500, temperature=0.8)
# print(''.join([itos[i.item()] for i in output[0]]))
```

### Transformer的深度理解清单

```
读完这段代码后，你应该能回答：

1. 为什么Transformer需要位置编码？
   └─ 没有位置信息的自注意力是对称的，"我打你"和"你打我"在没位置编码时一样

2. 为什么用因果掩码？
   └─ 确保生成时只能看到过去，不能看到未来（不然就是作弊）

3. 为什么用残差连接？
   └─ 让梯度直接流向浅层，训练更深的网络

4. 为什么用LayerNorm（层归一化）而不是BatchNorm？
   └─ BN在变长序列上不稳定；LN对每个样本独立归一化，更适合NLP

5. FFN为什么先扩大4倍再缩小？
   └─ 在"注意力后的表示空间"中做更复杂的特征变换

6. 为什么generate时要限制上下文长度？
   └─ 位置编码有最大长度限制（max_len），超了就不能用了
```

---

### ✅ 费曼三句话（🍅65）

> 1. **用200行代码实现一个微型Transformer，你就理解了ChatGPT的底层原理**——它只是把你的mini版本放大了几万倍（更多层、更大维度、更多数据）。
> 2. **Transformer的核心只有三样东西：自注意力（捕获关系）+ 位置编码（注入顺序）+ 前馈网络（特征变换）**——用残差连接和LayerNorm把它们粘在一起。
> 3. **从1943年的一个神经元到2017年的Transformer，人类花了74年找到了序列建模的最佳架构**——到今天，几乎所有AI系统都是Transformer的变体或后代。

---

### 🎯 刻意练习

#### 初级侦探（模仿）
1. 运行MiniTransformer代码，在莎士比亚文本上训练100轮，观察loss下降，生成文本
2. 用HuggingFace的 `transformers` 库加载BERT-base模型，对10条电影评论做情感分类

#### 中级侦探（变式）
3. 修改MiniTransformer，把注意力头数从4改成8，对比训练速度和生成质量的变化
4. 实验不同的temperature值（0.2, 0.5, 0.8, 1.2），观察生成文本的差异

#### 高级侦探（创造）
5. 阅读Transformer论文的"Attention Is All You Need"原始论文（网上可搜），找出至少3个本文没有覆盖的细节
6. 用Transformer实现一个简单的代码生成器：用Python代码片段训练，让它生成简单的函数

#### 📝 探究笔记
```markdown
Transformer vs RNN 的根本差异：
1. 并行 vs 顺序，这对训练意味着什么？___
2. 自注意力的O(n²)复杂度在长序列上是个问题——有什么解决方案？___
3. 为什么说BERT是"理解型"而GPT是"生成型"？它们的架构差异的根本原因是什么？___

深入思考：
Transformer没有"递归"——它一次性看到所有词。这和人类的阅读方式完全不同。
为什么"非生物"的方式反而更有效？
```

---

### 📌 连线思考

> - **现实连接**：你正在使用的Claude Code，本质上是Transformer解码器通过RLHF训练后的产物。你敲的每个命令，都被转换成token序列，经过和你今天写的MiniTransformer相同的注意力计算。
> - **规模思考**：你的MiniTransformer（256维, 4层, 4头）≈ 5M参数。GPT-4 ≈ 1.7T参数 = 34万倍。人类大脑 ≈ 100T突触。但Transformer在语言任务上已经超越人类。
> - **范式转变**：Transformer是"序列到序列"的终极范式——它统一了文本、代码、图像（ViT）、音频（Whisper）、视频的建模方式。万物皆可token化，万物皆可Transformer。
> - **下集预告**：Day14中，我们将进入最具"创造力"的领域——生成模型。GAN、VAE、扩散模型——AI怎么从随机噪声中创造出从未存在过的图像？

---

> **📚 参考**：[[书库/人工智能/人工智能算法  卷3  深度学习和神经网络]] · [[书库/人工智能/深度学习 ]]
