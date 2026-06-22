---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#深度学习"
  - "#RNN"
  - "#LSTM"
  - "#GRU"
  - "#注意力机制"
  - "#序列模型"
  - "#番茄学习法"
  - "#120番茄"
  - "#Day12"
  - "#Part3"
aliases:
  - Day12 循环神经网络
  - RNN与序列魔法
  - 番茄56-60
---

# Day12：循环神经网络与序列魔法 🔄

> **番茄56-60 · Part 3 深度学习与神经网络**
>
> 🕵️ **悬疑开场**：CNN看不了一个句子——因为它记不住前面说了什么。RNN就是"有记忆"的网络。
>
> *"我喜欢吃苹果。"* → CNN看到的是三个词，但它不知道"苹果"是"吃"的对象。
>
> *"我不喜欢这个电影，___"* ——人类看到"不"字，就知道下文是负面评价。但对CNN来说，"不"和"喜欢"之间的逻辑关系——它完全看不懂。
>
> **因为语言是序列的，而CNN是空间的。**

---

## 📋 今日番茄概览

| 番茄 | 主题 | 类型 |
|:----:|::----|:----:|
| 🍅56 | RNN原理——循环的隐藏状态 | 核心概念 |
| 🍅57 | LSTM与GRU——解决记忆衰退 | 理论进阶 |
| 🍅58 | 序列到序列——机器翻译架构 | 方法+代码 |
| 🍅59 | 注意力机制——关注重点 | 核心创新 |
| 🍅60 | 思维导图+实战：文本生成 | 实战项目 |

---

## 🍅56 RNN原理——循环的隐藏状态

### 🔪 犯罪现场：失去记忆的侦探

> 想象一个侦探在审问一个连环案件的嫌疑人。
>
> 他问第一个问题——嫌疑人回答。他问第二个问题——他记得第一个回答，所以能追问。他问第三个问题——结合前两个回答，发现矛盾。
>
> 但如果他每问一个问题就**失忆**一次呢？
>
> 这就是传统神经网络（包括CNN）处理序列的方式：每次只看当前输入，完全忽略上下文。

### RNN的核心思想："循环"就是记忆

RNN的关键在于**隐藏状态（Hidden State）**——一个"记忆容器"，在每个时间步都更新，携带过去的信息。

```
时间 t=1:       时间 t=2:       时间 t=3:
  "我"            "爱"            "你"
    │               │               │
    ▼               ▼               ▼
  [RNN] ──→ h₁    [RNN] ──→ h₂    [RNN] ──→ h₃
    │       ↑       │       ↑       │
    │       │       │       │       │
    └───────┘       └───────┘       └───────┘
   输出:我         输出:爱         输出:你
```

**关键**：$h_2$ 不仅由"爱"决定，还由 $h_1$（包含了"我"的信息）共同决定。

所以当RNN看到"你"时，它知道前面是"我爱你"——而不是三个孤立的词。

### 数学上发生了什么？

```python
# RNN的核心公式——简洁但强大

import torch
import torch.nn as nn

class SimpleRNN(nn.Module):
    """
    一个最简单的RNN单元

    核心公式：
    h_t = tanh(W_h * h_{t-1} + W_x * x_t + b)

    直觉：
    - h_t: 当前时刻的"记忆状态"
    - h_{t-1}: 上一时刻的"记忆状态"
    - x_t: 当前时刻的"新输入"
    - W_h: 记忆的"衰减系数"——过去的信息怎么影响现在
    - W_x: 输入的"编码系数"——当前输入怎么进入记忆
    - tanh: 激活函数，把值压缩到(-1, 1)之间，防止记忆爆炸
    """
    def __init__(self, input_size, hidden_size):
        """
        参数:
            input_size: 每个输入的特征维度（如词向量的维度=300）
            hidden_size: 隐藏状态的维度（记忆容量）
        """
        super().__init__()
        self.hidden_size = hidden_size

        # 输入到隐藏的变换：input_size → hidden_size
        self.i2h = nn.Linear(input_size, hidden_size)
        # 隐藏到隐藏的变换：hidden_size → hidden_size（核心！）
        self.h2h = nn.Linear(hidden_size, hidden_size)
        # 隐藏到输出的变换：hidden_size → output_size
        self.h2o = nn.Linear(hidden_size, hidden_size)

    def forward(self, x, hidden=None):
        """
        单步前向传播

        参数:
            x: 当前时间步的输入 [batch, input_size]
            hidden: 上一时间步的隐藏状态 [batch, hidden_size]

        返回:
            output: 当前时间步的输出
            hidden: 当前时间步的隐藏状态（要传给下一步）
        """
        if hidden is None:
            hidden = torch.zeros(x.size(0), self.hidden_size)

        # RNN核心：新隐藏状态 = 旧隐藏状态 + 新输入
        # 这就像"更新你的记忆"——结合旧的记忆和新信息
        hidden = torch.tanh(self.i2h(x) + self.h2h(hidden))

        # 基于当前隐藏状态产生输出
        output = self.h2o(hidden)

        return output, hidden

    def forward_sequence(self, seq):
        """
        处理整个序列（逐个时间步")

        参数:
            seq: 输入序列 [seq_len, batch, input_size]

        返回:
            outputs: 所有时间步的输出
            hidden: 最后一个隐藏状态
        """
        hidden = None
        outputs = []

        for t in range(seq.size(0)):  # 遍历每个时间步
            output, hidden = self.forward(seq[t], hidden)
            outputs.append(output)

        return torch.stack(outputs), hidden

# ----- 使用示例 -----
# input_size=10, hidden_size=20
rnn = SimpleRNN(input_size=10, hidden_size=20)

# 一个长度为5的序列，batch_size=3
seq = torch.randn(5, 3, 10)  # [seq_len, batch, features]
outputs, last_hidden = rnn.forward_sequence(seq)
# outputs.shape = [5, 3, 20]  ← 每个时间步的输出
# last_hidden.shape = [3, 20] ← 最后的记忆状态（包含整个序列的信息）
```

