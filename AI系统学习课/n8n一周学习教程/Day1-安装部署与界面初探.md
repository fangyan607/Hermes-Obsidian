# Day 1：安装部署与界面初探

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：把 n8n 跑起来，熟悉界面，完成第一个工作流
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 n8n 是什么 + Docker 安装部署
🍅 番茄3-4：界面导航 + 第一个工作流
🍅 番茄5-6：深入理解数据流 + 自由实践
🍅 番茄7-8：今日复习 + 输出成果
```

---

## 番茄钟1：理解 n8n（25分钟）

### 1.1 用大白话理解 n8n

n8n 就像一个「数字流水线工厂」：

- **原材料** = 数据（邮件、API返回、文件）
- **机器** = 节点（每一台做一件事）
- **传送带** = 连线（数据从一台机器流向下一台）
- **产线** = 工作流（多台机器组成的完整流程）
- **厂长** = 你（设计产线，决定怎么流转）

> 举例：每天早上自动抓新闻 → AI 总结 → 发到 Slack
> 这条产线 = Schedule Trigger → HTTP Request → AI Agent → Slack

### 1.2 n8n vs 其他自动化工具

| 特性 | n8n | Zapier | Make | Power Automate |
|------|-----|--------|------|----------------|
| 开源 | ✅ | ❌ | ❌ | ❌ |
| 自托管 | ✅ 数据在自己手里 | ❌ | ❌ | ❌ |
| 免费额度 | 无限（自托管） | 100次/月 | 1000次/月 | 有限 |
| 代码节点 | ✅ JS/Python | ❌ | ✅ 有限 | ❌ |
| AI 原生集成 | ✅ | ✅ | ⚠️ | ⚠️ |
| 节点数 | 400+ | 6000+ | 1500+ | 800+ |
| 数据安全 | 本地可控 | 云端 | 云端 | 云端 |

**选择建议**：
- 数据敏感 / 需要自定义代码 → **n8n**
- 快速上手 / 不想折腾部署 → **Zapier**
- 视觉化复杂流程 → **Make**

### 1.3 n8n 能做什么？

```
个人自动化                    企业自动化
├── 每日新闻摘要推送到手机      ├── CRM 数据自动同步
├── 邮件自动分类归档            ├── 客户工单自动分发
├── Obsidian 笔记自动采集      ├── 审批流程自动化
├── 社交媒体自动发帖            ├── 数据 ETL 管道
└── AI 对话助手                └── AI 智能客服
```

> ✋ **费曼自测**：用你自己的话，向一个不懂技术的人解释 n8n 是什么，它能解决什么问题。

---

## 番茄钟2：Docker 安装部署（25分钟）

### 2.1 为什么用 Docker？

类比：Docker 就像「集装箱」——把 n8n 和它需要的所有依赖打包在一起，不管在哪台电脑上都能直接运行，不会出现"在我电脑上能跑"的问题。

### 2.2 安装 Docker Desktop

**Windows**：
1. 下载 [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. 安装后重启电脑
3. 打开 Docker Desktop，等待启动完成（左下角显示绿色 Running）

**验证安装**：
```bash
docker --version
# 输出: Docker version 24.x.x

docker-compose --version
# 输出: Docker Compose version v2.x.x
```

### 2.3 创建 docker-compose.yml

在你喜欢的位置创建一个文件夹（如 `D:\n8n\`），在里面创建 `docker-compose.yml`：

```yaml
version: "3.8"

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - N8N_EDITOR_BASE_URL=http://localhost:5678
      - GENERIC_TIMEZONE=Asia/Shanghai
      - TZ=Asia/Shanghai
    volumes:
      - n8n_data:/home/node/.n8n
      - ./local-files:/files

volumes:
  n8n_data:
