---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#深度学习"
  - "#卷积神经网络"
  - "#CNN"
  - "#计算机视觉"
  - "#番茄学习法"
  - "#120番茄"
  - "#Day11"
  - "#Part3"
aliases:
  - Day11 卷积神经网络
  - 让AI看见世界
  - 番茄51-55
---

# Day11：卷积神经网络——让AI"看见"世界 👁️

> **番茄51-55 · Part 3 深度学习与神经网络**
>
> 🕵️ **悬疑开场**：一张猫的图片在计算机眼里只是数字矩阵——CNN怎么从像素中认出猫？
>
> "计算机看到的不是猫，是数字。一堆数字。"
>
> 一张 224×224 的彩色图片 = 224 × 224 × 3 = 150,528 个数字。全连接网络需要 150,528 个输入神经元，第一层如果有 1000 个神经元，那就是 **1.5 亿个参数**。
>
> 这太蠢了。像素之间有空间关系——相邻的像素构成边缘，边缘构成纹理，纹理构成形状。
>
> **CNN 就是为"利用空间结构"而生的。**

---

## 📋 今日番茄概览

| 番茄 | 主题 | 类型 |
|:----:|:----|:----:|
| 🍅51 | 卷积操作——滑动窗口提取特征 | 核心概念 |
| 🍅52 | 池化与下采样——浓缩就是精华 | 理论进阶 |
| 🍅53 | 经典CNN架构进化史 | 历史+理论 |
| 🍅54 | 迁移学习——站在巨人肩膀上 | 方法+实践 |
| 🍅55 | 实战：用预训练模型做图像分类 | 实战项目 |

---

## 🍅51 卷积操作——滑动窗口提取特征

### 🔪 犯罪现场：侦探的放大镜

> 想象你是一位侦探，正在查看一张犯罪现场照片。你不会一下子看完整张照片——你会用放大镜在照片上**滑动**，一个区域一个区域地看。
>
> 这就是卷积。
>
> 但你不是盲目地看——你心里有特定的"模板"（寻找什么）：血迹的形状、脚印的纹理、指纹的纹路。
>
> 在CNN里，这些"模板"就叫**卷积核（Kernel）**或**滤波器（Filter）**。

### 卷积操作的本质

卷积 = **滑动窗口 × 逐元素相乘 × 求和**

```
输入图像 (5×5)        卷积核 (3×3)        输出特征图 (3×3)
┌───┬───┬───┬───┬───┐    ┌───┬───┬───┐    ┌────┬────┬────┐
│ 1 │ 1 │ 1 │ 0 │ 0 │    │ 1 │ 0 │ 1 │    │  ? │  ? │  ? │
├───┼───┼───┼───┼───┤    ├───┼───┼───┤    ├────┼────┼────┤
│ 0 │ 1 │ 1 │ 1 │ 0 │    │ 0 │ 1 │ 0 │    │  ? │  ? │  ? │
├───┼───┼───┼───┼───┤    ├───┼───┼───┤    ├────┼────┼────┤
│ 0 │ 0 │ 1 │ 1 │ 1 │    │ 1 │ 0 │ 1 │    │  ? │  ? │  ? │
├───┼───┼───┼───┼───┤    └───┴───┴───┘    └────┴────┴────┘
│ 0 │ 0 │ 1 │ 1 │ 0 │
├───┼───┼───┼───┼───┤
│ 0 │ 1 │ 1 │ 0 │ 0 │
└───┴───┴───┴───┴───┘

第一次卷积（左上角3×3区域）：
┌───┬───┬───┐    ┌───┬───┬───┐
│ 1 │ 1 │ 1 │    │ 1 │ 0 │ 1 │    1×1 + 1×0 + 1×1
├───┼───┼───┤    ├───┼───┼───┤    + 0×0 + 1×1 + 1×0
│ 0 │ 1 │ 1 │  ×  │ 0 │ 1 │ 0 │    + 0×1 + 0×0 + 1×1
├───┼───┼───┤    ├───┼───┼───┤
│ 0 │ 0 │ 1 │    │ 1 │ 0 │ 1 │    = 1+0+1+0+1+0+0+0+1 = 4
└───┴───┴───┘    └───┴───┴───┘
```

