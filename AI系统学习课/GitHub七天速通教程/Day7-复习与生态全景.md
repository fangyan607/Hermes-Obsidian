# Day 7：复习与生态全景

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：Week 1 知识整合，掌握 GitHub 2026 生态全景
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：综合复习考试 + 能力自评

---

## 今日学习路径

```
🍅 番茄1-2：Week 1 知识回顾 + GitHub CLI 高级用法
🍅 番茄3-4：GitHub 生态全景 + 2026 平台趋势
🍅 番茄5-6：综合复习考试 + 安全最佳实践
🍅 番茄7-8：试卷复盘 + 持续学习路径
```

---

## 番茄1：Week 1 知识回顾（25分钟）

### 1.1 六天核心概念速查表

这是过去 6 天所有核心概念的**一键速查表**——快速浏览，标记你不确定的部分，后面重点复习。

#### Day 1：Git 基础与仓库管理

```
核心公式：工作区 → git add → 暂存区 → git commit → 本地仓库 → git push → 远程仓库
```

| 概念 | 一句话说明 | 关键命令 |
|:-----|:-----------|:---------|
| Git 三大区域 | 工作区（编辑）→ 暂存区（选中）→ 仓库（存档） | `git add` / `git commit` |
| SSH Key | 数字身份证，免密连接 GitHub | `ssh-keygen -t ed25519` |
| 分支 | 平行宇宙，互不干扰 | `git branch` / `git checkout -b` |
| 克隆/推送/拉取 | 同步本地与远程 | `git clone` / `git push` / `git pull` |

**必会命令**：`git status` → `git add` → `git commit` → `git push` → `git pull` → `git log --oneline`

#### Day 2：分支与协作工作流

```
核心流程：Fork/Clone → Branch → Commit → Push → PR → Review → Merge
```

| 概念 | 一句话说明 | 关键命令/操作 |
|:-----|:-----------|:--------------|
| Pull Request (PR) | 请求合并代码的"申请单" | GitHub 网页创建 |
| Code Review | 代码审核，团队把关质量 | PR 上的评论 + 修改建议 |
| 合并冲突 | 同一文件同一位置被多人修改 | 手动编辑冲突标记 → `git add` → 完成合并 |
| Issue | 任务跟踪单（Bug / Feature / Discussion） | GitHub Issues 面板 |
| 分支保护规则 | 防止直接推送到重要分支 | Settings → Branches → Add rule |

**PR 黄金三原则**：
1. 一个 PR 只做一件事
2. PR 标题 = 做了什么 + 为什么
3. PR 描述 = 背景 + 改动 + 测试说明

#### Day 3：GitHub Actions CI/CD

```
核心结构：.github/workflows/*.yml → 事件触发 → Job → Step → Action
```

| 概念 | 一句话说明 |
|:-----|:-----------|
| Workflow | 一个完整的自动化流程（YAML 文件） |
| Event | 触发 Workflow 的事件（push、pull_request、schedule） |
| Job | 一系列步骤，运行在同一 Runner 上 |
| Step | 一个具体的操作（运行命令或使用 Action） |
| Action | 可复用的自动化单元（来自 Marketplace 或自定义） |
| Runner | 执行 Workflow 的服务器（GitHub 托管或自托管） |

**经典 CI 流程**：
```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install && npm test
```

#### Day 4：GitHub Pages 部署

```
核心流程：推送到指定分支/目录 → GitHub 自动构建 → 上线访问
```

| 概念 | 一句话说明 |
|:-----|:-----------|
| Pages 站点类型 | 个人/组织（`username.github.io`）vs 项目（`username.github.io/repo`） |
| 部署方式 | 从分支部署 / 从 Actions 工作流部署 |
| 自定义域名 | 在仓库 Settings → Pages 配置 CNAME |
| Jekyll/Hugo | 静态站点生成器，与 Pages 原生集成 |

**三种部署方式**：
```
1. 最简单：Settings → Pages → 选择 main 分支的 /root
2. 灵活：.github/workflows/deploy.yml 自定义构建
3. 静态生成器：本地 Jekyll/Hugo 构建 → 推送到 gh-pages 分支
```

#### Day 5：高级特性与 AI 协作

| 概念 | 一句话说明 |
|:-----|:-----------|
| GitHub Projects | 项目管理看板（Board View / Table View / Roadmap） |
| GitHub Copilot | AI 编程助手，提供实时代码建议 |
| Copilot Chat | IDE 内对话式 AI 编程辅导 |
| Stacked PRs | 将大 PR 拆成多个小 PR 串行提交的进阶工作流 |
| GitHub CLI (gh) | 用命令行管理 GitHub 全部操作 |

#### Day 6：开源贡献实战

```
核心流程：找到项目 → Fork → Clone → 创建分支 → 修改 → Push → PR → 等待合并
```

| 概念 | 一句话说明 |
|:-----|:-----------|
| Fork | 复制别人的仓库到你的 GitHub 账号下 |
| CONTRIBUTING.md | 项目的贡献指南（必读） |
| CODE_OF_CONDUCT.md | 社区行为准则 |
| Good First Issue | 标注了"适合新手"的 Issue |
| Upstream | 原始项目仓库（你 fork 的来源） |

**同步上游仓库**：
```bash
git remote add upstream https://github.com/原项目/repo.git
git fetch upstream
git merge upstream/main
```

> ✋ **费曼自测**：不看上面的表格，你能说出每个 Day 学到的最重要的 3 个概念吗？如果某个 Day 的内容你完全想不起来，把这个番茄钟剩下的时间用来回顾那天的文件。

---

### 1.2 Week 1 技能雷达图

在进入后面内容前，先做一个**快速自评**（1-5 分）：

```
技能                   评分          亟需练习    已掌握
──────────────────────────────────────────────────────────
Git 基本操作           ⭐⭐☆☆☆     [ ]         [ ]
分支与合并             ⭐⭐☆☆☆     [ ]         [ ]
Pull Request 流程      ⭐⭐☆☆☆     [ ]         [ ]
Code Review           ⭐⭐☆☆☆     [ ]         [ ]
解决合并冲突           ⭐⭐☆☆☆     [ ]         [ ]
GitHub Actions        ⭐⭐☆☆☆     [ ]         [ ]
GitHub Pages          ⭐⭐☆☆☆     [ ]         [ ]
GitHub Projects       ⭐⭐☆☆☆     [ ]         [ ]
GitHub Copilot        ⭐⭐☆☆☆     [ ]         [ ]
开源贡献流程           ⭐⭐☆☆☆     [ ]         [ ]
GitHub CLI (gh)       ⭐⭐☆☆☆     [ ]         [ ]
──────────────────────────────────────────────────────────
总评分：____/55
```

> **自我诊断**：
> - **45-55**：你已经可以教别人了！
> - **35-44**：大部分掌握，个别薄弱环节需要强化
> - **20-34**：有几个关键技能还没形成肌肉记忆，多练
> - **<20**：建议重新学习 Day 1-6 的相应部分

---

## 🍅 番茄1结束，休息5分钟

**快速验证**：
- [ ] 快速浏览了 Day 1-6 的核心概念
- [ ] 完成技能雷达图自评
- [ ] 标记了需要重点复习的薄弱环节

---

## 番茄2：GitHub CLI 高级用法（25分钟）

### 2.1 什么是 GitHub CLI？

GitHub CLI（`gh`）让你**不用打开浏览器**，直接在终端完成所有 GitHub 操作。

