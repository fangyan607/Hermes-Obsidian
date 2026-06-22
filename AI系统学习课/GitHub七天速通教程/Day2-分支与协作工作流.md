# Day 2：分支与协作工作流

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 PR/Issue/Code Review 完整协作流程
> 🧠 教学方法：费曼学习法 × 刻意练习
> 🎯 刻意练习重点：合并冲突解决 × 3 次练习

---

## 今日学习路径

```
🍅 番茄1-2：理解协作工作流概览 + PR/Issue 核心概念
🍅 番茄3-4：PR 完整操作 + Code Review 实战
🍅 番茄5-6：合并冲突解决 + 刻意练习（冲突解决 × 3）
🍅 番茄7-8：复习巩固 + 输出成果 + Stacked PRs 新特性
```

---

## 🍅 番茄1：协作工作流全景（25分钟）

### 1.1 为什么需要协作工作流？

昨天你学会了 Git 单人操作——提交、分支、推送。但真实开发中，你**几乎不会一个人在 main 分支上直接写代码**。

想象一个场景：

> 你和同事小明同时修改同一个项目。你加了登录功能，他加了支付功能。
> 你们各自在自己的分支上开发，互不干扰。
> 开发完成后，通过 Pull Request 请求对方审查代码。
> 审查通过后，合并到主分支。
> 如果两人改了同一个文件，就产生了"合并冲突"——需要手动解决。

这就是 **GitHub 协作工作流** 的核心。

### 1.2 协作工作流的四个角色

```
┌─────────────────────────────────────────────────────┐
│                    GitHub 仓库                        │
│                                                      │
│   main ────●──────────●──────────●────→             │
│             ↑          ↑          ↑                  │
│             │          │          │                  │
│   PR #1  ●──┘    PR #2 ●──┘    PR #3 ●──┘           │
│   (登录功能)      (支付功能)      (优化)              │
│                                                      │
│   Issue #1 ── 功能请求                                │
│   Issue #2 ── Bug 报告                                │
└─────────────────────────────────────────────────────┘
```

四个关键概念：

| 概念 | 大白话 | 现实类比 |
|:-----|:-------|:---------|
| **Issue** | "任务卡片"或"讨论帖" | 便利贴上写：要做什么/出了什么 bug |
| **Pull Request (PR)** | "合并请求" | 你说：我写好了，你 check 一下，没问题就合进去 |
| **Code Review** | "代码审查" | 同事说：这里写得不对，改一下再合 |
| **Merge** | "合并" | 把你的改动合并到主分支 |

### 1.3 GitHub Flow vs Git Flow

两种最主流的协作策略，你需要知道它们的区别。

#### GitHub Flow（推荐初学者）

GitHub 官方推荐的**极简工作流**：

```ascii
main ──────●─────────●─────────●──
            ↑         ↑         ↑
feature    ●→PR→Merge ●→PR→Merge ●→PR→Merge
```

**流程（4步）：**
1. 从 `main` 创建功能分支
2. 在分支上提交修改
3. 创建 Pull Request
4. Code Review 通过后合并回 `main`

**特点：** 简单、适合持续部署（CI/CD）、适合中小团队。

#### Git Flow（复杂但严谨）

适用于有**发布周期**的项目：

```ascii
main ──────●─────────────────●── (v1.0)──●── (v1.1)
            ↑                 ↑          ↑
develop ────●────●────●──────●──────────●──
                 ↑    ↑    ↑            ↑
feature         ●    ●    ●            ● (hotfix)
release                          ●──●──●
```

**分支类型：**
| 分支 | 用途 |
|:-----|:------|
| `main` | 生产版本，只有发布时才合并 |
| `develop` | 日常开发主分支 |
| `feature/*` | 新功能开发 |
| `release/*` | 发布准备（只修 bug，不加功能） |
| `hotfix/*` | 紧急修复生产 bug |

**初学者建议：从 GitHub Flow 开始。** GitHub Flow 包含了 90% 的日常协作场景，Git Flow 等你进了大公司自然会接触。

> ✋ **费曼自测**：向朋友解释 GitHub Flow 的 4 个步骤。Git Flow 比 GitHub Flow 多出了哪些分支类型？什么场景下需要用 Git Flow？

---

