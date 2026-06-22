# Day 6：Skill 自动生成

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：理解并触发 Skill 自动生成，创建自定义技能
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Skill 自动生成原理
🍅 番茄3-4：触发自动生成
🍅 番茄5-6：创建自定义技能
🍅 番茄7-8：技能优化 + 复习输出
```

---

## 番茄钟1：理解自动生成原理（25分钟）

### 1.1 用大白话理解自动生成

**Skill 自动生成是什么？**

想象你经常做一道菜，每次都按相同的步骤：
1. 洗菜 → 2. 切菜 → 3. 炒菜 → 4. 装盘

有一天，你决定把这个流程**写下来**，变成一个"食谱"，以后只需要说"做那道菜"，就能自动执行整个流程。

**Skill 自动生成就是：**
- AI 发现你重复做某个复杂任务
- AI 自动把流程"写下来"，生成一个 Skill
- 下次只需要说"触发这个任务"，就能自动执行

### 1.2 自动生成的触发条件

```
复杂任务 → 复杂度评分 ≥ 阈值 → 触发自动生成
```

**复杂度评分维度：**

| 维度 | 权重 | 说明 |
|:-----|:-----|:-----|
| 步骤数 | 30% | 步骤越多越复杂 |
| 工具调用 | 25% | 调用的工具越多越复杂 |
| 决策点 | 25% | 需要做决策的次数 |
| 输出类型 | 20% | 输出的复杂程度 |

### 1.3 自动生成流程

```
┌─────────────────────────────────────────────────────────────┐
│                    Skill 自动生成流程                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 用户执行复杂任务                                         │
│     └── AI 记录所有步骤和决策                                │
│                                                             │
│  2. 任务完成后，AI 分析                                      │
│     ├── 复杂度评分                                          │
│     ├── 可复用性评估                                        │
│     └── 是否建议生成 Skill                                   │
│                                                             │
│  3. 用户确认生成                                             │
│     └── AI 生成 SKILL.md 文件                               │
│                                                             │
│  4. Skill 可用                                               │
│     └── 下次可通过触发词调用                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

> ✋ **费曼自测**：什么样的任务会被自动生成 Skill？举一个例子。

---

## 番茄钟2：自动生成的配置（25分钟）

### 2.1 启用自动生成

```yaml
# config.yaml
skills:
  enabled: true
  auto_generate: true          # 启用自动生成

  auto_generation:
    enabled: true
    min_complexity: 3          # 最小复杂度阈值（1-5）
    ask_confirmation: true     # 是否询问用户确认
    save_path: ~/.hermes/skills/auto-generated/
```

### 2.2 复杂度阈值说明

| 阈值 | 含义 | 适用场景 |
|:-----|:-----|:---------|
| 1 | 几乎所有任务 | 不推荐，会产生大量低价值 Skill |
| 2 | 简单任务 | 适合初学者 |
| 3 | 中等复杂任务 | **推荐**，平衡质量和数量 |
| 4 | 复杂任务 | 适合高级用户 |
| 5 | 非常复杂的任务 | 只生成最重要的 Skill |

### 2.3 自动生成的 Skill 命名规则

```
<任务关键词>-<日期>

示例：
- obsidian-note-processor-20260606
- web-content-summarizer-20260606
- data-cleaning-pipeline-20260606
```

> ✋ **费曼自测**：如果你想只对非常复杂的任务生成 Skill，应该把 `min_complexity` 设置为多少？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] Skill 自动生成是 AI 学习你的工作流程
- [ ] 复杂度评分决定是否触发
- [ ] 需要在 config.yaml 中启用

---

## 番茄钟3：触发自动生成（25分钟）

### 3.1 触发自动生成的任务示例

**任务：将网页内容整理成知识库笔记**

```
You: 帮我完成以下任务：
1. 抓取这篇文章的内容：https://example.com/article
2. 提取主要观点和关键信息
3. 翻译成中文
4. 按照 Obsidian 笔记格式整理
5. 添加合适的标签和链接

Hermes: 好的，让我一步步完成...

[执行步骤 1-5...]

任务完成！这是一个复杂任务，我建议将其保存为 Skill，方便以后复用。
是否生成 Skill？（y/n）

You: y

Hermes: 已生成 Skill：web-article-to-note
触发词：["抓取.*文章", "网页.*笔记", "整理.*网页"]
```

### 3.2 验证生成的 Skill

```bash
# 查看自动生成的技能
hermes skill list --type auto-generated

# 查看技能详情
hermes skill show web-article-to-note

# 查看技能文件
cat ~/.hermes/skills/auto-generated/web-article-to-note/SKILL.md
```

### 3.3 测试生成的 Skill

```
You: 帮我把这篇网页文章整理成笔记：https://example.com/new-article

Hermes: [触发 web-article-to-note 技能]
正在执行网页笔记整理流程...
[自动执行 5 个步骤]
完成！笔记已生成。
```

> ✋ **费曼自测**：执行一个复杂任务，观察 AI 是否建议生成 Skill。

---

