---
created: 2026-06-15
tags:
  - "#AI教程"
  - "#番茄学习法"
  - "#Python"
  - "#数据分析"
  - "#NumPy"
  - "#Pandas"
  - "#可视化"
  - "#Day02"
aliases:
  - Day02-Python侦探工具包
  - Python语言基础与数据魔法
  - 120番茄-Day02
---

# 🍅 Day02：Python侦探工具包——语言基础与数据魔法

> **案件编号**：Case#002
> **案发时间**：1991年，荷兰
> **案件名**：为什么Python成了AI的第一语言？
>
> "真相就在数据中，而Python是你挖掘真相的瑞士军刀。"

---

## 🍅 番茄1：Python 速通——变量、列表、字典、条件、循环

### 🎬 悬疑开场：为什么侦探都爱 Python？

想象你是 1990 年代的一名程序员。你想写一个分析数据的程序：

- 用 **C 语言**：你要先声明变量类型、手动分配内存、小心翼翼地处理指针。写 100 行，只干了 10 行的事。
- 用 **Java**：你要先写一个类、一个 main 方法，光是"Hello World"就要 5 行样板代码。
- 用 **Python**：直接写 `print("Hello World")`——好了。

这就是 Python 的设计哲学：**简单、可读、高效**。它像一位贴心的搭档，在你开口之前就把工具递到你手上。

**Python 的四大设计原则**（来自 Python 之禅）：

> - **优美胜于丑陋**（Beautiful is better than ugly）
> - **简洁胜于复杂**（Simple is better than complex）
> - **可读性至关重要**（Readability counts）
> - **现在开始干比等着更好**（Now is better than never）

对于 AI 和数据分析而言，Python 的杀手锏是：**它让你专注于"你要分析什么"，而不是"你该怎么分配内存"**。

---

### 🔬 核心概念 1.1：变量与数据类型——给数据贴标签

变量就是给数据起个名字。Python 是**动态类型**语言——你不需要告诉它"这个是整数，那个是字符串"，它会自动识别。

```python
# 🧪 变量——侦探的笔记本

# --- 基础数据类型 ---
case_number = 1024          # int（整数）
confidence = 0.95           # float（浮点数）
suspect_name = "张三"        # str（字符串）
is_guilty = False           # bool（布尔值）

print(f"案件编号: {case_number} (类型: {type(case_number).__name__})")
print(f"置信度: {confidence} (类型: {type(confidence).__name__})")
print(f"嫌疑人: {suspect_name} (类型: {type(suspect_name).__name__})")
print(f"是否有罪: {is_guilty} (类型: {type(is_guilty).__name__})")

# --- 动态类型的威力 ---
mystery = 42
print(f"\nmystery 是: {mystery} ({type(mystery).__name__})")

mystery = "现在变成了字符串"
print(f"mystery 是: {mystery} ({type(mystery).__name__})")
# 在 C 语言里这是不可能的，但 Python 可以——这就是灵活性

# --- 类型转换（侦探的"变装术"）---
age_str = "35"          # 从文件读取的年龄是字符串
age_int = int(age_str)  # 转换成整数才能做数学运算
print(f"\n明年嫌疑人 {age_int + 1} 岁")
```

> ✋ **费曼自测**：Python 为什么不需要声明变量类型？"动态类型"有什么好处和潜在风险？

---

### 🔬 核心概念 1.2：列表与字典——侦探的数据库

**列表（list）**：有序的集合，就像侦探案件板上按时间排列的线索。

**字典（dict）**：键值对的集合，就像嫌疑人的档案——通过名字（键）找到详细信息（值）。

```python
# 🧪 列表与字典——数据组织的基础

# --- 列表：有序的线索清单 ---
print("📋 案件线索清单（列表）：")
clues = [
    "脚印",     # 索引 0
    "指纹",     # 索引 1
    "DNA样本",  # 索引 2
    "监控录像", # 索引 3
    "通话记录"  # 索引 4
]

print(f"  全部线索: {clues}")
print(f"  第一条线索: {clues[0]}")       # 正向索引
print(f"  最后一条线索: {clues[-1]}")    # 负向索引
print(f"  前三条: {clues[:3]}")          # 切片

# 列表的操作
clues.append("凶器")                      # 添加
clues.remove("指纹")                      # 删除
clues.sort()                              # 排序
print(f"  处理后线索: {clues}")

# --- 字典：嫌疑人的档案 ---
print("\n👤 嫌疑人档案（字典）：")
suspect = {
    "name": "张三",
    "age": 35,
    "occupation": "保安",
    "has_motive": True,
    "alibi": "在值班",
    "known_associates": ["李四", "王五"]
}

print(f"  姓名: {suspect['name']}")
print(f"  职业: {suspect['occupation']}")
print(f"  同伙: {suspect['known_associates']}")
suspect["has_evidence"] = True  # 动态添加新字段
print(f"  是否有证据: {suspect['has_evidence']}")

# --- 列表推导式——Python 的优雅魔法 ---
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 传统方式
evens_old = []
for n in numbers:
    if n % 2 == 0:
        evens_old.append(n)

# 列表推导式（一行搞定）
evens = [n for n in numbers if n % 2 == 0]
squares = [n**2 for n in numbers]

print(f"\n🔢 列表推导式魔法：")
print(f"  偶数: {evens}")
print(f"  平方: {squares}")
```

