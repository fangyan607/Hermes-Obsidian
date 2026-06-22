---
created: 2026-06-15
tags:
  - "#AI教程"
  - "#番茄学习法"
  - "#数据结构"
  - "#链表"
  - "#栈"
  - "#队列"
  - "#哈希表"
  - "#树"
  - "#图"
  - "#Day04"
aliases:
  - Day04-数据结构
  - 信息的组织形式与操作
  - 120番茄-Day04
---

# 🍅 Day04：数据结构——信息的组织形式与操作

> **案件编号**：Case#004 — Part 1 终章
> **案发时间**：计算机科学诞生之初
> **案件名**：同样的数据，用什么"容器"装——决定了你能多快找到答案
>
> "数据结构 + 算法 = 程序。" — Niklaus Wirth
>
> "容器决定了速度，选择决定了命运。"

---

## 🍅 番茄1：数组与链表——连续 vs 链式

### 🎬 悬疑开场：两种极端的存储哲学

你是一个侦探，手上有一份 1000 人的证人名单。你有两种方式存放这份名单：

**方式 A — 连续存放（数组）：**
你有一个带编号的文件夹柜，1 号抽屉放第 1 个证人，2 号抽屉放第 2 个证人……以此类推。要找到第 500 个证人，你直接走到 500 号抽屉——**O(1)**。但是你想在中间插入一个新证人，你需要把后面的所有抽屉重新编号——**O(n)**。

**方式 B — 链式存放（链表）：**
你有一串"寻宝图"——每张卡片上写着一个证人的名字，以及下一张卡片的位置。要找到第 500 个证人，你必须从第一张开始，按图索骥 500 次——**O(n)**。但是要插入一个新证人，你只需要撕掉两张卡片之间的连接，插进去重新连上——**O(1)**。

这就是数据结构的第一课：**没有完美的结构，只有适合场景的选择。**

---

### 🔬 核心概念 1.1：数组——连续的内存块

```python
# 🧪 数组——连续内存存储的哲学

# Python 的 list 实际上是"动态数组"
# 底层是连续的内存块

print("=== 数组的特征 ===\n")

# 特征1：连续内存，随机访问 O(1)
arr = [10, 20, 30, 40, 50]
print(f"数组: {arr}")
print(f"访问 arr[2] = {arr[2]}  # O(1) — 直接通过地址偏移计算位置")
print(f"访问 arr[0] = {arr[0]}  # O(1) — 不管数组多大，时间一样\n")

# 特征2：插入/删除末尾 O(1)，中间 O(n)
print("--- 插入操作的时间 ---")
arr.append(60)  # 末尾插入 O(1)
print(f"末尾追加 60: {arr} (O(1))")

arr.insert(0, 5)  # 开头插入 O(n) — 所有元素要后移
print(f"开头插入 5: {arr} (O(n) — 需要后移)")

arr.insert(2, 25)  # 中间插入 O(n)
print(f"中间插入 25: {arr} (O(n) — 有一部分要后移)\n")

# 特征3：预分配 vs 动态扩容
print("--- 动态数组的扩容机制 ---")
import sys
small_arr = []
for i in range(10):
    small_arr.append(i)
    print(f"  元素数: {i+1:2d}, 底层占用: {sys.getsizeof(small_arr):4d} 字节")
    # 可以看到容量并不是每次 +1，而是成倍增长的
print("\n(数组会预分配额外的空间，所以 append 大多数时候是 O(1))")

# 数组的内存布局示意图
print("""
📋 数组在内存中的样子：

  地址: 1000  1004  1008  1012  1016  1020
       ┌─────┬─────┬─────┬─────┬─────┬─────┐
       │  10 │  20 │  30 │  40 │  50 │  60 │
       └─────┴─────┴─────┴─────┴─────┴─────┘
         ↑
       arr[0]  →  直接通过 arr[0] 的地址 + 索引 × 每个元素大小 找到任意元素
                   
  优点: 随机访问 O(1), 内存利用率高
  缺点: 插入/删除中间元素需要移动其他元素 O(n)
""")
```

---

### 🔬 核心概念 1.2：链表——非连续的"寻宝链"

```python
# 🧪 链表——非连续存储的哲学

class ListNode:
    """链表的节点——每个节点存数据 + 指向下一个节点的指针"""
    def __init__(self, data):
        self.data = data  # 数据
        self.next = None  # 指向下一个节点的"指针"

class LinkedList:
    """单向链表"""
    def __init__(self):
        self.head = None  # 头节点
        self._size = 0
    
    def append(self, data):
        """在末尾追加 (O(n))"""
        new_node = ListNode(data)
        if not self.head:
            self.head = new_node
        else:
            current = self.head
            while current.next:
                current = current.next
            current.next = new_node
        self._size += 1
    
    def insert_at_beginning(self, data):
        """在开头插入 (O(1)) — 数组做不到！"""
        new_node = ListNode(data)
        new_node.next = self.head
        self.head = new_node
        self._size += 1
        print(f"  在开头插入 {data}: O(1) — 只改指针，不需要移动任何元素")
    
    def insert_after(self, target_data, new_data):
        """在指定节点后插入 (O(n), 但插入本身是 O(1))"""
        current = self.head
        while current and current.data != target_data:
            current = current.next
        
        if current:
            new_node = ListNode(new_data)
            new_node.next = current.next
            current.next = new_node
            self._size += 1
            print(f"  在 {target_data} 后插入 {new_data}: 插入本身 O(1)")
            return True
        return False
    
    def delete(self, data):
        """删除指定节点 (O(n))"""
        if not self.head:
            return False
        
        if self.head.data == data:
            self.head = self.head.next
            self._size -= 1
            print(f"  删除 {data}: 改头指针即可 O(1)")
            return True
        
        current = self.head
        while current.next and current.next.data != data:
            current = current.next
        
        if current.next:
            current.next = current.next.next
            self._size -= 1
            print(f"  删除 {data}: 跳过该节点 O(1)")
            return True
        return False
    
    def get(self, index):
        """按下标访问 (O(n)) — 数组是 O(1)"""
        if index < 0 or index >= self._size:
            return None
        current = self.head
        for _ in range(index):
            current = current.next
        return current.data if current else None
    
    def display(self):
        """打印链表"""
        elements = []
        current = self.head
        while current:
            elements.append(str(current.data))
            current = current.next
        print("  " + " → ".join(elements) + " → None")
    
    def __len__(self):
        return self._size

# 演示链表
print("=== 链表的特征 ===\n")

# 创建链表
linked_list = LinkedList()
for val in [10, 20, 30, 40, 50]:
    linked_list.append(val)

print(f"初始链表:")
linked_list.display()

print(f"\n--- 插入操作 ---")
linked_list.insert_at_beginning(5)   # O(1) 开头插入
linked_list.display()

linked_list.insert_after(30, 35)     # 中间插入
linked_list.display()

print(f"\n--- 删除操作 ---")
linked_list.delete(20)               # 删除
linked_list.display()

print(f"\n--- 访问操作 ---")
print(f"get(0) = {linked_list.get(0)}  # O(1) — 第一个元素")
print(f"get(3) = {linked_list.get(3)}  # O(n) — 需要从头遍历")

# 链表内存布局示意
print("""
📋 链表在内存中的样子：

  每个节点在内存中任意位置，通过"指针"串起来

  节点1(地址0xA0)    节点2(地址0xF3)    节点3(地址0x2C)
  ┌──────────┐      ┌──────────┐      ┌──────────┐
  │ data: 10 │      │ data: 20 │      │ data: 30 │
  │ next: ───┼─────→│ next: ───┼─────→│ next: ───┼──→ ...
  └──────────┘      └──────────┘      └──────────┘
        ↑
      head (引用第一个节点)

  优点: 插入/删除 O(1)（只要你知道位置）
  缺点: 随机访问 O(n), 需要额外内存存指针
""")
```