## 番茄钟4：分析生成的 Skill（25分钟）

### 4.1 生成的 SKILL.md 结构

```markdown
---
name: web-article-to-note-20260606
description: 将网页内容整理成知识库笔记
triggers:
  - "抓取.*文章"
  - "网页.*笔记"
  - "整理.*网页"
auto_generated: true
created_at: 2026-06-06
complexity: 4
---

# 网页文章转笔记

## 功能
将任意网页内容转化为结构化的 Obsidian 笔记。

## 工作流程

### 步骤 1：抓取网页内容
- 使用 web-scraper 技能
- 提取正文内容

### 步骤 2：提取关键信息
- 识别标题、作者、日期
- 提取主要观点
- 识别关键词

### 步骤 3：翻译
- 检测源语言
- 翻译成中文

### 步骤 4：整理格式
- 使用 Obsidian Markdown 格式
- 添加 YAML frontmatter
- 添加标签

### 步骤 5：输出
- 生成笔记文件
- 添加到指定目录

## 输入参数
- url: 网页链接
- output_dir: 输出目录（可选，默认 Clippings/）

## 输出
- 结构化的 Obsidian 笔记文件
```

### 4.2 自动生成 vs 手动创建

| 对比项 | 自动生成 | 手动创建 |
|:-------|:---------|:---------|
| 效率 | 高 | 低 |
| 精确度 | 中 | 高 |
| 灵活性 | 中 | 高 |
| 适用场景 | 常规任务 | 定制需求 |

### 4.3 优化生成的 Skill

```bash
# 编辑生成的 Skill
nano ~/.hermes/skills/auto-generated/web-article-to-note/SKILL.md

# 可以优化：
# - 添加更多触发词
# - 调整工作流程
# - 添加错误处理
# - 添加权限设置
```

> ✋ **费曼自测**：查看生成的 SKILL.md 文件，分析其结构和内容。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 成功触发 Skill 自动生成
- [ ] 查看了生成的 SKILL.md 文件
- [ ] 测试了生成的 Skill

---

## 番茄钟5：创建自定义技能（25分钟）

### 5.1 手动创建 Skill 的场景

| 场景 | 说明 |
|:-----|:-----|
| 定制需求 | 自动生成无法满足的特殊需求 |
| 精确控制 | 需要精确控制每个步骤 |
| 复杂逻辑 | 包含复杂的条件判断 |
| 集成外部系统 | 需要连接特定的 API 或工具 |

### 5.2 创建自定义 Skill 步骤

**步骤一：创建 Skill 目录**

```bash
mkdir -p ~/.hermes/skills/custom/knowledge-compiler
```

**步骤二：创建 SKILL.md**

```markdown
---
name: knowledge-compiler
description: 将剪藏内容编译成结构化知识笔记
triggers:
  - "编译.*知识"
  - "处理.*剪藏"
  - "知识.*编译"
---

# 知识编译器

## 功能
将 Clippings/ 目录下的剪藏内容编译成结构化的知识笔记。

## 工作流程

### 1. 扫描剪藏目录
- 读取 Clippings/ 下所有 .md 文件
- 提取文件元信息

### 2. 分析内容类型
- 文章类型识别
- 主题分类
- 关键词提取

### 3. 编译处理
- 提取核心观点
- 生成摘要
- 建立知识链接

### 4. 输出结果
- 存入对应的知识库目录
- 更新索引文件

## 输入参数
- input_dir: 输入目录（默认 Clippings/）
- output_dir: 输出目录（默认 Reading/）

## 权限
- read: Clippings/, Reading/
- write: Reading/, Claude_Memory/
```

**步骤三：注册 Skill**

```bash
# 注册自定义技能
hermes skill register knowledge-compiler

# 验证技能
hermes skill validate knowledge-compiler
```

> ✋ **费曼自测**：创建一个适合你日常工作的自定义 Skill。

---

## 番茄钟6：技能模板库（25分钟）

### 6.1 常用技能模板

**模板一：内容处理**

```yaml
name: content-processor
description: 通用内容处理模板
triggers:
  - "处理.*内容"

workflow:
  - step: input
    action: 读取输入内容
  - step: analyze
    action: 分析内容结构
  - step: transform
    action: 转换格式
  - step: output
    action: 输出结果
```

**模板二：数据分析**

```yaml
name: data-pipeline
description: 数据分析流水线模板
triggers:
  - "分析.*数据"

workflow:
  - step: load
    action: 加载数据源
  - step: clean
    action: 数据清洗
  - step: analyze
    action: 统计分析
  - step: visualize
    action: 生成可视化
  - step: report
    action: 生成报告
```

**模板三：工作流自动化**

```yaml
name: workflow-automation
description: 工作流自动化模板
triggers:
  - "自动化.*流程"

workflow:
  - step: trigger
    action: 检测触发条件
  - step: execute
    action: 执行任务序列
  - step: notify
    action: 发送通知
  - step: log
    action: 记录日志
```

### 6.2 从模板创建 Skill

