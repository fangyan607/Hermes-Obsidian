# Day 2：数据处理管道（3个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建3个数据处理工作流，掌握数据清洗、格式转换、批量处理
> 🧠 教学方法：费曼学习法 × 刻意练习
> 📹 参考视频：[B站 n8n 实战系列](https://www.bilibili.com/video/BV15zCEBDEfT/)
> 📖 前置理论：[[Day2-核心节点与触发器]]、[[Day4-数据处理与工作流模式]]

---

## 今日学习路径

```
🍅 番茄1-2：实例4 · 用户数据清洗管道
🍅 番茄3-4：实例5 · CSV格式转换器
🍅 番茄5-6：实例6 · 批量文件处理
🍅 番茄7-8：今日复习 + 费曼综合检测
```

---

## 🔴 番茄1：实例4 · 用户数据清洗管道（上）

### 🎯 场景与目标

**场景**：你从多个渠道收集了用户注册数据，但数据质量参差不齐——有缺失邮箱的、电话格式混乱的、名字大小写不一致的，甚至还有重复条目。你需要一条自动化管道，把脏数据洗干净。

**学习重点**：
- Code 节点的正则验证
- IF 节点的条件分流
- Merge 节点的数据合并
- Set 节点的字段增删改

### 🏗️ 工作流架构图

```
┌──────────────┐
│ Manual Trigger│
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│ Code: 生成脏用户数据  │
│ (含各类数据问题)      │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Edit Fields (Set)    │
│ 删除敏感字段          │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Code: 数据清洗与验证  │
│ (邮箱验证+电话标准化) │
└──────┬───────────────┘
       │
       ▼
┌──────────────────┐
│ IF: 数据是否有效？ │
└──┬───────────┬───┘
   │ true      │ false
   ▼           ▼
┌────────┐  ┌──────────────┐
│ Set    │  │ Set          │
│ 加处理 │  │ 加错误原因    │
│ 标记   │  │              │
└───┬────┘  └──────┬───────┘
    │              │
    ▼              ▼
┌─────────────────────────┐
│ Merge: 合并有效+无效数据 │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Code: 生成清洗报告       │
└─────────────────────────┘
```

### 🔑 API/凭证准备

本实例**无需任何 API Key**，所有数据在 Code 节点内生成和处理，纯本地运行。

---

## 🔴 番茄2：实例4 · 用户数据清洗管道（下）

### 🔧 逐节点配置

#### 节点1：Manual Trigger

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.manualTrigger` |
| 说明 | 手动点击执行，无需额外配置 |

#### 节点2：Code — 生成脏用户数据

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
// 模拟从多个渠道收集的脏用户数据
const dirtyUsers = [
  { id: 1, name: "zhang san", email: "zhangsan@example.com", phone: "13812345678", ssn: "310-12-3456", source: "web" },
  { id: 2, name: "LI SI", email: "", phone: "86-139-8765-4321", ssn: "320-45-6789", source: "mobile" },
  { id: 3, name: "wang wu", email: "wangwu@", phone: "15011112222", ssn: "", source: "web" },
  { id: 4, name: "ZHAO LIU", email: "zhaoliu@test.com", phone: "abc123", ssn: "310-99-0000", source: "import" },
  { id: 5, name: "sun qi", email: "sunqi@example.com", phone: "1371234567", ssn: "330-78-1111", source: "mobile" },
  { id: 6, name: "ZHANG SAN", email: "zhangsan@example.com", phone: "13812345678", ssn: "310-12-3456", source: "web" },
  { id: 7, name: "zhou ba", email: "zhouba@mail.com", phone: "18600001111", ssn: "", source: "import" },
  { id: 8, name: "wu jiu", email: "wujiu@domain", phone: "15022223333", ssn: "340-56-2222", source: "web" },
  { id: 9, name: "CHEN SHI", email: "", phone: "13344445555", ssn: "310-33-3333", source: "mobile" },
  { id: 10, name: "  huang yi  ", email: "huangyi@ok.com", phone: "15566667777", ssn: "", source: "import" },
];

return dirtyUsers.map(user => ({ json: user }));
```

**数据问题清单**：

| 编号 | 问题类型 | 出现在 |
|------|----------|--------|
| 1 | 邮箱缺失 | id=2, id=9 |
| 2 | 邮箱格式无效 | id=3（无域名）, id=8（无TLD） |
| 3 | 电话格式混乱 | id=2（带国际码+短横线）, id=4（非数字） |
| 4 | 名字大小写不一致 | 全部（需统一为首字母大写） |
| 5 | 重复条目 | id=6 与 id=1 重复 |
| 6 | 敏感字段（SSN） | 多条含社会保险号 |
| 7 | 名字前后空格 | id=10 |

#### 节点3：Edit Fields (Set) — 删除敏感字段

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.set` |
| Mode | Manual Mapping |

| 操作 | 字段 | 说明 |
|------|------|------|
| **Remove** | `ssn` | 删除社会保险号 |
| **Remove** | `source` | 删除来源标记（无需保留） |
| **Keep** | `id`, `name`, `email`, `phone` | 保留这四个字段 |

> **提示**：在 Edit Fields 节点中，切换到"Remove"模式，添加 `ssn` 和 `source` 两个字段名即可移除。

#### 节点4：Code — 数据清洗与验证

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const items = $input.all();

// 去重：基于 email + phone 组合
const seen = new Set();
const deduped = items.filter(item => {
  const key = `${item.json.email}|${item.json.phone}`;
  if (seen.has(key)) return false;
  seen.add(key);
  return true;
});

// 邮箱正则验证
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

// 中国手机号正则：1开头，11位数字
const phoneRegex = /^1[3-9]\d{9}$/;

function standardizePhone(raw) {
  if (!raw) return '';
  // 去掉所有非数字字符
  const digits = raw.replace(/\D/g, '');
  // 如果以86开头，去掉86
  if (digits.startsWith('86') && digits.length === 13) {
    return digits.slice(2);
  }
  return digits;
}

function standardizeName(raw) {
  if (!raw) return '';
  return raw.trim().split(/\s+/).map(word =>
    word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
  ).join(' ');
}

const cleaned = deduped.map(item => {
  const data = item.json;
  const errors = [];

  // 名字标准化
  const cleanName = standardizeName(data.name);

  // 邮箱验证
  const cleanEmail = (data.email || '').trim();
  const emailValid = emailRegex.test(cleanEmail);
  if (!cleanEmail) {
    errors.push('邮箱缺失');
  } else if (!emailValid) {
    errors.push('邮箱格式无效');
  }

  // 电话标准化与验证
  const cleanPhone = standardizePhone(data.phone);
  const phoneValid = phoneRegex.test(cleanPhone);
  if (!cleanPhone) {
    errors.push('电话缺失');
  } else if (!phoneValid) {
    errors.push('电话格式无效');
  }

  return {
    json: {
      id: data.id,
      name: cleanName,
      email: cleanEmail,
      phone: cleanPhone,
      emailValid: emailValid,
      phoneValid: phoneValid,
      isValid: errors.length === 0,
      errors: errors.length > 0 ? errors.join('; ') : ''
    }
  };
});

return cleaned;
```

#### 节点5：IF — 数据是否有效

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.if` |
| Conditions | `isValid` `equal` `true` |
| Type | Boolean |
| Output | true → 有效数据, false → 无效数据 |

#### 节点6a：Set — 加处理标记（true分支）

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.set` |
| Mode | Manual Mapping |

| 字段 | 值 | 说明 |
|------|-----|------|
| `status` | `"cleaned"` | 标记为已清洗 |
| `cleanedAt` | `{{ $now.toISO() }}` | 清洗时间戳 |

#### 节点6b：Set — 加错误原因（false分支）

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.set` |
| Mode | Manual Mapping |

| 字段 | 值 | 说明 |
|------|-----|------|
| `status` | `"invalid"` | 标记为无效 |
| `reviewedAt` | `{{ $now.toISO() }}` | 审核时间戳 |

#### 节点7：Merge — 合并有效+无效数据

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.merge` |
| Mode | Append |

> Append 模式将两条分支的数据简单拼合，保持各自字段不变。

#### 节点8：Code — 生成清洗报告

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const items = $input.all();
const total = items.length;
const valid = items.filter(i => i.json.isValid).length;
const invalid = total - valid;

const errorStats = {};
items.forEach(item => {
  if (item.json.errors) {
    item.json.errors.split('; ').forEach(err => {
      errorStats[err] = (errorStats[err] || 0) + 1;
    });
  }
});

return [{
  json: {
    report: '用户数据清洗报告',
    totalRecords: total,
    validRecords: valid,
    invalidRecords: invalid,
    validRate: `${((valid / total) * 100).toFixed(1)}%`,
    dedupedFrom: 10,
    dedupedCount: 1,
    errorBreakdown: errorStats,
    cleanedAt: new Date().toISOString(),
    summary: `共处理 ${total} 条去重后数据，${valid} 条有效(${((valid/total)*100).toFixed(1)}%)，${invalid} 条需人工审核`
  }
}];
```

### 🧪 测试验证

**预期输出（清洗报告节点）**：

```json
{
  "report": "用户数据清洗报告",
  "totalRecords": 9,
  "validRecords": 4,
  "invalidRecords": 5,
  "validRate": "44.4%",
  "dedupedFrom": 10,
  "dedupedCount": 1,
  "errorBreakdown": {
    "邮箱缺失": 2,
    "邮箱格式无效": 2,
    "电话格式无效": 1
  },
  "summary": "共处理 9 条去重后数据，4 条有效(44.4%)，5 条需人工审核"
}
```

**有效数据示例**（IF true 分支）：

| id | name | email | phone | status |
|----|------|-------|-------|--------|
| 1 | Zhang San | zhangsan@example.com | 13812345678 | cleaned |
| 7 | Zhou Ba | zhouba@mail.com | 18600001111 | cleaned |
| 10 | Huang Yi | huangyi@ok.com | 15566667777 | cleaned |

**无效数据示例**（IF false 分支）：

| id | name | email | phone | errors | status |
|----|------|-------|-------|--------|--------|
| 2 | Li Si | | 13987654321 | 邮箱缺失 | invalid |
| 3 | Wang Wu | wangwu@ | 15011112222 | 邮箱格式无效 | invalid |
| 4 | Zhao Liu | zhaoliu@test.com | | 电话格式无效 | invalid |

### 💡 变体与扩展

| 变体 | 说明 | 需要的改动 |
|------|------|-----------|
| **接入真实数据源** | 用 HTTP Request 替代 Code 生成数据 | 节点2改为调用 API |
| **写入数据库** | 清洗结果存入 Google Sheets 或数据库 | 末尾加 Google Sheets 节点 |
| **发送清洗通知** | 每次清洗完自动发 Slack/邮件通知 | 末尾加 Slack 或 Email 节点 |
| **定时清洗** | 改用 Schedule Trigger 定时跑 | 替换 Manual Trigger |
| **更复杂去重** | 模糊匹配去重（相似度>90%） | Code 节点中加入相似度算法 |

### ✋ 费曼检测

1. **解释**：为什么去重要在验证之前做？调换顺序会怎样？
2. **设计**：如果需要把无效数据自动发送到修复队列（一个 Google Sheet），你应该在哪个节点后面接？画出新分支。
3. **改写**：将邮箱正则改为支持中文邮箱（如 `张三@例子.中国`），你的正则该怎么改？
4. **推理**：Merge 节点用 Append 而不是 Combine 模式，为什么？如果用 Combine 会出现什么问题？

---

## 🔴 番茄3：实例5 · CSV格式转换器（上）

### 🎯 场景与目标

**场景**：你收到一份 CSV 格式的销售数据，需要把它转换成 JSON 供 API 调用，同时生成一份 Markdown 表格方便在 Obsidian 中阅读。这就是一条 CSV → JSON → Markdown 的数据处理管道。

**学习重点**：
- CSV 字符串解析为结构化数据
- Split Out 拆分数据行
- Code 节点生成 Markdown 表格
- 数据格式转换的通用思路

### 🏗️ 工作流架构图

```
┌──────────────┐
│ Manual Trigger│
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│ Code: 样本CSV数据     │
│ (10+行销售记录)       │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Code: CSV→JSON解析    │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Split Out: 拆分行     │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Edit Fields (Set)    │
│ 重命名+格式化列       │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Code: 生成Markdown表  │
└──────┬───────────────┘
       │
       ▼
┌──────────────────────┐
│ Write File: 保存.md   │
└──────────────────────┘
```

### 🔑 API/凭证准备

本实例**无需任何 API Key**。Write File 节点写入本地文件系统即可。

---

## 🔴 番茄4：实例5 · CSV格式转换器（下）

### 🔧 逐节点配置

#### 节点1：Manual Trigger

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.manualTrigger` |

#### 节点2：Code — 样本CSV数据

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const csvData = `product_id,product_name,category,price,quantity_sold,sale_date,region
P001,无线蓝牙耳机,电子产品,299.00,156,2026-05-01,华东
P002,纯棉T恤,服装,89.00,342,2026-05-01,华南
P003,不锈钢保温杯,家居,59.90,278,2026-05-02,华北
P004,机械键盘,电子产品,459.00,89,2026-05-02,华东
P005,瑜伽垫,运动,49.90,195,2026-05-03,西南
P006,空气净化器,家电,1299.00,45,2026-05-03,华东
P007,真丝围巾,服装,199.00,123,2026-05-04,华北
P008,智能手表,电子产品,899.00,67,2026-05-04,华南
P009,陶瓷餐具套装,家居,168.00,91,2026-05-05,华东
P010,跑步鞋,运动,399.00,234,2026-05-05,西南
P011,投影仪,电子产品,2499.00,28,2026-05-06,华北
P012,乳胶枕头,家居,129.00,312,2026-05-06,华南`;

return [{ json: { csv: csvData } }];
```

#### 节点3：Code — CSV→JSON解析

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const csvString = $input.first().json.csv;

function parseCSV(csv) {
  const lines = csv.trim().split('\n');
  const headers = lines[0].split(',').map(h => h.trim());

  const rows = [];
  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(',').map(v => v.trim());
    const row = {};
    headers.forEach((header, idx) => {
      row[header] = values[idx] || '';
    });
    rows.push(row);
  }

  return { headers, rows };
}

const { headers, rows } = parseCSV(csvString);

return [{
  json: {
    headers: headers,
    rows: rows,
    totalRows: rows.length,
    parsedAt: new Date().toISOString()
  }
}];
```

**解析后输出结构**：

```json
{
  "headers": ["product_id", "product_name", "category", "price", "quantity_sold", "sale_date", "region"],
  "rows": [
    { "product_id": "P001", "product_name": "无线蓝牙耳机", "category": "电子产品", "price": "299.00", "quantity_sold": "156", "sale_date": "2026-05-01", "region": "华东" },
    ...
  ],
  "totalRows": 12
}
```

#### 节点4：Split Out — 拆分行

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.splitOut` |
| Field to Split Out | `rows` |

> Split Out 将 `rows` 数组拆分为独立的 Item，每个 Item 包含一条销售记录。

#### 节点5：Edit Fields (Set) — 重命名+格式化列

| 配置项 | 值 | 说明 |
|--------|-----|------|
| 节点类型 | `n8n-nodes-base.set` | |
| Mode | Manual Mapping | |

| 操作 | 原字段 | 新字段名 | 新值 | 说明 |
|------|--------|----------|------|------|
| Rename | `product_id` | `id` | — | 缩短字段名 |
| Rename | `product_name` | `name` | — | 缩短字段名 |
| Rename | `quantity_sold` | `soldQty` | — | 缩短字段名 |
| Add | — | `revenue` | `{{ Number($json.price) * Number($json.soldQty) }}` | 计算销售额 |
| Add | — | `priceLevel` | `{{ Number($json.price) >= 500 ? '高价' : Number($json.price) >= 100 ? '中价' : '低价' }}` | 价格分级 |

#### 节点6：Code — 生成Markdown表

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const items = $input.all();

// 定义列：字段名 → 显示名
const columns = [
  { key: 'id', label: '编号' },
  { key: 'name', label: '产品名称' },
  { key: 'category', label: '类别' },
  { key: 'price', label: '单价(元)' },
  { key: 'soldQty', label: '销量' },
  { key: 'revenue', label: '销售额(元)' },
  { key: 'priceLevel', label: '价位' },
  { key: 'sale_date', label: '日期' },
  { key: 'region', label: '区域' },
];

// 构建表头
const headerRow = '| ' + columns.map(c => c.label).join(' | ') + ' |';
const separator = '| ' + columns.map(() => '---').join(' | ') + ' |';

// 构建数据行
const dataRows = items.map(item => {
  const data = item.json;
  return '| ' + columns.map(c => data[c.key] ?? '').join(' | ') + ' |';
});

// 计算汇总
const totalRevenue = items.reduce((sum, item) => sum + Number(item.json.revenue || 0), 0);
const totalSoldQty = items.reduce((sum, item) => sum + Number(item.json.soldQty || 0), 0);

const summarySection = `
## 汇总统计

| 指标 | 数值 |
|------|------|
| 产品总数 | ${items.length} |
| 总销量 | ${totalSoldQty} |
| 总销售额 | ¥${totalRevenue.toFixed(2)} |
| 平均单价 | ¥${(totalRevenue / totalSoldQty).toFixed(2)} |
`;

const markdown = `# 销售数据报表

> 生成时间：${new Date().toLocaleString('zh-CN')}

${headerRow}
${separator}
${dataRows.join('\n')}
${summarySection}
`;

return [{ json: { markdown, totalRows: items.length, totalRevenue } }];
```

#### 节点7：Write File — 保存.md

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.writeBinaryFile` |
| File Name | `sales_report_{{ $now.toFormat('yyyyMMdd') }}.md` |
| Data Property Name | `markdown` |

> **注意**：需要先用一个 Code 节点将 Markdown 字符串转为 binary 格式，或者在 Write File 前添加一段转换代码。简化方案是将节点6的输出直接用表达式写入：

```javascript
// 在节点6末尾添加 binary 转换
const buffer = Buffer.from(markdown, 'utf-8');
return [{
  json: { totalRows: items.length, totalRevenue },
  binary: {
    data: await this.helpers.prepareBinaryData(buffer, `sales_report_${new Date().toISOString().slice(0,10)}.md`, 'text/markdown')
  }
}];
```

### 🧪 测试验证

**预期 Markdown 输出**：

```markdown
# 销售数据报表

> 生成时间：2026/6/8 14:30:00

| 编号 | 产品名称 | 类别 | 单价(元) | 销量 | 销售额(元) | 价位 | 日期 | 区域 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| P001 | 无线蓝牙耳机 | 电子产品 | 299.00 | 156 | 46644 | 中价 | 2026-05-01 | 华东 |
| P002 | 纯棉T恤 | 服装 | 89.00 | 342 | 30438 | 低价 | 2026-05-01 | 华南 |
| P003 | 不锈钢保温杯 | 家居 | 59.90 | 278 | 16652.2 | 低价 | 2026-05-02 | 华北 |
...

## 汇总统计

| 指标 | 数值 |
|------|------|
| 产品总数 | 12 |
| 总销量 | 1960 |
| 总销售额 | ¥... |
```

### 💡 变体与扩展

| 变体 | 说明 | 需要的改动 |
|------|------|-----------|
| **从文件读取CSV** | 用 Read File 节点替代 Code 生成 | 节点2换为 Read File |
| **CSV含逗号** | 处理 `"值,含逗号"` 的引号包裹 | 改进 parseCSV 函数支持引号 |
| **多Sheet合并** | 解析多个CSV后 Merge | 添加多个解析分支 |
| **增量更新** | 只处理新增行 | 加 IF 判断日期是否为新增 |
| **输出到Obsidian** | 直接写入 Vault 目录 | Write File 路径设为 Vault 目录 |

### ✋ 费曼检测

1. **解释**：为什么 Split Out 要放在 parseCSV 之后，而不是直接对原始 CSV 字符串操作？
2. **设计**：如果 CSV 中某个字段含有逗号（如 `"无线耳机,白色"`），当前的 `split(',')` 会出什么问题？你会怎么修复？
3. **推理**：revenue 字段是在 Set 节点中用表达式计算的，如果改在 Code 节点中计算，各有什么优劣？
4. **扩展**：如果要在 Markdown 表格中增加"同比变化"列，需要额外输入什么数据？工作流该怎么改？

---

## 🔴 番茄5：实例6 · 批量文件处理（上）

### 🎯 场景与目标

**场景**：你有大量文件需要批量处理——比如重命名、添加时间戳、压缩等。一次性处理可能内存溢出或超时，所以需要分批处理（每次3个），并在批次之间加入等待时间。这是生产环境中最常见的批量处理模式。

**学习重点**：
- Split In Batches 分批处理
- Wait 节点的限流作用
- 循环回路的连接方式
- 批处理结果的收集与汇总

### 🏗️ 工作流架构图

```
┌──────────────┐
│ Manual Trigger│
└──────┬───────┘
       │
       ▼
┌────────────────────────┐
│ Code: 生成10个模拟文件   │
└──────┬─────────────────┘
       │
       ▼
┌─────────────────────────────┐
│ Split In Batches: 每批3个    │◄─────────────┐
└──────┬──────────────────────┘               │
       │ (每批3个Item)                         │
       ▼                                      │
┌──────────────────────────────┐              │
│ Code: 模拟文件处理            │              │
│ (加时间戳+生成新文件名)       │              │
└──────┬───────────────────────┘              │
       │                                      │
       ▼                                      │
┌────────────────┐                            │
│ Wait: 1秒间隔   │                            │
└──────┬─────────┘                            │
       │                                      │
       └──────────────────────────────────────┘
       │ (Split In Batches 会自动判断：
       │  还有数据→回到自身继续循环
       │  没有数据→走"done"出口)
       │
       ▼ (done出口)
┌────────────────────────┐
│ Code: 收集所有处理结果   │
└──────┬─────────────────┘
       │
       ▼
┌─────────────────────────┐
│ Code: 生成批处理报告     │
└─────────────────────────┘
```

> **关键理解**：Split In Batches 有两个出口——
> - **正常出口**：当前批次的 Item 输出，需连回处理节点形成循环
> - **Done 出口**：所有批次处理完毕后输出，连接下游汇总节点

### 🔑 API/凭证准备

本实例**无需任何 API Key**，纯模拟处理。

---

## 🔴 番茄6：实例6 · 批量文件处理（下）

### 🔧 逐节点配置

#### 节点1：Manual Trigger

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.manualTrigger` |

#### 节点2：Code — 生成10个模拟文件条目

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const fileTypes = ['jpg', 'png', 'pdf', 'docx', 'mp4', 'xlsx', 'gif', 'svg', 'mp3', 'zip'];
const folders = ['photos', 'documents', 'media', 'archives', 'design'];

const files = fileTypes.map((ext, i) => {
  const originalName = `file_${String(i + 1).padStart(3, '0')}.${ext}`;
  const folder = folders[i % folders.length];
  const sizeKB = Math.floor(Math.random() * 5000) + 100; // 100KB ~ 5MB
  const createdAt = new Date(2026, 0, 1 + i * 3).toISOString().split('T')[0];

  return {
    originalName,
    extension: ext,
    folder,
    sizeKB,
    createdAt,
    status: 'pending'
  };
});

return files.map(f => ({ json: f }));
```

**模拟数据示例**：

| originalName | extension | folder | sizeKB | createdAt |
|-------------|-----------|--------|--------|-----------|
| file_001.jpg | jpg | photos | 2340 | 2026-01-01 |
| file_002.png | png | documents | 890 | 2026-01-04 |
| file_003.pdf | pdf | media | 3200 | 2026-01-07 |
| ... | ... | ... | ... | ... |

#### 节点3：Split In Batches — 每批3个

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.splitInBatches` |
| Batch Size | `3` |
| Options - Reset | `false` |

> **连线说明**：
> 1. Code(模拟文件处理) 的输出 → 连回 Split In Batches 的输入
> 2. Wait 的输出 → 连回 Split In Batches 的输入
> 3. Split In Batches 的 **done** 出口 → 连到 Code(收集结果)

这样形成循环：Split In Batches 吐出一批 → 处理 → Wait → 回到 Split In Batches → 吐出下一批 → ... → 全部完成走 done 出口。

#### 节点4：Code — 模拟文件处理

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for Each Item |

```javascript
const data = $input.item.json;

// 生成新文件名：时间戳_原始名
const timestamp = Date.now();
const newName = `${timestamp}_${data.originalName}`;

// 模拟处理：计算压缩后大小（假设压缩30%-70%）
const compressionRatio = 0.3 + Math.random() * 0.4; // 0.3 ~ 0.7
const newSizeKB = Math.round(data.sizeKB * compressionRatio);

// 模拟处理时间（实际中可能是真实压缩/重命名操作）
const processingTimeMs = Math.floor(Math.random() * 500) + 100;

return {
  json: {
    ...data,
    newName,
    originalSizeKB: data.sizeKB,
    newSizeKB,
    compressionRatio: (compressionRatio * 100).toFixed(1) + '%',
    savedKB: data.sizeKB - newSizeKB,
    processedAt: new Date().toISOString(),
    processingTimeMs,
    status: 'processed',
    batchNumber: Math.ceil(($input.item.index + 1) / 3) // 当前批次号
  }
};
```

#### 节点5：Wait — 1秒间隔

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.wait` |
| Wait Amount | `1` |
| Wait Unit | `Seconds` |

> Wait 节点的作用：避免连续处理导致 API 限流或资源过载。生产环境中，如果对接真实文件服务或 API，这步至关重要。

#### 节点6：Code — 收集所有处理结果

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
// Split In Batches done 出口会输出所有已处理的 Item
// 这里我们直接拿到全部结果，进行汇总
const items = $input.all();

// 按批次分组
const batchGroups = {};
items.forEach(item => {
  const batch = item.json.batchNumber || 'unknown';
  if (!batchGroups[batch]) batchGroups[batch] = [];
  batchGroups[batch].push(item.json);
});

return [{
  json: {
    allResults: items.map(i => i.json),
    batchGroups,
    totalFiles: items.length,
    totalBatches: Object.keys(batchGroups).length
  }
}];
```

#### 节点7：Code — 生成批处理报告

| 配置项 | 值 |
|--------|-----|
| 节点类型 | `n8n-nodes-base.code` |
| Language | JavaScript |
| Mode | Run Once for All Items |

```javascript
const data = $input.first().json;
const results = data.allResults;
const batchGroups = data.batchGroups;

// 计算汇总
const totalOriginalKB = results.reduce((s, r) => s + r.originalSizeKB, 0);
const totalNewKB = results.reduce((s, r) => s + r.newSizeKB, 0);
const totalSavedKB = totalOriginalKB - totalNewKB;
const totalProcessingTime = results.reduce((s, r) => s + r.processingTimeMs, 0);

// 按文件类型统计
const typeStats = {};
results.forEach(r => {
  if (!typeStats[r.extension]) {
    typeStats[r.extension] = { count: 0, originalKB: 0, newKB: 0 };
  }
  typeStats[r.extension].count++;
  typeStats[r.extension].originalKB += r.originalSizeKB;
  typeStats[r.extension].newKB += r.newSizeKB;
});

// 构建报告
const report = {
  title: '批量文件处理报告',
  summary: {
    totalFiles: results.length,
    totalBatches: data.totalBatches,
    batchSize: 3,
    totalOriginalSizeKB: totalOriginalKB,
    totalNewSizeKB: totalNewKB,
    totalSavedKB: totalSavedKB,
    compressionRate: ((totalSavedKB / totalOriginalKB) * 100).toFixed(1) + '%',
    totalProcessingTimeMs: totalProcessingTime,
    avgProcessingTimeMs: Math.round(totalProcessingTime / results.length),
    completedAt: new Date().toISOString()
  },
  batchDetails: Object.entries(batchGroups).map(([batch, files]) => ({
    batch: Number(batch),
    fileCount: files.length,
    files: files.map(f => f.newName)
  })),
  typeBreakdown: Object.entries(typeStats).map(([ext, stats]) => ({
    type: ext,
    count: stats.count,
    originalSizeKB: stats.originalSizeKB,
    newSizeKB: stats.newSizeKB,
    savedKB: stats.originalSizeKB - stats.newSizeKB
  }))
};

return [{ json: report }];
```

### 🧪 测试验证

**预期报告输出**：

```json
{
  "title": "批量文件处理报告",
  "summary": {
    "totalFiles": 10,
    "totalBatches": 4,
    "batchSize": 3,
    "totalOriginalSizeKB": 18234,
    "totalNewSizeKB": 9117,
    "totalSavedKB": 9117,
    "compressionRate": "50.0%",
    "totalProcessingTimeMs": 2847,
    "avgProcessingTimeMs": 284,
    "completedAt": "2026-06-08T14:30:00.000Z"
  },
  "batchDetails": [
    { "batch": 1, "fileCount": 3, "files": ["1717852200000_file_001.jpg", "...", "..."] },
    { "batch": 2, "fileCount": 3, "files": ["...", "...", "..."] },
    { "batch": 3, "fileCount": 3, "files": ["...", "...", "..."] },
    { "batch": 4, "fileCount": 1, "files": ["..."] }
  ]
}
```

**关键验证点**：

| 检查项 | 预期 |
|--------|------|
| 总文件数 | 10 |
| 批次数 | 4（3+3+3+1） |
| 最后一批文件数 | 1 |
| 每个文件都有 newName | 是 |
| 所有 status 都是 processed | 是 |

### 💡 变体与扩展

| 变体 | 说明 | 需要的改动 |
|------|------|-----------|
| **真实文件操作** | 读取文件→压缩→重命名→写回 | Code 换为 Read File + Sharp/ImageMagick |
| **动态批大小** | 根据文件总大小动态调整批次 | Code 计算批大小后传入 Split In Batches |
| **错误重试** | 某个文件处理失败时自动重试 | 加 IF 判断 + Loop 回重试（最多3次） |
| **并行处理** | 多个工作流同时处理不同批次 | 用 Execute Workflow 并行调用 |
| **进度通知** | 每批完成发一条进度消息 | Wait 后加 Slack/Email 通知 |

### ✋ 费曼检测

1. **画图**：在纸上画出 Split In Batches 的循环连线。如果忘了把 Wait 输出连回 Split In Batches，会发生什么？
2. **解释**：为什么 Split In Batches 需要一个"done"出口？如果没有这个出口，你怎么知道所有批次都处理完了？
3. **设计**：如果每批处理可能失败，你想加一个"失败重试3次"的逻辑，应该在哪里加？画出修改后的架构图。
4. **推理**：Wait 节点设为1秒，处理10个文件（4批）总共至少要等多少秒？如果你有1000个文件，这个等待时间能接受吗？怎么优化？

---

## 🔴 番茄7：今日复习

### 知识总结表

| 模式 | 核心节点 | 适用场景 | 关键技巧 |
|------|----------|----------|----------|
| **数据清洗** | Code + IF + Set + Merge | 脏数据→干净数据 | 先去重再验证，有效/无效分流后合并 |
| **格式转换** | Code + Split Out + Set | CSV/JSON/MD互转 | 先解析为结构化，再转换为目标格式 |
| **批量处理** | Split In Batches + Wait + Code | 大量数据分批跑 | 循环回路+done出口，批次间加等待 |

### 数据处理模式决策树

```
你的数据处理需求是什么？
│
├─ 清洗/验证数据
│  ├─ 需要去重？ → Code 节点实现去重逻辑
│  ├─ 需要验证？ → Code 正则 + IF 分流
│  └─ 有效/无效都要保留？ → Merge(Append) 合并
│
├─ 格式转换
│  ├─ CSV → JSON？ → Code 解析 + Split Out 拆行
│  ├─ JSON → Markdown？ → Code 拼接字符串
│  └─ 任意格式互转？ → 先→JSON→再→目标格式
│
├─ 批量处理
│  ├─ 数据量大需分批？ → Split In Batches
│  ├─ 需要限流/等待？ → Wait 节点
│  └─ 需要收集汇总？ → Code 在 done 出口汇总
│
└─ 通用技巧
   ├─ 字段增删改 → Edit Fields (Set)
   ├─ 数组拆分 → Split Out
   ├─ 条件分支 → IF / Switch
   └─ 数据合并 → Merge (Append/Combine)
```

### 数据操作表达式速查

| 操作 | 表达式 | 说明 |
|------|--------|------|
| 获取当前Item字段 | `{{ $json.fieldName }}` | 最常用 |
| 获取所有Item | `{{ $input.all() }}` | Code 节点中 |
| 引用上游节点 | `{{ $('节点名').item.json.field }}` | 跨节点引用 |
| 当前时间 | `{{ $now.toISO() }}` | ISO 8601 格式 |
| 格式化日期 | `{{ $now.toFormat('yyyy-MM-dd') }}` | 自定义格式 |
| 条件表达式 | `{{ $json.age >= 18 ? '成人' : '未成年' }}` | 三元运算 |
| 数学运算 | `{{ Number($json.price) * Number($json.qty) }}` | 计算字段 |
| 字符串拼接 | `{{ $json.firstName + ' ' + $json.lastName }}` | 拼接 |
| 数组长度 | `{{ $json.items.length }}` | 获取数组元素数 |
| 安全取值 | `{{ $json.field ?? '默认值' }}` | 空值保护 |

---

### 刻意练习——数据处理管道

**练习目标**：用 3 种不同方式处理同一数据集，熟练掌握数据清洗、格式转换和批量处理

**任务序列（重复×3）：**

```
===== 循环 1：3 种过滤方式 =====
对实例4的脏数据，分别用以下3种方式过滤出有效数据：
1. IF 节点条件分流
2. Code 节点 filter() 方法
3. Code 节点循环判断
验证：三种方式输出的有效数据完全一致

===== 循环 2：3 种格式转换 =====
对实例5的 CSV 数据，做以下3种格式转换：
1. CSV → JSON（已实现）
2. JSON → Markdown 表格（已实现）
3. JSON → HTML 表格
验证：三种格式都正确显示了全部12行销售数据

===== 循环 3：完整 ETL 管道 =====
构建完整 ETL 管道：
Extract：HTTP Request 获取 JSONPlaceholder API（/users）数据
Transform：Code 节点清洗（去重+标准化+重命名字段）
Load：Write File 写入 JSON 文件
验证：输出的文件包含完整处理后的数据
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| IF / Switch 条件路由 | ⬜ | ⬜ | ⬜ |
| 数据格式互转 | ⬜ | ⬜ | ⬜ |
| ETL 管道设计 | ⬜ | ⬜ | ⬜ |
| Code 节点数据清洗 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：数据清洗、格式转换、批量处理——这三种数据处理模式的核心区别是什么？在什么场景下应该选择哪种模式？

---

## 🔴 番茄8：费曼综合检测

### 自检清单

| # | 检测项 | 能做到 | 需复习 |
|---|--------|--------|--------|
| 1 | 能说出数据清洗管道的5个步骤 | ☐ | ☐ |
| 2 | 能写出邮箱和手机号的正则验证 | ☐ | ☐ |
| 3 | 能解释 IF 节点分流后 Merge(Append) 的原理 | ☐ | ☐ |
| 4 | 能手写 CSV 解析为 JSON 的代码 | ☐ | ☐ |
| 5 | 能生成 Markdown 表格（含表头、分隔行、数据行） | ☐ | ☐ |
| 6 | 能画出 Split In Batches 的循环连线图 | ☐ | ☐ |
| 7 | 能解释 Split In Batches 的 done 出口何时触发 | ☐ | ☐ |
| 8 | 能设计一个带错误重试的批量处理流程 | ☐ | ☐ |
| 9 | 能根据需求选择合适的数据处理模式 | ☐ | ☐ |
| 10 | 能独立搭建今天3个工作流中的任意一个 | ☐ | ☐ |

### 费曼总结（用自己的话写）

```markdown
## 今日费曼总结

### 1. 数据清洗管道的核心思路是：
（用一句话描述）


### 2. CSV转Markdown的关键步骤是：
（列出3步）
1.
2.
3.

### 3. Split In Batches 循环的工作原理是：
（解释给不懂编程的朋友听）


### 4. 今天最让我困惑的点：
（记录下来，明天查资料解决）

```

### 学习笔记模板

```markdown
## Day 2 学习笔记

### 实例4：用户数据清洗管道
- 关键收获：
- 踩坑记录：
- 改进想法：

### 实例5：CSV格式转换器
- 关键收获：
- 踩坑记录：
- 改进想法：

### 实例6：批量文件处理
- 关键收获：
- 踩坑记录：
- 改进想法：

### 明日预告
Day 3 将进入 API 集成实战，会用到：
- OpenAI / GLM 的 API Key
- GitHub Personal Access Token
- HTTP Request 节点的高级配置

提前准备好 API Key！
```

---

## 🎉 Day 2 完成！

今天你掌握了 n8n 中三种核心数据处理模式：

1. **清洗管道** — 脏数据进来，干净数据出去，无效数据被标记
2. **格式转换** — 数据在不同格式间自由转换
3. **批量处理** — 大任务分批执行，稳步推进

这三个模式几乎覆盖了日常数据处理 80% 的场景。当你遇到一个新的数据处理需求时，先对照决策树判断属于哪种模式，然后套用对应的工作流架构。

**明天见！** → [[实例Day3-API集成实战]]

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[实例Day1-基础自动化]] - Day 1 实例
> - [[实例Day3-API集成实战]] - Day 3 实例
> - [[Day2-核心节点与触发器]] - 理论 Day 2
> - [[Day4-数据处理与工作流模式]] - 理论 Day 4