### RNN的序列处理能力

| 问题类型 | 图示 | 例子 |
|:---------|:----:|:-----|
| **序列→单输出** | 🛜➡️📦 | 情感分类："这个电影真好看" → 正面 |
| **序列→序列** | 🛜➡️🛜 | 机器翻译："I love you" → "我爱你" |
| **单输入→序列** | 📦➡️🛜 | 图像描述：一张图 → "一只猫坐在沙发上" |
| **同步序列** | 🛜🔄🛜 | 视频帧分类：每一帧标出人物位置 |

### RNN的致命缺陷

```python
# RNN的理论问题：长期依赖

# 句子："我出生在法国，在那里生活了20年，所以我说一口流利的___"
# 正确答案应该是"法语"
# 
# 但"法语"和"法国"之间相隔了20个词！
# 
# RNN的梯度通过20个时间步反向传播：
# 梯度 = 梯度_t * tanh' * W_h * tanh' * W_h * ... (20次连乘)
# 
# 如果 W_h < 1：梯度消失 → 学不会长期依赖（"法国"和"法语"的关系）
# 如果 W_h > 1：梯度爆炸 → 训练不稳定
#
# 这就是RNN在实际中很难"记住"长期信息的根本原因

# 梯度消失的数学直觉
import numpy as np

def rnn_grad_decay(steps, w_h=0.5):
    """模拟RNN梯度随时间步衰减"""
    grad = 1.0
    for t in range(steps):
        # tanh的导数最大为1，通常小于1
        tanh_deriv = np.random.uniform(0.1, 0.9)
        grad *= w_h * tanh_deriv
    return grad

print(f"5步后梯度: {rnn_grad_decay(5):.6f}")    # 还能接受
print(f"20步后梯度: {rnn_grad_decay(20):.6f}")  # ≈ 0
print(f"100步后梯度: {rnn_grad_decay(100):.6f}") # 彻底消失
```

---

### ✅ 费曼三句话（🍅56）

> 1. **RNN的"循环"就是"记住"**——上一时刻的输出和当前时刻的输入一起决定当前时刻的状态，就像一个侦探不断更新案情笔记。
> 2. **RNN的核心公式只有一行：h_t = tanh(W_h·h_{t-1} + W_x·x_t)**——但这一行公式让"记忆"成为可能。
> 3. **RNN的致命问题是梯度消失/爆炸**——通过多个时间步反向传播时，梯度要么消失（记不住远处信息），要么爆炸（训练崩溃）。LSTM就是来修这个的。

---

## 🍅57 LSTM与GRU——解决"记忆衰退"问题

### 🔍 破案突破：给记忆加上"门控"

> 1997年，Hochreiter和Schmidhuber提出了LSTM（长短期记忆网络）。
>
> 核心洞察：**RNN的问题在于它无差别地"记住一切"**——不管是重要的还是不重要的，都用同一个公式更新记忆。
>
> LSTM引入了"门控"机制——**选择性地记忆和遗忘**。

### LSTM的"三个门"

想象你有一个工作笔记和一个长期知识库：

```
遗忘门：这个旧信息还要不要保留？    → "上周的天气如何？" → 删掉
输入门：这个新信息值得记住吗？      → "老板说周日加班"  → 记下来
输出门：基于当前记忆，应该输出什么？  → "周日不能出去玩了" → 输出
```

