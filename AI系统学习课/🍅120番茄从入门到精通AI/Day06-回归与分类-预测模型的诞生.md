---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#机器学习"
  - "#线性回归"
  - "#逻辑回归"
  - "#KNN"
  - "#朴素贝叶斯"
  - "#番茄26-30"
aliases:
  - Day06
  - 回归与分类
  - 预测模型的诞生
---

# Day06：回归与分类——预测模型的诞生 🍅26-30

> **侦探笔记**：昨天的番茄我们知道了"三种学习范式"——今天，我们要开始亲手打造第一个真正的预测模型。

---

## 案发现场：两个问题，改变世界

想象你坐在一家银行的信贷办公室里。

你的上司走进来，扔给你两份任务：

**任务一："这栋房子值多少钱？"**

你手上有一套房子的数据：面积120平米，3室2厅，朝南，15楼，靠近地铁站。你需要给出一**具体数字**——¥3,200,000，不是"中等价位"，不是"比较贵"——而是一个精确的预测。

**任务二："这笔贷款该不该批？"**

另一个人申请贷款。你有他的信息：月收入¥15,000，信用分720，已有房贷，逾期记录0次。你需要给出一个**二选一的判断**——批，还是不批。

这两个任务，代表了监督学习中最重要的两个分支：

```
监督学习
    │
    ├── 回归（Regression）→ 输出连续的数值 → "值多少钱？"
    │
    └── 分类（Classification）→ 输出离散的标签 → "批不批？"
```

今天，我们将围绕这两个问题，打造四个经典的预测模型。

---

## 🍅 番茄26：线性回归——找到最佳拟合直线

### 悬疑开场：最小二乘法的"原罪"

想象你在犯罪现场发现了一组脚印。

脚印的深度和人的体重之间有关系吗？你量了5个人的脚印深度和体重：

| 脚印深度(cm) | 体重(kg) |
|:------------:|:--------:|
| 1.0 | 45 |
| 1.5 | 52 |
| 2.0 | 58 |
| 2.5 | 68 |
| 3.0 | 73 |

你想知道：如果发现一个脚印深度2.2cm，嫌疑人的体重大概是多少？

**你需要的，就是一条直线。**

线性回归干的事情，就是找到这条"最佳"直线——所谓"最佳"，就是让所有数据点到直线的**垂直距离的平方和最小**。

这就叫**最小二乘法（Ordinary Least Squares, OLS）**。

### 数学直觉：一条直线的故事

一条直线的公式：

```
y = wx + b

其中：
- y = 预测值（体重）
- x = 特征（脚印深度）
- w = 权重/斜率（脚印每深1cm，体重增加多少kg）
- b = 偏置/截距（脚印深度为0时的体重，不一定有意义）
```

**线性回归要做的：找到最好的 w 和 b。**

### "最好"的数学定义：损失函数

"最好"不是感觉，而是数学：

```
损失函数（均方误差 MSE）= 1/n × Σ(y真实 - y预测)²

为什么用平方？三个原因：
1. 正负误差不会抵消（-5和+5的平均不是0）
2. 大误差被放大（平方让大误差更"痛"）
3. 数学性质好（可导，容易优化）
```

### 完整代码：从零实现线性回归

