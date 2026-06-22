# Day 4：实战项目一 - GitHub Pages 部署

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：用 GitHub Pages 从零部署个人博客网站
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：从零到上线的完整项目实践

---

## 今日学习路径

```
🍅 番茄1-2：理解 Pages 原理 + Jekyll 基础
🍅 番茄3-4：搭建个人博客（从零到上线）
🍅 番茄5-6：实战：完整项目部署（含自定义域名 + Actions 自动部署）
🍅 番茄7-8：复习 + 输出成果
```

**今日产出：** 一个在线的个人博客网站，可通过 `https://你的用户名.github.io` 访问

---

## 番茄钟1：GitHub Pages 是什么（25分钟）

### 1.1 用大白话理解 Pages

**GitHub Pages 是什么？**

GitHub Pages 是 GitHub 免费提供的**静态网站托管服务**。简单说：

```
传统建站：租服务器 → 配置环境 → 部署代码 → 维护（花钱+费力）
GitHub Pages：写代码 → 推送到仓库 → 自动上线（免费+省心）
```

**核心特性：**

| 特性 | 说明 |
|:-----|:------|
| **免费** | 无需服务器费用，带宽和存储由 GitHub 承担 |
| **静态站点** | HTML/CSS/JS 静态文件，不支持后端语言（PHP/Python/Node） |
| **自定义域名** | 支持绑定自己的域名（如 `blog.yourname.com`） |
| **HTTPS 自动** | 自动签发 Let's Encrypt SSL 证书 |
| **无服务器维护** | GitHub 负责运维，你只管写内容 |
| **存储限制** | 仓库不超过 1GB，Pages 站点不超过 1GB |
| **带宽限制** | 每月 100GB 带宽，每小时不超过 10 次构建 |

### 1.2 三种 Pages 类型

GitHub Pages 有三种使用方式，**选错类型会导致路径问题**，一定要理解：

```
类型 1：User/Organization Site（用户/组织站点）
└── 仓库名：<用户名>.github.io
└── 访问地址：https://<用户名>.github.io
└── 特点：一个 GitHub 账号只能有一个
└── 用途：个人主页、简历、博客

类型 2：Project Site（项目站点）
└── 仓库名：任意仓库名
└── 访问地址：https://<用户名>.github.io/<仓库名>
└── 特点：每个项目都可以有一个
└── 用途：项目文档、Demo 演示

类型 3：Workflow Pages（2026 新增）
└── 仓库名：任意仓库名
└── 访问地址：由 Actions 工作流决定
└── 特点：用 GitHub Actions 完全控制构建和部署流程
└── 用途：需要自定义构建工具的场景
```

> ⚠️ **常见坑**：用 Project Site 模式时，如果用了绝对路径 `/image.png`，部署后路径会变成 `https://用户.github.io/image.png`（404），应该用相对路径或 `{{ site.baseurl }}/image.png`

### 1.3 部署原理

```
你本地写代码
    │
    ▼
git push 到 GitHub 仓库
    │
    ▼
GitHub 自动检测 Pages 配置
    │
    ├─ 如果用 Jekyll → 自动构建生成静态文件
    ├─ 如果用 Actions → 按 workflow 配置构建
    └─ 如果是纯静态文件 → 直接部署
    │
    ▼
部署到 GitHub 的 CDN 网络（全球加速）
    │
    ▼
用户访问你的地址就能看到网站
```

### 1.4 2026 年 Pages 新特性

2026 年 GitHub Pages 有以下重要改进：

| 新特性 | 说明 |
|:-------|:------|
| **构建速度提升** | 默认构建时间从 10分钟缩短到 3分钟 |
| **自定义构建流程** | 不再限制只能用 Jekyll，支持任意静态站点生成器 |
| **Preview Deployments** | 每次 PR 自动生成预览链接 |
| **Branch-level 配置** | 不同分支可以配置不同的构建方式 |
| **改进的 404 页面** | 内置更友好的 404 模板 |

