# Day 4：实战项目一 — 用 Codex 开发 CLI 工具

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：用 Codex CLI 从零到一完成一个完整的 CLI 工具开发
> 🧠 教学方法：费曼学习法 × 项目驱动学习 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：项目规划 + 需求分析
🍅 番茄3-4：与 Codex 协作开发核心功能
🍅 番茄5-6：测试 + Bug 修复 + 完善
🍅 番茄7-8：文档 + 发布 + 复盘
```

---

## 项目概述

### 今日项目：md-tidy — Markdown 文件批处理工具

**项目目标：** 开发一个 CLI 工具，能对 Markdown 文件做批量整理。

**核心功能：**
1. ✅ 自动修复 Markdown 格式（空行、缩进）
2. ✅ 批量替换文字（如修改链接域名）
3. ✅ 统计文档信息（字数、标题数、链接数）
4. ✅ 支持通配符（`*.md`）和递归目录

**为什么选这个项目：**
- 足够复杂（涉及文件读写、正则、CLI 参数解析）
- 实用性强（Daily use）
- 适合 Codex 发挥（明确的输入输出）

---

## 番茄钟1：项目规划（25分钟）

### 1.1 用大白话定义需求

**我们要做什么？**

```
用户输入：
  md-tidy fix README.md
  md-tidy stats src/**/*.md
  md-tidy replace "old.com" "new.com" --recursive

工具输出：
  ✅ 修复格式后的 Markdown
  📊 文档统计报告
  🔄 批量替换后的结果
```

### 1.2 项目设计

```
md-tidy/
├── src/
│   ├── index.ts        ← 入口：CLI 参数解析
│   ├── commands/
│   │   ├── fix.ts      ← 格式修复命令
│   │   ├── stats.ts    ← 统计命令
│   │   └── replace.ts  ← 替换命令
│   └── utils/
│       ├── file.ts     ← 文件操作工具
│       └── format.ts   ← Markdown 格式工具
├── package.json
├── tsconfig.json
└── AGENTS.md
```

### 1.3 项目前置准备

```bash
# 创建项目目录
mkdir md-tidy && cd md-tidy

# 初始化项目
npm init -y

# 安装依赖
npm install commander  # CLI 参数解析
npm install -D typescript @types/node

# 配置 TypeScript
npx tsc --init --target es2022 --module commonjs --outDir dist --rootDir src --strict true
```

### 1.4 创建 AGENTS.md

```markdown
# AGENTS.md

## Project
md-tidy - Markdown file batch processing CLI tool

## Commands
- Build: `npm run build`
- Test: `npm test`
- Dev: `npm run build && node dist/index.js`

## Tech Stack
- TypeScript strict mode
- Commander.js for CLI
- Node.js 18+

## Conventions
- Named exports only
- Async/await over callbacks
- Error-first error handling
- Unit tests in __tests__/
```

> ✋ **费曼自测**：在开始写代码之前，为什么要先做项目规划和设计？用 Codex 做项目和直接让它写代码有什么不同？

---

## 番茄钟2：Codex 协作模式（25分钟）

### 2.1 与 Codex 协作的最佳方式

```
传统方式：让 Codex "一次生成所有代码"
  → 问题：代码量大时容易混乱，难以调试

更好的方式：分步迭代
  1. 先让 Codex 理解项目结构
  2. 一次做一个功能模块
  3. 每完成一步就验证
  4. 逐步完善
```

### 2.2 Codex 工作流的 4 个阶段

**阶段一：探索（Explore）**
```bash
codex "阅读项目目录，告诉我当前的项目结构"
```

**阶段二：规划（Plan）**
```bash
codex "我需要创建一个 CLI 工具项目，结构是... 你觉得这个设计合理吗？"
```

**阶段三：执行（Execute）**
```bash
codex -a auto-edit "创建 src/index.ts，用 commander.js 解析命令..."
```

**阶段四：验证（Verify）**
```bash
codex -q "检查代码，运行测试，报告结果"
```

### 2.3 好 Prompt 的 3 个要素

```
差的 Prompt：
"帮我写这个工具"

好的 Prompt：
  1. 明确上下文
  2. 具体任务
  3. 验收标准