```python
import torch
import torch.nn as nn

class LSTMCell(nn.Module):
    """
    LSTM的核心单元——比RNN多了一个"细胞状态" C_t

    RNN:    h_t = f(h_{t-1}, x_t)       只有隐藏状态
    LSTM:   h_t = f(h_{t-1}, C_{t-1}, x_t)  隐藏状态 + 细胞状态

    细胞状态 C_t 就像一个"传送带"——信息可以在上面流畅地传递，
    门控决定什么信息被添加或移除
    """
    def __init__(self, input_size, hidden_size):
        super().__init__()
        self.hidden_size = hidden_size

        # 三个门 + 候选记忆：总共4个变换
        # 把输入和隐藏状态拼接，一次计算所有门控值（效率优化）
        self.gates = nn.Linear(input_size + hidden_size, 4 * hidden_size)

    def forward(self, x, states):
        """
        LSTM前向传播

        参数:
            x: 当前输入 [batch, input_size]
            states: (h_prev, c_prev) 上一个时刻的隐藏状态和细胞状态

        返回:
            h_next: 当前时刻的隐藏状态
            c_next: 当前时刻的细胞状态
        """
        h_prev, c_prev = states

        # 拼接输入和上一隐藏状态
        combined = torch.cat([x, h_prev], dim=1)

        # 一次计算4个门控值
        gates = self.gates(combined)

        # 拆分成4部分
        i, f, g, o = gates.chunk(4, dim=1)

        # ---- 遗忘门 ----
        # sigmoid: 输出0到1之间，"0=完全忘记，1=完全记住"
        forget_gate = torch.sigmoid(f)
        # 旧的细胞状态 × 遗忘门
        # 如果遗忘门=0，这部分记忆彻底丢了
        # 如果遗忘门=1，这部分记忆完整保留

        # ---- 输入门 ----
        input_gate = torch.sigmoid(i)
        # 新候选记忆（用tanh压缩到(-1,1)）
        candidate = torch.tanh(g)

        # ---- 更新细胞状态 ----
        # 旧记忆 × 遗忘门 + 新候选 × 输入门
        # 这就是LSTM的"选择性记忆"核心
        c_next = forget_gate * c_prev + input_gate * candidate

        # ---- 输出门 ----
        output_gate = torch.sigmoid(o)
        # 隐藏状态 = 输出门 × tanh(细胞状态)
        h_next = output_gate * torch.tanh(c_next)

        return h_next, (h_next, c_next)

# LSTM vs RNN，一句话对比：
#
# RNN:  h_t = tanh(W·[h_{t-1}, x_t])
#       ↑ 旧记忆和新输入一视同仁地混合
#
# LSTM: f = sigmoid(...)  ← 遗忘旧记忆的比例
#       i = sigmoid(...)  ← 采纳新信息的比例
#       o = sigmoid(...)  ← 输出多少记忆
#       c_t = f*c_{t-1} + i*candidate  ← 选择性更新
#       h_t = o * tanh(c_t)
#       ↑ 每一步都在"决定"：忘多少、记多少、输出多少
```

### LSTM的门控流程图

```
                   ┌─────────────────────────────────────┐
                   │              细胞状态 (传送带)          │
                   │  c_{t-1} ────[×]──────────[+]────▶ c_t │
                   │              ↑              ↑          │
                   │              │              │          │
                   │          [遗忘门]        [输入门]       │
                   │              │              │          │
                   │              f              i          │
                   │              ↑              ↑          │
                   │          [sigmoid]      [sigmoid]      │
                   │              ↑              ↑          │
                   │              │              │          │
                   │           [拼接 h_{t-1}, x_t]          │
                   │              │              │          │
                   │              └──────┬───────┘          │
                   │                     │                  │
                   │                     ▼                  │
                   │               [tanh] 候选记忆          │
                   │                     │                  │
                   │                     g                  │
                   │                     │                  │
                   │               [×] ←── [输出门 o]       │
                   │                     │                  │
                   │                     ▼                  │
                   │    h_{t-1} ───▶ h_t (隐藏状态输出)     │
                   └─────────────────────────────────────┘
```

### GRU：LSTM的简化版

2014年，Cho等人提出了GRU（门控循环单元）——把LSTM的三个门合并成两个，去掉了独立的细胞状态：

```
GRU核心公式（更简洁）：
1. 重置门 r：决定多少旧记忆被"重置"  → 控制短期依赖
2. 更新门 z：决定多少旧记忆被"保留"  → 控制长期依赖
3. 新隐藏状态 = (1-z) × 旧状态 + z × 候选状态
```

**GRU vs LSTM 实战对比：**

| 对比项 | LSTM | GRU |
|:-------|:----:|:----:|
| 参数数量 | 多（3个门+1个候选） | 少（2个门） |
| 计算速度 | 慢 | 快 |
| 长期记忆 | ⭐⭐⭐⭐⭐（有专门细胞状态） | ⭐⭐⭐⭐ |
| 数据量小 | 容易过拟合 | 更鲁棒 |
| 谁在用 | 经典NLP任务 | 机器翻译、语音 |

### PyTorch实战：用LSTM做情感分析