### 边缘检测实例：最直观的卷积

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

# 创建一个简单的图像：黑白交界
image = np.zeros((20, 20))
image[:, 10:] = 1  # 右边一半是白色

# 定义卷积核（滤波器）
# Sobel 水平边缘检测核
kernel_horizontal = np.array([
    [-1, -1, -1],
    [ 0,  0,  0],
    [ 1,  1,  1]
])

# Sobel 垂直边缘检测核
kernel_vertical = np.array([
    [-1, 0, 1],
    [-1, 0, 1],
    [-1, 0, 1]
])

# 执行卷积（二维卷积）
# 'same' 模式：输出尺寸与输入相同（通过填充）
edges_h = signal.convolve2d(image, kernel_horizontal, mode='same')
edges_v = signal.convolve2d(image, kernel_vertical, mode='same')

# ---- 直觉 ----
# 卷积核就像"探针"：
# 水平核：如果图像中某区域的上下差异大 → 输出值大 → 这里有一条水平边缘
# 垂直核：如果图像中某区域的左右差异大 → 输出值大 → 这里有一条垂直边缘
#
# 在黑白交界处，左右像素差异最大，
# 所以垂直边缘检测核在那里输出最大值！
```

### 卷积的超参数

```python
# ---- 三个关键超参数 ----

# 1. 卷积核大小 (Kernel Size)：常用 3×3, 5×5, 7×7
#    越小越关注局部细节，越大越关注全局模式
kernel_size = 3

# 2. 步长 (Stride)：每次滑动多少像素
#    stride=1 → 逐像素滑动（保留更多空间信息）
#    stride=2 → 每两像素滑动一次（下采样）
stride = 1

# 3. 填充 (Padding)：是否在图像边缘补0
#    padding='valid' → 不填充，输出变小
#    padding='same'  → 填充使得输出尺寸与输入相同
padding = 'same'

# ---- 输出尺寸计算公式 ----
# 输出尺寸 = (输入尺寸 - 卷积核尺寸 + 2×填充) / 步长 + 1
#
# 例如：输入 28×28, 卷积核 3×3, stride=1, padding='same'
# 输出 = (28 - 3 + 2×1) / 1 + 1 = 28  ← 尺寸不变！

# ---- 多个卷积核 ----
# 一个卷积核检测一种特征（比如水平边缘）
# 多个卷积核检测多种特征（水平边缘 + 垂直边缘 + 斜边 + 纹理...）
# CNN 的每一层通常有 64 或 128 个卷积核
num_filters = 64  # 这一层输出64张"特征图"
```

### 为什么要用卷积而不是全连接？

| 对比 | 全连接层 (FC) | 卷积层 (Conv) |
|:-----|:-------------:|:-------------:|
| **参数数量** | 150,528×1000=1.5亿 | 3×3×3×64=1,728 |
| **空间结构** | ❌ 无视空间关系 | ✅ 保留空间信息 |
| **平移不变性** | ❌ 猫挪个位置就认不出 | ✅ 无论猫在哪都能认出 |
| **局部连接** | ❌ 每个像素连每个神经元 | ✅ 只看局部区域 |

**卷积核 = 可学习的特征检测器。** 在训练过程中，卷积核的权重会从随机噪声逐渐变成有意义的边缘检测器、纹理检测器、形状检测器...

---

### ✅ 费曼三句话（🍅51）

> 1. **卷积就是"用一个模板在图像上滑动匹配"**——模板（卷积核）检测某种特征（如边缘），匹配度越高输出值越大。
> 2. **CNN比全连接网络节省了99.99%的参数**——因为每个卷积核在所有位置共享权重，不需要每个像素单独学一个参数。
> 3. **卷积核不需要人设计，网络自己会学**——训练完成后，第一层卷积核通常是边缘检测器，越深层越抽象。

---

## 🍅52 池化与下采样——浓缩就是精华

### 🔍 破案技巧：从细节到全局

> 侦探看监控录像时，不会分析每一帧的每一个像素。他先看整体——"什么时间、什么地点、什么人"——再放大关键细节。
>
> 这就像池化：**保留最重要的信息，丢掉无关紧要的细节。**

### 最大池化（Max Pooling）：最有话语权的"代表"

```
输入 4×4:              2×2 最大池化 (stride=2):
┌────┬────┬────┬────┐        ┌────┬────┐
│ 1  │ 3  │ 2  │ 4  │        │MAX │MAX │
├────┼────┼────┼────┤  ──▶  │ 1,3│ 2,4│  =  [3, 4]
│ 5  │ 6  │ 7  │ 8  │        │ 2,4│ 6,8│
├────┼────┼────┼────┤        ├────┼────┤
│ 9  │ 1  │ 3  │ 2  │        │MAX │MAX │
├────┼────┼────┼────┤  ──▶  │ 9,1│ 3,2│  =  [9, 3]
│ 4  │ 8  │ 6  │ 0  │        │ 4,8│ 6,0│
└────┴────┴────┴────┘        └────┴────┘
```

```python
import torch
import torch.nn as nn

