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

## 八、终极方案：本地Obsidian ↔ GitHub ↔ 腾讯云服务器 双向自动同步

本方案实现：**本地电脑修改笔记自动同步GitHub \+ 腾讯云服务器实时拉取更新**，云端常驻备份、异地容灾、可远程访问库文件，完美适配项目管理知识库，全程免费、稳定、无会员。

### 整体同步逻辑

本地Obsidian（写入）→ Obsidian\-Git插件自动提交推送 → GitHub私有仓库（中转备份）→ 腾讯云服务器定时拉取更新（云端常驻副本），支持双向修复，文件版本完全一致。

### 前置准备（缺一不可）

1. 本地电脑安装 **Git**（官网直接下载安装，默认配置即可）

2. Obsidian 关闭安全模式，安装核心插件：**Obsidian Git**

3. GitHub 新建 **私有仓库（Private）**，空仓库、无需初始化README

4. 腾讯云轻量/云服务器一台，系统推荐CentOS7/8、Ubuntu20\.04\+

### 第一步：本地Obsidian绑定GitHub（自动推送）

#### 1\. 仓库初始化（本地库关联GitHub）

打开你的Obsidian项目库根目录，右键打开终端，依次执行以下命令：

```bash
# 初始化本地Git仓库
git init
# 配置用户名邮箱（替换为自己GitHub账号）
git config user.name "你的GitHub用户名"
git config user.email "你的GitHub邮箱"
# 创建忽略文件（过滤缓存、配置垃圾，避免同步冗余）
cat > .gitignore << EOF
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.trash/
.obsidian/cache/
.DS_Store
EOF
# 首次全部提交
git add .
git commit -m "Obsidian项目库初始化同步"
# 关联远程GitHub仓库（替换为你的仓库SSH地址）
git remote add origin git@github.com:用户名/仓库名.git
# 首次推送
git push -u origin main
```

#### 2\. 配置SSH免密登录（关键，避免每次输密码）

1. 本地终端生成密钥：`ssh-keygen` 全程回车默认

2. 打开公钥文件，复制全部内容：`~/.ssh/id_rsa.pub`

3. GitHub → 设置 → SSH and GPG keys → 新增SSH密钥，粘贴保存

#### 3\. Obsidian Git插件自动同步配置

打开插件设置，开启以下核心功能：

- Auto commit（自动提交）：开启，间隔3分钟

- Auto push（自动推送）：开启

- Auto pull（启动拉取）：开启，打开库自动同步云端更新

- Commit message 自定义：`自动同步：{{date}} {{time}} 项目库更新`

配置完成后：本地每一次保存笔记，都会自动提交并推送到GitHub。

### 第二步：腾讯云服务器配置（实时同步GitHub库）

#### 1\. 服务器基础环境安装

SSH连接腾讯云服务器，执行命令安装Git：

```bash
# Ubuntu/Debian
apt update && apt install git -y
# CentOS
yum install git -y
```

#### 2\. 服务器配置GitHub免密SSH

操作和本地一致，服务器生成SSH密钥，公钥添加到自己GitHub账号，实现免密拉取。

#### 3\. 服务器克隆Obsidian库

```bash
# 新建存放目录
mkdir -p /opt/obsidian-vault
cd /opt/obsidian-vault
# 克隆你的GitHub私有仓库
git clone git@github.com:用户名/仓库名.git .
```

### 第三步：设置服务器**全自动定时同步**（核心）

通过定时任务，让服务器每隔5分钟自动拉取GitHub最新笔记，和本地完全同步。

#### 1\. 新建同步脚本

```bash
cat > /opt/obsidian-sync.sh << EOF
#!/bin/bash
cd /opt/obsidian-vault
git fetch --all
git reset --hard origin/main
git pull origin main
EOF
```

#### 2\. 赋予执行权限

```bash
chmod +x /opt/obsidian-sync.sh
```

#### 3\. 设置crontab定时任务

```bash
# 打开定时任务编辑
crontab -e
# 粘贴以下内容（每5分钟同步一次）
/5    * /opt/obsidian-sync.sh >> /opt/sync-log.txt 2>&1
```

保存退出，服务器即刻开启全自动同步，永久生效。

### 四、双向同步冲突解决（必看）

日常使用仅需遵循：**本地为主、云端为辅**

- 仅在本地Obsidian编辑笔记，服务器只做备份同步，不会产生冲突

- 若更换电脑，打开库后Obsidian Git会自动拉取云端最新版本

- 出现冲突时：本地执行 `git pull` 合并即可，版本以最新修改为准

### 五、方案优势（适配项目管理）

1. **三重备份**：本地电脑 \+ GitHub云端仓库 \+ 腾讯云服务器，杜绝项目笔记丢失

2. **全自动无感同步**：无需手动上传下载，改完即同步

3. **版本回溯**：Git保留所有修改记录，可随时恢复任意历史项目版本

4. **云端常驻**：腾讯云7×24小时留存库文件，可远程查看、备份、迁移

### 六、避坑要点

- 仓库必须设置为**私有**，项目资料、工作文档禁止公开

- 严格配置\.gitignore，不要同步缓存、工作区文件，避免库臃肿报错

- 本地和服务器均使用SSH方式关联仓库，不要用HTTPS，避免频繁输密码

- 服务器不要直接编辑库文件，防止双向冲突，统一本地编辑

需要我直接把**可一键复制的同步脚本\+gitignore文件内容**打包给你吗？

```Plain Text

```

> （注：部分内容可能由 AI 生成）
