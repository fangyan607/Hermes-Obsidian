---
created: 2026-06-19
tags:
  - AI系统学习课
  - MCP
  - mcp2cli
  - 工具
  - 番茄费曼
  - 刻意练习
  - CLI
source: https://github.com/knowsuchagency/mcp2cli
updated: 2026-06-19
---

# 🍅 mcp2cli 一番茄快速掌握

> **1个番茄 · 费曼学习法 × 刻意练习**
> 把任何 MCP 服务器、OpenAPI 接口或 GraphQL 端点变成 CLI 命令

---

## 📋 学习目标

| 项目 | 内容 |
|------|------|
| **学习主题** | mcp2cli —— One CLI for Every API，零代码生成，节省 96-99% Token |
| **掌握程度** | □ 了解 → ✅ 理解 → □ 应用 → □ 教授他人 |
| **学习方法** | 番茄工作法 🍅 + 费曼学习法 📝 + 刻意练习 🎯 |
| **总时长** | 1个番茄 = 25分钟专注（无休息，单番茄冲刺） |

---

## ⏱️ 番茄节奏

```
前10分钟 → 🧠 费曼输入：理解 mcp2cli 是什么、为什么需要它
中间10分钟 → ✋ 刻意练习：四个核心模式 + bake + 动手模拟
最后5分钟 → 📝 费曼复盘：三句话总结 + 快速问答
```

---

# 🧠 阶段一：费曼输入（前10分钟）

## 1.1 这是什么？（费曼三句话热身）

| 你问 | 费曼回答 |
|------|----------|
| **它是什么？** | mcp2cli 是一个 CLI 工具，能把 **MCP 服务器**、**OpenAPI 接口文档**、**GraphQL 端点** 三种 API 来源自动变成命令行命令——不用写一行代码 |
| **为什么需要它？** | AI Agent 调用工具时，每次都要把完整的工具 Schema（参数结构、描述等）塞进对话上下文，浪费大量 Token。mcp2cli 把这些 Schema **留在 CLI 进程里**，只在需要时传必要参数，节省 96-99% Token |
| **怎么做到的？** | 你运行 `mcp2cli --mcp <URL> list-tools` 时，它先连接到 API 源，动态解析出可用的命令和参数，然后像普通 CLI 一样执行——整个过程**零代码生成、零临时文件** |

## 1.2 Token 节省原理（核心卖点）

```
传统方式（AI Agent 直接调用 MCP）:
  每次对话 → 发送全部工具 Schema（~1400 Tokens 对于 96 个工具）
  每次轮询 → 重复发送

mcp2cli 方式:
  工具 Schema 留在 CLI 进程本地
  CLI 只传递: {tool_name, arg1: val1, arg2: val2}
  → 每次调用只需 ~20-50 Tokens

节省幅度: 96-99% 🚀
```

> 💡 **费曼翻译**：想象每次点餐你都要把整本菜单念一遍——mcp2cli 就像只喊"老样子"，厨师已经知道菜单了。

---

## 1.3 三种 API 来源（核心能力图）

```
mcp2cli
    │
    ├── 📡 --mcp URL        → MCP 服务器（HTTP/SSE 协议）
    │     例: mcp2cli --mcp https://mcp.example.com/sse search --query "test"
    │
    ├── 🖥️ --mcp-stdio CMD  → MCP 服务器（标准输入输出）
    │     例: mcp2cli --mcp-stdio "npx @mcp/github" list-repos
    │
    ├── 📄 --spec URL|FILE  → OpenAPI 规范（JSON/YAML）
    │     例: mcp2cli --spec ./openapi.json list-pets --status available
    │
    └── 🔗 --graphql URL    → GraphQL 端点
          例: mcp2cli --graphql https://api.example.com/graphql users --limit 10
```

---

# ✋ 阶段二：刻意练习（中间10分钟）

## 2.1 🎯 练习1：安装与启动（遮住右侧试试）

| 场景 | 命令 | 自测 ✅ |
|------|------|---------|
| 不安装直接运行 | `uvx mcp2cli --help` | □ |
| 全局安装 | `uv tool install mcp2cli` | □ |
| 安装 AI Agent Skill | `npx skills add knowsuchagency/mcp2cli --skill mcp2cli` | □ |
| 查看帮助 | `mcp2cli --help` | □ |