## 🍅 番茄2：Issue 创建与管理（2026新版）（25分钟）

### 2.1 用大白话理解 Issue

**Issue 就是"任务帖"。**

在 GitHub 上，Issue 用来：
- 🐛 **报告 Bug**：在"用户登录后页面崩溃"
- ✨ **请求功能**：希望增加"记住密码"功能
- 📝 **记录任务**：重构用户模块
- 💬 **讨论方案**：数据库用 MySQL 还是 PostgreSQL？

### 2.2 创建第一个 Issue

**步骤：**
1. 打开你的仓库 → 点击 **Issues** → **New Issue**
2. 填写标题（清晰、简洁）
3. 填写描述（用模板最好）

**好的 Issue 模板：**

```markdown
### 描述
用户登录后，点击"个人中心"按钮，页面白屏无响应。

### 复现步骤
1. 打开登录页，输入账号密码
2. 点击"登录"
3. 跳转到首页，点击右上角"个人中心"
4. 页面白屏

### 期望行为
应该显示个人中心页面，包含用户信息和设置选项。

### 实际行为
浏览器白屏，控制台报错：Uncaught TypeError: Cannot read property 'name' of undefined

### 环境
- 浏览器：Chrome 120
- 操作系统：Windows 11
- 应用版本：v2.3.1
```

### 2.3 Issue Fields —— 2026年新特性

2026年，GitHub 推出了 **Issue Fields**——你可以给 Issue 添加结构化字段，像填表格一样管理任务。

**内置字段：**

| 字段 | 可选值 | 用途 |
|:-----|:-------|:-----|
| **Priority（优先级）** | Critical, High, Medium, Low | 紧急程度 |
| **Effort（工作量）** | Small, Medium, Large, X-Large | 预估耗时 |
| **Status（状态）** | Todo, In Progress, Done | 进度跟踪 |
| **Team（团队）** | Frontend, Backend, Design, QA | 负责团队 |

**如何启用：** 仓库 Settings → Issues → **Issue Fields** → 开启并配置自定义字段。

**可视化效果：** Issue 列表现在可以像 Notion/飞书表格一样显示字段列。

```ascii
┌──────────────────────────────────────────────────────────┐
│ Issues                                                 │
│                                                        │
│ [#3] 用户登录后页面白屏    🟥 Critical 🟧 Medium  Frontend│
│ [#2] 增加"记住密码"功能     🟧 High    🟩 Small  Backend │
│ [#1] 重构用户模块            🟩 Medium  🟨 Large  Fullstack│
│                                                        │
│ 优先级↑                工作量↑     团队↑               │
└──────────────────────────────────────────────────────────┘
```

**为什么重要：** 以前你需要在标题里写 `[Critical] 用户登录白屏`，现在直接用字段标记，筛选和排序更方便。

### 2.4 Issue 最佳实践

1. **标题格式：** `[类型] 简短描述` — 如 `[Bug] 登录页面白屏`
2. **一个 Issue 只做一件事** — 不要在一个 Issue 里同时报告三个 bug
3. **使用标签（Labels）：** `bug`, `enhancement`, `good first issue`
4. **关联 PR：** 在 PR 描述中输入 `Closes #3`，PR 合并后会自动关闭 Issue

> ✋ **费曼自测**：不加描述，只写一句"页面打不开"的 Issue 有什么问题？用 Issue Fields 的 Priority 和 Effort 字段，给管理者带来什么好处？

---

## 🍅 番茄1-2结束，休息5分钟

**验证清单：**
- [ ] 能画图解释 GitHub Flow 和 Git Flow 的区别
- [ ] 能在自己的仓库里创建一个 Issue
- [ ] 能描述 Issue Fields 中 Priority 和 Effort 的用途
- [ ] 知道 `Closes #3` 这种语法的作用

---

## 🍅 番茄3：PR 完整操作——从创建到合并（25分钟）

### 3.1 用大白话理解 PR

**PR 就是"我写好了，你检查一下，没问题就合进去"。**

想象你和室友一起做饭：
```
你做了一道菜（在 feature 分支上开发）
你对室友说："我做好了，你尝尝咸淡"（创建 PR）
室友尝了一口说："盐少了，再加点"（Code Review 提出意见）
你加了盐（修改代码）
室友说："行了，装盘吧"（Approve）
你把菜倒进大盘子里（Merge 到 main）
```