---

### 🔬 核心概念 1.3：条件与循环——程序的控制流

> ✋ **费曼自测**：如果没有循环，让你分析 100 万条数据你会怎么做？

```python
# 🧪 条件与循环——侦探的探案流程

# --- 条件判断：线索分类 ---
def classify_evidence(evidence_type, confidence):
    """根据证据类型和置信度判断价值"""
    
    # 多分支判断
    if confidence >= 0.9:
        level = "极高价值"
    elif confidence >= 0.7:
        level = "高价值"
    elif confidence >= 0.5:
        level = "中等价值"
    else:
        level = "低价值"
    
    # 复合条件
    if evidence_type == "DNA" and confidence >= 0.8:
        level += " ★ 锁定级证据"
    
    return level

evidence_samples = [
    ("DNA", 0.99),
    ("指纹", 0.85),
    ("目击证词", 0.45),
    ("监控录像", 0.75),
]

print("🔍 证据价值评估：")
for ev_type, conf in evidence_samples:
    level = classify_evidence(ev_type, conf)
    print(f"  {ev_type} (置信度:{conf:.2f}) -> {level}")

# --- 循环：批量处理 ---
print("\n📊 批量数据处理：")

# 场景1：遍历一个列表
ip_addresses = [
    "192.168.1.100", "10.0.0.5", "172.16.0.1",
    "192.168.1.101", "10.0.0.6"
]
print("  扫描到的 IP 地址：")
for ip in ip_addresses:
    if ip.startswith("192.168"):
        print(f"    🏠 内网IP: {ip}")
    else:
        print(f"    🌐 外网IP: {ip}")

# 场景2：使用 enumerate 获取索引
print("\n  带编号的线索列表：")
for idx, clue in enumerate(["脚印", "指纹", "DNA"], start=1):
    print(f"    #{idx}: {clue}")

# 场景3：使用 zip 并行遍历
names = ["张三", "李四", "王五"]
scores = [85, 92, 78]
print("\n  嫌疑人评分（并行遍历）：")
for name, score in zip(names, scores):
    status = "高危" if score >= 90 else "关注" if score >= 80 else "普通"
    print(f"    {name}: {score}分 → {status}")

# 场景4：while 循环——直到找到为止
print("\n  🔎 搜索目标（while循环）：")
database = ["张三", "李四", "王五", "赵六", "陈七"]
target = "王五"
i = 0
found = False
while i < len(database) and not found:
    print(f"    检查第{i+1}个: {database[i]}")
    if database[i] == target:
        found = True
        print(f"    ✅ 找到目标 {target}！位置: {i}")
    i += 1
```

---

### 🧠 费曼三句话（番茄1）

> 1. **Python 是"不用操心底层"的语言**——变量不需要声明类型，列表和字典随手就用，让你把精力放在"解决问题"而不是"管理内存"上。
> 2. **列表（有序集合）和字典（键值对）是 Python 数据组织的两大基石**——列表像线索板上的清单，字典像嫌疑人的档案卡。
> 3. **循环是数据处理的发动机**——`for` 遍历已知集合，`while` 一直找到条件不满足为止。加上 `if/elif/else` 分支判断，你能处理任何逻辑。

### ❓ 悬疑追问

> 你有没有想过，当你写 `my_dict[key]` 的时候，Python 底层是怎么做到瞬间就找到对应值的？这个魔法背后的机制叫**哈希表**——我们会在 Day04 揭开它的面纱。

---

## 🍅 番茄2：函数与面向对象——写可复用的侦探工具

### 🎬 悬疑开场：为什么好侦探不会每次都重新造轮子？

坏侦探的做法：
> 每次接到新案子，从零开始调查。不记笔记，不归纳方法。每个案子都是"全新的"。

好侦探的做法：
> 每次破案后，把有效的方法记录下来。下次遇到类似案件，直接套用。他的"方法论"越来越丰富，破案越来越快。

编程中的"好侦探"就是**写出可复用的代码的人**。函数和类，就是你把方法论固定下来的工具。

---

### 🔬 核心概念 2.1：函数——你的"破案方法论"

```python
# 🧪 函数——从"一次性脚本"到"可复用工具"

# --- 糟糕的方式：每次重写逻辑 ---
# 分析案件1的文本
text1 = "张三在晚上10点进入了大楼"
words1 = text1.split()
print(f"案件1的词数: {len(words1)}")

# 分析案件2的文本——同样的逻辑重写一次
text2 = "李四的指纹出现在保险柜上"
words2 = text2.split()
print(f"案件2的词数: {len(words2)}")

# --- 好的方式：用函数封装 ---
def count_words(text):
    """
    统计文本中的词数
    
    写一次，用无数次。这就是函数的力量。
    """
    if not text:
        return 0
    return len(text.split())

print(f"\n✅ 用函数统计：")
print(f"  案件1词数: {count_words(text1)}")
print(f"  案件2词数: {count_words(text2)}")
print(f"  空文本: {count_words('')}")

# --- 参数的高级用法 ---
def analyze_text(text, remove_punctuation=True, min_word_length=2):
    """
    更强大的文本分析函数
    
    参数说明：
    - remove_punctuation: 是否去除标点（默认是）
    - min_word_length: 最小词长（默认2，过滤掉单个字母）
    """
    import string
    
    if remove_punctuation:
        # 去除标点符号
        for p in string.punctuation:
            text = text.replace(p, '')
    
    words = text.split()
    # 过滤短词（列表推导式）
    words = [w for w in words if len(w) >= min_word_length]
    
    return {
        "total_words": len(words),
        "unique_words": len(set(words)),
        "avg_word_length": sum(len(w) for w in words) / len(words) if words else 0
    }

sample = "Hello, AI World! This is amazing."
result = analyze_text(sample)
print(f"\n📊 文本分析报告：")
for key, value in result.items():
    print(f"  {key}: {value}")
```