```

**好的 Prompt 示例：**
```
"在 src/commands/fix.ts 中创建一个导出函数 fixMarkdown，
接收文件路径参数，用正则修复常见的 Markdown 格式问题（多余空行、缩进不一致），
返回修复后的内容。使用 fs/promises 进行异步文件操作。"
```

> ✋ **费曼自测**：为什么"分步迭代"比"一次生成"更适合用 Codex 做项目？

---

## 🍅 番茄钟1-2结束，休息5分钟

**验证清单：**
- [ ] 项目目录结构创建完成
- [ ] package.json 和依赖安装完成
- [ ] tsconfig.json 配置完成
- [ ] AGENTS.md 创建完成

---

## 番茄钟3：核心命令开发（25分钟）

### 3.1 建立入口文件

```bash
codex -a auto-edit "
在 src/index.ts 中，使用 commander.js 创建 CLI 入口：
- 命令：fix, stats, replace
- 全局选项：--verbose, --dry-run
- fix: <files...> 要修复的文件
- stats: <files...> 要统计的文件
- replace: <from> <to> <files...> --recursive

每个命令调用 src/commands/ 下对应模块的导出函数
"
```

### 3.2 开发 fix 命令

```bash
codex -a auto-edit "
在 src/commands/fix.ts 中实现格式修复功能：

fixMarkdown(content: string): string
需要修复的问题：
1. 删除连续多余的空白行（最多保留一个空行）
2. 确保标题前后各有一个空行
3. 列表项缩进统一为 2 空格
4. 代码块前后各有一个空行

使用正则表达式实现，每个修复步骤有独立函数。
导出 fixMarkdown 和 fixFile(path: string): Promise<void>
"
```

### 3.3 开发 stats 命令

```bash
codex -a auto-edit "
在 src/commands/stats.ts 中实现统计功能：

analyzeMarkdown(content: string): MdStats
MdStats 接口包含：
- totalChars: number（总字符数）
- totalWords: number（总词数）
- headingCount: number（标题数，按级别统计）
- linkCount: number（链接数，区分内链外链）
- codeBlockCount: number（代码块数）
- listItemCount: number（列表项数）
- estimatedReadTime: number（估算阅读时间，中文 300字/分钟）

导出 analyzeMarkdown 和 statsFile(path: string): Promise<MdStats>
"
```

> ✋ **费曼自测**：在让 Codex 写代码前，你自己先想清楚 fixMarkdown() 需要处理哪几种格式问题。说给你的"橡皮鸭"听。

---

## 番茄钟4：replace 命令 + 工具函数（25分钟）

### 4.1 开发 replace 命令

```bash
codex -a auto-edit "
在 src/commands/replace.ts 中实现批量替换功能：

replaceInContent(content: string, from: string, to: string, options?: {
  regex?: boolean;      // 是否使用正则
  caseSensitive?: boolean; // 是否区分大小写
}): string

导出 replaceInContent 和 replaceInFile(
  path: string, from: string, to: string, options?
): Promise<{ path: string; replaced: boolean; count: number }>
"
```

### 4.2 开发文件工具函数

```bash
codex -a auto-edit "
在 src/utils/file.ts 中实现文件操作工具：

- findFiles(patterns: string[], options?: { recursive?: boolean }): Promise<string[]>
  // 支持 glob 模式匹配文件，如 'src/**/*.md'

- readFile(path: string): Promise<string>
  // 读取文件，UTF-8

- writeFile(path: string, content: string): Promise<void>
  // 写入文件，先备份原文件为 .bak

- backupFile(path: string): Promise<string>
  // 创建 .bak 备份，返回备份路径
"
```

### 4.3 构建并测试

```bash
# 构建项目
npm run build

# 测试命令
node dist/index.js stats src/ --verbose

# 创建测试用 Markdown 文件
echo '# Test\n\nHello world\n\n## Section 1\n\n- item 1\n- item 2' > test.md

# 测试 fix 命令
node dist/index.js fix test.md

# 测试 replace 命令
node dist/index.js replace "Hello" "Hi" test.md
```

> ✋ **费曼自测**：为什么 replace 命令需要 `--dry-run` 选项？在什么场景下这个选项特别重要？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] `npm run build` 编译成功
- [ ] fix 命令能修复格式问题
- [ ] stats 命令能输出统计信息
- [ ] replace 命令能批量替换文字

---

## 番茄钟5：测试开发（25分钟）

### 5.1 安装测试框架

```bash
npm install -D vitest
```

### 5.2 让 Codex 写测试

```bash
codex -a auto-edit "
在 src/__tests__/ 目录下创建测试文件：

