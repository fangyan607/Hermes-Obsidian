# Obsidian 从零搭建项目管理（保姆级教程，个人/小团队通用）

# Obsidian 从零搭建项目管理（保姆级教程，个人 / 小团队通用）

## 一、先搭库结构（PARA 规范，不乱文件夹）

### 1\. 固定文件夹结构（直接照抄新建）

```Plain Text
📁 你的知识库根目录
├─ 📁 00_仪表盘（总项目看板、全局任务）
├─ 📁 01_Projects（所有在进行的项目，核心文件夹）
│  ├─ 📁 项目A（网站开发）
│  │  ├─ 📄 项目总览.md（项目首页）
│  │  ├─ 📁 任务清单
│  │  ├─ 📁 会议纪要
│  │  ├─ 📁 资料文档
│  │  └─ 📁 复盘归档
│  ├─ 📁 项目B（毕业设计）
├─ 📁 02_Areas（长期领域：工作、学习、副业）
├─ 📁 03_Resources（素材、模板、工具文档）
│  └─ 📁 Templates（项目模板文件夹）
└─ 📁 04_Archive（已结束项目归档）
```

### 2\. 标签规范（统一筛选用）

- 状态：`#状态/待启动` `#状态/进行中` `#状态/已完成` `#状态/延期`

- 优先级：`#P1紧急` `#P2重要` `#P3常规`

- 任务类型：`#任务/开发` `#任务/调研` `#任务/文档`

## 二、必装核心插件（3 套方案：新手 / 进阶 / 专业）

### ✅ 新手极简方案（零代码，5 分钟上手）

1. **Tasks**：带日期、优先级的待办任务，全局汇总任务

2. **Kanban**：拖拽式看板，复刻 Trello

3. **Templater**：一键新建标准化项目文档

4. **Homepage**：打开库直接进入项目总仪表盘

### ✅ 进阶通用方案（最推荐，个人项目首选）

在新手基础上加装：

1. **Dataview**：自动汇总所有项目、任务成动态表格 / 日历

2. **QuickAdd**：一键新建项目、新建任务，不用手动选文件夹

3. **Periodic Notes\+Calendar**：每日 / 每周项目进度复盘

### ✅ 专业项目方案（甘特图、多视图管理）

安装 **Obsidian Projects** 插件

- 支持：看板、表格、日历、画廊 4 种视图

- 自定义字段、任务依赖、里程碑、批量修改任务状态

## 三、第一步：制作【项目标准模板】（统一格式，避免混乱）

进入 `03_Resources/Templates`，新建「项目模板\.md」

### 模板内容（直接复制）

```yaml
---
# YAML元数据（Dataview自动读取）
project_name: "{{tp.file.title}}"
status: 待启动 #待启动/进行中/已暂停/已完结
priority: P2
start_date: {{tp.date.now("YYYY-MM-DD")}}
due_date: 
manager: 自己
tags: ["#项目"]
---

# {{project_name}}｜项目总览
## 1. 项目基本信息
- 项目目标：
- 交付物：
- 起止时间：{{start_date}} ~ {{due_date}}
- 核心里程碑：

## 2. 任务总看板
```kanban
## 待开始
```

## 进行中

```Plain Text
## 已完成
```

## 延期

```Plain Text
## 3. 关键链接
- 任务文件夹：[[{{project_name}}/任务清单]]
- 会议记录：[[{{project_name}}/会议纪要]]
- 相关资料：

## 4. 项目进度复盘
### 本周进展
### 风险与问题
### 下周计划

## 5. 全局任务汇总（自动更新）
```dataview
TASK
FROM "01_Projects/{{project_name}}/任务清单"
WHERE !completed
SORT priority DESC,due ASC
```

```Plain Text
### 配置Templater调用模板
设置 → Templater → Template folder location：选择 `03_Resources/Templates`
以后新建项目，直接右键「使用模板新建」，一键生成完整项目框架。

## 四、两种主流项目管理实操方式
### 方式1：Kanban看板管理（最直观，敏捷任务流）
1. 在项目总览页插入看板代码块，分为4列：待开始→进行中→已完成→延期
2. 新建任务笔记，放在「任务清单」文件夹，任务页YAML：
```yaml
---
task_name: 
status: 待开始
priority: P1/P2/P3
due: 2026-08-01
belong_project: "[[网站开发]]"
tags: ["#任务","#任务/开发"]
---
- [ ] {{task_name}} 📅 {{due}}
任务详情、需求描述、验收标准
```

3. 看板绑定当前项目文件夹，拖拽卡片即可修改任务状态，所有数据自动同步到 Dataview 表格。

### 方式 2：Dataview 全局项目仪表盘（多项目统一管控）

在 `00_仪表盘/全局项目总览.md` 粘贴以下代码，自动汇总所有项目、过期任务、高优先级任务：

#### 1\. 所有项目总表

```dataview
TABLE status AS 项目状态,priority AS 优先级,start_date AS 开始时间,due_date AS 截止时间
FROM "01_Projects" AND #项目
SORT status DESC,due_date ASC
```

#### 2\. 所有未完成任务汇总

```dataview
TASK
FROM "01_Projects"
WHERE !completed
SORT priority DESC,due ASC
```

#### 3\. 本周到期任务预警

```dataview
TASK
FROM "01_Projects"
WHERE due >= date(today) AND due <= date(today)+7
AND !completed
```

## 五、项目全流程工作流（标准执行步骤）

1. **立项阶段**：用模板新建项目总览，填写目标、起止时间、里程碑

2. **拆解阶段**：拆分子任务，每个任务新建独立笔记，标注优先级、截止时间、负责人

3. **执行阶段**：看板拖拽更新任务状态，每日在周期笔记记录项目进展，关联项目双向链接

4. **复盘阶段**：项目结束后填写复盘内容，将整个项目文件夹移动到 `04_Archive` 归档

5. **复盘复用**：通过 Dataview 查询归档项目，沉淀项目经验模板

## 六、进阶实用技巧

### 1\. Mermaid 甘特图（不用插件，做项目时间规划）

直接在项目总览插入甘特图代码块：

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title 网站开发项目甘特图
    section 需求阶段
    需求调研       :done,des1,2026-07-01,3d
    方案评审       :done,des2,after des1,2d
    section 开发阶段
    前端开发       :active,dev1,after des2,7d
    后端接口       :dev2,after des2,10d
    section 上线阶段
    测试部署       :test1,after dev1 dev2,3d```

### 2\. 任务依赖管理

在任务正文用双向链接绑定前置任务：`依赖任务：[[前端页面开发]]`，避免串行任务遗漏。

### 3\. 多项目风险管控

用 Dataview 筛选所有延期、P1 紧急任务，每天打开仪表盘快速排查风险。

## 七、避坑要点

1. 不要建超过 3 层文件夹，层级越深越难用

2. 所有任务、项目必须统一 YAML 字段，否则 Dataview 无法聚合

3. 已完结项目统一归档，不要留在 Projects 文件夹造成仪表盘冗余

4. 优先从「简单看板 \+ Dataview 表格」起步，不要一开始堆砌十几款插件

需要我直接把**项目仪表盘 \+ 项目模板 \+ 甘特图 \+ 任务汇总**全套可复制代码打包给你吗？

```Plain Text

```

> （注：部分内容可能由 AI 生成）
