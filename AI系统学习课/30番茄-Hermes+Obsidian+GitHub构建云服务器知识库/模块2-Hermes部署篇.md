---
created: 2026-06-20
tags:
  - "#教程/模块2"
  - "#hermes"
  - "#部署"
  - "#api"
  - "#微信"
  - "#QQ"
  - "#飞书"
  - "#钉钉"
aliases: Hermes部署篇
---

# 🍅 模块2：Hermes部署篇（番茄5-10）

> ⏱ **总时长**：6番茄 = 150分钟专注 + 休息
> 📖 **学习目标**：安装Hermes Agent、配置模型API、集成四大通讯平台
> 🧠 **费曼核心**："Hermes是AI大脑的'操作系统'——它连接模型、知识和通讯工具"

---

## 🍅 番茄5：Hermes Agent一键安装

> ⏱ 25分钟 | 📌 核心技能：Hermes安装、虚拟环境、启动验证

### 5.1 Hermes Agent是什么？

```
┌───────────────────────────────────────┐
│           Hermes Agent                │
│  ┌─────────┐  ┌─────────┐  ┌───────┐ │
│  │ 模型接入  │  │ 工具调用  │  │ 知识库 │ │
│  │ OpenAI   │  │ Web搜索  │  │ 本地KB │ │
│  │ Claude   │  │ 代码执行 │  │ RAG   │ │
│  │ 更多...  │  │ 文件操作 │  │       │ │
│  └─────────┘  └─────────┘  └───────┘ │
│  ┌─────────────────────────────┐      │
│  │    通讯集成                   │      │
│  │  微信 │ QQ │ 飞书 │ 钉钉     │      │
│  └─────────────────────────────┘      │
└───────────────────────────────────────┘
```

### 5.2 安装Hermes Agent

```bash
# 登录服务器
ssh root@114.215.208.216

# 方法一：官方一键安装（推荐）
curl -fsSL https://hermes-agent.sh/install | bash

# 方法二：使用国内镜像（如果官方安装慢）
# curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/hermes-agent/install/main/install.sh | bash

# 安装完成后，检查版本
hermes --version
```

### 5.3 虚拟环境管理

```bash
# Hermes通常安装在虚拟环境中
# 激活虚拟环境
source ~/.hermes/bin/activate
# 或
source ~/.local/share/hermes/venv/bin/activate

# 提示：终端会出现 (hermes) 前缀
# 退出虚拟环境
deactivate

# 查看Hermes路径
which hermes
```

### 5.4 初始化配置

```bash
# 运行配置向导
hermes setup
```

配置向导会依次询问：
1. **模型提供商**：选择OpenRouter（推荐国内使用）
2. **API Key**：输入你的OpenRouter Key
3. **沙箱运行模式**：选择 Local（本机直接运行）
4. **SSH配置**：如果选择Local模式则跳过

### 5.5 验证安装

```bash
# 启动测试（前台运行，按Ctrl+C停止）
hermes server --host 0.0.0.0 --port 18789

# 在浏览器中访问
# http://你的服务器IP:18789
# 例：http://114.215.208.216:18789
```

### ⚠️ 常见问题

| 问题 | 原因 | 解决方案 |
|:---|:----|:--------|
| 无法访问18789端口 | 安全组未放行 | 检查阿里云安全组规则 |
| | UFW防火墙阻挡 | `sudo ufw allow 18789/tcp` |
| 安装失败 | 国内网络问题 | 使用ghproxy代理 |
| | 依赖缺失 | `sudo apt install -y build-essential` |

### 💪 刻意练习

```
基础：完成Hermes安装，前台启动并访问Web界面
挑战：在浏览器中点击Hermes界面，尝试一次对话
费曼检验："为什么需要API Key？OpenRouter起什么作用？"
```

---

## 🍅 番茄6：模型API Key配置

> ⏱ 25分钟 | 📌 核心技能：多种模型API接入、OpenRouter配置

### 6.1 获取OpenRouter API Key

