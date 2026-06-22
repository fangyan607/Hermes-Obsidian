# Day 3：GitHub Actions CI/CD

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 GitHub Actions，编写自动化 CI/CD 工作流
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：递进式 Workflow 编写（3个版本）

---

## 今日学习路径

```
🍅 番茄1-2：理解 Actions 核心概念 + YAML 语法基础
🍅 番茄3-4：编写第一个 CI Workflow（自动运行测试）
🍅 番茄5-6：刻意练习 — 递进式 Workflow 编写（3个版本）
🍅 番茄7-8：复习巩固 + 输出成果 + 制作个人 Cheat Sheet
```

---

## 前期准备

在开始之前，请确保你已准备好：

- [ ] 一个 GitHub 仓库（可以用 Day 1 创建的仓库，或新建一个测试仓库）
- [ ] 仓库里有一个简单的项目（JS/Node 项目最佳，本教程以此为例）
- [ ] 能够访问 github.com
- [ ] 对 YAML 有一点基本概念（没有也没关系，今天会讲）

### 快速创建测试项目

如果你还没有一个适合测试的仓库，在本地执行：

```bash
# 创建一个测试项目
mkdir gh-actions-demo
cd gh-actions-demo
git init

# 初始化一个 Node.js 项目
echo '{"name":"gh-actions-demo","version":"1.0.0"}' > package.json

# 创建一个简单的测试文件
mkdir -p src test

cat > src/add.js << 'EOF'
function add(a, b) {
  return a + b;
}
module.exports = add;
EOF

cat > test/add.test.js << 'EOF'
const add = require('../src/add');

test('adds 1 + 2 to equal 3', () => {
  expect(add(1, 2)).toBe(3);
});

test('adds -1 + 1 to equal 0', () => {
  expect(add(-1, 1)).toBe(0);
});
EOF

# 安装测试框架
npm install --save-dev jest

# 在 package.json 中添加测试脚本
# 手动添加: "scripts": { "test": "jest" }

# 提交到 Git 并推送到 GitHub
git add .
git commit -m "init: demo project for Actions"
git remote add origin <你的仓库地址>
git push -u origin main
```

---

## 番茄1：Actions 核心概念（25分钟）

### 1.1 用大白话理解 CI/CD

**CI/CD 是什么？**

```
没有 CI/CD 的世界：
  写代码 → 手动测试 → 手动部署 → 出错了 😱

有 CI/CD 的世界：
  写代码 → 推送 GitHub → 自动测试 → 自动部署 → 安稳睡觉 😴
```

**两个关键概念：**

| 术语 | 英文 | 大白话 | 类比 |
|:-----|:-----|:-------|:-----|
| **持续集成** | Continuous Integration (CI) | 每次提交代码，自动运行测试，确保没改坏东西 | 像每个零件出厂前都自动质检 |
| **持续部署** | Continuous Deployment (CD) | 测试通过后，自动把代码部署到服务器 | 像质检通过后自动送到仓库上架 |

**2026 年的 GitHub Actions：**

截至 2026 年，GitHub Actions 已经成为全球最大的 CI/CD 平台之一：
- 每周运行 **20 亿分钟以上** 的 Workflow
- 支持 **Linux / macOS / Windows / ARM** 等多种运行环境
- **安全大幅提升**：OIDC（OpenID Connect）成为默认认证方式，不再需要存储长期密钥
- **Artifact Attestation**：构建产物可以生成加密签名，确保供应链安全
- **Docker 原生支持增强**：可直接在 Runner 上构建和推送容器镜像

> 💡 **CI 为什么重要？**
> 谷歌研究表明，实施 CI 的团队，Bug 发现时间从 **数天缩短到数分钟**。CI 就是你的"代码安全气囊"。

### 1.2 GitHub Actions 五大核心概念

GitHub Actions 本质上是一个**事件驱动的自动化系统**。理解这五个概念，你就掌握了 80%：

```
┌─────────────────────────────────────────────────┐
│                   Workflow                       │
│  ┌───────────────────────────────────────────┐   │
│  │  Job 1 (test)                             │   │
│  │  ┌──────────┐  ┌──────────┐  ┌────────┐  │   │
│  │  │ Step 1   │  │ Step 2   │  │ Step 3 │  │   │
│  │  │ Checkout │→│ Setup    │→│ Run    │  │   │
│  │  │ 代码     │  │ Node.js  │  │ 测试   │  │   │
│  │  └──────────┘  └──────────┘  └────────┘  │   │
│  └───────────────────────────────────────────┘   │
│  ┌───────────────────────────────────────────┐   │
│  │  Job 2 (deploy)  [依赖 Job 1]             │   │
│  │  ┌──────────┐  ┌──────────┐               │   │
│  │  │ Step 1   │  │ Step 2   │               │   │
│  │  │ Deploy   │→│ Notify   │               │   │
│  │  └──────────┘  └──────────┘               │   │
│  └───────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
         ↑ 运行在 Runner（GitHub 提供的虚拟机）上
         ↑ 由 Event（如 push、PR）触发
```

**逐一拆解：**

