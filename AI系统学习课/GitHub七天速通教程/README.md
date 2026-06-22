# GitHub 七天速通教程

> ⏱ 总学时：56个番茄钟（约24小时）
> 🎯 学习方式：每日8个番茄钟，边学边练
> 🧠 教学方法：番茄工作法 × 费曼学习法 × 刻意练习
> 📅 创建日期：2026-06-11

---

## 学习目标

**一周后你能：**
1. ✅ 熟练使用 Git 进行版本控制（提交、分支、合并、解决冲突）
2. ✅ 掌握 GitHub 协作流程（PR、Issue、Code Review）
3. ✅ 编写 GitHub Actions 自动化工作流
4. ✅ 用 GitHub Pages 部署个人站点
5. ✅ 使用 GitHub Projects 管理项目
6. ✅ 理解开源协作规范并贡献代码
7. ✅ 掌握 GitHub Copilot、Stacked PRs 等 2026 新特性

---

## 一周日程概览

| 日期 | 主题 | 番茄钟 | 核心产出 | 刻意练习重点 |
|:-----|:-----|:-------|:---------|:------------|
| **Day 1** | Git 基础与仓库管理 | 8个 | 创建第一个仓库，掌握提交/分支 | 重复提交-修改-查看循环 |
| **Day 2** | 分支与协作工作流 | 8个 | 完成第一个 PR 和 Code Review | 模拟团队冲突解决 |
| **Day 3** | GitHub Actions CI/CD | 8个 | 编写自动化测试+部署工作流 | 从简单到复杂的递进 Workflow |
| **Day 4** | GitHub Pages 实战 | 8个 | 部署个人博客网站 | 完整项目从零到上线 |
| **Day 5** | 高级特性与 AI 协作 | 8个 | 配置 Projects、Copilot、Stacked PRs | 多 PR 管理工作流 |
| **Day 6** | 开源贡献实战 | 8个 | 为真实开源项目贡献代码 | Fork→PR→Review→Merge 全流程 |
| **Day 7** | 复习与生态全景 | 8个 | 构建个人 GitHub 知识图谱 | 综合复习考试 + 能力评估 |

---

## 每日时间安排

```
每个番茄钟 = 25分钟专注 + 5分钟休息

上午（番茄1-4）：理论理解 + 核心操作 + 刻意练习
下午（番茄5-6）：实战操作 + 动手练习
晚上（番茄7-8）：复习巩固 + 输出成果
```

## 刻意练习设计原则

本教程融入**刻意练习（Deliberate Practice）**方法论，每章包含：

| 原则 | 实现方式 |
|:-----|:---------|
| **明确目标** | 每日首标明确当天能力目标 |
| **渐进难度** | 任务从简单到复杂递进 |
| **即时反馈** | 每步操作后有验证检查点 |
| **重复变式** | 同一技能在不同场景重复练习 |
| **突破舒适区** | 每章设"进阶挑战"任务 |
| **反思总结** | 每番茄后设回顾环节 |

---

## 教程文件索引

| 文件 | 内容 | 刻意练习 |
|:-----|:-----|:---------|
| [[Day1-Git基础与仓库管理]] | Git初始化、提交、分支、SSH配置 | 提交-修改-查看循环×5 |
| [[Day2-分支与协作工作流]] | PR、Issue、Code Review、冲突解决 | 模拟团队冲突解决×3 |
| [[Day3-GitHub-Actions与CI-CD]] | Workflow语法、CI/CD流水线 | 递进式Workflow编写 |
| [[Day4-实战项目一-GitHub-Pages部署]] | Pages、Jekyll、自定义域名 | 从零到上线完整项目 |
| [[Day5-高级特性与AI协作]] | Projects、Copilot、Stacked PRs、Security | 多PR管理工作流 |
| [[Day6-实战项目二-开源贡献]] | Fork、Contribute、社区规范 | Fork→PR→Merge全流程 |
| [[Day7-复习与生态全景]] | 总结、安全、生态、综合考试 | 综合能力评估 |

---

## 前置准备

### 需要的资源

1. **GitHub 账号**
   - 免费注册：https://github.com/signup
   - 建议开启 Two-Factor Authentication (2FA)

2. **开发环境**
   - Git（>= 2.40）：`git --version` 检查
   - 代码编辑器（VS Code 推荐）
   - 终端（macOS Terminal / Windows PowerShell / Linux Bash）

3. **网络准备**
   - 能访问 github.com
   - 配置 SSH Key（Day 1 会教）

4. **可选（Day 5 需要）**
   - GitHub Copilot 订阅（学生可免费申请）
   - Node.js 18+（GitHub Copilot Desktop App）

---

## 每日自检清单

```markdown
- [ ] Day 1：能独立创建仓库、提交代码、切换分支
- [ ] Day 2：能发起 PR、做 Code Review、解决合并冲突
- [ ] Day 3：能编写 GitHub Actions 工作流并触发 CI
- [ ] Day 4：能通过 GitHub Pages 部署个人站点
- [ ] Day 5：会使用 Projects 看板和 Copilot AI 功能
- [ ] Day 6：能为开源项目贡献代码
- [ ] Day 7：能画出 GitHub 生态全景图
```

---

## 常见问题速查

| 问题 | 解决方案 |
|:-----|:---------|
| `Permission denied (publickey)` | SSH Key 未配置，运行 `ssh-keygen` 并添加到 GitHub |
| `Merge conflict` | 手动编辑冲突文件，删除 `<<<<<<<` 标记后提交 |
| `Push rejected` | 本地落后于远程，先 `git pull --rebase` |
| `Actions 不触发` | 检查 `.github/workflows/` 路径和 YAML 语法 |
| `Pages 404` | 检查 Settings → Pages 中分支和路径配置 |
| `Copilot 不工作` | 检查订阅状态和 IDE 插件连接 |

---

## 开始学习

👉 从 [[Day1-Git基础与仓库管理]] 开始你的 GitHub 速通之旅！

---

> **下一步推荐学习：** 完成本教程后，可继续学习 GitHub Copilot SDK 开发、GitHub Actions 高级 Workflow、或参与 GitHub 开源社区贡献指南。
