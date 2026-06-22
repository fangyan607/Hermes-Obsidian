# Day 2：目录结构与配置文件

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 ~/.hermes/ 目录结构和配置文件
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 ~/.hermes/ 目录结构
🍅 番茄3-4：掌握 config.yaml 配置
🍅 番茄5-6：掌握 .env 和其他配置文件
🍅 番茄7-8：配置实践 + 复习输出
```

---

## 番茄钟1：目录结构概览（25分钟）

### 1.1 用大白话理解目录结构

**~/.hermes/ 是什么？**

想象你在装修一套房子，每个房间有特定功能：

| 房间 | 文件/目录 | 功能 |
|:-----|:----------|:-----|
| **客厅** | config.yaml | 主配置，控制整体行为 |
| **保险柜** | .env | 存放密码（API Key等） |
| **书房** | MEMORY.md | 长期记忆库 |
| **卧室** | USER.md | 用户画像，你的偏好 |
| **衣帽间** | SOUL.yaml | AI人格设定 |
| **工具间** | skills/ | 技能库存放 |
| **分身房** | profiles/ | 多实例配置 |
| **储藏室** | cache/ | 临时缓存 |

### 1.2 完整目录结构

```
~/.hermes/
├── config.yaml          # 主配置文件
├── .env                 # API密钥（敏感信息）
├── auth.json            # OAuth认证信息
│
├── MEMORY.md            # 长期记忆
├── USER.md              # 用户画像
├── SOUL.yaml            # AI人格配置
│
├── skills/              # 技能库
│   ├── built-in/        # 内置技能
│   └── custom/          # 自定义技能
│
├── profiles/            # 多实例配置
│   ├── default/         # 默认实例
│   ├── dev/             # 开发实例
│   └── work/            # 工作实例
│
└── cache/               # 临时缓存
    ├── models/          # 模型缓存
    └── conversations/   # 对话缓存
```

> ✋ **费曼自测**：如果 config.yaml 是"客厅"，那么 .env 是什么？为什么要分开存放？

---

## 番茄钟2：核心配置文件详解（25分钟）

### 2.1 配置文件优先级

**加载顺序（后者覆盖前者）：**

```
1. 系统默认配置
2. ~/.hermes/config.yaml
3. --config 指定的配置文件
4. 命令行参数
```

### 2.2 config.yaml 完整配置项

```yaml
# ==================== 模型配置 ====================
model:
  provider: openrouter          # 提供商：openrouter/openai/anthropic/local
  name: hermes-4-14b            # 模型名称
  api_key: ${OPENROUTER_API_KEY} # 从环境变量读取
  base_url: https://openrouter.ai/api/v1
  temperature: 0.7              # 创造性（0-1）
  max_tokens: 4096              # 最大输出长度

# ==================== 记忆配置 ====================
memory:
  enabled: true                 # 是否启用记忆
  max_tokens: 10000             # 记忆窗口大小
  compression: true             # 是否压缩旧记忆
  curated_write: true           # 策展式写入（推荐开启）

# ==================== 技能配置 ====================
skills:
  enabled: true                 # 是否启用技能系统
  auto_generate: true           # 是否自动生成技能
  path: ~/.hermes/skills        # 技能库存放路径

# ==================== 工具配置 ====================
tools:
  enabled: true                 # 是否启用工具
  default_toolset: full         # 默认工具集：full/minimal/custom
  mcp_servers: []               # MCP服务器列表

# ==================== 日志配置 ====================
logging:
  level: INFO                   # 日志级别：DEBUG/INFO/WARNING/ERROR
  file: ~/.hermes/hermes.log    # 日志文件路径
```

### 2.3 配置项速查表

| 配置项 | 作用 | 推荐值 |
|:-------|:-----|:-------|
| `model.provider` | 模型提供商 | openrouter |
| `model.temperature` | 创造性程度 | 0.7（平衡） |
| `memory.max_tokens` | 记忆窗口 | 10000 |
| `memory.curated_write` | 策展式写入 | true |
| `skills.auto_generate` | 自动生成技能 | true |

> ✋ **费曼自测**：如果 AI 的回答太保守，你应该调整哪个配置项？调大还是调小？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] ~/.hermes/ 是 Hermes 的配置主目录
- [ ] config.yaml 是主配置文件
- [ ] .env 存放敏感信息（API Key）

---

## 番茄钟3：config.yaml 实践（25分钟）

### 3.1 创建 config.yaml

```bash
# 进入配置目录
cd ~/.hermes

# 创建配置文件
touch config.yaml

# 编辑配置文件
nano config.yaml  # 或使用你喜欢的编辑器
```

### 3.2 基础配置模板

```yaml
# Hermes 基础配置模板
# 创建日期：2026-06-06

model:
  provider: openrouter
  name: hermes-4-14b
  api_key: ${OPENROUTER_API_KEY}
  base_url: https://openrouter.ai/api/v1
  temperature: 0.7
  max_tokens: 4096

