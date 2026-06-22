---
created: 2026-06-19
module: D
total_pomodoros: 5
tags:
  - Vercel
  - Lovable
  - AI
  - 全栈
  - Supabase
  - 教程
---

# 模块D：Lovable 全栈 AI 开发与 Vercel 联动（5🍅）

> 目标：掌握 Lovable——AI 全栈应用构建器，学会从想法到全栈应用再到 Vercel 部署的完整链路

---

## 🍅21 Lovable 平台入门（25分钟）

### 费曼输入

**Lovable** 是 2026 年最热门的 AI 全栈应用构建器（前身是开源项目 GPT Engineer，GitHub 50,000+ ⭐）。它由 Anton Osika 和 Fabian Hedin 于 2023 年在斯德哥尔摩创立，到 2026 年已拥有约 800 万用户、$206M ARR、$6.6B 估值（Nvidia 和 Salesforce 投资）。

**Lovable 的定位**："用自然语言构建完整应用"——不仅是 UI，而是**包含数据库、认证、API 的完整全栈应用**。

**三大工作模式**：

| 模式 | 用途 | 耗费额度 | 适用场景 |
|:----|:-----|:--------:|:--------|
| **Agent 模式** 🤖 | AI 自主规划、开发、调试 | 消耗额度 | 复杂需求、多步骤开发 |
| **Chat 模式** 💬 | 协作式对话迭代 | 消耗额度 | 逐步精炼功能 |
| **Visual 编辑** 🎨 | 点击直接修改 UI | **免费** | 微调样式、改文案、调布局 |

**技术栈**：
- 前端：React + TypeScript + Vite + Tailwind CSS + shadcn/ui
- 后端：原生 Supabase 集成（PostgreSQL + Auth + Storage + RLS）
- 支付：原生 Stripe 集成

### 刻意练习

```bash
# 1. 访问 lovable.dev 注册
# 使用 GitHub 账号登录

# 2. 了解 Dashboard
#    - My Projects：项目列表
#    - Templates：模板库（电商、SaaS、博客等）
#    - Settings：账号设置

# 3. 从模板创建第一个项目
#    - 点击 "New Project"
#    - 选择一个模板（或 "Blank Project"）
#    - 给项目起名字
#    - 等待 AI 构建完成（约 1-3 分钟）

# 4. 了解 Lovable 编辑器布局
#    - 左侧：Chat/Agent 对话面板
#    - 中间：实时预览（自动刷新）
#    - 右侧：组件树/文件面板
#    - 顶部：模式切换（Agent/Chat/Visual）
```

**定价（2026）**：

| 套餐 | 价格 | 核心权益 |
|:----|:----|:--------|
| Free | $0/月 | 每日 5 额度（约 30/月），仅公开项目 |
| Pro | ~$25/月 | 100 额度/月，自定义域名，去水印 |
| Business | ~$50/月 | SSO，私有项目，数据不出训练 |
| Enterprise | 定制 | 审计日志，SCIM，高级安全 |

### ✅ 完成标准

- [ ] 注册 Lovable 账号并通过 GitHub 登录
- [ ] 从模板创建一个项目
- [ ] 了解三种工作模式的区别
- [ ] 了解 Lovable 的技术栈和定价

### 📖 费曼三句话

1. Lovable 是 AI 时代的"全栈工程师"——你说要什么应用，它帮你把前后端+数据库全干了
2. 和 v0 的区别：v0 生成 UI 组件，Lovable 生成完整的全栈应用（含数据库和认证）
3. Visual 编辑是免费的，适合非技术人员微调 UI

---

## 🍅22 用 Lovable 构建全栈应用（25分钟）

### 费曼输入

Lovable 的核心能力是将自然语言描述转化为完整的全栈应用。与 v0 只生成前端不同，Lovable 的后端使用 **Supabase**（内置 PostgreSQL 数据库、用户认证、文件存储、行级安全策略 RLS）。

**一条提示词生成一个全栈应用的示例**：

