# Day 4：数据处理与工作流模式

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握数据转换四件套、三种循环模式、四种错误处理策略
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：数据模型深入 + 数据转换四件套（Split Out / Aggregate / Sort / Remove Duplicates）
🍅 番茄3-4：三种循环模式 + 四种错误处理策略
🍅 番茄5-6：实战——批量用户数据处理工作流 + 自由实践
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：数据模型深入（25分钟）

### 1.1 用大白话理解 n8n 数据模型

如果说 Day 1 你学到了「Item 是传送带上的包裹」，今天我们要打开包裹，看看里面的结构：

```
📦 一个 Item 的完整结构:
{
  "json": {                    ← 📋 标签信息（结构化文字数据）
    "name": "张三",
    "age": 25,
    "tags": ["前端", "Vue"]
  },
  "binary": {                  ← 🖼️ 实物（文件、图片等）
    "avatar": {
      "data": "...",           ← 文件的二进制内容
      "mimeType": "image/png",
      "fileName": "avatar.png"
    }
  }
}
```

**类比**：Item 就像一个快递包裹——
- `json` 是贴在箱子上的标签（容易读取、筛选、修改）
- `binary` 是箱子里的实物（图片、PDF、音频等）
- 大多数节点只处理标签（json），少数节点（如 Read/Write File）处理实物（binary）

### 1.2 数据在节点间的流转规则

| 规则 | 说明 | 举例 |
|------|------|------|
| **1 进 N 出** | 一个 Item 进入节点，可能输出多个 Item | Split Out 拆分数组 → 1 变多 |
| **N 进 1 出** | 多个 Item 进入节点，可能合并为一个 | Aggregate 聚合 → 多变 1 |
| **N 进 N 出** | 最常见：每个 Item 独立处理 | Set 给每个 Item 加字段 |
| **Item 独立处理** | 默认每个 Item 分别执行 | 5 个 Item → HTTP Request 发 5 次 |

### 1.3 理解输入引用：$input vs $items

在 Code 节点和表达式中，你需要注意数据的引用方式：

```javascript
// 方式1：引用当前节点的所有输入
const allItems = $input.all();      // 返回所有 Item 的数组

// 方式2：引用当前 Item（在表达式中最常用）
const currentName = $json.name;     // 等同于 $input.item.json.name

// 方式3：引用上游特定节点的输出
const upstreamData = $('HTTP Request').item.json;  // 按节点名引用
```

**引用层级速查**：

| 表达式 | 含义 | 使用场景 |
|--------|------|----------|
| `$json` | 当前 Item 的 json 数据 | 最常用，获取当前行数据 |
| `$input.item.json` | 同上，更完整的写法 | Code 节点中 |
| `$input.all()` | 所有输入 Item 的数组 | 需要遍历所有数据时 |
| `$('节点名').item.json` | 指定节点的第一个 Item | 跨节点引用数据 |
| `$('节点名').all()` | 指定节点的所有 Item | 跨节点引用全部数据 |

### 1.4 用实际操作验证数据结构

创建一个新工作流来观察数据结构：

```
Manual Trigger → Code (构造复杂数据) → Edit Fields (观察 json)
```

**Code 节点代码**：

```javascript
// 构造包含嵌套结构的复杂 Item
return [
  {
    json: {
      user: "张三",
      profile: {
        age: 25,
        city: "北京",
        skills: ["JavaScript", "Vue", "Node.js"]
      },
      projects: [
        { name: "项目A", status: "进行中" },
        { name: "项目B", status: "已完成" }
      ]
    }
  }
];
```

执行后观察 Output 面板——你会看到嵌套的 JSON 结构被完整保留。

> ✋ **费曼自测**：n8n 中一个 Item 的 `json` 和 `binary` 分别存什么？如果一个工作流只处理文字数据，`binary` 会有内容吗？

---

## 番茄钟2：数据转换四件套（25分钟）

### 2.1 用大白话理解四件套

想象你是一个仓库管理员，面对一堆杂乱的货物：

| 节点 | 大白话 | 类比 |
|------|--------|------|
| **Split Out** | 把一箱货物拆成单件 | 拆箱——一箱苹果 → 一个一个摆出来 |
| **Aggregate** | 把散货装进箱子 | 装箱——一堆苹果 → 装成一箱 |
| **Sort** | 按规则排列货物 | 排序——按大小/价格排列 |
| **Remove Duplicates** | 去掉重复的货物 | 去重——同样的只留一个 |

### 2.2 Split Out——拆分数组

**最常用的场景**：API 返回一个数组，你想对数组中的每个元素分别处理。