---

### 🔬 核心概念 1.3：数组 vs 链表——终极对比

```python
# 🧪 数组 vs 链表 —— 场景对决

print("="*60)
print("⚔️  数组 vs 链表 · 终极对决")
print("="*60)

print("""
┌──────────────┬─────────────────────┬──────────────────────┐
│   操作        │  数组 (动态数组)     │  链表 (单向链表)      │
├──────────────┼─────────────────────┼──────────────────────┤
│ 随机访问      │  O(1) 🏆            │  O(n)                │
│ 开头插入      │  O(n)               │  O(1) 🏆             │
│ 末尾插入      │  O(1)*              │  O(n)                │
│ 中间插入      │  O(n)               │  O(n) 但插入操作 O(1)│
│ 删除          │  O(n)               │  O(n) 但删除操作 O(1)│
│ 内存占用      │  低（纯数据）        │  高（额外指针）       │
│ 内存连续性    │  连续 🏆 (缓存友好)  │  分散（缓存不友好）   │
└──────────────┴─────────────────────┴──────────────────────┘
  * 均摊 O(1)，偶尔需要扩容
""")

print("🎯 选择指南：")
print("""
  用数组（Python list）：
  ├─ 需要频繁按索引访问 → 用数组
  ├─ 主要在末尾添加/删除 → 用数组
  ├─ 对内存连续性有要求 → 用数组
  └─ 实战中的 95% 场景 → 用数组（Python list 够强了！）
  
  用链表：
  ├─ 需要频繁在开头/中间插入删除 → 用链表
  ├─ 不知道数据总量 → 链表天然动态
  ├─ 需要实现队列/栈等结构 → 链表是底层实现
  └─ 实战中的 5% 特殊场景 → 用链表
""")

# 实战场景对照
import time

print("📊 实战性能对比：")

# 场景1：在开头大量插入
print("\n场景1：在开头插入 100,000 个元素")
data_size = 100000

# 数组（list）在开头插入
arr = []
start = time.time()
for i in range(data_size):
    arr.insert(0, i)  # 每次都要移动所有元素
arr_time = time.time() - start
print(f"  数组开头插入: {arr_time:.4f} 秒")

# 链表在开头插入
linked = LinkedList()
start = time.time()
for i in range(data_size):
    linked.insert_at_beginning(i)
linked_time = time.time() - start
print(f"  链表开头插入: {linked_time:.4f} 秒")
print(f"  🏆 链表快了 {arr_time/linked_time:.0f} 倍")
```

> ✋ **费曼自测**：如果用数组实现一个"经常需要在中间插入和删除"的功能（比如任务调度器），会有什么问题？链表又是怎么解决这个问题的？

---

### 🧠 费曼三句话（番茄1）

> 1. **数组是"连续的内存块"**——随机访问 O(1) 极快，但插入/删除中间元素需要"搬动"其他元素。就像编号的文件夹柜，找快、插慢。
> 2. **链表是"非连续的寻宝链"**——每个节点存数据 + 指向下一个的指针。插入只要改指针 O(1)，但按索引访问 O(n)。就像寻宝图，找慢、插快。
> 3. **没有"最好的"数据结构，只有"最适合场景的"**——大多数场景用动态数组（Python 的 list）就行，链表在需要频繁插入/删除时发光。

### ❓ 悬疑追问

> 数组和链表是两种最基础的"容器"。但它们有一个共同特点——你只能在**两头或任意位置**操作。如果我说，有一个结构，你永远只能从**一个特定的方向**操作——那是什么？

---

## 🍅 番茄2：栈与队列——后进先出 vs 先进先出

### 🎬 悬疑开场：两个现实世界的"容器"

**栈（Stack）**：一摞盘子。你永远只能从最上面取盘子，也永远只能把新盘子放在最上面。**后进先出（LIFO: Last In, First Out）**。

**队列（Queue）**：排队买奶茶。先来的人先买到，后来的人排后面。**先进先出（FIFO: First In, First Out）**。

这两个"容器"看起来简单到可笑——但它们是计算机科学中**最广泛应用**的数据结构之二。从函数调用到任务调度，从浏览器的"后退"按钮到打印机的任务队列——都在用栈和队列。

---

### 🔬 核心概念 2.1：栈——"后进先出"的哲学

```python
# 🧪 栈的实现与应用

class Stack:
    """
    栈：后进先出 (LIFO)
    
    就像一摞盘子：
    - push: 放一个盘子在顶上
    - pop: 从顶上拿走一个盘子
    - peek: 看一眼顶上是什么
    """
    def __init__(self):
        self.items = []
    
    def push(self, item):
        """压栈：把元素放到栈顶 (O(1))"""
        self.items.append(item)
        print(f"  推入: {item}")
    
    def pop(self):
        """出栈：从栈顶取出元素 (O(1))"""
        if self.is_empty():
            return None
        item = self.items.pop()
        print(f"  弹出: {item}")
        return item
    
    def peek(self):
        """查看栈顶元素 (O(1))"""
        if self.is_empty():
            return None
        return self.items[-1]
    
    def is_empty(self):
        return len(self.items) == 0
    
    def size(self):
        return len(self.items)
    
    def display(self):
        """从栈顶到栈底显示"""
        print("  栈状态 (栈顶←):", self.items[::-1] if self.items else "空")

# --- 应用1：浏览器的"后退"按钮 ---
print("🌐 应用1：浏览器后退功能\n")

browser_history = Stack()
current_page = "首页"

print(f"当前页面: {current_page}")

# 访问新页面
pages = ["新闻", "科技频道", "AI专题", "GPT-5发布"]
for page in pages:
    browser_history.push(current_page)  # 把当前页压栈
    current_page = page
    print(f"  → 跳转到: {current_page}")
    print(f"     (之后可按「后退」回到上一页)\n")

# 后退
print("点击「后退」按钮：")
for _ in range(3):
    previous = browser_history.pop()
    if previous:
        print(f"  ← 回到: {previous}")
    current_page = previous if previous else current_page

# --- 应用2：括号匹配（编译器的基石）---
print("\n📐 应用2：括号匹配检测\n")

def is_balanced(expression):
    """
    检查表达式中的括号是否匹配
    
    编译器就是用栈来检查的：
    - 遇到左括号 → 压栈
    - 遇到右括号 → 弹出栈顶，检查是否匹配
    - 最后如果栈空 → 匹配
    """
    stack = Stack()
    pairs = {')': '(', ']': '[', '}': '{'}
    
    for i, char in enumerate(expression):
        if char in '([{':           # 左括号 → 压栈
            stack.push(char)
            print(f"  位置{i}: '{char}' → 入栈")
        elif char in ')]}':          # 右括号 → 检查
            if stack.is_empty():
                print(f"  位置{i}: '{char}' → ❌ 栈空，无法匹配")
                return False
            top = stack.pop()
            expected = pairs[char]
            if top != expected:
                print(f"  位置{i}: '{char}' → ❌ 期望匹配'{expected}'但找到'{top}'")
                return False
            print(f"  位置{i}: '{char}' → ✅ 匹配 '{expected}'")
    
    balanced = stack.is_empty()
    if not balanced:
        print(f"\n  ❌ 还有未匹配的左括号在栈中")
    return balanced

test_expressions = [
    "{[()]}",      # 正确的
    "{[(])}",      # 错误的
]
for expr in test_expressions:
    print(f"\n--- 检查: {expr} ---")
    result = is_balanced(expr)
    print(f"结果: {'✅ 括号匹配' if result else '❌ 括号不匹配'}")
```