```

**关键参数解释**：

| 参数 | 含义 | 为什么这样设置 |
|------|------|---------------|
| `image: n8nio/n8n:latest` | 使用最新版 n8n 镜像 | 保持最新功能 |
| `ports: "5678:5678"` | 把容器内 5678 映射到主机 5678 | 浏览器访问 localhost:5678 |
| `volumes: n8n_data` | 数据持久化 | 重启容器数据不丢失 |
| `volumes: ./local-files:/files` | 本地文件映射 | n8n 可以读写本机文件 |
| `GENERIC_TIMEZONE=Asia/Shanghai` | 设置时区 | 定时任务按北京时间执行 |

### 2.4 启动 n8n

```bash
# 进入 docker-compose.yml 所在目录
cd D:\n8n

# 启动（后台运行）
docker-compose up -d

# 查看运行状态
docker-compose ps

# 查看日志
docker-compose logs -f n8n
```

**首次启动会自动下载镜像，大约 1-3 分钟。** 看到以下日志说明启动成功：

```
n8n is now ready for your first workflow
Editor is now accessible via: http://localhost:5678/
```

### 2.5 访问 n8n

打开浏览器，访问 `http://localhost:5678`

首次访问会要求：
1. 设置管理员邮箱和密码
2. 进入主界面

> ⚠️ 如果端口 5678 被占用，修改 `docker-compose.yml` 中的端口，如 `"5679:5678"`，然后访问 `localhost:5679`

> ✋ **费曼自测**：docker-compose.yml 中 `volumes` 那行是做什么的？如果不配置会怎样？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] n8n 是开源工作流自动化平台，核心是「节点+连线」
- [ ] Docker 是运行 n8n 的推荐方式
- [ ] 数据持久化靠 volumes，没有它重启数据会丢
- [ ] n8n 默认端口 5678

---

## 番茄钟3：界面导航（25分钟）

### 3.1 五大功能区域

```
┌─────────────────────────────────────────────────────────┐
│  ① 左侧边栏       │  ② 顶部工具栏                       │
│  ┌────────────┐   │  ┌───────────────────────────────┐  │
│  │ Workflows   │   │  │ 工作流名称  │ Save │ Execute  │  │
│  │ Executions  │   │  └───────────────────────────────┘  │
│  │ Credentials │   │                                     │
│  │ Settings    │   │  ③ 主画布区域                       │
│  └────────────┘   │  ┌───────────────────────────────┐  │
│                   │  │                               │  │
│                   │  │   拖拽节点 + 连线编排区域       │  │
│                   │  │                               │  │
│                   │  └───────────────────────────────┘  │
│                   │                                     │
│                   │  ④ 节点配置面板（点击节点弹出）      │
│                   │  ┌───────────────────────────────┐  │
│                   │  │ Parameters │ Settings │ Output │  │
│                   │  └───────────────────────────────┘  │
│                   │                                     │
│  ⑤ 添加节点按钮    │                                     │
│  ┌────────────┐   │                                     │
│  │    + Add    │   │                                     │
│  └────────────┘   │                                     │
└─────────────────────────────────────────────────────────┘
```

### 3.2 左侧边栏四个入口

| 菜单 | 功能 | 类比 |
|------|------|------|
| **Workflows** | 所有工作流列表 | 你的「产线清单」 |
| **Executions** | 执行历史记录 | 「生产日志」 |
| **Credentials** | API 密钥管理 | 「钥匙柜」 |
| **Settings** | 系统设置 | 「工厂配置」 |

### 3.3 画布基本操作

| 操作 | 方法 |
|------|------|
| 添加节点 | 点击画布 `+` 或双击画布 |
| 连接节点 | 从节点右侧圆点拖到下一个节点左侧圆点 |
| 删除节点 | 选中节点 → 按 Delete 键 |
| 复制节点 | Ctrl+C → Ctrl+V |
| 缩放画布 | 鼠标滚轮 |
| 拖动画布 | 按住空白区域拖动 |
| 查看节点输出 | 点击节点 → Output 标签页 |