```
浏览器操作：打开 GitHub → 点按钮 → 填表单 → 点确认
gh 操作：    gh pr create → 完事（10 秒）
```

### 2.2 安装与配置

```bash
# macOS
brew install gh

# Windows (winget)
wing install GitHub.cli

# Linux (Ubuntu/Debian)
sudo apt install gh

# 验证安装
gh --version

# 登录认证
gh auth login
# 选择：GitHub.com → HTTPS → Login with a web browser → 复制验证码 → 浏览器中确认
```

### 2.3 gh 命令速查表

这是目前 `gh` CLI 支持的全部核心功能，按使用频率排列：

#### PR 管理（日常最常用）

```bash
# 创建 PR（当前分支 → 默认目标分支）
gh pr create --title "添加用户登录功能" --body "实现了邮箱密码登录"

# 创建 PR 时指定目标分支
gh pr create --base main --head feature-login --title "..." --body "..."

# 创建 PR 并填写模板
gh pr create --fill          # 使用 git trailer 信息填充

# 查看 PR 列表（默认只显示 open）
gh pr list
gh pr list --state all       # 包含已关闭的
gh pr list --assignee @me    # 分配给自己的
gh pr list --label bug       # 按标签筛选
gh pr list --author @me      # 自己创建的

# 查看 PR 详情
gh pr view 123               # 查看 PR #123
gh pr view --web             # 在浏览器中打开

# 查看 PR 中的修改
gh pr diff 123

# 查看 PR 检查状态
gh pr checks 123

# 合并 PR
gh pr merge 123              # 默认 merge commit
gh pr merge 123 --squash     # Squash merge
gh pr merge 123 --rebase     # Rebase merge

# 在本地检出 PR
gh pr checkout 123

# 关闭 PR（不合并）
gh pr close 123

# 重新打开 PR
gh pr reopen 123

# 添加 reviewer
gh pr edit 123 --add-reviewer username
```

#### Issue 管理

```bash
# 创建 Issue
gh issue create --title "登录页面样式问题" --body "在移动端按钮偏移了 2px"

# 创建 Issue 并添加 label
gh issue create --label bug --label ui --title "..." --body "..."

# 查看 Issue
gh issue list
gh issue list --assignee @me
gh issue list --label "good first issue"
gh issue list --state closed

# 查看 Issue 详情
gh issue view 456
gh issue view --web

# 关闭 Issue
gh issue close 456

# 重新打开
gh issue reopen 456

# 评论 Issue
gh issue comment 456 --body "我来修复这个问题！"

# 查看 Issue 状态
gh issue status
```

#### 仓库操作

```bash
# 查看仓库信息
gh repo view
gh repo view owner/repo     # 查看其他仓库
gh repo view --web          # 在浏览器中打开

# 搜索仓库
gh search repos "机器学习" --limit 10
gh search repos --owner microsoft --language python --stars ">1000"

# 克隆仓库
gh repo clone owner/repo

# Fork 仓库
gh repo fork owner/repo
gh repo fork --clone         # Fork 并克隆到本地

# 创建仓库
gh repo create my-new-repo --public --clone
gh repo create my-new-repo --private --add-readme --gitignore Node

# 删除仓库
gh repo delete owner/repo    # 需要确认

# 查看仓库 Fork
gh repo fork --remote
```

#### GitHub Actions 管理

```bash
# 查看 Workflow 列表
gh workflow list
gh workflow list --all       # 包含已禁用的

# 手动触发 Workflow
gh workflow run build.yml
gh workflow run deploy.yml --ref main  # 指定分支

# 查看 Workflow 运行状态
gh run list
gh run list --workflow=build.yml
gh run list --status=failure

# 查看运行详情
gh run view 789
gh run view --log --failed   # 只看失败步骤的日志

# 重新运行
gh run rerun 789
gh run rerun --failed        # 只重跑失败的 Job

# 取消运行
gh run cancel 789

# 下载 artifacts
gh run download 789
```

#### 个人与配置管理

```bash
# 查看通知
gh notification list
gh notification list --all   # 包含已读

# 标记为已读
gh notification read 123

# 查看我的信息
gh api user                  # 查看当前用户信息
gh api repos                 # 查看所有仓库

# 配置设置
gh config set editor vim     # 设置默认编辑器
gh config get editor         # 查看配置

# 切换账号（支持多账号）
gh auth switch

# 缓存状态
gh auth status

# 浏览 GitHub（在浏览器中打开）
gh browse                    # 打开当前仓库
gh browse --branch feature   # 打开指定分支
gh browse --settings         # 打开仓库设置
gh browse main.go            # 打开文件
gh browse main.go -b main:3  # 打开文件第 3 行
```

#### 高级操作

```bash
# 使用 gh api 直接调用 REST API（可以做任何 GitHub 能做的事）
gh api repos/:owner/:repo   # 查看仓库信息
gh api repos/:owner/:repo/issues  # 列出所有 Issue
gh api --method POST repos/:owner/:repo/issues -f title="New Issue" -f body="Body"

# 使用 GraphQL
gh api graphql -f query='query { viewer { login } }'

# Gist 管理
gh gist list
gh gist create file.txt
gh gist create file.txt --public

# 查看 GitHub 状态
gh api https://www.githubstatus.com/api/v2/summary.json | jq '.components'
```

### 2.4 gh 实用工作流组合

```bash
# == 快速 PR 流（每天用 10 次）==
git checkout -b fix/typo
echo "fix" >> README.md
git add . && git commit -m "修复 typo"
git push -u origin fix/typo
gh pr create --fill --label bug

# == 批量查看待处理的 PR ==
gh pr list --assignee @me --json number,title,headRefName,createdAt

# == 快速 Issue 回复 ==
gh issue comment 456 --body "感谢报告，已修复在 #123 中"

# == 一键发布 ==
gh workflow run deploy.yml --ref main && gh run watch

# == 查看最近失败的 CI ==
gh run list --status=failure --limit 5 --json workflowName,headBranch,conclusion,url

# == 搜索开源项目练手 ==
gh search issues --label "good first issue" --limit 20 --language python
```

### 2.5 gh 对比 Web 操作

| 操作 | Web 操作 | gh 操作 | 耗时 |
|:-----|:---------|:--------|:-----|
| 创建 PR | 5 次点击 + 填表单 | `gh pr create --fill` | 10 秒 vs 2 分钟 |
| 查看分配的 PR | 打开页面 → 筛选 → 过滤 | `gh pr list --assignee @me` | 2 秒 vs 30 秒 |
| 合并 PR | 打开 PR → 等加载 → 点合并 | `gh pr merge 123` | 3 秒 vs 30 秒 |
| 重跑失败 CI | 打开 Actions → 找到 → 点重跑 | `gh run rerun --failed` | 3 秒 vs 1 分钟 |
| 创建 Issue | 打开项目 → New Issue → 填表 | `gh issue create -t "..." -b "..."` | 10 秒 vs 1 分钟 |

> ✋ **费曼自测**：向一个只用 GitHub 网页的人解释，为什么 gh CLI 能提升 10 倍效率。你能说出至少 3 个 gh 可以一键完成、但网页操作需要多步的场景吗？

---

## 🍅 番茄2结束，休息5分钟

**验证清单**：
- [ ] `gh --version` 显示版本号
- [ ] `gh auth status` 显示已登录
- [ ] `gh pr list` 显示当前仓库的 PR 列表
- [ ] `gh issue list --assignee @me` 显示分配给自己的 Issue
- [ ] `gh workflow list` 显示仓库的 Workflow