---

### 🔬 核心概念 2.2：队列——"先进先出"的哲学

```python
# 🧪 队列的实现与应用

from collections import deque
import time

class Queue:
    """
    队列：先进先出 (FIFO)
    
    就像排队：
    - enqueue: 排到队尾
    - dequeue: 从队头离开
    - front: 看看队头是谁
    """
    def __init__(self):
        # 用 deque（双端队列）实现，两端操作都是 O(1)
        self.items = deque()
    
    def enqueue(self, item):
        """入队：排到队尾 (O(1))"""
        self.items.append(item)
        print(f"  入队: {item} (排在队尾)")
    
    def dequeue(self):
        """出队：队头离开 (O(1))"""
        if self.is_empty():
            return None
        item = self.items.popleft()
        print(f"  出队: {item} (队头离开)")
        return item
    
    def front(self):
        """查看队头 (O(1))"""
        if self.is_empty():
            return None
        return self.items[0]
    
    def is_empty(self):
        return len(self.items) == 0
    
    def size(self):
        return len(self.items)
    
    def display(self):
        print(f"  队列状态 (队头←): {list(self.items)}")

# --- 应用1：打印机任务队列 ---
print("🖨️ 应用1：打印机任务队列\n")

printer_queue = Queue()
tasks = ["文档1.pdf", "图片2.png", "报告3.docx", "表格4.xlsx"]

print("添加打印任务：")
for task in tasks:
    printer_queue.enqueue(task)

print("\n开始打印：")
while not printer_queue.is_empty():
    current = printer_queue.dequeue()
    print(f"  🖨️ 正在打印: {current}...")
    time.sleep(0.2)  # 模拟打印耗时
    print(f"     ✅ 打印完成\n")

# --- 应用2：消息队列（AI 系统的通信基础）---
print("📨 应用2：消息队列——AI Agent 的通信\n")

class MessageQueue:
    """消息队列：AI Agent 之间通过它传递消息"""
    def __init__(self):
        self.queues = {}
    
    def create_queue(self, name):
        self.queues[name] = Queue()
        print(f"  创建消息队列: {name}")
    
    def send(self, queue_name, message):
        """发送消息"""
        if queue_name not in self.queues:
            self.create_queue(queue_name)
        self.queues[queue_name].enqueue(message)
    
    def receive(self, queue_name):
        """接收消息"""
        if queue_name not in self.queues:
            return None
        return self.queues[queue_name].dequeue()

# 模拟 AI Agent 通信
print("构建 AI Agent 消息系统：")
msg_system = MessageQueue()
msg_system.create_queue("agent_messages")

print("\nAgent A 发送消息：")
msg_system.send("agent_messages", "任务1: 分析数据")
msg_system.send("agent_messages", "任务2: 生成报告")
msg_system.send("agent_messages", "任务3: 发送邮件")

print("\nAgent B 按序处理消息：")
while not msg_system.queues["agent_messages"].is_empty():
    message = msg_system.receive("agent_messages")
    print(f"  🤖 Agent B 处理: {message}")
```

---

### 🔬 核心概念 2.3：栈 vs 队列——两种"排队哲学"

```
┌─────────────────────────────────────────────────────────────────┐
│          栈 (Stack)                vs          队列 (Queue)    │
├─────────────────────────────────────────────────────────────────┤
│                                                               │
│  后进先出 (LIFO)                       先进先出 (FIFO)         │
│                                                               │
│  ┌───┐                               ┌───┐ ┌───┐ ┌───┐       │
│  │ C │ ← 栈顶/开口                     │ A │ │ B │ │ C │       │
│  ├───┤                                │   │ │   │ │   │       │
│  │ B │                                └───┘ └───┘ └───┘       │
│  ├───┤                               队头→  ←队尾              │
│  │ A │                                                        │
│  └───┘                                                       │
│                                                               │
│  应用:                                 应用:                   │
│  ├─ 函数调用栈                          ├─ 任务队列             │
│  ├─ 编译器语法分析                      ├─ 消息队列             │
│  ├─ 浏览器的"后退"                     ├─ BFS（广度优先搜索）  │
│  ├─ 撤销(Ctrl+Z)                       ├─ 打印机队列           │
│  └─ 深度优先搜索(DFS)                  └─ 键盘缓冲区           │
│                                                               │
└─────────────────────────────────────────────────────────────────┘
```

> ✋ **费曼自测**：栈和队列的核心区别是什么？能用一个生活场景说明栈的 LIFO 和队列的 FIFO 的区别吗？

---

### 🧠 费曼三句话（番茄2）

> 1. **栈是"后进先出"**——像一摞盘子，你只能从顶上放和取。函数调用、浏览器的"后退"、Ctrl+Z 撤销，都是栈的应用。
> 2. **队列是"先进先出"**——像排队买东西，先来的先服务。任务队列、消息队列、打印机缓冲，都是队列的应用。
> 3. **栈和队列的巧妙之处在于它们的"限制"**——正是这种"你只能从一个方向操作"的限制，让它们的行为变得可预测，适合特定的场景。

### ❓ 悬疑追问

> 我们讨论了链表（灵活插入删除）、数组（随机访问）、栈和队列（受限操作）。但它们有一个共同点：当你"找"一个东西的时候，你仍然只能遍历（O(n)）或者已排序后二分（O(log n)）。
>
> 有没有一种结构，可以在**平均 O(1)** 的时间内找到任何数据？这听起来像是魔法——但计算机科学里有这个魔法：**哈希表**。

---

## 🍅 番茄3：哈希表——O(1) 查找的魔法

### 🎬 悬疑开场：一个像"词典"的魔法盒

想象你要在一座图书馆里找到一本《AI 从入门到精通》。

**没有目录的图书馆**：你只能在书架间挨个找——O(n)。这就是线性搜索。

**按书名首字母排序的图书馆**：你走到"AI"区域，在 A 区里找——O(log n)。这就是二分搜索。

**一本按"书名 → 位置"索引的魔法词典**：你直接查"AI 从入门到精通"→ 位置是"3 楼 A 区 7 架 12 行"。你走过去直接拿——O(1)。

这个"魔法词典"就是**哈希表（Hash Table）**。在 Python 里，它叫**字典（dict）**。

---

### 🔬 核心概念 3.1：哈希表的原理——"函数的力量"