## 2.2 🎯 练习2：四种核心模式（分类记忆）

### MCP HTTP 模式（最常用）

```bash
# 列出 MCP 服务器的所有工具
mcp2cli --mcp https://mcp.example.com/sse --list

# 调用一个工具
mcp2cli --mcp https://mcp.example.com/sse search --query "test"

# 携带认证头
mcp2cli --mcp https://mcp.example.com/sse --auth-header "x-api-key:sk-..." query --sql "SELECT 1"

# 搜索工具（按名称/描述，不区分大小写）
mcp2cli --mcp https://mcp.example.com/sse --search "task"
```

### MCP Stdio 模式（本地 MCP 服务器）

```bash
# 列出工具
mcp2cli --mcp-stdio "npx @modelcontextprotocol/server-filesystem /tmp" --list

# 调用工具
mcp2cli --mcp-stdio "npx @modelcontextprotocol/server-filesystem /tmp" read-file --path /tmp/hello.txt

# 传递环境变量给 MCP 服务器进程
mcp2cli --mcp-stdio "node server.js" --env API_KEY=sk-... --env DEBUG=1 search --query "test"
```

### OpenAPI 模式（任意 API 文档）

```bash
# 从远程 Spec 列出命令
mcp2cli --spec https://petstore3.swagger.io/api/v3/openapi.json --list

# 调用接口
mcp2cli --spec ./openapi.json --base-url https://api.example.com list-pets --status available

# POST 请求（从标准输入传 JSON）
echo '{"name": "Fido"}' | mcp2cli --spec ./spec.json create-pet --stdin
```

### GraphQL 模式（任意 GraphQL）

```bash
# 列出查询和变更
mcp2cli --graphql https://api.example.com/graphql --list

# 执行查询
mcp2cli --graphql https://api.example.com/graphql users --limit 10

# 自定义字段选择
mcp2cli --graphql https://api.example.com/graphql users --fields "id name email"
```

> 🧠 **刻意练习**：遮住右边命令，只看场景描述，**自己写出对应命令**

---

## 2.3 🎯 练习3：Bake 模式——省到你不想用别的

Bake 模式是 mcp2cli 的**杀手级功能**：把连接配置存成"别名"，以后用 `@别名` 直接调用。

### 创建 Bake

```bash
# 从 OpenAPI 规格创建
mcp2cli bake create petstore --spec https://api.example.com/spec.json \
  --exclude "delete-*,update-*" --methods GET,POST --cache-ttl 7200

# 从 MCP Stdio 创建
mcp2cli bake create mygit --mcp-stdio "npx @mcp/github" \
  --include "search-*,list-*" --exclude "delete-*"
```

### 使用 Bake

```bash
# 列工具
mcp2cli @petstore --list

# 调用——不需要再写 --spec/--mcp
mcp2cli @petstore list-pets --limit 10

# 另一个 bake
mcp2cli @mygit search-repos --query "rust"
```

### 管理 Bake

```bash
mcp2cli bake list              # 列出所有
mcp2cli bake show petstore     # 查看配置（秘密已脱敏）
mcp2cli bake update petstore --cache-ttl 3600  # 更新
mcp2cli bake remove petstore   # 删除
mcp2cli bake install petstore  # 创建 ~/.local/bin/petstore 包装脚本
```

> 💡 **关键洞察**：Bake 安装出来的包装脚本是独立的可执行文件——`petstore list-pets`，都不用敲 `mcp2cli` 了！

---

## 2.4 🎯 练习4：常用扩展功能（快速记忆）