> ✋ **费曼自测**：不看上图，你能说出 n8n 界面的五个核心区域分别是什么吗？

---

## 番茄钟4：创建第一个工作流（25分钟）

### 4.1 目标

创建一个手动触发 → 设置数据 → 输出 "Hello n8n!" 的工作流。

```
Manual Trigger → Edit Fields (Set) → 输出结果
```

### 4.2 步骤详解

**第一步：创建空白工作流**

1. 点击左侧 **Workflows**
2. 点击右上角 **Add Workflow** 按钮
3. 双击工作流名称，改为 `My First Workflow`

**第二步：添加 Manual Trigger**

1. 点击画布中央的 `+` 按钮
2. 在搜索框输入 `Manual Trigger`
3. 点击选中该节点
4. 无需配置，保持默认

**第三步：添加 Edit Fields (Set) 节点**

1. 点击 Manual Trigger 右侧的 `+` 按钮
2. 搜索 `Edit Fields`，选择 **Edit Fields (Set)**
3. 配置：
   - Mode: **Manual Mapping**
   - 点击 **Add Value** → 选择 **String**
   - Name: `greeting`
   - Value: `Hello n8n! 🎉`
4. 点击 **Back to canvas**

**第四步：执行工作流**

1. 点击右上角 **Execute Workflow** 按钮
2. 观察每个节点变成绿色 ✅
3. 点击 Set 节点 → 查看 **Output** 标签页

你应该看到：

```json
{
  "greeting": "Hello n8n! 🎉"
}
```

🎉 **恭喜！你已经完成了第一个 n8n 工作流！**

### 4.3 保存工作流

点击右上角 **Save** 按钮（或 Ctrl+S）。

### 4.4 添加更多字段

回到 Set 节点，再添加几个字段：

| Name | Value | 类型 |
|------|-------|------|
| `greeting` | `Hello n8n! 🎉` | String |
| `today` | `{{ $now.toFormat('yyyy-MM-dd') }}` | String |
| `randomNumber` | `{{ Math.floor(Math.random() * 100) }}` | Number |

> 💡 注意：以 `{{ }}` 包裹的是 **n8n 表达式**，运行时会被计算为实际值。这是 n8n 最强大的特性之一，Day 3 会深入讲解。

> ✋ **费曼自测**：不看步骤，从头创建一个新的工作流，让它输出你的名字和今天的日期。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] n8n 在浏览器中可以正常访问
- [ ] 知道怎么添加、连接、删除节点
- [ ] 第一个工作流执行成功
- [ ] 理解 `{{ }}` 表达式的作用

---

## 番茄钟5：理解 n8n 的数据流（25分钟）

### 5.1 用大白话理解数据流

数据在 n8n 中就像「传送带上的包裹」：

```
📦 包裹结构:
{
  "json": { ... },     ← 标签信息（文字数据）
  "binary": { ... }    ← 实物（文件、图片）
}
```

- 每个节点处理包裹，然后传给下一个节点
- 一条传送带上可以有多个包裹（多个 Item）
- 节点之间传递的是**整条传送带**

### 5.2 Item 的概念

n8n 中数据以 **Item** 为基本单位流转：

**单个 Item**：
```json
{
  "json": {
    "name": "张三",
    "age": 25
  }
}
```

**多个 Items**（数组）：
```json
[
  { "json": { "name": "张三", "age": 25 } },
  { "json": { "name": "李四", "age": 30 } }
]
```

**重要规则**：
- 大多数节点对**每个 Item 分别执行一次**
- 如果有 10 个 Item，HTTP Request 会发 10 次请求
- 可以用 Split In Batches 控制每次处理多少个

### 5.3 用实际操作验证

创建一个新工作流来观察数据流：

```
Manual Trigger → Code (生成3个Item) → Set (添加新字段)
```

