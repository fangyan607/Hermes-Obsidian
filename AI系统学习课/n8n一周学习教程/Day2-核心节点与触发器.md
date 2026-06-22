# Day 2：核心节点与触发器

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 8 大核心节点和 5 种触发器，能看懂任何工作流
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：节点分类体系 + 5种触发器详解
🍅 番茄3-4：逻辑节点三剑客（IF/Switch/Merge）+ Edit Fields
🍅 番茄5-6：Code 节点深入 + 自由实践
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：节点分类体系（25分钟）

### 1.1 用大白话理解节点分类

n8n 有 400+ 节点，但它们只做四件事：

- **触发器** = 门铃——事情从哪里开始？
- **动作** = 手——做什么事情？
- **逻辑** = 大脑——怎么流转？
- **工具** = 工具箱——数据怎么处理？

### 1.2 节点分类树

```
n8n 节点
├── 🔵 触发器节点（Trigger）—— 事情从哪里开始？
│   ├── Manual Trigger      手动触发（点一下执行一次）
│   ├── Schedule Trigger    定时触发（每天9点、每小时）
│   ├── Webhook             请求触发（收到HTTP请求）
│   ├── Chat Trigger        聊天触发（对话式交互）
│   └── App Trigger         应用触发（新邮件、新Issue等）
│
├── 🟢 动作节点（Action）—— 做什么事情？
│   ├── HTTP Request        发送HTTP请求（万能API调用器）
│   ├── Send Email          发送邮件
│   ├── Slack               发消息
│   ├── Google Sheets       读写表格
│   └── 400+ 应用节点...
│
├── 🟡 逻辑节点（Logic）—— 怎么流转？
│   ├── IF                  二选一判断
│   ├── Switch              多选一分支
│   ├── Merge               合并数据流
│   ├── Split Out           拆分数组
│   ├── Split In Batches    分批处理
│   └── Loop Over Items     循环处理
│
└── 🔴 工具节点（Utility）—— 数据处理
    ├── Code                编写 JS/Python 代码
    ├── Edit Fields (Set)   设置/修改/删除字段
    ├── Date & Time         日期处理
    ├── Crypto              加密/哈希
    ├── HTML Extract        提取网页内容
    └── Markdown            Markdown 转换
```

### 1.3 本周重点的 8 个节点

| # | 节点 | 类别 | 用途 | 学习日 |
|---|------|------|------|--------|
| 1 | Manual Trigger | 触发器 | 手动执行 | Day 1 |
| 2 | Schedule Trigger | 触发器 | 定时执行 | Day 2 |
| 3 | Webhook | 触发器 | HTTP触发 | Day 5 |
| 4 | HTTP Request | 动作 | 调用API | Day 3 |
| 5 | IF | 逻辑 | 条件判断 | Day 2 |
| 6 | Switch | 逻辑 | 多路分支 | Day 2 |
| 7 | Edit Fields (Set) | 工具 | 数据处理 | Day 2 |
| 8 | Code | 工具 | 自定义代码 | Day 2 |

> ✋ **费曼自测**：不看上面的分类树，你能说出四种节点类别各自的「角色」吗？（触发器=门铃、动作=手...）

---

## 番茄钟2：5种触发器详解（25分钟）

### 2.1 Manual Trigger —— 手动触发

最简单，点一下执行一次。适合：
- 调试工作流
- 一次性任务
- 手动确认后再执行

**无需任何配置。**

### 2.2 Schedule Trigger —— 定时触发

**配置界面**：

```
触发规则选择：
├── Every Minute        每分钟
├── Every Hour          每小时
├── Every Day           每天（指定时间）
├── Every Week          每周（指定星期和时间）
├── Every Month         每月（指定日期和时间）
└── Custom (Cron)       自定义 Cron 表达式
```

**Cron 表达式速查**：

```
格式: 分 时 日 月 星期

示例：
0 9 * * *        → 每天9:00
0 9 * * 1-5      → 工作日9:00
*/30 * * * *     → 每30分钟
0 9 1 * *        → 每月1号9:00
0 9,18 * * *     → 每天9:00和18:00
```

