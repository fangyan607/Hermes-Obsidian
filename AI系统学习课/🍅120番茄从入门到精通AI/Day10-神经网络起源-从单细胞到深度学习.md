---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#深度学习"
  - "#神经网络"
  - "#番茄学习法"
  - "#费曼学习法"
  - "#120番茄"
  - "#Day10"
  - "#Part3"
aliases:
  - Day10 神经网络起源
  - 从单细胞到深度学习
  - 番茄46-50
---

# Day10：神经网络起源——从单细胞到深度学习 🧠

> **番茄46-50 · Part 3 深度学习与神经网络**
>
> 🕵️ **悬疑开场**：1943年，两个科学家发现——一个神经元就是一个逻辑门。如果连接很多神经元呢？

---

## 📋 今日番茄概览

| 番茄 | 主题 | 类型 |
|:----:|:----|:----:|
| 🍅46 | 感知机——最简神经网络 | 核心概念 |
| 🍅47 | 多层感知机——隐藏层的秘密 | 理论进阶 |
| 🍅48 | 反向传播——神经网络的学习引擎 | 核心算法 |
| 🍅49 | 激活函数——非线性的力量 | 理论+代码 |
| 🍅50 | 用PyTorch写第一个神经网络 | 实战项目 |

---

## 🍅46 感知机——最简神经网络

### 🔪 犯罪现场：一个神经元的判决

> 1957年，心理学家弗兰克·罗森布拉特（Frank Rosenblatt）站在一台巨大的机器前。这台叫"感知机"（Perceptron）的东西，由400个光电单元组成，重达一吨。
>
> 罗森布拉特对这台机器说："来，区分一下左边和右边。"
>
> 机器嗡嗡作响。几分钟后——它成功了。
>
> 这是人类历史上第一次，一台机器学会了"看"。
>
> **但悲剧也随之而来。** 1969年，明斯基在《感知机》一书中证明：感知机连"异或"（XOR）这种简单问题都解决不了。神经网络陷入第一次"AI寒冬"。
>
> 是感知机太弱了吗？不，是**一层**太弱了。

### 感知机的数学本质

感知机是最简单的神经网络——一个神经元的数学抽象：

```
输入 x₁ → w₁
输入 x₂ → w₂      Σ(w·x + b) → 阶跃函数 → 输出 (0 或 1)
输入 x₃ → w₃
```

**核心公式**：

$$output = \begin{cases} 0 & \text{if } \sum w_i x_i + b \leq 0 \\ 1 & \text{if } \sum w_i x_i + b > 0 \end{cases}$$

其中：
- $w_i$ = 权重（weight）——每个输入的重要性
- $b$ = 偏置（bias）——神经元的"敏感度阈值"
- 阶跃函数 = 激活函数——决定神经元是否"兴奋"

### 类比：保安的判断

想象你是一个夜店保安（神经元）：
- **输入**：年龄（$x_1$）、穿着分数（$x_2$）、是否VIP（$x_3$）
- **权重**：年龄的重要性=$w_1$，穿着=$w_2$，VIP=$w_3$
- **偏置**：你有多严格——b高则谁都进不来
- **激活**：放行=1，拦下=0

**感知机就是一个"线性分类器"**——它在特征空间画一条线，把数据一分为二。

### 感知机学习算法

```python
# 感知机学习算法的伪代码
# 本质：错了就调整，直到全对

import numpy as np

class Perceptron:
    def __init__(self, learning_rate=0.01, n_epochs=100):
        self.lr = learning_rate  # 学习率：每次调整的步长
        self.n_epochs = n_epochs  # 训练轮数
        self.weights = None
        self.bias = None

    def fit(self, X, y):
        """训练感知机"""
        n_samples, n_features = X.shape

        # 初始化权重和偏置为0
        self.weights = np.zeros(n_features)
        self.bias = 0

        for epoch in range(self.n_epochs):
            # 逐样本训练（随机梯度下降的思想）
            for idx, x_i in enumerate(X):
                # 线性加权求和
                linear_output = np.dot(x_i, self.weights) + self.bias
                # 阶跃激活
                y_predicted = self._step_function(linear_output)

                # 核心：更新规则
                # 如果预测错误，朝正确方向调整权重
                # delta = 真实值 - 预测值（只有0, 1, -1三种可能）
                delta = y[idx] - y_predicted
                self.weights += self.lr * delta * x_i
                self.bias += self.lr * delta

        return self

    def _step_function(self, x):
        """阶跃激活函数"""
        return np.where(x >= 0, 1, 0)  # >=0 输出1，否则0

    def predict(self, X):
        """预测新样本"""
        linear_output = np.dot(X, self.weights) + self.bias
        return self._step_function(linear_output)

# ----- 使用示例 -----
# X = np.array([[0,0], [0,1], [1,0], [1,1]])  # AND 问题
# y = np.array([0, 0, 0, 1])  # AND 真值表
# p = Perceptron(learning_rate=0.1, n_epochs=10)
# p.fit(X, y)
# print(p.predict(X))  # 输出 [0 0 0 1] —— AND 可以解决
# 但如果是 XOR 问题 ([0,1,1,0]) —— 感知机永远学不会！
```