1. 访问 [OpenRouter](https://openrouter.ai/)
2. 注册/登录账号
3. 进入 Keys 页面，创建新Key
4. 复制Key（格式：`sk-or-v1-xxxxxxxxxxxxxxxx`）

> 💡 **提示**：OpenRouter的好处是聚合了多种模型（GPT-4、Claude、Gemini等），只需一个Key即可访问多种模型。

### 6.2 配置Hermes的API Key

```bash
# 运行配置
hermes setup

# 或直接编辑配置文件
nano ~/.hermes/config.yaml
```

配置文件示例：

```yaml
# ~/.hermes/config.yaml

models:
  default_provider: openrouter
  
  openrouter:
    api_key: "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"
    base_url: "https://openrouter.ai/api/v1"
    default_model: "anthropic/claude-3.5-sonnet"
    
  # 可选：直接配置其他模型
  # openai:
  #   api_key: "sk-xxxx"
  #   base_url: "https://api.openai.com/v1"
  
  # 可选：配置本地模型 (LLaMA, Qwen等)
  # local:
  #   base_url: "http://localhost:11434/v1"
  #   default_model: "qwen2.5:7b"

server:
  host: "0.0.0.0"
  port: 18789
  
sandbox:
  mode: local  # local | ssh | docker
```

### 6.3 常用模型推荐

| 模型 | 提供商 | 特点 | 推荐场景 |
|:---|:------|:----|:--------|
| Claude 3.5 Sonnet | Anthropic | 推理能力强，适合复杂任务 | 心理咨询、写作 |
| GPT-4o | OpenAI | 全面均衡 | 通用对话 |
| DeepSeek V3 | DeepSeek | 性价比高，中文优秀 | 法律咨询 |
| Qwen 2.5 (72B) | 阿里云 | 中文最佳 | 本土化应用 |

### 6.4 验证API配置

```bash
# 使用hermes测试API连接
hermes doctor --fix

# 如果输出显示API密钥有效，说明配置成功
```

### 💪 刻意练习

```
基础：配置OpenRouter API Key并验证成功
挑战：尝试在配置中切换不同的模型，观察回答质量和速度的变化
费曼检验："API Key本质上是什么？为什么不能把Key上传到GitHub？"
```

---

## 🍅 番茄7：微信集成配置

> ⏱ 25分钟 | 📌 核心技能：企业微信接入、消息转发配置

### 7.1 准备工作

要集成微信，有两种方式：
- **企业微信应用**（推荐，功能完整）
- **个人微信协议**（有封号风险，不推荐）

这里使用**企业微信**方式。

### 7.2 创建企业微信应用

1. 登录 [企业微信管理后台](https://work.weixin.qq.com/)
2. 应用管理 → 创建应用
3. 填写应用信息：
   - **应用名称**：Hermes AI助手
   - **应用描述**：你的AI知识库助手
   - **可见范围**：选择需要使用的成员
4. 创建完成后，获取：
   - **AgentId**：应用的唯一ID
   - **Secret**：应用密钥

### 7.3 配置企业ID

```bash
# 企业微信后台 → 我的企业 → 企业信息
# 获取 企业ID (CorpId)
```

### 7.4 Hermes配置微信

```bash
# 运行hermes setup，在微信配置部分输入
# 或直接编辑配置文件

nano ~/.hermes/config.yaml
```

添加微信配置：

```yaml
# 在config.yaml中添加
channels:
  wechat:
    enabled: true
    type: wecom  # 企业微信
    corp_id: "你的企业ID"
    agent_id: "你的AgentId"
    secret: "你的Secret"
    # 可选：配置接收消息的URL
    # callback_url: "https://你的域名/callback"
```

### 7.5 配置消息回调（可选）

如果想让微信主动接收消息，需要配置回调URL：

```bash
# 在企业微信应用设置中配置回调URL
# URL格式：http://你的服务器IP:18789/api/wechat/callback
# 或：https://你的域名/api/wechat/callback

# 在服务器防火墙放行
sudo ufw allow 18789/tcp
```

### 7.6 验证微信集成

```bash
# 重启Hermes
hermes server --host 0.0.0.0 --port 18789

# 在企业微信中向应用发送消息测试
```

### 💪 刻意练习

```
基础：创建企业微信应用并配置到Hermes
挑战：测试发送一条消息给企业微信应用，确认收到AI回复
费曼检验："企业微信应用和个人微信机器人有什么本质区别？"
```

---

## 🍅 番茄8：QQ集成配置

> ⏱ 25分钟 | 📌 核心技能：QQ机器人接入

### 8.1 QQ机器人接入方式

QQ机器人的接入方式：
- **QQ官方机器人**（推荐，需要申请）
- **基于Mirai的私搭方案**（技术门槛高）

### 8.2 申请QQ官方机器人

1. 访问 [QQ机器人开放平台](https://bot.q.qq.com/)
2. 注册开发者账号
3. 创建机器人：
   - **机器人名称**：Hermes助手
   - **机器人类型**：公域机器人（可被搜索）或私域机器人（仅限群内使用）
4. 获取 **BotAppID** 和 **BotToken**

### 8.3 Hermes配置QQ

```bash
nano ~/.hermes/config.yaml
```

```yaml
channels:
  qq:
    enabled: true
    type: official  # 官方机器人
    app_id: "你的BotAppID"
    token: "你的BotToken"
    # 沙箱环境（开发测试）
    sandbox: true
    
    # 事件订阅（根据需要开启）
    intents:
      - GROUP_AT_MESSAGE     # 群@消息
      - C2C_MESSAGE          # 私聊消息
    #  - DIRECT_MESSAGE      # 频道私信
```

### 8.4 QQ群聊配置

```yaml
# 可选：限定只在指定群聊中响应
qq:
  enabled: true
  allow_groups:
    - "群号1"
    - "群号2"
  # 或白名单用户
  allow_users:
    - "QQ号1"
```

### 8.5 验证QQ集成

```bash
# 重启Hermes
hermes server --host 0.0.0.0 --port 18789

# 在QQ中@机器人发送消息测试
# 或发送私聊消息
```

### 💪 刻意练习

```
基础：申请QQ机器人并配置到Hermes，私聊回复正常
挑战：在群聊中@机器人测试，配置仅限特定群响应
费曼检验："QQ机器人为什么需要沙箱环境？正式上线前应该做什么测试？"
```

---

## 🍅 番茄9：飞书集成配置

> ⏱ 25分钟 | 📌 核心技能：飞书机器人接入

### 9.1 飞书开放平台

飞书是字节跳动旗下的协作平台，API接口完善，集成体验最好。

### 9.2 创建飞书应用

1. 访问 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用：
   - **应用名称**：Hermes AI知识库助手
   - **应用描述**：基于知识库的AI助手
3. 获取凭证：
   - **App ID**
   - **App Secret**

### 9.3 配置机器人能力

在飞书开放平台配置：
1. 功能配置 → 机器人 → 开启机器人能力
2. 事件订阅 → 添加事件：
   - `im.message.receive_v1`（接收消息）
3. 权限管理 → 添加权限：
   - `im:message`（消息相关）
   - `im:chat`（群聊相关）
4. 发布应用 → 版本管理 → 创建版本 → 提交审核

### 9.4 Hermes配置飞书

```bash
nano ~/.hermes/config.yaml
```

```yaml
channels:
  feishu:
    enabled: true
    app_id: "你的AppID"
    app_secret: "你的AppSecret"
    
    # 可选：配置允许的租户
    # tenant: "你的租户域名"
    
    # 可选：事件回调
    # callback_url: "https://你的域名/api/feishu/callback"
```

### 9.5 验证飞书集成

```bash
# 重启Hermes
hermes server --host 0.0.0.0 --port 18789

# 在飞书中搜索你的应用并发送消息测试
```

### 💪 刻意练习

```
基础：创建飞书应用并配置到Hermes
挑战：测试飞书信道，包括私聊和群聊两种场景
费曼检验："为什么说飞书的API接口是三家里最好用的？"
```

---

## 🍅 番茄10：钉钉集成配置 + 多平台综合测试

> ⏱ 25分钟 | 📌 核心技能：钉钉机器人接入、多平台统一管理

### 10.1 钉钉开放平台

钉钉是阿里系协作平台，Hermes对钉钉的支持也较为完善。

### 10.2 创建钉钉机器人

1. 访问 [钉钉开放平台](https://open.dingtalk.com/)
2. 创建应用：
   - **应用类型**：企业内部应用
   - **应用名称**：Hermes AI知识库助手
3. 配置机器人：
   - 添加机器人能力
   - **消息接收模式**：HTTP（Webhook）
   - **消息出口URL**：`http://你的服务器IP:18789/api/dingtalk/callback`
4. 获取凭证：
   - **Client ID**（AppKey）
   - **Client Secret**（AppSecret）

### 10.3 Hermes配置钉钉

```bash
nano ~/.hermes/config.yaml
```

```yaml
channels:
  dingtalk:
    enabled: true
    client_id: "你的ClientID"
    client_secret: "你的ClientSecret"
    # 机器人编码（在机器人设置中获取）
    robot_code: "你的机器人编码"
    # 回调URL
    callback_url: "http://114.215.208.216:18789/api/dingtalk/callback"
```

### 10.4 多平台配置汇总

完成全部配置后的完整`config.yaml`：

```yaml
# ~/.hermes/config.yaml 完整配置

models:
  default_provider: openrouter
  openrouter:
    api_key: "sk-or-v1-xxxxxxxxxxxxxxxx"
    base_url: "https://openrouter.ai/api/v1"
    default_model: "anthropic/claude-3.5-sonnet"

server:
  host: "0.0.0.0"
  port: 18789

sandbox:
  mode: local

channels:
  wechat:
    enabled: true
    type: wecom
    corp_id: "xxx"
    agent_id: "xxx"
    secret: "xxx"
  
  qq:
    enabled: true
    type: official
    app_id: "xxx"
    token: "xxx"
  
  feishu:
    enabled: true
    app_id: "xxx"
    app_secret: "xxx"
  
  dingtalk:
    enabled: true
    client_id: "xxx"
    client_secret: "xxx"
    robot_code: "xxx"
    callback_url: "http://114.215.208.216:18789/api/dingtalk/callback"

knowledge:
  base_path: "/home/hermes/knowledge-bases"
  index_path: "/home/hermes/.hermes/knowledge_index"
```

### 10.5 配置守护进程（让Hermes后台运行）

```bash
# 安装screen（终端复用器）
sudo apt install -y screen

# 创建持久会话
screen -S hermes

# 在screen中启动Hermes
hermes server --host 0.0.0.0 --port 18789

# 按 Ctrl+A 然后按 D 分离会话（服务继续运行）

# 重新连接到Hermes会话
screen -r hermes

# 查看所有screen会话
screen -ls
```

#### 或者使用systemd服务（推荐生产环境）

```bash
# 创建systemd服务文件
sudo nano /etc/systemd/system/hermes.service
```

```ini
[Unit]
Description=Hermes Agent Service
After=network.target

[Service]
Type=simple
User=hermes
WorkingDirectory=/home/hermes
ExecStart=/home/hermes/.local/share/hermes/venv/bin/hermes server --host 0.0.0.0 --port 18789
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
# 启用并启动服务
sudo systemctl daemon-reload
sudo systemctl enable hermes
sudo systemctl start hermes

# 查看状态
sudo systemctl status hermes

# 查看日志
sudo journalctl -u hermes -f
```

### 10.6 多平台综合测试

**测试清单**：

- [ ] Hermes Web界面可正常访问（http://IP:18789）
- [ ] 通过Web界面提问能收到AI回复
- [ ] 企业微信发送消息能收到回复
- [ ] QQ私聊/群聊@机器人能正常响应
- [ ] 飞书发送消息能收到回复
- [ ] 钉钉发送消息能收到回复

### 10.7 各平台特性对比

| 特性 | 微信(企业) | QQ | 飞书 | 钉钉 |
|:----|:---------|:---|:----|:----|
| 配置难度 | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| 用户体验 | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| API完善度 | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 适合场景 | 日常个人使用 | 群聊机器人 | 团队协作 | 企业办公 |
| 审核要求 | 有 | 有 | 有 | 有 |

### 💪 刻意练习

```
基础：完成钉钉集成，并用systemd配置Hermes为开机自启服务
挑战：在所有四个平台上分别发送消息，观察回复是否一致
项目：编写一个shell脚本，一键检查所有平台连接状态
费曼检验："守护进程和前台运行有什么区别？为什么生产环境要用systemd？"
```

---

## 📊 模块2回顾

### 番茄进度

- [x] 🍅 番茄5：Hermes Agent安装
- [x] 🍅 番茄6：模型API Key配置
- [x] 🍅 番茄7：微信集成
- [x] 🍅 番茄8：QQ集成
- [x] 🍅 番茄9：飞书集成
- [x] 🍅 番茄10：钉钉集成 + 综合测试

### 费曼检验

用你自己的话回答：
1. "Hermes Agent在整个架构中扮演什么角色？"
2. "四种通讯平台集成各有什么特点？你首选哪个？"
3. "为什么使用systemd而不是screen管理Hermes进程？"

### 刻意练习成果

```
已完成的操作：
- [ ] Hermes安装并成功启动
- [ ] 配置了至少一个模型的API Key
- [ ] 集成了至少一个通讯平台
- [ ] 配置了Hermes开机自启

下一步的关键问题：
1.
2.
```

---

**下一步 → [[模块3-知识库构建篇]]**