# PyTorch中的最大池化
# 2×2 池化窗口，步长2 → 宽高各减半
maxpool = nn.MaxPool2d(kernel_size=2, stride=2)

# 示例：输入 1张图, 64个通道, 28×28
x = torch.randn(1, 64, 28, 28)
out = maxpool(x)
print(out.shape)  # torch.Size([1, 64, 14, 14])
# 通道数不变（64），宽高各减半（14×14）
# 信息量减少75%，但最重要的特征保留下来了！
```

### 为什么池化有效？

**直觉**：一张猫的照片缩小到一半尺寸，你仍然能认出它是猫。因为"猫的特征"（耳朵形状、胡须位置）在更大尺度上仍然存在。

**妙用**：
1. **降维**：减少计算量（参数减少75%）
2. **平移不变性**：猫往左移2个像素，池化后输出几乎不变
3. **防止过拟合**：丢细节=丢噪声=更鲁棒

### 池化的变体

| 类型 | 操作 | 特点 |
|:-----|:-----|:------|
| **Max Pooling** | 取窗口最大值 | 保留最显著特征，最常用 |
| **Average Pooling** | 取窗口平均值 | 保留整体信息，更平滑 |
| **Global Average Pooling** | 整个特征图取平均 | 替代全连接层，减少参数 |

### 完整卷积块的结构

```
输入图像 (28×28)
    │
    ▼
┌──────────────────┐
│   卷积层 (Conv2D) │  ← 特征提取：用卷积核检测特征
│   3×3, 32个核     │
├──────────────────┤
│   激活层 (ReLU)   │  ← 非线性：打破线性
├──────────────────┤
│   池化层 (MaxPool)│  ← 降维：保留精华
│   2×2, stride=2   │
└──────────────────┘
    │ 输出 (14×14×32)
    ▼
┌──────────────────┐
│   卷积层 (Conv2D) │  ← 更高层次的特征
│   3×3, 64个核     │
├──────────────────┤
│   激活层 (ReLU)   │
├──────────────────┤
│   池化层 (MaxPool)│
└──────────────────┘
    │ 输出 (7×7×64)
    ▼