> "创建一个团队任务管理应用。用户可以注册登录，创建项目，在项目中添加任务并分配给团队成员。每个任务有标题、描述、截止日期、优先级（高/中/低）和状态（待办/进行中/完成）。项目创建者可以邀请成员。"
>
> Lovable 生成：
> - ✅ 用户注册/登录页面（Supabase Auth）
> - ✅ 项目 CRUD 页面
> - ✅ 任务 CRUD 页面
> - ✅ 数据库表（projects, tasks, profiles, project_members）
> - ✅ RLS 安全策略
> - ✅ 邀请成员功能

**关键概念**：Supabase 集成

Lovable 自动创建和管理 Supabase 项目：
- 每个 Lovable 项目关联一个 Supabase 项目
- 自动建表、自动生成 RLS 策略
- 数据直接在 Lovable 的 "Data" 面板中可视化管理
- 可在 Supabase Dashboard 中高级管理

### 刻意练习

```markdown
# 练习1：构建个人博客应用
# 在 Lovable 的 Agent 模式下输入：

"创建一个个人博客应用，包含：
1. 首页：显示文章列表（标题+摘要+日期+封面图）
2. 文章详情页：完整文章内容 + 评论区
3. 管理后台：富文本编辑器写文章、管理评论
4. 用户系统：读者用邮箱登录后可评论，管理员单独账号
5. 标签系统：文章可以打标签，按标签筛选
6. 响应式设计：手机和电脑都能看"

# 练习2：添加功能
"给博客添加 newsletter 订阅功能，
在首页底部加一个输入邮箱的订阅表单，
订阅数据保存到数据库的 subscribers 表"

# 练习3：Visual 编辑
# 切换到 Visual 模式，点击页面上的文字直接修改样式
# 改一下首页的标题颜色和字体大小
```

**Agent 模式使用技巧**：

| 做法 | 说明 |
|:----|:-----|
| 从简单开始 | 先核心功能再逐步添加，别一次性全说完 |
| 提供具体细节 | "左导航右内容"比"好看"有用得多 |
| 用 "Try to fix" | 出错了点这个按钮，Lovable 自动尝试修复 |
| 阶段性保存 | 完成一个功能后手动保存版本快照 |
| 参考现有应用 | "类似 Notion 的编辑器"比"一个编辑器"更准确 |

### ✅ 完成标准

- [ ] 用 Agent 模式创建一个带数据库的全栈应用
- [ ] 理解 Lovable + Supabase 的后端集成方式
- [ ] 使用 Visual 模式进行 UI 微调
- [ ] 掌握 Agent 模式使用技巧

### 📖 费曼三句话

1. Lovable 的"全栈"不只是 UI——它自动创建 PostgreSQL 数据库、认证系统和安全策略
2. Supabase 是 Lovable 的后端引擎，每个应用自带数据库和管理面板
3. 从简单核心功能开始逐步迭代，比一次说完所有需求更可靠

---

## 🍅23 GitHub 管线与版本控制（25分钟）

### 费曼输入

Lovable 提供**双向 GitHub 同步**，所有计划（包括免费版）都支持。这意味着你的应用代码自动同步到 GitHub 仓库，你可以在 Lovable 和传统开发工作流之间自由切换。

**双向同步工作流**：

```
Lovable 编辑 → 自动同步到 GitHub
        ↕
GitHub 推送 → Lovable 自动拉取更新
```

**混合开发模式**：
```
非技术人员：用 Lovable 的 Chat/Agent 构建应用
     ↓ 代码同步到 GitHub
专业开发者：克隆仓库，在 VS Code 中扩展功能
     ↓ 代码推回 GitHub
Lovable 自动同步，继续用 AI 开发新功能
```

### 刻意练习

```bash
# 1. 连接 GitHub
#    Lovable 项目 → Settings → GitHub → Connect
#    授权 Lovable 访问你的 GitHub 账号

# 2. 查看同步的仓库
#    在 GitHub 上查看 Lovable 自动创建的仓库
#    结构如下：
my-blog-app/
├── src/
│   ├── components/    # React 组件
│   ├── pages/         # 页面
│   ├── lib/           # 工具函数
│   ├── integrations/  # Supabase/Stripe 集成
│   └── App.tsx        # 入口
├── supabase/
│   └── migrations/    # 数据库迁移文件
├── public/            # 静态资源
├── package.json
├── vite.config.ts
└── vercel.json        # Vercel 部署配置

# 3. 本地开发
git clone https://github.com/你的用户名/my-blog-app.git
cd my-blog-app
npm install
npm run dev

# 4. 本地修改后推回
git add .
git commit -m "添加新功能"
git push

# 5. 回到 Lovable 查看变更是否同步
```