> ✋ **费曼自测**：为什么说函数是"抽象"的一种形式？好的函数应该满足什么条件？

---

### 🔬 核心概念 2.2：面向对象——把"数据+操作"打包

面向对象编程（OOP）的核心思想：**把相关的数据和操作打包在一起**。

想象一个"案件"：
- **数据（属性）**：案件编号、案发时间、地点、嫌疑人列表、证据列表
- **操作（方法）**：添加嫌疑人、添加证据、更新状态、生成报告

```python
# 🧪 面向对象——创建一个完整的案件管理系统

class Case:
    """案件类——每个案件都是一个对象"""
    
    # 类变量：所有实例共享
    total_cases = 0
    STATUS_OPTIONS = ["调查中", "已破案", "已归档", "未结"]
    
    def __init__(self, case_id, title, location):
        """构造函数：创建案件时自动调用"""
        self.case_id = case_id
        self.title = title
        self.location = location
        self.status = "调查中"
        self.suspects = []       # 嫌疑人列表
        self.evidence = []       # 证据列表
        self.notes = ""          # 办案笔记
        
        Case.total_cases += 1   # 每次创建案件，总数+1
        print(f"📂 新案件创建: [{case_id}] {title}")
    
    def add_suspect(self, name, reason):
        """添加嫌疑人"""
        suspect = {"name": name, "reason": reason, "arrested": False}
        self.suspects.append(suspect)
        print(f"  👤 添加嫌疑人: {name}（原因: {reason}）")
    
    def add_evidence(self, evidence_type, description, value=0.5):
        """添加证据"""
        evidence = {
            "type": evidence_type,
            "description": description,
            "value": value  # 证据价值 0~1
        }
        self.evidence.append(evidence)
        print(f"  📌 添加证据: [{evidence_type}] {description}")
    
    def solve_case(self):
        """破案——更新状态"""
        if len(self.evidence) >= 2 and len(self.suspects) >= 1:
            self.status = "已破案"
            print(f"  🎉 案件 [{self.case_id}] 已破案！")
        else:
            print(f"  ⚠️ 证据或嫌疑人不足，无法结案")
    
    def generate_report(self):
        """生成案件报告"""
        avg_evidence_value = (
            sum(e['value'] for e in self.evidence) / len(self.evidence)
            if self.evidence else 0
        )
        
        return f"""
{'='*50}
📋 案件报告: {self.title}
{'='*50}
案件编号: {self.case_id}
案发地点: {self.location}
案件状态: {self.status}
嫌疑人: {len(self.suspects)} 人
证据: {len(self.evidence)} 件
证据平均价值: {avg_evidence_value:.2f}
{'='*50}
"""

# 使用类：创建对象
print("=== 使用面向对象系统管理案件 ===\n")

# 创建案件
case1 = Case("C001", "博物馆失窃案", "市博物馆")
case2 = Case("C002", "数据泄露案", "科技公司总部")

# 操作案件
print("\n--- 案件1 办案过程 ---")
case1.add_suspect("张三", "当晚在博物馆附近出现")
case1.add_suspect("李四", "有盗窃前科")
case1.add_evidence("指纹", "展柜玻璃上的指纹", 0.8)
case1.add_evidence("DNA", "手套上的皮屑", 0.9)
case1.solve_case()

print("\n--- 案件2 办案过程 ---")
case2.add_suspect("王五", "离职员工，有系统权限")
case2.add_evidence("日志", "凌晨3点的登录记录", 0.7)
case2.solve_case()

# 生成报告
print(case1.generate_report())
print(case2.generate_report())

print(f"📊 系统统计: 共创建 {Case.total_cases} 个案件")
```

> ✋ **费曼自测**：面向对象编程和面向过程编程的根本区别是什么？什么时候该用类，什么时候用函数就够了？

---

### 🧠 费曼三句话（番茄2）

> 1. **函数是"动作的封装"**——把一段逻辑打包，起个名字，以后只需喊这个名字就能执行这段逻辑。好的函数像一把瑞士军刀，功能明确，随取随用。
> 2. **类是"数据+动作的封装"**——对象有属性（数据）和方法（操作），就像真实世界的物体有状态和行为。案件有嫌疑人和证据，也有破案和报告。
> 3. **可复用代码是编程能力的核心指标**——菜鸟写一次性脚本，高手写可复用的函数和类，架构师设计可组合的模块系统。

### ❓ 悬疑追问

> 对象是"数据+操作"的打包——那有没有一种更优雅的方式，把"通用的操作"也抽象出来？比如"排序"——不管是排序嫌疑人名单还是排序证据清单，逻辑是一样的。这就是**泛型**和**高阶函数**的用武之地。