┌──────────────────┐
│   展平 (Flatten)  │  ← 特征图→向量
├──────────────────┤
│   全连接层 (FC)   │  ← 分类决策
├──────────────────┤
│   输出层          │  ← 10个类别概率
└──────────────────┘
```

---

### ✅ 费曼三句话（🍅52）

> 1. **池化就是"选出最响的声音"**——在一个小区域里，最大池化只保留最大值，丢掉其他，就像一群人说话只记录最大声的那个。
> 2. **池化让网络对"微小位移"不敏感**——特征位置稍微变一点没关系，只要特征还在那个大致区域里就行。
> 3. **卷积+池化交替使用构成了CNN的核心骨架**——卷积负责"找什么"，池化负责"在哪找"，配合天衣无缝。

---

## 🍅53 经典CNN架构——LeNet → AlexNet → VGG → ResNet进化史

### 🔍 悬疑时间线：CNN的进化是一场"越狱"

> 1998年，Yann LeCun在贝尔实验室提出了LeNet——第一个成功商业化的CNN，用于美国邮政的手写数字识别。
>
> 但CNN真正"越狱"是在2012年——当Alex Krizhevsky用GPU训练了一个巨大的CNN，在ImageNet比赛中以**压倒性优势**夺冠（错误率26%→15%）。
>
> 从那时起，CNN的进化就像军备竞赛。

### 第一代：LeNet-5（1998）——奠基者

```
输入: 32×32 灰度图
    │
Conv1: 6@5×5  ──▶ 池化 ──▶  提取低级边缘
    │
Conv2: 16@5×5 ──▶ 池化 ──▶  提取形状
    │
FC: 120 → 84 → 10 (输出)
    │
输出: 10个数字 (0-9)
```

**创新**：第一个用反向传播训练的CNN。解决了美国邮政的手写数字识别——每天处理数百万封信件。

**局限**：计算资源有限，网络很浅（2个卷积层），只能处理简单任务。

### 第二代：AlexNet（2012）——引爆者

```
输入: 227×227×3 彩色图（三倍于LeNet的复杂度！）
    │
Conv1: 96@11×11, stride=4 ──▶ 池化 ──▶  LRN（局部响应归一化）
    │
Conv2: 256@5×5 ──▶ 池化 ──▶  LRN
    │
Conv3: 384@3×3
    │
Conv4: 384@3×3
    │
Conv5: 256@3×3 ──▶ 池化
    │
FC: 4096 → 4096 → 1000 (输出)
```

**三大革命性创新**：
1. **ReLU激活函数** → 解决梯度消失，训练更深网络
2. **GPU加速** → 两块GTX 580训练了6天（当时是超级计算）
3. **Dropout** → 随机丢弃50%神经元，防止过拟合

**历史意义**：ImageNet 2012冠军，错误率从26%骤降到15%，宣告深度学习时代到来。

### 第三代：VGGNet（2014）——坚持到底

```
输入: 224×224×3
    │
[Conv64]×2 ──▶ 池化    ← 全是3×3小卷积核！
    │
[Conv128]×2 ──▶ 池化
    │
[Conv256]×3 ──▶ 池化
    │
[Conv512]×3 ──▶ 池化
    │
[Conv512]×3 ──▶ 池化
    │
FC: 4096 → 4096 → 1000
```

**核心洞察**：**两个3×3卷积串联 = 一个5×5卷积的感受野**，但参数更少（2×9=18 vs 25），非线性更强（两次ReLU）。

**代价**：1.38亿参数，500MB的模型文件——太慢了。

### 第四代：ResNet（2015）——革命者

> 到2015年，研究人员发现一个诡异的现象：**网络越深，错误率反而越高**。
>
> 这不是过拟合——训练集上的误差也增加了。
>
> 这就是"退化问题"（Degradation Problem）：深层网络太难优化了。

**ResNet的解决方案：残差连接（Skip Connection）**

```
传统网络：    x → [Conv → ReLU → Conv] → H(x)
           每一层必须学到完整映射 H(x)

ResNet：    x → [Conv → ReLU → Conv] → + → ReLU
                                      ↑
                                   x (直接从输入跳过来)
           每一层只学"残差" F(x) = H(x) - x
           如果这一层没用，F(x) = 0，H(x) = x（恒等映射）
```

```python
# ResNet的核心：残差块

import torch
import torch.nn as nn