> ✋ **费曼自测**：用自己的话解释 User Site 和 Project Site 的区别。如果我想部署一个项目文档站点，应该用哪种类型？访问 URL 长什么样？

---

## 番茄钟2：Jekyll 静态站点生成器基础（25分钟）

### 2.1 Jekyll 是什么

Jekyll 是 GitHub Pages 默认集成的**静态站点生成器**。它把 Markdown 文章转换成 HTML 页面。

```
Jekyll 的核心理念：
Markdown 文章 + 主题模板 = 静态 HTML 网站
         ↓                    ↓
    你只管写内容           自动生成网站
```

**为什么选择 Jekyll？**

```
Jekyll               其他工具（Hugo/Next.js/Gatsby）
─────────────────────────────────────────────────
GitHub Pages 原生支持   需要额外配置 Actions
无需安装运行时            需要 Node.js/Go 环境
零配置即可部署            需要写构建配置
适合博客/文档             适合复杂应用
插件有限制                插件自由选择
```

### 2.2 Jekyll 目录结构

一个标准的 Jekyll 项目结构：

```
my-blog/
├── _config.yml          ← 核心配置文件（站点标题、主题等）
├── _posts/              ← 博客文章目录（Markdown 文件）
│   └── 2026-06-11-hello-world.md
├── _layouts/            ← 页面布局模板
│   ├── default.html
│   └── post.html
├── _includes/           ← 可复用的组件片段
│   ├── header.html
│   └── footer.html
├── _data/               ← 数据文件（YAML/JSON）
│   └── navigation.yml
├── assets/              ← 静态资源（CSS/JS/图片）
│   ├── css/
│   └── images/
├── index.md             ← 首页
├── about.md             ← 关于页面
└── Gemfile              ← Ruby 依赖文件
```

**关键文件详解：**

| 文件/文件夹 | 用途 | 是否必须 |
|:------------|:-----|:---------|
| `_config.yml` | 站点配置，定义标题、主题、URL 等 | ✅ 必须 |
| `_posts/` | 文章目录，文件名格式：`YYYY-MM-DD-title.md` | 有博客则需要 |
| `_layouts/` | 模板布局 | 使用主题则可省略 |
| `index.html` 或 `index.md` | 首页 | ✅ 至少一个 |

### 2.3 _config.yml 核心配置

```yaml
# 最基本的配置（只写这些就能跑）
title: 我的博客
email: your@email.com
description: >-
  这是我的个人博客，记录技术学习和生活思考。
baseurl: ""  # 如果是 User Site 留空
             # 如果是 Project Site 填 /仓库名
url: "https://yourusername.github.io"  # 正式域名

# 主题配置
theme: minima  # GitHub Pages 官方默认主题

# 构建配置
markdown: kramdown
permalink: /:year/:month/:day/:title/  # URL 格式

# 社交链接
twitter_username: your_twitter
github_username:  your_github

# 插件（GitHub Pages 支持的有限列表）
plugins:
  - jekyll-feed      # RSS Feed 自动生成
  - jekyll-seo-tag   # SEO 优化标签
  - jekyll-sitemap   # 自动生成 sitemap.xml

# 排除文件（不包含在生成的站点中）
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
```

### 2.4 文章 Front Matter 格式

每篇 Markdown 文章开头需要 YAML 元数据（Front Matter）：

```yaml
---
layout: post              # 使用 _layouts/post.html 模板
title:  "我的第一篇文章"   # 文章标题
date:   2026-06-11 10:00:00 +0800
categories: jekyll update # 分类
tags: [github, blog]      # 标签
author: 你的名字
---

这里是文章正文，用 Markdown 格式书写。

## 二级标题

正文内容...
```

> ✋ **费曼自测**：`_config.yml`、`_posts/`、`Front Matter` 这三者分别是什么作用？为什么文章文件名必须是 `YYYY-MM-DD-title.md` 格式？

