# Day 1：Git 基础与仓库管理

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 Git 核心操作，创建第一个 GitHub 仓库
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：提交-修改-查看循环 × 5 次重复

---

## 今日学习路径

```
🍅 番茄1-2：理解 Git 核心概念 + SSH 配置
🍅 番茄3-4：第一个仓库与首次提交
🍅 番茄5-6：分支操作与刻意练习
🍅 番茄7-8：复习巩固 + 输出成果
```

---

## 番茄钟1：Git 核心概念（25分钟）

### 1.1 用大白话理解 Git

**Git 是什么？**

想象你在写一本书，每写一版你都说"保存一下"：

```
普通保存：只保留最新版本
Git 保存：保留每次修改的历史 + 谁改的 + 为什么改 + 随时可以回退
```

**Git 不是 GitHub！** 很多人搞混：

| 概念 | 类比 | 说明 |
|:-----|:-----|:------|
| **Git** | 你的本地"时光机" | 版本控制工具，离线可用 |
| **GitHub** | 云端"图书馆" | 托管 Git 仓库的网站，在线协作 |

**核心思维转变：**

```
没有 Git：代码只有一份，"改坏了就完了"
有了 Git：每次提交都是"存档点"，随时可以"读档"
```

### 1.2 Git 三大区域

这是 Git 最核心的概念——**理解了这个，后面全是操作**：

```
工作区（Working Directory）    ← 你正在编辑的文件
    │
    │  git add （暂存，类似于"选中要保存的修改"）
    ▼
暂存区（Staging Area）        ← 选中的修改，等待打包
    │
    │  git commit （提交，类似于"打包存档"）
    ▼
本地仓库（Local Repository）   ← 已保存的存档记录
```

> ✋ **费曼自测**：用"写书"的类比向朋友解释 Git 的三大区域。如果只 `git add` 但没 `git commit`，修改会被保存吗？

---

## 番茄钟2：Git 安装与 SSH 配置（25分钟）

### 2.1 检查/安装 Git

```bash
# 检查是否已安装
git --version

# macOS（用 Homebrew）
brew install git

# Windows（用 winget）
winget install Git.Git

# Linux（Ubuntu/Debian）
sudo apt install git-all

# 安装后确认
git --version  # 期望 >= 2.40
```

### 2.2 首次配置

```bash
# 告诉 Git 你是谁（这些信息会记录在每次提交中）
git config --global user.name "你的名字"
git config --global user.email "your@email.com"

# 设置默认分支名
git config --global init.defaultBranch main

# 查看配置
git config --list
```

### 2.3 配置 SSH Key（连接 GitHub 的关键）

**用大白话讲：** SSH Key 就像你的"数字身份证"——GitHub 通过它来识别你是谁，不用每次输密码。

```bash
# 1. 生成 SSH Key（一路回车）
ssh-keygen -t ed25519 -C "your@email.com"

# 2. 查看公钥（复制出来）
cat ~/.ssh/id_ed25519.pub

# 3. 打开 GitHub → Settings → SSH and GPG keys → New SSH key
# 4. 粘贴公钥，保存

# 5. 测试连接
ssh -T git@github.com
# 期望输出：Hi 你的名字! You've successfully authenticated...
```

> ⚠️ **常见错误**：如果 `Permission denied`，检查是否用了正确的邮箱生成 Key。

> ✋ **费曼自测**：SSH Key 为什么比密码更安全？为什么需要一对公钥和私钥？

---

## 🍅 番茄钟1-2结束，休息5分钟

**验证清单：**
- [x] `git --version` 显示版本号
- [x] `git config --list` 显示你的姓名和邮箱
- [x] `ssh -T git@github.com` 认证成功

---

## 番茄钟3：创建第一个仓库（25分钟）

### 3.1 在 GitHub 上创建仓库

1. 打开 https://github.com/new
2. 填写仓库名：`my-first-repo`
3. 选择 **Public**（公开）
4. ✅ 勾选 `Add a README file`
5. ✅ 勾选 `.gitignore` → 选择 `Node`（或你的语言）
6. 点击 **Create repository**

### 3.2 克隆到本地

```bash
# 克隆（把远程仓库下载到本地）
git clone git@github.com:你的用户名/my-first-repo.git

# 进入目录
cd my-first-repo

# 查看仓库状态
git status
```

**克隆后你会看到什么：**

```
my-first-repo/
├── .git/          ← Git 的"魔法文件夹"（不要动它！）
├── .gitignore     ← 告诉 Git 忽略哪些文件
└── README.md      ← 仓库的"门面"
```

### 3.3 第一次修改与提交