**实操**：创建一个「每分钟报时」工作流

```
Schedule Trigger (Every Minute)
    ↓
Set (currentTime: {{ $now.toFormat('HH:mm:ss') }})
```

### 2.3 Webhook Trigger —— 请求触发（Day 5 详解）

快速预览：

```
HTTP Method: POST
Path: my-webhook
完整URL: http://localhost:5678/webhook/my-webhook
```

测试：
```bash
curl -X POST http://localhost:5678/webhook/my-webhook \
  -H "Content-Type: application/json" \
  -d '{"message": "hello"}'
```

### 2.4 Chat Trigger —— 聊天触发

n8n 内置的聊天界面，适合构建 AI 对话应用。在 Day 6 AI Agent 中会用到。

### 2.5 App Trigger —— 应用事件触发

需要在 n8n 中配置对应应用的凭证（OAuth 或 API Key）：

| 应用 | 触发事件 | 需要的凭证 |
|------|----------|-----------|
| Gmail | 新邮件 | Google OAuth |
| Slack | 新消息 | Slack Bot Token |
| GitHub | 新 Issue/PR | GitHub Token |
| Notion | 页面更新 | Notion Integration |
| Telegram | 新消息 | Telegram Bot Token |

> ⚠️ App Trigger 需要配置凭证，Day 3 会学习凭证系统。

> ✋ **费曼自测**：5 种触发器分别在什么场景使用？各举一个实际例子。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] 节点分为四类：触发器、动作、逻辑、工具
- [ ] Schedule Trigger 使用 Cron 表达式定义时间规则
- [ ] Webhook 通过 HTTP 请求触发，适合外部系统调用
- [ ] App Trigger 需要配置应用凭证

---

## 番茄钟3：逻辑节点三剑客（25分钟）

### 3.1 IF 节点 —— 二选一

**用大白话理解**：IF 就像十字路口——条件满足走左边的路，不满足走右边的路。

**配置**：

```
条件类型: String / Number / Boolean
操作符: equals / not equals / contains / greater than / less than / ...

示例：
Value 1: {{ $json.score }}
Operation: greater than
Value 2: 60

├── True 输出  → score >= 60 的 Item
└── False 输出 → score < 60 的 Item
```

**实操**：创建一个「成绩判断」工作流

```
Code (生成5个学生成绩)
    ↓
IF (score >= 60)
    ├── True → Set (消息: "✅ 及格")
    └── False → Set (消息: "❌ 需要补考")
```

**Code 节点**：
```javascript
return [
  { json: { name: "张三", score: 85 } },
  { json: { name: "李四", score: 62 } },
  { json: { name: "王五", score: 45 } },
  { json: { name: "赵六", score: 91 } },
  { json: { name: "钱七", score: 58 } }
];
```

### 3.2 Switch 节点 —— 多选一

**用大白话理解**：Switch 就像高速公路的枢纽——根据不同条件走不同的出口。

**配置**：

```
Routing Rules:
Rule 1: {{ $json.department }} equals "技术部" → 输出 0
Rule 2: {{ $json.department }} equals "市场部" → 输出 1
Rule 3: {{ $json.department }} equals "人事部" → 输出 2
Fallback: 不匹配任何规则 → 输出 3
```

**实操**：创建一个「部门路由」工作流

```
Code (生成员工数据)
    ↓
Switch (按部门路由)
    ├── 技术部 → Set (分配技术经理)
    ├── 市场部 → Set (分配市场经理)
    ├── 人事部 → Set (分配人事经理)
    └── 其他 → Set (分配总经理)
```

**Code 节点**：
```javascript
return [
  { json: { name: "张三", department: "技术部" } },
  { json: { name: "李四", department: "市场部" } },
  { json: { name: "王五", department: "人事部" } },
  { json: { name: "赵六", department: "财务部" } }
];
```

### 3.3 Merge 节点 —— 合并数据流