### 感知机的致命缺陷

| 问题 | 感知机能解决吗？ | 可视化 |
|:-----|:----------------:|:-------|
| AND（与） | ✅ 一条线分开 | 直线可分 |
| OR（或） | ✅ 一条线分开 | 直线可分 |
| XOR（异或） | ❌ 一条线不够 | 需要两条线 |

**这就是"线性不可分"问题。** XOR 需要非线性决策边界——单个感知机能做到的，只是在高维空间画一个超平面。

### 悬疑追问：为什么XOR需要两层？

```
XOR 的真相：
0 XOR 0 = 0
0 XOR 1 = 1     想象坐标轴：(0,0)和(1,1)是一类，(0,1)和(1,0)是另一类
1 XOR 0 = 1     你无法用一条直线分开这四个点——但两条线可以
1 XOR 1 = 0
```

- 🧠 答案的种子已经埋下：**多层**。
- ❓ **悬疑追问**：如果一层不够，多少层才够？深度学习到底需要"多深"？

---

### ✅ 费曼三句话（🍅46）

> 1. **感知机就是一个"电子保安"**——对输入加权求和，超过阈值就放行（输出1），否则拦下（输出0）。
> 2. **它只能在数据空间画一条直线**——所以像XOR这种需要"绕弯"的问题，单层感知机永远搞不定。
> 3. **这个局限不是感知机的失败，而是多层网络的序章**——一个神经元不够，那就用一群。

---

## 🍅47 多层感知机——隐藏层的秘密

### 🔍 破案突破：隐藏层就是"看不见的推理层"

回到XOR问题。如果我们把两个感知机组合起来呢？

```
第一层：   第二层：
x₁ → [P1]  \
              → [P3] → 输出
x₂ → [P2]  /
```

- P1 识别"左半边的模式"
- P2 识别"右半边的模式"
- P3 组合P1和P2的结果——**这就是推理**

**隐藏层（Hidden Layer）** 就是"看不见的中间推理步骤"。

### 多层感知机的架构

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│ 输入层   │────▶│ 隐藏层   │────▶│ 输出层   │
│ (Input)  │     │ (Hidden) │     │ (Output) │
├─────────┤     ├─────────┤     ├─────────┤
│ 特征 x₁  │     │ 神经元 h₁│     │ 预测 ŷ₁  │
│ 特征 x₂  │     │ 神经元 h₂│     │ 预测 ŷ₂  │
│ 特征 x₃  │     │ 神经元 h₃│     │          │
│ ...      │     │ ...      │     │          │
└─────────┘     └─────────┘     └─────────┘
     ↑               ↑               ↑
   原始数据       抽象特征         最终决策
```

### 为什么"深"比"宽"更强大？

**宽网络**（一层很多神经元）= 很多保安各自判断 → 但信息没有深化处理

**深网络**（多层神经元）= 初级保安 → 中级主管 → 高级经理 → 最终决策

每一层都在**逐步抽象**：
- 第一层：检测边缘、纹理（低级特征）
- 第二层：组合边缘成形状（中级特征）
- 第三层：组合形状成物体（高级特征）
- 最后一层：做出决策

```python
# 多层感知机的伪代码（手动前向传播）
# 帮助理解"层"的概念

import numpy as np