---

## 🍅 番茄3：NumPy 与数据矩阵——让 Python 处理数字像呼吸一样自然

### 🎬 悬疑开场：当 Python 遇上大数据

Python 原生的列表（list）很方便，但它有一个致命弱点：**慢**。

想象你有一段视频监控数据——每秒 30 帧，每帧 1920×1080 个像素，每个像素 3 个颜色值。你需要对这个巨大的三维数组做各种数学运算。

用 Python 原生列表来做：
- 一个 1000 万元素的列表，做一次加法操作耗时约 **0.5 秒**
- 同样的操作，NumPy 只需要 **0.01 秒**——快了 **50 倍**

**NumPy（Numerical Python）** 就是为解决这个问题而生的。它在底层用 C 语言操作连续内存块，避免了 Python 循环的巨大开销。

---

### 🔬 核心概念 3.1：NumPy 数组——带"引擎"的列表

```python
# 🧪 NumPy 基础——从列表到数组
import numpy as np

# --- 创建 NumPy 数组 ---
print("=== 创建 NumPy 数组 ===\n")

# 从列表创建
data = [1, 2, 3, 4, 5]
arr = np.array(data)
print(f"从列表创建: {arr}")
print(f"类型: {type(arr)}")
print(f"形状: {arr.shape}")   # (5,) 表示一维，5个元素
print(f"数据类型: {arr.dtype}")  # int64 或 int32（看系统）

# 特殊数组
zeros = np.zeros((3, 4))      # 3行4列的全0数组
ones = np.ones((2, 3))        # 2行3列的全1数组
eye = np.eye(4)               # 4×4 单位矩阵
random_arr = np.random.rand(3, 3)  # 3×3 随机数

print(f"\n全0数组:\n{zeros}")
print(f"\n全1数组:\n{ones}")
print(f"\n单位矩阵:\n{eye}")
print(f"\n随机数矩阵:\n{random_arr}")

# 范围数组
range_arr = np.arange(0, 10, 2)    # 类似 range() 但返回数组
linspace = np.linspace(0, 1, 5)    # 0到1之间均匀取5个数
print(f"\narange(0,10,2): {range_arr}")
print(f"linspace(0,1,5): {linspace}")
```

---

### 🔬 核心概念 3.2：向量化运算——同时操作所有元素

NumPy 最强大的功能是**向量化**——不用写循环，就能对整个数组做运算。

```python
# 🧪 向量化运算——不用循环，一次搞定所有数据

print("=== 向量化运算 ===\n")

# 传统 Python 方式：写循环
py_list = list(range(1_000_000))
py_result = []
for x in py_list:
    py_result.append(x * 2 + 1)
print(f"Python循环: ✓ (但代码写了3行)")

# NumPy 方式：直接对数组做运算
np_arr = np.arange(1_000_000)
np_result = np_arr * 2 + 1
print(f"NumPy向量化: ✓ (一行搞定，快50倍)")

# --- 数学运算演示 ---
a = np.array([1, 2, 3, 4])
b = np.array([10, 20, 30, 40])

print(f"\na = {a}")
print(f"b = {b}")
print(f"a + b = {a + b}")
print(f"a * b = {a * b}")
print(f"a ** 2 = {a ** 2}")
print(f"sin(a) = {np.sin(a)}")
print(f"a > 2 = {a > 2}")  # 布尔索引

# --- 矩阵运算（AI 的基础）---
print("\n=== 矩阵运算 ===")
X = np.array([[1, 2], [3, 4]])
Y = np.array([[5, 6], [7, 8]])

print(f"X =\n{X}")
print(f"Y =\n{Y}")
print(f"X · Y (矩阵乘法) =\n{np.dot(X, Y)}")  # 矩阵乘法
print(f"X * Y (逐元素乘法) =\n{X * Y}")       # Hadamard乘积
print(f"X 的转置:\n{X.T}")
```

---

### 🔬 核心概念 3.3：广播机制——形状不同的数组也能运算

广播（Broadcasting）是 NumPy 最优雅的特性之一：不用手动复制数据，NumPy 会自动"扩展"小的数组来匹配大的数组。

```python
# 🧪 广播机制——不同形状的数组也能愉快地运算

print("=== 广播机制 ===\n")

# 场景1：标量加向量
scores = np.array([[80, 85, 90], [75, 88, 92]])
bonus = 5  # 所有人都加5分
print(f"原始分数:\n{scores}")
print(f"加 {bonus} 分后:\n{scores + bonus}")
# 不用写循环！NumPy 自动把 5 扩展到和 scores 一样的形状

# 场景2：一维数组 + 二维数组
matrix = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
row_mean = np.array([1, 2, 3])
print(f"\n矩阵:\n{matrix}")
print(f"行偏移: {row_mean}")
print(f"矩阵 + 行偏移:\n{matrix + row_mean}")

# 场景3：真实世界案例——标准化数据
# 假设有一组特征数据（每个样本有3个特征）
data = np.random.rand(5, 3) * 100  # 5个样本，3个特征
print(f"\n原始特征数据:\n{data}")

# 计算每个特征的均值和标准差
mean = np.mean(data, axis=0)    # 对列求平均
std = np.std(data, axis=0)      # 对列求标准差

# 标准化（Z-score）：(每个值 - 均值) / 标准差
normalized = (data - mean) / std
print(f"\n均值: {mean}")
print(f"标准差: {std}")
print(f"标准化后:\n{normalized}")
print(f"标准化后均值 ≈ {np.mean(normalized, axis=0)}")  # 接近0
print(f"标准化后标准差 ≈ {np.std(normalized, axis=0)}")  # 接近1
```