---

## 🍅 番茄钟1-2结束，休息5分钟

**验证清单：**
- [ ] 能说出三种 Pages 类型的区别
- [ ] 能解释 Jekyll 的工作流程
- [ ] 能写出 `_config.yml` 的基本配置
- [ ] 理解 Front Matter 的格式和作用

---

## 番茄钟3：从零搭建个人博客（25分钟）

### 3.1 准备工作环境

```bash
# 检查 Ruby 环境（Jekyll 需要）
ruby --version  # 期望 >= 2.5.0

# macOS 安装 Ruby（如果需要）
brew install ruby

# Windows 安装 Ruby
# 下载：https://rubyinstaller.org/downloads/
# 安装时勾选 "Add Ruby executables to your PATH"

# Linux 安装 Ruby
sudo apt install ruby-full

# 安装 Jekyll 和 Bundler
gem install jekyll bundler

# 验证安装
jekyll --version  # 期望 >= 4.0
```

> ⚠️ **2026 年提示**：如果不想装 Ruby，可以直接用 GitHub Actions 构建——把 Markdown 推送到仓库，让 GitHub 服务器上的 Jekyll 帮你生成。番茄5会讲这种方法。

### 3.2 创建博客项目

**方法一：用 Jekyll 命令创建（推荐）**

```bash
# 创建新博客（替换成你的用户名）
jekyll new blog --template https://github.com/jekyll/minima

# 如果 jekyll new 报错（网络问题），用方法二
```

**方法二：手动创建（适合熟悉结构）**

```bash
# 创建项目目录
mkdir my-blog && cd my-blog

# 创建核心文件
echo "title: 我的博客
description: 记录技术与成长
theme: minima
plugins:
  - jekyll-feed" > _config.yml

echo "# 你好，世界！
这是我的个人博客，基于 GitHub Pages 搭建。

## 关于我
全栈开发者，热爱开源和分享。" > index.md

echo "const intros = document.querySelectorAll('article p');
console.log('博客已加载 ✨');" > script.js
```

### 3.3 选择并安装主题

GitHub Pages 官方支持的主题（开箱即用）：

| 主题 | 风格 | GitHub Stars | 特点 |
|:-----|:-----|:-------------|:-----|
| `minima` | 简洁极简 | 3.5k+ | 默认主题，干净清爽 |
| `cayman` | 扁平卡片 | 1.2k+ | 适合项目文档 |
| `dinky` | 左侧导航 | 1k+ | 适合技术笔记 |
| `hacker` | 黑客风 | 1.5k+ | 深色主题 |
| `midnight` | 深色简洁 | 1k+ | 适合个人博客 |
| `leap-day` | 大标题风 | 800+ | 视觉冲击强 |

**配置主题：**

```yaml
# _config.yml 中
theme: minima
```

**使用第三方主题（比如流行的 Chirpy）：**

```bash
# 方法：直接 fork 主题仓库
# 1. 访问 https://github.com/cotes2020/jekyll-theme-chirpy/fork
# 2. 将仓库名改为 <你的用户名>.github.io
# 3. 修改 _config.yml 中的个人信息
# 4. 推送即可生效
```

### 3.4 本地预览

```bash
# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve

# 访问 http://localhost:4000
# 按 Ctrl+C 停止
```

**常见问题：**

```
问题：bundle install 很慢或失败
解决：gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

问题：本地运行报错 "require': cannot load such file"
解决：bundle update

问题：修改 _config.yml 后不生效
解决：重启 jekyll serve（加 --livereload 可自动刷新）
```

> ⚠️ 注意：`baseurl` 配置和本地预览 URL 有关。如果 `baseurl: ""`，访问 `http://localhost:4000`；如果 `baseurl: "/blog"`，访问 `http://localhost:4000/blog`

### 3.5 写第一篇文章

在 `_posts/` 目录下创建文章文件：