```python
# === 案例：用脚印深度预测体重（线性回归完整实现） ===

import numpy as np
import matplotlib.pyplot as plt

# ========== 第一步：准备数据 ==========
# 模拟数据：脚印深度 vs 体重
footprint_depth = np.array([1.0, 1.5, 2.0, 2.5, 3.0])
weight = np.array([45, 52, 58, 68, 73])

print("=" * 50)
print("案件数据：脚印深度 → 体重")
print("=" * 50)
for depth, w in zip(footprint_depth, weight):
    print(f"  脚印 {depth:.1f}cm → 体重 {w}kg")

# ========== 第二步：用最小二乘法求解 w 和 b ==========
# 从零推导，不用sklearn
n = len(footprint_depth)
x_mean = np.mean(footprint_depth)
y_mean = np.mean(weight)

# 计算 w = Σ((x - x̄)(y - ȳ)) / Σ((x - x̄)²)
numerator = np.sum((footprint_depth - x_mean) * (weight - y_mean))
denominator = np.sum((footprint_depth - x_mean) ** 2)
w = numerator / denominator

# 计算 b = ȳ - w × x̄
b = y_mean - w * x_mean

print(f"\n计算过程：")
print(f"  平均脚印深度：{x_mean:.2f}cm")
print(f"  平均体重：{y_mean:.1f}kg")
print(f"  分子 Σ((x-x̄)(y-ȳ)) = {numerator:.2f}")
print(f"  分母 Σ((x-x̄)²) = {denominator:.2f}")
print(f"\n✅ 模型训练完成！")
print(f"  体重 = {w:.2f} × 脚印深度 + ({b:.2f})")
print(f"  解释：脚印每深1cm，体重增加约{w:.2f}kg")

# ========== 第三步：做预测 ==========
def predict(depth):
    """用训练好的线性模型做预测"""
    return w * depth + b

# 预测嫌疑人（脚印深度2.2cm）
suspect_depth = 2.2
suspect_weight = predict(suspect_depth)
print(f"\n🔍 案件预测：")
print(f"  嫌疑人脚印深度：{suspect_depth}cm")
print(f"  预测嫌疑人体重：{suspect_weight:.1f}kg")

# ========== 第四步：评估模型 ==========
# 计算预测值和真实值的差异
predictions = predict(footprint_depth)
errors = weight - predictions
mse = np.mean(errors ** 2)  # 均方误差
rmse = np.sqrt(mse)         # 均方根误差（更直观）

print(f"\n📊 模型评估：")
print(f"  均方误差(MSE)：{mse:.2f}")
print(f"  均方根误差(RMSE)：{rmse:.2f}kg")
print(f"  （RMSE的意思是：平均预测偏差约{rmse:.1f}kg）")

# 逐个对比
print(f"\n真实 vs 预测 对比：")
for d, real, pred in zip(footprint_depth, weight, predictions):
    diff = real - pred
    print(f"  脚印{d:.1f}cm：真实{real}kg vs 预测{pred:.1f}kg（偏差{diff:+.1f}kg）")

# ========== 第五步：可视化 ==========
plt.figure(figsize=(10, 6))
# 数据点
plt.scatter(footprint_depth, weight, color='blue', s=150,
            label='真实数据', zorder=5)
# 拟合直线
x_line = np.linspace(0.5, 3.5, 100)
y_line = predict(x_line)
plt.plot(x_line, y_line, color='red', linewidth=2,
         label=f'拟合直线: y = {w:.2f}x + {b:.2f}')
# 预测点
plt.scatter([suspect_depth], [suspect_weight], color='green', s=200,
            marker='*', label=f'预测: {suspect_weight:.1f}kg', zorder=6)
# 误差线（展示每个点的预测误差）
for depth, real, pred in zip(footprint_depth, weight, predictions):
    plt.plot([depth, depth], [real, pred], 'k--', alpha=0.5, linewidth=1)

plt.xlabel('脚印深度 (cm)')
plt.ylabel('体重 (kg)')
plt.title('线性回归：脚印深度 → 体重预测')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

# ========== 使用sklearn实现（生产环境用这个） ==========
from sklearn.linear_model import LinearRegression

# sklearn版本只要3行
sklearn_model = LinearRegression()
sklearn_model.fit(footprint_depth.reshape(-1, 1), weight)  # 训练
sklearn_pred = sklearn_model.predict([[suspect_depth]])[0]  # 预测

print(f"\n🤖 sklearn结果验证：")
print(f"  w = {sklearn_model.coef_[0]:.2f}, b = {sklearn_model.intercept_:.2f}")
print(f"  预测体重：{sklearn_pred:.1f}kg")
print(f"  （和手工计算结果一致！）")

# === 核心洞察 ===
# 线性回归是最简单的机器学习模型，但它揭示了所有监督学习的本质：
# 1. 选择一个模型结构（在这里是直线 y=wx+b）
# 2. 定义一个损失函数（在这里是MSE）
# 3. 优化参数（在这里是最小二乘法）
# 所有的深度学习模型，都是这个模式的复杂化
```

### 线性回归的局限

```
优点：
✅ 简单、快速、可解释
✅ 是许多复杂模型的基础
✅ 对线性关系效果极好

缺点：
❌ 只能捕捉线性关系
❌ 对异常值敏感
❌ 需要满足一些统计假设（如误差独立同分布）
❌ 复杂现实问题往往不是线性的
```

---

✋ **费曼自测**

> 用一句话向一个初中生解释线性回归：
>
> "假设你记录了一周每天的温度和冰淇淋销量，线性回归就是画一条穿过这些点的直线，让你能根据明天的温度预测大致能卖多少冰淇淋。"
>
> 问自己：如果数据不是直线关系（比如"学习时间 vs 考试成绩"，超过一定时间后成绩不再提升），线性回归还会有效吗？
> 答案：不会。这种情况需要用**多项式回归**或其他非线性模型。

---

## 🍅 番茄27：逻辑回归——明明是分类为什么叫"回归"？

### 悬疑开场：名字里藏着一个秘密

逻辑回归（Logistic Regression）——这可能是机器学习里**名字最误导人的算法**。

它叫"回归"，但它做的却是**分类**。

为什么？

故事要从一个"坏学生"的数据问题说起。

### 问题：线性回归做分类的致命缺陷

假设你想根据肿瘤大小判断是良性还是恶性：

```
肿瘤大小  →  良性(0) / 恶性(1)

数据：
0.5cm → 良性(0)
1.0cm → 良性(0)
1.5cm → 良性(0)
2.0cm → 恶性(1)
2.5cm → 恶性(1)
3.0cm → 恶性(1)
```

如果直接用线性回归：

