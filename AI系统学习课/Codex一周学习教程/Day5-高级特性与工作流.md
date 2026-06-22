# Day 5：高级特性与工作流集成

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 Codex SDK、多 Agent 并行、CI/CD 集成
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：Codex SDK 入门
🍅 番茄3-4：多 Agent 并行与工作流编排
🍅 番茄5-6：CI/CD 集成实战
🍅 番茄7-8：复习输出 + 综合练习
```

---

## 番茄钟1：Codex SDK 是什么？（25分钟）

### 1.1 用大白话理解 SDK

**没有 SDK：** 你在终端里敲 `codex "..."`，等它做完，拿到结果——这是"手动挡"。

**有了 SDK：** 你在代码里调用 `codex.tasks.create(...)`，像调用一个普通函数——这是"自动挡"。

```
手动挡（CLI）：
  终端操作 → 等待 → 看结果 → 复制粘贴到下一个命令

自动挡（SDK）：
  Python/JS 脚本 → 自动创建任务 → 自动获取结果 → 自动处理
```

**核心思维转变：**

```
CLI 模式：Codex 是人机交互的工具
SDK 模式：Codex 是程序调用的 API → 可嵌入任何自动化流程
```

### 1.2 SDK 能做什么？

```python
# 场景一：批量代码审查
from openai import Codex

client = Codex()
prs = get_open_prs("my-org/my-repo")

for pr in prs:
    task = client.tasks.create(
        repo="my-org/my-repo",
        prompt=f"审查 PR #{pr.number} 的改动，关注安全问题和边界情况",
        environment="review-sandbox",
    )
    post_review_comment(pr.number, task.result)
```

```python
# 场景二：自动化文档生成
from openai import Codex

client = Codex()
changed_files = get_changed_files("main")

for file in changed_files:
    if file.endswith(".py"):
        client.tasks.create(
            repo="my-org/my-repo",
            prompt=f"为 {file} 中的所有公共函数生成文档字符串",
            environment="doc-gen",
        )
```

### 1.3 SDK 适用场景

| 场景 | CLI 方式 | SDK 方式 | 推荐 |
|:-----|:---------|:---------|:-----|
| 一次性代码生成 | `codex "生成..."` | — | ✅ CLI |
| 日常开发 | `codex -a auto-edit` | — | ✅ CLI |
| CI/CD 流水线 | — | SDK 集成 | ✅ SDK |
| 批量 PR 审查 | 逐个操作 | 循环调用 | ✅ SDK |
| 定时维护任务 | Cron + CLI | SDK + Cron | ✅ SDK |
| 复杂工作流 | 手动串联 | 代码编排 | ✅ SDK |

> ✋ **费曼自测**：SDK 和 CLI 最核心的区别是什么？在什么场景下你不得不用 SDK？

---

## 番茄钟2：SDK 实战（25分钟）

### 2.1 安装 SDK

```bash
# Python
pip install openai-codex-sdk

# Node.js (即将推出)
npm install @openai/codex-sdk
```

### 2.2 基础用法

```python
from openai import Codex

# 创建客户端
client = Codex()

# 创建单一任务
task = client.tasks.create(
    repo="my-org/my-repo",
    prompt="给所有缺少 OpenAPI 示例的接口补充示例",
    environment="prod-mirror",  # 生产镜像环境
)

# 等待结果
result = task.wait()  # 或 task.poll()
print(f"状态: {result.status}")
print(f"输出: {result.output}")

# 异步方式
task = client.tasks.create(
    repo="my-org/my-repo",
    prompt="分析代码库并生成架构文档",
    environment="analysis",
    async=True,  # 不阻塞
)

# 稍后检查
status = task.check()
print(f"完成度: {status.progress}%")
```

### 2.3 任务管理与监控

```python
# 列出所有任务
tasks = client.tasks.list(status="running")
for task in tasks:
    print(f"[{task.id}] {task.prompt[:50]}... - {task.status}")

