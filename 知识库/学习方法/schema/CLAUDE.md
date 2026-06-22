# Learning KB -- LLM Wiki Workflow

## Topic Config
- Topic: 学习方法
- Vault path: 知识库/学习方法
- Skills: 6 core skills (时间管理, 刻意练习, 深度工作, 清单系统, 高维思考, 金字塔原理)
- Books: 15 (创造时间、刻意学习、极简时间、番茄工作法、精英都是细节控、聪明人是如何思考的、金字塔原理大全集、高效工作法4册套装、高效清单工作法、高维度思考法、费曼经典、10倍速影像阅读法、决胜右脑、学习的学问、快速阅读)

## Conventions
- All internal links use [[wikilinks]]
- YAML frontmatter: type: learning, category, skill_tag, level
- Index files in .书库索引/ are auto-maintained
- Book notes retain original metadata (Title, Authors, Publisher, Date) as inline fields
- When querying, match skill_tag to trigger corresponding SKILL module
- Level tags: 入门 / 进阶 / 综合

## Retrieval Rules
1. 目录路由检索 — 按 `知识库/学习方法/` 锁定学习领域
2. 标签技能检索 — 通过 `skill_tag` 触发 6 大 SKILL
3. 语义全文检索 — 跨 15 本书整合知识点
4. 层级区分检索 — 按 `level` 区分入门/进阶内容输出