**GitHub 协作的最佳实践**：

| 场景 | 做法 |
|:----|:-----|
| 非技术人员 | 全程在 Lovable 操作，GitHub 作为备份 |
| 团队协作 | Lovable 构建基础 → 开发者 clone 做深度开发 |
| 企业项目 | Lovable 生成 → 开发者 Review → 手动合并 PR |
| 持续迭代 | Lovable 和开发者各自修改 → 解决冲突 → 同步 |

### ✅ 完成标准

- [ ] 连接 Lovable 项目到 GitHub
- [ ] 在 GitHub 上查看生成的仓库结构
- [ ] 克隆仓库到本地并成功运行
- [ ] 理解双向同步的工作流

### 📖 费曼三句话

1. Lovable 的项目自动同步到 GitHub——代码永远是你的
2. 双向同步意味着 AI 开发和传统开发可以混合进行
3. GitHub 仓库里有完整的代码结构，和手动写的项目一模一样

---

## 🍅24 Lovable → Vercel 部署迁移（25分钟）

### 费曼输入

Lovable 自带托管（`lovable.app` 子域名），但生产环境建议部署到 Vercel。因为 Lovable 生成的是标准 **Vite + React** 项目，部署到 Vercel 非常简单。

**为什么要把 Lovable 项目迁移到 Vercel？**

| 原因 | 说明 |
|:----|:-----|
| 自定义域名 | Vercel 支持绑定自己的域名 |
| 全球 CDN | Vercel 100+ 边缘节点，性能更好 |
| 统一管理 | 所有项目在 Vercel Dashboard 统一管理 |
| 团队协作 | Vercel Team 功能 |
| AI 基础设施 | AI Gateway、Sandbox、Workflow SDK 等 |

**Vercel 部署三步走**：

```
Step 1: Lovable → GitHub（自动同步）
Step 2: GitHub → Vercel（导入仓库）
Step 3: Vercel 配置（环境变量 + 构建设置）
```

### 刻意练习

```bash
# 步骤1：确认 Lovable 项目已同步到 GitHub
# 步骤2：在 Vercel 中导入

# Vercel Dashboard → Add New → Project
# → Import Git Repository → 选择你的 Lovable 项目
# → Framework Preset: 自动检测为 Vite
# → Build Command: npm run build
# → Output Directory: dist
# → Node.js Version: 22.x

# 步骤3：配置环境变量（关键！）
# Lovable 项目依赖 Supabase 环境变量
# 在 Lovable 的 Cloud 面板中查看这些值：

# 需要的环境变量（Vercel → Settings → Environment Variables）：
VITE_SUPABASE_URL=https://你的项目.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=你的匿名公钥
VITE_SUPABASE_PROJECT_ID=你的项目ID

# 步骤4：添加 SPA 重写规则
# 在项目根目录创建 vercel.json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ],
  "cleanUrls": true
}

# 步骤5：部署
# 点击 Deploy，等待完成
# 访问 https://你的项目.vercel.app
```

**常见问题排查**：

| 问题 | 原因 | 解决 |
|:----|:-----|:----|
| 页面空白 | 环境变量未设置 | 添加 VITE_SUPABASE_* 变量 |
| 路由 404 | 缺少 SPA 重写 | 添加 vercel.json rewrites |
| CORS 错误 | Supabase 域名限制 | 在 Supabase 设置中添加 Vercel 域名 |
| 构建失败 | Node 版本不匹配 | 设置 Node.js 22.x |
| Auth 不工作 | 未配置重定向 URL | 在 Supabase Auth 设置中添加 Vercel URL |

### ✅ 完成标准

- [ ] 成功将 Lovable 项目部署到 Vercel
- [ ] 正确配置 Supabase 环境变量
- [ ] 添加 vercel.json 解决 SPA 路由问题
- [ ] 验证应用在 Vercel 上完整运行（含数据库和认证）