> ✋ **费曼自测**：为什么向量化运算比 Python 循环快 50 倍？广播机制解决了什么问题？

---

### 🧠 费曼三句话（番茄3）

> 1. **NumPy 数组 = Python 列表 + 极速引擎**——底层用 C 语言操作连续内存块，比 Python 循环快几十倍。AI 和数据分析的所有计算都建立在 NumPy 之上。
> 2. **向量化运算让你不用写循环**——`arr * 2 + 1` 一行代码就完成了"每个元素乘以2再加1"的操作。代码更短、更清晰、更快。
> 3. **广播机制是 NumPy 的优雅魔法**——小数组自动扩展匹配大数组，避免了手动复制数据的麻烦和低效。

### ❓ 悬疑追问

> NumPy 处理的是"数值"。但真实世界的数据不仅有数字，还有文字、日期、缺失值、分类变量……你怎么把这些"脏"数据整理成 NumPy 能处理的干净矩阵？这就是 Pandas 的战场。

---

## 🍅 番茄4：Pandas 与数据清洗——真实世界中 90% 的时间在干这个

### 🎬 悬疑开场：一个真实的数据科学家的日常

大多数人对 AI/数据科学的想象：
> 写高大上的神经网络 → 训练模型 → 部署 → 改变世界

真实世界中 90% 的时间：
> 导入数据 → 发现一堆缺失值 → 骂数据录入员 → 清洗数据 → 合并表格 → 发现格式不对 → 再次清洗 → 终于可以开始分析了

Anders 曾经说过：**"数据科学家 80% 的时间花在数据准备上，20% 的时间花在抱怨数据准备上。"**

**Pandas** 就是帮你熬过那 80% 时间的工具。

---

### 🔬 核心概念 4.1：Series 和 DataFrame——Pandas 的两大核心

```python
# 🧪 Pandas 基础——Series（一列）和 DataFrame（表格）
import pandas as pd
import numpy as np

# --- Series：一维带标签的数据 ---
print("=== Series ===")
嫌疑人的年龄 = pd.Series([35, 42, 28, 51], 
                          index=["张三", "李四", "王五", "赵六"])
print(嫌疑人的年龄)
print(f"\n平均年龄: {嫌疑人的年龄.mean()}")
print(f"最年长: {嫌疑人的年龄.max()}")
print(f"年龄 > 35: \n{嫌疑人的年龄[嫌疑人的年龄 > 35]}")

# --- DataFrame：二维表格（类似 Excel）---
print("\n=== DataFrame ===")
data = {
    "姓名": ["张三", "李四", "王五", "赵六"],
    "年龄": [35, 42, 28, 51],
    "职业": ["保安", "医生", "程序员", "会计"],
    "有前科": [True, False, False, True],
    "案发时在场": ["是", "否", "是", "不确定"]
}
df = pd.DataFrame(data)
print(df)
print(f"\n基本信息：")
print(f"  形状: {df.shape}")
print(f"  列名: {list(df.columns)}")
```

---

### 🔬 核心概念 4.2：数据清洗——处理真实世界的"脏"数据

```python
# 🧪 数据清洗——侦探整理混乱的线索

# --- 创建一份"脏"数据 ---
dirty_data = {
    "案件编号": ["C001", "C002", "C003", "C004", "C005", "C006"],
    "案发日期": ["2026-01-15", "2026/02/20", "2026-03-10", None, "2026-05-01", "2026-05-01"],
    "受害人年龄": [35, 42, None, 28, 51, -5],        # -5 是异常值
    "涉案金额": ["10000", "20,000", "15000", "30000", None, "五百"],  # 格式不统一
    "破案用时(天)": [3, 7, 14, None, 2, 3],
    "已破案": [True, True, False, "是", "Yes", True],  # 布尔值不统一
}

df_dirty = pd.DataFrame(dirty_data)
print("=== 原始脏数据 ===")
print(df_dirty)
print(f"\n数据类型：\n{df_dirty.dtypes}")

# --- 数据清洗开始 ---
print("\n" + "="*50)
print("🔧 开始数据清洗...")
print("="*50)

# Step 1: 处理日期格式不统一
print("\n📅 Step1: 标准化日期格式")
# 不同格式的日期要统一
df_dirty["案发日期"] = pd.to_datetime(df_dirty["案发日期"], errors="coerce")
print(df_dirty["案发日期"])

# Step 2: 处理缺失值
print("\n📊 Step2: 检查缺失值")
print(df_dirty.isnull().sum())

# 填充或删除缺失值
df_dirty["破案用时(天)"] = df_dirty["破案用时(天)"].fillna(
    df_dirty["破案用时(天)"].mean()  # 用平均值填充
)
print(f"破案用时缺失值填充后:\n{df_dirty['破案用时(天)']}")

# Step 3: 处理异常值
print("\n⚠️ Step3: 处理异常值")
# 年龄不能为负
df_dirty.loc[df_dirty["受害人年龄"] < 0, "受害人年龄"] = None
df_dirty["受害人年龄"] = df_dirty["受害人年龄"].fillna(
    df_dirty["受害人年龄"].median()  # 用中位数填充
)
print(f"受害人年龄修正后:\n{df_dirty['受害人年龄']}")

# Step 4: 统一格式
print("\n🔄 Step4: 统一格式")
# 涉案金额：去掉逗号，转成数字
def clean_amount(val):
    if pd.isna(val):
        return None
    if isinstance(val, str):
        val = val.replace(",", "").strip()
        # 如果是中文数字，这里简化处理
        if val == "五百":
            return 500
        return float(val)
    return float(val)

df_dirty["涉案金额"] = df_dirty["涉案金额"].apply(clean_amount)
print(f"涉案金额清洁后:\n{df_dirty['涉案金额']}")

# 已破案：统一成布尔值
def clean_bool(val):
    if isinstance(val, bool):
        return val
    if isinstance(val, str):
        return val.lower() in ["是", "yes", "true", "1"]
    return False

df_dirty["已破案"] = df_dirty["已破案"].apply(clean_bool)

# --- 最终结果 ---
print("\n" + "="*50)
print("✅ 数据清洗完成！")
print("="*50)
print(df_dirty)
print(f"\n数据类型：\n{df_dirty.dtypes}")
```