```bash
# 创建文章目录
mkdir -p _posts

# 创建第一篇文章
cat > _posts/2026-06-11-welcome-to-my-blog.md << 'EOF'
---
layout: post
title: "欢迎来到我的博客"
date: 2026-06-11 08:00:00 +0800
categories: 随笔
tags: [hello-world, 博客]
---

## 为什么搭建这个博客？

作为一名开发者，我一直想有一个属于自己的地方来记录：

1. **技术学习笔记**：学过的知识要输出才能内化
2. **项目经验总结**：踩过的坑要记录下来
3. **生活思考**：偶尔写点技术之外的东西

## 为什么选择 GitHub Pages？

- 免费，无需服务器维护
- 支持 Markdown 写作，专注内容
- 版本控制，历史可追溯
- 全球 CDN 加速，访问速度快

期待在这个小天地里持续输出！🚀
EOF
```

---

## 番茄钟4：部署到 GitHub Pages（25分钟）

### 4.1 创建 GitHub 仓库

```bash
# 1. 登录 GitHub，点击右上角 + → New repository
# 2. 仓库名必须严格是：<你的用户名>.github.io
#    示例：如果用户名是 fangyan，仓库名就是 fangyan.github.io
# 3. 设置为 Public
# 4. 不要勾选 README（本地项目已有）
# 5. 点击 Create repository
```

### 4.2 推送到 GitHub

```bash
# 在博客项目目录中执行
# 初始化 Git（如果还没初始化）
git init

# 添加所有文件
git add .

# 首次提交
git commit -m "初始化个人博客"

# 关联远程仓库（替换成你的用户名）
git remote add origin git@github.com:你的用户名/你的用户名.github.io.git

# 推送到 GitHub
git push -u origin main
```

### 4.3 开启 Pages

1. 打开仓库 → **Settings** → **Pages**
2. 在 **Branch** 下拉选择 `main`，目录选择 `/（根目录）`
3. 点击 **Save**

等待 1-2 分钟，访问 `https://你的用户名.github.io`

### 4.4 一键部署完成后的验证

```
访问 https://你的用户名.github.io
    ↓
应该看到：
├── 博客标题（和 _config.yml 中配置的一致）
├── 第一篇文章的摘要或链接
└── 页脚有 Powered by GitHub Pages
```

**检查清单：**

| 检查项 | 期望结果 | 验证方式 |
|:-------|:---------|:---------|
| 首页正常 | 显示博客标题和内容 | 浏览器打开 URL |
| 文章可访问 | 点击文章链接能打开 | 测试 `/2026/06/11/...` |
| CSS 样式加载 | 页面有基本样式 | 看页面的颜色和布局 |
| 响应式 | 手机/电脑都能看 | 缩小浏览器窗口 |
| 404 页面 | 访问不存在页面有提示 | 访问 `/nonexistent` |

> ✋ **费曼自测**：你的博客现在已经上线了！向旁边的人解释整个过程：从本地写 Markdown 到推送部署，每一步发生了什么。如果修改了文章重新推送，网站会立即更新吗？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 本地 `bundle exec jekyll serve` 能正常预览
- [ ] 仓库名正确设置为 `<用户名>.github.io`
- [ ] 访问 `https://<用户名>.github.io` 看到博客上线
- [ ] 有一篇已发布的文章可访问

---

## 番茄钟5：自定义域名配置（25分钟）

### 5.1 域名方案对比

```
方案一：使用默认域名（免费，推荐新手）
└── https://你的用户名.github.io
└── 优点：免费、自动 HTTPS、无需任何配置
└── 缺点：URL 不够个性化

方案二：使用子域名（推荐，性价比最高）
└── https://blog.yourname.com
└── 优点：专业、免费 HTTPS、DNS 配置简单
└── 费用：仅需购买域名（约 30-100元/年）

方案三：使用裸域名/根域名（进阶）
└── https://yourname.com
└── 优点：最专业
└── 缺点：DNS 配置复杂、需要 A 记录解析
```