### 📖 费曼三句话

1. Lovable 项目部署到 Vercel 只需要三步：GitHub 同步 → Vercel 导入 → 配置环境变量
2. 环境变量是迁移中最容易出错的一环——Supabase 的 URL 和 Key 必须正确
3. SPA 路由重写（rewrites）是 Vite 应用在 Vercel 上的必备配置

---

## 🍅25 高级配置与生产准备（25分钟）

### 费曼输入

将 Lovable 应用部署到 Vercel 只是第一步。生产环境还需要考虑认证配置、域名绑定、性能优化和 CI/CD。

**生产就绪清单**：

```
☐ 自定义域名绑定
☐ Supabase Auth 重定向 URL 配置
☐ 环境变量分环境管理（Production/Preview/Development）
☐ Vercel Analytics 启用
☐ 性能优化（懒加载、图片优化）
☐ CI/CD 自动部署配置
☐ 错误监控
```

### 刻意练习

```bash
# 1. 绑定自定义域名
# Vercel → 项目 → Settings → Domains → 添加域名
# 在 DNS 服务商添加 CNAME 记录到 cname.vercel-dns.com

# 2. Supabase Auth 配置
# Supabase Dashboard → Authentication → Settings
# 在 Redirect URLs 中添加：
# https://你的域名.com/**
# https://你的域名.com/auth/callback

# 3. 环境变量分环境管理
# Vercel → 项目 → Settings → Environment Variables

# Production 环境：
VITE_SUPABASE_URL=https://你的项目.supabase.co
VITE_APP_URL=https://你的域名.com

# Preview 环境（自动使用预览域名）：
VITE_SUPABASE_URL=https://你的项目.supabase.co
VITE_APP_URL=https://preview-分支名.vercel.app

# 4. 开启 Analytics
# Vercel → 项目 → Analytics → Enable Web Analytics
# 无需额外代码，自动采集页面访问数据

# 5. 性能优化
# Lazy load 组件（Lovable 生成的代码已默认支持）
# 图片使用 Vercel Image Optimization
```

```typescript
// 生产环境检测示例 — 确保代码在不同环境正常工作
const isProduction = import.meta.env.PROD;
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const appUrl = import.meta.env.VITE_APP_URL;

if (!supabaseUrl) {
  console.error('Missing VITE_SUPABASE_URL environment variable');
}

// Supabase 客户端初始化（注意重定向 URL）
export const supabase = createClient(
  supabaseUrl,
  import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY,
  {
    auth: {
      autoRefreshToken: true,
      persistSession: true,
      redirectTo: `${appUrl}/auth/callback`
    }
  }
);
```

**完整的生产管线**：

```
开发者推送代码到 GitHub
    ↓
Vercel 自动检测变更
    ↓
Preview 部署（自动分配预览域名）
    ↓
团队 Review
    ↓
合并到 main 分支
    ↓
Production 部署
    ↓
Slack/邮件通知
```

### ✅ 完成标准

- [ ] 绑定自定义域名并配置 DNS
- [ ] 配置 Supabase Auth 重定向 URL
- [ ] 设置多环境变量（Production/Preview）
- [ ] 开启 Vercel Analytics
- [ ] 理解 CI/CD 生产管线全流程

### 📖 费曼三句话

1. 生产环境不只是"能访问"——还需要自定义域名、Auth 配置和监控
2. 环境变量按 Production/Preview 分开管理，不同环境用不同配置
3. CI/CD 管线让每次代码推送自动走预览→审核→上线流程

---

## 🍅 模块D 综合考核

1. 在 Lovable 中创建一个"个人记账"应用（含数据库，记录收支、分类统计）
2. 将项目同步到 GitHub，查看完整项目结构
3. 部署到 Vercel，配置所有必要的环境变量
4. 绑定自定义域名（如有），配置 Supabase Auth 重定向
5. 写三句话总结什么时候用 Lovable、什么时候用 v0

**预期耗时**：45-60分钟（2个番茄）
**完成标准**：一个由 Lovable 构建的全栈应用在 Vercel 上运行，包含数据库和认证