1. format.test.ts - 测试 fixMarkdown()：
   - 多余的空白行被压缩
   - 标题前后添加空行
   - 列表缩进统一为 2 空格

2. stats.test.ts - 测试 analyzeMarkdown()：
   - 空的 Markdown 返回全零
   - 正确统计标题数
   - 正确统计链接数
   - 阅读时间估算正确

3. replace.test.ts - 测试 replaceInContent()：
   - 普通文字替换
   - 正则替换
   - 区分大小写/不区分大小写

4. file.test.ts - 测试文件操作：
   - findFiles 能匹配 glob 模式
   - 备份文件创建成功
"
```

### 5.3 运行测试

```bash
# 在 package.json 中添加 test 脚本
# "test": "vitest run"

npm test
```

### 5.4 用 Codex 修复失败的测试

```bash
codex -a auto-edit "运行 npm test，分析失败的测试，修复代码直到全部通过"
```

> ✋ **费曼自测**：Codex 写测试比自己写有什么优势和劣势？你觉得哪些测试需要自己把关？

---

## 番茄钟6：Bug 修复与完善（25分钟）

### 6.1 边界情况测试

```bash
codex -a auto-edit "
创建测试用边界情况文件并测试：

边界情况：
1. 空文件（0 字节）
2. 只有空格的'空'文件
3. 超大文件（故意造一个 1MB 的 Markdown）
4. 不存在的文件
5. 没有读权限的文件
6. 混合编码文件（UTF-8 + GBK）

确保所有边界情况有合理的错误处理
"
```

### 6.2 完善错误处理

```bash
codex -a auto-edit "
在 src/utils/errors.ts 中创建统一的错误处理：

- CodexError 类（继承 Error）
  - filePath?: string（出错的路径）
  - exitCode: number（进程退出码）

- 每个命令的顶层用 try/catch 包裹
- 错误信息清晰说明"哪里错了 + 可能的原因 + 建议修复"
- --verbose 模式下输出完整 stack trace
"
```

### 6.3 添加进度显示

```bash
codex -a auto-edit "
在批量处理多个文件时添加进度指示（不使用第三方库）：

- 处理多个文件时显示进度条
- 格式: [3/10] fix: README.md ✅
- --verbose 模式下显示详细处理信息
- 最终输出汇总：'处理完成: 10 个文件, 8 个已修改, 2 个跳过'
"
```

> ✋ **费曼自测**：为什么错误处理和边界情况很重要？列举 3 个"用户可能做但你没预料到"的操作。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 所有测试通过（`npm test`）
- [ ] 边界情况有正确处理
- [ ] 有统一的错误处理和友好的错误信息
- [ ] 批量处理有进度显示

---

## 番茄钟7：文档与发布准备（25分钟）

### 7.1 完善 README.md

```bash
codex -q "
为 md-tidy 项目创建一个完整的 README.md，包含：
- 项目简介（一句话说明）
- 安装方式（npm install -g）
- 所有命令和参数说明（表格形式）
- 使用示例（3-5 个典型用法）
- API 文档（作为库使用时）
- 贡献指南
- MIT License 声明
"
```

### 7.2 准备发布到 npm

```bash
# 更新 package.json
codex -a auto-edit "
更新 package.json，添加：
- bin: { 'md-tidy': './dist/index.js' }
- 文件头添加 #!/usr/bin/env node
- types: './dist/index.d.ts'
- files: ['dist/', 'README.md', 'LICENSE']
- keywords: ['markdown', 'cli', 'batch']
"
```

### 7.3 项目复盘：Codex 使用经验

**回顾今天用 Codex 做项目的经验：**

| 阶段 | Codex 表现 | 我的贡献 |
|:-----|:-----------|:---------|
| 规划 | 提供了技术选型建议 | 设计了目录结构和功能优先级 |
| 编码 | 快速生成代码骨架 | 指导具体实现方向 |
| 测试 | 生成基础测试用例 | 补充边界情况 |
| 调试 | 快速定位语法错误 | 判断逻辑是否正确 |
| 文档 | 生成整洁的 README | 确保文档覆盖所有功能 |

**最佳实践总结：**
1. **先设计，再编码**——让 Codex 理解架构比让它"自由发挥"效果好
2. **分步迭代**——每步完成后验证，避免大段 Debug
3. **清晰的 Prompt**——上下文 + 任务 + 验收标准
4. **测试先行**——让 Codex 写测试，你自己判断测试是否充分
5. **人类做决策，AI 做执行**——架构选型、功能优先级由人定

> ✋ **费曼自测**：今天用 Codex 做项目，你觉得节省了多少时间？在哪些环节 Codex 给你最大的惊喜？

---

## 番茄钟8：输出成果 + 复习作业（25分钟）

### 8.1 项目成果清单

```markdown
# md-tidy 项目成果