```
拆分前（1个Item）:                    拆分后（3个Item）:
{                                     { "name": "张三", "skill": "JS" }
  "name": "团队A",                    { "name": "李四", "skill": "Python" }
  "members": [                        { "name": "王五", "skill": "Go" }
    { "name": "张三", "skill": "JS" },
    { "name": "李四", "skill": "Python" },
    { "name": "王五", "skill": "Go" }
  ]
}
```

**配置步骤**：

1. 添加 **Split Out** 节点
2. **Field to Split Out**: `members`（选择要拆分的数组字段名）
3. （可选）勾选 **Include Binary Data** 如果你还需要保留 binary

**实操练习**：

```
Manual Trigger → Code (构造含数组的数据) → Split Out (拆分数组) → Set (给每个成员加标签)
```

**Code 节点**：

```javascript
return [{
  json: {
    teamName: "开发组",
    members: [
      { name: "张三", role: "前端" },
      { name: "李四", role: "后端" },
      { name: "王五", role: "测试" }
    ]
  }
}];
```

**Split Out 配置**：
- Field to Split Out: `members`

**Set 节点**：
- Name: `greeting`, Value: `={{ $json.name }} 是 {{ $json.role }} 开发者`

执行后你会看到 3 个 Item，每个代表一个成员。

### 2.3 Aggregate——聚合数据

**最常用的场景**：把分散的 Item 重新组合成一个，比如统计、汇总。

```
聚合前（3个Item）:              聚合后（1个Item）:
{ "name": "张三", "score": 85 }  {
{ "name": "李四", "score": 62 }    "data": [
{ "name": "王五", "score": 45 }      { "name": "张三", "score": 85 },
                                     { "name": "李四", "score": 62 },
                                     { "name": "王五", "score": 45 }
                                   ]
                                 }
```

**配置步骤**：

1. 添加 **Aggregate** 节点
2. **Aggregate**: 选择 `All Items Together`（把所有 Item 合并）或 `Each Item`（保留分组）
3. **Field to Aggregate**: 留空则聚合所有字段，指定字段名则只聚合该字段

**常见模式——Split Out → 处理 → Aggregate**：

```
数据源 → Split Out (拆开) → IF (筛选) → ... → Aggregate (合回去)
```

这是 n8n 中最经典的数据处理管道。

### 2.4 Sort——排序

**配置步骤**：

1. 添加 **Sort** 节点
2. 点击 **Add Sort Rule**
3. **Field Name**: 选择排序依据的字段
4. **Order**: `Ascending`（升序）或 `Descending`（降序）

**实操示例**：

```
Code (生成成绩列表) → Sort (按分数降序) → 输出
```

**Code 节点**：

```javascript
return [
  { json: { name: "张三", score: 85 } },
  { json: { name: "李四", score: 62 } },
  { json: { name: "王五", score: 95 } },
  { json: { name: "赵六", score: 45 } }
];
```

**Sort 配置**：
- Field Name: `score`
- Order: `Descending`

执行后输出：王五(95) → 张三(85) → 李四(62) → 赵六(45)

### 2.5 Remove Duplicates——去重

**配置步骤**：

1. 添加 **Remove Duplicates** 节点
2. **Compare**: 选择去重依据
   - `All Fields`：所有字段都相同才算重复
   - `Selected Fields`：只比较指定字段
3. 如果选择 `Selected Fields`，点击 **Add Field to Compare** 添加字段名

**实操示例**：

```
Code (含重复数据) → Remove Duplicates (按邮箱去重) → 输出
```

**Code 节点**：

```javascript
return [
  { json: { name: "张三", email: "zhang@test.com" } },
  { json: { name: "张三丰", email: "zhang@test.com" } },  // 邮箱重复
  { json: { name: "李四", email: "li@test.com" } },
  { json: { name: "李四", email: "li@test.com" } }         // 完全重复
];
```

**Remove Duplicates 配置**：
- Compare: `Selected Fields`
- Field to Compare: `email`

执行后只保留 2 个 Item（张三、李四各一个）。

### 2.6 四件套组合：经典数据管道

```
HTTP Request (获取用户列表) → Split Out (拆分数组) → Remove Duplicates (去重)
  → Sort (按注册日期排序) → Aggregate (合并成一份报告)
```

> ✋ **费曼自测**：如果你从 API 拿到一个包含 100 个订单的数组，想按金额从高到低排列并去掉重复订单，需要用到哪几个节点？顺序是什么？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Item 的 `json` 存结构化数据，`binary` 存文件
- [ ] Split Out 把一个 Item 中的数组拆成多个 Item
- [ ] Aggregate 把多个 Item 合并成一个
- [ ] Sort 按字段排序，Remove Duplicates 按字段去重
- [ ] 经典管道：Split Out → 处理 → Aggregate

---

## 番茄钟3：三种循环模式（25分钟）

### 3.1 用大白话理解循环