class ResidualBlock(nn.Module):
    """
    残差块：让梯度有一条"高速公路"直接流回浅层

    这就是为什么ResNet可以做到152层（是VGG的8倍！）
    但参数却更少（VGG是笨重的大块头，ResNet是精悍的轻骑兵）
    """
    def __init__(self, in_channels, out_channels, stride=1):
        super().__init__()

        # 主路径：学习残差 F(x)
        self.conv1 = nn.Conv2d(in_channels, out_channels,
                               kernel_size=3, stride=stride,
                               padding=1, bias=False)
        self.bn1 = nn.BatchNorm2d(out_channels)  # 批归一化：稳定训练
        self.relu = nn.ReLU(inplace=True)
        self.conv2 = nn.Conv2d(out_channels, out_channels,
                               kernel_size=3, stride=1,
                               padding=1, bias=False)
        self.bn2 = nn.BatchNorm2d(out_channels)

        # 快捷连接：如果输入输出维度不匹配，用1×1卷积调整
        self.shortcut = nn.Sequential()
        if stride != 1 or in_channels != out_channels:
            self.shortcut = nn.Sequential(
                nn.Conv2d(in_channels, out_channels,
                          kernel_size=1, stride=stride, bias=False),
                nn.BatchNorm2d(out_channels)
            )

    def forward(self, x):
        # 主路径
        out = self.relu(self.bn1(self.conv1(x)))
        out = self.bn2(self.conv2(out))

        # 关键：加上输入 x（残差连接！）
        out += self.shortcut(x)  # 梯度可以直接通过这里反向传播！

        out = self.relu(out)
        return out
```

### CNN架构进化一览

| 模型 | 年份 | 层数 | 参数 | ImageNet Top-5错误率 | 关键创新 |
|:----:|:----:|:----:|:----:|:-------------------:|:---------|
| LeNet-5 | 1998 | 5 | 60K | N/A | 第一个CNN |
| AlexNet | 2012 | 8 | 60M | 15.3% | ReLU, GPU, Dropout |
| VGG-16 | 2014 | 16 | 138M | 7.3% | 小卷积核堆叠 |
| ResNet-50 | 2015 | 50 | 25M | 3.6% | 残差连接 |
| ResNet-152 | 2015 | 152 | 60M | 3.0% | 极深网络 |

> **有趣的事实**：ResNet-152有152层，但参数只有60M——比只有16层却有138M参数的VGG更少。因为ResNet用全局平均池化取代了全连接层，极大减少了参数。

---

### ✅ 费曼三句话（🍅53）

> 1. **CNN进化史就是"越深越强，越强越难训"的挣扎史**——LeNet→AlexNet→VGG→ResNet，核心矛盾始终是：如何让上百层的网络稳定训练。
> 2. **ResNet的残差连接是CNN进化中最重要的思想之一**——它让梯度有了"高速公路"，152层深度不再是问题。
> 3. **每一代架构的创新都是为了解决上一代的核心瓶颈**——AlexNet解决训练速度（GPU+ReLU），VGG解决深度（小卷积核堆叠），ResNet解决退化（残差连接）。

---

## 🍅54 迁移学习——站在巨人肩膀上

### 🔍 犯罪现场：不用从零开始

> 想象你要培训一个新侦探。是从ABC开始教他认字、学逻辑、练格斗——还是让他直接看老侦探的案例档案，上手实战？
>
> 答案显而易见。
>
> **迁移学习（Transfer Learning）就是让AI先在一个大规模数据集上学好"基础知识"，再快速适应你的特定任务。**

### 为什么迁移学习有效？

CNN的学习是分层的：

```
低层：边缘、颜色、纹理        ← 这些是"通用视觉知识"
  │                          ← 不管识别什么，都用得上
中层：形状、图案、部件
  │
高层：特定类别特征            ← 这些是"任务特化"知识
  │                          ← 需要针对新任务微调
输出层：类别分类器
```

**ResNet在ImageNet（1000类，1400万张图）上预训练后**：
- 低层卷积核已经学会检测边缘、纹理——**通用**
- 中层学会了形状、图案——**比较通用**
- 高层学会了特定类别特征——**需要微调**

### 迁移学习的三种策略

```python
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import models  # torchvision内置经典模型