```bash
# 1. 编辑 README.md 添加内容
echo "# My First Repo\n\n这是我的第一个 GitHub 仓库！" > README.md

# 2. 查看状态（会显示 README.md 被修改）
git status

# 3. 添加到暂存区
git add README.md

# 4. 提交到本地仓库
git commit -m "初始化 README，添加项目描述"

# 5. 推送到 GitHub
git push origin main
```

> ✋ **费曼自测**：`git status`、`git add`、`git commit`、`git push` 这四个命令分别对应"写书"类比中的什么操作？

---

## 番茄钟4：文件的增删改查（25分钟）

### 4.1 文件生命周期

```
Untracked（未跟踪）    ← 新建的文件，Git 还不认识
    │
    │  git add
    ▼
Staged（已暂存）       ← Git 知道它了，等待提交
    │
    │  git commit
    ▼
Unmodified（未修改）   ← 已存档，和仓库一致
    │
    │ 修改文件
    ▼
Modified（已修改）     ← 改过了，等待再次暂存
    │
    │  git add → git commit（循环）
    ▼
Unmodified（又回到原点）
```

### 4.2 操作演练

```bash
# 创建新文件
echo "console.log('hello')" > app.js

# 查看状态（Untracked 文件）
git status

# 添加到暂存区
git add app.js

# 再次查看（变成 Staged）
git status

# 提交
git commit -m "添加 app.js 入口文件"

# 修改文件
echo "console.log('hello world')" > app.js

# 查看修改内容（强烈推荐养成习惯）
git diff

# 提交修改
git add app.js && git commit -m "更新 app.js 输出内容"

# 查看提交历史
git log --oneline
# 输出示例：
# abc1234 更新 app.js 输出内容
# def5678 添加 app.js 入口文件
# ghi9012 初始化 README，添加项目描述

# 推送到远程
git push origin main
```

> ✋ **费曼自测**：新建文件 → 修改 → 提交 这个循环，`git status` 应该在第几步使用？为什么每次都先 `git status` 是个好习惯？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [x] GitHub 上创建了 `my-first-repo`
- [x] 本地克隆成功
- [x] 完成至少 3 次提交并推送到远程
- [x] 能看懂 `git log --oneline` 的输出

---

## 番茄钟5：分支操作（25分钟）

### 5.1 用大白话理解分支

**分支是什么？**

想象你写小说时想试试"另一个结局"：

```
main（主线剧情）──A──B──C──D
                         │
                         └── feature-ending（分支剧情）
                               └── E──F
```

分支让你**同时开发多个功能**，互不干扰，最后合并。

### 5.2 分支核心操作

**刻意练习：建立分支操作的心智模型**

```bash
# 查看当前分支（* 号表示当前所在分支）
git branch
# * main

# 创建新分支
git branch feature-login

# 切换到新分支
git checkout feature-login
# 或一步到位（推荐）
git checkout -b feature-login

# 在新分支上工作
echo "function login() {}" > login.js
git add login.js && git commit -m "添加登录功能"

# 切换回 main 分支
git checkout main
# 注意：login.js 不见了！因为 main 分支没有这个文件

# 合并分支
git merge feature-login
# login.js 又出现了

# 删除分支（合并后可以删除）
git branch -d feature-login

# 推送到远程（首次推送需要 -u）
git push -u origin feature-login
```

### 5.3 分支命名规范

| 分支类型 | 命名示例 | 说明 |
|:---------|:---------|:-----|
| 主分支 | `main` | 稳定版本，永远可部署 |
| 功能分支 | `feature/login-page` | 新功能开发 |
| 修复分支 | `fix/login-bug` | Bug 修复 |
| 发布分支 | `release/v1.0` | 版本发布准备 |

> ✋ **费曼自测**：如果不小心在 main 分支上直接修改了代码，但你想把它放到一个新分支上，应该怎么做？

---

## 番茄钟6：刻意练习——提交-修改-查看循环 × 5（25分钟）

### 6.1 刻意练习目标

在 25 分钟内**重复 5 次**完整的 Git 操作循环，形成肌肉记忆。

### 6.2 练习任务

```bash
# ===== 循环 1：基本文件操作 =====
echo "<!-- 首页 -->" > index.html
git add index.html && git commit -m "添加 index.html"
git push origin main

# ===== 循环 2：修改已跟踪文件 =====
echo "<!-- 首页 - v2 -->" > index.html
git diff  # 观察修改内容
git add index.html && git commit -m "更新 index.html 内容"
git push

# ===== 循环 3：多文件操作 =====
echo "body { color: red; }" > style.css
echo "<link rel='stylesheet' href='style.css'>" >> index.html
git add . && git commit -m "添加样式文件并引用"
git push

# ===== 循环 4：分支操作 =====
git checkout -b feature-nav
echo "<nav>导航</nav>" >> index.html
git add . && git commit -m "添加导航栏"
git checkout main
git merge feature-nav
git push

# ===== 循环 5：回滚操作 =====
# 查看历史
git log --oneline -3
# 回退到上一个版本（但保留修改在工作区）
git reset --soft HEAD~1
# 查看文件还在
cat index.html
# 重新提交
git add . && git commit -m "重新提交（合并导航+样式）"
git push --force-with-lease
```