> 日期：2026-06-11

---

## 完成的功能

- [x] fix 命令：自动修复 Markdown 格式
- [x] stats 命令：文档统计分析
- [x] replace 命令：批量文字替换
- [x] --verbose 详细模式
- [x] --dry-run 预览模式
- [x] 边界情况处理
- [x] 进度显示
- [x] 统一错误处理

## 测试覆盖率

- [x] 单元测试：全部通过
- [x] 边界情况测试：5 种场景
- [x] 手动测试：3 个典型场景

## 发布准备

- [x] README.md 完成
- [x] package.json 配置完成
- [x] CLI 入口配置完成
```

### 8.2 今日复习作业

**作业 1：扩展现有项目**
选择以下至少一个扩展功能，用 Codex CLI 实现：
```markdown
选项 A：添加 table 命令
- 功能：读取 Markdown 中的表格，转为 CSV/JSON
- 提示：`md-tidy table README.md --format csv`

选项 B：添加 check 命令  
- 功能：检查 Markdown 中的死链（需要网络请求）
- 提示：`md-tidy check README.md --timeout 5`

选项 C：添加 init 命令
- 功能：生成 Markdown 项目模板
- 提示：`md-tidy init my-blog --template blog`
```

**作业 2：反思与总结**
回答以下问题：
```
1. 如果用 Cursor 做这个项目，体验会有什么不同？
2. 如果用 Claude Code 做这个项目，又有什么不同？
3. 你今天最满意的 Codex Prompt 是哪个？为什么？
4. 下次你会怎么改进与 Codex 的协作方式？
```

**作业 3：实用技巧积累**
记录今天用 Codex 学到的 3 个实用技巧：
```
1. ____
2. ____
3. ____
```

### 刻意练习——与 Codex 协作的 Prompt 工程

**练习目标**：掌握编写高质量 Prompt 的三个层次，能根据不同场景选择最佳 Prompt 策略

**任务序列（重复×3）：**

```
===== 循环 1：Prompt 质量对比 =====
1. 写一个"差的 Prompt"：只用一句话描述需求，让 Codex 生成代码
2. 写一个"中等 Prompt"：包含上下文 + 任务描述
3. 写一个"好的 Prompt"：包含上下文 + 具体任务 + 验收标准 + 输出格式
验证方式：对比三次输出结果的质量差异

===== 循环 2：审批模式对比 =====
1. 用 Suggest 模式让 Codex 完成一个功能模块的代码
2. 用 Auto Edit 模式完成同样的任务
3. 用 Full Auto 模式完成同样的任务
验证方式：对比三种模式下的控制感、安全感和效率

===== 循环 3：分步迭代开发 =====
1. 先让 Codex 生成项目结构（探索阶段）
2. 再让 Codex 生成核心功能的实现方案（规划阶段）
3. 最后让 Codex 逐步实现每个功能模块（执行阶段）
验证方式：每一步都验证输出结果，记录迭代轮次
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 写出结构化 Prompt | ⬜ | ⬜ | ⬜ |
| 掌握三种审批模式 | ⬜ | ⬜ | ⬜ |
| 分步迭代开发能力 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：Prompt 质量对 Codex 输出的影响有多大？"好的 Prompt"和"差的 Prompt"之间，代码质量的差距主要体现在哪些方面？

### 8.3 今日自检清单

- [ ] **番茄1-2**：完成了项目规划和 Codex 协作模式理解
- [ ] **番茄3-4**：核心命令（fix/stats/replace）开发完成
- [ ] **番茄5-6**：测试和 Bug 修复完成
- [ ] **番茄7-8**：文档完善，复盘总结

---

## 🎉 Day 4 完成！

**今日成果：**
- ✅ 从零到一完成了一个完整的 CLI 工具
- ✅ 掌握了与 Codex 分步协作的开发模式
- ✅ 理解了"人做决策，AI 做执行"的核心原则
- ✅ 产出了一个可用的 Markdown 批处理工具

**明天预告：** [[Day5-高级特性与工作流]] - SDK 集成 + 多 Agent 并行 + CI/CD

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day3-对比与选型]] - 工具选型参考