memory:
  enabled: true
  max_tokens: 10000
  compression: true
  curated_write: true

skills:
  enabled: true
  auto_generate: true

tools:
  enabled: true
  default_toolset: full

logging:
  level: INFO
```

### 3.3 验证配置

```bash
# 检查配置是否正确
hermes config validate

# 查看当前配置
hermes config show
```

> ✋ **费曼自测**：运行 `hermes config show`，检查输出是否符合你的配置。

---

## 番茄钟4：.env 和 auth.json（25分钟）

### 4.1 .env 文件详解

**为什么用 .env？**
- 敏感信息不应该进入版本控制
- 不同环境可以使用不同的 .env 文件
- 便于管理和轮换密钥

**.env 完整配置：**

```env
# ==================== API Keys ====================
# OpenRouter（推荐）
OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxxxxxx

# OpenAI（备选）
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx

# Anthropic（备选）
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxxxxx

# ==================== 其他服务 ====================
# GitHub（用于MCP连接）
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxx

# 数据库连接（可选）
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# ==================== 代理设置（可选） ====================
HTTP_PROXY=http://127.0.0.1:7890
HTTPS_PROXY=http://127.0.0.1:7890
```

### 4.2 auth.json 配置

**OAuth 认证信息：**

```json
{
  "github": {
    "access_token": "ghp_xxxxxxxxxxxxxxxx",
    "token_type": "bearer"
  },
  "google": {
    "access_token": "ya29.xxxxxxxxxxxxxxxx",
    "refresh_token": "1//xxxxxxxxxxxxxxxx",
    "expiry": "2026-07-06T00:00:00Z"
  }
}
```

### 4.3 安全最佳实践

```bash
# 设置 .env 文件权限
chmod 600 ~/.hermes/.env

# 添加到 .gitignore
echo ".env" >> ~/.gitignore
echo "auth.json" >> ~/.gitignore
```

> ✋ **费曼自测**：为什么要把 API Key 放在 .env 而不是直接写在 config.yaml 里？

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] config.yaml 创建完成
- [ ] .env 配置 API Key
- [ ] `hermes config validate` 通过

---

## 番茄钟5：记忆文件预览（25分钟）

### 5.1 MEMORY.md 简介

**MEMORY.md 是什么？**

想象一本**永不丢失的日记本**，AI 每次和你对话前都会先翻阅这本日记，记住你的背景、项目、重要经验。

### 5.2 MEMORY.md 基础模板

```markdown
# Hermes 长期记忆

## 用户背景
- 使用 Obsidian 进行知识管理
- 知识库名称：ideal
- 重点关注：知识自动化、AI记忆、内容生产

## 项目背景
- ideal知识库：个人知识管理 + 内容创作
- 书库系统：心理学、中医、法律等专题书库

## 重要经验
- [待积累]

## 注意事项
- 不要在会话中途修改 MEMORY.md
- 开启策展式写入避免记忆膨胀
```

### 5.3 USER.md 简介

**USER.md 是什么？**

一份**用户画像档案**，告诉 AI 你是谁、你喜欢什么、你讨厌什么。

```markdown
# 用户画像

## 基本信息
- 身份：内容创作者、知识管理爱好者
- 偏好：结构化、实用、高效
- 技术栈：Obsidian、Claude、Python

## 沟通风格
- 使用 Markdown 格式
- 清晰的层级结构
- 提供可执行的清单

## 禁忌
- 不要过度使用 emoji
- 不要输出冗余内容
- 不要在会话中途修改记忆文件
```

> ✋ **费曼自测**：MEMORY.md 和 USER.md 的区别是什么？各存放什么类型的信息？

---

## 番茄钟6：SOUL.yaml 和 profiles（25分钟）

### 6.1 SOUL.yaml 简介

**SOUL.yaml 是什么？**

一份**AI人格设定**，决定 AI 的性格、行为模式、说话风格。

```yaml
# SOUL.yaml - AI人格配置
name: Claudian
role: Obsidian知识库助手

personality:
  traits:
    - 专业但不死板
    - 简洁高效
    - 主动思考

communication_style:
  language: 中文
  tone: 专业友好
  format: Markdown

behavior_rules:
  - 每次启动先阅读 MEMORY.md
  - 使用相对路径引用文件
  - 编辑前必须先读取文件

constraints:
  - 不要覆盖用户数据
  - 不要使用绝对路径操作 Vault 文件
  - 不要创建不必要的临时文件
```

### 6.2 profiles 多实例

**profiles 是什么？**

为不同场景创建**独立的AI实例**，每个实例有独立的记忆和配置。

```
~/.hermes/profiles/
├── default/           # 默认实例
│   ├── MEMORY.md
│   ├── USER.md
│   └── SOUL.yaml
├── dev/               # 开发实例
│   ├── MEMORY.md
│   └── SOUL.yaml
└── work/              # 工作实例
    ├── MEMORY.md
    └── SOUL.yaml