---

### 🔬 核心概念 4.3：数据分组与聚合——从数据中提取线索

```python
# 🧪 数据分组分析——分组探索数据中的模式

# --- 创建一个更完整的数据集 ---
np.random.seed(42)
case_data = pd.DataFrame({
    "案件类型": np.random.choice(["盗窃", "诈骗", "暴力", "网络犯罪"], 100),
    "破案用时": np.random.randint(1, 30, 100),
    "涉案金额": np.random.randint(1000, 100000, 100),
    "警员数量": np.random.randint(2, 10, 100),
    "已破案": np.random.choice([True, False], 100, p=[0.7, 0.3]),
})

print("=== 案件数据集（前5行）===")
print(case_data.head())

# --- GroupBy：按类别分组 ---
print("\n🔍 按案件类型分析：")
grouped = case_data.groupby("案件类型")

# 每组的基本统计
print(grouped[["破案用时", "涉案金额"]].mean())

# --- 聚合分析 ---
print("\n📊 各类型案件详细聚合：")
analysis = case_data.groupby("案件类型").agg({
    "破案用时": ["mean", "std", "min", "max"],
    "涉案金额": ["sum", "mean"],
    "已破案": "mean",  # 破案率
    "警员数量": "mean"
})
print(analysis)

# --- 条件过滤 + 分组 ---
print("\n🎯 高价值案件分析（涉案金额 > 50000）：")
high_value = case_data[case_data["涉案金额"] > 50000]
print(high_value.groupby("案件类型")["破案用时"].agg(["mean", "count"]))

# --- 交叉分析 ---
print("\n🔄 破案率 × 案件类型 × 警员数量等级：")
case_data["警力等级"] = pd.cut(
    case_data["警员数量"], 
    bins=[0, 3, 6, 10], 
    labels=["少", "中", "多"]
)
pivot = pd.pivot_table(
    case_data,
    values="已破案",
    index="案件类型",
    columns="警力等级",
    aggfunc="mean"
)
print(pivot)
```

> ✋ **费曼自测**：如果让你用一句话解释 Pandas 和 Excel 的区别，你怎么说？

---

### 🧠 费曼三句话（番茄4）

> 1. **Pandas 是 Python 界的 Excel**——DataFrame 就像一个超级智能的电子表格，但比 Excel 强在：能处理百万行数据、能用代码重复操作、能无缝对接机器学习的库。
> 2. **数据清洗是 AI 工作中最枯燥但最重要的一环**——真实世界的数据从来都是脏的：缺失值、格式不统一、异常值、数据类型混乱。Pandas 提供了全套的"清洁工具"。
> 3. **GroupBy 是数据探索的核心操作**——按组分析（groupby + agg）就是从数据中发现模式的根本方法。"盗窃案的平均破案时间 vs 诈骗案的平均破案时间"——这种对比就是数据分析的本质。

### ❓ 悬疑追问

> 数据清洗完，分析做完了。但如果你要给老板汇报，你打算怎么办？把这一堆数字拍他桌上？——不，你需要可视化。一个漂亮的图表胜过一千行数据。这就是下一个番茄的故事。

---

## 🍅 番茄5：Matplotlib 可视化——一图胜千言

### 🎬 悬疑开场：为什么侦探办公室有一面大白板？

每个侦探剧里都有一面大白板——上面贴满了照片、用红线连来连去。为什么？因为**人的大脑天生不擅长处理抽象数字，但天生擅长处理视觉信息**。

你花了 4 个番茄处理数据、分析模式——但如果不把结果"画"出来，这些洞察就只存在于你的脑子里。Matplotlib 就是把你分析结果"画"到白板上的工具。

---

### 🔬 核心概念 5.1：Matplotlib 基础——画出你的第一条线

