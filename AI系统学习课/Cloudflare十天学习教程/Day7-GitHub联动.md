# Day 7：GitHub Actions 联动 CI/CD

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：实现 GitHub 自动部署到 Cloudflare
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 CI/CD 和 GitHub Actions
🍅 番茄3-4：配置 Cloudflare API Token
🍅 番茄5-6：创建部署工作流
🍅 番茄7-8：自动化测试 + 复习输出
```

---

## 番茄钟1：理解 CI/CD

### 1.1 用大白话理解 CI/CD

**CI/CD 是什么？**

想象你是一个**面包师**：

| 传统方式 | CI/CD 自动化 |
|:---------|:-------------|
| 每次烤面包手动操作 | 机器自动烤面包 |
| 可能忘记某个步骤 | 流程标准化 |
| 质量不稳定 | 每次结果一致 |

**CI（持续集成）：** 代码提交后自动测试
**CD（持续部署）：** 测试通过后自动部署

### 1.2 GitHub Actions 工作流

```
代码推送 → GitHub Actions 触发
                ↓
            安装依赖
                ↓
            运行测试
                ↓
            构建项目
                ↓
            部署到 Cloudflare
                ↓
            自动上线
```

### 1.3 Cloudflare + GitHub 的优势

| 优势 | 说明 |
|:-----|:-----|
| **自动部署** | 推送代码自动上线 |
| **预览环境** | 每个 PR 生成预览链接 |
| **回滚便捷** | 出问题快速回滚 |
| **团队协作** | 多人开发自动同步 |

> ✋ **费曼自测**：解释 CI/CD 如何提高开发效率。

---

## 番茄钟2：GitHub Actions 基础

### 2.1 工作流文件结构

```yaml
# .github/workflows/deploy.yml
name: Deploy to Cloudflare

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Build
        run: npm run build
      
      - name: Deploy
        run: npx wrangler pages deploy ./dist
```

### 2.2 触发条件

| 触发器 | 说明 | 示例 |
|:-------|:-----|:-----|
| `push` | 推送时触发 | `branches: [main]` |
| `pull_request` | PR 时触发 | `branches: [main]` |
| `schedule` | 定时触发 | `cron: '0 0 * * *'` |
| `workflow_dispatch` | 手动触发 | - |

### 2.3 环境变量

```yaml
env:
  NODE_VERSION: '18'
  CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
  CLOUDFLARE_ACCOUNT_ID: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
```

> ✋ **费曼自测**：创建一个在 push 到 main 分支时触发的工作流文件。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] CI/CD 自动化测试和部署
- [ ] GitHub Actions 通过 YAML 文件配置
- [ ] 支持多种触发条件

---

## 番茄钟3：配置 Cloudflare API Token

### 3.1 获取 Account ID

```
Cloudflare Dashboard → 右侧边栏

Account ID: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 3.2 创建 API Token

```
My Profile → API Tokens → Create Token

选择模板：Edit Cloudflare Workers

或自定义权限：
- Account: Cloudflare Pages - Edit
- Zone: Zone - Read
- Zone: DNS - Edit

创建后复制 Token（只显示一次）
```

### 3.3 配置 GitHub Secrets

```
GitHub 仓库 → Settings → Secrets and variables → Actions

添加 Secrets：
- CLOUDFLARE_API_TOKEN: 你的 API Token
- CLOUDFLARE_ACCOUNT_ID: 你的 Account ID
```

### 3.4 权限说明

| 权限 | 用途 |
|:-----|:-----|
| `Account.Cloudflare Pages.Edit` | Pages 部署 |
| `Account.Workers Scripts.Edit` | Workers 部署 |
| `Zone.Zone.Read` | 读取域名信息 |
| `Zone.DNS.Edit` | 修改 DNS 记录 |

> ✋ **费曼自测**：创建一个用于 Pages 部署的 API Token。

---

## 番茄钟4：Pages 部署工作流

### 4.1 完整部署配置

```yaml
# .github/workflows/deploy.yml
name: Deploy to Cloudflare Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      deployments: write
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build
        run: npm run build
      
      - name: Deploy to Cloudflare Pages
        uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-website
          directory: dist
          gitHubToken: ${{ secrets.GITHUB_TOKEN }}
```

### 4.2 预览部署

**PR 自动生成预览链接：**

```yaml
# PR 时部署到预览环境
on:
  pull_request:
    branches: [ main ]

# 自动生成预览 URL
# https://xxx-branch-name.my-website.pages.dev
```