# ---- 策略1：特征提取（小数据集） ----
# 冻结所有卷积层，只训练新分类器

model = models.resnet18(pretrained=True)  # 加载在ImageNet上预训练的权重

# 冻结所有参数
for param in model.parameters():
    param.requires_grad = False  # 不计算梯度，不更新

# 替换最后的全连接层（ResNet的fc层）
num_features = model.fc.in_features  # ResNet18: 512
model.fc = nn.Linear(num_features, 2)  # 假设做猫狗二分类

# 只有新加的fc层会被训练
# 其他层的权重是"冻结"的——即它们被当作固定的特征提取器

# ---- 策略2：微调（中等数据集） ----
# 解冻高层，让它们适应新任务

model = models.resnet18(pretrained=True)

# 先冻结所有层
for param in model.parameters():
    param.requires_grad = False

# 解冻最后两个残差块（layer4 和 layer3）
for param in model.layer4.parameters():
    param.requires_grad = True
for param in model.layer3.parameters():
    param.requires_grad = True

# 替换分类头
num_features = model.fc.in_features
model.fc = nn.Linear(num_features, 10)  # 假设10类

# 优化器只更新解冻的参数
optimizer = optim.Adam([
    {'params': model.layer3.parameters()},
    {'params': model.layer4.parameters()},
    {'params': model.fc.parameters()}
], lr=0.001)

# ---- 策略3：完整训练（大数据集） ----
# 用预训练权重做初始化，然后全量训练

model = models.resnet50(pretrained=True)

# 所有层都参与训练
for param in model.parameters():
    param.requires_grad = True

# 替换分类头
model.fc = nn.Linear(2048, 100)  # 100类新任务

# 注意：使用小学习率（避免破坏预训练学到的知识）
optimizer = optim.Adam(model.parameters(), lr=0.0001)  # 比正常小10倍
```

### 什么时候用哪种策略？

| 数据量 | 与ImageNet相似度 | 推荐策略 | 原因 |
|:------:|:----------------:|:---------|:-----|
| 小 | 高 | 特征提取 | 数据少，微调容易过拟合 |
| 小 | 低 | 特征提取 | 数据少，但低层特征仍然有用 |
| 中 | 高 | 微调高层 | 让高层适应你的数据分布 |
| 中 | 低 | 微调更多层 | 任务差异大，需要更多适应 |
| 大 | 任意 | 完整训练 | 数据足够从头学习，但预训练提供好的起点 |

### 迁移学习的惊人效果

```python
# 想象你只有100张蚂蚁和蜜蜂的图片
# 从头训练ResNet：准确率 ≈ 60-70%
# 用预训练的ResNet（特征提取）：准确率 ≈ 92-95%
# 用预训练的ResNet（微调）：准确率 ≈ 96-98%
#
# 100张图片 + 迁移学习 = 10000张图片 + 从头训练
```

**这就是"站在巨人肩膀上"的力量。**

---

### ✅ 费曼三句话（🍅54）

> 1. **迁移学习就是让AI先上"预科班"再学"专业课"**——先在ImageNet上看过1400万张图，再用你手头的100张图微调。
> 2. **低层特征（边缘、纹理）是通用的，高层特征（类别细节）是特化的**——所以迁移时通常是"冻结底层，微调高层"。
> 3. **100张标注图片 + 迁移学习 ≈ 10000张图片 + 从头训练**——这是深度学习落地时最实用的技巧，没有之一。

---

## 🍅55 实战：用预训练模型做图像分类

### 🔍 悬疑收尾：用世界上最厉害的"眼睛"看世界

> 2015年的ResNet-152花了数周在数百块GPU上训练，才学会识别1000种物体。
>
> 但今天——你只需要5行代码就能调用它的能力。这就是开源精神和迁移学习的结晶。

### 实战：用ResNet识别图片中的物体

```python
import torch
import torch.nn as nn
from torchvision import models, transforms
from PIL import Image
import json
import urllib.request