### 3.2 完整 PR 流程演练

**场景：** 你和同事合作开发一个项目。你要加一个"用户登录"功能。

**Step 1：创建功能分支**

```bash
# 确保 main 是最新的
git checkout main
git pull origin main

# 创建功能分支（规范命名）
git checkout -b feature/user-login
```

**Step 2：开发并提交**

```bash
# 写代码
echo "function login(email, password) { /* ... */ }" > login.js

# 提交
git add login.js
git commit -m "feat: 添加用户登录功能"

# 推送到远程（首次推送需要 -u）
git push -u origin feature/user-login
```

**Step 3：在 GitHub 上创建 PR**

推送后，GitHub 会显示一个黄色的提示框："**feature/user-login** had recent pushes" → 点击 **Compare & pull request**。

填写 PR 信息：

```markdown
## 描述
新增用户登录功能。

## 做了什么
- 添加 login.js，实现邮箱+密码登录
- 添加表单验证
- 错误提示优化

## 如何测试
1. 启动项目
2. 访问 /login
3. 输入 test@example.com / 123456
4. 验证能正常登录

## 相关 Issue
Closes #2

## 截图
[相关截图]

## 检查清单
- [ ] 代码风格一致
- [ ] 无控制台报错
- [ ] 单元测试通过
```

**关键设置：**
- **Reviewers**：选择审查人（你的同事）
- **Assignees**：分配给自己
- **Labels**：选择 `enhancement`
- **Projects**：关联到项目看板

### 3.3 PR 的四种状态

```ascii
PR 创建
  │
  ├──→ Open（开放状态，等待 Review）
  │       │
  │       ├──→ Changes Requested（审查人要求修改）
  │       │       │
  │       │       └──→ 修改后重新提交
  │       │
  │       ├──→ Approved（审查通过）
  │       │       │
  │       │       └──→ Merge（合并）
  │       │
  │       └──→ Closed（主动关闭，不需要合并）
  │
  └──→ Merged（已合并）
```

**命令对照：**

```bash
# 创建 PR（命令行方式）
gh pr create --title "feat: 用户登录功能" --body "实现邮箱密码登录"

# 查看 PR 列表
gh pr list

# 查看 PR 详情
gh pr view 3

# 合并 PR
gh pr merge 3
```

> ✋ **费曼自测**：PR 和 Branch 是什么关系？如果没有 PR，直接在 main 上 push 会有什么问题？

---

## 🍅 番茄4：Code Review 最佳实践（25分钟）

### 4.1 为什么要做 Code Review？

**Code Review 不是为了"挑刺"，而是为了：**

1. **发现 Bug** — 写代码的人容易陷入思维盲区
2. **提高代码质量** — 有人看着，你会写得更好
3. **知识共享** — 团队都知道代码在干什么
4. **统一风格** — 保持代码一致性
5. **你不在时有人能接手** — 别人看过你的代码，出了问题能修

### 4.2 作为 PR 创建者（你提交 PR）

**好的 PR 习惯：**

1. **PR 要小** —— 一个 PR 只做一件事。100 行以内的 PR 最好 Review，1000 行的 PR 没人想看
2. **标题要清晰** —— `feat: 用户登录功能` 比 `更新代码` 好 100 倍
3. **描述要完整** —— 告诉审查人"改了什么、为什么改、怎么测试"
4. **自己先 Review 一遍** —— 提交 PR 前自己看一遍 diff，能发现一半的问题

```bash
# 提交 PR 前的自检
git diff main...HEAD  # 查看当前分支和 main 的差异
# 确认没有: 调试代码、console.log、密码硬编码、多余文件
```

### 4.3 作为 Code Reviewer（你审查别人的 PR）

| 审查维度 | 具体看什么 |
|:---------|:-----------|
| **逻辑正确性** | 代码逻辑有没有漏洞？边界情况考虑了吗？ |
| **代码质量** | 有没有重复代码？函数是不是太长？命名是否清晰？ |
| **安全性** | 有没有 SQL 注入？用户输入校验了吗？密码明文存储？ |
| **性能** | 有没有不必要的循环？数据库查询优化了吗？ |
| **可维护性** | 以后别人能看懂吗？有注释吗？ |