---

## 番茄3：GitHub 生态全景（25分钟）

### 3.1 生态全景图

下面是 2026 年 GitHub 生态系统的完整地图——它已经远不止是一个"代码托管平台"了。

```
┌─────────────────────────────────────────────────────────┐
│                   GitHub 生态全景（2026）                  │
├─────────────────────────────────────────────────────────┤
│                                                          │
│   ┌─────────────┐    ┌──────────────┐    ┌───────────┐  │
│   │   Copilot   │    │   Actions    │    │  Packages │  │
│   │   AI 编程    │    │   CI/CD      │    │  包管理    │  │
│   │  Agent 编排  │    │  2B+ min/周  │    │  私有托管  │  │
│   └──────┬──────┘    └──────┬───────┘    └─────┬─────┘  │
│          │                  │                   │        │
│          └──────────┬───────┴──────────┐        │        │
│                     │                  │                │
│          ┌──────────▼──────────┐       │                │
│          │   GitHub 核心平台    │       │                │
│          │  (Repos + Issues +  │◄──────┘                │
│          │   PRs + Discussions)│                        │
│          └──────────┬──────────┘                        │
│                     │                                    │
│    ┌────────────────┼────────────────┐                   │
│    │                │                │                   │
│    ▼                ▼                ▼                   │
│ ┌────────┐   ┌──────────┐   ┌──────────────┐           │
│ │Pages   │   │Codespaces│   │   Mobile     │           │
│ │ 静态部署 │   │ 云端开发   │   │  移动管理    │           │
│ └────────┘   └──────────┘   └──────────────┘           │
│                                                          │
│ ┌──────────────────────────────────────────────────┐    │
│ │              安全基础设施                          │    │
│ │  Dependabot  │  Secret Scanning  │  2FA  │  SSO  │    │
│ └──────────────────────────────────────────────────┘    │
│                                                          │
│ ┌──────────────────────────────────────────────────┐    │
│ │           社区与协作                               │    │
│ │  Discussions  │  Sponsors  │  Star  │  Fork      │    │
│ └──────────────────────────────────────────────────┘    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 3.2 各生态模块详解

#### GitHub Copilot（AI 编程的核心入口）

**Copilot Desktop App (2026)** 已经成为 AI Agent 编排中心：

```
Copilot Desktop App 能力架构
┌─────────────────────────────────────────────┐
│           Copilot Desktop App               │
├─────────────────────────────────────────────┤
│  ┌──────────────────────────────────────┐   │
│  │  Agent 模式                          │   │
│  │  • 自动化 Issue 修复                 │   │
│  │  • PR 代码审查                       │   │
│  │  • 文档自动生成                      │   │
│  │  • 测试用例编写                      │   │
│  └──────────────────────────────────────┘   │
│  ┌──────────────────────────────────────┐   │
│  │  Chat 模式                           │   │
│  │  • 代码解释                         │   │
│  │  • 重构建议                         │   │
│  │  • 最佳实践查询                     │   │
│  └──────────────────────────────────────┘   │
│  ┌──────────────────────────────────────┐   │
│  │  内嵌工具                            │   │
│  │  • 终端集成                         │   │
│  │  • 文件编辑                         │   │
│  │  • Git 操作                         │   │
│  │  • 代码搜索                         │   │
│  └──────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

**Copilot 数据**：支持 100+ 编程语言，每天被 300 万+ 开发者使用。

#### GitHub Actions（自动化引擎）

- **规模**：每周运行 20 亿分钟（2B+ minutes/week）
- **Marketplace**：20000+ 个社区 Action
- **主要用途**：
  - CI/CD（最常用）
  - 自动化 Issue/PR 管理
  - 定时任务（数据备份、报告生成）
  - 基础设施即代码（IaC）
  - 包发布自动化

```yaml
# Actions 生态的典型用法
name: 全自动化发布
on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci && npm run build
      - uses: actions/upload-artifact@v4
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

#### GitHub Packages（私有包托管）

如同 Docker Hub 和 npm 的"GitHub 版本"：

| 包类型 | 命令 | 用途 |
|:-------|:-----|:------|
| Docker 镜像 | `docker push ghcr.io/owner/image` | 容器镜像 |
| npm 包 | `npm publish --registry=https://npm.pkg.github.com` | JavaScript 包 |
| NuGet | `dotnet nuget push` | .NET 包 |
| Maven | `mvn deploy` | Java 包 |
| RubyGems | `gem push` | Ruby 包 |

**优势**：和 GitHub 仓库的权限一体化，无需单独配置认证。

#### GitHub Codespaces（云端开发环境）

```
传统开发环境设置：
找电脑 → 装系统 → 装 IDE → 装 SDK → 配置环境 → 克隆代码 → 跑起来
                                                      耗时：2小时起步

Codespaces 设置：
点一下 "Open in Codespaces" → 浏览器打开 → 可以直接编码
                                                      耗时：30秒
```

- **配置**：`.devcontainer/devcontainer.json`
- **规格**：2-32 核 CPU，4-64 GB RAM 可选
- **持久化**：代码存 GitHub，环境配置在 `devcontainer.json` 中版本控制
- **集成**：VS Code Web / JetBrains Gateway / 终端 SSH

#### GitHub Mobile（移动端管理）

```text
随时随地：
● 审查 PR          ← 排队时掏出手机看代码
● 回复评论          ← 队友 @ 你时秒回
● 合并紧急 PR       ← 上线前最后一刻批准
● 查看 CI 状态      ← 确认部署成功
● 关闭过期 Issue    ← 清理 backlog
```

> **最佳实践**：GitHub Mobile 适合"看一眼"和"回一句"，不适合"写代码"。

#### GitHub Discussions（社区讨论）

```
GitHub Discussions 和 Issues 的分工：

Issues              Discussions
─────────           ───────────────
任务跟踪             开放讨论
报告 Bug            提问与解答
功能请求             社区交流
有明确结论           探索性话题
需要分配负责人       不需要指定负责人
```

### 3.3 生态模块互操作性

这些模块不是孤立的——它们深度集成：

```text
场景：开发一个新功能
1. Developer 在 Codespaces 中编码（云端开发环境）
2. Push 代码触发 Actions 自动测试（CI/CD）
3. 创建 PR → Copilot Agent 自动审查代码（AI 审查）
4. PR 合并 → Actions 构建 Docker 镜像 → 推送到 Packages（包管理）
5. Actions 自动部署到 Pages / 服务器（部署）
6. Team 在 Discussions 中回顾成果（社区）
7. Manager 在 Mobile 上批准最终合并（移动管理）
```

> ✋ **费曼自测**：向一个不懂技术的朋友解释 GitHub 生态。你不需要解释细节，只需要说明"为什么 GitHub 不只存代码"——用 3 句话概括。

---

## 🍅 番茄3结束，休息5分钟

**验证清单**：
- [ ] 能画出 GitHub 生态全景图（至少 6 个模块）
- [ ] 能说出 Copilot Desktop App 的三种模式
- [ ] 理解 Codespaces 和本地开发的本质区别
- [ ] 知道 Discussions 和 Issues 的分工

---

## 番茄4：2026 GitHub 平台趋势（25分钟）

### 4.1 2026 年关键数据

