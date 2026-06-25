---
created: 2026-06-22
updated: 2026-06-25
type: session-memory
domain: kb-architecture
layer: 3
---

# MEMORY — 大脑目录层（Layer 3）

> 三层记忆系统的路由中枢 | 每次启动读取 | 决定了"现在的我知道什么"

---

## 一、Vault 身份

| 属性 | 值 |
|------|-----|
| **名称** | Hermes & Obsidian — 个人知识宇宙 |
| **位置** | `J:/hermes&obsidian/tengxunyun/` |
| **架构** | 三层记忆系统（Layer 1 永久知识 / Layer 2 会话记忆 / Layer 3 大脑目录） |
| **知识领域** | 8 大领域（法律/创造性思维/学习方法/心理学/中医学/新科技与应用/写作/道医） |
| **总规模** | LLM-Wiki ~3,000+ 文件 · GBrain 38+ 实体 · SKILL 53+ · 跨域连接 21+ |
| **建造者** | AI 助手（Claude Code）+ 用户协作 |
| **核心方法论** | Dream Cycle（Dream→Plan→Execute→Review） |

---

## 二、Layer 1 目录地图（永久记忆）

### LLM-Wiki — 内容存储层（面向 RAG / AI 问答）

| 领域 | 路径 | 文件数 | schema |
|------|------|--------|--------|
| 中国法律书库 | `LLM-Wiki/中国法律书库/` | ~2,000+ | law |
| 中医书库 | `LLM-Wiki/中医书库/` | ~260 | tcm |
| 道医全集 | `LLM-Wiki/道医全集/` | 106 | tcm |
| 心理学书库 | `LLM-Wiki/心理学书库/` | ~250 | psychology |
| 创造性思维 | `LLM-Wiki/创造性思维/` | 16 | creativity |
| 学习方法 | `LLM-Wiki/学习方法/` | 18 | learning |
| 新科技与应用 | `LLM-Wiki/新科技与应用/` | 22 | tech |
| 写作 | `LLM-Wiki/写作/` | 13+300 | writing |

### GBrain — 知识图谱层（面向概念关联 / 可视化）

| 领域 | 实体数 | type 分布 |
|------|--------|-----------|
| 法律 | 5 | law |
| 创造性思维 | 5 | concept, method |
| 学习方法 | 5 | method |
| 心理学 | 5 | theory, therapy, concept |
| 中医学 | 5 | theory, practice |
| 新科技与应用 | 5 | concept, technology, methodology |
| 写作 | 5 | concept, technique, method |
| 知识库中心（KnowledgeHub） | 3 | dashboard, plan, navigation |

**入口**：[[GBrain/README.md]] | **全库导航**：[[GBrain/KnowledgeHub/全库导航.md]] | **数据面板**：[[GBrain/KnowledgeHub/知识统计.md]]

---

## 三、Layer 2 会话记忆（Claude_Memory）

**位置**：`Claude_Memory/`

Layer 2 是 AI 的"工作记忆"与"草稿本"——

| 规则 | 说明 |
|------|------|
| 当前会话的思路/决策/灵感 | 优先记录到 `Claude_Memory/`，文件名 `YYYY-MM-DD-<主题>.md` |
| 会话结束后 | 执行归档：将可迁移内容移至 Layer 1，使用 [[Claude_Memory/归档模板.md]] |
| 记忆清理 | 归档完成后删除会话临时文件 |

**参考**：[[Claude_Memory/README.md]] · [[Claude_Memory/归档模板.md]]

---

## 四、Layer 3 路由规则（即本文件）

本文件（MEMORY.md）在每次会话启动时被读取，是 AI 的"大脑目录"。其运作规则：