```python
# 🧪 哈希表底层原理模拟

class SimpleHashTable:
    """
    模拟哈希表的工作原理
    
    核心思想：把"键"通过一个函数（哈希函数）映射到一个位置
    - key  →  哈希函数  →  位置（索引）
    - 存: 计算位置，放进去
    - 取: 计算位置，拿出来
    
    这就是为什么 dict 的查找是平均 O(1)
    """
    def __init__(self, size=10):
        self.size = size
        self.table = [[] for _ in range(size)]  # 每个位置是一个桶（列表）
        self._collisions = 0
    
    def _hash(self, key):
        """
        哈希函数：把任意类型的 key 映射到一个整数位置
        
        要求：
        1. 同一个 key 每次计算的结果必须相同（确定性）
        2. 不同的 key 尽量映射到不同的位置（均匀性）
        3. 计算要快
        """
        # Python 内置的 hash 函数
        return hash(key) % self.size
    
    def put(self, key, value):
        """存入键值对"""
        index = self._hash(key)
        bucket = self.table[index]
        
        # 检查 key 是否已存在（更新）
        for i, (k, v) in enumerate(bucket):
            if k == key:
                bucket[i] = (key, value)
                print(f"  更新 [{index}]: {key} = {value}")
                return
        
        # 不存在则添加
        bucket.append((key, value))
        print(f"  插入 [{index}]: {key} = {value}")
        
        if len(bucket) > 1:
            self._collisions += 1
            print(f"    ⚠️ 哈希冲突！桶[{index}] 现在有 {len(bucket)} 个元素")
    
    def get(self, key):
        """根据键取值"""
        index = self._hash(key)
        bucket = self.table[index]
        
        for k, v in bucket:
            if k == key:
                return v
        
        return None  # Key not found
    
    def display(self):
        """显示哈希表内部结构"""
        print(f"\n📊 哈希表内部结构 (size={self.size}):")
        for i, bucket in enumerate(self.table):
            if bucket:
                print(f"  [{i}]: {bucket}")
            else:
                print(f"  [{i}]: 空")
        print(f"  总冲突: {self._collisions}")

# 演示哈希表
print("=== 哈希表的工作原理 ===\n")

# 创建哈希表
ht = SimpleHashTable(size=8)

# 插入一些键值对
print("插入数据：")
ht.put("张三", 35)
ht.put("李四", 42)
ht.put("王五", 28)
ht.put("赵六", 51)
ht.put("陈七", 29)

ht.display()

# 查找
print("\n--- 查找 ---")
for name in ["张三", "王五", "不存在"]:
    result = ht.get(name)
    print(f"  查询 '{name}' → {'O(1) 找到: ' + str(result) if result else '❌ 未找到'}")

print("\n📝 关键洞察：")
print("  dict['张三'] 不是"翻遍整个字典"——而是直接计算位置！")
print("  这就是为什么 dict 查找是 O(1) 而不是 O(n)")
```

---

### 🔬 核心概念 3.2：哈希冲突——"不可能完美的魔法"

```python
# 🧪 哈希冲突——为什么哈希表不是完美的

print("=== 哈希冲突 ===")
print("""
  理想情况：每个 key 映射到不同的位置 → O(1)
  现实情况：不同的 key 可能映射到相同的位置 → 「冲突」
  
  处理冲突的两种主要方法：
  
  1️⃣ 链地址法（Separate Chaining）
     ┌──────┐    ┌───┐ ┌───┐ ┌───┐
     │索引 3 │───→│ K1│→│ K5│→│ K8│
     └──────┘    └───┘ └───┘ └───┘
     同一个桶用链表串联 → 冲突多了退化成 O(n)
     
  2️⃣ 开放地址法（Open Addressing）
     冲突了就往后找空位
     ┌───┬───┬───┬───┬───┬───┐
     │ K1│ K5│ K8│   │   │   │
     └───┴───┴───┴───┴───┴───┘
       ↑ 冲突↑ 再冲突↑ 终于找到了
""")

# 演示哈希冲突对性能的影响
print("\n📊 对比：好哈希 vs 坏哈希")

def poor_hash(key):
    """糟糕的哈希函数：把所有键映射到很少的位置"""
    return len(str(key)) % 3  # 只用长度取模3，大量冲突

class PoorHashTable:
    """用糟糕哈希函数的哈希表"""
    def __init__(self):
        self.size = 10
        self.table = [[] for _ in range(self.size)]
    
    def _hash(self, key):
        return poor_hash(key) % self.size
    
    def put(self, key, value):
        index = self._hash(key)
        self.table[index].append((key, value))
    
    def get(self, key):
        index = self._hash(key)
        bucket = self.table[index]
        for k, v in bucket:
            if k == key:
                return v
        return None

# 插入相同哈希值的键
print("\n用糟糕的哈希函数：")
bad_ht = PoorHashTable()
for i in range(20):
    key = f"user_{i}"
    bad_ht.put(key, i * 10)

# 查看分布
for i, bucket in enumerate(bad_ht.table):
    if bucket:
        print(f"  桶[{i}]: {len(bucket)} 个元素 {[k for k, _ in bucket]}")
    else:
        print(f"  桶[{i}]: 空")

print("""
  ⚠️ 问题：所有键都集中在少数几个桶里
  ⚠️ 查找退化成了 O(桶内元素数) ≈ O(n)
  ⚠️ 哈希表失去了它的"魔法"
  
  ✅ 好的哈希函数应该让键均匀分布
  ✅ Python 的 dict 底层有高度优化的哈希函数
""")

# Python dict 的实际性能
import time

print("\n⚡ Python dict 的实际性能：")
n = 1_000_000
test_dict = {f"key_{i}": i for i in range(n)}

start = time.time()
for i in range(10000):
    _ = test_dict[f"key_{i}"]
dict_time = time.time() - start

print(f"  在 {n:,} 条数据的 dict 中查找 10,000 次: {dict_time:.6f} 秒")
print(f"  平均每次: {dict_time/10000*1_000_000:.2f} 微秒")
print(f"  ✅ 这就是 O(1) 平均的威力！")
```

---

### 🔬 核心概念 3.3：Python dict 的一行禅机

```python
# 🧪 Python dict 实战——哈希表在 AI 中的无处不在

print("=== Python dict 的 AI 应用场景 ===\n")

# 场景1：特征缓存（空间换时间）
print("📊 场景1：特征缓存")
feature_cache = {}

def extract_features(text):
    """提取文本特征（带缓存）"""
    # 用文本作为 key 的哈希值
    cache_key = hash(text) 
    
    if cache_key in feature_cache:  # O(1)
        print(f"  ✅ 缓存命中: {text[:20]}...")
        return feature_cache[cache_key]
    
    print(f"  🔄 计算特征: {text[:20]}...")
    # 模拟复杂的特征提取
    features = {
        "length": len(text),
        "word_count": len(text.split()),
        "has_punctuation": any(c in ".,!?" for c in text),
    }
    feature_cache[cache_key] = features  # O(1) 存储
    return features

# 第一次调用——慢
extract_features("这是第一条测试文本，用来测试缓存功能")
# 第二次调用——快（缓存命中）
extract_features("这是第一条测试文本，用来测试缓存功能")

# 场景2：词频统计（最简单的文本分析）
print("\n📊 场景2：词频统计")
text = "the cat and the dog and the mouse and the cat"
word_counts = {}

for word in text.split():
    # dict.get 默认值用法：如果 key 不存在返回 0
    word_counts[word] = word_counts.get(word, 0) + 1

print(f"  词频: {word_counts}")

# 场景3：哈希表在神经网络中的对应
print("\n🤖 场景3：哈希概念 → 神经网络嵌入层")
word_to_index = {
    "猫": 0, "狗": 1, "老鼠": 2, "鸟": 3,
}
index_to_word = {v: k for k, v in word_to_index.items()}  # 反转字典

# 每个词对应一个"嵌入向量"（在神经网络中就是权重矩阵的行）
embeddings = [
    [0.1, 0.2, 0.3],  # 猫
    [0.4, 0.5, 0.6],  # 狗
    [0.7, 0.8, 0.9],  # 老鼠
    [1.0, 1.1, 1.2],  # 鸟
]

# 通过哈希表（字典）O(1) 找到"猫"的嵌入向量
word = "猫"
idx = word_to_index[word]  # O(1)
vector = embeddings[idx]   # O(1)
print(f"  '{word}' → 索引 {idx} → 嵌入向量 {vector}")
```

> ✋ **费曼自测**：为什么说哈希表的查找是"平均 O(1)"而不是"严格 O(1)"？什么情况下哈希表会退化成 O(n)？

---

### 🧠 费曼三句话（番茄3）