### 5.2 购买域名

推荐域名注册商：

| 服务商 | 价格 | 特点 |
|:-------|:-----|:------|
| **Namesilo** | 约 $8-12/年 | 性价比高，免费 Whois 隐私 |
| **Cloudflare** | 成本价（不加价） | DNS 管理最佳，DDOS 防护 |
| **GoDaddy** | 约 $10-15/年 | 最常见但附加服务贵 |
| **阿里云/腾讯云** | 约 30-60元/年 | 国内访问快，需要实名 |

```bash
# 建议：去 Namesilo 或 Cloudflare 购买
# 搜索你想要的域名（如 yourname.com）
# 加入购物车 → 付款 → 完成购买
```

### 5.3 DNS 配置

**方案一：子域名（如 blog.yourname.com）**

```
在你的 DNS 管理后台添加 CNAME 记录：

类型      名称        值                      TTL
──────   ──────     ─────────────────────   ──────
CNAME    blog       你的用户名.github.io.     600
```

**方案二：裸域名（如 yourname.com）**

```
类型      名称        值                              TTL
──────   ──────     ─────────────────────────────   ──────
A        @          185.199.108.153                  600
A        @          185.199.109.153                  600
A        @          185.199.110.153                  600
A        @          185.199.111.153                  600
```

> &#x20;注意：GitHub Pages 的 IP 地址可能会变，建议用 CNAME 方式而不是 A 记录。

### 5.4 在 GitHub 仓库配置自定义域名

```bash
# 方法一：直接在仓库设置中配置（推荐）
# Settings → Pages → Custom domain → 输入你的域名 → Save

# 方法二：创建 CNAME 文件（自动生效）
echo "blog.yourname.com" > CNAME
git add CNAME && git commit -m "配置自定义域名"
git push
```

### 5.5 等待 DNS 生效

```bash
# 检查 DNS 是否生效
nslookup blog.yourname.com

# 或
dig blog.yourname.com

# 应该显示 CNAME 指向 <用户名>.github.io

# 也可以在线工具：
# https://dnschecker.org/ 检查全球 DNS 传播情况
```

**DNS 传播时间：** 一般 10 分钟到 2 小时，最长 48 小时

### 5.6 HTTPS 自动配置

GitHub 会自动申请 Let's Encrypt 证书：

```
Settings → Pages → Custom domain
    ↓
输入域名 → Save
    ↓
等待 DNS 检查通过（Enforce HTTPS 自动变绿）
    ↓
HTTPS 证书签发完成（可能需要 5-30 分钟）
    ↓
✅ 可以通过 https://blog.yourname.com 访问
```

> ⚠️ **重要**：不要在 HTTPS 强制启用前访问，否则浏览器会缓存重定向。等 GitHub 显示 "Enforce HTTPS" 已勾选后，再访问自定义域名。

> ✋ **费曼自测**：CNAME 记录和 A 记录有什么区别？为什么 GitHub Pages 推荐用 CNAME 而不是 A 记录？（提示：GitHub Pages 的 IP 可能会变）

---

## 番茄钟6：GitHub Actions 自动部署 Pages（25分钟）

### 6.1 为什么需要 Actions 部署

虽然 Jekyll 可以直接在 Pages 设置中部署，但用 Actions 有以下好处：

```
Pages 默认部署                     Actions 部署
────────────────────────────────  ────────────────────────────────
只支持 Jekyll                     支持任意静态站点生成器
构建日志有限                       完整构建日志可查看
无法自定义构建步骤                   完全控制构建流程
不支持构建缓存                     支持缓存加速
构建失败原因不明确                   每一步都可调试
```

### 6.2 创建 Actions 部署工作流