```python
import torch
import torch.nn as nn

class SentimentLSTM(nn.Module):
    """
    用LSTM做电影评论情感分类

    架构：
    词嵌入(Embedding) → LSTM → 全连接 → 输出(正面/负面)
    """
    def __init__(self, vocab_size, embedding_dim=100,
                 hidden_size=128, num_layers=2, num_classes=2):
        super().__init__()

        # 词嵌入层：把单词ID映射成稠密向量
        # vocab_size=50000, embedding_dim=100
        # → 50,000个词×100维 = 500万参数的"词-向量对照表"
        self.embedding = nn.Embedding(vocab_size, embedding_dim)

        # LSTM层
        # num_layers=2 表示堆叠两个LSTM层
        self.lstm = nn.LSTM(
            input_size=embedding_dim,   # 100
            hidden_size=hidden_size,    # 128
            num_layers=num_layers,      # 2
            batch_first=True,           # 输入格式：[batch, seq_len, features]
            dropout=0.5,                # 防止过拟合
            bidirectional=False         # 是否双向（下章讲）
        )

        # 分类器
        self.classifier = nn.Sequential(
            nn.Linear(hidden_size, 64),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(64, num_classes)
        )

    def forward(self, x):
        """
        参数:
            x: 单词ID序列 [batch, seq_len]
               例如: [[2, 45, 198, 3021, 8, ...]]

        返回:
            分类logits [batch, num_classes]
        """
        # 词嵌入: [batch, seq_len] → [batch, seq_len, embedding_dim]
        embedded = self.embedding(x)

        # LSTM:
        # output: 每个时间步的隐藏状态 [batch, seq_len, hidden_size]
        # (hidden, cell): 最后时间步的状态
        lstm_out, (hidden, cell) = self.lstm(embedded)

        # 取最后一个时间步的隐藏状态作为序列的"总结"
        # hidden.shape = [num_layers, batch, hidden_size]
        # 取最后一层: hidden[-1]
        last_hidden = hidden[-1]  # [batch, hidden_size]

        # 分类
        logits = self.classifier(last_hidden)
        return logits

# ---- 训练循环 ----
# 伪代码示例
# model = SentimentLSTM(vocab_size=50000)
# criterion = nn.CrossEntropyLoss()
# optimizer = torch.optim.Adam(model.parameters())
#
# for epoch in range(10):
#     for batch in dataloader:
#         texts, labels = batch  # texts: [batch, seq_len]
#         outputs = model(texts)
#         loss = criterion(outputs, labels)
#         loss.backward()
#         optimizer.step()

# ---- 推理示例 ----
# model.eval()
# with torch.no_grad():
#     text = "This movie was absolutely fantastic!"
#     tokenized = tokenizer(text)  # [1, seq_len]
#     output = model(tokenized)
#     prediction = torch.argmax(output, dim=1)
#     # 输出: 1 (正面)
```

---

### ✅ 费曼三句话（🍅57）

> 1. **LSTM的核心创新是"细胞状态传送带"加上三个门控开关**——遗忘门决定扔什么，输入门决定记什么，输出门决定说什么。
> 2. **LSTM解决了RNN梯度消失的问题**——因为细胞状态的传递是"加法"（c_t = f*c_{t-1} + i* candidate），而不是"乘法"，梯度可以无损流过加法操作。
> 3. **GRU是LSTM的精简版（两个门替代三个门）**——参数更少，训练更快，在很多任务上效果不输LSTM。

---

## 🍅58 序列到序列——机器翻译的经典架构

### 🔍 犯罪现场：翻译就是"编码和解码"

> "I love you" → 中文翻译 → "我爱你"
>
> 这两个句子长度不同、语序不同、结构不同。RNN怎么处理这种"输入长度≠输出长度"的问题？

### Encoder-Decoder架构（编码器-解码器）

```
                    Encoder RNN                    Decoder RNN

                     ▲                             ▲
                     │                             │
"I" ──▶ [RNN] ──▶ h₁ ──┐                   ┌── h₁' ◀── [START]
"love" ──▶ [RNN] ──▶ h₂ │                   │    │
                     │   └── Context ──▶ [RNN] ──▶ h₂' ◀── "我"
"you" ──▶ [RNN] ──▶ h₃ ──┐    Vector       │    │
                     ▲    │                   │    │
                     │   ┌──┘                ◀── [RNN] ──▶ h₃' ◀── "爱"
                     ▼                             │
                                                    ▼
                                                   [RNN] ──▶ h₄' ◀── "你"
                                                         │
                                                         ▼
                                                       [END]
```

**核心思想：**

1. **编码器**：读完整句，压缩成一个"上下文向量"（Context Vector）
2. **解码器**：基于这个向量，逐词生成翻译

**问题**：上下文向量必须"压缩"整个句子的信息——句子越长，信息丢失越多。