class Layer:
    """神经网络的一层"""
    def __init__(self, n_inputs, n_neurons, activation='sigmoid'):
        # 权重矩阵：n_inputs × n_neurons
        # 为什么是矩阵？因为每个输入连接到每个神经元
        self.weights = np.random.randn(n_inputs, n_neurons) * 0.1
        # 偏置：每个神经元一个
        self.bias = np.zeros((1, n_neurons))
        self.activation = activation

    def forward(self, inputs):
        """前向传播：输入 → 加权求和 → 激活"""
        self.inputs = inputs
        # 矩阵乘法：批量计算所有连接的加权和
        self.z = np.dot(inputs, self.weights) + self.bias
        # 激活函数引入非线性
        if self.activation == 'sigmoid':
            self.output = 1 / (1 + np.exp(-self.z))
        elif self.activation == 'relu':
            self.output = np.maximum(0, self.z)
        return self.output


class MLP:
    """多层感知机"""
    def __init__(self):
        # 构建一个3层网络：2→4→1
        # 2个输入特征，4个隐藏神经元，1个输出
        self.hidden = Layer(2, 4, activation='sigmoid')  # 隐藏层
        self.output = Layer(4, 1, activation='sigmoid')  # 输出层

    def forward(self, X):
        """完整的前向传播"""
        # 输入 → 隐藏层 → 输出层
        hidden_output = self.hidden.forward(X)
        final_output = self.output.forward(hidden_output)
        return final_output

    def predict(self, X):
        """预测"""
        return np.round(self.forward(X))


# ----- 为什么两层就能解决XOR？ -----
# 可视化直觉：
# 第一层：把输入空间"扭曲"成线性可分的表示
# 第二层：在这个新表示上做线性分类
#
# 输入空间       隐藏层空间        输出
# (0,0) ──→  [0.5, 0.5, ...] ──→  0
# (0,1) ──→  [0.9, 0.1, ...] ──→  1  ← 被重新排列了！
# (1,0) ──→  [0.1, 0.9, ...] ──→  1
# (1,1) ──→  [0.5, 0.5, ...] ──→  0
#
# 隐藏层相当于把坐标轴"掰弯"了，
# 使得原来线性不可分的数据变得线性可分！
```

### 深度学习的"深"到底多深？

| 年代 | 网络深度 | 代表 | 能力 |
|:----:|:--------:|:-----|:-----|
| 1960s | 1层 | 感知机 | 线性分类 |
| 1980s | 2-3层 | MLP | 简单非线性 |
| 2000s | 5-10层 | LeNet | 手写数字识别 |
| 2010s | 50-100层 | ResNet | 图像识别冠军 |
| 2020s | 1000+层 | 超大模型 | 语言理解、生成 |

> **关键洞察**：每增加一层，网络就能学习更抽象的表示。但更深的网络需要更精巧的训练方法——这就是反向传播登场的理由。

---

### ✅ 费曼三句话（🍅47）

> 1. **多层感知机就是"层层递进的推理链"**——第一层看细节，第二层看模式，第三层做决策，跟侦探破案层层深入一样。
> 2. **隐藏层是"看不见的思考空间"**——它把原始输入"扭曲"成一个线性可分的表示，这就是XOR能被解决的秘密。
> 3. **深度不是炫技，而是抽象层次的堆叠**——问题是：层数越深，怎么训练就越难。反向传播就是来解决这个的。

---

## 🍅48 反向传播——神经网络的学习引擎

### 🔍 犯罪现场还原：一个网络怎么"学习"？

> 想象你是一个新手厨师，第一次做红烧肉。你尝了一口——太咸了。
>
> 你往回推理：
> - 太咸 → 盐放多了 → 下次少放5克
> - 下次再尝 → 还是咸 → 再少放3克
> - 直到恰到好处
>
> **反向传播（Backpropagation）就是这个"尝一口→往回推理→调整配方"的数学版本。**

### 链式法则：反向传播的数学心脏

反向传播的本质就是**微积分的链式法则（Chain Rule）**：

$$\frac{\partial L}{\partial w} = \frac{\partial L}{\partial \hat{y}} \cdot \frac{\partial \hat{y}}{\partial z} \cdot \frac{\partial z}{\partial w}$$

翻译成人话：
- $L$ = 损失（Loss）= 预测有多离谱
- $\hat{y}$ = 预测值
- $z$ = 加权求和结果
- $w$ = 权重

**链式法则说**：要知道"权重的微小变化如何影响最终损失"，就把一路上所有"局部变化率"乘起来。

### 梯度下降：下山 analogy

想象你站在一座山上（损失函数的表面），大雾笼罩，看不见全貌。你想下山（最小化损失），怎么办？

1. 感受脚下的坡度（计算梯度）
2. 往最陡的下坡方向迈一步（更新权重）
3. 重复

```python
# 反向传播的完整实现
# 从零开始，不依赖框架