```yaml
# 文件路径：.github/workflows/deploy.yml

name: Deploy to GitHub Pages

on:
  # 推送到 main 分支时触发
  push:
    branches: [main]
  # 允许手动触发
  workflow_dispatch:

# 权限设置
permissions:
  contents: read
  pages: write
  id-token: write

# 同一时间只允许一个部署运行
concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: 检出代码
        uses: actions/checkout@v4

      - name: 设置 Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          bundler-cache: true

      - name: 安装依赖
        run: |
          bundle install

      - name: 构建站点
        run: |
          bundle exec jekyll build
        env:
          JEKYLL_ENV: production

      - name: 上传构建产物
        uses: actions/upload-pages-artifact@v3
        with:
          path: "./_site"

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: 部署到 GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 6.3 工作流详解

```yaml
# 触发器说明
on:
  push:
    branches: [main]      # main 分支有推送时触发
  workflow_dispatch:       # 也可以在 Actions 页面手动触发

# 权限说明
permissions:
  contents: read           # 读取仓库内容
  pages: write             # 写入 Pages 部署
  id-token: write          # 身份认证令牌

# 两个 Job 的分工
build（构建）:
  1. checkout → 拉取代码
  2. setup-ruby → 配置 Ruby 环境
  3. bundle install → 安装 Jekyll 依赖
  4. jekyll build → 生成静态文件到 _site/
  5. upload-pages-artifact → 上传构建产物

deploy（部署）:
  1. 依赖 build 完成后执行
  2. deploy-pages → 部署到 Pages 服务
```

### 6.4 开启 Actions Pages

```bash
# 1. 创建 workflows 目录
mkdir -p .github/workflows

# 2. 将上面的 YAML 保存到 .github/workflows/deploy.yml
# 3. 推送到 GitHub
git add .github/
git commit -m "配置 GitHub Actions 自动部署 Pages"
git push
```

然后在仓库设置中：

```
Settings → Pages → Source → 选择 "GitHub Actions"
```

### 6.5 使用其他静态站点生成器（2026 新特性）

2026 年 GitHub Pages 不再局限于 Jekyll。以下是一些流行的替代方案：

**使用 Hugo 构建：**

```yaml
# .github/workflows/hugo-deploy.yml
name: Deploy Hugo Site

on:
  push:
    branches: [main]

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: 安装 Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'

      - name: 构建
        run: hugo --minify

      - name: 部署
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

**使用 Next.js 构建（Static Export）：**

```yaml
# .github/workflows/nextjs-deploy.yml
name: Deploy Next.js Site

on:
  push:
    branches: [main]

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: 安装 Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'

      - name: 安装依赖
        run: npm ci

      - name: 构建
        run: npm run build
        env:
          NEXT_PUBLIC_BASE_PATH: /<你的仓库名>

      - name: 部署
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./out
```

### 6.6 预览部署（Preview Deployments）

2026 年 Pages 支持 PR 预览部署：

```yaml
# 在 deploy.yml 中添加
on:
  pull_request:
    branches: [main]

# 添加预览 job
  preview:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
      - run: bundle install
      - run: bundle exec jekyll build
      - name: 部署预览
        uses: actions/deploy-pages@v4
        with:
          preview: true  # 启用预览模式
```

这样每次创建 PR 时，GitHub 会自动生成一个预览链接（如 `https://<用户名>.github.io/pr-preview/pr-3/`），方便 Review。

> ✋ **费曼自测**：为什么用 Actions 部署比 Pages 默认部署更灵活？如果我想用 VuePress 构建文档站点，应该修改工作流中的哪些部分？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 自定义域名 DNS 已配置并生效
- [ ] 能通过自定义域名访问博客
- [ ] HTTPS 已自动启用
- [ ] Actions 工作流成功运行一次
- [ ] 理解工作流中 build 和 deploy 两个 job 的分工

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

**GitHub Pages 完整工作流：**