| 功能 | 命令 | 一句话总结 |
|------|------|-----------|
| **OAuth 认证** | `--oauth` / `--oauth-client-id` / `--oauth-client-secret` | 自动处理授权码+PKCE流程，缓存和刷新 Token |
| **敏感信息保护** | `--auth-header "Authorization:env:MY_TOKEN"` | 用 `env:` 和 `file:` 前缀避免秘密暴露在进程列表 |
| **缓存控制** | `--cache-ttl 86400` / `--refresh` | 默认缓存1小时，可调TTL或强制刷新 |
| **JSON 输出** | `--json` | 强制输出合法 JSON，适合 LLM 解析 |
| **输出截断** | `--head 5` / `--compact` | 大数据时只取前N条 |
| **使用量排名** | `--list --top 10 --compact` | 按调用频率排序，最常用的排前面 |
| **TOON 格式** | `--toon` | Token 高效编码，比 JSON 省40-60% Token |

---

# 📝 阶段三：费曼复盘（最后5分钟）

## 3.1 费曼三句话（强制输出）

> **不看资料，用三句话向一个刚入门 AI 的开发者解释 mcp2cli**

| 我的三句话 | 自评 |
|------------|:----:|
| ① mcp2cli 是一个"万能 API 转 CLI"工具——无论 API 是用 MCP、OpenAPI 还是 GraphQL 写的，它都能自动识别并让你直接在终端里调用 | ✅ / ❌ |
| ② 对 AI Agent 来说，它最牛的地方是省 Token——不用每次对话都传完整的工具 Schema，只需要传实际调用的参数就行，能省 96-99% | ✅ / ❌ |
| ③ 它还支持 Bake 模式把你的 API 配置存成快捷别名，以后用 `@别名` 就能直接调用，甚至能生成独立的 CLI 包装脚本 | ✅ / ❌ |

## 3.2 快速问答（刻意练习·检验）

| 问题 | 答案 |
|------|------|
| mcp2cli 支持哪三种 API 来源？ | MCP HTTP/SSE、MCP Stdio、OpenAPI、GraphQL（四种） |
| 怎么不安装就使用？ | `uvx mcp2cli --help` |
| Bake 模式用哪个符号调用？ | `@`（如 `mcp2cli @petstore --list`） |
| --search 隐含什么？ | 隐含 `--list` |
| 怎么避免 API Key 出现在进程列表？ | 用 `env:` 或 `file:` 前缀（如 `--auth-header "Authorization:env:MY_TOKEN"`） |
| mcp2cli 的设计受谁启发？ | [CLIHub](https://kanyilmaz.me/2026/02/23/cli-vs-mcp.html) by Kagan Yilmaz |

## 3.3 快速参考卡（打印级）

```
安装:     uv tool install mcp2cli
使用:     mcp2cli --mcp <URL> | --mcp-stdio <CMD> | --spec <FILE> | --graphql <URL>
快捷:     bake create <别名> → mcp2cli @<别名>
省Token:  96-99%
Shell集成: bake install <别名> → 生成独立命令
输出控制:  --json | --pretty | --raw | --toon | --head N | --compact
认证:     --auth-header | --oauth | env:/file: 前缀
缓存:     --cache-ttl N | --refresh | --cache-key
```

---

## 🔗 知识连接

| 已有知识 | 连接 | 启发 |
|----------|------|------|
| [[AI系统学习课/10-MCP与A2A的应用]] | MCP 协议基础 | mcp2cli 是 MCP 协议的 CLI 化实现 |
| [[AI系统学习课/11-Agent智能体系统的设计与应用]] | Agent 工具调用 | mcp2cli 解决 Agent 工具调用的 Token 浪费问题 |
| [[Claude_Memory/知识库技术对比洞见-RAG-GBrain-LLM_WIKI-2026-06-10]] | 工具链效率 | 省 Token = 省成本 = 更快响应 |
| [[日记/2026-06-19]] | 今日学习 | mcp2cli 是日记里收藏的工具 |

---

## 📝 番茄记录

- [x] 🧠 费曼输入：理解 mcp2cli 的核心价值（省 Token 96-99%）
- [x] ✋ 刻意练习：四种模式 + Bake + 扩展功能
- [x] 📝 费曼复盘：三句话输出 + 快速问答
- [ ] 下一步：实际安装并连接一个真实 API 体验

> **一句话总结**：mcp2cli = 万能 API 转 CLI + 96-99% Token 节省 + Bake 快捷别名，是 AI Agent 工具调用的终极效率工具。