```python
# 🧪 Matplotlib 基础——从数据到视觉
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# 设置中文字体（Windows）
plt.rcParams['font.sans-serif'] = ['SimHei', 'DejaVu Sans']
plt.rcParams['axes.unicode_minus'] = False

print("=== Matplotlib 可视化基础 ===\n")

# --- 最简单的图：折线图 ---
x = [1, 2, 3, 4, 5, 6, 7]
y = [3, 7, 2, 8, 5, 9, 4]

plt.figure(figsize=(10, 4))
plt.plot(x, y, marker='o', linestyle='-', color='b', linewidth=2, markersize=8)
plt.title("📈 每日线索发现数量")
plt.xlabel("天数")
plt.ylabel("线索数")
plt.grid(True, alpha=0.3)
plt.show()  # 在 Jupyter 中用 %matplotlib inline 可直接显示
```

---

### 🔬 核心概念 5.2：四大基本图表——侦探的视觉工具包

```python
# 🧪 四大基本图表类型

# 生成模拟数据
np.random.seed(42)

# 1️⃣ 折线图：展示趋势
print("📊 图表1 - 折线图：展示时间趋势")
months = ["1月", "2月", "3月", "4月", "5月", "6月"]
crime_rate = [45, 52, 48, 63, 58, 71]

plt.figure(figsize=(10, 5))
plt.plot(months, crime_rate, marker='o', linewidth=2, markersize=8, color='#E74C3C')
plt.title("📈 上半年犯罪率变化趋势", fontsize=14)
plt.xlabel("月份")
plt.ylabel("案件数量")
plt.grid(True, alpha=0.3)

# 标注最高点
max_idx = crime_rate.index(max(crime_rate))
plt.annotate(f'峰值: {max(crime_rate)}件', 
             xy=(max_idx, max(crime_rate)),
             xytext=(max_idx + 0.5, max(crime_rate) + 5),
             arrowprops=dict(arrowstyle='->', color='red'))
plt.show()

# 2️⃣ 柱状图：比较不同类别的值
print("\n📊 图表2 - 柱状图：类别对比")
crime_types = ["盗窃", "诈骗", "暴力", "网络犯罪", "经济犯罪"]
case_counts = [120, 85, 63, 145, 42]

plt.figure(figsize=(10, 5))
bars = plt.bar(crime_types, case_counts, color=['#3498DB', '#E74C3C', '#2ECC71', '#F39C12', '#9B59B6'])
plt.title("📊 各类案件数量对比", fontsize=14)
plt.xlabel("案件类型")
plt.ylabel("案件数量")

# 在柱子上显示数值
for bar, count in zip(bars, case_counts):
    plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 2,
             str(count), ha='center', va='bottom')
plt.show()

# 3️⃣ 饼图：展示占比
print("\n📊 图表3 - 饼图：占比分析")
sizes = [35, 25, 20, 12, 8]
labels = ["有明确嫌疑人", "有DNA证据", "有监控证据", "有指纹证据", "无线索"]
colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7']
explode = (0.05, 0.05, 0.05, 0.05, 0.1)  # 突出"无线索"

plt.figure(figsize=(8, 8))
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct='%1.1f%%', shadow=True, startangle=90)
plt.title("🎯 案件线索类型分布", fontsize=14)
plt.axis('equal')  # 保证饼图是圆的
plt.show()

# 4️⃣ 散点图：展示两个变量的关系
print("\n📊 图表4 - 散点图：变量间关系")
# 警员数量 vs 破案用时
num_officers = np.random.randint(2, 10, 50)
solve_time = 25 - num_officers * 2 + np.random.randn(50) * 3  # 负相关
solve_time = np.clip(solve_time, 1, 30)  # 保证正数

plt.figure(figsize=(10, 5))
plt.scatter(num_officers, solve_time, alpha=0.6, s=100, c='#3498DB', edgecolors='white')
plt.title("👥 警员数量 vs 破案用时", fontsize=14)
plt.xlabel("警员数量")
plt.ylabel("破案用时（天）")

# 添加趋势线
z = np.polyfit(num_officers, solve_time, 1)
p = np.poly1d(z)
plt.plot(sorted(num_officers), p(sorted(num_officers)), 
         linestyle='--', color='red', alpha=0.7, label='趋势线')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()
```

---

### 🔬 核心概念 5.3：多子图与综合可视化——一页纸的破案报告