**Code 节点代码**：
```javascript
return [
  { json: { name: "张三", score: 85 } },
  { json: { name: "李四", score: 62 } },
  { json: { name: "王五", score: 45 } }
];
```

**Set 节点**（添加新字段）：
- Name: `passed`
- Value: `={{ $json.score >= 60 ? "✅ 及格" : "❌ 不及格" }}`

执行后，你会看到 3 个 Item 各自被处理：

```json
[
  { "name": "张三", "score": 85, "passed": "✅ 及格" },
  { "name": "李四", "score": 62, "passed": "✅ 及格" },
  { "name": "王五", "score": 45, "passed": "❌ 不及格" }
]
```

> ✋ **费曼自测**：如果有 5 个 Item 经过一个 HTTP Request 节点，会发几次请求？为什么？

---

## 番茄钟6：自由实践——改造你的工作流（25分钟）

### 6.1 练习1：创建一个「自我介绍生成器」

```
Manual Trigger → Set (填写个人信息) → Code (生成介绍文案)
```

**Set 节点**：

| Name | Value |
|------|-------|
| `name` | 你的名字 |
| `role` | 你的职业 |
| `hobby` | 你的爱好 |

**Code 节点**：
```javascript
const { name, role, hobby } = $input.item.json;
return {
  json: {
    introduction: `大家好，我是${name}，一名${role}。工作之余，我喜欢${hobby}。很高兴认识大家！`,
    shortBio: `${name} | ${role} | 热爱${hobby}`
  }
};
```

### 6.2 练习2：创建一个「倒计时计算器」

```
Manual Trigger → Set (目标日期) → Code (计算倒计时)
```

**Code 节点**：
```javascript
const targetDate = new Date($input.item.json.targetDate);
const now = new Date();
const diffMs = targetDate - now;
const diffDays = Math.ceil(diffMs / (1000 * 60 * 60 * 24));

return {
  json: {
    targetDate: $input.item.json.targetDate,
    daysRemaining: diffDays,
    message: diffDays > 0
      ? `距离目标还有 ${diffDays} 天 🎯`
      : `目标日期已过 ${Math.abs(diffDays)} 天 ⏰`
  }
};
```

### 6.3 练习3（挑战）：尝试使用 Schedule Trigger

将 Manual Trigger 替换为 **Schedule Trigger**，让工作流每小时自动执行一次。

**配置**：
- Trigger Rule: `Every Hour`
- 在 Set 节点中使用 `{{ $now }}` 显示当前时间

> ✋ **费曼自测**：你能不看教程，从零创建一个工作流并成功执行吗？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 理解 Item 是 n8n 数据的基本单位
- [ ] 理解多个 Item 会被节点分别处理
- [ ] 能独立创建包含 Code 节点的工作流
- [ ] 能使用 `{{ }}` 表达式

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

| 概念 | 一句话解释 | 类比 |
|------|-----------|------|
| n8n | 开源工作流自动化平台 | 数字流水线工厂 |
| 工作流 (Workflow) | 一系列节点的有序组合 | 一条产线 |
| 节点 (Node) | 执行一个操作的单元 | 一台机器 |
| 触发器 (Trigger) | 启动工作流的入口 | 门铃 / 开关 |
| Item | 数据的基本单位 | 传送带上的包裹 |
| 表达式 (Expression) | `{{ }}` 包裹的动态值 | Excel 公式 |
| 凭证 (Credential) | API 密钥等认证信息 | 酒店房卡 |

### 7.2 命令速查卡

```bash
# Docker 操作
docker-compose up -d        # 启动 n8n（后台）
docker-compose down          # 停止 n8n
docker-compose restart       # 重启 n8n
docker-compose logs -f n8n   # 查看实时日志
docker-compose ps            # 查看运行状态

# 更新 n8n
docker-compose pull          # 拉取最新镜像
docker-compose up -d         # 用最新镜像重启
```

### 7.3 画布操作速查