> 1. **哈希表是"用函数计算位置"的魔法字典**——通过哈希函数把键直接映射到存储位置，所以插入/查找平均 O(1)。Python 的 dict 和 set 都是哈希表。
> 2. **哈希冲突是哈希表的"阿基里斯之踵"**——不同的键可能映射到同一个位置。解决方法是链地址法或开放地址法。冲突多了，O(1) 会退化成 O(n)。
> 3. **哈希表的本质是"空间换时间"**——用额外的内存（预分配桶）换取极致的查找速度。在 AI 中，缓存、特征存储、词汇表都大量使用哈希思想。

### ❓ 悬疑追问

> 哈希表让"通过一个键找一个值"变得极快。但现实中的关系更复杂——数据之间不仅有"一对一"的关系，还有"一对多"（一个父节点有多个子节点）、"多对多"（社交网络）。
>
> 要表达这些层级/网络关系，我们需要新的数据结构——**树**和**图**。

---

## 🍅 番茄4：树与图——层级关系与网络关系

### 🎬 悬疑开场：从档案室到社交网络

我们前面学到的所有数据结构——数组、链表、栈、队列、哈希表——都很擅长处理**线性关系**。一个接一个，或者一个键对应一个值。

但真实世界的关系更复杂：

- **层级关系**：公司的组织架构（总经理 → 部门经理 → 员工）、电脑的文件系统（文件夹套文件夹）、AI 决策树（条件分支再分支）
- **网状关系**：社交网络（朋友的朋友的朋友）、知识图谱（实体之间的任意连接）、神经网络（神经元之间的复杂连接）

**树**处理层级关系，**图**处理网状关系。它们是 AI 世界的"骨架"。

---

### 🔬 核心概念 4.1：树——层级关系的表达

```python
# 🧪 树——层级结构

class TreeNode:
    """树的节点"""
    def __init__(self, name, title=""):
        self.name = name
        self.title = title
        self.children = []  # 子节点列表
        self.parent = None  # 父节点引用（可选）
    
    def add_child(self, child):
        """添加子节点"""
        self.children.append(child)
        child.parent = self
        return self  # 支持链式调用
    
    def __repr__(self):
        return f"{self.name}({self.title})"

def print_tree(node, level=0):
    """打印树（缩进表示层级）"""
    indent = "  " * level
    prefix = "├── " if level > 0 else ""
    print(f"{indent}{prefix}{node.name} - {node.title}")
    for child in node.children:
        print_tree(child, level + 1)

def tree_depth(node):
    """计算树的深度（递归！）"""
    if not node.children:
        return 1
    return 1 + max(tree_depth(child) for child in node.children)

# 构建一棵"公司组织架构树"
print("🌳 树——层级结构示例\n")

# 创建节点
ceo = TreeNode("张总", "CEO")
cto = TreeNode("李总", "CTO")
cfo = TreeNode("王总", "CFO")
pm = TreeNode("赵经理", "产品经理")
dev1 = TreeNode("陈工", "前端开发")
dev2 = TreeNode("刘工", "后端开发")
design = TreeNode("林设计", "UI设计")
accounting = TreeNode("周会计", "会计")

# 构建树
ceo.add_child(cto).add_child(cfo)
cto.add_child(pm).add_child(dev1).add_child(dev2)
pm.add_child(design)
cfo.add_child(accounting)

print("📋 公司组织架构：")
print_tree(ceo)
print(f"\n📊 树深度: {tree_depth(ceo)} 层")

# --- 树的遍历 ---
print("\n🔍 树的遍历方式：")

def preorder_traversal(node, level=0):
    """前序遍历：先访问父节点，再访问子节点"""
    print("  " * level + f"→ {node.name}")
    for child in node.children:
        preorder_traversal(child, level + 1)

def postorder_traversal(node, level=0):
    """后序遍历：先访问子节点，再访问父节点"""
    for child in node.children:
        postorder_traversal(child, level + 1)
    print("  " * level + f"→ {node.name}")

print("\n前序遍历（父→子）：")
preorder_traversal(ceo)

print("\n后序遍历（子→父）：")
postorder_traversal(ceo)

# --- 树的AI应用：决策树 ---
print("\n🤖 树的AI应用：简单决策树")

class DecisionNode:
    """决策树节点"""
    def __init__(self, question, yes_branch=None, no_branch=None, decision=None):
        self.question = question      # 问题
        self.yes_branch = yes_branch  # 是 → 这个分支
        self.no_branch = no_branch    # 否 → 这个分支
        self.decision = decision      # 如果是叶子节点，这就是决策结果
    
    def decide(self, data):
        """做出决策"""
        if self.decision is not None:
            return self.decision
        
        answer = data.get(self.question, False)
        if answer:
            return self.yes_branch.decide(data)
        else:
            return self.no_branch.decide(data)

# 构建一个简单的信用评估决策树
# 根节点
root = DecisionNode("收入 > 5000?")
# 第二层
root.yes_branch = DecisionNode("有信用卡?")
root.no_branch = DecisionNode("有抵押物?")
# 第三层（叶子节点）
root.yes_branch.yes_branch = DecisionNode(decision="✅ 通过")
root.yes_branch.no_branch = DecisionNode(decision="🟡 需人工审核")
root.no_branch.yes_branch = DecisionNode(decision="🟡 需人工审核")
root.no_branch.no_branch = DecisionNode(decision="❌ 拒绝")

# 测试
applicants = [
    {"收入 > 5000?": True, "有信用卡?": True},
    {"收入 > 5000?": True, "有信用卡?": False},
    {"收入 > 5000?": False, "有抵押物?": False},
]

for app in applicants:
    result = root.decide(app)
    print(f"  {app} → {result}")
```

---

### 🔬 核心概念 4.2：二叉树与二叉搜索树——"二分法"的数据结构

```python
# 🧪 二叉搜索树（BST）——排序 + 搜索的完美结合

class BSTNode:
    """二叉搜索树节点"""
    def __init__(self, value):
        self.value = value
        self.left = None   # 左子树（所有值小于当前节点）
        self.right = None  # 右子树（所有值大于当前节点）

class BinarySearchTree:
    """
    二叉搜索树（BST）：
    - 左子树的所有节点都小于根节点
    - 右子树的所有节点都大于根节点
    - 左右子树也是 BST
    
    这天然支持了"二分查找"——每次比较排除一半的树
    """
    def __init__(self):
        self.root = None
    
    def insert(self, value):
        """插入（递归）"""
        if not self.root:
            self.root = BSTNode(value)
            return
        
        def _insert(node, value):
            if value < node.value:
                if node.left:
                    _insert(node.left, value)
                else:
                    node.left = BSTNode(value)
            elif value > node.value:
                if node.right:
                    _insert(node.right, value)
                else:
                    node.right = BSTNode(value)
            # 等于时忽略（或者可以计数）
        
        _insert(self.root, value)
    
    def search(self, value):
        """搜索"""
        def _search(node, value, depth=0):
            if not node:
                return False, depth
            if node.value == value:
                return True, depth
            elif value < node.value:
                return _search(node.left, value, depth + 1)
            else:
                return _search(node.right, value, depth + 1)
        
        found, depth = _search(self.root, value)
        print(f"  搜索 {value}: {'✅ 找到' if found else '❌ 未找到'} (经过 {depth} 层)")
        return found
    
    def inorder(self):
        """中序遍历：左→根→右（升序输出！）"""
        result = []
        def _inorder(node):
            if node:
                _inorder(node.left)
                result.append(node.value)
                _inorder(node.right)
        _inorder(self.root)
        return result
    
    def display(self):
        """打印树结构"""
        def _display(node, level=0):
            if node:
                _display(node.right, level + 1)
                print("     " * level + f"──→ {node.value}")
                _display(node.left, level + 1)
        _display(self.root)

# 演示 BST
print("=== 二叉搜索树 ===")

bst = BinarySearchTree()
values = [50, 30, 70, 20, 40, 60, 80, 35, 45]
print(f"插入: {values}\n")
for v in values:
    bst.insert(v)

print("树形结构（右→左）：")
bst.display()

print(f"\n中序遍历（升序输出）: {bst.inorder()}")

print("\n搜索测试：")
bst.search(45)  # 存在
bst.search(100) # 不存在

# --- BST vs 数组的搜索性能对比 ---
print("\n📊 BST vs 数组搜索性能对比：")
import random
import time

# 创建 10000 个随机数
data = list(range(10000))
random.shuffle(data)

# 构建 BST
bst = BinarySearchTree()
for v in data:
    bst.insert(v)

# BST 搜索
start = time.time()
for _ in range(1000):
    target = random.randint(0, 10000)
    # 遍历查找
    node = bst.root
    while node:
        if node.value == target:
            break
        elif target < node.value:
            node = node.left
        else:
            node = node.right
bst_time = time.time() - start

# 列表搜索
arr = list(range(10000))
start = time.time()
for _ in range(1000):
    target = random.randint(0, 10000)
    for v in arr:
        if v == target:
            break
arr_time = time.time() - start

print(f"  列表搜索 1000 次: {arr_time:.4f}s (O(n))")
print(f"  BST搜索 1000 次: {bst_time:.4f}s (O(log n))")
print(f"  🏆 BST快了 {arr_time/bst_time:.0f} 倍")
```

