# 心理学书库 -- LLM Wiki Workflow

## Topic Config

- Topic: 心理学书库
- Vault path: LLM-Wiki/心理学书库
- Skills: 8 core skills (基础理论检索, 临床症状诊断, 心理咨询会谈, 心理疗法实操, 情绪压力疏导, 危机干预处置, 人际婚恋家庭指导, 人格特质分析)
- Books: 123+
- LLM Wiki plan: [[LLM-Wiki/心理学书库/Obsidian-LLMWIKI心理学库开发方案.md]]

## Conventions

- All internal links use [[wikilinks]]
- YAML frontmatter:
  - type: psychology
  - category: 基础理论/临床诊断/心理咨询/危机干预
  - skill_tag: 心理评估,共情沟通,症状诊断,情绪疏导
  - level: 入门|进阶|临床专业
- Index files in `.书库索引/` are auto-maintained
- Metadata index: [[LLM-Wiki/心理学书库/.书库索引/书籍元数据索引.md]]
- Skill index: [[LLM-Wiki/心理学书库/.书库索引/技能模块索引.md]]

## Retrieval Rules

| Type | Strategy |
|------|----------|
| 目录路由检索 | 按12个分类文件夹锁定领域 |
| 标签技能检索 | 通过 skill_tag 触发对应 SKILL |
| 语义全文检索 | 跨笔记整合心理学知识点 |
| 层级权限检索 | 按 level 区分科普/专业内容输出 |

## Maintenance

- 新增笔记归入对应分类目录
- 定期刷新索引缓存
- 保持 YAML frontmatter 完整性