### 6.3 自检清单

完成 5 次循环后检查：

| 技能 | 1次 | 2次 | 3次 | 4次 | 5次 |
|:-----|:---:|:---:|:---:|:---:|:---:|
| `git status` 检查状态 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| `git add` 暂存 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| `git commit -m ""` 提交 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| `git push` 推送 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
| `git log --oneline` 查看历史 | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：不看笔记，写出完整的一次"修改→提交→推送"命令序列。`git reset --soft HEAD~1` 做了什么？和 `git reset --hard` 有什么区别？

---

## 🍅 番茄钟5-6结束，休息5分钟

**刻意练习成果：**
- [x] 完成 5 次提交-修改-查看循环
- [x] 体验了分支创建和合并
- [x] 尝试了版本回滚

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

**Git 数据流（必须记住）：**

```
工作区 → git add → 暂存区 → git commit → 本地仓库 → git push → 远程仓库
                                                                     │
           远程仓库 ← git pull ← 本地仓库 ← git merge ← 分支 ← git branch
```

### 7.2 你今天学到的所有命令

| 命令 | 功能 | 使用频率 |
|:-----|:-----|:---------|
| `git init` | 初始化新仓库 | 低（项目开始时） |
| `git clone <url>` | 克隆远程仓库 | 中 |
| `git status` | 查看工作区状态 | **极高**（每天 50+ 次） |
| `git add <file>` | 暂存文件 | **极高** |
| `git commit -m "msg"` | 提交暂存区 | **极高** |
| `git push` | 推送到远程 | 高 |
| `git pull` | 拉取远程更新 | 高 |
| `git branch` | 查看分支 | 中 |
| `git checkout -b <name>` | 创建并切换分支 | 中 |
| `git merge <branch>` | 合并分支 | 中 |
| `git log --oneline` | 查看简洁历史 | 中 |
| `git diff` | 查看修改内容 | 高 |
| `git reset --soft HEAD~1` | 回退一次提交 | 低 |

### 7.3 刻意练习复盘

回答三个问题：

1. **今天哪个操作最不熟练？** ____（回去再练 3 次）
2. **哪个概念最抽象？** ____（试试用类比解释）
3. **哪些场景会用到今天学的技能？** ____

---

## 番茄钟8：输出成果（25分钟）

### 8.1 创建学习笔记

```markdown
# GitHub 学习笔记 - Day 1

> 日期：2026-06-11
> 完成状态：✅

## 核心结论
掌握了 Git 的三大区域（工作区/暂存区/仓库）和基本的提交-推送循环。

## 关键要点
1. Git ≠ GitHub：Git 是本地版本控制，GitHub 是远程托管
2. 标准操作流：git status → git add → git commit → git push
3. 分支是轻量级的，大胆创建、随时合并、用完即删
4. 每次提交前先 git diff 检查修改内容

## 刻意练习记录
- 提交-修改-查看循环完成 5 次
- 最不熟练的操作：____
- 需要加强的概念：____
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：能画图解释 Git 三大区域
- [ ] **番茄3-4**：完成了首次提交和推送
- [ ] **番茄5-6**：掌握了分支操作，完成 5 次刻意练习循环
- [ ] **番茄7-8**：创建了今日学习笔记

### 8.3 进阶挑战（可选）

```bash
# 尝试理解 .gitignore 的用法
echo ".DS_Store" >> .gitignore   # macOS 系统文件
echo "node_modules/" >> .gitignore  # Node 依赖
echo "*.log" >> .gitignore          # 日志文件
git add .gitignore && git commit -m "配置 .gitignore"

# 尝试 git stash（临时保存工作区修改）
echo "临时修改" >> index.html
git stash
git stash list
git stash pop
```

---

## 🎉 Day 1 完成！

**今日成果：**
- ✅ 理解 Git 三大区域核心概念
- ✅ 配置 SSH Key 连接 GitHub
- ✅ 完成 5 次提交-修改-查看刻意练习
- ✅ 掌握分支创建、切换、合并

**明天预告：** [[Day2-分支与协作工作流]] - 学习 PR、Issue、Code Review 和冲突解决

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day2-分支与协作工作流]] - 下一天内容