---

### 🔬 核心概念 4.3：图——网状关系的表达

```python
# 🧪 图——网络关系

from collections import deque

class Graph:
    """
    图：由节点（顶点）和边组成的网状结构
    
    用邻接表表示：
    {
        "A": ["B", "C"],  # A 连接着 B 和 C
        "B": ["A", "D"],  # B 连接着 A 和 D
        ...
    }
    """
    def __init__(self):
        self.adjacency = {}  # 邻接表
    
    def add_vertex(self, vertex):
        """添加节点"""
        if vertex not in self.adjacency:
            self.adjacency[vertex] = []
    
    def add_edge(self, v1, v2, bidirectional=True):
        """添加边（默认双向）"""
        self.add_vertex(v1)
        self.add_vertex(v2)
        
        # 双向边
        if bidirectional:
            self.adjacency[v1].append(v2)
            self.adjacency[v2].append(v1)
        else:
            self.adjacency[v1].append(v2)
    
    def display(self):
        """打印图"""
        print("📊 图结构（邻接表）：")
        for vertex, neighbors in self.adjacency.items():
            print(f"  {vertex} → {neighbors}")
    
    def bfs(self, start, target=None):
        """
        广度优先搜索（BFS）：像水波一样一圈圈扩散
        
        用队列实现——先发现先处理
        应用：最短路径、社交网络"一度人脉"
        """
        visited = set()
        queue = deque([[start]])
        
        print(f"\n🔍 BFS 从 {start} 开始搜索{' ' + target if target else ''}：")
        
        while queue:
            path = queue.popleft()
            vertex = path[-1]
            
            if vertex not in visited:
                visited.add(vertex)
                print(f"  访问: {vertex} (路径: {'→'.join(path)})")
                
                if vertex == target:
                    print(f"  ✅ 找到目标 {target}! 最短路径: {'→'.join(path)}")
                    return path
                
                for neighbor in self.adjacency.get(vertex, []):
                    if neighbor not in visited:
                        new_path = list(path)
                        new_path.append(neighbor)
                        queue.append(new_path)
        
        print(f"  {'❌ 未找到目标' if target else '✅ 遍历完成'}")
        return None
    
    def dfs(self, start, target=None):
        """
        深度优先搜索（DFS）：一条路走到黑，不行再回头
        
        用栈实现——后进先出
        应用：迷宫探索、拓扑排序、连通性检测
        """
        visited = set()
        stack = [[start]]
        
        print(f"\n🔍 DFS 从 {start} 开始搜索{' ' + target if target else ''}：")
        
        while stack:
            path = stack.pop()
            vertex = path[-1]
            
            if vertex not in visited:
                visited.add(vertex)
                print(f"  访问: {vertex} (路径: {'→'.join(path)})")
                
                if vertex == target:
                    print(f"  ✅ 找到目标 {target}! 路径: {'→'.join(path)}")
                    return path
                
                for neighbor in self.adjacency.get(vertex, []):
                    if neighbor not in visited:
                        new_path = list(path)
                        new_path.append(neighbor)
                        stack.append(new_path)
        
        print(f"  {'❌ 未找到目标' if target else '✅ 遍历完成'}")
        return None

# 构建一个"犯罪网络"图
print("🕸️ 犯罪网络图——嫌疑人之间的关联\n")

crime_network = Graph()
# 添加节点和边
connections = [
    ("张三", "李四"),
    ("张三", "王五"),
    ("李四", "赵六"),
    ("王五", "赵六"),
    ("王五", "陈七"),
    ("赵六", "刘八"),
    ("陈七", "刘八"),
    ("陈七", "周九"),
]

for v1, v2 in connections:
    crime_network.add_edge(v1, v2)

crime_network.display()

# BFS：找到张三到刘八的最短路径
print("\n=== BFS 广度优先搜索 ===")
print("场景：找到张三到刘八的最短路径")
crime_network.bfs("张三", "刘八")

# DFS：深度优先搜索
print("\n=== DFS 深度优先搜索 ===")
print("场景：从张三出发，探查整个网络")
crime_network.dfs("张三")

# --- 图的AI应用：知识图谱 ---
print("\n🤖 图的AI应用：知识图谱")
# 知识图谱 = "实体"（节点）+ "关系"（边）
knowledge_graph = Graph()
knowledge_graph.add_edge("Transformer", "Attention机制", bidirectional=False)
knowledge_graph.add_edge("Transformer", "GPT", bidirectional=False)
knowledge_graph.add_edge("GPT", "ChatGPT", bidirectional=False)
knowledge_graph.add_edge("Transformer", "BERT", bidirectional=False)
knowledge_graph.add_edge("Attention机制", "Google", bidirectional=False)
knowledge_graph.add_edge("GPT", "OpenAI", bidirectional=False)
knowledge_graph.add_edge("ChatGPT", "OpenAI", bidirectional=False)

print("\n📚 AI知识图谱：")
knowledge_graph.display()

# 查询：GPT 和 Attention机制有关系吗？
print("\n🔍 查询知识图谱：从 Transformer 出发")
knowledge_graph.bfs("Transformer")
```

> ✋ **费曼自测**：树和图最大的区别是什么？什么时候应该用树，什么时候应该用图？

---

### 🧠 费曼三句话（番茄4）

> 1. **树表达层级关系，图表达网状关系**——树有明确的"父→子"结构（文件系统、组织架构），图没有层级限制（社交网络、知识图谱）。
> 2. **二叉搜索树是"排序+搜索"的优雅结合**——左小右大的结构天然支持二分查找 O(log n)，中序遍历直接得到升序结果。
> 3. **BFS（广度优先）和 DFS（深度优先）是图遍历的两种基本策略**——BFS 像水波扩散（找最短路径），DFS 像探险一条路走到黑（找连通性）。它们分别是"队列思维"和"栈思维"的体现。

### ❓ 悬疑追问

> 我们学完了数组、链表、栈、队列、哈希表、树、图——这些都是"经典数据结构"。但 AI 世界还有一种"新型数据结构"：**张量（Tensor）**。它本质上是一个 N 维数组，是神经网络处理数据的"原生格式"。这个我们会在 Day10（神经网络）中深入。
>
> 不过先停一下——让我们把 Part 1 的所有知识拼成一张完整的图。