import numpy as np

class NeuralNetwork:
    """
    一个 2→4→1 的神经网络
    手动实现前向传播和反向传播
    """
    def __init__(self):
        # 初始化权重（小随机数）
        np.random.seed(42)
        # 输入层→隐藏层：2×4
        self.w1 = np.random.randn(2, 4) * 0.1
        self.b1 = np.zeros((1, 4))
        # 隐藏层→输出层：4×1
        self.w2 = np.random.randn(4, 1) * 0.1
        self.b2 = np.zeros((1, 1))

    def sigmoid(self, z):
        """Sigmoid激活函数"""
        return 1 / (1 + np.exp(-np.clip(z, -500, 500)))

    def sigmoid_derivative(self, z):
        """Sigmoid的导数（用于反向传播）"""
        s = self.sigmoid(z)
        return s * (1 - s)  # sigmoid的导数 = sigmoid * (1 - sigmoid)

    def forward(self, X):
        """前向传播"""
        # 隐藏层
        self.z1 = np.dot(X, self.w1) + self.b1  # 加权求和
        self.a1 = self.sigmoid(self.z1)          # 激活（隐藏层输出）
        # 输出层
        self.z2 = np.dot(self.a1, self.w2) + self.b2
        self.a2 = self.sigmoid(self.z2)          # 最终输出
        return self.a2

    def backward(self, X, y, output):
        """反向传播——核心考点！"""
        m = X.shape[0]  # 样本数量

        # ---- 第一步：计算输出层的误差 ----
        # 损失函数：均方误差 (MSE)
        # dL/d_a2 = -(y - a2)  即预测与真实的差异
        dL_da2 = -(y - output)

        # ---- 第二步：链式法则往回推 ----
        # 输出层梯度：
        # dL/dz2 = dL/da2 * da2/dz2
        #        = -(y - a2) * sigmoid'(z2)
        d_a2_d_z2 = self.sigmoid_derivative(self.z2)
        dL_dz2 = dL_da2 * d_a2_d_z2  # 输出层的"误差信号"

        # 隐藏层到输出层的权重梯度：
        # dL/dw2 = dL/dz2 * dz2/dw2
        #        = dL/dz2 * a1^T
        d_w2 = np.dot(self.a1.T, dL_dz2) / m
        d_b2 = np.sum(dL_dz2, axis=0, keepdims=True) / m

        # ---- 第三步：误差继续往回传播到隐藏层 ----
        # 隐藏层的误差 = 输出层误差反向传播 + 本层激活函数的导数
        dL_da1 = np.dot(dL_dz2, self.w2.T)  # 误差通过w2反向传播
        d_a1_d_z1 = self.sigmoid_derivative(self.z1)
        dL_dz1 = dL_da1 * d_a1_d_z1

        # 输入层到隐藏层的权重梯度
        d_w1 = np.dot(X.T, dL_dz1) / m
        d_b1 = np.sum(dL_dz1, axis=0, keepdims=True) / m

        return d_w1, d_b1, d_w2, d_b2

    def update(self, d_w1, d_b1, d_w2, d_b2, lr=0.1):
        """梯度下降更新权重"""
        self.w1 -= lr * d_w1
        self.b1 -= lr * d_b1
        self.w2 -= lr * d_w2
        self.b2 -= lr * d_b2

    def train(self, X, y, epochs=10000, lr=0.1, verbose=True):
        """训练循环"""
        for i in range(epochs):
            # 前向传播
            output = self.forward(X)
            # 反向传播
            grads = self.backward(X, y, output)
            # 更新权重
            self.update(*grads, lr)

            if verbose and i % 1000 == 0:
                loss = np.mean((y - output) ** 2)
                print(f"Epoch {i}, Loss: {loss:.6f}")

    def predict(self, X):
        return np.round(self.forward(X))


# ----- 验证：用XOR问题测试 -----
X = np.array([[0,0], [0,1], [1,0], [1,1]])
y = np.array([[0], [1], [1], [0]])  # XOR