| 概念 | 英文 | 解释 | 类比 |
|:-----|:-----|:-----|:-----|
| **工作流** | Workflow | 一个完整的自动化流程，定义在 `.github/workflows/*.yml` 中 | 工厂的一条完整流水线 |
| **作业** | Job | 工作流中的一组步骤，运行在同一 Runner 上 | 流水线上的一个工位 |
| **步骤** | Step | Job 中的单个任务，可以执行命令或使用 Action | 工位上的一个操作 |
| **运行器** | Runner | 执行 Workflow 的虚拟机或容器 | 流水线的工人 |
| **事件** | Event | 触发 Workflow 运行的条件 | 启动流水线的按钮 |

### 1.3 GitHub Actions 的定价模型（2026）

对于**公开仓库**：Actions 完全**免费**，无时间限制。
对于**私有仓库**：免费账号每月有 **2,000 分钟**（约 33 小时）免费额度。

### 1.4 Workflow 文件结构预览

一个完整的 Workflow 文件长这样（先混个脸熟）：

```yaml
# .github/workflows/ci.yml
name: CI                        # 工作流名称

on:                             # 触发事件
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:                           # 作业列表
  test:                         # 作业 ID
    runs-on: ubuntu-latest      # 运行环境
    steps:                      # 步骤列表
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm test
```

> ✋ **费曼自测**：用自己的话解释 Workflow、Job、Step 的关系。如果在一个 Workflow 中有两个 Job，它们是同时运行还是先后运行？（提示：默认是同时运行，但可以通过 `needs` 控制顺序）

---

## 番茄2：YAML 语法基础（25分钟）

### 2.1 YAML 快速入门（10分钟就够）

GitHub Actions 的 Workflow 用 **YAML** 格式编写。如果你从没接触过 YAML，这里是你需要知道的全部：

**核心规则（记住这 5 条就够了）：**

```yaml
# 1. 缩进用空格，不用 Tab（两个空格是标准）
name: my-workflow

# 2. 键值对：key: value（冒号后要有一个空格）
key: value

# 3. 列表用 - 开头
steps:
  - name: Step 1
  - name: Step 2

# 4. 字符串可以不用引号
message: hello world

# 5. 注释用 #
# 这是注释
```

**完整的语法示例：**

```yaml
# 字符串（大部分情况下不用引号）
name: my workflow

# 数字
version: 3
timeout-minutes: 10

# 布尔值
debug: true
fail-fast: false

# 多行字符串（用 | 保留换行）
multiline-script: |
  echo "Line 1"
  echo "Line 2"
  echo "Line 3"

# 多行字符串（用 > 折叠为一行）
description: >
  This is a long description
  that will be folded into
  a single line

# 对象（嵌套）
person:
  name: Alice
  age: 30
  address:
    city: Beijing
    country: China

# 列表
fruits:
  - apple
  - banana
  - orange

# 列表中的对象
runners:
  - os: ubuntu-latest
    cores: 2
  - os: windows-latest
    cores: 4
```

### 2.2 Workflow 文件模板

```yaml
# .github/workflows/文件名.yml
# ── 文件命名规则 ──
# 文件名即 Workflow 名称的一部分，用连字符分隔
# 例如：ci.yml, deploy.yml, lint-and-test.yml

name: <工作流显示名称>           # 在 GitHub Actions 页面显示的名称
run-name: <运行名称>             # 可选，每次运行的名称，可用变量

on:                              # 触发事件（关键！）
  <event>:                       # push, pull_request, workflow_dispatch 等
    <filters>:                   # branches, paths, tags 等过滤条件

env:                             # 全局环境变量（可选）
  <KEY>: <value>

jobs:                            # 作业列表（关键！）
  <job_id>:                      # job 的唯一标识符
    name: <作业显示名称>         # 在界面上显示的名称（可选）
    runs-on: <runner>            # 运行环境（关键！）
    needs: [<job_id>]            # 依赖关系（可选，默认并行执行）
    if: <condition>              # 条件执行（可选）
    env:                         # 作业级环境变量（可选）
      <KEY>: <value>
    strategy:                    # 运行策略（可选）
      matrix:                    # 矩阵构建
        <key>: [<values>]
    steps:                       # 步骤列表（关键！）
      - name: <步骤名称>         # 步骤名称
        uses: <action>@<版本>    # 使用现成的 Action
        with:                    # 传给 Action 的参数
          <key>: <value>
        env:                     # 步骤级环境变量
          <KEY>: <value>
      - name: <步骤名称>
        run: <命令>              # 直接运行 Shell 命令
        shell: <shell>           # 使用什么 Shell（bash, pwsh, python 等）
        working-directory: <目录> # 工作目录
```

### 2.3 常用 Runner 类型

```yaml
runs-on: ubuntu-latest        # Linux（最快，最常用，免费额度多）
runs-on: ubuntu-24.04         # 指定 Ubuntu 24.04（2026 年最新 LTS）
runs-on: windows-latest       # Windows Server
runs-on: macos-latest         # macOS（macOS 付费，额度较少）
runs-on: ubuntu-latest        # ARM64（适合编译 ARM 架构应用）

# 自托管 Runner（如果你有自己的服务器）
runs-on: self-hosted
runs-on: [self-hosted, linux, x64, gpu]
```

> ✋ **费曼自测**：打开你喜欢的项目的 GitHub 仓库，找到 `.github/workflows/` 目录，看一个真实的 Workflow 文件，用刚学的知识逐行理解它。你能说出每个部分对应什么概念吗？

---

## 番茄3：编写第一个 CI Workflow（25分钟）

### 3.1 Step-by-Step 创建 Workflow

**Step 1：创建目录结构**

在你的仓库根目录下：