```python
# 用线性回归做分类的问题演示
import numpy as np
import matplotlib.pyplot as plt

tumor_size = np.array([0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 5.0])  # 加了一个极端值5.0
malignant = np.array([0, 0, 0, 1, 1, 1, 1])

# 线性回归拟合
from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(tumor_size.reshape(-1, 1), malignant)

# 预测
test_sizes = np.linspace(0, 6, 100)
predictions = model.predict(test_sizes.reshape(-1, 1))

plt.figure(figsize=(10, 5))
plt.scatter(tumor_size, malignant, color='blue', s=100, label='真实数据')
plt.plot(test_sizes, predictions, color='red', linewidth=2, label='线性回归预测')
plt.axhline(y=0.5, color='gray', linestyle='--', alpha=0.5)
plt.axvline(x=1.75, color='gray', linestyle='--', alpha=0.5)
plt.xlabel('肿瘤大小 (cm)')
plt.ylabel('恶性概率')
plt.title('用线性回归做分类的问题：预测值可能小于0或大于1')
plt.ylim(-0.5, 1.8)
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

# 问题展示：线性回归的预测值范围是(-∞, +∞)
# 但概率的范围是[0, 1]
# 所以线性回归不适合直接做分类！
```

**问题所在**：
- 线性回归的输出范围是 (-∞, +∞)
- 概率的范围是 [0, 1]
- 我们需要一种方法把 (-∞, +∞) "压缩"到 [0, 1]

### Sigmoid函数的魔法

这就是 **Sigmoid 函数** 登场的地方：

```
Sigmoid: σ(z) = 1 / (1 + e^(-z))

当 z = 0 时，σ(z) = 0.5
当 z → +∞ 时，σ(z) → 1
当 z → -∞ 时，σ(z) → 0
```

它的形状是一条**S型曲线**——完美地把任何实数映射到(0, 1)之间。

```python
# === Sigmoid函数可视化 ===
import numpy as np
import matplotlib.pyplot as plt

def sigmoid(z):
    """Sigmoid函数：把任意实数压缩到[0,1]之间"""
    return 1 / (1 + np.exp(-z))

# 生成从-10到10的数值
z = np.linspace(-10, 10, 100)
s = sigmoid(z)

plt.figure(figsize=(10, 5))
plt.plot(z, s, color='purple', linewidth=3, label='Sigmoid函数')
plt.axhline(y=0.5, color='gray', linestyle='--', alpha=0.5, label='决策边界 (y=0.5)')
plt.axhline(y=0, color='gray', linestyle=':', alpha=0.3)
plt.axhline(y=1, color='gray', linestyle=':', alpha=0.3)
plt.axvline(x=0, color='gray', linestyle='--', alpha=0.3)
plt.xlabel('z (线性组合的输出)')
plt.ylabel('σ(z) (预测概率)')
plt.title('Sigmoid函数：把(-∞, +∞)映射到(0, 1)')
plt.legend()
plt.grid(True, alpha=0.3)

# 标注几个关键点
important_z = [-5, -2, 0, 2, 5]
for iz in important_z:
    plt.scatter([iz], [sigmoid(iz)], color='red', s=80, zorder=5)
    plt.annotate(f'σ({iz})={sigmoid(iz):.3f}',
                xy=(iz, sigmoid(iz)), xytext=(iz+1, sigmoid(iz)+0.1),
                arrowprops=dict(arrowstyle='->'), fontsize=9)

plt.show()

print("Sigmoid函数的关键特点：")
print(f"  σ(0) = {sigmoid(0):.2f}  → 中间点")
print(f"  σ(2) = {sigmoid(2):.3f}  → 正向大值")
print(f"  σ(5) = {sigmoid(5):.4f}  → 接近1")
print(f"  σ(-2) = {sigmoid(-2):.3f}  → 负向小值")
print(f"  σ(-5) = {sigmoid(-5):.4f}  → 接近0")

# === 核心洞察 ===
# 逻辑回归 = 线性回归 + Sigmoid
# 步骤1：做线性组合 z = wx + b（这就是"回归"部分的名字来源）
# 步骤2：通过Sigmoid转换成概率 σ(z)
# 步骤3：根据概率做分类（概率>0.5为类别1，否则为类别0）
```

### 完整案例：肿瘤分类器