```python
# 简单的Seq2Seq模型

import torch
import torch.nn as nn

class Encoder(nn.Module):
    """编码器：读取输入序列，生成上下文向量"""
    def __init__(self, vocab_size, embedding_dim, hidden_size):
        super().__init__()
        self.hidden_size = hidden_size
        self.embedding = nn.Embedding(vocab_size, embedding_dim)
        self.lstm = nn.LSTM(embedding_dim, hidden_size, batch_first=True)

    def forward(self, x):
        """
        参数:
            x: 输入序列 [batch, seq_len]
        返回:
            hidden, cell: 编码后的上下文向量
        """
        embedded = self.embedding(x)  # [batch, seq_len, emb_dim]
        _, (hidden, cell) = self.lstm(embedded)
        # hidden.shape = [1, batch, hidden_size]
        return hidden, cell


class Decoder(nn.Module):
    """解码器：从上下文向量生成输出序列"""
    def __init__(self, vocab_size, embedding_dim, hidden_size):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, embedding_dim)
        self.lstm = nn.LSTM(embedding_dim, hidden_size, batch_first=True)
        self.fc = nn.Linear(hidden_size, vocab_size)  # 预测下一个词

    def forward(self, x, hidden, cell):
        """
        参数:
            x: 上一个已生成的词 [batch, 1]
            hidden, cell: 编码器传来的上下文
        返回:
            prediction: 下一个词的预测分布
            hidden, cell: 更新后的状态
        """
        embedded = self.embedding(x)
        output, (hidden, cell) = self.lstm(embedded, (hidden, cell))
        prediction = self.fc(output.squeeze(1))
        return prediction, hidden, cell


class Seq2Seq(nn.Module):
    """完整的编码器-解码器架构"""
    def __init__(self, encoder, decoder, device):
        super().__init__()
        self.encoder = encoder
        self.decoder = decoder
        self.device = device

    def forward(self, src, trg, teacher_forcing_ratio=0.5):
        """
        参数:
            src: 源语言句子 [batch, src_len]
            trg: 目标语言句子 [batch, trg_len]
            teacher_forcing_ratio: 用真实词vs用预测词的比例

        训练技巧——Teacher Forcing（教师强制）：
        - 用真实的前一个词来预测下一个词（收敛快）
        - 用自己预测的词来预测下一个词（更鲁棒）
        - 训练初期多用真实词，后期多用预测词
        """
        batch_size = trg.shape[0]
        trg_len = trg.shape[1]
        trg_vocab_size = self.decoder.fc.out_features

        # 存储所有时间步的预测
        outputs = torch.zeros(batch_size, trg_len, trg_vocab_size).to(self.device)

        # 编码器处理源句子
        hidden, cell = self.encoder(src)

        # 解码器的第一个输入：<SOS> (start of sequence token)
        input_token = trg[:, 0].unsqueeze(1)  # [batch, 1]

        # 逐词解码
        for t in range(1, trg_len):
            # 解码一步
            output, hidden, cell = self.decoder(input_token, hidden, cell)
            outputs[:, t, :] = output

            # Teacher Forcing 决策
            teacher_force = torch.rand(1).item() < teacher_forcing_ratio
            top1 = output.argmax(1)  # 模型预测的词
            input_token = trg[:, t].unsqueeze(1) if teacher_force else top1.unsqueeze(1)

        return outputs

# ---- 使用示例 ----
# 假设: src_vocab_size=10000, trg_vocab_size=15000, emb_dim=256, hidden=512
# encoder = Encoder(10000, 256, 512)
# decoder = Decoder(15000, 256, 512)
# model = Seq2Seq(encoder, decoder, device)
#
# src = torch.randint(0, 10000, (32, 20))  # 32个句子，每个最多20词
# trg = torch.randint(0, 15000, (32, 25))  # 翻译结果，每个最多25词
# output = model(src, trg)
# output.shape  # [32, 25, 15000] ← 每个时间步的词汇表概率分布
```

### Encoder-Decoder的局限

| 问题 | 表现 | 原因 |
|:-----|:-----|:------|
| **信息瓶颈** | 长句子翻译质量下降 | 一个固定长度的上下文向量必须包含整个句子信息 |
| **对齐问题** | 不知道源语言的哪个词对应目标语言的哪个词 | 编码器必须把所有信息"压扁"成一个向量 |

**解决方案**：Attention（注意力机制）——不让解码器"猜"整个句子的含义，而是让它在每一步"查看"源句子的相关部分。

---

### ✅ 费曼三句话（🍅58）

> 1. **Seq2Seq = 编码器"读" + 解码器"写"**——编码器把输入压缩成上下文向量，解码器逐词展开成输出。
> 2. **Teacher Forcing是训练时的"作弊技巧"**——训练时用正确答案引导，而不是让模型自己乱猜，大幅加快收敛。
> 3. **固定长度的上下文向量是信息瓶颈**——句子越长，瓶颈越严重。注意力机制就是来打破这个瓶颈的。

---

## 🍅59 注意力机制——不再"压缩"所有信息，而是"关注"重点

### 🔍 破案突破：不要压缩，要"翻阅"