nn = NeuralNetwork()
print("训练前预测：", nn.predict(X).flatten())
nn.train(X, y, epochs=10000, lr=0.5)
print("训练后预测：", nn.predict(X).flatten())
# 预期输出：[0 1 1 0] —— 多层 + 反向传播 终于解决了XOR！
```

### 反向传播的三步曲

```
1️⃣ 前向传播：输入 → 逐层计算 → 得到预测值
2️⃣ 计算损失：预测值 vs 真实值 → 得到误差
3️⃣ 反向传播：误差 ← 逐层 ← 计算每个权重的"责任"
       ↕
  更新权重：朝减少误差的方向调整
```

### 训练中的陷阱

| 问题 | 现象 | 解决 |
|:-----|:-----|:-----|
| 梯度消失 | 深层梯度趋近0，不学习 | ReLU、BatchNorm、残差连接 |
| 梯度爆炸 | 梯度太大，权重震荡 | 梯度裁剪、小学习率 |
| 过拟合 | 记住数据而不是学习 | Dropout、正则化、更多数据 |
| 陷入局部最优 | 停在次优解 | 动量、Adam优化器、随机初始化 |

---

### ✅ 费曼三句话（🍅48）

> 1. **反向传播就是"用链式法则反向计算每个权重的责任"**——前向传播算出错了多少，反向传播算出每个权重该为这个错误负多少责。
> 2. **梯度下降是"摸着石头下山"**——你不需要知道整座山的样子，只需要感受脚下的坡度（梯度），往最陡的下坡方向走一步，不断重复。
> 3. **深层网络的训练困难（梯度消失/爆炸）不是反向传播的错，而是链式法则连乘的必然结果**——这也是为什么后来需要ReLU、残差连接等技巧。

---

## 🍅49 激活函数——非线性的力量

### 🔍 为什么需要"不听话"的神经元？

如果没有激活函数，多层网络会变成什么？

```python
# 没有激活函数的"线性"多层网络
layer1 = W1 * x + b1
layer2 = W2 * layer1 + b2 = W2*(W1*x + b1) + b2 = (W2*W1)*x + (W2*b1+b2)
# ↑ 还是线性！两层合并成一层！
```

**没有非线性的多层网络 = 一层网络的"伪装"**。无论堆多少层，最终等价于一个线性变换。

**激活函数的作用就是"打破线性"**——让每一层都能学习到新的、不同的特征。

### 三大主流激活函数

#### 1️⃣ Sigmoid：历史功臣

$$sigmoid(x) = \frac{1}{1 + e^{-x}}$$

```
特性：
- 输出范围：(0, 1)——天然的"概率"
- 平滑、可导
- 但：两端梯度几乎为0 → 梯度消失
```

**类比**：Sigmoid像一个"是否录取"的决策——输出0.99表示"非常肯定录取"，0.01表示"非常肯定不录取"。

**问题**：当网络很深时，链式法则连乘多个接近0的梯度，梯度消失。

#### 2️⃣ Tanh：升级版Sigmoid

$$tanh(x) = \frac{e^x - e^{-x}}{e^x + e^{-x}}$$

```
特性：
- 输出范围：(-1, 1)——有正负
- 零中心化（比Sigmoid好）
- 但：两端梯度还是接近0
```

**类比**：Tanh像"情感评分"——-1表示极度负面，0表示中立，+1表示极度正面。

#### 3️⃣ ReLU：现代DL的基石

$$ReLU(x) = max(0, x)$$

```
特性：
- 输出范围：[0, +∞)
- 计算极快：就是个max(0, x)
- x > 0时梯度恒为1 → 解决梯度消失！
- 但：x < 0时梯度为0 → "神经元死亡"
```

**类比**：ReLU像一个"只有正反馈的喇叭"——正向信号放大传递，负向信号直接静音。

### 为什么ReLU是革命性的？

| 特性 | Sigmoid | Tanh | ReLU |
|:-----|:-------:|:----:|:----:|
| 计算速度 | 慢（指数运算） | 慢（指数运算） | 极快（max） |
| 梯度消失问题 | 严重 | 有改善 | 几乎解决 |
| 输出范围 | (0, 1) | (-1, 1) | [0, ∞) |
| 是否零中心 | 否 | **是** | 否 |
| 死亡神经元 | 无 | 无 | 有 |
| 现代应用 | 输出层 | RNN中常用 | **隐藏层首选** |

```python
# 三种激活函数及其导数的可视化
import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def sigmoid_derivative(x):
    s = sigmoid(x)
    return s * (1 - s)