循环就像「快递员送包裹」：

- 你有 100 个包裹要送
- 不能一次性全搬（太重）
- 得一批一批送
- 不同送法 = 不同循环模式

### 3.2 模式一：Split In Batches——分批处理（推荐）

**适用场景**：API 有速率限制，不能一次发太多请求。

```
所有数据 → Split In Batches (每批3个) → 处理节点 → 循环回到 Split In Batches
                                       ↑              ↓
                                       └──────────────┘
```

**工作原理**：

```
100 个 Item 进入 Split In Batches
  → 第1批：Item 1-3 → 处理 → 回到 Split In Batches
  → 第2批：Item 4-6 → 处理 → 回到 Split In Batches
  → ...
  → 最后一批：Item 97-100 → 处理 → 继续往下走
```

**配置步骤**：

1. 添加 **Split In Batches** 节点
2. **Batch Size**: `3`（每批处理多少个 Item）
3. 在 Split In Batches 之后添加你的处理节点
4. **把最后一个处理节点的输出连回 Split In Batches**——这形成循环
5. Split In Batches 的第二个输出（done）连接后续节点

**关键理解**：

| 输出 | 含义 | 连接到 |
|------|------|--------|
| 输出1（batch） | 当前批次的数据 | 处理节点 |
| 输出2（done） | 所有批次处理完毕 | 后续节点 |

**实操示例——批量发送通知**：

```
Manual Trigger → Code (生成用户列表) → Split In Batches (每批2个)
  → HTTP Request (发送通知) → 连回 Split In Batches
  → Set (全部完成提示)
```

**Code 节点**：

```javascript
return [
  { json: { userId: 1, name: "张三", email: "zhang@test.com" } },
  { json: { userId: 2, name: "李四", email: "li@test.com" } },
  { json: { userId: 3, name: "王五", email: "wang@test.com" } },
  { json: { userId: 4, name: "赵六", email: "zhao@test.com" } },
  { json: { userId: 5, name: "孙七", email: "sun@test.com" } }
];
```

**Split In Batches 配置**：
- Batch Size: `2`

**HTTP Request 配置**（模拟发送通知）：
- Method: `POST`
- URL: `https://httpbin.org/post`
- Body (JSON):
```json
{
  "message": "Hello {{ $json.name }}",
  "email": "{{ $json.email }}"
}
```

执行后观察：HTTP Request 会分 3 批执行（2+2+1）。

### 3.3 模式二：Code 节点循环——编程式控制

**适用场景**：需要复杂的循环逻辑（条件跳出、嵌套循环等）。

```javascript
// Code 节点中的循环示例：处理每个 Item 并添加处理结果
const items = $input.all();
const results = [];

for (const item of items) {
  const score = item.json.score;

  // 复杂的条件逻辑
  let level;
  if (score >= 90) {
    level = "A - 优秀";
  } else if (score >= 80) {
    level = "B - 良好";
  } else if (score >= 60) {
    level = "C - 及格";
  } else {
    level = "D - 不及格";
  }

  results.push({
    json: {
      ...item.json,
      level: level,
      passed: score >= 60
    }
  });
}

return results;
```

**Code 循环 vs Split In Batches**：

| 特性 | Split In Batches | Code 循环 |
|------|------------------|-----------|
| 可视化 | ✅ 流程图可见 | ❌ 代码中隐藏 |
| 调试方便 | ✅ 每批可单独检查 | ⚠️ 需要加日志 |
| 复杂逻辑 | ❌ 只能简单循环 | ✅ 条件/嵌套/递归 |
| 速率控制 | ✅ 天然分批 | ⚠️ 需手动 Wait |
| 调用外部 API | ✅ 可配合 HTTP Request | ❌ 不适合 |
| 数据纯计算 | ⚠️ 过于繁琐 | ✅ 简洁高效 |

### 3.4 模式三：Wait + Loop——定时轮询

**适用场景**：等待某个条件满足（比如等 API 处理完成、等文件生成）。

```
触发器 → HTTP Request (发起任务) → Wait (等30秒) → HTTP Request (检查状态)
  ↑                                                              ↓
  └──────────── 如果未完成，连回来继续等 ──────────────────────────┘
```

**实操示例——等待 API 任务完成**：

```
Manual Trigger → HTTP Request (提交任务) → IF (状态=完成?)
  → Yes → Set (任务完成！)                    → No → Wait (等30秒) → 连回 IF
```

**IF 节点配置**：
- Condition: `{{ $json.status }}` equals `completed`

**Wait 节点配置**：
- Wait Type: `Time`
- Amount: `30` Unit: `Seconds`

**重要提醒**：
- ⚠️ 一定要设置**最大重试次数**（在 IF 的 No 分支加计数器），否则可能死循环
- ⚠️ Wait 节点会占用执行时间，长时间轮询消耗资源
- 💡 建议总等待时间不超过 5 分钟