> 想象你在翻译一个长句子。你不是把整句记在脑子里再逐词翻译——你会反复回看原文，每次只关注你需要的那一部分。
>
> 注意力机制就是让模型能"回看原文"。
>
> 2015年，Bahdanau等人提出了**注意力机制（Attention Mechanism）**。它允许解码器在生成每个词时，**动态地选择源句子的不同部分**。

### 注意力的核心思想

```
编码器输出: [h₁, h₂, h₃, h₄, h₅]  ← 每个词对应的隐藏状态
               │   │   │   │   │
               ▼   ▼   ▼   ▼   ▼
              ┌─────────────────────┐
              │   注意力权重计算     │  ← 解码器当前的状态 q
              │   α₁, α₂, α₃, α₄, α₅ │
              └─────────────────────┘
                      │
                      ▼
              加权和: c = Σ αᵢ hᵢ
                      │
                      ▼
            ┌────────────────────┐
            │  上下文向量 c      │ ← 包含最相关的源句信息
            │  + 解码器状态     │
            │  → 预测下一个词   │
            └────────────────────┘
```

```python
# 注意力机制的实现

import torch
import torch.nn as nn
import torch.nn.functional as F

class Attention(nn.Module):
    """
    Bahdanau注意力（加法注意力）

    核心问题：给定解码器当前状态 q，编码器所有输出 H = [h₁, ..., hₙ]
    计算每个 hᵢ 对当前解码步的重要性（注意力权重）

    三步骤：
    1. 计算"能量"：eᵢ = score(q, hᵢ)  ← 相关性分数
    2. 归一化：αᵢ = softmax(eᵢ)        ← 注意力分布
    3. 加权和：c = Σ αᵢ hᵢ             ← 上下文向量
    """
    def __init__(self, hidden_size):
        super().__init__()
        # 注意力权重矩阵（可学习）
        self.attention = nn.Linear(hidden_size * 2, hidden_size)
        self.v = nn.Linear(hidden_size, 1, bias=False)

    def forward(self, query, encoder_outputs):
        """
        参数:
            query: 解码器当前状态 [batch, hidden_size]
            encoder_outputs: 编码器所有输出 [batch, src_len, hidden_size]

        返回:
            context: 上下文向量 [batch, hidden_size]
            attention_weights: 注意力权重 [batch, src_len]
        """
        batch_size = encoder_outputs.shape[0]
        src_len = encoder_outputs.shape[1]

        # 复制查询向量，每个时间步一个
        query = query.unsqueeze(1).repeat(1, src_len, 1)
        # query: [batch, src_len, hidden_size]

        # 步骤1：计算能量
        # 把query和每个encoder_output拼接，过全连接层
        energy = torch.tanh(self.attention(
            torch.cat((query, encoder_outputs), dim=2)
        ))
        # energy: [batch, src_len, hidden_size]

        # 压缩到1维
        attention_energies = self.v(energy).squeeze(2)
        # attention_energies: [batch, src_len]

        # 步骤2：softmax归一化为概率分布
        attention_weights = F.softmax(attention_energies, dim=1)
        # attention_weights: [batch, src_len]，每行和为1

        # 步骤3：加权求和得到上下文向量
        context = torch.bmm(attention_weights.unsqueeze(1),
                            encoder_outputs).squeeze(1)
        # context: [batch, hidden_size]

        return context, attention_weights

# ---- 注意力的可视化 ----
# 当翻译 "I love you" → "我爱你" 时：
#
# 解码"我"时：注意力集中在 "I"           α = [0.9, 0.05, 0.05]
# 解码"爱"时：注意力集中在 "love"         α = [0.05, 0.9, 0.05]
# 解码"你"时：注意力集中在 "you"          α = [0.05, 0.05, 0.9]
#
# 这就是"对齐"——模型学会了源语言和目标语言单词之间的对应关系！
```

### 注意力机制的泛化：Query, Key, Value

所有注意力机制都可以用一个统一的框架理解：

> **给定一个Query，在一组Key-Value对中，找出与Query最相关的Value**

```
比喻：你在图书馆找书
- Query：你的问题（"深度学习入门书籍"）
- Key：书的标签（"机器学习"、"Python"、"编程入门"）
- Value：书的内容

步骤：
1. Query vs 每个Key → 相关性分数
2. softmax → 归一化为权重
3. 权重 × 对应Value → 加权和

"那本标签最匹配的书，它的内容对你最有价值"
```

| 组件 | 在机器翻译中 | 在自注意力中 |
|:-----|:-----------|:------------|
| Query | 解码器当前状态 | 当前词 |
| Key | 编码器每个位置的输出 | 序列中所有词 |
| Value | 编码器每个位置的输出 | 序列中所有词 |

---

### ✅ 费曼三句话（🍅59）

> 1. **注意力机制就是"动态查阅"**——不再把所有信息压扁成一个向量，而是每次只"看"最相关的部分。
> 2. **注意力三步骤：打分（Query vs Key）→ 归一化（softmax）→ 加权求和（Value）**——这个框架统一了整个注意力家族。
> 3. **注意力机制直接催生了Transformer**——既然"注意"比"循环"更有效，为什么不只用注意力？这正是Day13的主题。