```python
# === 案例：逻辑回归实现肿瘤良性/恶性分类 ===

import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix

# ========== 第一步：准备数据 ==========
# 特征：肿瘤大小(cm) 和 患者年龄
tumor_size = np.array([0.8, 1.2, 1.5, 1.8, 2.0, 2.2, 2.5, 2.8, 3.0, 3.5,
                       0.5, 1.0, 1.3, 1.6, 1.9, 2.1, 2.3, 2.7, 3.2, 4.0])
age = np.array([25, 30, 35, 40, 45, 50, 55, 60, 65, 70,
                28, 32, 38, 42, 48, 52, 58, 62, 68, 75])
# 标签：0=良性, 1=恶性
is_malignant = np.array([0, 0, 0, 0, 0, 1, 0, 1, 1, 1,
                         0, 0, 0, 0, 1, 1, 1, 1, 1, 1])

# 组合特征
X = np.column_stack([tumor_size, age])
y = is_malignant

print("=" * 50)
print("肿瘤数据概览")
print("=" * 50)
print(f"样本总数：{len(y)}")
print(f"良性肿瘤：{np.sum(y==0)} 个")
print(f"恶性肿瘤：{np.sum(y==1)} 个")
print()

# ========== 第二步：训练逻辑回归模型 ==========
model = LogisticRegression()
model.fit(X, y)

print("模型训练完成！")
print(f"学到的参数：")
print(f"  特征1权重（肿瘤大小）：{model.coef_[0][0]:.3f}")
print(f"  特征2权重（年龄）：{model.coef_[0][1]:.3f}")
print(f"  偏置(bias)：{model.intercept_[0]:.3f}")

# ========== 第三步：预测 ==========
# 预测单个样本
new_patient = np.array([[2.0, 45]])  # 肿瘤2.0cm，45岁
probability = model.predict_proba(new_patient)[0]
prediction = model.predict(new_patient)[0]

print(f"\n🔍 新患者预测：")
print(f"  肿瘤大小：{new_patient[0][0]}cm")
print(f"  年龄：{new_patient[0][1]}岁")
print(f"  良性概率：{probability[0]:.1%}")
print(f"  恶性概率：{probability[1]:.1%}")
print(f"  诊断结果：{'恶性' if prediction == 1 else '良性'}")

# ========== 第四步：评估模型 ==========
y_pred = model.predict(X)
accuracy = accuracy_score(y, y_pred)
cm = confusion_matrix(y, y_pred)

print(f"\n📊 模型评估：")
print(f"  训练集准确率：{accuracy:.2%}")

# 混淆矩阵
print(f"  混淆矩阵：")
print(f"             预测良性  预测恶性")
print(f"  实际良性    {cm[0][0]:5d}      {cm[0][1]:5d}")
print(f"  实际恶性    {cm[1][0]:5d}      {cm[1][1]:5d}")

# ========== 第五步：可视化决策边界 ==========
plt.figure(figsize=(10, 7))

# 绘制数据点
plt.scatter(X[y==0, 0], X[y==0, 1], color='green', s=100,
            marker='o', label='良性', edgecolors='black')
plt.scatter(X[y==1, 0], X[y==1, 1], color='red', s=100,
            marker='x', label='恶性', edgecolors='black')

# 绘制决策边界（概率=0.5的等高线）
x_min, x_max = X[:, 0].min() - 0.5, X[:, 0].max() + 0.5
y_min, y_max = X[:, 1].min() - 5, X[:, 1].max() + 5
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 200),
                     np.linspace(y_min, y_max, 200))
Z = model.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 1]
Z = Z.reshape(xx.shape)
plt.contourf(xx, yy, Z, levels=[0, 0.5, 1], colors=['lightgreen', 'lightcoral'],
             alpha=0.3, label='决策区域')
plt.contour(xx, yy, Z, levels=[0.5], colors='blue', linewidths=2,
            label='决策边界 (P=0.5)')

plt.xlabel('肿瘤大小 (cm)')
plt.ylabel('患者年龄')
plt.title('逻辑回归：肿瘤分类决策边界')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

# === 核心洞察 ===
# 逻辑回归虽然叫"回归"，但它做的是分类！
# 名字的来源是因为：它先做线性回归，然后用Sigmoid把结果转换成概率
```

---

✋ **费曼自测**

> 用三句话向一个非技术人员解释逻辑回归：
>
> 1. "逻辑回归的名字有误导——它实际是做**分类**的，不是做回归的。"
> 2. "它先像线性回归一样计算一个分数，然后用一个S型曲线（Sigmoid）把分数转成0-100%的概率。"
> 3. "概率超过50%就判断为A类，否则判断为B类。"
>
> 问自己：为什么 Sigmoid 函数选择 0.5 作为决策边界？
> 答案：不是必须的！你可以调整阈值。如果更在意不要漏掉恶性肿瘤（召回率优先），可以把阈值降到0.3。

---

## 🍅 番茄28：K近邻（KNN）——"近朱者赤"的算法版本

### 悬疑开场：最"懒"的机器学习算法

在机器学习的众多算法中，KNN（K-Nearest Neighbors，K近邻）可能是最"懒"的一个。

**它根本没有"训练"过程！**

其它算法：
```
训练阶段：学习参数（花几个小时、几天）
预测阶段：用学到的参数做预测（瞬间完成）
```

KNN：
```
训练阶段：啥也不干（就是把数据存起来）
预测阶段：开始工作（计算距离、找邻居、投票）
```

所以KNN也被称为**惰性学习（Lazy Learning）** 算法。

### 核心思想：邻居投票

KNN的理念极其简单，简单到让人怀疑"这也算机器学习？"

> **"一个人是什么样，看看他身边最近的K个朋友就知道了。"**

算法步骤只有3步：

```
1. 计算新数据点和所有训练数据之间的距离
2. 找出距离最近的K个点（邻居）
3. 让这K个邻居投票决定新数据点的类别（分类）或平均值（回归）
```

### 一个直觉例子

```
你搬到一个新小区，想知道这个小区的"档次"。

你观察了离你家最近的5户邻居：
  邻居1：年收入¥500,000  → 高档小区
  邻居2：年收入¥450,000  → 高档小区
  邻居3：年收入¥480,000  → 高档小区
  邻居4：年收入¥200,000  → 普通小区
  邻居5：年收入¥100,000  → 老旧小区

K=5投票：3票高档 vs 2票普通/老旧
结论：这是高档小区
```

### 完整代码：KNN手写数字识别