```

**切换实例：**

```bash
# 使用默认实例
hermes chat

# 使用 dev 实例
hermes chat --profile dev

# 使用 work 实例
hermes chat --profile work
```

> ✋ **费曼自测**：如果你想为"学习AI课程"和"日常写作"创建两个不同的AI助手，应该怎么做？

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 理解 MEMORY.md 的作用
- [ ] 理解 USER.md 的作用
- [ ] 理解 SOUL.yaml 的作用
- [ ] 理解 profiles 多实例隔离

---

## 番茄钟7：今日复习（25分钟）

### 7.1 核心概念回顾

**目录结构速记口诀：**

```
config.yaml 管全局
.env 存密钥
MEMORY.md 记长期
USER.md 画用户
SOUL.yaml 定人格
skills/ 放技能
profiles/ 分实例
```

### 7.2 配置文件对比

| 文件 | 用途 | 修改频率 | 敏感性 |
|:-----|:-----|:---------|:-------|
| config.yaml | 主配置 | 低 | 低 |
| .env | API密钥 | 低 | 高 |
| MEMORY.md | 长期记忆 | 中 | 中 |
| USER.md | 用户画像 | 低 | 低 |
| SOUL.yaml | AI人格 | 低 | 低 |

### 7.3 命令速查卡

| 命令 | 功能 |
|:-----|:-----|
| `hermes config validate` | 验证配置 |
| `hermes config show` | 查看当前配置 |
| `hermes chat --profile <name>` | 使用指定实例 |
| `hermes memory show` | 查看记忆内容 |

---

## 番茄钟8：输出成果（25分钟）

### 8.1 完成目录结构创建

```bash
# 创建完整目录结构
mkdir -p ~/.hermes/{skills/built-in,skills/custom,profiles/default,cache/models,cache/conversations}

# 创建配置文件
touch ~/.hermes/{config.yaml,.env,MEMORY.md,USER.md,SOUL.yaml}
```

### 8.2 刻意练习——目录结构与配置文件

**练习目标**：在20分钟内对配置文件进行3轮"修改—验证—观察"的完整循环

**任务序列（重复×3）：**

```
===== 循环 1：入门任务 =====
1. 修改 config.yaml 中的 temperature 为 0.3、0.7、1.0 三个值
2. 每次修改后运行 `hermes config validate` 验证语法
3. 运行 `hermes config show` 确认修改生效
验证方式：hermes config show 输出与配置一致

===== 循环 2：进阶任务 =====
1. 创建一份自定义 AGENTS.md，定义3条行为规则
2. 在 config.yaml 中添加 agents_file 指向自定义路径
3. 运行 `hermes chat` 测试新规则是否生效
验证方式：AI 行为符合新定义的规则

===== 循环 3：挑战任务 =====
1. 在 `/tmp/hermes-test` 下从零创建完整项目结构
2. 包含 config.yaml、.env、MEMORY.md、USER.md、SOUL.yaml
3. 配置完成后运行 `hermes config validate` 全项通过
验证方式：从头搭建的配置能正常启动并进入对话
```

**自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 配置项修改 | ⬜ | ⬜ | ⬜ |
| config.yaml 语法验证 | ⬜ | ⬜ | ⬜ |
| AGENTS.md 创建 | ⬜ | ⬜ | ⬜ |
| 完整项目搭建 | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：不看配置文档，能否独立完成一份完整的 config.yaml + .env + MEMORY.md 配置？

### 8.3 今日自检清单

- [ ] **番茄1-2**：能画出 ~/.hermes/ 目录结构图
- [ ] **番茄3-4**：config.yaml 配置完成并通过验证
- [ ] **番茄5-6**：理解 MEMORY.md/USER.md/SOUL.yaml 的区别
- [ ] **番茄7-8**：创建了完整目录结构

### 8.4 学习笔记模板

```markdown
# Hermes Agent 学习笔记 - Day 2

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
掌握了 ~/.hermes/ 目录结构，理解了每个配置文件的作用。

## 关键要点

### 1. 目录结构
- config.yaml：主配置
- .env：敏感信息
- MEMORY.md：长期记忆
- USER.md：用户画像
- SOUL.yaml：AI人格

### 2. 配置最佳实践
- API Key 放 .env，不进版本控制
- 开启策展式写入避免记忆膨胀
- 使用 profiles 隔离不同场景

## 明日计划
- 学习记忆系统配置
- 实践 MEMORY.md 写入机制
```

---

## 🎉 Day 2 完成！

**今日成果：**
- ✅ 掌握 ~/.hermes/ 目录结构
- ✅ 完成 config.yaml 配置
- ✅ 理解各配置文件的作用
- ✅ 了解 profiles 多实例隔离

**明天预告：** [[Day3-记忆系统]] - 深入学习 MEMORY.md 和 USER.md 配置

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day1-安装与模型配置]] - 上一天内容