```bash
mkdir -p .github/workflows
```

**Step 2：创建 Workflow 文件**

```bash
touch .github/workflows/ci.yml
```

**Step 3：编写 Workflow 内容**

```yaml
# .github/workflows/ci.yml
# 作用：每次推送到 main 分支或创建 PR 时，自动运行测试

name: CI                       # 工作流名称
on:                            # 触发条件
  push:                        # 当有代码推送时
    branches: [main]           # 仅当推送到 main 分支
  pull_request:                # 当有 Pull Request 时
    branches: [main]           # PR 的目标是 main 分支

jobs:                          # 定义作业
  test:                        # 作业 ID
    name: Run Tests            # 作业显示名称
    runs-on: ubuntu-latest     # 使用最新版 Ubuntu 运行

    steps:                     # 步骤列表
      # Step 1：检出代码
      - name: Checkout code
        uses: actions/checkout@v4
        # 这是 GitHub Actions 最常用的 Action
        # 作用：将仓库代码下载到 Runner 上
        # v4 是目前的最新稳定版本

      # Step 2：设置 Node.js 环境
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20     # 使用 Node.js 20
          cache: 'npm'         # 缓存 node_modules，加速后续运行

      # Step 3：安装依赖
      - name: Install dependencies
        run: npm ci
        # npm ci vs npm install：
        # npm ci：基于 package-lock.json 安装，更快更可重现
        # npm install：可能会更新 lock 文件

      # Step 4：运行测试
      - name: Run tests
        run: npm test
        # 这里的 npm test 对应 package.json 中的 scripts.test
```

### 3.2 提交并观察 Workflow 运行

```bash
# 创建 .github/workflows/ 目录和 ci.yml 文件后
git add .github/
git commit -m "ci: add GitHub Actions CI workflow"
git push
```

推送后，打开浏览器：
1. 进入你的 GitHub 仓库
2. 点击顶部的 **Actions** 标签页
3. 你应该能看到一个正在运行的 Workflow（黄色圆点表示进行中）
4. 点击进入可以查看实时日志

### 3.3 理解 Workflow 运行过程

```
提交代码 → GitHub 检测到 .github/workflows/*.yml
    ↓
GitHub 分配 Runner（虚拟机）
    ↓
Runner 启动 → 按步骤执行 Workflow
    ↓
Step 1: actions/checkout@v4（检出代码）
    ↓
Step 2: actions/setup-node@v4（安装 Node.js）
    ↓
Step 3: npm ci（安装依赖）
    ↓
Step 4: npm test（运行测试）
    ↓
完成 ✅ 或 失败 ❌
```

### 3.4 故意制造失败（学习调试）

修改 `src/add.js`，制造一个错误：

```js
function add(a, b) {
  return a - b;  // 故意把 + 写成 -
}
```

提交并推送：

```bash
git add src/add.js
git commit -m "debug: intentionally break the add function"
git push
```

观察 Actions 运行结果：
- 你会看到红色 ❌ 标记
- 点击失败的 Workflow 查看日志
- 找到具体的错误信息
- 修复后重新提交

> ✋ **费曼自测**：解释为什么 CI 能在代码合并到 main 之前就发现问题。如果 CI 失败了，代码还能合并到 main 吗？（提示：可以通过分支保护规则控制）

---

## 番茄4：深入 Workflow - 触发条件与 Marketplace（25分钟）

### 4.1 触发事件详解

`on:` 是 Workflow 的"开关"，定义了什么时候自动启动。

**最常用的触发事件：**

```yaml
# 1. push：代码推送时触发
on:
  push:
    branches:           # 仅某些分支
      - main
      - 'release/**'    # 通配符，匹配 release/v1, release/v2 等
    tags:               # 仅某些标签
      - 'v*'            # 匹配 v1.0, v2.0.1 等
    paths:              # 仅某些文件变更时触发
      - 'src/**'
      - '!docs/**'      # ! 表示排除 docs 目录下的变更

# 2. pull_request：PR 相关事件
on:
  pull_request:
    types: [opened, synchronize, reopened]
    # opened：新建 PR
    # synchronize：向 PR 推送新提交
    # reopened：重新打开已关闭的 PR
    # 如果不指定 types，默认包含以上三种

# 3. schedule：定时触发（cron 表达式）
on:
  schedule:
    - cron: '0 0 * * *'    # 每天 UTC 0:00（北京时间 8:00）
    - cron: '0 */6 * * *'  # 每 6 小时

# 4. workflow_dispatch：手动触发（非常有用！）
on:
  workflow_dispatch:
    inputs:                 # 可以定义输入参数
      environment:
        description: '部署环境'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production
      debug:
        description: '启用调试模式'
        required: false
        default: false
        type: boolean

# 5. 多种事件组合
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * 1'   # 每周一 UTC 2:00
  workflow_dispatch:       # 也可以手动触发
```

### 4.2 cron 表达式速查

```
格式：┌───── 分钟 (0-59)
      │ ┌───── 小时 (0-23)
      │ │ ┌───── 日 (1-31)
      │ │ │ ┌───── 月 (1-12)
      │ │ │ │ ┌───── 星期 (0-6, 0=周日)
      │ │ │ │ │
      * * * * *
```

| 表达式 | 含义 |
|:-------|:-----|
| `0 0 * * *` | 每天午夜 |
| `0 9 * * 1-5` | 工作日早 9 点 |
| `*/15 * * * *` | 每 15 分钟 |
| `0 */6 * * *` | 每 6 小时 |
| `0 2 * * 0` | 每周日凌晨 2 点 |