```python
# === 案例：用KNN识别手写数字（MNIST简化版） ===

import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, classification_report

# ========== 第一步：加载数据集 ==========
# sklearn自带的"小MNIST"：8×8像素的手写数字（0-9）
digits = load_digits()

# 数据集信息
print("=" * 50)
print("手写数字数据集信息")
print("=" * 50)
print(f"样本总数：{len(digits.data)}")
print(f"每张图片大小：8×8 = {digits.data.shape[1]} 像素")
print(f"类别（数字）：0-9 共{len(digits.target_names)}类")
print()

# ========== 第二步：理解数据 ==========
# 显示前10张图片
fig, axes = plt.subplots(2, 5, figsize=(10, 5))
for i, ax in enumerate(axes.flat):
    ax.imshow(digits.images[i], cmap='gray')
    ax.set_title(f'数字: {digits.target[i]}')
    ax.axis('off')
plt.suptitle('手写数字数据集样本')
plt.show()

# ========== 第三步：分割数据 ==========
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.3, random_state=42
)

print(f"训练集：{X_train.shape[0]} 个样本")
print(f"测试集：{X_test.shape[0]} 个样本")

# ========== 第四步：训练KNN模型 ==========
# 选择K=3（看看最近的3个邻居）
k = 3
knn = KNeighborsClassifier(n_neighbors=k)
knn.fit(X_train, y_train)  # 实际上KNN的"训练"就是存数据

print(f"\nKNN模型（K={k}）训练完成！")

# ========== 第五步：预测与评估 ==========
y_pred = knn.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

print(f"\n📊 KNN评估结果（K={k}）：")
print(f"  测试集准确率：{accuracy:.2%}")

# 显示分类报告（每个类别的精确率、召回率、F1）
print(f"\n详细分类报告：")
print(classification_report(y_test, y_pred))

# ========== 第六步：展示预测结果 ==========
# 随机选几个测试样本，展示真实值和预测值
n_show = 10
indices = np.random.choice(len(X_test), n_show, replace=False)

fig, axes = plt.subplots(2, 5, figsize=(12, 6))
for i, (idx, ax) in enumerate(zip(indices, axes.flat)):
    ax.imshow(X_test[idx].reshape(8, 8), cmap='gray')
    true_label = y_test[idx]
    pred_label = y_pred[idx]
    color = 'green' if true_label == pred_label else 'red'
    ax.set_title(f'真实:{true_label}\n预测:{pred_label}', color=color)
    ax.axis('off')
plt.suptitle(f'KNN预测结果（绿色=正确，红色=错误）')
plt.show()

# ========== 第七步：K值的影响 ==========
# 尝试不同的K值，观察准确率变化
print("\n📈 K值对准确率的影响：")
k_values = [1, 3, 5, 7, 9, 15, 21, 31]
for k in k_values:
    model = KNeighborsClassifier(n_neighbors=k)
    model.fit(X_train, y_train)
    acc = accuracy_score(y_test, model.predict(X_test))
    print(f"  K={k:2d} → 准确率={acc:.2%}")

# ========== 第八步：距离度量 ==========
print("\n📏 距离度量方式对比：")
from sklearn.neighbors import DistanceMetric
# 欧氏距离（默认）：直线距离
# 曼哈顿距离：街区距离（只能横着走或竖着走）
metrics = ['euclidean', 'manhattan', 'chebyshev']
for metric in metrics:
    model = KNeighborsClassifier(n_neighbors=5, metric=metric)
    model.fit(X_train, y_train)
    acc = accuracy_score(y_test, model.predict(X_test))
    print(f"  {metric:12s} → 准确率={acc:.2%}")

# === 核心洞察 ===
# KNN是最直观的机器学习算法——"近朱者赤，近墨者黑"
# 优点：无需训练、直观易懂、对非线性问题效果好
# 缺点：预测慢（要算所有距离）、受维度灾难影响大、需要归一化
```

### KNN的"维度灾难"

KNN有一个致命问题——**维度灾难（Curse of Dimensionality）**。

```
低维空间（2个特征）：
  每个点周围都"有邻居"
  
高维空间（100个特征）：
  所有点之间的距离都差不多大
  "最近的邻居"和"最远的邻居"差异很小
  KNN失去了区分能力
```

这是机器学习中反复出现的主题：**特征越多不代表效果越好**。

---

✋ **费曼自测**

> 用一个具体的场景解释KNN：
> "假设你去一个新城市找餐厅。你问酒店前台推荐。前台说：'看看这家酒店附近最受欢迎的3家餐厅，如果其中2家以上是川菜馆，那你大概率也喜欢川菜。'——这就是KNN。"
>
> 问自己：K值越大，模型越"平滑"。为什么？如果K=训练集总数，会发生什么？
> 答案：K=总数意味着所有数据点投票，结果永远是训练集中最多的那个类别（常数预测）。

---

## 🍅 番茄29：朴素贝叶斯——用概率做分类

### 悬疑开场：贝叶斯定理与一桩谋杀案

想象你是一桩谋杀案的侦探。

现场线索：
1. 凶手是左撇子（全城只有10%的人是左撇子）
2. 现场有凶手的DNA
3. 监控拍到凶手身高175cm以上

你逮捕了一个嫌疑人——他是左撇子。

**问题：他是凶手的概率有多大？**

你可能会想："全城10%的人是左撇子，所以概率是10%……"

**错！**

你忽略了其他线索的"先验信息"。

这正是 **贝叶斯定理** 的核心思想：

