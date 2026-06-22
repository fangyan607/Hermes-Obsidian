# Day 5：Cloudflare Pages 静态网站部署

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：使用 Pages 部署静态网站，配置自定义域名
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Cloudflare Pages
🍅 番茄3-4：创建 Pages 项目
🍅 番茄5-6：配置自定义域名
🍅 番茄7-8：部署优化 + 复习输出
```

---

## 番茄钟1：理解 Cloudflare Pages

### 1.1 用大白话理解 Pages

**Pages 是什么？**

想象你写了一本书，需要**印刷发行**：

| 传统方式 | Cloudflare Pages |
|:---------|:-----------------|
| 自己买印刷机 | 免费印刷厂 |
| 自己建仓库 | 全球仓库 |
| 自己发货 | 自动就近发货 |
| 更新要重新印刷 | 自动更新 |

**Pages = 免费的静态网站托管 + 全球 CDN + 自动部署**

### 1.2 Pages 能做什么？

| 功能 | 说明 |
|:-----|:-----|
| **静态网站托管** | HTML/CSS/JS 网站 |
| **框架支持** | React/Vue/Next.js/Hugo 等 |
| **自动部署** | Git 推送自动构建部署 |
| **预览环境** | 每个 PR 自动生成预览链接 |
| **自定义域名** | 绑定自己的域名 |
| **免费 SSL** | 自动配置 HTTPS |

### 1.3 Pages vs 其他托管

| 对比项 | Cloudflare Pages | Vercel | Netlify |
|:-------|:-----------------|:-------|:--------|
| 免费额度 | 无限带宽 | 100GB/月 | 100GB/月 |
| 构建时间 | 500次/月 | 6000分钟 | 300分钟 |
| CDN 节点 | 310+ | 100+ | 100+ |
| Functions | Workers 集成 | Serverless | Functions |
| 国内访问 | ⭐ 较好 | 一般 | 一般 |

> ✋ **费曼自测**：Cloudflare Pages 相比其他托管服务有什么优势？

---

## 番茄钟2：支持的框架

### 2.1 预设框架

| 框架 | 构建命令 | 输出目录 |
|:-----|:---------|:---------|
| **Next.js** | `npm run build` | `out` 或 `.next` |
| **React** | `npm run build` | `build` |
| **Vue** | `npm run build` | `dist` |
| **Nuxt** | `npm run build` | `.output/public` |
| **Hugo** | `hugo` | `public` |
| **Jekyll** | `jekyll build` | `_site` |
| **Astro** | `npm run build` | `dist` |
| **纯 HTML** | 无 | `/` |

### 2.2 框架预设检测

```
Pages 会自动检测：
- 根目录的 package.json
- 框架配置文件
- 自动选择正确的构建命令
```

### 2.3 自定义构建

**如果没有预设框架：**

```
构建命令：npm run build
构建输出目录：dist
根目录：/
环境变量：可添加
```

> ✋ **费曼自测**：你的项目使用什么框架？对应的构建命令是什么？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Pages 是免费的静态网站托管服务
- [ ] 支持主流前端框架
- [ ] 自动部署和预览

---

## 番茄钟3：创建 Pages 项目

### 3.1 连接 Git 仓库

**步骤：**

```
1. 进入 Workers & Pages → Create → Pages
2. 选择 "Connect to Git"
3. 授权 GitHub/GitLab
4. 选择要部署的仓库
```

### 3.2 配置构建设置

```
项目名称：my-website
生产分支：main

构建设置：
- 框架预设：React（自动检测）
- 构建命令：npm run build
- 构建输出目录：build

环境变量（可选）：
- NODE_VERSION: 18
```

### 3.3 触发部署

```
点击 "Save and Deploy"

等待构建完成：
- 安装依赖
- 执行构建
- 上传文件
- 部署到全球节点

通常 1-3 分钟完成
```

### 3.4 查看部署结果

```
部署完成后获得：
- 默认域名：my-website.pages.dev
- 部署链接：https://xxx.pages.dev

点击链接查看网站
```

> ✋ **费曼自测**：创建一个 Pages 项目并成功部署。

---

## 番茄钟4：本地开发与预览

### 4.1 Wrangler CLI

**安装 Wrangler：**

```bash
npm install -g wrangler

# 或在项目中
npm install wrangler --save-dev
```

### 4.2 本地预览

```bash
# 进入项目目录
cd my-project

# 本地预览
wrangler pages dev ./dist

# 或指定端口
wrangler pages dev ./dist --port 3000
```

### 4.3 手动部署

```bash
# 登录 Cloudflare
wrangler login

