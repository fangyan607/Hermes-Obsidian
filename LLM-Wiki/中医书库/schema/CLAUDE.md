# 中医书库 -- LLM Wiki Workflow

## Topic Config

- Topic: 中医书库
- Vault path: LLM-Wiki/中医书库
- Skills: 8 core skills (中医基础理论, 四诊辨证诊断, 中药材查询, 经典方剂配伍, 经络穴位实操, 九种体质辨识, 各科常见病症, 食疗药膳康养)
- Books: 大量（含道医全集）
- LLM Wiki plan: [[LLM-Wiki/中医书库/Obsidian-LLMWIKI中医知识库AI应用方案.md]]

## Conventions

- All internal links use [[wikilinks]]
- YAML frontmatter:
  - type: tcm
  - category: 中医基础/辨证论治/中药方剂/经络针灸/体质养生/内科杂病/骨伤妇科
  - skill_tag: 辨证诊断,方药查询,体质调理,经络取穴,食疗康养
  - level: 入门/进阶/临床实操
- Index files in `.书库索引/` are auto-maintained
- Metadata index: [[LLM-Wiki/中医书库/.书库索引/书籍元数据索引.md]]
- Skill index: [[LLM-Wiki/中医书库/.书库索引/技能模块索引.md]]

## Retrieval Rules

| Type | Strategy |
|------|----------|
| 目录定向检索 | 按病症、方药、经络类目锁定笔记 |
| 标签技能检索 | 识别 skill_tag 自动匹配诊疗能力模块 |
| 语义智能检索 | 理解症状描述，跨笔记辨证 |
| 层级检索区分 | 按 level 区分科普养生与临床辨证输出 |

## Maintenance

- 新增中医资料归入对应目录
- 定期刷新向量缓存
- 保持 YAML frontmatter 完整性
- 典型病案单独归档
