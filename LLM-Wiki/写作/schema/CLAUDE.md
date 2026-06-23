# 写作知识库 -- KB Workflow

## Topic Config
- Topic: 写作知识库
- Vault path: LLM-Wiki/写作
- Skills: 7 core skills (故事创作, 影视脚本, 自媒体创作, 文学鉴赏, 思辨随笔, 散文创作, 写作修辞&描写)
- Type: writing

## Conventions
- All internal links use [[wikilinks]]
- YAML frontmatter: type: writing, category, skill_tag, level
- Index files in .书库索引/ are auto-maintained
- Books: covering 7 writing domains — story creation, screenwriting, self-media, literary appreciation, critical thinking, prose, rhetoric & description

## File Structure
```
LLM-Wiki/写作/
├── .书库索引/
│   ├── README.md              # 书库索引中心
│   ├── 书籍元数据索引.md       # 图书/内容元数据（七域汇总）
│   └── 技能模块索引.md          # 7大SKILL技能
├── schema/
│   ├── CLAUDE.md              # 工作流约定
│   └── kb.yaml                # 知识库元数据
├── Log.md                     # 操作日志
├── 故事创作/                   # 132+文件
├── 影视脚本/                   # 80+文件（含skill版）
├── 自媒体创作/                 # 11个文件
├── 文学鉴赏/                   # 23个文件
├── 思辨随笔/                   # 7个文件
├── 散文创作/                   # 3个文件
└── 写作修辞&描写/              # 42个文件
```

## Skills Overview
| Skill | Name | Trigger |
|-------|------|---------|
| Skill1 | 故事创作 | 故事结构、人物塑造、情节设计、英雄之旅、类型小说、叙事技巧 |
| Skill2 | 影视脚本 | 电影剧本、银幕剧作、镜头语言、剪辑、导演、表演、电影分析 |
| Skill3 | 自媒体创作 | 自媒体写作、新媒体文案、短视频脚本、营销文案、爆款方法 |
| Skill4 | 文学鉴赏 | 诗词鉴赏、散文赏析、古典文学、文学批评、审美分析 |
| Skill5 | 思辨随笔 | 批判性思维、逻辑论证、议论文写作、随笔、思辨方法 |
| Skill6 | 散文创作 | 非虚构写作、散文技法、个人叙事、文章基础 |
| Skill7 | 写作修辞&描写 | 修辞学、描写技法、语法、病句修改、辞格、汉语表达 |

## YAML Frontmatter Template
```yaml
---
title: 书籍/专题名称
category: 故事创作/影视脚本/自媒体创作/文学鉴赏/思辨随笔/散文创作/写作修辞&描写
skill_tag: Skill1,Skill2,Skill3,Skill4,Skill5,Skill6,Skill7
level: 入门/进阶/专业
keywords: 关键词1,关键词2,关键词3
type: writing
---
```