**用大白话理解**：Merge 就像河流的交汇——两条溪流汇聚成一条河。

**三种合并模式**：

| 模式 | 效果 | 示例 |
|------|------|------|
| **Append** | 简单拼接 | [A,B] + [C,D] = [A,B,C,D] |
| **Combine** | 按位置配对 | [A,B] + [1,2] = [{A,1},{B,2}] |
| **Choose** | 只保留一个输入 | 只要输入A，丢弃B |

**实操**：创建一个「数据合并」工作流

```
Manual Trigger
    ↓
    ├── Code (数据A: 姓名列表)
    │       ↓
    └── Code (数据B: 分数列表)
            ↓
        Merge (Combine 模式)
            ↓
        Set (合并结果)
```

数据A Code 节点：
```javascript
return [
  { json: { name: "张三" } },
  { json: { name: "李四" } }
];
```

数据B Code 节点：
```javascript
return [
  { json: { score: 85 } },
  { json: { score: 62 } }
];
```

> ✋ **费曼自测**：IF 和 Switch 的区别是什么？什么时候用 IF，什么时候用 Switch？Merge 的 Combine 模式和 Append 模式有什么区别？

---

## 番茄钟4：Edit Fields (Set) 节点深入（25分钟）

### 4.1 用大白话理解 Set

Set 就像「快递打包台」——从包裹里取出需要的东西、扔掉不要的、贴上新标签。

### 4.2 四种操作模式

| 操作 | 含义 | 类比 |
|------|------|------|
| **Add Value** | 添加新字段 | 贴新标签 |
| **Update Value** | 修改已有字段 | 改标签内容 |
| **Remove Value** | 删除字段 | 撕掉标签 |
| **Rename Key** | 重命名字段 | 换标签名 |

### 4.3 实操：数据清洗

**场景**：从 API 获取了用户数据，需要清洗和转换

```
Code (模拟API返回数据)
    ↓
Edit Fields
    ├── Remove: password (删除敏感字段)
    ├── Remove: internal_id (删除内部字段)
    ├── Rename: name → username (重命名)
    └── Add: processedAt: {{ $now }} (添加处理时间)
```

**输入数据**：
```json
{
  "internal_id": 12345,
  "name": "张三",
  "email": "zhang@test.com",
  "password": "123456",
  "age": 25
}
```

**输出数据**：
```json
{
  "username": "张三",
  "email": "zhang@test.com",
  "age": 25,
  "processedAt": "2026-06-08T10:30:00.000Z"
}
```

### 4.4 表达式在 Set 中的使用

```
Add Value:
  Name: displayName
  Value: ={{ $json.username }} (年龄: {{ $json.age }})

Add Value:
  Name: emailDomain
  Value: ={{ $json.email.split('@')[1] }}

Add Value:
  Name: isAdult
  Value: ={{ $json.age >= 18 }}
```

> ✋ **费曼自测**：Set 节点的四种操作模式分别是什么？如何删除一个字段？如何给字段重命名？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 掌握 IF 节点的条件判断
- [ ] 掌握 Switch 节点的多路分支
- [ ] 掌握 Merge 节点的三种合并模式
- [ ] 掌握 Set 节点的四种操作模式
- [ ] 能在 Set 中使用表达式

---

## 番茄钟5：Code 节点深入（25分钟）

### 5.1 用大白话理解 Code 节点

Code 节点 = 「万能加工厂」——其他节点做不到的事，Code 都能做。你写 JavaScript（或 Python），什么逻辑都能实现。

### 5.2 两种运行模式

| 模式 | 执行次数 | 适用场景 |
|------|---------|---------|
| **Run Once for All Items** | 对整个数据集执行一次 | 聚合统计、批量转换 |
| **Run Once for Each Item** | 对每个 Item 各执行一次 | 逐条处理、调用外部函数 |

### 5.3 输入输出

```javascript
// 获取所有 Item
const allItems = $input.all();

// 获取第一个 Item
const firstItem = $input.first();

// 获取当前 Item（Each Item 模式）
const currentItem = $input.item;

// 返回结果
return [{ json: { result: "value" } }];
```