# 获取任务日志
logs = client.tasks.logs(task_id="task_123")
for log in logs:
    print(f"[{log.timestamp}] {log.message}")

# 取消任务
client.tasks.cancel(task_id="task_123")

# 重试失败任务
client.tasks.retry(task_id="task_123")

# 设置任务超时
task = client.tasks.create(
    ..., timeout_minutes=30,  # 30 分钟后自动终止
)
```

### 2.4 使用示例：批量更新文档

```python
"""
场景：项目重构后，批量更新所有受影响的文档
"""
from openai import Codex
import os

client = Codex()

# 获取所有受影响文件
changed_files = [
    "docs/api/authentication.md",
    "docs/api/users.md",
    "docs/guides/migration.md",
]

# 批量创建更新任务
tasks = []
for doc_path in changed_files:
    task = client.tasks.create(
        repo="my-org/my-repo",
        prompt=f"""
        阅读以下文件并更新 {doc_path}：
        1. 检查哪些 API 签名发生了变化
        2. 更新文档中的示例代码
        3. 确保版本号和时间戳正确
        4. 保持原有的文档风格
        
        只修改 {doc_path}，不要动其他文件。
        """,
        environment="docs-sandbox",
        async=True,
    )
    tasks.append(task)

# 等待所有任务完成
results = [t.wait() for t in tasks]

# 生成报告
success = sum(1 for r in results if r.status == "completed")
failed = sum(1 for r in results if r.status == "failed")
print(f"文档更新完成: {success} 成功, {failed} 失败")
```

> ✋ **费曼自测**：用 SDK 和用 CLI 脚本（`codex -q "..."`）本质上有什么不同？SDK 带来的核心价值是什么？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] SDK = 编程方式调用 Codex（CLI 是人工方式）
- [ ] 适合 CI/CD、批量任务、复杂工作流
- [ ] 支持同步（wait）和异步（async）模式

---

## 番茄钟3：多 Agent 并行（25分钟）

### 3.1 为什么需要多 Agent？

```
单 Agent 模式：
  Agent 做任务 A → Agent 做任务 B → Agent 做任务 C
  总时间 = A + B + C

多 Agent 模式：
  Agent 做任务 A ──┐
  Agent 做任务 B ──┼── 并行执行
  Agent 做任务 C ──┘
  总时间 = max(A, B, C)
```

### 3.2 Codex 多 Agent 的实现方式

**方式一：Agents SDK（编程方式）**
```python
from openai import Codex

client = Codex()

# 并行创建多个任务
tasks = [
    client.tasks.create(repo="my-repo", prompt="任务1", environment="sandbox-1"),
    client.tasks.create(repo="my-repo", prompt="任务2", environment="sandbox-2"),
    client.tasks.create(repo="my-repo", prompt="任务3", environment="sandbox-3"),
]

# 同时等待
results = [t.wait() for t in tasks]
```

**方式二：Git Worktree（隔离环境）**
```bash
# 每个 Agent 在自己的 worktree 中工作
git worktree add ../my-repo-agent1 feature/agent1
git worktree add ../my-repo-agent2 feature/agent2

# 在每个目录中分别启动 Codex
cd ../my-repo-agent1 && codex -a auto-edit "添加用户认证"
cd ../my-repo-agent2 && codex -a auto-edit "添加日志模块"
```

### 3.3 实战：多 Agent 并行代码审查

```bash
# 场景：同时审查 3 个不同模块的 PR
codex -q "审查 src/auth/ 的所有改动，关注安全问题"
codex -q "审查 src/api/ 的所有改动，检查 API 兼容性"
codex -q "审查 src/db/ 的所有改动，检查 SQL 注入风险"

# 在三个终端中同时运行
```

### 3.4 多 Agent 的最佳实践

```
✅ 可并行：
  • 不共享状态的模块（utils、docs、test）
  • 独立的文件编辑（不同目录）
  • 只读分析任务（审查、统计）