```bash
# 从模板创建
hermes skill create --from-template content-processor my-processor

# 编辑生成的 Skill
nano ~/.hermes/skills/custom/my-processor/SKILL.md

# 注册
hermes skill register my-processor
```

> ✋ **费曼自测**：选择一个模板，创建适合你需求的自定义 Skill。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 创建了自定义 Skill
- [ ] 从模板创建了 Skill
- [ ] 注册并测试了 Skill

---

## 番茄钟7：技能优化与调试（25分钟）

### 7.1 技能调试命令

```bash
# 调试技能执行
hermes skill run <name> --debug

# 查看技能日志
hermes skill logs <name>

# 测试技能匹配
hermes skill test --input "帮我整理这些剪藏"
```

### 7.2 常见问题与解决

| 问题 | 原因 | 解决方案 |
|:-----|:-----|:---------|
| 技能不触发 | 触发词不匹配 | 添加更多触发词 |
| 执行失败 | 权限不足 | 配置 permissions |
| 输出错误 | 工作流逻辑问题 | 检查并修复 workflow |
| 性能慢 | 步骤过多 | 优化工作流程 |

### 7.3 技能优化技巧

```markdown
# 优化触发词
triggers:
  - "编译.*知识"      # 原有
  - "处理.*剪藏"      # 添加
  - "知识.*编译"      # 添加
  - "整理.*收藏"      # 添加同义词

# 添加错误处理
error_handling:
  retry: 3
  fallback: "请手动处理"
  log_errors: true

# 添加性能优化
performance:
  cache_results: true
  parallel_steps: [step2, step3]
```

### 7.4 技能版本管理

```bash
# 查看技能版本
hermes skill version <name>

# 更新技能
hermes skill update <name>

# 回滚到旧版本
hermes skill rollback <name> --version 1.0.0
```

> ✋ **费曼自测**：调试一个有问题的 Skill，找出问题并修复。

---

## 番茄钟8：输出成果（25分钟）

### 8.1 刻意练习——Skill自动生成

**练习目标**：在25分钟内完成"自动生成→测试→迭代"的3轮Skill优化循环

**任务序列（重复×3）：**

```
===== 循环 1：入门任务 =====
1. 用3种不同的描述方式让 Hermes 执行一个复杂任务并触发自动生成
2. 方式一：详细描述每个步骤（5步以上）
3. 方式二：只描述目标，让 AI 自行拆解
4. 方式三：混合使用指令+目标描述
验证方式：3种方式均成功生成 Skill，对比生成的 SKILL.md 结构差异

===== 循环 2：进阶任务 =====
1. 测试自动生成的 Skill 在真实场景中的效果
2. 用完全不同的输入来运行同一个 Skill
3. 评估 Skill 的泛化能力和鲁棒性
验证方式：找出 Skill 的至少1个不足或可优化点

===== 循环 3：挑战任务 =====
1. 基于测试反馈对生成的 Skill 进行迭代优化
2. 修改 SKILL.md：添加触发词、优化工作流、增加错误处理
3. 重新注册并测试优化后的 Skill
验证方式：优化后的 Skill 比原始版本表现更好或覆盖更多场景
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 触发自动生成 | ⬜ | ⬜ | ⬜ |
| 生成 Skill 测试 | ⬜ | ⬜ | ⬜ |
| SKILL.md 分析与优化 | ⬜ | ⬜ | ⬜ |
| 迭代改进 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：自动生成的 Skill 和手动创建的 SKILL.md 在结构和质量上有什么差异？

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 Skill 自动生成原理和配置
- [ ] **番茄3-4**：成功触发自动生成并测试
- [ ] **番茄5-6**：创建了自定义 Skill
- [ ] **番茄7-8**：优化并调试了 Skill

### 8.3 已创建技能清单

| 技能名 | 类型 | 功能 |
|:-------|:-----|:-----|
| web-article-to-note | 自动生成 | 网页转笔记 |
| knowledge-compiler | 自定义 | 剪藏编译 |
| my-processor | 模板创建 | 内容处理 |

### 8.4 学习笔记模板

```markdown
# Hermes Agent 学习笔记 - Day 6

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
掌握了 Skill 自动生成和自定义创建，可以扩展 AI 能力。

## 关键要点

### 1. 自动生成原理
- 复杂度评分 ≥ 阈值触发
- AI 自动记录流程
- 生成 SKILL.md 文件

### 2. 自定义创建
- 创建目录和 SKILL.md
- 定义触发词和工作流
- 注册并测试

### 3. 技能优化
- 添加更多触发词
- 配置错误处理
- 性能优化

## 明日计划
- Week 1 复习
- 综合实战项目
```

---

## 🎉 Day 6 完成！

**今日成果：**
- ✅ 理解 Skill 自动生成机制
- ✅ 触发并测试自动生成
- ✅ 创建自定义 Skill
- ✅ 掌握技能调试优化

**明天预告：** [[Day7-复习与综合实战]] - Week 1 复习和知识自动化流水线

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day5-Skill安装与使用]] - 上一天内容