```
                            ┌──────────────────┐
                            │  你写 Markdown    │
                            │  文章 + Front     │
                            │  Matter 元数据    │
                            └────────┬─────────┘
                                     │
                                     ▼
                            ┌──────────────────┐
                            │  git push 到      │
                            │  GitHub 仓库      │
                            └────────┬─────────┘
                                     │
                  ┌──────────────────┼──────────────────┐
                  ▼                  ▼                  ▼
        ┌─────────────────┐  ┌──────────────┐  ┌──────────────┐
        │ 默认 Jekyll 构建 │  │ Actions 构建  │  │ 直接部署静态  │
        │（零配置，有限制）│  │（灵活，可控） │  │  文件（最快） │
        └────────┬────────┘  └──────┬───────┘  └──────┬───────┘
                 │                  │                  │
                 └──────────────────┼──────────────────┘
                                    ▼
                         ┌──────────────────┐
                         │  静态 HTML/CSS   │
                         │  部署到 CDN 网络 │
                         └────────┬─────────┘
                                  │
                                  ▼
                         ┌──────────────────┐
                         │  用户通过浏览器   │
                         │  访问你的网站     │
                         └──────────────────┘
```

### 7.2 你今天学到的所有命令

**Jekyll 命令：**

| 命令 | 功能 | 使用频率 |
|:-----|:-----|:---------|
| `jekyll new <name>` | 创建新 Jekyll 项目 | 低（项目初始化） |
| `jekyll build` | 构建生成静态文件 | 中 |
| `jekyll serve` | 本地预览（含构建） | 高（开发时） |
| `bundle install` | 安装 Ruby 依赖 | 中 |
| `bundle update` | 更新 Ruby 依赖 | 低 |

**Git 命令（回顾）：**

| 命令 | 功能 | 使用频率 |
|:-----|:-----|:---------|
| `git init` | 初始化仓库 | 低 |
| `git add .` | 暂存所有文件 | 高 |
| `git commit -m ""` | 提交 | 高 |
| `git push` | 推送到远程 | 高 |
| `git remote add origin <url>` | 关联远程仓库 | 低 |

**域名相关：**

| 命令/工具 | 功能 |
|:----------|:-----|
| `nslookup <domain>` | 查看 DNS 解析 |
| `dig <domain>` | DNS 详细查询 |
| `echo "domain" > CNAME` | 配置自定义域名 |

### 7.3 刻意练习复盘

回答三个问题：

1. **今天哪个操作最不熟练？** ____（回去再练 3 次）
2. **哪个概念最抽象？** ____（试试用类比解释）
3. **哪些场景会用 Pages 部署？** ____

### 7.4 常见错误速查

| 问题 | 原因 | 解决方案 |
|:-----|:-----|:---------|
| 访问显示 404 | 仓库名不是 `<用户名>.github.io` | 检查仓库命名规则 |
| CSS 样式不加载 | `baseurl` 配置错误 | User Site 留空，Project Site 填仓库名 |
| 自定义域名不生效 | DNS 没传播或 CNAME 不对 | `dig` 检查解析，等待传播 |
| HTTPS 无法启用 | DNS 未完全解析 | 等 DNS 全球生效后再试 |
| Actions 部署失败 | Ruby 版本不兼容 | 检查 `ruby/setup-ruby` 中版本号 |
| 图片显示 404 | 使用了绝对路径 | 改用 `{{ site.baseurl }}/images/xxx.png` |
| `bundle install` 慢 | RubyGems 源在国外 | 换国内镜像源 |

---

## 番茄钟8：输出成果（25分钟）

### 8.1 创建学习笔记