```text
GitHub 2026 平台数据
───────────────────────────────────────
🌍 1 亿+ 开发者                     ← 全球开发者都在这里
📦 4.2 亿+ 仓库                     ← 世界最大的代码仓库
🔄 14 亿+ 提交/月                   ← 每个月 14 亿次代码提交
🔄 30 亿+ PR 创建（累计）           ← 协作的规模
🤖 300 万+ 开发者使用 Copilot       ← AI 编程已成主流
⚡ 20 亿+ Actions 分钟/周           ← 自动化无处不在
🌐 覆盖 200+ 国家和地区             ← 真正的全球化平台
```

### 4.2 五大核心趋势

#### 趋势一：AI Agent 原生开发

GitHub 正在从"AI 辅助编程"迈向"AI Agent 原生开发"：

```
2022             2024              2026
──────────       ──────────        ───────────────
Copilot          Copilot Chat      Copilot Agent
代码补全         对话式编程        自动化执行任务
↓                ↓                 ↓
"下一个token"    "帮我写函数"      "帮我修复这个 Issue
                                   分析代码 → 定位根因
                                   创建分支 → 编写修复
                                   生成测试 → 创建 PR"

```

**关键转变**：开发者从"写代码"变成"指挥 AI 写代码"。

#### 趋势二：Agentic Memory（Agent 记忆系统）

2026 年最大的突破之一——Agent 有了"记忆"：

```
传统 Agent：每次对话都是新的，不记得之前做了什么
           ┌─ 任务1 ─┐   ┌─ 任务2 ─┐   ┌─ 任务3 ─┐
           │ 忘记一切 │   │ 忘记一切 │   │ 忘记一切 │
           └─────────┘   └─────────┘   └─────────┘

Agentic Memory：
           ┌─ 任务1 ─┐   ┌─ 任务2 ─┐   ┌─ 任务3 ─┐
           │         │──▶│         │──▶│         │
           │ 记住上下文│   │ 记住决策 │   │ 学习模式 │
           └─────────┘   └─────────┘   └─────────┘
                │              │              │
                └────── 长期记忆 ────────┘
                     项目知识持续积累
```

**对开发者的意义**：
- Agent 能记住你的编码习惯（代码风格、命名规范）
- Agent 能理解项目上下文（架构决策、历史原因）
- Agent 能从中断处继续工作（不用重复描述上下文）

#### 趋势三：AI 原生工作流

```
传统开发流程：
需求 → 写代码 → 提交 → 审查 → 测试 → 部署
                              ↓
                        人做所有环节

AI 原生工作流：
需求 → Agent 写代码 → Agent 审查 → Agent 测试 → 人批准 → Agent 部署
                                                         ↓
                     AI 做 80% 工作，人做 20% 决策
```

**实际案例**：
```bash
# 一个典型的 2026 AI 原生工作流
# 1. 在 Issue 中描述需求
gh issue create --title "添加搜索功能" --body "用户应该能全文搜索文章"

# 2. Copilot Agent 自动分析并创建 PR
# （Agent 分析 Issue → 设计实现方案 → 编写代码 → 创建 PR）

# 3. 人的工作变成：审查、调整、批准
gh pr review 789 --approve
```

#### 趋势四：安全左移（Shift Left on Security）

安全措施从"上线前检查"变成"编码时预防"：

```
传统安全：
编码 → 审查 → 测试 → 部署 → 安全扫描（发现问题太晚了！）
                              ↑
                        这里才发现问题

安全左移：
编码（Secret Scanning 实时检测） → 审查（Dependabot 自动提醒） → 测试 → 部署
↑                                ↑
编码时就警报                     PR 时就阻止
```

#### 趋势五：开源商业化成熟

```
开源 3.0 模式：
Code   →   Community   →   Cloud
免费代码    社区协作      付费云服务

GitHub Sponsors / GitHub Marketplace / Copilot 分成
开源已经从"热爱驱动"变成"可持续商业模式"
```

### 4.3 这对你意味着什么？

| 如果你是 | 应该关注 |
|:---------|:---------|
| 个人开发者 | 学会用 Copilot Agent 提升效率，保持代码阅读能力 |
| 团队负责人 | 引入 AI 原生工作流，重新定义"开发"的边界 |
| 开源维护者 | 利用 AI Agent 自动化 Issue 分类和 PR 审查 |
| 初学者 | AI 工具降低了入门门槛，但基本功（Git/代码能力）仍是核心竞争力 |
| 技术管理者 | 关注安全左移策略，在流程层面引入自动化安全检测 |

### 4.4 开发者的新核心素养（2026）

```
2026 年 GitHub 开发者核心素养：
────────────────────────────────
1️⃣ AI 协作能力     ← 知道什么时候信任 AI，什么时候自己写
2️⃣ 代码审查能力    ← AI 写代码越来越多，人审代码越来越重要
3️⃣ 安全思维        ← Secret Scanning、Dependabot 成为日常
4️⃣ 自动化思维      ← 能用 Actions 自动化的绝不用手动
5️⃣ 全栈意识        ← CI/CD + 部署 + 运维一体化
```

> ✋ **费曼自测**：用你自己的话总结"AI Agent 原生开发"和"AI 辅助编程"的本质区别。为什么说 2026 年开发者的核心能力不再是"写代码"？

---

## 🍅 番茄4结束，休息5分钟

**验证清单**：
- [ ] 理解 AI Agent 原生开发和传统编程的区别
- [ ] 理解 Agentic Memory 的概念
- [ ] 能说出 2026 GitHub 的三大趋势

---

## 番茄5：综合复习考试（25分钟）

### 5.1 考试说明

```
📝 GitHub 七天速通教程 · 综合结业考试
─────────────────────────────────────────
⏱ 用时：25 分钟
📋 题数：15 题
🎯 满分：100 分
✅ 及格：70 分
🏆 优秀：90 分
📌 规则：闭卷，不看笔记，诚实自测
```

### 5.2 试卷

#### 第一部分：基础概念（每题 5 分，共 25 分）

**第 1 题**（Git 基础）：一个文件的"一生"要经过哪 4 种状态？请按顺序写出。

```
答：_______________________________________________________

参考：Untracked → Staged → Unmodified → Modified
```

**第 2 题**（Git vs GitHub）：用一句话说明 Git 和 GitHub 的本质区别。

```
答：_______________________________________________________

参考：Git 是本地版本控制工具，GitHub 是托管 Git 仓库的云端协作平台。
```

**第 3 题**（SSH Key）：SSH Key 为什么要分公钥和私钥？公钥存在哪里？私钥存在哪里？

```
答：_______________________________________________________

参考：公钥加密、私钥解密。公钥存在 GitHub 服务器上，私钥存在本地 ~/.ssh/ 目录。
公钥可以公开，私钥绝不可泄露。
```

**第 4 题**（分支）：一个团队使用以下分支策略，请解释每个分支的作用：
- `main`：
- `feature/*`：
- `release/*`：
- `hotfix/*`：

```
答：_______________________________________________________

参考：
main：稳定版本，随时可部署
feature/*：新功能开发，从 main 分支创建，合并回 main
release/*：版本发布准备，只做 Bug 修复和文档更新
hotfix/*：线上紧急修复，从 main 创建，修复后合并回 main 和当前 release
```

**第 5 题**（工作流）：写出完整的"功能开发 → 提交 → 推送 → 创建 PR → 合并"命令序列。

```
答：_______________________________________________________

参考：
git checkout -b feature/my-feature
# 编写代码...
git add . && git commit -m "feat: 添加xxx功能"
git push -u origin feature/my-feature
gh pr create --fill  # 或在网页创建 PR
# PR 审查通过后...
gh pr merge  # 或在网页点 Merge
```