**防止死循环的技巧**：

```javascript
// 在 Wait 之前的 Code 节点中维护计数器
const retryCount = $('IF').item.json.retryCount || 0;
const newCount = retryCount + 1;

if (newCount > 10) {
  // 超过 10 次，抛出错误
  throw new Error('轮询超时：等待超过 10 次（约5分钟）');
}

return {
  json: {
    ...$input.item.json,
    retryCount: newCount
  }
};
```

> ✋ **费曼自测**：你有 200 个用户要调用 API 发邮件，API 限制每秒最多 5 次请求，应该用哪种循环模式？为什么？

---

## 番茄钟4：四种错误处理策略（25分钟）

### 4.1 用大白话理解错误处理

错误处理就像「工厂的安全措施」：

| 策略 | 类比 | 适用场景 |
|------|------|----------|
| Continue On Fail | 给机器装保护罩——坏了不停产线 | 某个非关键步骤偶尔失败 |
| Error Trigger | 装火灾警报——出了事自动报警 | 全局监控，统一处理错误 |
| Try-Catch (IF) | 人工巡检——每步检查再决定 | 需要根据错误类型做不同处理 |
| Sub-Workflow | 隔离车间——危险操作在独立空间 | 高风险操作，防止连锁崩溃 |

### 4.2 策略一：Continue On Fail——节点级容错

**最简单的错误处理**：让节点失败后继续执行，不中断整个工作流。

**配置步骤**：

1. 点击目标节点 → 右上角 **Settings** 标签页
2. 找到 **Continue On Fail** → 开启开关
3. （可选）在 Note 中备注：这个节点为什么允许失败

**工作原理**：

```
正常流程:  A → B(失败!) → 整个流程停止 ❌
Continue On Fail:  A → B(失败但继续) → C → D ✅
```

**实操示例**：

```
Manual Trigger → Code (正常数据) → HTTP Request (可能失败的API, 开启Continue On Fail) → Set (检查结果)
```

**Code 节点**：

```javascript
return [
  { json: { url: "https://httpbin.org/status/200" } },  // 会成功
  { json: { url: "https://httpbin.org/status/500" } },  // 会失败
  { json: { url: "https://httpbin.org/status/200" } }   // 会成功
];
```

**HTTP Request 配置**：
- Method: `GET`
- URL: `={{ $json.url }}`
- Settings → Continue On Fail: **开启**

**Set 节点**（检查结果）：
- Name: `status`, Value: `={{ $json.error ? "❌ 失败: " + $json.error.message : "✅ 成功" }}`

执行后你会看到：3 个 Item 全部流过，其中第 2 个带错误信息但不中断流程。

**关键点**：
- 开启后，失败节点的输出会包含 `error` 字段
- 可以用 `{{ $json.error }}` 判断是否失败
- 只影响当前节点，不影响其他节点

### 4.3 策略二：Error Trigger——工作流级错误处理器

**适用场景**：当任何工作流出错时，自动触发一个错误处理工作流（发通知、记录日志等）。

**配置步骤**：

1. 创建一个**新的**错误处理工作流
2. 添加 **Error Trigger** 节点作为触发器
3. 添加错误处理节点（如发 Slack 通知、写日志）

**Error Trigger 输出的数据结构**：

```json
{
  "execution": {
    "id": "1234",
    "url": "https://your-n8n.com/execution/1234",
    "retryOf": null,
    "error": {
      "message": "HTTP Error 500",
      "name": "NodeApiError"
    },
    "lastNodeExecuted": "HTTP Request",
    "mode": "manual"
  },
  "workflow": {
    "id": "5678",
    "name": "我的数据处理工作流"
  }
}
```

**实操示例——错误通知工作流**：

```
Error Trigger → Set (格式化错误信息) → Slack (发送错误通知)
```

如果没有 Slack，可以用 HTTP Request 代替：

```
Error Trigger → Set (格式化错误信息) → HTTP Request (发送到 httpbin)
```

**Set 节点**：

| Name | Value |
|------|-------|
| `errorWorkflow` | `={{ $json.workflow.name }}` |
| `errorNode` | `={{ $json.execution.lastNodeExecuted }}` |
| `errorMessage` | `={{ $json.execution.error.message }}` |
| `executionUrl` | `={{ $json.execution.url }}` |

**在目标工作流中配置 Error Trigger**：

1. 打开目标工作流 → **Settings**（齿轮图标）
2. 找到 **Error Workflow** → 选择你刚创建的错误处理工作流
3. 保存

现在，目标工作流任何节点出错，都会自动触发错误处理工作流。

### 4.4 策略三：Try-Catch with IF 节点——条件式错误处理

