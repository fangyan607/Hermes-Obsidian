---
created: 2026-06-19
tags:
  - AI系统学习课
  - open-lovable
  - Firecrawl
  - 配置教程
  - 番茄费曼
  - 刻意练习
  - React
source: https://github.com/firecrawl/open-lovable
updated: 2026-06-19
---

# 🍅 Open Lovable 一番茄配置掌握

> **1个番茄 · 费曼学习法 × 刻意练习**
> 用聊天的方式让 AI 帮你构建 React 应用——开源版 Lovable.dev

---

## 📋 学习目标

| 项目 | 内容 |
|------|------|
| **学习主题** | Open Lovable —— Firecrawl 团队开发的开源项目，让 AI 通过对话直接构建 React 应用 |
| **掌握程度** | □ 了解 → ✅ 理解 → ✅ 应用 → □ 教授他人 |
| **学习方法** | 番茄工作法 🍅 + 费曼学习法 📝 + 刻意练习 🎯 |
| **总时长** | 1个番茄 = 25分钟专注 |

---

## ⏱️ 番茄节奏

```
前8分钟  → 🧠 费曼输入：理解 Open Lovable 是什么、需要哪些基础设施
中间12分钟 → ✋ 刻意练习：逐一配置四层 API 密钥 + 沙箱选择
最后5分钟  → 📝 费曼复盘：三句话总结 + 配置清单核对
```

---

# 🧠 阶段一：费曼输入（前8分钟）

## 1.1 这是什么？（费曼三句话热身）

| 你问 | 费曼回答 |
|------|----------|
| **它是什么？** | Open Lovable 是一个开源 Web 应用（Next.js），你像聊天一样告诉 AI 想要什么应用，它就直接帮你生成 React 代码并实时预览——相当于 Lovable.dev 的开源平替 |
| **谁做的？** | Firecrawl 团队（就是做那个超强网页抓取工具的团队） |
| **我需要准备什么？** | 一个 Firecrawl API Key（必选）+ 随便选一个 AI 模型（Gemini/Anthropic/OpenAI/Groq）+ 一个沙箱环境（Vercel 或 E2B） |

## 1.2 整体架构（一图流）

```
👤 你输入: "帮我做一个待办事项应用"
    │
    ▼
🧠 AI Provider (Gemini/Claude/GPT/Groq) 
    │  理解需求 → 生成 React 代码
    │
    ▼
🕸️ Firecrawl API — 如果 AI 需要查文档/抓网页来增强回答
    │
    ▼
📦 Sandbox (Vercel / E2B) — 实时预览生成的 React 应用
    │
    ▼
🖥️ 浏览器 — 你看到结果，继续聊天迭代
```

## 1.3 你需要提前注册的账号（基础设施）

| 服务 | 层级 | 注册链接 | 备注 |
|:----|:----:|:---------|:-----|
| **Firecrawl** 🔥 | ✅ 必选 | https://firecrawl.dev | 核心引擎，免费额度足够试用 |
| **AI 模型**（四选一） | ✅ 必选 | 见下方 | 任选一个有免费额度的 |
| **Vercel** 或 **E2B** | ✅ 必选 | vercel.com / e2b.dev | 用来预览生成的页面 |

---

# ✋ 阶段二：刻意练习（中间12分钟）

## 2.1 🎯 练习1：克隆与安装

> **遮住右侧，只看左侧回忆命令**

| 步骤 | 命令 | 自测 ✅ |
|:----|:-----|:-------:|
| 克隆项目 | `git clone https://github.com/firecrawl/open-lovable.git` | □ |
| 进入目录 | `cd open-lovable` | □ |
| 安装依赖 | `pnpm install`（或 npm install / yarn install） | □ |
| 创建环境变量 | 复制 `.env.example` 为 `.env.local` | □ |
| 启动开发服务器 | `pnpm dev`（或 npm run dev / yarn dev） | □ |
| 打开浏览器 | http://localhost:3000 | □ |