---

## 🍅 番茄5：思维导图 + 费曼大总结（Part 1 收官）

### 🎬 悬疑开场：Part 1 的"侦探武器清单"

恭喜你！你已经完成了"120 番茄 AI 从入门到精通"的 Part 1——**编程基础与计算思维**。

4 天，20 个番茄，你学了什么？

让我们回到第一天的问题：**一个开关怎么变成了能写诗的 GPT？**

现在你有完整的答案了：

```
开关（晶体管）→ 逻辑门 → CPU → 机器码 → Python → 
函数/类/模块 → 算法（搜索/排序/递归）→ 数据结构（数组/哈希表/树/图）
```

这就是从"通和断"到"智能"的完整链条。你走过的每一步，都是 AI 历史上的一个大步。

---

### 🧠 番茄1-4 思维导图

```
┌──────────────────────────────────────────────────────────────┐
│          📦  数据结构——信息的组织形式与操作（Part 1收官）      │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  🍅1 数组 vs 链表                                           │
│  ├─ 数组: 连续内存, O(1)随机访问, O(n)插入/删除             │
│  ├─ 链表: 非连续, O(n)随机访问, O(1)插入/删除               │
│  ├─ Python list = 动态数组（大多数场景足够）                 │
│  └─ 选择: 频繁访问→数组, 频繁插入/删除→链表                 │
│                                                              │
│  🍅2 栈 vs 队列                                             │
│  ├─ 栈: 后进先出 (LIFO) → 函数调用/撤销/DFS                │
│  ├─ 队列: 先进先出 (FIFO) → 任务调度/消息/BFS              │
│  ├─ Python: 列表可实现栈, deque 可实现队列                   │
│  └─ 哲学: "限制"反而让行为可预测                             │
│                                                              │
│  🍅3 哈希表                                                  │
│  ├─ 原理: 哈希函数把"键"映射到"位置"                        │
│  ├─ 性能: 平均 O(1) 查找/插入/删除                          │
│  ├─ 冲突处理: 链地址法 / 开放地址法                          │
│  ├─ Python: dict 和 set 底层都是哈希表                       │
│  └─ 代价: 需要额外内存（空间换时间）                         │
│                                                              │
│  🍅4 树与图                                                  │
│  ├─ 树: 层级关系, 每个节点有父节点+子节点                   │
│  │  ├─ 二叉树: 每个节点最多2个子节点                         │
│  │  ├─ 二叉搜索树: 左小右大, O(log n)搜索                   │
│  │  └─ AI应用: 决策树, 神经网络的层级结构                    │
│  ├─ 图: 网状关系, 节点之间任意连接                          │
│  │  ├─ BFS: 队列+广度优先, 找最短路径                       │
│  │  ├─ DFS: 栈+深度优先, 找连通性                           │
│  │  └─ AI应用: 知识图谱, 社交网络分析                       │
│  └─ 核心: 关系比数据本身更重要                               │
│                                                              │
│  📐 Day01-04 总结——从开关到智能 (Part 1)                    │
│  ├─ Day01: 二进制→逻辑门→CPU→编程思维                       │
│  ├─ Day02: Python→NumPy→Pandas→可视化                       │
│  ├─ Day03: 复杂度→搜索→排序→递归                            │
│  └─ Day04: 数组/链表→栈/队列→哈希表→树/图                  │
│     └─ 所有知识构成一个"层"：底层和上层协同工作              │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

### 🔬 核心概念 5.1：数据结构的"选择"——这是程序员最重要的能力

```python
# 🧪 综合案例：数据结构选择器——根据场景选择合适的数据结构

"""
🕵️ 侦探数据结构选择器
    
场景：你是一个侦探系统架构师，需要为不同的功能选择合适的数据结构
"""
print("="*60)
print("🕵️ 侦探数据结构选择器 v1.0")
print("="*60)

scenarios = [
    {
        "name": "嫌疑人快速检索（按姓名查找详细信息）",
        "desc": "有 100 万条记录，需要根据姓名立即找到对应信息",
        "data_structure": "哈希表 (dict)",
        "reason": "O(1) 平均查找时间，键值对天然匹配"姓名→详情"",
        "complexity": "O(1) 平均",
    },
    {
        "name": "办案任务调度（按提交顺序处理）",
        "desc": "新任务不断到来，严格按照先来后到的顺序处理",
        "data_structure": "队列 (Queue / deque)",
        "reason": "FIFO 特性完美匹配"先来先服务"的需求",
        "complexity": "O(1) 入队和出队",
    },
    {
        "name": "证据链回溯（撤销上一步操作）",
        "desc": "在案件管理中，用户可能需要撤销上一步添加的证据",
        "data_structure": "栈 (Stack / list)",
        "reason": "LIFO 特性完美匹配"撤销最近操作"",
        "complexity": "O(1) 压栈和出栈",
    },
    {
        "name": "犯罪网络分析（人物之间的关系）",
        "desc": "需要分析嫌疑人之间的社交网络，找到关键节点",
        "data_structure": "图 (Graph)",
        "reason": "图天然表达"节点+边"的网状关系",
        "complexity": "O(V+E) 遍历",
    },
    {
        "name": "案件分类决策（按条件逐层判断）",
        "desc": "根据案件特征自动判断案件类型和处理优先级",
        "data_structure": "树 (Tree / Decision Tree)",
        "reason": "树的层级结构匹配"条件→子条件→结论"的决策过程",
        "complexity": "O(log n) ~ O(n)",
    },
    {
        "name": "现场线索记录（经常需要按顺序查看所有线索）",
        "desc": "需要在末尾追加新线索，也经常按位置查看任意线索",
        "data_structure": "动态数组 (list)",
        "reason": "O(1) 随机访问 + O(1) 均摊追加，兼顾两者",
        "complexity": "O(1) 访问, O(1) 均摊追加",
    },
]

print(f"\n{'场景名称':<30} {'推荐结构':<20} {'复杂度':<15}")
print("-" * 65)
for s in scenarios:
    print(f"{s['name']:<30} {s['data_structure']:<20} {s['complexity']:<15}")
    print(f"  {'理由:':<4} {s['reason']}")
    print()

# --- 综合应用：构建一个简易的案件管理系统 ---
print("\n" + "="*60)
print("🛠️  综合应用：构建微型案件管理系统")
print("="*60)

