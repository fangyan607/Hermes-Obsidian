# 新科技与应用 -- KB Workflow

## Topic Config
- Topic: 新科技与应用
- Vault path: LLM-Wiki/新科技与应用
- Skills: 9 core skills
- Type: tech

## Conventions
- All internal links use [[wikilinks]]
- YAML frontmatter: type: tech, category, skill_tag, level
- Index files in .书库索引/ are auto-maintained
- Content covers latest breakthroughs in AI, quantum computing, BCI, robotics, and emerging technologies

## File Structure
```
LLM-Wiki/新科技与应用/
├── .书库索引/
│   ├── README.md              # 书库索引中心
│   ├── 书籍元数据索引.md       # 内容元数据
│   └── 技能模块索引.md          # 9大SKILL技能
├── schema/
│   ├── CLAUDE.md              # 工作流约定
│   └── kb.yaml                # 知识库元数据
├── Log.md                     # 操作日志
└── ...（技术专题文件）
```

## Skills Overview
| Skill | Name | Trigger |
|-------|------|---------|
| Skill1 | 世界模型与物理AI | 世界模型、物理AI、具身智能、空间智能 |
| Skill2 | 量子计算 | 量子计算、量子芯片、量子AI、拓扑量子 |
| Skill3 | 脑机接口 | 脑机接口、BCI、神经接口、脑芯片 |
| Skill4 | 人形机器人 | 人形机器人、具身机器人、双足机器人、仿生 |
| Skill5 | AI架构创新 | AI架构、扩散模型、MoE、基础模型 |
| Skill6 | AI for Science | AI for Science、AI4S、科研自动化、药物发现 |
| Skill7 | 能源与新材料 | 清洁能源、电网技术、冷却材料、提锂 |
| Skill8 | 生物医药科技 | mRNA疫苗、外泌体、精密发酵、个性化医疗 |
| Skill9 | 网络与密码安全 | 格密码学、后量子密码、AI安全 |

## YAML Frontmatter Template
```yaml
---
title: 专题名称
category: 世界模型/量子计算/脑机接口/人形机器人/AI架构/AI for Science/能源材料/生物医药/密码安全
skill_tag: Skill1,Skill2,Skill3,Skill4,Skill5,Skill6,Skill7,Skill8,Skill9
level: 入门/进阶/前沿
keywords: 关键词1,关键词2,关键词3
type: tech
---
```