## 2.2 🎯 练习2：四层 API 密钥配置（核心中的核心）

这是最关键的配置环节，**逐层搞定**：

### 第1层：🔥 Firecrawl（必选——整个系统的引擎）

```env
FIRECRAWL_API_KEY=your_firecrawl_api_key
```

> 去 https://firecrawl.dev 注册 → Dashboard → 复制 API Key

### 第2层：🧠 AI Provider（四选一——你的"程序员"）

```env
# ┌─ Option A: Google Gemini（推荐——免费额度最大方）
#    注册: https://aistudio.google.com/app/apikey
GEMINI_API_KEY=your_gemini_api_key

# ├─ Option B: Anthropic Claude（代码能力强）
#    注册: https://console.anthropic.com
ANTHROPIC_API_KEY=your_anthropic_api_key

# ├─ Option C: OpenAI GPT（最通用）
#    注册: https://platform.openai.com
OPENAI_API_KEY=your_openai_api_key

# └─ Option D: Groq（速度最快，免费）
#    注册: https://console.groq.com
GROQ_API_KEY=your_groq_api_key
```

> 💡 **选哪个？** 个人推荐 **Gemini**（免费额度最大）或 **Groq**（响应速度最快）

### 第3层：⚡ Fast Apply（可选——让编辑更快）

```env
MORPH_API_KEY=your_morphllm_api_key
```

> 去 https://morphllm.com/dashboard 注册获取。不是必须的，但加了之后 AI 修改代码的速度会更快。

### 第4层：📦 Sandbox Provider（二选一——渲染预览环境）

#### 方案A：Vercel Sandbox（默认，推荐）

```env
SANDBOX_PROVIDER=vercel
```

**认证方式有两种：**

```
┌─ Method A: OIDC Token（开发环境推荐）
│  运行以下命令自动生成：
│    vercel link        # 关联 Vercel 项目
│    vercel env pull    # 拉取环境变量
│  → VERCEL_OIDC_TOKEN 自动填充
│
└─ Method B: Personal Access Token（生产环境）
    VERCEL_TEAM_ID=team_xxxxxxxxx
    VERCEL_PROJECT_ID=prj_xxxxxxxxx
    VERCEL_TOKEN=vercel_xxxxxxxxxxxx
    # 从 Vercel Dashboard → Settings → Tokens 获取
```

#### 方案B：E2B Sandbox（备选）

```env
SANDBOX_PROVIDER=e2b
E2B_API_KEY=your_e2b_api_key
```

> 去 https://e2b.dev 注册获取

---

## 2.3 🎯 练习3：完整的 .env.local 配置决策树

> **刻意练习**：遮住右侧，按场景做出选择

```
开始配置 .env.local
    │
    ├── FIRECRAWL_API_KEY → [去 firecrawl.dev 注册] ← 必选，没有它啥也干不了
    │
    ├── AI 模型 → 选哪个？
    │   ├─ 想要免费额度大 → Gemini ✅
    │   ├─ 想要代码质量高 → Anthropic ✅
    │   ├─ 想要最通用的 → OpenAI ✅
    │   └─ 想要响应最快 → Groq ✅
    │
    ├── MORPH_API_KEY → 加不加？
    │   ├─ 想要编辑更快 → 加（去 morphllm.com 注册）
    │   └─ 无所谓 → 不加
    │
    └── 沙箱选哪个？
        ├─ 已经有 Vercel 账号 → Vercel（默认）
        │   ├─ 开发环境 → Method A: OIDC Token（vercel link + vercel env pull）
        │   └─ 生产环境 → Method B: PAT（手动填 VERCEL_TOKEN）
        └─ 想用别的 → E2B（改 SANDBOX_PROVIDER=e2b）
```

> 🧠 **刻意练习**：遮住右侧选项，仅看左边的决策点，说出每个分支该怎么做

---

## 2.4 🎯 练习4：启动验证清单

启动后打开 http://localhost:3000，检查：