**Review 评论的三个级别：**

```markdown
// 级别1：必须改（Blocking）
🚫 这里密码明文存储了，必须使用 bcrypt 加密。

// 级别2：建议改（Non-blocking）
💡 这里用 map 代替 forEach 会更简洁，可读性更好。

// 级别3：纯好奇（Question）
❓ q: 这里为什么选择用 axios 而不是 fetch？
```

### 4.4 Code Review 对话示例

**PR #3 — 用户登录功能**

> **Reviewer 小明：**
> ```markdown
> @开发者 整体逻辑没问题，有几个地方需要修改：
>
> 1. login.js:15 — 密码不能明文存储，请使用 bcrypt 加密后再保存。这个必须改，有安全风险。
> 2. login.js:28 — 错误提示用中文写死不太好，建议用 i18n 方案。如果这次时间紧，可以下个 PR 改。
> 3. login.js:5 — `==` 建议改成 `===`，避免类型转换带来的隐式 bug。
>
> 另外想问一下：为什么不用 JWT 而是用 Session？有什么考量？
> ```

> **PR 创建者（你）：**
> ```markdown
> @小明 感谢 Review！
>
> 1. ✅ 已修复，改用 bcrypt 加密
> 2. 📝 先记 Issue 了，下个 PR 加 i18n
> 3. ✅ 已改 ===
>
> > 为什么用 Session 不用 JWT？
> 因为这个项目是服务端渲染，Session 方案更简单，也方便失效控制。
> ```

**核心原则：对事不对人。** Review 的是代码，不是写代码的人。

> ✋ **费曼自测**：Code Review 的三个评论级别是什么？看到一个 bug 和看到一个风格问题时，分别应该用什么级别的评论？

---

## 🍅 番茄3-4结束，休息5分钟

**验证清单：**
- [ ] 完成了一次完整的 PR 创建流程（从分支到合并）
- [ ] 会在 PR 描述中写清楚做了什么、怎么测试
- [ ] 知道 Code Review 的三个评论级别
- [ ] 知道 `gh pr create` 的用法

---

## 🍅 番茄5：合并冲突的解决（25分钟）

### 5.1 用大白话理解合并冲突

**合并冲突就是：两个人同时改了同一个文件的同一行代码，Git 不知道听谁的。**

想象你和朋友同时修改同一份 Word 文档：

```
你改了第1行："今天是周一"
朋友也改第1行："今天是周二"
Word 问：到底保留哪个？→ 这就是合并冲突
```

### 5.2 冲突产生的原因

```ascii
时间线：

main:      A───B───C───D  ← 同事合并了自己的修改
                 \
feature:          └───E───F  ← 你在开发新功能

             同时修改了同一个文件！
             第10行内容不同 → 冲突！
```

**具体场景：**

你改了 `index.js` 的第 10 行，同事也改了 `index.js` 的第 10 行，你们都推送了。当你执行 `git merge main` 把同事的改动合并进来时：

```
Auto-merging index.js
CONFLICT (content): Merge conflict in index.js
Automatic merge failed; fix conflicts and then commit the result.
```

### 5.3 解决冲突的完整流程

**Step 1：看到冲突提示**

```bash
git merge main
# CONFLICT in index.js
```

**Step 2：打开冲突文件**

你会看到这样的标记：

```javascript
function greet() {
<<<<<<< HEAD
  console.log("你好！");      // ← 你的修改（当前分支）
=======
  console.log("Hello!");     // ← 同事的修改（合并进来的分支）
>>>>>>> main
}
```

**冲突标记解释：**
| 标记 | 含义 |
|:-----|:------|
| `<<<<<<< HEAD` | 你的修改开始 |
| `=======` | 分隔线 |
| `>>>>>>> main` | 对方的修改结束 |

**Step 3：选择保留方案**

你有三种选择：

```javascript
// 方案1：保留你的
console.log("你好！");

// 方案2：保留对方的
console.log("Hello!");

// 方案3：两个都保留（合并）
console.log("你好！Hello!");

// 方案4：重写（双方都不要，重新写）
console.log("こんにちは！");
```

**Step 4：标记为已解决并提交**