#### 第二部分：协作与 CI/CD（每题 7 分，共 28 分）

**第 6 题**（合并冲突）：当你执行 `git pull` 遇到合并冲突时，描述你的**完整解决步骤**。

```
答：_______________________________________________________

参考：
1. 查看冲突文件：git status 找到冲突文件
2. 打开文件，找到 <<<<<<< HEAD（当前分支）和 ======= >>>>>>> branch（合并分支）
3. 手动编辑，保留正确代码，删除冲突标记
4. git add <file> 标记为已解决
5. git commit 完成合并
```

**第 7 题**（Code Review）：列举你会在 Code Review 中重点检查的 5 个方面。

```
答：_______________________________________________________

参考：
1. 代码逻辑是否正确（有没有 Bug）
2. 有没有安全漏洞（SQL 注入、XSS 等）
3. 代码风格是否一致（命名、缩进、注释）
4. 有没有重复代码（DRY 原则）
5. 测试是否覆盖了关键路径
```

**第 8 题**（Actions）：以下 GitHub Actions Workflow 中每一行的作用是什么？

```yaml
name: CI                                    # ①
on: [push, pull_request]                    # ②
jobs:                                       # ③
  test:                                     # ④
    runs-on: ubuntu-latest                  # ⑤
    steps:                                  # ⑥
      - uses: actions/checkout@v4           # ⑦
      - run: npm install && npm test        # ⑧
```

```
① ________________________________________________________
② ________________________________________________________
③ ________________________________________________________
④ ________________________________________________________
⑤ ________________________________________________________
⑥ ________________________________________________________
⑦ ________________________________________________________
⑧ ________________________________________________________
```

**第 9 题**（Pages）：GitHub Pages 的三部署方式分别是什么？哪种最推荐？

```
答：_______________________________________________________

参考：
1. 从分支部署（最简单）
2. 从 Actions 工作流部署（最灵活，推荐）
3. 通过静态站点生成器（Jekyll/Hugo）构建后部署
推荐方式：Actions 工作流部署，可以自定义构建过程
```

#### 第三部分：高级特性与生态（每题 7 分，共 21 分）

**第 10 题**（Copilot）：Copilot 从"代码补全"到"Agent 模式"的进化意味着什么？

```
答：_______________________________________________________

参考：从被动响应（等你写代码再补全）到主动执行（接收任务自动完成）。
Agent 模式能自主分析代码、定位问题、编写修复、创建 PR，
开发者从"写代码"变成"审查 AI 代码 + 做决策"。
```

**第 11 题**（生态）：除了代码托管，GitHub 还提供哪些主要服务？列举至少 6 个。

```
答：_______________________________________________________

参考：Actions（CI/CD）、Copilot（AI 编程）、Packages（包托管）、
Pages（静态部署）、Codespaces（云端开发环境）、Projects（项目管理）、
Discussions（社区讨论）、Mobile（移动管理）、Security（安全扫描）
```

**第 12 题**（安全）：什么是"安全左移"（Shift Left on Security）？在 GitHub 生态中如何实现？

```
答：_______________________________________________________

参考：安全左移是把安全检查从"部署后"提前到"编码时"。
GitHub 中通过 Dependabot（依赖漏洞预警）、Secret Scanning（敏感信息检测）、
CodeQL（代码质量分析）、分支保护规则等方式，在 PR 阶段就阻止安全问题进入主分支。
```

#### 第四部分：实战场景（每题 13 分，共 26 分）

**第 13 题**（完整工作流）：你收到一个任务"为项目添加搜索功能"，请写出从接到任务到代码上线的**完整 GitHub 工作流**（包括所有 Git 命令、PR 操作、CI/CD 流程）。

```
答：_______________________________________________________

参考：
1. 创建 Issue 描述需求 → gh issue create --title "添加搜索功能"
2. 创建功能分支 → git checkout -b feature/search
3. 本地开发 → 编码 + 本地测试
4. 提交 → git add . && git commit -m "feat: 实现全文搜索"
5. 推送 → git push -u origin feature/search
6. 创建 PR → gh pr create --fill
7. Actions 自动运行 CI（lint + test + build）
8. 请求 Code Review → gh pr edit --add-reviewer team-lead
9. 根据 Review 意见修改 → 再次提交推送
10. 通过后合并 → gh pr merge --squash
11. Actions 自动部署到生产环境
```

**第 14 题**（开源贡献）：你想为 `lodash` 这样的知名开源项目贡献代码，但发现项目有 50000+ Star。请写出**完整的贡献流程**，并说明每一步如何确保你的 PR 被合并。

```
答：_______________________________________________________

参考：
1. 找到合适的 Issue（good first issue / help wanted 标签）
2. 评论说明你想参与，等待维护者回复（避免撞车）
3. Fork 项目 → gh repo fork lodash/lodash --clone
4. 创建分支 → git checkout -b fix/xxx
5. 修改代码并测试（确保通过现有测试，添加新测试）
6. 阅读 CONTRIBUTING.md 确认贡献规范
7. 推送并创建 PR → gh pr create
8. PR 描述中写明：修改了什么、为什么修改、如何测试
9. 等待维护者 Review，积极回应修改意见
10. PR 被合并（或被关闭，保持礼貌）
```

**第 15 题**（问题诊断）：你的同事说"我的 `git push` 被拒绝了，但我不明白为什么"。请列出至少 4 种可能的原因和对应的解决方案。

```
答：_______________________________________________________

参考：
1. 本地落后于远程 → git pull --rebase 后再推送
2. 分支受保护（不允许直接推送）→ 改用 PR 流程
3. SSH Key 未配置或过期 → ssh -T git@github.com 检查认证
4. 权限不足（没有该仓库的写入权限）→ 联系仓库管理员
5. 推送到了错误的分支 → git push origin correct-branch
6. 远程仓库已删除或重命名 → 检查 remote URL：git remote -v
```

### 5.3 答案与评分

**评分标准**：

```
各题分值：
第1-5题：每题 5 分 × 5 = 25 分
第6-9题：每题 7 分 × 4 = 28 分
第10-12题：每题 7 分 × 3 = 21 分
第13-15题：每题 13 分（7+6） × 3 = 26 分
─────────────────────────────────────
总分：100 分
```

**评分指南**（对自己诚实）：

- **完全答对**：概念准确，无遗漏 → 满分
- **部分正确**：核心概念对，细节有遗漏 → 一半分
- **方向对但表述不清**：知道概念但说不清楚 → 1/4 分
- **完全不会**：0 分

### 5.4 成绩解读

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
得分        等级            建议
─────────────────────────────────────
95-100   🏆 GitHub 大师     你可以教这门课了！
80-94    🌟 熟练掌握        查漏补缺，巩固薄弱环节
70-79    ✅ 及格            建议重新学习 Day 1-6 相关内容
50-69    🔄 需要努力        针对薄弱 Day 重新学习
<50      📚 从头再来        建议重新学习全部课程
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> ✋ **费曼自测**：考试结束后，选择一道你答得最不好的题。用 3 分钟向一个"虚拟听众"解释这道题的正确答法。

---

## 🍅 番茄5结束，休息5分钟

**验证清单**：
- [ ] 完成全部 15 道考试题
- [ ] 诚实评分，记录分数：____/100
- [ ] 标记了所有答错的题目

---

## 番茄6：安全最佳实践汇总（25分钟）