> ⚠️ **注意**：cron 使用 UTC 时间。北京时间 = UTC + 8 小时

### 4.3 Marketplace Actions 使用

**什么是 Marketplace Action？**

Action 是一个可复用的自动化单元，就像"代码积木"。别人写好了，你拿来拼装就行。

**如何找 Action？**

- GitHub Marketplace：https://github.com/marketplace?type=actions
- 在 Workflow 中直接搜索

**最常用的官方 Action：**

```yaml
# actions/checkout —— 检出代码（几乎每个 Workflow 都需要）
- uses: actions/checkout@v4

# actions/setup-node —— 配置 Node.js
- uses: actions/setup-node@v4
  with:
    node-version: 20

# actions/setup-python —— 配置 Python
- uses: actions/setup-python@v5
  with:
    python-version: '3.12'

# actions/cache —— 缓存依赖，加速构建
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

# actions/upload-artifact —— 上传构建产物
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: dist/

# actions/download-artifact —— 下载构建产物
- uses: actions/download-artifact@v4
  with:
    name: build-output

# actions/deploy-pages —— 部署到 GitHub Pages
- uses: actions/deploy-pages@v4
```

**实用的第三方 Action（2026 年推荐）：**

```yaml
# Docker 构建与推送
- uses: docker/build-push-action@v6
  with:
    push: true
    tags: myapp:latest

# 代码质量检查
- uses: github/codeql-action/analyze@v3

# Slack 通知
- uses: rtCamp/action-slack-notify@v2

# 钉钉通知
- uses: nicepkg/action-dingtalk@v1

# SSH 部署
- uses: easingthemes/ssh-deploy@main
```

### 4.4 手动触发 Workflow（workflow_dispatch）

增加手动触发功能非常实用，特别是在调试阶段：

```yaml
name: Deploy
on:
  workflow_dispatch:
    inputs:
      environment:
        description: '目标环境'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to ${{ github.event.inputs.environment }}
        run: |
          echo "Deploying to ${{ github.event.inputs.environment }}..."
          # 实际部署命令
```

手动触发方式：
1. 进入仓库 → Actions 标签
2. 选择你的 Workflow
3. 点击 **Run workflow** 按钮
4. 选择参数并运行

> ✋ **费曼自测**：如果在一个 Workflow 中同时配置了 `push` 和 `pull_request` 触发，当有人向你的仓库提交 PR 时，Workflow 会运行几次？（提示：会运行两次，一次是 push 到 PR 分支，一次是 PR 事件）

---

## 番茄5：Matrix 策略与多版本测试（25分钟）

### 5.1 什么是 Matrix 策略？

**问题：** 你的代码在 Node 18 上能跑，但用户可能在 Node 20、22 上使用。难道要写 3 个重复的 Job 吗？

**答案：** 用 Matrix 策略，一份配置自动生成多个 Job 实例。

```
Matrix 配置：
  node-version: [18, 20, 22]
  os: [ubuntu-latest, windows-latest]

生成 3 × 2 = 6 个 Job：
  Job 1: ubuntu + Node 18
  Job 2: ubuntu + Node 20
  Job 3: ubuntu + Node 22
  Job 4: windows + Node 18
  Job 5: windows + Node 20
  Job 6: windows + Node 22
```

### 5.2 使用 Matrix 的完整示例

```yaml
# .github/workflows/matrix-test.yml
name: Matrix Test
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    name: Test on ${{ matrix.os }} with Node ${{ matrix.node-version }}
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20, 22]
      # fail-fast 控制：如果一个 Job 失败，是否取消其他所有 Job
      fail-fast: false
      # max-parallel 控制：最多同时运行几个 Job
      max-parallel: 5

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Check Node version
        run: node --version
```

### 5.3 Matrix 高级用法

**包含（include）：为特定组合添加额外配置：**

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node-version: [18, 20]
    include:
      # 只对 ubuntu + Node 22 这个组合添加额外步骤
      - os: ubuntu-latest
        node-version: 22
        experimental: true    # 标记为实验性
        lint: true            # 添加 lint 标志
    exclude:
      # 排除某些不需要的组合
      - os: windows-latest
        node-version: 18

steps:
  - uses: actions/checkout@v4

  - name: Setup Node.js ${{ matrix.node-version }}
    uses: actions/setup-node@v4
    with:
      node-version: ${{ matrix.node-version }}

  - name: Run lint (only for specific configurations)
    if: ${{ matrix.lint }}
    run: npm run lint

  - name: Run tests
    run: npm test
```

### 5.4 条件执行（if 语法）

```yaml
# 基于分支条件
- name: Run expensive tests
  if: github.ref == 'refs/heads/main'
  run: npm run test:full

# 基于事件类型
- name: Notify on PR
  if: github.event_name == 'pull_request'
  run: echo "This is a PR!"

# 基于前一步结果
- name: Upload report
  if: always()            # 即使前一步失败也执行
  run: echo "Always runs"

- name: Only on success
  if: success()           # 前一步成功才执行（默认行为）

- name: Only on failure
  if: failure()           # 前一步失败才执行
  run: echo "Something failed!"

- name: Never on cancelled
  if: cancelled()         # 被取消时才执行
  run: echo "Cancelled"