❌ 不可并行：
  • 共享状态的流水线（A 的输出是 B 的输入）
  • 依赖式重构（先改接口再改实现）
  • 需要全局一致性的任务

最佳实践：
  • 任务拆分到"文件级别"或"模块级别"
  • 每个 Agent 用独立的 Git 分支
  • 最终手工合并，解决冲突
```

> ✋ **费曼自测**：什么类型的任务适合并行，什么不适合？为什么共享状态的流水线不能并行？

---

### 3.5 🆕 App 多 Agent 实战：Worktrees + Review UI（补充）

> **前置条件：** 已安装 Codex Desktop App（详见 [[Codex App 完整指南]]）

CLI 的多 Agent 需要你手动管理终端和 Git 分支。**App 的 Worktree 系统把这个过程自动化了。**

#### 什么是 App Worktree？

```
你：  "我要加三个功能：认证、导出、仪表盘"
      
CLI 做法：
  开 3 个终端 → 手动 git worktree add → 分别运行 codex → 手工合并

App 做法：
  创建 3 个 Thread → 每个自动分配独立 Worktree → 互不干扰 → Review UI 审查 → 一键合并
```

#### 实战对比：CLI vs App 多 Agent

| 维度 | CLI 方式 | App 方式 |
|:-----|:---------|:---------|
| **创建** | `git worktree add` 手动 | 新建 Thread 自动创建 |
| **隔离** | Git Worktree | Git Worktree（自动管理） |
| **监控** | 手动切换终端窗口 | 左侧面板看到所有 Thread 状态 |
| **审查** | `/diff` 文字 Diff | Review UI 图形化 Diff |
| **合并** | `git merge` 手动合并 | Review UI → Approve & Merge |
| **清理** | 手动删除 Worktree | 归档 Thread 自动清理 |

#### Review UI 安全审查工作流

```
App 推荐的安全闭环：

1. 下达任务到 Thread
2. Agent 在独立 Worktree 中工作
3. 完成后通知 → Review UI 显示变更
4. 逐行审查 Diff（可评论、可拒绝）
5. 在 Thread 终端中运行测试（Cmd+J）
6. 满意 → Approve & Merge → 写入本地 Git
7. 不满意 → Request Changes → Agent 自动修改
```

> **关键安全机制：** Codex App **从不自动触碰你的本地 Git 状态**——所有变更都锁在 Worktree 中，直到你在 Review UI 中显式批准合并。

#### 在 Day 5 学到的 App 能力

- **Worktrees** — 并行多 Agent 零冲突的基石
- **Review UI** — 图形化 Diff 审查，降低审查负担
- **Thread 系统** — 每个 Agent 独立会话 + 独立终端
- **无缝切换** — CLI 中 `/app` 跳到 App，上下文不丢失

> 💡 **建议：** 学完本章后，花 1 个番茄钟打开 [[Codex App 完整指南]]，深入学习 App 的 Computer Use、Automations 和插件系统。阅读这部分内容可以替代 CLI 的手动多 Agent 管理。

---

## 番茄钟4：工作流编排（25分钟）

### 4.1 典型工作流模式

```python
"""
模式一：流水线（Pipeline）
A → B → C 串联，每个 Agent 的输入是上一个的输出
"""
from openai import Codex

client = Codex()

# Step 1: 分析
analysis = client.tasks.create(
    repo="my-repo",
    prompt="分析代码库，找出所有需要更新的 API 文档",
).wait()

# Step 2: 规划（输入分析结果）
plan = client.tasks.create(
    repo="my-repo",
    prompt=f"根据分析结果制定文档更新计划：\n{analysis.output}",
).wait()

# Step 3: 执行（输入规划）
execution = client.tasks.create(
    repo="my-repo",
    prompt=f"执行文档更新计划：\n{plan.output}",
).wait()
```

```python
"""
模式二：扇出/扇入（Fan-out/Fan-in）
先把任务拆成多个子任务并行执行，再合并结果
"""
from openai import Codex