> **P(A|B) = P(B|A) × P(A) / P(B)**

```
P(凶手|左撇子) = P(左撇子|凶手) × P(凶手) / P(左撇子)

- P(凶手)：先验概率（案发前我们认为某人是凶手的概率，很小）
- P(左撇子|凶手)：似然（凶手是左撇子的概率，很大，接近100%）
- P(左撇子)：证据（全城左撇子的比例，10%）
- P(凶手|左撇子)：后验概率（知道嫌疑人是左撇子后，他是凶手的概率）
```

**关键是：先验 + 证据 = 后验**

这就是贝叶斯推理的本质——用新证据更新你的信念。

### 朴素贝叶斯分类器

朴素贝叶斯（Naive Bayes）就是把贝叶斯定理应用到分类问题中。

**"朴素"在哪里？**

它做了一个非常"朴素"的假设：

> **所有特征之间相互独立。**

翻译成人话：
- "苹果是红色的"和"苹果是圆的"这两个特征互不影响
- 知道苹果是红色的，但不能推出苹果是不是圆的

这个假设在现实中几乎**永远不成立**——但神奇的是，这个算法效果却出奇的好！

### 垃圾邮件过滤：朴素贝叶斯的经典战场

```
邮件内容："恭喜您获得100万奖金，点击领取！"

朴素贝叶斯要做的事：
P(垃圾邮件 | "恭喜" AND "奖金" AND "领取") 
  = P("恭喜"|垃圾) × P("奖金"|垃圾) × P("领取"|垃圾) × P(垃圾) / P(邮件)
```

```python
# === 案例：用朴素贝叶斯做垃圾邮件分类 ===

import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, confusion_matrix

# ========== 第一步：准备数据 ==========
# 模拟邮件数据（实际项目中会有成千上万封）
emails = [
    # 垃圾邮件
    "恭喜您中奖了 点击领取奖金",
    "免费领取 iPhone 点击链接",
    "限时优惠 全场五折 马上抢购",
    "您的账户异常 请立即验证",
    "恭喜获得100万 手续费仅需",
    "低价促销 限量发售 先到先得",
    "您的信用卡被盗刷 立即处理",
    # 正常邮件
    "明天下午三点开会 请准时参加",
    "项目进度报告已经发送",
    "本周五团建 请大家报名",
    "关于预算调整的批复通知",
    "客户拜访计划已确认",
    "新产品发布会的筹备进展",
    "请查收附件中的季度财务报表",
    "关于系统升级的维护通知",
]
labels = [1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]

print("=" * 50)
print("垃圾邮件分类数据")
print("=" * 50)
for email, label in zip(emails, labels):
    print(f"  {'[垃圾]' if label else '[正常]'} {email}")

# ========== 第二步：特征提取 ==========
# 把文本转换成数字向量（词袋模型）
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(emails)

# 查看词汇表
feature_names = vectorizer.get_feature_names_out()
print(f"\n词汇表大小：{len(feature_names)} 个词")
print(f"词汇表（部分）：{feature_names[:15]}")

# ========== 第三步：分词割数据 + 训练 ==========
X_train, X_test, y_train, y_test = train_test_split(
    X, labels, test_size=0.3, random_state=42
)

# 朴素贝叶斯分类器
nb_model = MultinomialNB()
nb_model.fit(X_train, y_train)

print(f"\n模型训练完成！")
print(f"训练集大小：{X_train.shape[0]} 封邮件")
print(f"测试集大小：{X_test.shape[0]} 封邮件")

# 查看学到的概率
print(f"\n🤔 模型学到的一些"知识"：")
# 展示每个词在垃圾邮件vs正常邮件中的重要性
log_prob = nb_model.feature_log_prob_
word_importance = []
for i, word in enumerate(feature_names):
    spam_prob = np.exp(log_prob[1, i])
    normal_prob = np.exp(log_prob[0, i])
    ratio = spam_prob / normal_prob if normal_prob > 0 else 999
    word_importance.append((word, ratio, spam_prob, normal_prob))

# 最"垃圾"的词
word_importance.sort(key=lambda x: x[1], reverse=True)
print(f"\n  最能标识垃圾邮件的词：")
for word, ratio, sp, nor in word_importance[:5]:
    print(f"    '{word}': 垃圾中出现概率={sp:.1%}, 正常中出现概率={nor:.1%}")

# 最"正常"的词
word_importance.sort(key=lambda x: x[1])
print(f"\n  最能标识正常邮件的词：")
for word, ratio, sp, nor in word_importance[:5]:
    print(f"    '{word}': 正常中出现概率={nor:.1%}, 垃圾中出现概率={sp:.1%}")

# ========== 第四步：预测 ==========
y_pred = nb_model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

print(f"\n📊 评估结果：")
print(f"  测试集准确率：{accuracy:.2%}")

# 混淆矩阵
cm = confusion_matrix(y_test, y_pred)
print(f"  混淆矩阵：")
print(f"              预测正常  预测垃圾")
print(f"  实际正常     {cm[0][0]:5d}      {cm[0][1]:5d}")
print(f"  实际垃圾     {cm[1][0]:5d}      {cm[1][1]:5d}")

# ========== 第五步：测试新邮件 ==========
test_emails = [
    "恭喜您获得大奖 点击领取",
    "关于下周的会议安排",
    "免费领取百万奖金",
    "项目进展顺利 请查收报告",
]

print(f"\n🔍 测试新邮件：")
for email in test_emails:
    email_vector = vectorizer.transform([email])
    proba = nb_model.predict_proba(email_vector)[0]
    pred = nb_model.predict(email_vector)[0]
    print(f"  内容：{email}")
    print(f"  正常概率：{proba[0]:.1%}  垃圾概率：{proba[1]:.1%}")
    print(f"  判断：{'🚫 垃圾邮件' if pred else '✅ 正常邮件'}\n")

# === 核心洞察 ===
# 朴素贝叶斯的核心思想：
# 1. 用训练数据统计每个词在各类别中出现的概率
# 2. 对新邮件，计算所有词联合起来的概率
# 3. 选择概率最大的类别
# 虽然"朴素"的独立性假设不现实，但它简单、快速、在小数据集上效果惊人！
```