```bash
# 删除冲突标记，保留想要的内容

# 确认所有冲突都解决了
git status
# 应该没有 "both modified" 的文件了

# 标记为已解决（其实就是 add 到暂存区）
git add index.js

# 提交合并
git commit -m "解决合并冲突：统一 greeting 为中英文双语"

# 推送
git push
```

### 5.4 可视化合并工具

如果你觉得手动编辑冲突标记太麻烦，可以用可视化工具：

```bash
# 使用 VSCode 内置的合并编辑器
git config --global merge.tool vscode
git mergetool
```

VSCode 的合并编辑器会显示三列：
- **左侧（Incoming）** — 对方修改
- **中间（Result）** — 最终结果（你在这里编辑）
- **右侧（Current）** — 你的修改

### 5.5 避免冲突的最佳实践

1. **频繁拉取**：`git pull origin main` 每天至少一次
2. **小 PR**：PR 越小，冲突概率越低
3. **多沟通**：改公共文件前在群里说一声
4. **代码拆分**：把大文件拆成小模块，减少多人改同一文件

> ✋ **费曼自测**：`<<<<<<< HEAD` 和 `>>>>>>> main` 分别代表什么？为什么经常拉取 `git pull` 可以减少冲突？

---

## 🍅 番茄6：刻意练习——合并冲突解决 × 3（25分钟）

### 6.1 准备环境

在 25 分钟内**解决 3 次不同类型的冲突**，形成肌肉记忆。

```bash
# 创建一个练习仓库
mkdir conflict-practice
cd conflict-practice
git init
git checkout -b main

# 初始文件
cat > app.js << 'EOF'
console.log("App 启动");

const users = ["Alice", "Bob"];

function showUsers() {
  users.forEach(user => {
    console.log(user);
  });
}

showUsers();
EOF

git add . && git commit -m "初始化项目"
```

### 6.2 练习1：单行冲突（最简单）

```bash
# 创建分支1：feature/greeting
git checkout -b feature/greeting
cat > app.js << 'EOF'
console.log("App 启动");

const greeting = "你好！";

const users = ["Alice", "Bob"];

function showUsers() {
  users.forEach(user => {
    console.log(user);
  });
}

showUsers();
EOF
git add . && git commit -m "feat: 添加问候语"

# 切回 main 创建分支2
git checkout main
git checkout -b feature/color
cat > app.js << 'EOF'
console.log("App 启动");

const themeColor = "蓝色";

const users = ["Alice", "Bob"];

function showUsers() {
  users.forEach(user => {
    console.log(user);
  });
}

showUsers();
EOF
git add . && git commit -m "feat: 添加主题色"

# 制造冲突：合并 feature/greeting 到 feature/color
git merge feature/greeting  # ← 这里会冲突！
```

**解决任务：**
- 两个分支都在第 3 行添加了不同代码
- 目标是：**同时保留 `greeting` 和 `themeColor`**

**预期结果：**

```javascript
console.log("App 启动");

const greeting = "你好！";
const themeColor = "蓝色";

const users = ["Alice", "Bob"];

function showUsers() {
  users.forEach(user => {
    console.log(user);
  });
}

showUsers();
```

```bash
# 解决后
git add app.js
git commit -m "解决冲突：同时保留 greeting 和 themeColor"
```

✅ **练习1完成标记：** ⬜

---

### 6.3 练习2：同一函数内的冲突（中等难度）

```bash
# 从干净的 main 开始
git checkout main

# 分支1：feature/users-extended
git checkout -b feature/users-extended
cat > app.js << 'EOF'
console.log("App 启动");

const users = ["Alice", "Bob", "Charlie", "Diana"];

function showUsers() {
  console.log("用户列表：");
  users.forEach((user, index) => {
    console.log(`${index + 1}. ${user}`);
  });
  console.log(`共 ${users.length} 位用户`);
}

showUsers();
EOF
git add . && git commit -m "feat: 扩展用户列表，添加序号显示"

# 切回 main 创建分支2
git checkout main
git checkout -b feature/users-filter
cat > app.js << 'EOF'
console.log("App 启动");

const users = ["Alice", "Bob"];

function showUsers() {
  const adminUsers = users.filter(user => user.startsWith("A"));
  console.log("管理员用户：");
  adminUsers.forEach(user => {
    console.log(user);
  });
}

showUsers();
EOF
git add . && git commit -m "feat: 过滤显示管理员用户"

# 制造冲突
git merge feature/users-extended  # ← 冲突！
```