### 4.3 部署状态徽章

```markdown
# 在 README.md 中添加
[![Deploy](https://github.com/user/repo/actions/workflows/deploy.yml/badge.svg)](https://github.com/user/repo/actions/workflows/deploy.yml)
```

> ✋ **费曼自测**：创建一个完整的 Pages 部署工作流。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] API Token 创建成功
- [ ] GitHub Secrets 配置完成
- [ ] 部署工作流文件创建

---

## 番茄钟5：Workers 部署工作流

### 5.1 Workers 部署配置

```yaml
# .github/workflows/deploy-worker.yml
name: Deploy Worker

on:
  push:
    branches: [ main ]
    paths:
      - 'worker/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install Wrangler
        run: npm install -g wrangler
      
      - name: Deploy Worker
        run: |
          cd worker
          wrangler deploy
        env:
          CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
```

### 5.2 环境变量管理

```yaml
# 在 wrangler.toml 中引用
[[kv_namespaces]]
binding = "MY_KV"
id = ${{ secrets.KV_NAMESPACE_ID }}

# 或在工作流中设置
- name: Deploy with secrets
  run: wrangler deploy
  env:
    CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
```

### 5.3 版本管理

```yaml
- name: Get version
  id: version
  run: echo "VERSION=$(date +%Y%m%d-%H%M%S)" >> $GITHUB_OUTPUT

- name: Deploy with version
  run: wrangler deploy --version ${{ steps.version.outputs.VERSION }}
```

> ✋ **费曼自测**：创建一个 Workers 部署工作流。

---

## 番茄钟6：自动化测试

### 6.1 添加测试步骤

```yaml
jobs:
  test-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
        if: success()
      
      - name: Deploy
        uses: cloudflare/pages-action@v1
        if: success() && github.ref == 'refs/heads/main'
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-website
          directory: dist
```

### 6.2 Lint 检查

```yaml
- name: Lint
  run: npm run lint

- name: Type check
  run: npm run type-check
```

### 6.3 部署通知

```yaml
- name: Notify on success
  if: success()
  run: |
    curl -X POST ${{ secrets.WEBHOOK_URL }} \
      -H 'Content-Type: application/json' \
      -d '{"text": "Deploy successful!"}'

- name: Notify on failure
  if: failure()
  run: |
    curl -X POST ${{ secrets.WEBHOOK_URL }} \
      -H 'Content-Type: application/json' \
      -d '{"text": "Deploy failed!"}'
```

### 6.4 刻意练习任务

```markdown
## CI/CD 配置任务

- [ ] 创建 API Token
- [ ] 配置 GitHub Secrets
- [ ] 创建部署工作流
- [ ] 添加测试步骤
- [ ] 测试自动部署
```

> ✋ **费曼自测**：创建一个包含测试和部署的完整工作流。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 部署工作流运行成功
- [ ] 测试步骤通过
- [ ] 自动部署生效

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**CI/CD 速记：**

```
CI/CD = 自动化测试 + 自动化部署

GitHub Actions 配置：
1. 创建工作流文件
2. 配置触发条件
3. 设置 Secrets
4. 定义部署步骤

关键配置：
- API Token：Cloudflare 权限
- Account ID：账号标识
- Secrets：敏感信息安全存储
```

### 7.2 工作流模板

```yaml
# 最小可用模板
name: Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-project
          directory: dist
```

### 7.3 常见问题

| 问题 | 解决方案 |
|:-----|:---------|
| Token 无效 | 检查权限设置 |
| 部署失败 | 查看工作流日志 |
| Secrets 未生效 | 确认名称正确 |

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 7

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
GitHub Actions 实现代码推送自动部署，提高开发效率。

## 关键要点

### 1. CI/CD 配置
- 创建工作流文件
- 设置触发条件
- 配置部署步骤

### 2. 权限配置
- API Token 权限
- GitHub Secrets
- 环境变量

### 3. 自动化流程
- 代码检查
- 测试运行
- 自动部署

## 明日计划
- 学习安全防护与 WAF
- 配置防护规则
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 CI/CD 原理
- [ ] **番茄3-4**：配置 API Token 和 Secrets
- [ ] **番茄5-6**：创建完整的部署工作流
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 7 完成！

**今日成果：**
- ✅ 理解 CI/CD 原理
- ✅ 配置 GitHub Actions
- ✅ 实现自动部署

**明天预告：** [[Day8-安全防护]] - 学习 WAF 和安全防护

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day6-Workers]] - 上一天内容