```python
# 🧪 综合可视化——生成一份"破案分析报告"
print("📑 生成综合破案分析报告...\n")

# 1. 创建综合数据集
np.random.seed(42)
n = 200
data = pd.DataFrame({
    '案件类型': np.random.choice(['盗窃', '诈骗', '暴力', '网络犯罪'], n),
    '破案用时': np.random.randint(1, 30, n),
    '涉案金额': np.random.randint(1000, 100000, n),
    '警员数量': np.random.randint(2, 10, n),
    '季节': np.random.choice(['春', '夏', '秋', '冬'], n),
})

# 2. 创建 2×2 的多子图
fig, axes = plt.subplots(2, 2, figsize=(14, 10))
fig.suptitle('🕵️ 综合案件分析报告', fontsize=16, fontweight='bold')

# 左上：各类案件平均破案用时
ax1 = axes[0, 0]
case_type_stats = data.groupby('案件类型')['破案用时'].mean().sort_values()
ax1.barh(case_type_stats.index, case_type_stats.values, color='#3498DB')
ax1.set_title('📈 各类案件平均破案用时')
ax1.set_xlabel('平均用时（天）')

# 右上：涉案金额分布直方图
ax2 = axes[0, 1]
ax2.hist(data['涉案金额'] / 10000, bins=15, color='#2ECC71', edgecolor='white', alpha=0.7)
ax2.set_title('💰 涉案金额分布')
ax2.set_xlabel('涉案金额（万元）')
ax2.set_ylabel('案件数量')

# 左下：警员数量 vs 破案用时散点图
ax3 = axes[1, 0]
colors = {'盗窃': 'red', '诈骗': 'blue', '暴力': 'green', '网络犯罪': 'orange'}
for crime_type in data['案件类型'].unique():
    subset = data[data['案件类型'] == crime_type]
    ax3.scatter(subset['警员数量'], subset['破案用时'], 
                alpha=0.6, label=crime_type, c=colors.get(crime_type, 'gray'))
ax3.set_title('👥 警力配置与破案效率')
ax3.set_xlabel('警员数量')
ax3.set_ylabel('破案用时（天）')
ax3.legend()
ax3.grid(True, alpha=0.3)

# 右下：各季节案件类型占比（堆叠柱状图）
ax4 = axes[1, 1]
season_crime = pd.crosstab(data['季节'], data['案件类型'], normalize='index')
season_crime.plot(kind='bar', stacked=True, ax=ax4, colormap='Set2')
ax4.set_title('🍂 各季节案件类型分布')
ax4.set_xlabel('季节')
ax4.set_ylabel('占比')
ax4.legend(bbox_to_anchor=(1.05, 1), loc='upper left')

plt.tight_layout()
plt.show()
```

---

### 🔬 核心概念 5.4：图表类型选择指南——什么时候用什么图

```
📈 折线图 → 展示时间趋势
  └─ 用法: 案件数量随月份变化、收入逐年增长

📊 柱状图 → 比较不同类别
  └─ 用法: 各类型案件数量对比、各部门破案率对比

🥧 饼图 → 展示构成比例（类别不超过5个）
  └─ 用法: 案件类型占比、资源分配比例

🔵 散点图 → 展示两变量关系
  └─ 用法: 警员数量 vs 破案用时、年龄 vs 涉案金额

📦 箱线图 → 展示数据分布
  └─ 用法: 不同案件类型的破案用时分布

🔥 热力图 → 展示相关性矩阵
  └─ 用法: 各特征之间的相关程度、混淆矩阵
```

> ✋ **费曼自测**：给你一个问题——"比较不同部门的月销售额趋势"——你应该用什么图表？为什么？

---

### 🧠 费曼三句话（番茄5）

> 1. **可视化的本质是把"数字"变成"形状"**——人类大脑处理视觉信息的速度比处理文本快 6 万倍。一个好的图表胜过一千行数据。
> 2. **选对图表比画好图表更重要**——趋势用折线图，对比用柱状图，占比用饼图，关系用散点图。用错了会误导人。
> 3. **可视化是数据分析的"最后一公里"**——没有可视化，你的分析洞察就只存在于你的 Jupyter Notebook 里。有了可视化，你才能说服别人。

### ❓ 悬疑追问

> 你今天学会了怎么用 Python 处理数据。但有一个更深层的问题：**当一个数据点和一个数据点之间存在"规律"的时候，你怎么让计算机自动发现这些规律？**
>
> 下一站，Day03 将回答这个问题。**算法——让计算机自己寻找模式的艺术。**

---

## 🎯 刻意练习（独立探案）

> **基础题（模仿阶段）：**
>
> 1. 创建一个包含 5 个嫌疑人信息的字典列表（每个嫌疑人有姓名、年龄、职业、是否有前科），并用 for 循环打印出来
> 2. 用 NumPy 生成一个 5×5 的随机矩阵，计算每列的平均值
> 3. 用 Pandas 读取你电脑上的一个 CSV 文件（或者自己创建一个），打印前 5 行和数据摘要
>
> **进阶层（变式阶段）：**
>
> 4. 写一个函数 `clean_sales_data(df)`，能处理销售额数据中的缺失值（用平均值填充）和异常值（超过 3 倍标准差视为异常）
> 5. 用 Matplotlib 生成一个"4 种犯罪类型 × 4 个季度"的群组柱状图
>
> **挑战题（创造阶段）：**
>
> 6. 综合运用 Pandas 和 Matplotlib：找一份真实世界的数据集（比如 Kaggle 上的 Titanic 数据集），完成全流程：导入 → 清洗 → 分析 → 可视化 → 输出 5 条洞察

---

## 📌 连线思考

> 今天学到的所有 Python 工具——列表、字典、NumPy 数组、Pandas DataFrame——它们在计算机底层其实都是**数据结构**的不同实现。你用得越顺手，说明你对数据结构的直觉越好。
>
> Day04 会深入数据结构内部，让你看到这些"容器"的底层逻辑。而现在，你手里已经有了一个可以用的工具包。

> **下一站预告**：Day03——算法思维。如果 Python 是你的枪，算法就是你的枪法。同样的工具，高手和菜鸟用起来天差地别——区别就在算法。