| 检查项 | 正常状态 | 异常排查 |
|:------|:--------|:---------|
| 页面是否正常加载 | 出现聊天界面 | 检查 `pnpm dev` 是否运行，端口是否被占用 |
| 是否能发送消息 | 输入文字可发送 | 检查 AI Provider 的 API Key 是否正确 |
| AI 能否生成代码 | 收到代码响应 | 检查 Firecrawl API Key 是否有效 |
| 预览是否正常 | 生成的页面可预览 | 检查 Sandbox 配置（Vercel/E2B）是否正确 |

---

# 📝 阶段三：费曼复盘（最后5分钟）

## 3.1 费曼三句话（强制输出）

> **不看资料，用三句话向一个前端开发者解释如何配置 Open Lovable**

| 我的三句话 | 自评 |
|------------|:----:|
| ① 先注册 Firecrawl 拿 API Key，再去你喜欢的 AI 平台（推荐 Gemini 免费额度大）拿 API Key，这是两个必须的 | ✅ / ❌ |
| ② 克隆项目后配 .env.local，填好 FIRECRAWL_API_KEY 和你选的 AI Key，再选 Vercel 或 E2B 做预览沙箱 | ✅ / ❌ |
| ③ 运行 `pnpm dev` 打开 localhost:3000，就可以像聊天一样让 AI 帮你写 React 应用了 | ✅ / ❌ |

## 3.2 快速问答（刻意练习·检验）

| 问题 | 答案 |
|:-----|:-----|
| Open Lovable 是谁开发的？ | Firecrawl 团队 |
| 唯一必选的 API Key 是哪个？ | `FIRECRAWL_API_KEY` |
| 推荐用哪个 AI Provider？理由？ | Gemini（免费额度最大）或 Groq（响应最快） |
| MORPH_API_KEY 是干什么的？ | 加速 AI 编辑代码（可选） |
| 默认 Sandbox Provider 是哪个？ | Vercel（可切换为 E2B） |
| Vercel 的 OIDC Token 怎么生成？ | 运行 `vercel link` → `vercel env pull` |
| 启动后访问哪个 URL？ | http://localhost:3000 |

## 3.3 快速参考卡（打印级）

```
克隆:     git clone https://github.com/firecrawl/open-lovable.git && cd open-lovable
安装:     pnpm install
配置:     .env.local
          必填: FIRECRAWL_API_KEY
          四选一: GEMINI | ANTHROPIC | OPENAI | GROQ API_KEY
          可选: MORPH_API_KEY (加速编辑)
          沙箱: SANDBOX_PROVIDER=vercel (默认) | e2b
               Vercel → OIDC Token (dev) 或 PAT (prod)
启动:     pnpm dev → http://localhost:3000
```

---

## 🔗 知识连接

| 已有知识 | 连接 | 启发 |
|:---------|:-----|:-----|
| [[AI系统学习课/3-Cursor编程.pdf]] | AI 编程工具 | Open Lovable 是"对话式编程"的另一种形态 |
| [[AI系统学习课/10-MCP与A2A的应用]] | AI 工具生态 | Firecrawl 本身也是 MCP 生态的重要组成部分 |
| [[AI系统学习课/30-mcp2cli-一番茄快速掌握]] | 今日 CLI 工具 | Firecrawl 可被 mcp2cli 调用——工具链串联 |
| [[日记/2026-06-19]] | 今日学习 | 今天连续学了两个 Firecrawl 生态的工具 |

---

## 📝 番茄记录

- [x] 🧠 费曼输入：理解 Open Lovable 架构和前置条件
- [x] ✋ 刻意练习：四层 API 配置 + 决策树 + 启动验证
- [x] 📝 费曼复盘：三句话 + 快速问答
- [ ] 下一步：实际注册 Firecrawl 和 AI 账号，跑起来试试

> **一句话总结**：Open Lovable = Firecrawl 引擎 + 任选 AI 模型 + Vercel/E2B 沙箱，只需配好四层 API Key 就能拥有自己的 AI 应用生成器 🚀