```

### 5.5 环境变量与 Secrets

```yaml
name: Secrets Demo
on:
  workflow_dispatch:

env:                       # 全局环境变量
  NODE_ENV: test
  LOG_LEVEL: debug

jobs:
  build:
    runs-on: ubuntu-latest
    env:                   # 作业级环境变量
      CI: true

    steps:
      - uses: actions/checkout@v4

      # 使用环境变量
      - name: Print env
        run: |
          echo "Node env: $NODE_ENV"
          echo "Log level: $LOG_LEVEL"
          echo "CI flag: $CI"

      # 使用 Secrets（敏感信息，在仓库 Settings → Secrets 中设置）
      - name: Deploy with secret
        run: |
          echo "Deploying to $DEPLOY_URL"
          # 实际部署命令使用 ${{ secrets.DEPLOY_KEY }}
        env:
          DEPLOY_URL: ${{ secrets.DEPLOY_URL }}
```

> ⚠️ **Secrets 安全提示：**
> - Secrets 在日志中会自动被屏蔽（显示为 `***`）
> - 永远不要在日志中 `echo` secret 值
> - Secrets 不能在工作流中被 `if` 条件直接引用（除非注入到环境变量）
> - 2026 年推荐使用 **OIDC** 代替长期密钥进行云服务认证

> ✋ **费曼自测**：Matrix 策略中 `fail-fast: false` 是什么意思？为什么在测试多版本兼容性时建议将其设为 `false`？（提示：如果 Node 18 的测试失败了，你仍然想知道 Node 20 和 22 是否正常）

---

## 番茄6：刻意练习 — 递进式 Workflow 编写（25分钟）

这里是今天的**核心刻意练习环节**。你将编写 3 个递进版本的 Workflow，每一个都比上一个更复杂。

### 练习方法

```
v1 → v2 → v3
从简单到复杂，每一步增加一个新概念

v1：单 Job、单步、一个触发条件
v2：多 Job、Matrix、多个触发条件
v3：完整 CI + CD、并行 Job、产物传递

每个版本自己动手写！
先不看答案尝试，写完再对照检查
```

---

### v1：Simple Lint Check（简单语法检查）

**目标：** 每次推送时自动运行 ESLint，检查代码风格

**新增概念：** `actions/checkout`、`run` 命令、`package.json` scripts

在 `.github/workflows/v1-lint.yml` 中编写：

```bash
# 先用之前的测试项目，安装 ESLint
npm install --save-dev eslint
```

```yaml
# .github/workflows/v1-lint.yml
# 刻意练习 v1：最简单的 CI 工作流
# 
# 学习要点：
# 1. Workflow 文件的基本骨架（name / on / jobs）
# 2. 使用 actions/checkout 检出代码
# 3. 在 step 中直接运行 shell 命令
# 4. 按步骤理解每一步在做什么

name: V1 - Lint Check

# 触发条件：推送到任意分支时
on: push

jobs:
  # Job ID，可以任意取名（不要用空格）
  lint:
    # 运行环境
    runs-on: ubuntu-latest

    # 步骤：按顺序执行
    steps:
      # Step 1: 检出代码
      # 如果没有这一步，Runner 上没有你的代码
      - name: Checkout code
        uses: actions/checkout@v4

      # Step 2: 设置 Node.js
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20

      # Step 3: 安装依赖
      - name: Install dependencies
        run: npm ci

      # Step 4: 运行 lint 检查
      # 假设 package.json 中有 "lint": "eslint src/"
      - name: Run linter
        run: npm run lint
      # 如果 package.json 中没有 lint 脚本，也可以直接：
      # run: npx eslint src/
```

**你的任务：** 如果项目里还没有 ESLint 配置，先创建 `.eslintrc.json`，然后提交并观察 Workflow 运行。

**验证：**
- [ ] Workflow 文件是否在 `.github/workflows/` 目录下
- [ ] 推送后 Actions 标签页是否出现新的运行
- [ ] Lint 检查是否正确通过
- [ ] 故意制造一个 lint 错误，观察 CI 失败

---

### v2：Multi-OS Test Matrix（多系统测试矩阵）

**目标：** 在 3 个操作系统上、3 个 Node 版本上运行测试

**新增概念：** Matrix 策略、`strategy`、并发控制

在 `.github/workflows/v2-matrix-test.yml` 中编写：

```yaml
# .github/workflows/v2-matrix-test.yml
# 刻意练习 v2：Matrix 多版本测试
#
# 学习要点：
# 1. Matrix 策略的配置方法
# 2. 如何引用 matrix 变量（${{ matrix.os }}）
# 3. fail-fast 和 max-parallel 的作用
# 4. 并行 Job 的概念
# 5. 在 Job 名称中使用变量

name: V2 - Matrix Test

# 多个触发条件组合
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  # 添加 workflow_dispatch 方便手动测试
  workflow_dispatch:

jobs:
  # Job 名称：用 job_id 加上动态名称
  test:
    # 动态 Job 名称，方便区分不同的 matrix 组合
    name: Test (${{ matrix.os }} / Node ${{ matrix.node-version }})
    
    # 动态 Runner
    runs-on: ${{ matrix.os }}
    
    # ★ 核心：Matrix 策略配置
    strategy:
      # 不阻止其他组合继续测试
      fail-fast: false
      # 矩阵定义：会生成 3 × 3 = 9 个 Job
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20, 22]
      # 排除不需要的组合（可选）
      # exclude:
      #   - os: macos-latest
      #     node-version: 18

    steps:
      # Step 1: 检出代码
      - uses: actions/checkout@v4

      # Step 2: 设置 Node.js（版本从 matrix 中获取）
      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          # 根据不同系统缓存 npm
          cache: 'npm'

      # Step 3: 安装依赖
      - name: Install dependencies
        run: npm ci

      # Step 4: 运行测试
      - name: Run tests
        run: npm test

      # Step 5: 显示系统信息（验证运行环境）
      - name: System info
        run: |
          echo "OS: ${{ runner.os }}"
          echo "Node: $(node --version)"
          echo "npm: $(npm --version)"
        # Windows 上需要用 PowerShell
        shell: bash
```

**你的任务：** 故意在不同平台上制造差异，观察行为是否一致。

**验证：**
- [ ] Workflow 是否正确生成了 9 个 Job（或你指定数量的 Job）
- [ ] 每个 Job 是否在正确的 OS + Node 版本上运行
- [ ] 是否所有 Job 并行运行
- [ ] 如果某个 Job 失败，其他 Job 是否继续运行（取决于 fail-fast 设置）

---

### v3：Full CI + Deploy Workflow（完整 CI/CD）

**目标：** 一个完整的 CI/CD 流水线：测试 → 构建 → 部署到 GitHub Pages

**新增概念：** 多 Job 依赖、产物上传/下载、部署、条件执行

在 `.github/workflows/v3-full-ci-cd.yml` 中编写：

```yaml
# .github/workflows/v3-full-ci-cd.yml
# 刻意练习 v3：完整的 CI/CD 工作流
#
# 学习要点：
# 1. 多 Job 如何协同工作（needs 依赖）
# 2. 如何在不同 Job 之间传递产物（upload / download artifact）
# 3. CI 和 CD 如何串联
# 4. 环境变量的使用
# 5. 条件执行（只在 main 分支部署）
# 6. 2026 年推荐的 OIDC 安全的 Pages 部署方式

name: V3 - Full CI/CD Pipeline

# 触发条件
on:
  push:
    branches: [main]
    # 排除 docs 目录变更（不需要触发 CI）
    paths-ignore:
      - 'docs/**'
      - 'README.md'
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      deploy-to-pages:
        description: '是否部署到 GitHub Pages'
        required: true
        default: true
        type: boolean

# 全局环境变量
env:
  NODE_VERSION: '20'
  BUILD_DIR: 'dist'

jobs:
  # ==========================================
  # Job 1: Lint & Test（代码质量与测试）
  # ==========================================
  lint-and-test:
    name: Lint & Test
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint
        # 如果 lint 失败，整个 Job 失败，不会继续到 deploy
        continue-on-error: false

      - name: Run tests
        run: npm test

      - name: Upload test results (even on failure)
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: |
            junit.xml
            coverage/
          # if-no-files-found 设为 warn 而不是 error
          if-no-files-found: warn

  # ==========================================
  # Job 2: Build（构建）
  # 依赖 Job 1 成功（needs: lint-and-test）
  # ==========================================
  build:
    name: Build
    # ★ 依赖声明：Job 1 成功后才会执行
    needs: lint-and-test
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build project
        run: npm run build
        # 假设 package.json 中有 "build" 脚本
        # 例如：vite build / webpack --mode production

      # ★ 关键：将构建产物上传，供下一个 Job 使用
      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: ${{ env.BUILD_DIR }}/
          # 保留 7 天
          retention-days: 7

  # ==========================================
  # Job 3: Test on Multiple OS（兼容性测试）
  # 与 Job 2 并行执行（依赖相同，互不依赖）
  # ==========================================
  matrix-test:
    name: Test on ${{ matrix.os }}
    # 同样依赖 Job 1
    needs: lint-and-test
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, windows-latest]

    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test

  # ==========================================
  # Job 4: Deploy to GitHub Pages（部署）
  # 只有在推送到 main、且构建成功后执行
  # ==========================================
  deploy:
    name: Deploy to GitHub Pages
    # ★ 依赖 Job 2（构建）
    needs: build
    # ★ 条件执行：只在 main 分支且不是 PR 时部署
    if: |
      github.ref == 'refs/heads/main' &&
      github.event_name != 'pull_request'
    runs-on: ubuntu-latest

    # ★ 设置 Pages 部署的权限（2026 年推荐做法）
    permissions:
      contents: read
      pages: write
      id-token: write    # 使用 OIDC，无需密钥！

    # ★ 指定 Pages 环境
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      # 下载 Job 2 上传的构建产物
      - name: Download build artifacts
        uses: actions/download-artifact@v4
        with:
          name: build-output
          path: ${{ env.BUILD_DIR }}

      # 上传 Pages 产物
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ${{ env.BUILD_DIR }}

      # ★ 部署到 GitHub Pages
      - name: Deploy to Pages
        id: deployment
        uses: actions/deploy-pages@v4

      # 发送部署通知（如果配置了 Slack Webhook）
      - name: Send deployment notification
        if: success()
        run: |
          echo "✅ Deployed successfully!"
          echo "URL: ${{ steps.deployment.outputs.page_url }}"
```

### v3 的 Job 依赖关系图

```
┌──────────────────┐
│  lint-and-test   │ ← CI 入口：质量关卡
└────────┬─────────┘
         │
         ├────────────────────┐
         ▼                    ▼