### 5.4 常用代码模式

**模式1：数据转换**
```javascript
const items = $input.all();
return items.map(item => ({
  json: {
    ...item.json,
    fullName: `${item.json.firstName} ${item.json.lastName}`,
    upperName: item.json.firstName.toUpperCase()
  }
}));
```

**模式2：过滤数据**
```javascript
const items = $input.all();
return items.filter(item => item.json.age >= 18);
```

**模式3：聚合统计**
```javascript
const items = $input.all();
const totalScore = items.reduce((sum, item) => sum + item.json.score, 0);
const avgScore = totalScore / items.length;

return [{
  json: {
    totalStudents: items.length,
    totalScore,
    avgScore: Math.round(avgScore * 100) / 100,
    maxScore: Math.max(...items.map(i => i.json.score)),
    minScore: Math.min(...items.map(i => i.json.score))
  }
}];
```

**模式4：调用外部 API**
```javascript
// 使用 n8n 内置的 axios
const response = await this.helpers.httpRequest({
  method: 'GET',
  url: 'https://api.example.com/data',
  headers: { 'Authorization': 'Bearer YOUR_KEY' }
});

return [{ json: response }];
```

> ⚠️ Code 节点中不能使用 `require()` 导入外部包，但可以使用 n8n 内置的 `this.helpers` 方法。

> ✋ **费曼自测**：Code 节点的两种运行模式有什么区别？`$input.all()` 和 `$input.item` 分别在什么模式中使用？

---

## 番茄钟6：自由实践（25分钟）

### 6.1 综合练习：学生成绩分析系统

创建一个工作流，完成以下功能：

```
Schedule Trigger (每天9点)
    ↓
Code (生成学生数据)
    ↓
IF (是否及格？)
    ├── True → Switch (按等级分类)
    │           ├── 优秀(>=90) → Set (标记优秀)
    │           ├── 良好(>=80) → Set (标记良好)
    │           └── 及格(>=60) → Set (标记及格)
    └── False → Set (标记不及格)
```

**Code 节点（生成学生数据）**：
```javascript
const students = [
  { name: "张三", score: 95 },
  { name: "李四", score: 82 },
  { name: "王五", score: 67 },
  { name: "赵六", score: 45 },
  { name: "钱七", score: 78 },
  { name: "孙八", score: 91 },
  { name: "周九", score: 53 },
  { name: "吴十", score: 88 }
];
return students.map(s => ({ json: s }));
```

### 6.2 挑战练习：数据管道

创建一个包含 Merge + Code 的数据管道：

```
Manual Trigger
    ↓
    ├── Code (获取用户基本信息)
    └── Code (获取用户订单信息)
            ↓
        Merge (Combine)
            ↓
        Code (计算用户总消费)
            ↓
        IF (VIP客户？总消费>1000)
            ├── True → Set (VIP标记)
            └── False → Set (普通客户)
```

> ✋ **费曼自测**：你能否不查资料，独立完成一个包含 IF + Switch + Merge 的工作流？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 掌握 Code 节点的两种运行模式
- [ ] 能在 Code 节点中使用 `$input.all()` 和 `$input.item`
- [ ] 能实现数据转换、过滤、聚合
- [ ] 能组合使用 IF + Switch + Merge + Code

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

| 节点 | 一句话 | 类比 |
|------|--------|------|
| Manual Trigger | 点一下执行一次 | 手动开关 |
| Schedule Trigger | 按时间规则自动执行 | 闹钟 |
| Webhook | 收到HTTP请求时执行 | 门铃 |
| IF | 满足条件走A，不满足走B | 十字路口 |
| Switch | 按条件走不同出口 | 高速枢纽 |
| Merge | 合并两条数据流 | 河流交汇 |
| Edit Fields | 添加/修改/删除/重命名字段 | 快递打包台 |
| Code | 自定义 JS/Python 代码 | 万能加工厂 |