### 6.1 GitHub 安全框架

```
GitHub 安全 = 账户安全 + 仓库安全 + 代码安全 + 依赖安全
```

### 6.2 账户安全清单

| # | 安全措施 | 说明 | 开启方式 |
|:-:|:---------|:-----|:---------|
| 1 | ✅ **2FA 双因素认证** | 密码 + 验证码双重保护，防止密码泄露导致账号被盗 | Settings → Password and authentication → Two-factor authentication |
| 2 | ✅ **SSH Key 管理** | 定期轮换、及时吊销 | Settings → SSH and GPG keys |
| 3 | ✅ **Personal Access Tokens** | 替代密码的 API 令牌，可以设置权限和过期时间 | Settings → Developer settings → Personal access tokens |
| 4 | ✅ **Sessions 管理** | 定期审查活跃会话，吊销未知设备 | Settings → Password and authentication → Active sessions |
| 5 | ✅ **安全邮箱** | 使用独立邮箱注册，开启邮箱验证 | Settings → Emails |
| 6 | ✅ **恢复代码** | 保存 2FA 恢复码，防止丢失手机 | Settings → Password and authentication → Recovery codes |

### 6.3 SSH Key 安全最佳实践

```bash
# 1. 使用 ed25519（比 RSA 更安全更高效）
ssh-keygen -t ed25519 -C "your@email.com"

# 2. 为不同用途生成不同 Key
# ─ 个人设备：~/.ssh/id_ed25519_个人
# ─ 工作设备：~/.ssh/id_ed25519_工作
# ─ CI/CD 服务器：单独生成，在 GitHub 上添加为 Deploy Key

# 3. 配置 ~/.ssh/config 实现多 Key 管理
cat ~/.ssh/config
# Host github.com-personal
#   HostName github.com
#   User git
#   IdentityFile ~/.ssh/id_ed25519_个人
#
# Host github.com-work
#   HostName github.com
#   User git
#   IdentityFile ~/.ssh/id_ed25519_工作

# 4. 定期检查已授权的 Key
ssh-add -l                # 列出加载的 Key
cat ~/.ssh/id_ed25519.pub | ssh-keygen -lf /dev/stdin  # 查看 Key 指纹

# 5. 吊销不再使用的 Key
# 去 GitHub Settings → SSH and GPG keys → Delete
```

### 6.4 Personal Access Tokens (PAT) 最佳实践

```bash
# PAT 比密码更安全，因为：
# 1. 可以设置精细权限（scope 限制）
# 2. 可以设置过期时间（推荐 30-90 天）
# 3. 可以单独吊销（不影响其他服务）

# 创建 PAT（推荐 Fine-grained tokens，权限更细）
# GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens

# 使用 PAT 登录 gh CLI
gh auth login --with-token < my-token.txt

# 在 Actions 中使用 PAT（用 Secrets 存储）
# Settings → Secrets and variables → Actions → New repository secret
# 名称：GH_PAT
# 值：你的 PAT
```

```yaml
# 在 Actions 中使用 PAT 的示例
name: 需要跨仓库权限的 Workflow
on: [push]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: |
          # 使用 PAT 替代默认的 GITHUB_TOKEN
          git config --global url."https://${{ secrets.GH_PAT }}@github.com/".insteadOf "https://github.com/"
```

### 6.5 仓库安全清单

| # | 安全措施 | 说明 | 操作路径 |
|:-:|:---------|:-----|:---------|
| 1 | ✅ **分支保护规则** | 禁止直接推送 main，要求 PR 审查 | Settings → Branches → Add branch protection rule |
| 2 | ✅ **CODEOWNERS** | 代码所有者自动指派 Reviewer | 创建 `.github/CODEOWNERS` 文件 |
| 3 | ✅ **Secret Scanning** | 自动检测代码中的密钥泄露 | Settings → Security & analysis → Enable secret scanning |
| 4 | ✅ **Dependabot** | 自动检测依赖漏洞，自动创建修复 PR | Settings → Security & analysis → Enable Dependabot |
| 5 | ✅ **签名提交** | GPG 签名验证提交者身份 | `git commit -S` + 配置 GPG Key |
| 6 | ✅ **所需状态检查** | PR 合并前必须通过 CI | 分支保护规则中勾选 Require status checks |

### 6.6 代码安全清单

```text
编写代码时的安全检查：
────────────────────────────────

🔐 敏感信息（绝对不要提交到 Git！）
   密码、API Key、Token、私钥、数据库连接字符串
   解决方案：使用 .gitignore、环境变量、Secrets 存储

📁 .gitignore 必须包含：
   .env          # 环境变量（极可能含密钥）
   *.key         # 私钥文件
   *.pem         # 证书私钥
   credentials*  # 凭据文件
   secrets*      # 密钥文件
   node_modules/ # 依赖目录（太大）
   __pycache__/  # Python 缓存
   .DS_Store     # macOS 系统文件

🛡️ 如果不小心提交了敏感信息：
   1. 立即撤销：git reset --soft HEAD~1（如果刚提交）
   2. 修改被暴露的密钥（生成新的）
   3. 使用 git filter-repo 从历史中彻底清除
   4. 旧密钥置为无效
   
   ❌ 错误做法：只删除文件然后新提交（密钥仍留在 Git 历史中）
   ✅ 正确做法：git filter-repo 彻底清理历史 + 更换密钥
```

### 6.7 Dependabot 安全配置

```yaml
# .github/dependabot.yml
version: 2
updates:
  # 监控 npm 依赖
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"        # 每周检查一次
      day: "monday"
    open-pull-requests-limit: 10
    labels:
      - "dependencies"
      - "security"
    # 只检查安全更新
    allow:
      - dependency-type: "direct"
    # 忽略次要版本更新（减少噪声）
    ignore:
      - dependency-name: "*"
        update-types:
          - "version-update:semver-patch"

  # 监控 Docker 镜像
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
```

### 6.8 安全事故应急步骤

```
如果发现代码中泄露了敏感信息：
─────────────────────────────────
第1步：不要慌，不要只删除文件
第2步：立即更换被泄露的密钥（生成新密码/新 Token）
第3步：使用 git filter-repo 从 Git 历史中彻底删除
第4步：检查是否有其他人已经访问了你的仓库
第5步：如果仓库是公开的，检查是否有 Fork 包含了敏感信息

必要工具：
git filter-repo  # 用于从 Git 历史中彻底删除敏感信息
  pip install git-filter-repo
  git filter-repo --path .env --invert-paths  # 从所有历史中删除 .env 文件
```

> ✋ **费曼自测**：向一个刚开始用 GitHub 的朋友解释，为什么"提交密钥后马上删除再提交"是不够的？为什么密钥必须更换而不能只是"从代码里拿掉"？

---

## 🍅 番茄6结束，休息5分钟

**安全验证清单**：
- [ ] 已开启 2FA 验证
- [ ] 已检查并清理了无效的 SSH Key
- [ ] 仓库已开启 Dependabot
- [ ] 仓库已开启 Secret Scanning
- [ ] 已配置分支保护规则
- [ ] `.gitignore` 已包含常见敏感文件

---

## 番茄7：试卷复盘与薄弱环节强化（25分钟）

### 7.1 试卷分析

根据你的考试成绩，制定个性化复习计划：