# 手动部署
wrangler pages deploy ./dist --project-name=my-website
```

### 4.4 wrangler.toml 配置

```toml
name = "my-website"
pages_build_output_dir = "dist"

[site]
bucket = "./dist"
```

> ✋ **费曼自测**：使用 Wrangler 本地预览你的网站。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] Pages 项目创建成功
- [ ] 网站可以正常访问
- [ ] 了解 Wrangler CLI 使用

---

## 番茄钟5：配置自定义域名

### 5.1 添加自定义域名

**步骤：**

```
Workers & Pages → 选择项目 → Settings → Custom Domains

1. 点击 "Set up a custom domain"
2. 输入域名：www.example.com
3. 选择 DNS 区域
4. 点击 "Activate Domain"

Pages 自动配置 DNS 和 SSL
```

### 5.2 域名配置选项

| 域名类型 | 配置方式 |
|:---------|:---------|
| **子域名** | 自动添加 CNAME 记录 |
| **根域名** | 自动添加 A/AAAA 记录 |
| **外部域名** | 需手动配置 DNS |

### 5.3 验证域名配置

```bash
# 查询域名解析
dig www.example.com

# 应该返回 Cloudflare Pages 的 IP
```

### 5.4 域名重定向

**将根域名重定向到 www：**

```
Workers & Pages → 项目 → Settings → Redirects

添加规则：
- If the URL matches: example.com/*
- Then forward to: https://www.example.com/$1
- Status: 301
```

> ✋ **费曼自测**：为你的 Pages 项目配置自定义域名。

---

## 番茄钟6：环境变量与函数

### 6.1 环境变量配置

```
Workers & Pages → 项目 → Settings → Environment Variables

添加变量：
- API_KEY: xxx
- NODE_ENV: production

环境选择：
- Production：生产环境
- Preview：预览环境
```

### 6.2 在代码中使用

```javascript
// 在构建时访问
const apiKey = process.env.API_KEY;

// 在 Pages Functions 中访问
export function onRequest(context) {
  const apiKey = context.env.API_KEY;
}
```

### 6.3 Pages Functions

**创建 API 端点：**

```
项目结构：
functions/
└── api/
    └── hello.js
```

```javascript
// functions/api/hello.js
export function onRequest(context) {
  return new Response(JSON.stringify({
    message: "Hello from Cloudflare Pages!"
  }), {
    headers: { "Content-Type": "application/json" }
  });
}
```

**访问：** `https://your-site.pages.dev/api/hello`

### 6.4 刻意练习任务

```markdown
## Pages 高级配置

- [ ] 配置环境变量
- [ ] 创建一个 API 函数
- [ ] 测试 API 访问
```

> ✋ **费曼自测**：创建一个返回 "Hello World" 的 Pages Function。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 自定义域名配置成功
- [ ] 环境变量设置正确
- [ ] Pages Functions 运行正常

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**Pages 速记：**

```
Pages = 免费静态托管 + 自动部署

创建流程：
1. 连接 Git 仓库
2. 配置构建命令
3. 自动部署
4. 配置自定义域名

高级功能：
- 环境变量
- Pages Functions
- 预览部署
```

### 7.2 命令速查

| 命令 | 功能 |
|:-----|:-----|
| `wrangler pages dev ./dist` | 本地预览 |
| `wrangler pages deploy ./dist` | 手动部署 |
| `wrangler login` | 登录 Cloudflare |

### 7.3 常见问题

| 问题 | 解决方案 |
|:-----|:---------|
| 构建失败 | 检查构建命令和输出目录 |
| 页面空白 | 检查路由配置 |
| 自定义域名不生效 | 检查 DNS 配置 |

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 5

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
Pages 提供免费的静态网站托管，支持主流框架和自动部署。

## 关键要点

### 1. 创建流程
- 连接 Git 仓库
- 配置构建命令
- 自动部署

### 2. 自定义域名
- 添加域名
- 自动配置 DNS 和 SSL
- 设置重定向

### 3. 高级功能
- 环境变量
- Pages Functions
- Wrangler CLI

## 明日计划
- 学习 Cloudflare Workers
- 编写 Serverless 函数
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 Pages 功能
- [ ] **番茄3-4**：成功部署网站
- [ ] **番茄5-6**：配置自定义域名
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 5 完成！

**今日成果：**
- ✅ 理解 Cloudflare Pages
- ✅ 成功部署静态网站
- ✅ 配置自定义域名

**明天预告：** [[Day6-Workers]] - 学习 Cloudflare Workers 无服务器函数

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day4-SSL证书]] - 上一天内容