client = Codex()

# 扇出：并行执行
modules = ["auth", "api", "db", "ui"]
sub_tasks = []
for module in modules:
    task = client.tasks.create(
        repo="my-repo",
        prompt=f"审查 {module} 模块的代码覆盖率",
        environment=f"review-{module}",
        async=True,
    )
    sub_tasks.append(task)

# 扇入：合并结果
results = [t.wait() for t in sub_tasks]
report = "\n\n".join([f"## {m}\n{r.output}" for m, r in zip(modules, results)])

# 生成汇总报告
summary = client.tasks.create(
    repo="my-repo",
    prompt=f"根据以下各模块审查结果生成汇总报告：\n{report}",
).wait()

print(summary.output)
```

### 4.2 Grafana K6 + Codex：自动化性能测试

```python
"""
扇入/扇出模式的真实案例：
1. 扇出：多 Agent 并行生成性能测试脚本
2. 执行：运行 K6 测试
3. 扇入：汇总分析结果
"""
from openai import Codex

client = Codex()

# 扇出：为每个 API 端点生成测试
endpoints = ["/api/login", "/api/users", "/api/posts"]
gen_tasks = []
for ep in endpoints:
    task = client.tasks.create(
        repo="my-repo",
        prompt=f"为 {ep} 端点生成 K6 性能测试脚本，包含 100 并发用户测试",
        async=True,
    )
    gen_tasks.append(task)

# 执行测试（在 CI 环境中）
test_results = []
for task in gen_tasks:
    result = task.wait()
    test_script = result.output
    # 运行 K6 测试
    import subprocess
    k6_result = subprocess.run(["k6", "run", "--quiet", "-"], 
                                input=test_script, capture_output=True, text=True)
    test_results.append(k6_result.stdout)

# 扇入：分析结果
analysis = client.tasks.create(
    repo="my-repo",
    prompt=f"分析以下性能测试结果，找出性能瓶颈：\n{''.join(test_results)}",
).wait()

print(f"性能分析报告:\n{analysis.output}")
```

> ✋ **费曼自测**：画出一个扇出/扇入（Fan-out/Fan-in）工作流的示意图。这种模式适合解决什么问题？

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] 多 Agent 并行 = 任务拆分 + 独立执行 + 合并结果
- [ ] 流水线模式用于有依赖关系的任务
- [ ] 扇出/扇入模式用于"先拆后合"的场景

---

## 番茄钟5：CI/CD 集成（25分钟）

### 5.1 GitHub Actions + Codex

```yaml
# .github/workflows/codex-review.yml
name: Codex PR Review

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  codex-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 22
          
      - name: Install Codex
        run: npm install -g @openai/codex
        
      - name: Run Codex Review
        env:
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
        run: |
          codex -q "审查此 PR 的改动，重点关注:
          1. 安全漏洞
          2. 性能问题
          3. 代码风格一致性
          4. 测试覆盖率
          输出 JSON 格式报告" > review-report.json
          
      - name: Post Review Comment
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const report = JSON.parse(fs.readFileSync('review-report.json', 'utf8'));
            github.rest.issues.createComment({
              ...context.repo,
              issue_number: context.issue.number,
              body: `## 🤖 Codex Review\n\n${report.summary}`
            });
```

### 5.2 GitLab CI + Codex

```yaml
# .gitlab-ci.yml
codex-audit:
  stage: test
  image: node:22
  script:
    - npm install -g @openai/codex
    - |
      codex -q "审计代码库:
      - 检查硬编码密钥和凭证
      - 检查过期的依赖版本
      - 检查常见安全漏洞 (OWASP Top 10)
      - 生成 Markdown 格式的审计报告" > audit-report.md
  artifacts:
    paths:
      - audit-report.md
    when: always
