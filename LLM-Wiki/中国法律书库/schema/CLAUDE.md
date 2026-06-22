# Legal KB -- LLM Wiki Workflow

## Topic Config

- Topic: 中国法律书库
- Vault path: LLM-Wiki/中国法律书库
- Skills: 9 core skills (法律条文查询, 案例检索, 案例分析, 案件研判, 合规审查, 法律文书生成, 法律问答, 法律经济学分析, 犯罪心理分析)
- Total files: 2502 (法律法规2416部 + 法律书籍63本 + 年度案例23册)
- LLM Wiki plan: [[LLM-Wiki/中国法律书库/Obsidian-LLMWIKI法律知识库AI应用方案.md]]

## Conventions

- All internal links use [[wikilinks]]
- YAML frontmatter:
  - type: law
  - category: 中国法律/行政法规/司法解释/法律学习书籍/年度案例
  - skill_tag: 法律条文查询,案例检索,案例分析,案件研判,合规审查,法律文书生成,法律问答,法律经济学分析,犯罪心理分析
  - level: 入门/进阶/专业
  - keywords: 核心关键词
- Index files in `.书库索引/` are auto-maintained
- 法律条文类文件命名格式: `{法律名称}_{版本日期}`
- Metadata index: [[LLM-Wiki/中国法律书库/.书库索引/书籍元数据索引.md]]
- Skill index: [[LLM-Wiki/中国法律书库/.书库索引/技能模块索引.md]]

## Directory Structure

```
LLM-Wiki/中国法律书库/
├── .书库索引/            # 索引文件（自动维护）
│   ├── README.md         # 索引中心
│   ├── 书籍元数据索引.md  # 完整元数据
│   ├── 技能模块索引.md    # 9大SKILL索引
│   └── skills/           # 技能详细文档
├── schema/               # LLM Wiki 配置
│   ├── CLAUDE.md          # 工作流配置
│   └── kb.yaml            # 知识库元数据
├── 中国法律/              # 719部法律
├── 行政法规/              # 819部行政法规
├── 司法解释/              # 877部司法解释
├── 法律相关/              # 63本法律学习书籍
├── 2025年度案例/          # 23册年度案例
├── Log.md                # 操作日志
├── Obsidian-LLMWIKI法律知识库AI应用方案.md  # LLM Wiki 方案
└── 本地法律法规资料库AI智能查询与应用完整解决方案.md  # AI方案文档
```

## Retrieval Rules

| Type | Strategy |
|------|----------|
| 目录路由检索 | 按5个分类文件夹锁定领域（中国法律/行政法规/司法解释/法律相关/年度案例） |
| 标签技能检索 | 通过 skill_tag 触发对应 9 大 SKILL |
| 语义全文检索 | 跨笔记整合法律条文、案例、知识 |
| 层级权限检索 | 按 level 区分入门/进阶/专业内容输出 |

## Skill Tag Mapping

| Skill | 触发指令 | skill_tag |
|-------|----------|-----------|
| Skill1 | 法律条文查询, 法条检索, 法律依据查找 | 法律条文查询 |
| Skill2 | 案例检索, 查找案例, 相似案例查询 | 案例检索 |
| Skill3 | 案例分析, 案例拆解, 案例比对 | 案例分析 |
| Skill4 | 案件研判, 判案辅助, 法律适用分析 | 案件研判 |
| Skill5 | 合规审查, 风险识别, 合同审查 | 合规审查 |
| Skill6 | 法律文书生成, 起诉状生成, 法律意见书 | 法律文书生成 |
| Skill7 | 法律问答, 法律咨询, 普法咨询 | 法律问答 |
| Skill8 | 法律经济学分析, 成本收益分析, 制度效率评估 | 法律经济学分析 |
| Skill9 | 犯罪心理分析, 犯罪侧写, 动机分析 | 犯罪心理分析 |

## Maintenance

- 新增法律文件归入对应分类目录
- 文件命名遵循 `{法律名称}_{版本日期}` 格式
- 定期刷新索引缓存
- 保持 YAML frontmatter 完整性
- 法律法规时效性需定期核查（有效/废止/修订状态标注）
