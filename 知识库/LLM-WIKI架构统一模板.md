# LLM-WIKI 知识库统一架构模板

> 适用于法律、创造性思维、学习方法、心理学、中医学五域知识库
> 基于 Obsidian LLM-WIKI 插件 v0.1.0 + Karpathy 读写闭环理念

---

## 一、核心架构

每个 LLM-WIKI 知识库包含以下层级：

```
{domain}知识库/
├── .书库索引/              # 元数据与导航
│   ├── README.md          # 索引中心
│   ├── 书籍元数据索引.md    # 书籍清单
│   ├── 技能模块索引.md      # SKILL技能定义
│   ├── 增量更新流程.md      # 维护指南
│   └── 提示词模板库.md      # LLM提示词
├── schema/                 # LLM-WIKI 配置
│   ├── CLAUDE.md           # 工作流约定
│   └── kb.yaml             # 知识库元数据
├── raw/                    # 原始素材（可选）
│   ├── articles/
│   ├── papers/
│   ├── notes/
│   └── transcripts/
├── wiki/                   # 编译知识（可选）
│   ├── summaries/
│   ├── concepts/
│   └── queries/
├── Log.md                  # 操作日志
└── ...（现有书籍文件）
```

## 二、统一 YAML Frontmatter 标准

```yaml
---
title: 文件名
category: 领域分类
skill_tag: 技能标签1,技能标签2
level: 入门/进阶/专业
keywords: 关键词1,关键词2,关键词3
type: 领域类型（law/creativity/learning/psychology/tcm）
---
```

## 三、SKILL 技能模块标准定义格式

```markdown
### Skill{N}: 技能名称
**触发指令**：指令1、指令2
**关联目录**：对应文件夹
**核心能力**：
| 能力 | 说明 |
|------|------|
| 能力1 | 说明1 |
**输出内容**：xxx
```

## 四、检索匹配规则

| 类型 | 说明 |
|------|------|
| 目录路由检索 | 按文件夹大类锁定领域 |
| 标签技能检索 | 通过 skill_tag 触发 SKILL |
| 语义全文检索 | 跨笔记整合知识点 |
| 层级权限检索 | 按 level 区分入门/专业输出 |

## 五、通用提示词模板

### 通用知识库检索
```
仅依据 Obsidian LLM-WIKI 内 {领域} MD 笔记内容作答。
1. 识别问题匹配对应 skill_tag 与文件夹分类
2. 不编造库外理论内容
3. 复杂内容分层梳理，实操类给出清晰步骤
4. 关键内容标注对应笔记名称，支持溯源
```

### 领域分析提示词
```
启用 {领域} SKILL，调取 LLM-WIKI 对应目录笔记。
依据库内知识进行专业分析，结合多源笔记综合判断。
```