**适用场景**：某个节点可能失败，你想根据失败类型做不同处理。

```
A → B (可能失败) → IF (检查是否出错)
                      ├── Yes (出错) → 错误处理分支
                      └── No (正常)  → 正常处理分支
```

**实现方式**：

**方法A：Continue On Fail + IF 判断**

1. 在可能失败的节点开启 **Continue On Fail**
2. 在其后添加 **IF** 节点
3. 条件：`{{ $json.error }}` exists / is not empty
4. Yes 分支 → 错误处理
5. No 分支 → 正常流程

**方法B：利用节点输出的状态码**

```
HTTP Request (Continue On Fail) → IF (status code = 200?)
  ├── Yes → 正常处理
  └── No → 重试 / 记录错误 / 发通知
```

**IF 节点配置**：
- Condition: `{{ $json.error }}` is not empty

**实操示例**：

```
Manual Trigger → HTTP Request (Continue On Fail) → IF (有错误?)
  → True → Set (记录错误) → 输出
  → False → Set (正常处理) → 输出
```

**HTTP Request**：
- URL: `https://httpbin.org/status/500`（故意返回 500）
- Settings → Continue On Fail: **开启**

**IF 节点**：
- Condition: `{{ $json.error }}` is not empty

**True 分支的 Set 节点**：
- Name: `result`, Value: `⚠️ API 调用失败: {{ $json.error.message }}`

**False 分支的 Set 节点**：
- Name: `result`, Value: `✅ API 调用成功`

### 4.5 策略四：Sub-Workflow 隔离——危险操作隔离舱

**适用场景**：某个操作风险高（可能崩溃、超时），不想影响主工作流。

**类比**：核电站的反应堆放在隔离舱里——就算出了问题，也不会波及整座电站。

**配置步骤**：

1. 创建一个子工作流（执行高风险操作）
2. 在主工作流中使用 **Execute Workflow** 节点调用子工作流
3. 即使子工作流崩溃，主工作流也能捕获错误继续执行

**主工作流**：

```
Manual Trigger → Execute Workflow (调用子工作流, Continue On Fail) → IF (子工作流成功?)
  → Yes → 正常后续
  → No → 降级方案
```

**Execute Workflow 节点配置**：
- Source: `Database`
- Workflow ID: 选择子工作流
- Settings → Continue On Fail: **开启**

**子工作流示例**：

```
Manual Trigger → HTTP Request (调用不稳定API) → Set (提取结果)
```

**关键优势**：

| 特性 | 说明 |
|------|------|
| 隔离 | 子工作流的崩溃不影响主工作流 |
| 可重试 | 子工作流可以独立重试 |
| 可复用 | 同一个子工作流可被多个主工作流调用 |
| 可监控 | 每个子工作流有独立的执行日志 |

### 4.6 四种策略对比总结

| 策略 | 粒度 | 复杂度 | 适用场景 | 推荐指数 |
|------|------|--------|----------|----------|
| Continue On Fail | 节点级 | ⭐ | 单个节点偶尔失败 | ⭐⭐⭐⭐⭐ |
| Error Trigger | 工作流级 | ⭐⭐ | 全局错误通知和日志 | ⭐⭐⭐⭐ |
| Try-Catch (IF) | 分支级 | ⭐⭐⭐ | 需要区分成功/失败走不同路径 | ⭐⭐⭐⭐ |
| Sub-Workflow | 工作流级 | ⭐⭐⭐⭐ | 高风险操作隔离 | ⭐⭐⭐ |

**选择决策树**：

```
需要错误处理？
├── 只是不想让单个节点失败中断流程？
│   └── ✅ Continue On Fail
├── 想在出错时收到通知？
│   └── ✅ Error Trigger
├── 需要根据成功/失败走不同路径？
│   └── ✅ Try-Catch (Continue On Fail + IF)
└── 操作风险高，需要完全隔离？
    └── ✅ Sub-Workflow
```

> ✋ **费曼自测**：如果一个 HTTP Request 节点偶尔超时，你想让它失败后继续执行但记录错误日志，应该用哪种策略？如果还想对失败的请求单独重试呢？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 能说出三种循环模式的名称和适用场景
- [ ] 能配置 Split In Batches 并正确连线形成循环
- [ ] 理解 Continue On Fail 的作用和配置方法
- [ ] 能说出四种错误处理策略的区别
- [ ] 知道什么时候用 Sub-Workflow 隔离

---

## 番茄钟5：实战——批量用户数据处理工作流（25分钟）

### 5.1 目标

构建一个完整的批量用户数据处理工作流，综合运用今天学到的所有知识：