```markdown
# GitHub 学习笔记 - Day 4

> 日期：2026-06-11
> 完成状态：✅

## 核心结论
掌握了 GitHub Pages 从零部署个人博客的完整流程。

## 关键要点
1. 三种 Pages 类型：User Site（单仓库）、Project Site（多项目）、Workflow Pages（自定义）
2. Jekyll 工作流：Markdown + Front Matter → _config.yml → 静态 HTML
3. 自定义域名：CNAME 记录 → 仓库设置 → 自动 HTTPS
4. Actions 部署：build（构建）→ deploy（部署）两阶段流水线
5. 2026 新特性：任意生成器支持、Preview Deployments、构建速度提升

## 经验总结
- 最难的是：____
- 最有收获的是：____
- 下一步想深入的是：____
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：能画出 Pages 部署原理图，解释三种 Pages 类型
- [ ] **番茄3-4**：Jekyll 博客从零搭建并上线成功
- [ ] **番茄5-6**：配置了自定义域名 + Actions 工作流部署成功
- [ ] **番茄7-8**：创建了今日学习笔记

### 8.3 进阶挑战（可选）

**挑战 1：更换主题**
```bash
# 尝试 cayman 主题
echo "theme: cayman" > _config.yml
git add . && git commit -m "更换主题为 cayman"
git push
```

**挑战 2：添加评论系统**
```markdown
# 使用 utterances（基于 GitHub Issues 的评论系统）
# 1. 访问 https://github.com/apps/utterances 安装
# 2. 在文章底部添加：

<script src="https://utteranc.es/client.js"
        repo="你的用户名/你的用户名.github.io"
        issue-term="title"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>
```

**挑战 3：配置 Google Analytics**
```yaml
# _config.yml 中添加
google_analytics: UA-XXXXXXXXX-X

# 在 _includes/head.html 中添加（如果没有则创建）
{% if site.google_analytics %}
<script async src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '{{ site.google_analytics }}');
</script>
{% endif %}
```

**挑战 4：设置 404 页面**
```markdown
# 创建 404.md（GitHub Pages 自动识别）

---
layout: default
permalink: /404.html
---

# 404 - 页面未找到

抱歉，你访问的页面不存在。

[返回首页]({{ site.baseurl }}/)
```

### 8.4 成果展示模板

你的博客上线后，可以这样分享：

```
🚀 我的个人博客上线了！

📝 地址：https://你的用户名.github.io
⚙️ 技术栈：GitHub Pages + Jekyll + Minima 主题
📂 源码：https://github.com/你的用户名/你的用户名.github.io

第一篇博文：《欢迎来到我的博客》
记录了搭建过程和后续更新计划。

欢迎访问交流！
```

---

## 🎉 Day 4 完成！

**今日成果：**
- ✅ 理解 GitHub Pages 原理和三种部署类型
- ✅ 搭建并上线了个人博客
- ✅ 配置了自定义域名（可选）
- ✅ 编写了 GitHub Actions 自动部署工作流

**你的线上作品：**
- Primary：`https://你的用户名.github.io`
- Custom：`https://blog.yourname.com`（如果配置了）

---

## 📖 本章命令速查表

```bash
# ─── 本地开发 ─────────────────────────────────────────────
jekyll new <name>                          # 创建项目
bundle exec jekyll serve                   # 本地启动
bundle exec jekyll serve --livereload      # 自动刷新
bundle exec jekyll build                   # 构建静态文件

# ─── 部署 ──────────────────────────────────────────────────
git add . && git commit -m "更新博客"       # 提交
git push                                   # 推送上线

# ─── 域名检查 ──────────────────────────────────────────────
nslookup <your-domain>                      # DNS 解析检查
dig <your-domain>                           # 详细 DNS 查询

# ─── Actions 调试 ──────────────────────────────────────────
# GitHub → Actions → 选择 workflow → 查看日志
# 或本地测试：act -j build（需要安装 act CLI）
```

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day3-GitHub-Actions与CI-CD]] - 前一天：Actions CI/CD 基础
> - [[Day5-高级特性与AI协作]] - 下一天：Projects、Copilot、Stacked PRs
>
> **参考资源：**
> - [GitHub Pages 官方文档](https://docs.github.com/pages)
> - [Jekyll 中文文档](http://jekyllcn.com/)
> - [Pages 官方主题列表](https://pages.github.com/themes/)
> - [GitHub Actions deploy-pages](https://github.com/actions/deploy-pages)