```

### 5.3 预处理脚本（Sandbox 兼容）

```yaml
# CI 中处理沙箱限制
jobs:
  codex-task:
    steps:
      - name: Install deps (outside sandbox)
        run: npm ci
        
      - name: Run Codex in Full Auto
        run: |
          codex -a full-auto "给所有 src/ 下的 .ts 文件写单元测试"
        # 依赖已安装，沙箱内可直接使用
```

### 5.4 Codex + Cron：定时维护

```bash
# 每日代码健康检查
0 9 * * * cd /path/to/project && codex -q "检查代码健康度: 未使用的导入、过长函数、重复代码" > daily-health.md

# 每周依赖更新检查
0 10 * * 1 cd /path/to/project && codex -q "检查 package.json 中的依赖是否有安全更新"

# 每月架构审查
0 9 1 * * cd /path/to/project && codex -m gpt-5.5 "对整个项目进行架构审查，关注模块耦合度和扩展性"
```

> ✋ **费曼自测**：CI/CD 中集成 Codex 需要处理 Sandbox 的网络限制。你会怎么设计一个"依赖安装+Codex 执行"的 CI 流水线？

---

## 番茄钟6：Slack 与移动端集成（25分钟）

### 6.1 Slack Bot 集成

**前提：** ChatGPT Plus/Pro/Business/Enterprise 用户

```
在 Slack 中 @Codex 机器人：

@Codex 在 my-repo 中检查 main 分支的最近 commit，看看有没有安全问题
  → Codex：已检查最近 5 个 commit，发现 1 个潜在问题...

@Codex 帮我给 my-repo 添加一个 GitHub Action 的 CI 配置
  → Codex：已完成，PR 已创建：[链接]
```

**支持的操作：**
- 👀 **代码审查**：`@Codex review PR #123 in my-repo`
- 🔧 **任务执行**：`@Codex fix the login bug in my-repo`
- 📊 **状态查询**：`@Codex what's the test coverage in my-repo`
- 📝 **文档**：`@Codex update the README in my-repo`

### 6.2 移动端控制

**2026 年 5 月起：** 可通过 ChatGPT 移动端 App 控制 Codex

```
手机上的 ChatGPT → 选择 Codex → 输入任务 → 在笔记本电脑上执行 → 手机收到通知

适用场景：
  • 通勤时提交任务，到办公室就看到结果
  • 开会时让 Codex 后台跑测试
  • 躺在床上审查代码改动
```

### 6.3 Chrome 扩展

**2026 年 5 月发布的 Chrome 扩展：**
- 阅读网页内容作为上下文
- 自动填写表单
- 操作内部系统
- 跨标签页的并行任务

### 6.4 Sites 功能——即时网页应用

```bash
# 一句话创建交互式网页应用
codex -q "创建一个交互式项目管理看板，数据存储用 Markdown 文件，页面包含看板视图和日历视图"
# 生成一个永久 URL，可直接分享使用
```

Sites 功能特点：
- 文档/数据 → 交互式网页应用
- 单一 URL 即可分享
- Business/Enterprise 用户可用

> ✋ **费曼自测**：Slack 集成和移动端控制分别解决了什么场景下的痛点？你觉得哪个对你的工作流帮助最大？

---

## 🍅 番茄钟5-6结束，休息5分钟

**核心概念回顾：**
- [ ] CI/CD 集成：GitHub Actions / GitLab CI + Codex
- [ ] Sandbox 兼容：先在 CI 中装依赖
- [ ] Slack 集成：自然语言触发代码任务
- [ ] 移动端：随时提交任务，后台执行
- [ ] Sites：文档秒变网页应用

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

1. **Codex SDK**
   - 编程方式调用 Codex，适合自动化
   - 支持同步（wait）和异步（async）
   - 核心方法：`tasks.create()`、`task.wait()`、`task.check()`

2. **多 Agent 并行**
   - 流水线（Pipeline）：有依赖关系 → 串行
   - 扇出/扇入（Fan-out/Fan-in）：无依赖关系 → 并行
   - 通过终端多开、SDK、Git Worktree 实现