def tanh(x):
    return np.tanh(x)

def tanh_derivative(x):
    return 1 - np.tanh(x)**2

def relu(x):
    return np.maximum(0, x)

def relu_derivative(x):
    return np.where(x > 0, 1, 0)  # x>0时导数为1，否则0

# ---- 关键观察 ----
# 当 x 很大或很小时：
print(f"Sigmoid导数(10): {sigmoid_derivative(10):.10f}")  # ≈ 0  → 梯度消失！
print(f"Tanh导数(10):   {tanh_derivative(10):.10f}")     # ≈ 0  → 梯度消失！
print(f"ReLU导数(10):   {relu_derivative(10)}")          # = 1  → 梯度畅通！
# ReLU在正区间的梯度永远是1——这就是它解决梯度消失的秘密！
```

### 现代激活函数家族

```
第一代：Sigmoid / Tanh  ── 经典但梯度消失
    │
第二代：ReLU ── 简单粗暴，深度学习标配
    │
第三代：LeakyReLU / PReLU / ELU ── 修复ReLU的"死亡神经元"问题
    │
第四代：Swish / GELU ── 自门控，更平滑
```

**LeakyReLU**：$f(x) = max(\alpha x, x)$，其中$\alpha$很小（如0.01）
- 负区间不再死透，而是"漏"一点信号

**GELU**（GPT使用的激活函数）：$GELU(x) = x \cdot \Phi(x)$
- 结合了ReLU的稀疏性和Sigmoid的平滑性

---

### ✅ 费曼三句话（🍅49）

> 1. **激活函数就是神经元的"脾气"**——Sigmoid是"温和的二元判断"，ReLU是"暴躁的非负放大器"，没有它们，深层网络就是一层线性变换的伪装。
> 2. **ReLU在正区间的梯度恒为1，这是深度学习能"深"下去的关键**——它让误差信号在反向传播时不会越传越弱。
> 3. **选激活函数就像选工具**——输出层选Sigmoid（二分类）或Softmax（多分类），隐藏层无脑选ReLU（或其变种）。

---

## 🍅50 实战：用PyTorch写第一个神经网络

### 🔍 悬疑收尾：从一个神经元到"会认数字"的AI

> 我们从1943年的一个逻辑门开始，到1957年重达一吨的感知机，再到1986年反向传播的诞生，最后到2012年深度学习引爆AI革命。
>
> **70年的进化，浓缩在5个番茄里。**
>
> 现在是时候亲手造一个"活的"神经网络了——它能识别手写数字，就像早期的LeNet一样。

### 环境准备

```python
# 安装 PyTorch
# pip install torch torchvision

import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
from torch.utils.data import DataLoader
from torchvision import datasets, transforms
import matplotlib.pyplot as plt
import numpy as np

# 设置随机种子保证可复现
torch.manual_seed(42)
```

### 第1步：加载数据（MNIST手写数字）

```python
# MNIST = 70000张28×28的手写数字图片
# 就像侦探的"嫌疑人照片库"

transform = transforms.Compose([
    transforms.ToTensor(),  # 图片 → PyTorch张量
    transforms.Normalize((0.1307,), (0.3081,))  # 标准化（均值, 标准差）
])

train_dataset = datasets.MNIST(
    root='./data', train=True,
    download=True, transform=transform
)
test_dataset = datasets.MNIST(
    root='./data', train=False,
    transform=transform
)

train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)
test_loader = DataLoader(test_dataset, batch_size=1000, shuffle=False)