```
Manual Trigger → HTTP Request (获取用户列表) → Split Out (拆分数组)
  → IF (活跃用户?) → Split In Batches (每批3个)
  → HTTP Request (发送通知, Continue On Fail) → IF (有错误?)
    → Yes → Set (记录错误)
    → No → Set (记录成功)
  → 连回 Split In Batches
  → Aggregate (汇总结果) → Set (生成报告)
```

### 5.2 第一步：获取用户数据

**Manual Trigger** → **Code 节点**（模拟 API 返回数据）

**Code 节点**：

```javascript
// 模拟 API 返回的用户列表（实际项目中用 HTTP Request）
return [{
  json: {
    users: [
      { id: 1, name: "张三", email: "zhang@test.com", active: true, score: 85 },
      { id: 2, name: "李四", email: "li@test.com", active: false, score: 62 },
      { id: 3, name: "王五", email: "wang@test.com", active: true, score: 95 },
      { id: 4, name: "赵六", email: "zhao@test.com", active: true, score: 45 },
      { id: 5, name: "孙七", email: "sun@test.com", active: false, score: 78 },
      { id: 6, name: "周八", email: "zhou@test.com", active: true, score: 88 },
      { id: 7, name: "吴九", email: "wu@test.com", active: true, score: 55 }
    ]
  }
}];
```

### 5.3 第二步：拆分数组 + 筛选活跃用户

**Split Out**：
- Field to Split Out: `users`

**IF 节点**：
- Condition: `{{ $json.active }}` equals `true`
- True 输出连接后续节点
- False 输出可以不连（丢弃非活跃用户）

### 5.4 第三步：分批处理 + 发送通知

**Split In Batches**：
- Batch Size: `3`

**HTTP Request**（模拟发送通知）：
- Method: `POST`
- URL: `https://httpbin.org/post`
- Body (JSON):
```json
{
  "userId": "{{ $json.id }}",
  "name": "{{ $json.name }}",
  "message": "您的分数是 {{ $json.score }}，感谢参与！"
}
```
- Settings → Continue On Fail: **开启**

### 5.5 第四步：处理成功/失败

**IF 节点**（判断是否有错误）：
- Condition: `{{ $json.error }}` is not empty

**True 分支 → Set 节点**（记录失败）：
- Name: `result`, Value: `❌ 通知失败: {{ $('IF').item.json.name }} - {{ $json.error.message }}`

**False 分支 → Set 节点**（记录成功）：
- Name: `result`, Value: `✅ 通知成功: {{ $('IF').item.json.name }}`

### 5.6 第五步：循环回去

把两个 Set 节点的输出**都连回 Split In Batches**。

### 5.7 第六步：汇总结果

**Split In Batches 的 done 输出** → **Aggregate**：
- Aggregate: `All Items Together`

**Set 节点**（生成报告）：

| Name | Value |
|------|-------|
| `totalProcessed` | `={{ $input.all().length }}` |
| `reportTime` | `={{ $now.toFormat('yyyy-MM-dd HH:mm:ss') }}` |
| `summary` | `=批量处理完成！共处理 {{ $input.all().length }} 个用户` |

### 5.8 完整工作流图

```
Manual Trigger
    │
    ▼
Code (模拟用户数据)
    │
    ▼
Split Out (拆分 users 数组)
    │
    ▼
IF (active = true?)
    │
    ▼ (True)
Split In Batches (每批3个) ──── batch ──→ HTTP Request (发通知, Continue On Fail)
    │                                              │
    │ done                                         ▼
    ▼                                         IF (有错误?)
Aggregate (汇总)                           ↙         ↘
    │                                  True          False
    ▼                                    │              │
Set (生成报告)                        Set (失败)     Set (成功)
                                         │              │
                                         └──────┬───────┘
                                                │
                                    连回 Split In Batches
```

> ✋ **费曼自测**：不看上面的步骤，你能回忆出这个工作流的完整流程吗？每个节点的配置要点是什么？

---

## 番茄钟6：自由实践（25分钟）

### 6.1 练习1：订单数据处理管道

创建一个工作流，实现：

```
Code (生成订单数据) → Split Out (拆分订单) → Remove Duplicates (按订单号去重)
  → Sort (按金额降序) → IF (金额>100?) → Set (标记大单) → Aggregate (汇总)
```

**Code 节点**：

```javascript
return [{
  json: {
    orders: [
      { orderId: "A001", product: "键盘", amount: 299, customer: "张三" },
      { orderId: "A002", product: "鼠标", amount: 49, customer: "李四" },
      { orderId: "A001", product: "键盘", amount: 299, customer: "张三" },  // 重复订单
      { orderId: "A003", product: "显示器", amount: 1599, customer: "王五" },
      { orderId: "A004", product: "鼠标垫", amount: 25, customer: "赵六" },
      { orderId: "A005", product: "耳机", amount: 399, customer: "孙七" }
    ]
  }
}];
```