3. **CI/CD 集成**
   - GitHub Actions / GitLab CI
   - 注意 Sandbox 网络限制
   - 生成报告作为构建产物

4. **Slack + 移动端**
   - Slack 自然语言触发任务
   - 移动端随时提交审查/任务

### 7.2 命令速查卡

| 命令/代码 | 功能 |
|:----------|:-----|
| `client.tasks.create(repo, prompt)` | 创建 Codex 任务 |
| `task.wait()` | 同步等待任务完成 |
| `task.check()` | 异步检查任务状态 |
| `client.tasks.list(status="running")` | 列出运行中的任务 |
| `client.tasks.cancel(task_id)` | 取消任务 |
| `@Codex review PR #123` | Slack 中触发审查 |
| `codex -q "...创建 Sites..."` | 创建网页应用 |

### 7.3 工作流决策表

| 场景 | 方式 | 理由 |
|:-----|:-----|:-----|
| 一次性任务 | CLI | 快速直接 |
| CI/CD 集成 | SDK/GitHub Actions | 自动化 |
| 批量 PR 审查 | SDK + Fan-out | 并行加速 |
| 定时维护 | Cron + CLI | 简单可靠 |
| 团队协作 | Slack | 零门槛 |
| 远程操作 | 移动端 | 随时随地 |

---

## 番茄钟8：输出成果 + 复习作业（25分钟）

### 8.1 创建学习笔记

```markdown
# Codex CLI 学习笔记 - Day 5

> 日期：2026-06-11
> 完成状态：✅

---

## 核心结论
SDK 和多 Agent 是 Codex 从"个人工具"升级为"平台能力"的关键。

## 关键要点

### 1. SDK
- Python SDK 可以编程调用 Codex
- 同步（wait）vs 异步（async）两种模式

### 2. 多 Agent
- 流水线模式：串行依赖
- 扇出/扇入：并行独立任务
- Git Worktree 作为隔离方案

### 3. CI/CD
- GitHub Actions / GitLab CI 集成
- 注意 Sandbox 的网络限制

## 实践成果
- [ ] 安装了 Codex SDK（Python）
- [ ] 完成了 SDK 基础调用
- [ ] 设计了多 Agent 工作流
- [ ] 配置了 GitHub Actions 集成
```

### 8.2 今日复习作业

**作业 1：SDK 实战**
```python
# 用 Codex SDK 写一个 Python 脚本：
# 1. 扫描当前目录的 .md 文件
# 2. 让 Codex 审查每个文件
# 3. 生成汇总报告
```

**作业 2：工作流设计**
为以下场景设计 Codex 工作流，画出流程图：
```
场景：每周一上午，自动审查所有开源贡献者的 PR，
      生成审查报告并 @ 对应的维护者。
```

**作业 3：思考题**
```
Codex SDK 让你能把 AI 编程能力嵌入到任意自动化流程中。
这对软件开发流程会带来什么根本性变化？
未来会不会出现"全自动 PR 流水线"：提交代码 → Codex 审查 →
自动修改 → 自动合并？这个愿景的障碍在哪里？
```

### 8.3 今日自检清单

- [ ] **番茄1-2**：理解 SDK 的概念和基础用法
- [ ] **番茄3-4**：掌握多 Agent 并行和工作流编排
- [ ] **番茄5-6**：理解 CI/CD 和 Slack/移动端集成
- [ ] **番茄7-8**：完成复习作业

---

## 🎉 Day 5 完成！

**今日成果：**
- ✅ 掌握 Codex SDK 基础
- ✅ 理解多 Agent 并行策略
- ✅ CI/CD 集成配置完成
- ✅ 了解 Slack 和移动端集成

**明天预告：** [[Day6-实战项目二代码库重构]] - 用 Codex 分析并重构真实代码库

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day4-实战项目一CLI工具开发]] - 回顾编码协作模式