# 看一眼数据长什么样
images, labels = next(iter(train_loader))
# images.shape = [64, 1, 28, 28]  ← 64张图, 1通道, 28×28像素
# labels.shape = [64]             ← 对应的64个标签（0-9）
```

### 第2步：定义一个神经网络

```python
class HandwritingNet(nn.Module):
    """
    一个用于MNIST的简单全连接神经网络
    架构：784 → 128 → 64 → 10
    """
    def __init__(self):
        super().__init__()
        # nn.Linear(in_features, out_features) = 全连接层
        self.fc1 = nn.Linear(28*28, 128)  # 第一隐藏层
        self.fc2 = nn.Linear(128, 64)     # 第二隐藏层
        self.fc3 = nn.Linear(64, 10)      # 输出层（10个数字）
        self.dropout = nn.Dropout(0.2)    # 防止过拟合

    def forward(self, x):
        """
        前向传播定义

        参数:
            x: 输入图像 [batch_size, 1, 28, 28]
               
        返回:
            10类的概率分布
        """
        # 展平：把 28×28 的图像拉直成 784 维向量
        x = x.view(-1, 28*28)

        # 第一层：线性变换 + ReLU激活
        x = F.relu(self.fc1(x))

        # Dropout随机丢弃20%的神经元（防止过拟合）
        x = self.dropout(x)

        # 第二层：线性变换 + ReLU激活
        x = F.relu(self.fc2(x))

        # 第三层（输出）：线性变换 → 10个分数
        x = self.fc3(x)

        # 注意：这里没有Softmax！
        # PyTorch的CrossEntropyLoss内部包含了Softmax
        # 如果直接使用，记得在预测时加F.softmax(x, dim=1)
        return x

# 实例化模型
model = HandwritingNet()
print(model)
# HandwritingNet(
#   (fc1): Linear(in_features=784, out_features=128, bias=True)
#   (fc2): Linear(in_features=128, out_features=64, bias=True)
#   (fc3): Linear(in_features=64, out_features=10, bias=True)
#   (dropout): Dropout(p=0.2, inplace=False)
# )
```

### 第3步：训练循环

```python
def train_model(model, train_loader, epochs=5):
    """
    训练神经网络

    参数:
        model: 待训练的模型
        train_loader: 训练数据加载器
        epochs: 训练轮数
    """
    # 损失函数：交叉熵（分类问题的标准选择）
    criterion = nn.CrossEntropyLoss()

    # 优化器：Adam（自适应学习率的梯度下降进阶版）
    optimizer = optim.Adam(model.parameters(), lr=0.001)

    model.train()  # 切换到训练模式

    for epoch in range(epochs):
        total_loss = 0
        correct = 0
        total = 0

        for batch_idx, (data, target) in enumerate(train_loader):
            # data: [64, 1, 28, 28], target: [64]

            # 梯度清零——每次迭代前必须做！
            optimizer.zero_grad()

            # 前向传播
            output = model(data)  # output: [64, 10]

            # 计算损失
            loss = criterion(output, target)

            # 反向传播——自动微分！一行代码搞定
            loss.backward()

            # 更新权重
            optimizer.step()

            # 统计
            total_loss += loss.item()
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.view_as(pred)).sum().item()
            total += len(data)

            if batch_idx % 100 == 0:
                print(f'  Batch {batch_idx}: Loss = {loss.item():.4f}')

        accuracy = 100. * correct / total
        print(f'Epoch {epoch+1}: Avg Loss = {total_loss/len(train_loader):.4f}, '
              f'Accuracy = {accuracy:.2f}%')
        print('---')

# 开始训练！
train_model(model, train_loader, epochs=5)
# 预期输出：
# Epoch 1: Accuracy ≈ 92%
# Epoch 5: Accuracy ≈ 98%  ← 仅仅5轮就达到98%！
```

### 第4步：测试模型

```python
def test_model(model, test_loader):
    """在测试集上评估模型"""
    model.eval()  # 切换到评估模式（关闭Dropout等）
    correct = 0
    total = 0

    # torch.no_grad()：关闭梯度计算（节省内存，加速推理）
    with torch.no_grad():
        for data, target in test_loader:
            output = model(data)
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.view_as(pred)).sum().item()
            total += len(data)

    accuracy = 100. * correct / total
    print(f'Test Accuracy: {accuracy:.2f}%')
    return accuracy

test_model(model, test_loader)
# 预期：≈ 97-98%
```

### 第5步：看看模型"认出"了什么

```python
def visualize_predictions(model, test_loader, num_images=10):
    """可视化模型的预测结果"""
    model.eval()
    images, labels = next(iter(test_loader))

    with torch.no_grad():
        outputs = model(images)
        _, predicted = torch.max(outputs, 1)

    plt.figure(figsize=(15, 4))
    for i in range(num_images):
        plt.subplot(1, num_images, i+1)
        plt.imshow(images[i].squeeze(), cmap='gray')
        color = 'green' if predicted[i] == labels[i] else 'red'
        plt.title(f'预测: {predicted[i]}\n实际: {labels[i]}', color=color)
        plt.axis('off')
    plt.tight_layout()
    plt.show()