### 贝叶斯 vs 频率派：两种世界观

| 维度 | 频率派 | 贝叶斯派 |
|:-----|:-------|:---------|
| **概率定义** | 长期频率 | 信念程度 |
| **参数** | 固定但未知 | 有不确定性（用分布表示） |
| **先验知识** | 不用 | 必须用 |
| **代表算法** | 线性回归、SVM | 朴素贝叶斯、贝叶斯网络 |
| **适合场景** | 大数据 | 小数据、需要不确定性估计 |

---

✋ **费曼自测**

> 用一个比喻解释朴素贝叶斯：
>
> "你是一个水果鉴定师。你想知道一个又红又圆的东西是苹果还是樱桃。
> 你翻看记录发现：80%的苹果是红色的，90%的樱桃是红色的；70%的苹果是圆的，80%的樱桃是圆的。
> 朴素贝叶斯会假设'红色'和'圆形'是独立的，然后计算它是苹果的概率和是樱桃的概率，选择较大的那个。"
>
> 问自己：如果特征之间高度相关（比如"包含'中奖'"和"包含'奖金'"几乎总是同时出现），朴素贝叶斯会出什么问题？
> 答案：它会"双倍计算"同一个证据，导致概率估计偏差。这就是为什么它"朴素"但有效——在实际中，即使概率值不准确，排名（哪个类别概率最高）往往还是对的。

---

## 🍅 番茄30：思维导图 + 对比总结

### 悬疑收尾：你今天打造的四个模型

今天，你从"两个问题"出发——预测房价（回归）和判断贷款（分类）——亲手打造了四个模型。

回顾一下：

```
回归：预测连续数值
  ├── 线性回归：找到最佳拟合直线（简单、可解释）
  │
分类：预测离散标签  
  ├── 逻辑回归：线性回归 + Sigmoid（分类利器）
  ├── K近邻：让邻居投票（直观、非参数）
  └── 朴素贝叶斯：用概率做决策（快速、小数据）
```

### 🧠 思维导图：回归与分类全景

```
┌─────────────────────────────────────────────────────────────────┐
│              📊 回归 vs 分类 · 四大模型对比                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  🔵 线性回归 (Linear Regression)                                │
│  ├─ 本质：学习 y = wx + b 的最佳 w 和 b                         │
│  ├─ 优化目标：最小化均方误差（MSE）                              │
│  ├─ 优点：简单、快速、可解释性最强                               │
│  ├─ 缺点：只能拟合线性关系、对异常值敏感                          │
│  └─ 适用：房价预测、销售预测、趋势分析                            │
│                                                                  │
│  🟠 逻辑回归 (Logistic Regression)                              │
│  ├─ 本质：线性回归 + Sigmoid → 概率                             │
│  ├─ 优化目标：最大化似然（让预测概率尽量接近真实标签）              │
│  ├─ 优点：输出概率（可解释）、计算快、正则化友好                    │
│  ├─ 缺点：决策边界是线性的、特征工程要求高                         │
│  └─ 适用：二分类问题（垃圾邮件、疾病诊断、欺诈检测）                │
│                                                                  │
│  🟢 K近邻 (K-Nearest Neighbors)                                 │
│  ├─ 本质：K个最近邻居投票决定类别                                 │
│  ├─ 优化目标：无（非参数模型，没有显式训练）                       │
│  ├─ 优点：直观、无需假设数据分布、非线性能力强                      │
│  ├─ 缺点：预测慢、维度灾难、需要特征缩放                           │
│  └─ 适用：手写识别、推荐系统、小数据集分类                         │
│                                                                  │
│  🟣 朴素贝叶斯 (Naive Bayes)                                    │
│  ├─ 本质：用贝叶斯定理计算概率，假设特征独立                       │
│  ├─ 优化目标：最大化后验概率                                      │
│  ├─ 优点：极快、小数据效果好、适合文本分类                         │
│  ├─ 缺点：独立性假设不现实、对特征相关敏感                          │
│  └─ 适用：垃圾邮件过滤、情感分析、文本分类                          │
│                                                                  │
│  💡 模型选择黄金法则                                             │
│  ├─ 数据量小、特征独立 → 朴素贝叶斯                               │
│  ├─ 需要可解释性 → 线性/逻辑回归                                 │
│  ├─ 非线性、数据量大 → KNN + 特征工程                            │
│  └─ 都不满意？→ 明天学决策树和集成方法！                          │
└─────────────────────────────────────────────────────────────────┘
```