# ---- 第1步：加载预训练模型 ----
# 一行代码，加载在ImageNet上训练好的ResNet
# weights='IMAGENET1K_V1' 使用官方预训练权重
model = models.resnet50(pretrained=True)

# 切换到评估模式
model.eval()

# ---- 第2步：定义数据预处理 ----
# ImageNet的标准化要求：每张图需要经过特定变换
preprocess = transforms.Compose([
    transforms.Resize(256),          # 缩放短边到256
    transforms.CenterCrop(224),      # 中心裁剪到224×224
    transforms.ToTensor(),           # PIL图片 → PyTorch张量
    transforms.Normalize(            # 标准化（使用ImageNet的统计值）
        mean=[0.485, 0.456, 0.406],  # RGB三个通道的均值
        std=[0.229, 0.224, 0.225]    # RGB三个通道的标准差
    )
])

# ---- 第3步：加载并处理图片 ----
# 你也可以用自己的图片，比如：img = Image.open('my_cat.jpg')
# 这里我们下载一张示例图片
url = "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg"
img_path = "cat.jpg"
urllib.request.urlretrieve(url, img_path)

img = Image.open(img_path).convert('RGB')
img_tensor = preprocess(img)          # 应用预处理
img_batch = img_tensor.unsqueeze(0)   # 增加batch维度 [1, 3, 224, 224]

# ---- 第4步：推理 ----
with torch.no_grad():  # 推理时不需要计算梯度
    output = model(img_batch)

# output: [1, 1000]  ← 1000个类别的置信度分数

# ---- 第5步：解读结果 ----
# 加载ImageNet的类别标签
labels_url = "https://raw.githubusercontent.com/anishathalye/imagenet-simple-labels/master/imagenet-simple-labels.json"
labels = json.loads(urllib.request.urlopen(labels_url).read())

# 获取Top-5预测
probabilities = torch.nn.functional.softmax(output[0], dim=0)
top5_prob, top5_indices = torch.topk(probabilities, 5)

print("Top-5 预测结果：")
for i in range(5):
    idx = top5_indices[i].item()
    prob = top5_prob[i].item() * 100
    print(f"  {i+1}. {labels[idx]}: {prob:.2f}%")
# 预期输出：
#   1. tabby cat: 85.3%
#   2. tiger cat: 7.2%
#   3. Egyptian cat: 3.1%
#   ...
```

### 拓展：用自己的数据集做微调

```python
# ---- 实战：用蚂蚁和蜜蜂数据集做微调 ----
# 假设你有一个"ants_bees"文件夹，内有 train/val 子文件夹

from torchvision import datasets

# 数据加载
data_transforms = {
    'train': transforms.Compose([
        transforms.RandomResizedCrop(224),    # 随机裁剪（数据增强）
        transforms.RandomHorizontalFlip(),    # 随机翻转（数据增强）
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406],
                             [0.229, 0.224, 0.225])
    ]),
    'val': transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406],
                             [0.229, 0.224, 0.225])
    ]),
}

# 加载数据集
image_datasets = {
    x: datasets.ImageFolder(f'ants_bees/{x}', data_transforms[x])
    for x in ['train', 'val']
}
dataloaders = {
    x: torch.utils.data.DataLoader(image_datasets[x], batch_size=32, shuffle=True)
    for x in ['train', 'val']
}

# 加载预训练模型并微调
model = models.resnet18(pretrained=True)

# 替换最后一层（蚂蚁🐜 vs 蜜蜂🐝）
num_ftrs = model.fc.in_features
model.fc = nn.Linear(num_ftrs, 2)  # 2类

# 训练配置
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr=0.001, momentum=0.9)