**解决任务：**
- 两个分支重构了 `showUsers` 函数
- 目标是：**合并两个功能**——显示带序号的用户列表，同时过滤出管理员并单独显示

**预期结果（解决思路）：**

```javascript
console.log("App 启动");

const users = ["Alice", "Bob", "Charlie", "Diana"];

function showUsers() {
  console.log("用户列表：");
  users.forEach((user, index) => {
    console.log(`${index + 1}. ${user}`);
  });

  const adminUsers = users.filter(user => user.startsWith("A"));
  console.log("管理员用户：");
  adminUsers.forEach(user => {
    console.log(user);
  });

  console.log(`共 ${users.length} 位用户`);
}

showUsers();
```

```bash
git add app.js
git commit -m "解决冲突：合并用户扩展和筛选功能"
```

✅ **练习2完成标记：** ⬜

---

### 6.4 练习3：多文件冲突（综合实战）

```bash
# 从干净的 main 开始
git checkout main

# 创建分支1：feature/auth
git checkout -b feature/auth
mkdir -p src
cat > src/auth.js << 'EOF'
function login(email, password) {
  if (!email || !password) {
    throw new Error("邮箱和密码不能为空");
  }
  return { email, token: "fake-token-123" };
}

function logout() {
  console.log("已退出登录");
}

module.exports = { login, logout };
EOF

cat > src/index.js << 'EOF'
const auth = require("./auth");

const user = auth.login("test@test.com", "123456");
console.log("登录成功：", user.email);
EOF

git add . && git commit -m "feat: 添加用户认证模块"

# 切回 main 创建分支2
git checkout main
mkdir -p src
cat > src/profile.js << 'EOF'
function getProfile(userId) {
  return {
    id: userId,
    name: "Alice",
    avatar: "/avatars/alice.png"
  };
}

function updateProfile(userId, data) {
  console.log(`更新用户 ${userId} 的资料`);
  return { ...data, id: userId };
}

module.exports = { getProfile, updateProfile };
EOF

cat > src/index.js << 'EOF'
const profile = require("./profile");

const userProfile = profile.getProfile(1);
console.log("用户资料：", userProfile.name);
EOF

git add . && git commit -m "feat: 添加用户资料模块"

# 制造冲突
git merge feature/auth  # ← 冲突！
```

**解决任务：**
- `src/index.js` 冲突（两人都创建了）
- 目标是：**让两个模块共存**，`index.js` 同时引入 auth 和 profile

**预期结果：**

```javascript
const auth = require("./auth");
const profile = require("./profile");

const user = auth.login("test@test.com", "123456");
console.log("登录成功：", user.email);

const userProfile = profile.getProfile(1);
console.log("用户资料：", userProfile.name);
```

```bash
git add .
git commit -m "解决冲突：合并 auth 和 profile 模块"
```

✅ **练习3完成标记：** ⬜

---

### 6.5 刻意练习复盘

| 练习 | 冲突类型 | 难度 | 完成情况 | 用时 |
|:-----|:---------|:----|:---------|:-----|
| 1️⃣ 单行冲突 | 同时添加新代码 | ⭐ | ⬜ | ____ |
| 2️⃣ 函数内冲突 | 同时修改同一函数 | ⭐⭐ | ⬜ | ____ |
| 3️⃣ 多文件冲突 | 同时创建/修改多个文件 | ⭐⭐⭐ | ⬜ | ____ |

**自检清单：**
- [ ] 不用查笔记，能写出冲突标记的完整结构（HEAD/====/>>>>）
- [ ] 知道冲突时三个选择：保留谁的？如何合并？
- [ ] 知道解决冲突后需要 `git add` + `git commit`
- [ ] 能解释 `git merge` 和 `git rebase` 解决冲突的区别（见附录）

> ✋ **费曼自测**：三个冲突练习分别用了什么策略来解决？如果你在解决冲突时不确定某段代码要不要保留，应该怎么办？

---

## 🍅 番茄5-6结束，休息5分钟

**刻意练习成果：**
- [ ] 完成 3 次冲突解决练习
- [ ] 体验了单行冲突和函数内冲突两种类型
- [ ] 掌握了冲突标记的读写能力