提示：在 Aggregate 之后添加 Code 节点统计总金额和大单数量。

**统计 Code 节点**：

```javascript
const items = $input.all();
let totalAmount = 0;
let bigOrderCount = 0;

for (const item of items) {
  totalAmount += item.json.amount || 0;
  if (item.json.isBigOrder) bigOrderCount++;
}

return [{
  json: {
    totalOrders: items.length,
    totalAmount: totalAmount,
    bigOrderCount: bigOrderCount,
    averageAmount: Math.round(totalAmount / items.length),
    reportTime: new Date().toISOString()
  }
}];
```

### 6.2 练习2：错误处理实战

创建一个工作流，对多个 URL 发起请求，实现：

1. 开启 Continue On Fail
2. 成功的请求走正常路径
3. 失败的请求记录错误并重试一次

```
Code (URL列表) → Split In Batches (每批2个) → HTTP Request (Continue On Fail)
  → IF (有错误?)
    → True → HTTP Request (重试) → 连回 Split In Batches
    → False → 连回 Split In Batches
  → done → Aggregate (汇总)
```

**Code 节点**：

```javascript
return [
  { json: { url: "https://httpbin.org/status/200" } },
  { json: { url: "https://httpbin.org/status/500" } },  // 会失败
  { json: { url: "https://httpbin.org/status/200" } },
  { json: { url: "https://httpbin.org/status/404" } }   // 会失败
];
```

**重试的 HTTP Request**：
- URL: `={{ $('Split In Batches').item.json.url }}`（使用原始 URL 重试）
- 也开启 Continue On Fail

### 6.3 练习3（挑战）：完整的数据管道 + 错误处理

将练习1和练习2结合起来：

1. 获取订单数据 → 去重 → 排序
2. 对每个大单验证客户信息（调用 API）
3. API 可能失败，需要错误处理
4. 最终生成一份包含成功/失败统计的报告

> ✋ **费曼自测**：不看任何参考，从零设计一个包含「拆分→筛选→分批处理→错误处理→汇总」的完整工作流。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 完成了批量用户数据处理工作流
- [ ] 至少完成了练习1或练习2
- [ ] 理解 Split In Batches 的循环连线方式
- [ ] 能在失败场景中正确使用 Continue On Fail + IF
- [ ] 理解 Aggregate 在管道末尾的汇总作用

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念表

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| Split Out | 把数组字段拆成多个 Item | 拆箱——一箱苹果一个个摆出来 |
| Aggregate | 把多个 Item 合并成一个 | 装箱——散货装回箱子 |
| Sort | 按字段值排序 Item | 按大小排列货物 |
| Remove Duplicates | 按字段去重 | 同样的货只留一件 |
| Split In Batches | 分批处理 Item | 快递员一批一批送 |
| Code 循环 | 在代码中控制循环 | 人工一件件搬 |
| Wait + Loop | 定时轮询等待条件满足 | 每隔几分钟看一眼快递到了没 |
| Continue On Fail | 节点失败不中断流程 | 机器装保护罩 |
| Error Trigger | 出错自动触发处理工作流 | 火灾警报 |
| Try-Catch (IF) | 根据成功/失败走不同路径 | 人工巡检分流 |
| Sub-Workflow | 高风险操作在隔离空间执行 | 核反应堆隔离舱 |

### 7.2 循环模式决策树

```
需要循环处理数据？
├── 只需要对每个 Item 做计算？
│   └── ✅ 不需要循环！大多数节点自动逐个处理 Item
├── 需要调用外部 API 且有速率限制？
│   └── ✅ Split In Batches（分批处理）
├── 需要复杂的条件/嵌套逻辑？
│   └── ✅ Code 节点循环
└── 需要等待某个条件满足？
    └── ✅ Wait + Loop（定时轮询）
```

### 7.3 错误处理决策树

```
需要错误处理？
├── 只是不想让单节点失败中断流程？
│   └── ✅ Continue On Fail
├── 想在出错时收到通知？
│   └── ✅ Error Trigger
├── 需要根据成功/失败走不同路径？
│   └── ✅ Continue On Fail + IF（Try-Catch 模式）
└── 操作风险高，需要完全隔离？
    └── ✅ Sub-Workflow
```

### 7.4 数据转换节点速查卡

| 节点 | 输入→输出 | 关键配置 | 典型用法 |
|------|----------|----------|----------|
| Split Out | 1 Item → N Items | Field to Split Out | 拆分 API 返回的数组 |
| Aggregate | N Items → 1 Item | Aggregate 模式 | Split Out 后合回去 |
| Sort | N Items → N Items（有序） | Field + Order | 按时间/金额排序 |
| Remove Duplicates | N Items → ≤N Items | Compare Field | 按ID/邮箱去重 |
| Split In Batches | N Items → 批次处理 | Batch Size | 速率限制下的批量处理 |