```
错题分布分析：
────────────────────────────────────
错题所在 Day     →  需要复习的内容
────────────────────────────────────
Day 1（Git 基础）       → 三大区域、基本命令
Day 2（协作流程）       → PR 流程、冲突解决、Code Review
Day 3（Actions）       → Workflow 语法、CI/CD 概念
Day 4（Pages）         → 部署方式、自定义域名
Day 5（高级特性）       → Projects、Copilot、Stacked PRs
Day 6（开源贡献）       → Fork 流程、Upstream 同步
Day 7（安全+生态）      → 2FA、PAT、Dependabot
────────────────────────────────────
```

### 7.2 薄弱环节强化练习

根据你的弱项，选择对应的强化训练：

#### 如果 Git 基础薄弱

```bash
# 15 分钟快速强化
git status          # 理解"当前在哪个分支 + 有什么修改"
git diff            # 理解"我改了哪些内容"
git log --oneline --graph --all  # 理解"分支历史树"
git reset --soft HEAD~1  # 理解"回退不丢失修改"
```

#### 如果 PR 流程不熟

```bash
# 在本地用 gh 模拟完整 PR 流程
mkdir pr-practice && cd pr-practice
git init
echo "# PR Practice" > README.md
git add . && git commit -m "init"
git checkout -b feature/test
echo "change" >> README.md
git add . && git commit -m "test change"
echo "完成！你已经走完了 PR 的完整流程："
echo "分支 → 修改 → 提交 → (推送到远程) → 创建 PR → 合并"
```

#### 如果 Actions 不熟

```yaml
# 创建一个最简单的 Workflow 来理解结构
# 文件路径：.github/workflows/practice.yml
name: Practice
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "✅ Workflow 执行成功！"
      - run: echo "🔍 Event: ${{ github.event_name }}"
      - run: echo "🌿 Branch: ${{ github.ref_name }}"
```

### 7.3 能力自评表（最终版）

再次评估——这次应该比番茄1的评估更准确：

| 技能 | 学习前 | 学习后 | 提升 |
|:-----|:------|:-------|:-----|
| Git 基本操作 | __/5 | __/5 | __ |
| 分支与合并 | __/5 | __/5 | __ |
| Pull Request 流程 | __/5 | __/5 | __ |
| Code Review | __/5 | __/5 | __ |
| 解决合并冲突 | __/5 | __/5 | __ |
| GitHub Actions | __/5 | __/5 | __ |
| GitHub Pages | __/5 | __/5 | __ |
| GitHub Projects | __/5 | __/5 | __ |
| GitHub Copilot | __/5 | __/5 | __ |
| 开源贡献流程 | __/5 | __/5 | __ |
| GitHub CLI (gh) | __/5 | __/5 | __ |

```
成就感：⭐⭐⭐⭐⭐（1-5 星）
学习反馈：
────────────────────
最有收获的内容：__________________________________
最需要继续学习的内容：______________________________
印象最深的教训：____________________________________
```

### 7.4 常见问题 FAQ 更新

```
Q：学完 7 天还是记不住命令怎么办？
A：正常！Git 命令不需要死记硬背，建立"肌肉记忆"的方法是：
   - 每天实际使用 Git 操作 10+ 次（两周后自然记住）
   - 常用命令不到 10 个（status/add/commit/push/pull/branch/merge/log）
   - 用 gh CLI 替代网页操作（命令行用多了自然记住）

Q：学完 7 天后完全忘了 Day 1/2 的内容怎么办？
A：这是"学习曲线衰退"的正常现象。解决方案：
   - 立即创建一个个人项目，完整走一遍 Git 流程
   - 把本教程的速查表存为书签
   - 遇到问题回来查对应 Day 的内容

Q：接下来应该学什么？
A：看番茄8的学习路径规划！
```

> ✋ **费曼自测**：选出你现在最不熟练的一个技能，在接下来的 5 分钟内，用"给自己讲课"的方式把它解释清楚。

---

## 🍅 番茄7结束，休息5分钟

**验证清单**：
- [ ] 完成试卷分析，标记了薄弱环节
- [ ] 完成了至少一个薄弱环节的强化练习
- [ ] 填写了最终能力自评表

---

## 番茄8：输出成果与持续学习路径（25分钟）

### 8.1 创建 Day 7 学习笔记

```markdown
# GitHub 学习笔记 - Day 7

> 日期：2026-06-11
> 完成状态：✅

## 最终能力总结
____/55 分（番茄1自评）→ ____/55 分（番茄7终评）

## 综合考试成绩
____/100 分

## 我最擅长的 3 个技能
1. _________________________________
2. _________________________________
3. _________________________________

## 我最需要加强的 3 个技能
1. _________________________________
2. _________________________________
3. _________________________________

## Week 1 总收获
_______________________________________________________________
_______________________________________________________________
```

### 8.2 持续学习路径规划

你已经完成了 7 天的 GitHub 速通教程——但这只是开始。下面是 GitHub 生态中**下一步可以学习的方向**：

```
                    ┌─────────────────────────────────┐
                    │   你已完成：GitHub 七天速通教程    │
                    │    你有 7 天 GitHub 实践经验      │
                    └──────────────┬──────────────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    │         下一步方向             │
                    └──────────────┬──────────────┘
                                   │
        ┌──────────────────────────┼──────────────────────────┐
        │                          │                          │
        ▼                          ▼                          ▼
┌──────────────────┐   ┌──────────────────┐   ┌──────────────────┐
│  深度方向         │   │  广度方向         │   │  实战方向         │
│（选 1-2 个深耕）   │   │（扩大知识面）     │   │（项目驱动）       │
├──────────────────┤   ├──────────────────┤   ├──────────────────┤
│ • GitHub Actions │   │ • GitHub API     │   │ • 参与开源项目    │
│   高级 Workflow  │   │   REST + GraphQL │   │   持续贡献        │
│ • GitHub Copilot │   │ • GitHub Apps    │   │ • 用 GitHub      │
│   Agent 开发     │   │   开发           │   │   搭建个人品牌    │
│ • 安全与 DevSec  │   │ • Webhook 集成  │   │ • 团队 CI/CD     │
│   Ops 实践       │   │ • Git LFS       │   │   流水线搭建      │
│ • GitHub         │   │   大文件管理     │   │ • 完整项目        │
│   Packages 运维  │   │ • GitHub        │   │   从0到1部署      │
│                  │   │   Sponsors 开源  │   │                  │
│                  │   │   商业化         │   │                  │
└──────────────────┘   └──────────────────┘   └──────────────────┘
```

#### 推荐学习资源

**官方文档（首选，永远是第一手资料）**：

| 资源 | 链接 | 推荐指数 |
|:-----|:-----|:---------|
| GitHub Docs | docs.github.com | ⭐⭐⭐⭐⭐ |
| GitHub Skills | skills.github.com | ⭐⭐⭐⭐⭐ |
| GitHub Changelog | github.blog/changelog | ⭐⭐⭐⭐ |
| GitHub Community | github.com/community | ⭐⭐⭐⭐ |
| GitHub Status | www.githubstatus.com | ⭐⭐⭐ |

**进阶学习路径建议**：