1. **身份优先**：读取本文件 → 确认 vault 身份和架构 → 确定当前所处上下文
2. **按需导航**：根据用户需求，从 Layer 1 目录地图定位相关领域 → 读取对应文件
3. **跨域连接**：遇到跨领域问题时，查阅 GBrain 跨域连接表 [[GBrain/README.md#跨域连接]]
4. **会话记忆**：如果存在当前日期的 `Claude_Memory/YYYY-MM-DD-*.md`，优先读取作为工作记忆
5. **知识生长**：新知识按 Dream Cycle（Dream→Plan→Execute→Review）循环生长
6. **向下兼容**：历史构建记录保留在附录中，供回溯和上下文补全

### 快速定位

```
用户提到 → 查 MEMORY Layer 1 地图 → 定位领域路径 → 读取对应文件
用户问跨域 → 查 GBrain 跨域连接 → 追踪 relations wikilink
用户说新领域 → 启动 Dream Cycle（Plan → Execute → Review）
```

---

## 五、操作规则

### ✅ 应当做的

| 操作 | 说明 |
|------|------|
| 优先使用 Layer 1 知识 | 回答问题时，先查 LLM-Wiki 对应领域文件 |
| 维护 GBrain 连接 | 创建新实体时填写 type/domain/relations/tags |
| 记录关键决策 | 将重要决策写入当前会话的 Claude_Memory |
| 跨域检索 | 复杂问题跨越 2+ 领域时，查阅关联实体 |
| 更新统计 | 知识库有显著变化后更新 [[GBrain/KnowledgeHub/知识统计.md]] |

### ❌ 不应做的

| 操作 | 理由 |
|------|------|
| 直接修改知识库源文件 | 除非用户明确要求 |
| 忽略跨域连接 | 损失知识图谱的核心价值 |
| 在 Layer 1 创建临时记录 | 临时记录应在 Claude_Memory 中 |
| 删除未归档的会话记忆 | 先归档，再清理 |

---

## 六、快速命令模板

```
# 创建新知识库
为 [领域] 创建知识库（LLM-Wiki + GBrain），参考现有 schema 模板

# 更新已有知识库
为 [领域] 更新知识库，补充 [具体内容]

# 查询跨域关联
[概念A] 和 [概念B] 之间有什么关系？查 GBrain relations

# 执行 Dream Cycle
启动一次 Dream Cycle：[描述新领域/新方向]

# 会话归档
当前会话结束，执行 Layer 2 → Layer 1 归档
```

---

## 附录 A：构建历史记录

### v1.0 — 五域知识库（2026-06-22）

从零搭建五域（法律/创造性思维/学习方法/心理学/中医学）知识库：

| 系统 | 核心产出 |
|------|----------|
| LLM-Wiki | 6 个知识库，~3,202 文件，批量 frontmatter 补全 |
| GBrain | 五域 25 实体，4 条跨域连接 |
| SKILL | kb-builder 技能封装 |
| 架构 | LLM-Wiki + GBrain 双系统并行决策 |

**架构决策要点**：
- LLM-Wiki 做主体存储 → GBrain 做知识索引
- 每个实体至少连接 2 个其他实体
- 每个领域至少建立 2 条跨域连接
- 6 种实体类型：law/theory/practice/method/concept/therapy

### v1.1 — 新科技与应用（2026-06-23）

基于 2026 夏季达沃斯《十大新兴技术》实时搜索：

| 系统 | 核心产出 |
|------|----------|
| LLM-Wiki | 14 篇技术专题 + 9 大 SKILL |
| GBrain | 5 实体（世界模型/量子计算/脑机接口/具身智能/AI for Science） |
| 跨域连接 | 7 条（→创造性思维/学习方法/心理学） |

### v1.2 — 写作知识库（2026-06-23）

从 `知识库/写作` 迁移并扩展：

| 系统 | 核心产出 |
|------|----------|
| LLM-Wiki | 7 子目录（故事创作/影视脚本/自媒体/文学鉴赏/思辨随笔/散文创作/修辞&描写） |
| 子目录 SKILL | 7 个 `.skill.md` 文件 |
| GBrain | 5 实体（故事理论/影视语言/修辞与描写/创意写作/文学批评） |
| 跨域连接 | 7 条（→创造性思维/学习方法/心理学） |

### v1.3 — 三层记忆系统 + KnowledgeHub（2026-06-25）

| 组件 | 核心产出 |
|------|----------|
| Layer 1 | 永久记忆层（LLM-Wiki + GBrain）定位确认 |
| Layer 2 | Claude_Memory/ 会话记忆层（README.md + 归档模板） |
| Layer 3 | MEMORY.md 重写为大脑目录路由层 |
| KnowledgeHub | 全库导航 + 知识统计 + Dream Cycle 梦境循环计划 |
| Dream Cycle | Dream→Plan→Execute→Review 知识进化循环 |

### v1.4 — 五法合一AI教程改写（2026-06-25）

| 维度 | 产出 |
|------|------|
| 任务 | 将「🍅120番茄从入门到精通AI」教程改写为融合五种学习方法的「120番茄费曼金字塔刻意练习精通AI」 |
| 核心方法 | 番茄工作法 + 费曼学习法 + 金字塔原理 + 刻意练习 + 系统思考 |
| 增强原则 | 刻意练习+系统思考→模块化专业技能；金字塔原理+设计思维→清晰结构；深度工作+创造力→心流状态；时间管理+番茄工作法→有纪律的自由空间 |
| 新文件 | [[120番茄费曼金字塔刻意练习精通AI]] |
| 洞见归档 | [[Claude_Memory/2026-06-25-五法合一的AI教程设计洞见.md]] |
| 技能封装 | [[五法合一教程设计.skill.md]]（可复用的教程设计技能） |
| GBrain参考 | 9个GBrain实体（学习方法域+创造性思维域）的知识融合 |

---

*本文件为 Layer 3 大脑目录层，每次会话启动时读取。构建历史记录保留在附录中以供回溯。*