# visualize_predictions(model, test_loader)
```

### 训练完成后，理解你的网络

```python
# 看看权重矩阵——这就是"神经元"学到的模式
import matplotlib.pyplot as plt

def visualize_weights(model):
    """可视化第一层权重的形状——每个神经元在"看"什么"""
    weights = model.fc1.weight.data.numpy()  # [128, 784]

    plt.figure(figsize=(12, 6))
    for i in range(min(16, weights.shape[0])):
        plt.subplot(4, 4, i+1)
        # 把784维权重reshape回28×28的图像
        plt.imshow(weights[i].reshape(28, 28), cmap='gray')
        plt.title(f'神经元 {i}')
        plt.axis('off')
    plt.tight_layout()
    plt.show()

# visualize_weights(model)
# 你会看到：每个神经元学习到了不同的笔画模式
# 有的认出横线，有的认出竖线，有的认出圆圈...
```

---

### 🧠 番茄50的知识全景：从微观到宏观

```
1943 ── 神经元数学建模 ── McCulloch & Pitts
  │
1957 ── 感知机 ── Rosenblatt ── 单一神经元，线性分类
  │
1969 ── AI寒冬 ── Minsky证明感知机局限
  │
1986 ── 反向传播 ── Rumelhart, Hinton, Williams ── 多层网络的训练方法
  │
2006 ── 深度学习觉醒 ── Hinton的深度信念网络
  │
2012 ── AlexNet ── GPU+ReLU+Dropout ── 深度学习引爆
```

---

### ✅ 费曼三句话（🍅50）

> 1. **今天的实战只用了50行核心代码，就复现了1986年改变世界的技术。**
> 2. **PyTorch把反向传播抽象成一行`.backward()`**——但理解它背后"链式法则×梯度下降"的原理，才是区分"调包侠"和"工程师"的关键。
> 3. **这个98%准确率的数字识别器，在今天看来只是起点**——但在2012年，同样的技术让AI识别准确率从75%跃升到85%，开启了深度学习革命。

---

### 🎯 刻意练习

#### 初级侦探（模仿）
1. 把隐藏层改为 `[784 → 256 → 128 → 64 → 10]`——4层网络，训练效果变好还是变差？为什么？
2. 把激活函数从ReLU换成Sigmoid——训练速度有什么变化？准确率呢？

#### 中级侦探（变式）
3. 修改学习率为 `[0.1, 0.01, 0.0001]`——观察收敛速度和最终准确率的变化规律
4. 去掉Dropout——训练集准确率和测试集准确率差距变大吗？（过拟合观察）

#### 高级侦探（创造）
5. 用这个网络解决一个你身边的真实分类问题（比如区分猫和狗的照片），记录数据集、训练过程、最终准确率
6. 可视化隐藏层激活值——输入一张图片，看看每层神经元"兴奋"的程度，你能解释网络在"看"什么吗？

#### 📝 探究笔记
```markdown
今天的困惑：
- 梯度消失到底是什么感觉？是网络完全不更新了还是更新极慢？
- 有没有一种情况，网络层数增加反而准确率降低？
- Batch Normalization是怎么解决梯度消失的？

实验记录：
- 最佳学习率：___
- 最佳层数：___
- 达到 95% 准确率需要的轮数：___
```

---

### 📌 连线思考

> - **现实连接**：你现在使用的手机面部解锁、银行支票OCR、快递单号识别——底层都是今天学到的技术。
> - **历史视角**：从1943年到2026年，神经网络经历了三次寒冬和三次复兴。每次复兴，都是因为"算力+数据+算法"三要素同时突破。
> - **关键转折**：2012年AlexNet用GPU训练深度网络赢得ImageNet比赛——从此GPU成为"AI的石油"。
> - **下集预告**：Day11中，全连接网络将被"卷积"取代——AI从此真正"看见"了世界。

---

> **📚 参考**：[[书库/人工智能/人工智能算法  卷3  深度学习和神经网络]] · [[书库/人工智能/深度学习 ]] · [[书库/人工智能/从神经科学到心理学系列套装（13册）_脑与意识]]