---

## 🍅 番茄7：今日复习 + 2026新特性（25分钟）

### 7.1 核心概念回顾

**协作工作流全景图：**

```ascii
                        ┌──────────────────┐
                        │   Issue Fields   │
                        │  Priority/Effort │
                        └────────┬─────────┘
                                 │ 描述需求
                                 ▼
┌─────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 创建分支 │───→│ 提交代码 │───→│ 创建 PR  │───→│ Code     │
│ feature/ │    │ git add  │    │ gh pr    │    │ Review   │
│ login    │    │ commit   │    │ create   │    │          │
└─────────┘    └──────────┘    └──────────┘    └────┬─────┘
                                                     │
                  ┌──────────────────────────────────┘
                  ▼
          ┌──────────────┐    ┌──────────┐    ┌──────────┐
          │ 有冲突？     │──→│ 解决冲突 │──→│ 合并PR   │
          │ git merge    │    │ 手动编辑 │    │ gh pr    │
          │ CONFLICT     │    │ git add  │    │ merge    │
          └──────────────┘    └──────────┘    └──────────┘
```

### 7.2 2026新特性：Stacked PRs（堆叠式PR）

**什么是 Stacked PRs？**

当你开发一个大功能时，PR 太大不好 Review。Stacked PRs 把大 PR **拆成多个小 PR 堆叠起来**，每个 PR 依赖前一个。

**传统方式：**

```ascii
一个大 PR（500行修改）→ 没人想 Review
```

**Stacked PRs 方式：**

```ascii
PR #3 ──── 退款功能（50行）    ← 依赖 PR #2
PR #2 ──── 支付处理（150行）   ← 依赖 PR #1
PR #1 ──── 购物车功能（100行）  ← 基础功能
         ↑
     先合并这个
```

**为什么好用：**
- 每个 PR 100-200 行，Review 起来轻松
- 可以并行 Review，不用等前一个 PR 合并
- 早期发现设计问题，不用等全部写完

**如何使用：**

```bash
# 使用 gh CLI + gh-stack 扩展（GitHub 官方推出的实验性工具）

# 安装 gh-stack
gh extension install github/gh-stack

# 创建 Stack：基于 main 的 3 个分支
git checkout -b feature/cart         # PR #1
git commit -m "feat: 购物车功能"

git checkout -b feature/payment      # PR #2（基于 cart）
git commit -m "feat: 支付处理"

git checkout -b feature/refund       # PR #3（基于 payment）
git commit -m "feat: 退款功能"

# 提交整个 Stack
gh stack submit

# 查看 Stack 状态
gh stack status

# 当 PR #1 合并后，更新 Stack
gh stack sync
```

**适用场景：** 大功能开发、重构、多步骤 feature。

**不适用：** 小 PR（小于 100 行的 PR 不需要 stack）、单人开发的个人项目。

### 7.3 命令速查表

| 类别 | 命令 | 功能 |
|:-----|:-----|:-----|
| **Issue** | `gh issue create` | 创建 Issue |
| | `gh issue list` | 查看 Issue 列表 |
| | `gh issue view 3` | 查看 Issue 详情 |
| **PR** | `gh pr create` | 创建 PR |
| | `gh pr list` | 查看 PR 列表 |
| | `gh pr view 3` | 查看 PR 详情 |
| | `gh pr checkout 3` | 检出 PR 到本地 |
| | `gh pr merge 3` | 合并 PR |
| **冲突** | `git merge <branch>` | 合并分支（有冲突时会提示） |
| | `git merge --abort` | 放弃本次合并，回到合并前状态 |
| | `git mergetool` | 启动可视化合并工具 |
| **Review** | `gh pr review 3 --approve` | 通过 Review |
| | `gh pr review 3 --comment "msg"` | 添加评论 |
| | `gh pr review 3 --request-changes` | 要求修改 |
| **Stack** | `gh stack submit` | 提交 Stacked PRs |
| | `gh stack status` | 查看 Stack 状态 |
| | `gh stack sync` | 同步 Stack |
| **Issue** | `gh issue create` | 创建 Issue（可带 Field） |

### 7.4 费曼自测总复习

回答以下问题，确保今天的内容真正理解了：