┌──────────────────┐  ┌──────────────────┐
│     build        │  │   matrix-test    │
│ （构建产物）     │  │ （并行兼容测试） │
└────────┬─────────┘  └──────────────────┘
         │
         ▼
┌──────────────────┐
│  deploy (条件)   │ ← 仅 main 分支 + 非 PR
│  GitHub Pages    │
└──────────────────┘
```

### 配置 GitHub Pages 前置步骤

在运行 v3 Workflow 部署到 Pages 之前，需要先在仓库设置中启用 Pages：

1. 进入仓库 **Settings → Pages**
2. 在 **Source** 中选择 **GitHub Actions**
3. 这样 Pages 就等待 Actions 来部署了

### 刻意练习后的反思检查

完成三个版本后，问自己：

```
v1 → v2 学到了什么？
  ☐ YAML 文件的结构和语法
  ☐ 基本触发条件配置
  ☐ actions/checkout 的作用

v2 → v3 学到了什么？
  ☐ Matrix 策略配置
  ☐ fail-fast 的含义
  ☐ 动态 Job 名称

v3 完整 CI/CD 学到了什么？
  ☐ Job 依赖（needs）
  ☐ 产物传递（upload/download artifact）
  ☐ 条件执行（if）
  ☐ Pages 部署流程
  ☐ OIDC 安全认证