### 代码实战：四模型对比

```python
# === 四大模型在同一个数据集上的对比 ===

from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score
import time

# 加载乳腺癌数据集（二分类）
data = load_breast_cancer()
X, y = data.data, data.target

print("=" * 60)
print("四大分类模型对比 · 乳腺癌数据集")
print("=" * 60)
print(f"样本数：{X.shape[0]}，特征数：{X.shape[1]}")
print(f"类别：良性({data.target_names[0]}) / 恶性({data.target_names[1]})")
print()

# 数据分割 + 标准化
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)

# KNN和逻辑回归需要特征标准化
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 定义模型
models = {
    "逻辑回归": LogisticRegression(max_iter=1000),
    "KNN (K=5)": KNeighborsClassifier(n_neighbors=5),
    "朴素贝叶斯": GaussianNB(),
}

# 训练与评估
print(f"{'模型':12s} {'训练时间':10s} {'准确率':8s}")
print("-" * 32)

for name, model in models.items():
    # 选择适当的数据（KNN和逻辑回归用标准化后的）
    if name == "朴素贝叶斯":
        X_tr, X_te = X_train, X_test
    else:
        X_tr, X_te = X_train_scaled, X_test_scaled
    
    # 训练
    start = time.time()
    model.fit(X_tr, y_train)
    train_time = time.time() - start
    
    # 预测
    y_pred = model.predict(X_te)
    acc = accuracy_score(y_test, y_pred)
    
    print(f"{name:12s} {train_time*1000:8.2f}ms {acc:7.2%}")

print()
print("观察：不同模型在不同数据集上表现各异")
print("没有"最好"的模型——只有"最适合"的模型！")
```

### 刻意练习：今日探案任务

> **案件名称：泰坦尼克号生存预测**

你是历史学家，正在研究泰坦尼克号沉没事故。你有一份乘客名单，包括：
- Pclass（船舱等级）
- Sex（性别）
- Age（年龄）
- SibSp（兄弟姐妹/配偶数）
- Parch（父母/子女数）
- Fare（票价）
- Embarked（登船港口）

**任务：建立一个模型，预测一个乘客是否生还。**

```python
# === 练习框架：泰坦尼克号生存预测 ===

# 1. 加载数据
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import accuracy_score

# 自己找数据！可以从 seaborn 库加载
# import seaborn as sns
# titanic = sns.load_dataset('titanic')

# 或者用sklearn提供的模拟数据练习
# 先用鸢尾花数据集跑通流程

# 提示：需要做的步骤
"""
第1步：数据清洗
  - 处理缺失值（Age、Embarked）
  - 转换类别特征（Sex→0/1, Embarked→one-hot）

第2步：特征工程
  - 选择你觉得影响生存的特征
  - 思考：为什么"女性优先"会影响模型？

第3步：特征缩放
  - Age和Fare的量级差别很大
  - 对KNN和逻辑回归，需要标准化

第4步：模型选择
  - 至少尝试两种分类器
  - 比较它们的准确率

第5步：结果分析
  - 哪个特征的权重最大？（逻辑回归的系数）
  - 这符合历史事实吗？
"""
print("泰坦尼克号生存预测——你的任务")
print()
print("思考题：")
print("1. "妇女儿童优先"在模型里会如何体现？")
print("2. 头等舱乘客的生存率为什么更高？")
print("3. 如果只用"性别"一个特征做预测，准确率会是多少？")
```

**进阶挑战：**

1. **特征交互**：试试把"性别"和"船舱等级"组合成一个新特征（如"头等舱女性"），模型会更好吗？
2. **阈值调优**：逻辑回归默认阈值0.5。如果目标是"不漏掉任何一个可能生还的人"，你会怎么调？
3. **K值选择**：在KNN中，用一个循环尝试K=1到K=30，画一张"K值 vs 准确率"的图。

### 📌 本日核心公式

```
线性回归：  y = wx + b                          [预测连续值]
逻辑回归：  P(y=1) = σ(wx + b)                  [预测概率→分类]
KNN：       y = majority_vote(K_nearest)        [邻居投票]
朴素贝叶斯： y = argmax P(y) ∏ P(x_i|y)         [概率最大]
```

### ❓ 悬疑追问（思考题，不急于回答）

1. 如果逻辑回归叫做"回归"，那"回归"这个词在统计学里到底是什么意思？（提示：向平均值回归）
2. KNN需要特征标准化，但决策树不需要——为什么？（提示：基于距离 vs 基于阈值）
3. 朴素贝叶斯的"独立假设"明显不合理，为什么在文本分类中效果却出奇好？
4. 今天学的都是监督学习——明天，我们将进入更强大的世界：**决策树和集成学习**。

---

> **下一集预告：Day07**
>
> 你今天学的每个模型都有它的局限性：
> - 线性回归太"直"了
> - KNN太"懒"了
> - 朴素贝叶斯太"朴素"了
>
> 明天，一群"弱者"将联合起来，逆袭成最强的模型——
>
> **决策树和它的集成军团。**
>
> *"个体是脆弱的，但集体是强大的。"*