1. 🎯 **PR 是什么？**
   → "一种请求合并代码的机制，包含代码变更和讨论上下文"

2. 🎯 **冲突标记 `<<<<<<< HEAD` 和 `>>>>>>> main` 分别代表什么？**
   → HEAD 是你的修改，main 是你正在合并进来的修改

3. 🎯 **Good PR vs Bad PR 的区别？**
   → 好的 PR：小、描述清晰、一个功能、带测试
   → 差的 PR：大、标题模糊、多个功能、没描述

4. 🎯 **什么时候用 GitHub Flow vs Git Flow？**
   → 小团队/持续部署 → GitHub Flow
   → 大项目/版本发布周期 → Git Flow

---

## 🍅 番茄8：输出成果 + 进阶挑战（25分钟）

### 8.1 创建今日学习笔记

```markdown
# GitHub 学习笔记 - Day 2

> 日期：2026-06-11
> 完成状态：✅

## 核心结论
掌握了 PR 完整流程和冲突解决，理解了协作工作流的本质是"规范化的沟通"。

## 关键要点
1. GitHub Flow：main → feature branch → PR → Review → Merge
2. Issue Fields（2026）：用 Priority/Effort 等结构化字段管理任务
3. Code Review 三级别：必须改 / 建议改 / 纯好奇
4. 冲突解决三步：找标记 → 选方案 → add + commit
5. Stacked PRs（2026）：大 PR 拆小，堆叠依赖

## 刻意练习记录
- 冲突解决练习 1（单行冲突）：____（完成/未完成）
- 冲突解决练习 2（函数内冲突）：____（完成/未完成）
- 冲突解决练习 3（多文件冲突）：____（完成/未完成）
- 最不熟练的操作：____
- 需要加强的概念：____

## 明日预告
Day 3：CI/CD 与 GitHub Actions —— 自动化构建、测试、部署
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：能画图解释 GitHub Flow vs Git Flow
- [ ] **番茄3-4**：完成一次完整的 PR 创建→Review→合并流程
- [ ] **番茄5-6**：3 次冲突解决练习都完成了
- [ ] **番茄7**：理解 Stacked PRs 和 Issue Fields（2026新特性）
- [ ] **番茄8**：创建了今日学习笔记

### 8.3 进阶挑战（可选）

**挑战1：用 gh CLI 完成一次全流程操作**

```bash
# 不打开浏览器，全程命令行操作 PR
gh issue create --title "添加暗黑模式" --label "enhancement"
git checkout -b feature/dark-mode
# ... 写代码 ...
git push -u origin feature/dark-mode
gh pr create --title "feat: 添加暗黑模式" --body "实现暗黑/亮色主题切换"
gh pr merge
```

**挑战2：尝试用 rebase 解决冲突（vs merge）**

```bash
# 区别对比：
# git merge → 创建 merge commit，保留完整分支历史
# git rebase → 把当前分支的提交"移植"到目标分支顶部，历史更干净

git checkout feature/my-feature
# 用 rebase 代替 merge
git rebase main
# 如果冲突 -> 解决 -> git add -> git rebase --continue
# 想放弃 -> git rebase --abort
```

**挑战3：为一个开源项目提交 Issue**

```
找一个你常用的开源项目（如 React、Vue、VSCode）
在 GitHub 上找到它的 Issues 页面
找一个类似"good first issue"标签的问题
尝试参与讨论，或者提一个你遇到的 bug
```

---

## 🎉 Day 2 完成！

**今日成果：**
- ✅ 理解 GitHub Flow 和 Git Flow 两种协作策略
- ✅ 掌握 Issue 创建和管理（含 2026 Issue Fields）
- ✅ 完成一次完整的 PR 创建→Review→合并流程
- ✅ 掌握 Code Review 的最佳实践和评论规范
- ✅ 解决 3 次不同类型的合并冲突
- ✅ 了解 Stacked PRs 概念（2026新特性）

**明天预告：** CI/CD 与 GitHub Actions —— 让你的代码自动构建、测试、部署。你会学到怎么用 10 行配置就让每次 Push 自动运行测试。

---

> **相关文件：**
> - [[Day1-Git基础与仓库管理]] - 前一天内容
> - [[Day3-CI-CD与GitHub-Actions]] - 下一天内容
> - [[README]] - 教程总览