---

## 🍅60 思维导图+实战：文本生成

### 🔍 悬疑收尾：让RNN"写"出莎士比亚

> 2015年，Andrej Karpathy写了一篇著名的博客《The Unreasonable Effectiveness of Recurrent Neural Networks》。
>
> 他训练了一个字符级RNN——让它逐字符地学习莎士比亚的所有作品。
>
> 结果是惊人的：RNN不仅学会了英语单词的拼写，还学会了莎翁的句式结构、对话格式——甚至"剧情"。

### Part 3 · 番茄56-60 知识全景思维导图

```
┌─────────────────────────────────────────────────────────────┐
│              🍅 循环神经网络与序列魔法 · 全景图              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🍅56 RNN核心                                               │
│  ├─ 循环隐藏状态 h_t = tanh(W·[h_{t-1}, x_t])              │
│  ├─ 可处理任意长度序列                                      │
│  ├─ 共享权重（每个时间步用同一套参数）                      │
│  └─ 问题：梯度消失 → 记不住长期依赖                         │
│                                                             │
│  🍅57 LSTM & GRU                                            │
│  ├─ LSTM: 遗忘门+输入门+输出门+细胞状态                    │
│  │   → "选择性记忆"解决长程依赖                             │
│  └─ GRU: 重置门+更新门（LSTM简化版）                       │
│                                                             │
│  🍅58 Seq2Seq                                               │
│  ├─ Encoder：把源序列压缩成上下文向量                       │
│  ├─ Decoder：从上下文向量逐词生成                           │
│  ├─ Teacher Forcing：训练技巧                               │
│  └─ 问题：信息瓶颈（长句子不行）                            │
│                                                             │
│  🍅59 注意力机制                                            │
│  ├─ 统一框架：Query × Key → 权重 × Value                   │
│  ├─ 解决信息瓶颈                                            │
│  ├─ 可解释性：可视化注意力权重                              │
│  └─ 桥接：注意力 → Transformer                              │
│                                                             │
│  🍅60 文本生成实战                                          │
│  └─ 字符级RNN → 逐字符生成文本                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 实战：字符级RNN文本生成

```python
# ---- 用LSTM生成类似莎士比亚风格的文本 ----
# 
# 核心思想：字符级语言模型
# 给定前n个字符，预测下一个字符
# 训练完成后，从随机字符开始，逐个采样生成新文本

import torch
import torch.nn as nn
import numpy as np

class CharRNN(nn.Module):
    """
    字符级RNN语言模型
    输入：字符序列  →  输出：下一个字符的概率分布
    """
    def __init__(self, vocab_size, embedding_dim=64,
                 hidden_size=128, num_layers=2):
        super().__init__()
        self.hidden_size = hidden_size
        self.num_layers = num_layers

        # 字符嵌入
        self.embedding = nn.Embedding(vocab_size, embedding_dim)

        # LSTM
        self.lstm = nn.LSTM(embedding_dim, hidden_size,
                           num_layers, batch_first=True,
                           dropout=0.3 if num_layers > 1 else 0)

        # 输出层：预测下一个字符
        self.fc = nn.Linear(hidden_size, vocab_size)

    def forward(self, x, hidden=None):
        """
        参数:
            x: 字符ID序列 [batch, seq_len]
            hidden: 初始隐藏状态
        返回:
            output: 每个位置下一个字符的预测 [batch, seq_len, vocab]
            hidden: 最终隐藏状态
        """
        if hidden is None:
            hidden = self.init_hidden(x.size(0))

        embedded = self.embedding(x)  # [batch, seq_len, emb_dim]
        lstm_out, hidden = self.lstm(embedded, hidden)
        output = self.fc(lstm_out)     # [batch, seq_len, vocab]
        return output, hidden

    def init_hidden(self, batch_size):
        """初始化隐藏状态（全零）"""
        return (torch.zeros(self.num_layers, batch_size, self.hidden_size),
                torch.zeros(self.num_layers, batch_size, self.hidden_size))

    def generate(self, start_chars, char_to_idx, idx_to_char,
                 length=500, temperature=1.0):
        """
        生成文本

        参数:
            start_chars: 起始字符串
            temperature: 采样温度（>1更随机，<1更确定）
            length: 生成字符数
        """
        self.eval()
        device = next(self.parameters()).device

        # 把起始字符转为ID
        chars = [char_to_idx[c] for c in start_chars]
        input_seq = torch.tensor([chars], device=device)

        # 初始化隐藏状态
        hidden = self.init_hidden(1)

        # 先传入起始序列，更新隐藏状态
        with torch.no_grad():
            _, hidden = self(input_seq, hidden)

        # 获取最后一个字符的预测
        current_char = torch.tensor([[chars[-1]]], device=device)

        generated = list(start_chars)

        for _ in range(length):
            with torch.no_grad():
                output, hidden = self(current_char, hidden)

            # 获取最后一个时间步的预测
            logits = output[0, -1] / temperature  # temperature控制"创造性"

            # 从概率分布中采样
            probs = torch.softmax(logits, dim=0).cpu().numpy()
            next_char_idx = np.random.choice(len(probs), p=probs)

            # 附加上下文
            generated.append(idx_to_char[next_char_idx])
            current_char = torch.tensor([[next_char_idx]], device=device)

        return ''.join(generated)