### 7.2 触发器选择决策树

```
需要自动执行吗？
├── 不需要 → Manual Trigger
└── 需要
    ├── 按时间？ → Schedule Trigger
    ├── 收到请求？ → Webhook
    ├── 对话交互？ → Chat Trigger
    └── 应用事件？ → App Trigger
```

### 7.3 命令速查卡

```javascript
// Code 节点常用代码
$input.all()              // 获取所有 Item
$input.first()            // 获取第一个 Item
$input.item               // 获取当前 Item（Each模式）
$now                      // 当前时间
Math.max(...arr)          // 数组最大值
arr.filter(x => x > 0)   // 过滤
arr.map(x => x * 2)      // 映射
arr.reduce((s,x) => s+x, 0)  // 累加
```

> ✋ **费曼自测**：遮住上面的表格，你能回忆出每个节点的类比吗？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——节点配置与触发调试循环

**练习目标**：在20分钟内完成3轮节点实操循环，每轮聚焦不同类型的节点能力

**任务序列（重复×3）：**

```
===== 循环 1：配置3种不同触发器 =====
1. 创建新工作流，添加 Manual Trigger（手动触发）
2. 再创建一个工作流，添加 Schedule Trigger（定时触发，每5分钟）
3. 修改 Cron 表达式为每30分钟触发一次
4. 观察两个触发器的输出结构差异
验证：Manual Trigger 点一下即执行，Schedule Trigger 按时间规则显示触发时间

===== 循环 2：用同一数据测试3种不同处理节点 =====
1. 创建 Code 节点生成5个学生成绩 item
2. 分别添加 IF、Switch、Merge 节点各处理一次这份数据
3. IF 做及格/不及格判断
4. Switch 做优秀/良好/及格/不及格路由
5. Merge 合并两个数据集
验证：三种逻辑节点都能正确分流和处理数据

===== 循环 3：构建一个多节点串联工作流 =====
1. 从零创建新工作流
2. 结构：Code → IF → Switch → Merge → Set
3. Code 生成混合数据，IF 筛选有效数据
4. Switch 按类别分流，Merge 重新合并
5. Set 最终格式化输出
验证：数据经过所有节点后输出完整且正确
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 触发器配置与测试 | ⬜ | ⬜ | ⬜ |
| 逻辑节点(IF/Switch/Merge)运用 | ⬜ | ⬜ | ⬜ |
| 多节点串联工作流构建 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：三轮循环中，哪种节点花的时间最多？IF 和 Switch 的使用场景你能用一句话说清区别吗？

### 8.1 今日自检清单

- [ ] ✅ 能说出节点四种分类及其角色
- [ ] ✅ 能配置 Schedule Trigger（包括 Cron 表达式）
- [ ] ✅ 能使用 IF 做条件判断
- [ ] ✅ 能使用 Switch 做多路分支
- [ ] ✅ 能使用 Merge 合并数据流
- [ ] ✅ 能使用 Edit Fields 添加/修改/删除字段
- [ ] ✅ 能使用 Code 节点处理数据
- [ ] ✅ 能组合多个节点构建完整工作流

### 8.2 费曼一句话总结

> **n8n 的 400+ 节点归为四类：触发器决定何时启动，动作决定做什么，逻辑决定怎么流转，工具决定怎么处理数据。8 大核心节点覆盖了 80% 的使用场景。**

### 8.3 学习笔记

```markdown
## Day 2 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 明天想深入的方向
（为 Day 3 做准备）
```

---

## 🎉 Day 2 完成！

**今日成果：**
- ✅ 掌握了节点四分类体系
- ✅ 学会了 5 种触发器的使用
- ✅ 实操了 IF/Switch/Merge/Edit Fields/Code
- ✅ 完成了学生成绩分析系统

**明天预告：** [[Day3-凭证管理与API集成]] - 学会配置凭证，用 HTTP Request 调用任何 API

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day1-安装部署与界面初探]] - 上一天
> - [[Day3-凭证管理与API集成]] - 下一天