# 训练循环（简写）
num_epochs = 5
for epoch in range(num_epochs):
    for phase in ['train', 'val']:
        if phase == 'train':
            model.train()
        else:
            model.eval()

        running_loss = 0.0
        running_corrects = 0

        for inputs, labels in dataloaders[phase]:
            optimizer.zero_grad()

            with torch.set_grad_enabled(phase == 'train'):
                outputs = model(inputs)
                loss = criterion(outputs, labels)
                _, preds = torch.max(outputs, 1)

                if phase == 'train':
                    loss.backward()
                    optimizer.step()

            running_loss += loss.item() * inputs.size(0)
            running_corrects += torch.sum(preds == labels.data)

        epoch_loss = running_loss / len(image_datasets[phase])
        epoch_acc = running_corrects.double() / len(image_datasets[phase])

        print(f'{phase} Loss: {epoch_loss:.4f} Acc: {epoch_acc:.4f}')

# 5轮微调后，准确率应该轻松达到 95%+ 🎉
```

---

### 🧠 番茄55的知识全景：CNN的三层抽象

```
像素层 (原始输入)
  │
  ▼
低级特征 (边缘、颜色、纹理) ← 卷积核自动学习
  │                          ← 通用特征，跨任务共享
  ▼
中级特征 (形状、部件、纹理组合)
  │                          ← 通过层叠卷积获得
  ▼
高级特征 (物体类别、场景)
  │                          ← 最后一层做决策
  ▼
分类输出 (猫、狗、汽车...)
```

---

### ✅ 费曼三句话（🍅55）

> 1. **今天用20行代码就调用了世界上最强大的图像识别模型**——ResNet-152在ImageNet上训练的知识，被你用5行代码借来用了。
> 2. **迁移学习的关键是"只换最后一层，保留前面的通用特征提取器"**——就像给一个经验丰富的医生换一个专科方向，不需要重新学医。
> 3. **CNN的整个发展史告诉我们：更好的架构不是更多的参数，而是更聪明的连接方式**——ResNet用残差连接实现了VGG无法企及的深度。

---

### 🎯 刻意练习

#### 初级侦探（模仿）
1. 用预训练ResNet识别你的5张照片（猫、狗、风景、食物、人脸），分析模型哪里对哪里错
2. 修改代码用VGG-16代替ResNet，比较推理速度和准确率

#### 中级侦探（变式）
3. 收集50张你手机里的照片，做一个2-3类分类器（如"食物vs非食物""户外vs室内"），用迁移学习训练
4. 尝试冻结不同数量的层（冻结全部 vs 冻结前半 vs 全部微调），对比效果

#### 高级侦探（创造）
5. 找一个你感兴趣的真实问题（如医疗影像分类、卫星图片分析），收集数据，用迁移学习构建分类系统
6. 对比ResNet-18、ResNet-50、ResNet-152在你数据集上的性能-速度权衡

#### 📝 探究笔记
```markdown
实验记录：
- 识别准确率最高的图片类型：___
- 识别错误的图片有什么共同特征？___
- 冻结层数 vs 准确率的关系：___
- 训练时间 vs 微调层数的关系：___

关键发现：
卷积层学到的"通用特征"在什么情况下会失效？
```

---

### 📌 连线思考

> - **现实连接**：你每天用的Google Photos搜索（搜"狗"出现所有狗的照片）、微信扫码、安防摄像头人脸识别——底层都是CNN。
> - **经济视角**：2012年训练AlexNet的GPU成本约$100万。今天你用Colab的免费GPU就能运行更强大的ResNet。算力民主化是AI普及的第一推动力。
> - **哲学思考**：CNN的"层次化特征学习"和人类视觉皮层的层级结构（V1→V2→V4→IT）惊人相似。这不是巧合——**深度学习本身就受到神经科学的启发。**
> - **下集预告**：Day12中，我们将从"看"转向"读"和"听"——RNN给了AI"记忆"的能力，能处理句子、语音、时间序列了。

---

> **📚 参考**：[[书库/人工智能/人工智能算法  卷3  深度学习和神经网络]] · [[书库/人工智能/深度学习 ]] · [[书库/人工智能/从神经科学到心理学系列套装（13册）_脑与意识]]