### 7.5 表达式速查

| 表达式 | 含义 | 示例 |
|--------|------|------|
| `$json.fieldName` | 当前 Item 的字段值 | `$json.name` → "张三" |
| `$input.all()` | 所有输入 Item 数组 | Code 节点中遍历 |
| `$input.item.json` | 当前 Item（完整写法） | Code 节点中 |
| `$('节点名').item.json` | 指定节点的第一个 Item | 跨节点引用 |
| `$('节点名').all()` | 指定节点的所有 Item | 跨节点遍历 |
| `$json.error` | 错误信息（Continue On Fail） | 判断是否失败 |

> ✋ **费曼自测**：把上面的表格遮住，你能回忆出每个概念的一句话解释和类比吗？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——数据变换与工作流模式

**练习目标**：在25分钟内完成3轮数据处理循环，掌握拆分、筛选、聚合的完整管道操作

**任务序列（重复×3）：**

```
===== 循环 1：用3种不同方式处理同一数据 =====
1. 创建 Code 节点生成10条订单数据（含金额、类别、日期）
2. 用 Sort 按金额降序排列
3. 用 Remove Duplicates 按订单号去重
4. 用 Split Out 拆分数组后再用 Aggregate 合并回
5. 对比三种处理方式的数据输出差异
验证：排序后金额从高到低、重复订单被移除、拆分再合并后数据不变

===== 循环 2：构建条件分支工作流 =====
1. 创建 Code 节点生成混合数据
2. 添加 IF 节点做二选一判断（金额>100为"大单"）
3. 两个分支分别用 Set 节点标记不同标签
4. 用 Merge 将两个分支重新合并
验证：大单和小单被正确分离并标记，Merge 后数据完整

===== 循环 3：实现循环和聚合操作 =====
1. 创建 Code 节点生成一批用户数据
2. 用 Split In Batches 分批（每批3个）
3. 每批经过 HTTP Request 模拟发送通知
4. 循环处理完所有批次后用 Aggregate 汇总结果
5. 输出最终统计报告
验证：所有批次被依次处理，汇总报告包含正确的处理总数
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 数据转换四件套(Split/Aggregate/Sort/Dedup) | ⬜ | ⬜ | ⬜ |
| 条件分支(IF/Switch)与数据路由 | ⬜ | ⬜ | ⬜ |
| 循环分批处理与汇总 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Split Out + Aggregate 的组合为什么是 n8n 中最经典的数据管道模式？Split In Batches 的 batch 输出和 done 输出分别连接到什么节点？

### 8.1 今日自检清单

完成以下所有项才算通过 Day 4：

- [ ] ✅ 理解 Item 的 json 和 binary 结构
- [ ] ✅ 能使用 Split Out 拆分数组字段
- [ ] ✅ 能使用 Aggregate 合并多个 Item
- [ ] ✅ 能使用 Sort 和 Remove Duplicates
- [ ] ✅ 能配置 Split In Batches 形成循环
- [ ] ✅ 知道三种循环模式的适用场景
- [ ] ✅ 能配置 Continue On Fail
- [ ] ✅ 能配置 Error Trigger 工作流
- [ ] ✅ 能用 Continue On Fail + IF 实现 Try-Catch
- [ ] ✅ 理解 Sub-Workflow 隔离的作用
- [ ] ✅ 完成了批量用户数据处理工作流
- [ ] ✅ 至少完成了 1 个自由练习

### 8.2 费曼一句话总结

> **n8n 的数据处理核心是「拆-选-排-去-聚」五步管道，配合 Split In Batches 分批循环处理外部调用。错误处理从简单到复杂有四层：节点容错(Continue On Fail) → 全局告警(Error Trigger) → 条件分流(Try-Catch) → 隔离舱(Sub-Workflow)。**

### 8.3 学习笔记

```markdown
## Day 4 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 实践中遇到的问题
（记录实操中踩的坑和解决方案）

### 明天想深入的方向
（为 Day 5 做准备）
```

---

## 🎉 Day 4 完成！

**今日成果：**
- ✅ 掌握了数据转换四件套（Split Out / Aggregate / Sort / Remove Duplicates）
- ✅ 理解并实操了三种循环模式
- ✅ 掌握了四种错误处理策略
- ✅ 完成了批量用户数据处理工作流
- ✅ 独立完成了自由练习

**明天预告：** [[Day5-Webhook与外部集成]] - 学习 Webhook 触发器，构建完整的 API 服务，让外部系统主动调用你的工作流

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day3-凭证管理与API集成]] - 上一天
> - [[Day5-Webhook与外部集成]] - 下一天