class CaseManagementSystem:
    """综合使用多种数据结构的案件管理系统"""
    
    def __init__(self):
        self.cases = {}               # 哈希表: case_id → case_info
        self.evidence_stack = {}      # 栈: case_id → [证据列表]（便于撤销）
        self.task_queue = []          # 队列: 待处理任务列表
        self.assoc_graph = {}         # 图: 人物关联网络
    
    def add_case(self, case_id, title):
        """添加案件（哈希表）"""
        self.cases[case_id] = {
            "id": case_id,
            "title": title,
            "status": "调查中",
            "created": "2026-06-15",
        }
        self.evidence_stack[case_id] = []
        print(f"📂 案件 {case_id}: {title} — 已创建")
    
    def add_evidence(self, case_id, evidence):
        """添加证据（栈—便于撤销）"""
        if case_id in self.evidence_stack:
            self.evidence_stack[case_id].append(evidence)
            print(f"📌 案件 {case_id} 添加证据: {evidence}")
    
    def undo_last_evidence(self, case_id):
        """撤销最后一条证据（栈的LIFO）"""
        if case_id in self.evidence_stack and self.evidence_stack[case_id]:
            removed = self.evidence_stack[case_id].pop()
            print(f"↩️ 撤销证据: {removed}")
            return removed
        print(f"⚠️ 没有可撤销的证据")
        return None
    
    def add_task(self, task):
        """添加任务（队列—FIFO）"""
        self.task_queue.append(task)
        print(f"📋 添加任务: {task}")
    
    def process_next_task(self):
        """处理下一个任务（队列的出队操作）"""
        if self.task_queue:
            task = self.task_queue.pop(0)
            print(f"⚙️  处理任务: {task}")
            return task
        print(f"✅ 没有待处理任务")
        return None
    
    def add_relation(self, person1, person2):
        """添加人物关联（图）"""
        if person1 not in self.assoc_graph:
            self.assoc_graph[person1] = []
        if person2 not in self.assoc_graph:
            self.assoc_graph[person2] = []
        self.assoc_graph[person1].append(person2)
        self.assoc_graph[person2].append(person1)
        print(f"🔗 建立关联: {person1} ↔ {person2}")
    
    def find_connections(self, person, max_depth=3):
        """查找关联网络（BFS）"""
        visited = {person}
        queue = [(person, 0, [person])]
        
        print(f"\n🔍 查找 {person} 的社交网络：")
        while queue:
            current, depth, path = queue.pop(0)
            if depth < max_depth:
                for neighbor in self.assoc_graph.get(current, []):
                    if neighbor not in visited:
                        visited.add(neighbor)
                        new_path = path + [neighbor]
                        print(f"  {'→'.join(new_path)} (深度:{depth+1})")
                        queue.append((neighbor, depth + 1, new_path))
        
        return visited
    
    def get_case_summary(self, case_id):
        """案件摘要"""
        case = self.cases.get(case_id)
        if not case:
            return "案件不存在"
        
        evidence_list = self.evidence_stack.get(case_id, [])
        return f"""
📋 案件摘要: {case['title']}
  状态: {case['status']}
  证据数: {len(evidence_list)}
  待办任务: {len(self.task_queue)}
"""

# 运行综合系统
print("\n🚀 启动案件管理系统...\n")
cms = CaseManagementSystem()

# 添加案件
cms.add_case("C001", "博物馆失窃案")
cms.add_case("C002", "数据泄露案")

# 添加证据（栈操作）
cms.add_evidence("C001", "展柜指纹")
cms.add_evidence("C001", "监控录像")
cms.add_evidence("C001", "DNA样本")
cms.undo_last_evidence("C001")  # 撤销——栈的特性

# 添加任务（队列操作）
cms.add_task("分析C001的监控录像")
cms.add_task("传唤C002的嫌疑人")
cms.add_task("归档已完成案件")
cms.process_next_task()
cms.process_next_task()

# 建立人物关联（图）
cms.add_relation("张三", "李四")
cms.add_relation("张三", "王五")
cms.add_relation("李四", "赵六")
cms.add_relation("王五", "赵六")

# 查询关联网络（BFS）
cms.find_connections("张三", max_depth=2)

# 生成摘要
print(cms.get_case_summary("C001"))
```

---

### 🧠 费曼大总结（Part 1 最终回顾）

> **20 个番茄之后，用你自己的话回答这个问题：计算机到底是什么？**

```
计算机是一个：
├─ 用二进制（0和1）做最基础判断的机器
├─ 运行在CPU的"取指-解码-执行"循环上
├─ 通过编程语言（如Python）与人类沟通
├─ 用顺序/分支/循环三种结构执行任何逻辑
├─ 用函数和类来管理复杂性
├─ 用算法（搜索/排序/递归）解决问题
└─ 用数据结构（数组/哈希表/树/图）组织信息
```

**简单说：计算机 = 数据 + 算法 = 程序。程序 = 智能的基础。**

---

### 📊 Part 1：知识图谱总览

```
                    🧠 智能（AI / GPT）
                         ↑
              ┌──────────┴──────────┐
              │    算法 × 数据结构   │  ← Day03 + Day04
              │   (怎么解决问题)     │
              └──────────┬──────────┘
                         ↑
              ┌──────────┴──────────┐
              │   Python 编程语言    │  ← Day02
              │   (怎么表达问题)     │
              └──────────┬──────────┘
                         ↑
              ┌──────────┴──────────┐
              │  编程思维 + 抽象     │  ← Day01
              │   (怎么思考问题)     │
              └──────────┬──────────┘
                         ↑
              ┌──────────┴──────────┐
              │   二进制 / CPU / OS  │
              │   (物理基础)         │
              └─────────────────────┘
```

每一层都为上一层提供了"抽象"，让你在不理解底层细节的情况下构建复杂的系统。

---

### 🎯 刻意练习（独立探案）

> **基础题（模仿阶段）：**
>
> 1. 说说数组和链表在插入操作上的区别，以及各自适合什么场景
> 2. 用 Python 的 `list` 实现一个栈，包含 `push`、`pop`、`peek` 方法
> 3. 简述哈希表的工作原理——为什么它平均 O(1) 查找？
>
> **进阶层（变式阶段）：**
>
> 4. 写一个函数 `is_valid_bst(root)` 判断一棵树是不是二叉搜索树
> 5. 用邻接表实现一个图，包含 BFS 和 DFS 方法
> 6. 对比 Python 的 `list`、`dict`、`set` 三种数据结构在查找性能上的差异（用代码验证）
>
> **挑战题（创造阶段）：**
>
> 7. **Part 1收官项目**：综合 Day01-04 全部知识，设计一个"简易搜索引擎"：
>    - 用哈希表构建倒排索引（词 → 文档列表）
>    - 用树/图组织文档分类
>    - 用搜索算法（BFS/DFS）查找相关内容
>    - 用排序算法对搜索结果排名
>    - 用面向对象设计系统架构

---

### 📌 连线思考

> Part 1 结束了，但它不是终点——它是起点。
>
> 你学到的所有知识——二进制、编程思维、Python、算法、数据结构——并不是"计算机科学理论"，而是**AI 的底层基础设施**。
>
> - 神经网络的矩阵运算 → NumPy（Day02）
> - 决策树的分裂逻辑 → 二分搜索思维（Day03）
> - 知识图谱 → 图数据结构（Day04）
> - Transformer 的注意力机制 → "加权搜索"的概念（Day03）
>
> **从 Part 2 开始，我们将正式进入 AI 的世界。**

### ❓ Part 1 收官悬疑

> 你现在能回答第一天的问题了：**一个开关如何演变成能写诗的 GPT？**
>
> 答案是：通过 7 层抽象——
> 1. 开关（晶体管）→ 逻辑门（AND/OR/NOT）
> 2. 逻辑门 → CPU（取指-解码-执行）
> 3. CPU → 编程语言（Python）
> 4. 代码 → 函数/类/模块（抽象与封装）
> 5. 模块 → 算法（搜索/排序/递归）
> 6. 算法 → 数据结构（数组/哈希表/树/图）
> 7. 数据结构 → AI 模型（神经网络/知识图谱）
>
> **但你肯定还有一个更深的疑问：计算机是确定性的——同样的输入永远得到同样的输出。但 AI 不是——它"猜"，它"可能对"，它"有概率"……**
>
> **确定性的机器是怎么学会"不确定性"的？**
>
> 这个问题的答案，将在 Part 2 揭晓——**从数据中寻找真相**。

> **下一站预告**：Day05——机器学习开山。我们将看到计算机如何从"严格遵循规则"进化为"从数据中自己发现规则"。这是整个 AI 领域的"第一推动力"。
>
> **休息一下，给你的大脑留点时间消化。别忘了——潜意识也在学习。**

> **Part 1 统计：4 天 × 5 番茄 = 20 番茄 ✅**