```
📚 路径一：成为 Actions 专家（推荐优先）
  1. 学习 Composite Actions（可复用 Action 编写）
  2. 学习自托管 Runner 搭建
  3. 学习 Matrix Build 策略
  4. 学习 Reusable Workflows
  目标：能搭建企业级 CI/CD 流水线

📚 路径二：成为 Copilot Agent 开发者
  1. 学习 Copilot Extension 开发
  2. 学习 Agentic Memory 编程模式
  3. 学习 MCP（Model Context Protocol）协议
  4. 学习自定义 AI Agent 开发
  目标：能开发自定义代码 Agent

📚 路径三：成为开源维护者
  1. 从"贡献者"升级为"维护者"
  2. 学习社区管理（Discussions + Issues）
  3. 学习通过 GitHub Sponsors 变现
  4. 学习项目治理和 Roadmap 规划
  目标：能独立维护一个有影响力的开源项目

📚 路径四：成为 DevSecOps 实践者
  1. 学习 CodeQL 高级查询编写
  2. 学习完整的安全 CI/CD 流水线
  3. 学习合规性管理和审计日志
  4. 学习云原生安全最佳实践
  目标：能在企业级别实施 DevSecOps
```

#### 90 天进阶计划

```text
90 天持续提升计划：
────────────────────────────────────────
第 1-30 天：巩固基础 + 选择一个深度方向
  ├── 每天至少 1 次 Git 操作（保持肌肉记忆）
  ├── 完成选择方向（如 Actions 专家）的入门教程
  └── 尝试参与 1 个开源项目的 Issue 讨论

第 31-60 天：实践 + 项目驱动
  ├── 用 GitHub Actions 搭建一个个人项目的完整 CI/CD
  ├── 在开源项目中提交至少 3 个有意义的 PR
  └── 学习 gh CLI 的高级用法（gh api、gh workflow）

第 61-90 天：输出 + 分享
  ├── 写一篇 GitHub 使用心得博客（加深理解）
  ├── 在你的项目中使用 GitHub Security 功能
  └── 独立维护一个小型开源项目或工具
────────────────────────────────────────
```

### 8.3 Week 1 总复习墙

把下面这张表保存下来——这是你 7 天学到的全部能力的**快速查表**：

```
┌─────────────────────────────────────────────────────────────┐
│              GitHub 七天速通 · 能力总表                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Day 1: Git 基础                                              │
│  ├─ git init / clone / status / add / commit / push / pull   │
│  ├─ git branch / checkout / merge / log / diff               │
│  └─ SSH Key 配置、.gitignore                                 │
│                                                              │
│  Day 2: 协作工作流                                            │
│  ├─ Pull Request 创建与审查流程                                │
│  ├─ 合并冲突解决                                              │
│  ├─ Issue 管理与标签分类                                      │
│  └─ 分支保护规则 / CODEOWNERS                                │
│                                                              │
│  Day 3: Actions CI/CD                                        │
│  ├─ .github/workflows/*.yml 结构与语法                        │
│  ├─ Event / Job / Step / Action / Runner                     │
│  ├─ Secrets / Environment / Matrix                           │
│  └─ Marketplace / 自定义 Action                              │
│                                                              │
│  Day 4: Pages 部署                                            │
│  ├─ 个人/项目站点 / 自定义域名 / HTTPS                        │
│  ├─ Jekyll / Hugo / 静态站点生成器                            │
│  └─ Actions 自动化部署                                       │
│                                                              │
│  Day 5: 高级特性 + AI 协作                                    │
│  ├─ GitHub Projects（看板/表格/路线图）                       │
│  ├─ GitHub Copilot / Copilot Chat / Copilot Agent            │
│  ├─ Stacked PRs 多 PR 管理                                   │
│  └─ gh CLI 基础操作                                          │
│                                                              │
│  Day 6: 开源贡献                                              │
│  ├─ Fork / Upstream 同步 / CONTRIBUTING.md 规范              │
│  ├─ Good First Issue 寻找与参与                               │
│  ├─ 开源道德 / 社区沟通                                      │
│  └─ PR 持久化策略                                             │
│                                                              │
│  Day 7: 生态全景 + 安全                                       │
│  ├─ gh CLI 全部命令精通                                      │
│  ├─ 生态：Actions/Copilot/Packages/Codespaces/Mobile/Pages   │
│  ├─ 安全：2FA/SSH/PAT/Secret Scanning/Dependabot             │
│  └─ 趋势：AI Agent/Agentic Memory/安全左移                   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 8.4 你的最终自检清单

```
📋 GitHub 七天速通 · 结业自检
────────────────────────────────────────
□ 我能独立创建 GitHub 仓库并完成提交-推送流程
□ 我能创建分支、切换分支、合并分支
□ 我能在推送前用 git diff 检查修改
□ 我能看懂 git log --oneline --graph
□ 我能发起一个 PR 并做 Code Review
□ 我能解决合并冲突
□ 我能阅读和编写基础的 Actions Workflow
□ 我能通过 Actions 部署到 GitHub Pages
□ 我能用 GitHub Projects 管理任务
□ 我理解 GitHub Copilot 的基本用法
□ 我理解开源贡献的标准流程
□ 我安装了 gh CLI 并会基本操作
□ 我已开启 2FA 保护账号安全
□ 我理解 PAT 和 SSH Key 的用法
□ 我能画出 GitHub 2026 生态全景图
────────────────────────────────────────
已掌握：____/15 项
下一阶段小目标：______________________________
```

### 8.5 结业证书

```
═══════════════════════════════════════════
                                    
         GitHub 七天速通教程
             结 业 证 书
                                    
    兹证明
                                    
        {{你的名字}}
                                    
    已完成本教程全部 7 天 56 个番茄钟的学习
    掌握了 Git 版本控制、团队协作、CI/CD、
    Pages 部署、AI 协作、开源贡献等核心技能
                                    
    学习日期：2026年6月
    综合考试成绩：____/100
                                    
    下一步目标：________________________
                                    
═══════════════════════════════════════════
```

---

## 🍅 番茄8结束，学习完成！

### 🎉 Day 7 完成！

**今日成果：**
- ✅ 回顾 Week 1 全部核心概念（6 天知识速查表）
- ✅ 掌握 GitHub CLI（gh）高级用法
- ✅ 理解 GitHub 2026 生态全景（8 大模块）
- ✅ 了解 2026 平台趋势（AI Agent / Agentic Memory / 安全左移）
- ✅ 完成综合复习考试（15 题，100 分）
- ✅ 掌握安全最佳实践（2FA / SSH / PAT / Dependabot）
- ✅ 制定持续学习路径（90 天进阶计划）

### 🏆 恭喜你完成 GitHub 七天速通教程！

```text
从今天开始，你不再是 GitHub 新手。

你能：
● 用 Git 管理自己的代码历史
● 用 GitHub 和团队协作开发
● 用 Actions 自动化一切重复工作
● 用 Pages 部署你的项目
● 用 Copilot 提升编码效率
● 为开源世界贡献你的代码
● 用安全最佳实践保护你的代码

你的 GitHub 之旅才刚刚开始。
持续学习，持续贡献，持续成长。
```

### 明天做什么？

**下一步推荐：**
- 立即创建一个**个人项目**，用 GitHub 完整管理（把学到的都用上）
- 找一个你常用的开源项目，尝试**贡献一个小的文档修改**
- 把你的学习笔记整理成博客，分享给更多人
- 收藏本教程的速查表，**工作中随时查阅**

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day1-Git基础与仓库管理]] - Day 1 内容
> - [[Day2-分支与协作工作流]] - Day 2 内容
> - [[Day3-GitHub-Actions与CI-CD]] - Day 3 内容
> - [[Day4-实战项目一-GitHub-Pages部署]] - Day 4 内容
> - [[Day5-高级特性与AI协作]] - Day 5 内容
> - [[Day6-实战项目二-开源贡献]] - Day 6 内容