| 操作 | 快捷键 / 方法 |
|------|---------------|
| 添加节点 | 双击画布 / 点击 `+` |
| 连接节点 | 从右侧圆点拖到左侧圆点 |
| 删除节点 | 选中 → Delete |
| 复制节点 | Ctrl+C → Ctrl+V |
| 撤销 | Ctrl+Z |
| 保存工作流 | Ctrl+S |
| 执行工作流 | 点击 Execute Workflow |
| 单步执行 | 点击节点 → Execute Step |

> ✋ **费曼自测**：把上面的表格遮住，你能回忆出每个概念的一句话解释吗？

---

## 番茄钟8：输出成果（25分钟）

### 刻意练习——界面导航与第一个工作流

**练习目标**：在20分钟内完成3轮从零创建工作流的循环，每轮熟练度逐步提升

**任务序列（重复×3）：**

```
===== 循环 1：用不同方式启动 n8n =====
1. 先 docker-compose down 停止 n8n
2. 再 docker-compose up -d 重新启动
3. 访问 localhost:5678 确认正常运行
4. 对比两次启动日志的差异
验证：浏览器正常显示 n8n 编辑器界面

===== 循环 2：创建3种不同类型的节点 =====
1. 创建新工作流，添加 Manual Trigger 节点
2. 添加 Edit Fields (Set) 节点，配置输出字段
3. 添加 Code 节点，写一段简单的 JS 代码
4. 将三个节点连接形成完整链条
验证：3个节点正确连接，执行后全部变绿

===== 循环 3：完成一个完整工作流 =====
1. 从零创建新工作流（不使用之前的）
2. 结构：Manual Trigger → Code → Set
3. Code 节点生成3个带不同字段的 item
4. Set 节点为每个 item 添加新字段
5. 执行并检查每个节点的输出数据
验证：看到3个 item 被成功处理，每个都有新增字段
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| n8n 启动与访问 | ⬜ | ⬜ | ⬜ |
| 节点添加与连接 | ⬜ | ⬜ | ⬜ |
| 完整工作流构建 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：三轮循环下来，创建第一个工作流的时间是否越来越短？哪些步骤已经可以凭肌肉记忆完成？

### 8.1 今日自检清单

完成以下所有项才算通过 Day 1：

- [ ] ✅ n8n 通过 Docker 成功启动并可在浏览器访问
- [ ] ✅ 能说出 n8n 界面五个核心区域的功能
- [ ] ✅ 能独立添加节点、连接节点、执行工作流
- [ ] ✅ 第一个工作流输出 "Hello n8n!" 成功
- [ ] ✅ 理解 Item 是数据的基本单位
- [ ] ✅ 知道 `{{ }}` 表达式的作用
- [ ] ✅ 能使用 Code 节点处理数据
- [ ] ✅ Docker 的 volumes 作用是什么

### 8.2 费曼一句话总结

> **n8n 是一个开源的工作流自动化平台，通过拖拽节点+连线让数据自动流转。每个节点做一件事，数据以 Item 为单位在节点间传递，就像传送带上的包裹经过每台机器。**

### 8.3 学习笔记

```markdown
## Day 1 学习笔记

### 今天最大的收获
（用你自己的话写）

### 还没搞懂的地方
（记录费曼自测中答不上来的问题）

### 明天想深入的方向
（为 Day 2 做准备）
```

---

## 🎉 Day 1 完成！

**今日成果：**
- ✅ n8n 通过 Docker 成功运行
- ✅ 熟悉了界面五大区域
- ✅ 完成了第一个工作流
- ✅ 理解了 Item、表达式等核心概念
- ✅ 完成了 3 个实践练习

**明天预告：** [[Day2-核心节点与触发器]] - 深入学习 8 大核心节点和 5 种触发器

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day2-核心节点与触发器]] - 下一天
> - [[LLM-Wiki/Projects/n8n+GLM-OCR工作流]] - 已有的 n8n 工作流参考