```

---

## 番茄7：复习巩固（25分钟）

### 7.1 一天知识点思维导图

```
GitHub Actions CI/CD
│
├── 核心概念
│   ├── Workflow（工作流）- .github/workflows/*.yml
│   ├── Job（作业）- 一组步骤
│   ├── Step（步骤）- 单个命令或 Action
│   ├── Runner（运行器）- 执行环境
│   └── Event（事件）- 触发条件
│
├── YAML 语法
│   ├── 缩进（空格，非 Tab）
│   ├── key: value
│   ├── 列表用 -
│   └── # 注释
│
├── 触发条件
│   ├── push / pull_request
│   ├── schedule（cron 定时）
│   ├── workflow_dispatch（手动）
│   └── 路径/分支过滤
│
├── Marketplace Actions
│   ├── actions/checkout - 检出代码
│   ├── actions/setup-node - 配置 Node.js
│   ├── actions/cache - 缓存加速
│   ├── actions/upload-artifact - 上传产物
│   └── actions/deploy-pages - 部署 Pages
│
├── Matrix 策略
│   ├── 多版本并行测试
│   ├── include / exclude
│   └── fail-fast / max-parallel
│
└── 完整 CI/CD
    ├── 多 Job 协作（needs）
    ├── 产物传递（artifact）
    ├── 条件执行（if）
    └── 安全部署（OIDC + Pages）
```

### 7.2 易错点排查表

| 问题 | 原因 | 解决 |
|:-----|:-----|:-----|
| Workflow 不运行 | YAML 格式错误 | 用 `yamlint` 或在线工具检查格式 |
| Workflow 不运行 | 文件名不在 `.github/workflows/` | 检查路径是否正确 |
| Workflow 不运行 | branches 过滤条件不匹配 | 检查分支名和通配符 |
| `npm ci` 失败 | 没有 `package-lock.json` | 改用 `npm install` |
| Matrix 不生成多个 Job | 缩进错误 | 检查 `strategy.matrix` 缩进 |
| 构建产物获取不到 | 没有 upload 就 download | 检查 `needs` 依赖和 upload 步骤 |
| 部署失败 | Pages 未启用 Actions 部署模式 | Settings → Pages → Source: GitHub Actions |
| Secret 为空 | Secret 未添加到仓库 | 检查 Settings → Secrets and variables |

### 7.3 快速命令/代码速查卡

```yaml
# === 最简 Workflow 模板 ===
name: Quick Start
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "Hello World!"

# === 常用触发条件 ===
on:
  push: { branches: [main] }
  pull_request: { branches: [main] }
  schedule: [{ cron: '0 0 * * *' }]
  workflow_dispatch: {}

# === Matrix 配置 ===
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [18, 20]
  fail-fast: false

# === 条件执行 ===
if: github.ref == 'refs/heads/main'
if: success() / failure() / always() / cancelled()

# === 环境变量引用 ===
${{ env.NODE_VERSION }}
${{ matrix.os }}
${{ github.ref }}
${{ secrets.MY_SECRET }}
```

### 7.4 2026 年 GitHub Actions 新特性速览

1. **OIDC 成为默认认证方式**：不再需要存储云服务密钥，更安全
2. **Artifact Attestation**：构建产物自动签名，防止供应链攻击
3. **精细化管理 Runner**：支持更细粒度的 Runner 标签和资源控制
4. **ARM64 Runner 正式发布**：可在 ARM 架构上运行 Workflow
5. **Workflow 可视化增强**：GitHub 界面升级了 Workflow 拓扑图
6. **Durable Workflow**：支持长时间运行的工作流（实验性功能）

> ✋ **费曼自测**：用"做菜"的类比向朋友解释 CI/CD 的概念。比如："CI 就像是煮菜的过程中随时尝味道，确保每一步都正确。CD 就像是菜做好了之后自动端到桌上。"

---

## 番茄8：输出成果 + 自我检查（25分钟）

### 8.1 今日成果清单

今天的核心产出：

```
成果 1：理解 CI/CD 核心概念
成果 2：掌握 YAML 语法，能读懂 Workflow 文件
成果 3：创建了第一个 CI Workflow
成果 4：使用 Matrix 策略实现多版本测试
成果 5：刻意练习 - 完成了 3 个递进式 Workflow
成果 6：理解了部署流程（GitHub Pages CD）
```

### 8.2 最终自检清单

```markdown
- [ ] 我能用大白话向非技术人员解释 CI/CD 的概念
- [ ] 我能说出 Workflow / Job / Step / Runner / Event 的区别
- [ ] 我能写一个最简的 Workflow 文件（骨架正确）
- [ ] 我知道 4 种以上触发事件的配置方法
- [ ] 我会在 Workflow 中使用 Marketplace Action
- [ ] 我能配置 Matrix 策略做多版本测试
- [ ] 我理解 Job 之间的依赖关系（needs）
- [ ] 我会在 Job 之间传递构建产物（upload/download artifact）
- [ ] 我能配置条件执行（if 语法）
- [ ] 我完成了刻意练习的 3 个递进版本
- [ ] 我成功部署了一个页面到 GitHub Pages
- [ ] 我知道如何排查 Workflow 失败的常见原因
```

### 8.3 付诸实践：给你自己的项目配 CI

选择你当前正在开发的项目（不限语言）：

| 语言 | 推荐 Action | 测试框架 |
|:-----|:------------|:---------|
| **JavaScript/TypeScript** | actions/setup-node | Jest, Vitest |
| **Python** | actions/setup-python | pytest |
| **Java** | actions/setup-java | JUnit, Maven |
| **Go** | actions/setup-go | go test |
| **Rust** | actions-rust-lang/setup-rust-toolchain | cargo test |
| **Ruby** | actions/setup-ruby | RSpec |

**操作步骤：**
1. 在项目中创建 `.github/workflows/ci.yml`
2. 编写对应语言的 Workflow
3. 推送并观察运行结果
4. 如果能成功通过，去仓库加一个 **CI 状态徽章**！

### 8.4 添加状态徽章

在 README.md 中添加 CI 状态徽章，让别人一眼看到你的项目状态：

```markdown
![CI Status](https://github.com/<你的用户名>/<仓库名>/actions/workflows/ci.yml/badge.svg)
```

或者如果是 v3 的完整流水线：

```markdown
[![CI](https://github.com/<你的用户名>/<仓库名>/actions/workflows/v3-full-ci-cd.yml/badge.svg)](https://github.com/<你的用户名>/<仓库名>/actions/workflows/v3-full-ci-cd.yml)
```

### 8.5 预习：Day 4 预告

**明天主题：GitHub Pages 实战**

```
Day 4 你将学到：
  📦 从零搭建 Jekyll/Hugo 静态站点
  🎨 自定义域名 + HTTPS
  🔄 自动部署（Actions + Pages）
  📊 访问统计 + SEO 优化
  🚀 完整项目：从代码到上线的全流程
```

### 8.6 记忆卡片（Anki 格式）

将以下内容导入 Anki 或其他记忆工具：

```
Q: GitHub Actions 中 Workflow/Job/Step 的关系是什么？
A: Workflow 包含多个 Job，每个 Job 包含多个 Step。Workflow 是完整的自动化流程文件。

Q: Action 和 Step 有什么区别？
A: Step 是 Workflow 的最小执行单元。Action 是可复用的 Step 实现（别人写好的 Step 封装）。

Q: Matrix 策略中 fail-fast: false 是什么意思？
A: 当一个 Job 失败时，不取消其他正在运行的 Job。做兼容性测试时建议设为 false。

Q: 如何在 Job 之间传递文件？
A: 用 actions/upload-artifact 上传，另一个 Job 用 actions/download-artifact 下载。

Q: schedule 触发使用的时区是什么？
A: UTC 时间，北京时间需要 +8 小时。

Q: 2026 年推荐的 GitHub Actions 认证方式是什么？
A: OIDC（OpenID Connect），不需要在 Secrets 中存储长期密钥，更安全。
```

### 8.7 进一步学习资源

- [GitHub Actions 官方文档](https://docs.github.com/en/actions)
- [GitHub Marketplace](https://github.com/marketplace?type=actions) - 查找更多 Action
- [Awesome Actions](https://github.com/sdras/awesome-actions) - 社区精选 Action 列表
- [GitHub Actions 示例集合](https://github.com/actions/starter-workflows) - 各种语言的 Starter Workflow
- [Day 2 回顾：分支与协作工作流](Day2-分支与协作工作流.md) | [Day 4 预告：GitHub Pages 实战](Day4-实战项目一-GitHub-Pages部署.md)

---

> **Day 3 完成！** 🎉
>
> 你已经从一个对 CI/CD 一无所知的开发者，成长为能编写完整自动化流水线的工程师。
>
> 记住：**理解概念比记住语法更重要，动手实践比阅读文档更有效。**
>
> 明天见，继续 GitHub Pages 实战之旅！

---

## 附录：完整练习文件索引

完成所有练习后，你的仓库中应该有以下文件：

```yaml
.github/workflows/
├── ci.yml                 # 番茄3：第一个 CI Workflow
├── v1-lint.yml            # 番茄6：刻意练习 v1
├── v2-matrix-test.yml     # 番茄6：刻意练习 v2
└── v3-full-ci-cd.yml      # 番茄6：刻意练习 v3
```

> **建议**：将练习仓库设为公开，展示你的 CI/CD 学习成果！