# ---- 如何训练 ----
# 1. 准备训练数据（如莎士比亚全集.txt）
# with open('shakespeare.txt', 'r') as f:
#     text = f.read()
#
# 2. 构建字符映射表
# chars = sorted(list(set(text)))
# char_to_idx = {ch: i for i, ch in enumerate(chars)}
# idx_to_char = {i: ch for i, ch in enumerate(chars)}
# vocab_size = len(chars)
#
# 3. 准备训练样本
# seq_length = 100
# sequences = []
# targets = []
# for i in range(0, len(text) - seq_length, 1):
#     seq = text[i:i+seq_length]
#     tgt = text[i+1:i+seq_length+1]
#     sequences.append([char_to_idx[c] for c in seq])
#     targets.append([char_to_idx[c] for c in tgt])
#
# 4. 训练
# model = CharRNN(vocab_size)
# criterion = nn.CrossEntropyLoss()
# optimizer = torch.optim.Adam(model.parameters(), lr=0.001)
#
# for epoch in range(50):
#     for batch in dataloader:
#         x, y = batch
#         output, _ = model(x)
#         loss = criterion(output.view(-1, vocab_size), y.view(-1))
#         loss.backward()
#         optimizer.step()
#
# 5. 生成
# generated = model.generate("ROMEO: ", char_to_idx, idx_to_char,
#                            length=1000, temperature=0.8)
# print(generated)
```

### Temperature采样：创造力的开关

```
temperature=0.2: "I love you. I love you. I love you."  ← 最确定的输出
temperature=0.8: "I love you, my darling Juliet."        ← 有创意的输出
temperature=1.5: "I blorf yoz, mur splorken Jooliet!"   ← 太随机了
```

**直觉**：temperature控制概率分布的"尖锐程度"——低temperature压死小概率词，高temperature给所有词平等机会。

---

### ✅ 费曼三句话（🍅60）

> 1. **字符级RNN文本生成 = 下一个字符预测游戏的无限循环**——学完所有文本后，它掌握的不仅是语法，还有风格、节奏甚至"剧情"。
> 2. **Temperature是创意的调节旋钮**——低温度生成安全但无聊的文本，高温度生成有趣但可能胡说的文本。
> 3. **LSTM生成的文本看似合理，但缺乏真正的"全局一致性"**——它记得前面10个词，但记不住第1段和第5段的关系。这就是Transformer要解决的问题。

---

### 🎯 刻意练习

#### 初级侦探（模仿）
1. 用PyTorch的 `nn.LSTM` 实现一个句子情感分类器（正面/负面），在你的影评数据集上训练
2. 下载莎士比亚作品集，训练一个字符级RNN，生成1000字的莎翁风格文本

#### 中级侦探（变式）
3. 对比LSTM和GRU在同一个文本生成任务上的训练速度和生成质量
4. 修改文本生成代码，使用 `temperature=[0.2, 0.5, 0.8, 1.2]` 各生成一段，对比效果

#### 高级侦探（创造）
5. 用Seq2Seq + Attention实现一个简单的英中翻译系统（小规模数据集即可）
6. 思考：既然LSTM已经有了门控机制来缓解梯度消失，为什么还需要注意力机制？两者解决的分别是什么问题？

#### 📝 探究笔记
```markdown
实验记录：
- LSTM vs GRU 训练时间差异：___
- 最佳 temperature 值：___
- 生成的文本有趣但有什么明显的缺陷？___

关键思考：
如果不用RNN，只用注意力机制（不做循环），能不能处理序列？
——这正是Transformer的核心思想：Attention Is All You Need。
```

---

### 📌 连线思考

> - **现实连接**：你手机的输入法预测、Google翻译、Siri的语音识别——底层都是你说"记不住"的RNN家族技术。
> - **渐进式理解**：RNN像"在线流式处理"——来一个词处理一个词，不断更新记忆。CNN像"批量处理"——看到整张图再分析。理解两者的区别，就理解了80%的深度学习架构。
> - **历史视角**：2014-2017年，Seq2Seq+Attention统治了NLP领域。然后Transformer来了，一切都被改变了。
> - **下集预告**：Day13终于来了——Transformer，那个让RNN成为"传统方法"的论文。"Attention Is All You Need"——这是真的吗？

---

> **📚 参考**：[[书库/人工智能/人工智能算法  卷3  深度学习和神经网络]] · [[书库/人工智能/深度学习 ]]
