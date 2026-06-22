# LLM-WIKI 五域知识库全局索引

> 统一法律、创造性思维、学习方法、心理学、中医学五大知识库的 LLM-WIKI 架构
> 创建日期：2026-06-22
> 适配环境：Obsidian + LLM-WIKI 插件 v0.1.0

---

## 一、五域总览

| # | 知识库 | type | 存量 | SKILLs | LLM Wiki方案 | schema |
|---|--------|------|------|--------|-------------|--------|
| 1 | [[LLM-Wiki/中国法律书库]] | law | 2502部 | 9 | [[LLM-Wiki/中国法律书库/Obsidian-LLMWIKI法律知识库AI应用方案\|✅ 已创建]] | ✅ |
| 2 | [[LLM-Wiki/创造性思维]] | creativity | 16本 | 6 | [[LLM-Wiki/创造性思维/Obsidian-LLMWIKI创造性思维库AI开发方案\|✅ 已创建]] | ✅ |
| 3 | [[LLM-Wiki/学习方法]] | learning | 15本 | 6 | [[LLM-Wiki/学习方法/Obsidian-LLMWIKI学习方法库AI应用方案\|✅ 已创建]] | ✅ |
| 4 | [[LLM-Wiki/心理学书库]] | psychology | 123本 | 8 | ✅ 已有V1.1 | ✅ |
| 5 | [[LLM-Wiki/中医书库]] | tcm | 大量 | 8 | ✅ 已有V1.0 | ✅ |

---

## 二、统一架构规范

### 2.1 标准目录结构

```
知识库/{domain}/
├── .书库索引/           # 元数据与导航
│   ├── README.md       # 索引中心
│   ├── 书籍元数据索引.md # 书籍元数据
│   ├── 技能模块索引.md   # SKILL技能定义
│   └── ...             # 其他管理文件
├── schema/             # LLM-WIKI 配置
│   ├── CLAUDE.md       # 工作流约定
│   └── kb.yaml         # 知识库元数据
├── Log.md              # 操作日志
├── Obsidian-LLMWIKI{domain}库AI应用方案.md  # LLM-WIKI方案文档
└── ...书籍文件
```

### 2.2 统一 YAML Frontmatter

```yaml
---
title: 文件名称
category: 所属分类
skill_tag: 关联技能标签
level: 入门/进阶/专业
keywords: 关键词1,关键词2
type: law|creativity|learning|psychology|tcm
---
```

### 2.3 五域 type 标识

| 领域 | type 值 | 说明 |
|------|---------|------|
| 法律 | `law` | 法律法规、案例、法律书籍 |
| 创造性思维 | `creativity` | 创新方法、AI算法、认知科学 |
| 学习方法 | `learning` | 时间管理、学习技巧、思维模式 |
| 心理学 | `psychology` | 基础理论、临床诊断、咨询技术 |
| 中医学 | `tcm` | 中医基础、辨证论治、方药经络 |

---

## 三、检索路由规则

LLM-WIKI 检索时按以下优先级路由：

```
用户查询
  │
  ├─ 法律相关 (type:law) → 中国法律书库
  │   ├─ 法条查询 → Skill1
  │   ├─ 案例检索 → Skill2
  │   ├─ 案件研判 → Skill4
  │   └─ ...
  │
  ├─ 创新/算法相关 (type:creativity) → 创造性思维
  │   ├─ 创新方法 → Skill1
  │   ├─ AI算法 → Skill3
  │   └─ ...
  │
  ├─ 学习方法 (type:learning) → 学习方法
  │   ├─ 时间管理 → Skill1
  │   ├─ 刻意练习 → Skill2
  │   └─ ...
  │
  ├─ 心理相关 (type:psychology) → 心理学书库
  │   ├─ 理论检索 → Skill1
  │   ├─ 症状诊断 → Skill2
  │   └─ ...
  │
  └─ 中医相关 (type:tcm) → 中医书库
      ├─ 辨证诊断 → Skill2
      ├─ 方药查询 → Skill4
      └─ ...
```

---

## 四、LLM-WIKI 插件MCP配置

LLM-WIKI 插件提供了 MCP 服务（默认端口 48765），AI Agent（如 Claude Code, Cursor）可通过以下配置连接：

```json
{
  "mcpServers": {
    "llm-wiki": {
      "command": "node",
      "args": ["<path-to>/connector.js", "J:/hermes&obsidian/tengxunyun"]
    }
  }
}
```

连接后可通过 MCP 方法操作知识库：
- `vault.read` / `vault.modify` / `vault.create` — 读写笔记
- `vault.search` — 全文检索
- `vault.searchByTag` / `vault.searchByFrontmatter` — 元数据检索
- `vault.graph` / `vault.backlinks` — 知识图谱
- `vault.lint` — 知识库健康检查

---

## 五、相关链接

### 核心技能
- [[MEMORY.md|知识库构建全记录]]
- [[.claude/skills/kb-builder/SKILL.md|kb-builder — 知识库构建技能]]

### 法律
- [[LLM-Wiki/中国法律书库/.书库索引/README|法律书库索引中心]]
- [[LLM-Wiki/中国法律书库/Obsidian-LLMWIKI法律知识库AI应用方案|法律LLM-WIKI方案]]

### 创造性思维
- [[LLM-Wiki/创造性思维/.书库索引/README|创造性思维书库索引]]
- [[LLM-Wiki/创造性思维/Obsidian-LLMWIKI创造性思维库AI开发方案|创造性思维LLM-WIKI方案]]

### 学习方法
- [[LLM-Wiki/学习方法/.书库索引/README|学习方法书库索引]]
- [[LLM-Wiki/学习方法/Obsidian-LLMWIKI学习方法库AI应用方案|学习方法LLM-WIKI方案]]

### 心理学
- [[LLM-Wiki/心理学书库/.书库索引/README|心理学书库索引]]
- [[LLM-Wiki/心理学书库/Obsidian-LLMWIKI心理学库开发方案|心理学LLM-WIKI方案]]

### 中医学
- [[LLM-Wiki/中医书库/.书库索引/README|中医书库索引]]
- [[LLM-Wiki/中医书库/Obsidian-LLMWIKI中医知识库AI应用方案|中医LLM-WIKI方案]]

---

## 六、更新日志

| 日期 | 更新内容 |
|------|----------|
| 2026-06-22 | 创建 LLM-WIKI 五域知识库全局索引 |
| 2026-06-22 | 统一五域 schema/CLAUDE.md + kb.yaml 配置 |
| 2026-06-22 | 新增法律、创造性思维、学习方法三域 LLM-WIKI 方案 |
| 2026-06-22 | 更新心理学、中医已有 LLM-WIKI 方案为统一格式 |
| 2026-06-22 | 创建 kb-builder SKILL + MEMORY.md 知识库构建全记录 |
