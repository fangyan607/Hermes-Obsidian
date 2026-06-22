# Day 8：安全防护与 WAF

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：配置 WAF 规则，保护网站安全
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 Cloudflare 安全防护
🍅 番茄3-4：WAF 规则配置
🍅 番茄5-6：DDoS 防护与访问控制
🍅 番茄7-8：安全监控 + 复习输出
```

---

## 番茄钟1：理解安全威胁

### 1.1 常见网络威胁

| 威胁类型 | 说明 | 危害 |
|:---------|:-----|:-----|
| **DDoS 攻击** | 大量请求淹没服务器 | 服务不可用 |
| **SQL 注入** | 恶意 SQL 语句 | 数据泄露 |
| **XSS 攻击** | 注入恶意脚本 | 用户信息被盗 |
| **暴力破解** | 尝试密码组合 | 账户被入侵 |
| **恶意爬虫** | 自动抓取数据 | 服务器压力 |

### 1.2 Cloudflare 安全架构

```
┌─────────────────────────────────────────────────────────────┐
│                    Cloudflare 安全架构                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  用户请求                                                    │
│      ↓                                                      │
│  DDoS 防护层 ──→ 识别并过滤攻击流量                          │
│      ↓                                                      │
│  WAF 防火墙 ──→ 检查请求是否违反规则                         │
│      ↓                                                      │
│  Bot 管理 ──→ 识别和处理机器人流量                           │
│      ↓                                                      │
│  访问控制 ──→ IP/国家/速率限制                               │
│      ↓                                                      │
│  合法请求 → 源站                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 1.3 免费套餐安全能力

| 功能 | 免费额度 | 说明 |
|:-----|:---------|:-----|
| DDoS 防护 | 无限流量 | L3/L4/L7 防护 |
| WAF 规则 | 5条 | 自定义规则 |
| Bot 管理 | 基础 | 识别已知恶意机器人 |
| 速率限制 | 1条 | 限制请求频率 |

> ✋ **费曼自测**：列举三种常见的网络威胁。

---

## 番茄钟2：WAF 基础概念

### 2.1 什么是 WAF？

**WAF（Web Application Firewall）= 网站防火墙**

检查每个 HTTP 请求，根据规则决定：
- ✅ 放行
- ❌ 拦截
- 🔍 质询（人机验证）

### 2.2 WAF 规则类型

| 规则类型 | 说明 | 示例 |
|:---------|:-----|:-----|
| **托管规则** | Cloudflare 预设规则 | OWASP 核心规则 |
| **自定义规则** | 用户定义的规则 | 拦截特定 IP |
| **速率规则** | 限制请求频率 | 每分钟最多 100 次 |
| **区域锁定** | 限制访问地区 | 仅允许中国访问 |

### 2.3 规则匹配条件

```
条件 = 字段 + 运算符 + 值

示例：
- 字段：IP 地址
- 运算符：等于
- 值：1.2.3.4

结果：当访问者 IP 是 1.2.3.4 时触发
```

**常用字段：**

| 字段 | 说明 |
|:-----|:-----|
| IP Address | 访问者 IP |
| Country | 访问者国家 |
| Hostname | 访问域名 |
| URI Path | 请求路径 |
| User Agent | 浏览器标识 |
| Request Method | 请求方法 |

> ✋ **费曼自测**：解释 WAF 如何保护网站。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] 了解常见网络威胁
- [ ] 理解 Cloudflare 安全架构
- [ ] 掌握 WAF 规则类型

---

## 番茄钟3：配置托管规则

### 3.1 启用托管规则集

```
Security → WAF → Managed rules

Cloudflare Free Managed Ruleset：
- 已启用 ✅

点击配置：
- 规则操作：Block（拦截）/ Challenge（质询）/ Log（记录）
```

### 3.2 规则操作说明

| 操作 | 效果 | 适用场景 |
|:-----|:-----|:---------|
| **Block** | 直接拦截，返回 403 | 确定的恶意请求 |
| **Challenge** | 弹出验证页面 | 可疑请求 |
| **JS Challenge** | JavaScript 验证 | 中等风险 |
| **Managed Challenge** | 智能验证 | 推荐使用 |
| **Log** | 仅记录不拦截 | 测试规则 |

### 3.3 配置规则例外

```
跳过特定规则的场景：
- 路径是 /api/*
- 方法是 POST
- 用户已登录

Security → WAF → Custom rules → Create rule

规则名称：Skip API
条件：URI Path starts with /api/
操作：Skip → 选择要跳过的规则
```

> ✋ **费曼自测**：启用 Cloudflare 免费托管规则集。

---

## 番茄钟4：自定义安全规则

### 4.1 创建自定义规则

```
Security → WAF → Custom rules → Create rule

规则名称：Block Bad IPs

条件：
- Field: IP Address
- Operator: is in
- Value: 1.2.3.4, 5.6.7.8

操作：Block
```

### 4.2 常用规则模板

**规则1：拦截特定国家**

```yaml
规则名称：Block Country
条件：
- Field: Country
- Operator: is in
- Value: Country A, Country B
操作：Block
```

**规则2：保护管理后台**

```yaml
规则名称：Protect Admin
条件：
- Field: URI Path
- Operator: starts with
- Value: /admin
- AND
- Field: IP Address
- Operator: does not equal
- Value: 你的IP
操作：Block
```

**规则3：限制登录尝试**

```yaml
规则名称：Rate Limit Login
条件：
- Field: URI Path
- Operator: equals
- Value: /login
- AND
- Field: Request Method
- Operator: equals
- Value: POST
操作：Rate Limit: 5 requests / minute
```

### 4.3 规则优先级

```
规则按顺序执行：
1. 第一条匹配的规则生效
2. 后续规则不再检查

建议顺序：
1. 允许规则（白名单）
2. 拦截规则
3. 速率限制规则
```

> ✋ **费曼自测**：创建一条保护管理后台的自定义规则。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 托管规则启用成功
- [ ] 自定义规则创建完成

---

## 番茄钟5：DDoS 防护

### 5.1 DDoS 防护自动开启

```
Security → DDoS

免费套餐已包含：
- L3/L4 DDoS 防护（网络层）
- L7 DDoS 防护（应用层）

自动检测并缓解攻击
```

### 5.2 配置 L7 规则

```
Security → DDoS → HTTP DDoS Attack Protection

规则配置：
- Sensitivity level: Medium（推荐）
- 检测敏感度越高，误报风险越大
```

### 5.3 查看攻击报告

```
Security → DDOs → Overview

显示：
- 攻击次数
- 攻击类型
- 缓解流量
- 攻击来源
```

### 5.4 Bot 管理

```
Security → Bots

免费套餐功能：
- Bot Fight Mode：开启
- 识别已知的恶意机器人
- 自动拦截爬虫
```

> ✋ **费曼自测**：查看网站的安全报告。

---

## 番茄钟6：访问控制

### 6.1 IP 访问规则

```
Security → WAF → Tools → IP Access Rules

添加规则：
- IP：1.2.3.4
- 操作：Block / Challenge / Allow
- 备注：恶意IP

支持：
- 单个 IP
- IP 范围（CIDR）：192.168.1.0/24
- 国家代码：CN
```

### 6.2 用户代理规则

```
Security → WAF → Tools → User Agent Blocking

拦截特定浏览器标识：
- User Agent：包含 "badbot"
- 操作：Block
```

### 6.3 区域锁定

```
Security → WAF → Tools → Zone Lockdown

限制特定路径只允许特定 IP：
- URL: /admin/*
- IP: 你的IP
```

### 6.4 刻意练习任务

```markdown
## 安全配置任务

- [ ] 启用 DDoS 防护
- [ ] 开启 Bot Fight Mode
- [ ] 创建保护后台的规则
- [ ] 添加 IP 白名单
```

> ✋ **费曼自测**：配置 IP 访问规则白名单。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] DDoS 防护已启用
- [ ] Bot 管理已配置
- [ ] 访问控制规则生效

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**安全防护速记：**

```
安全威胁：DDoS、SQL注入、XSS、暴力破解

Cloudflare 防护：
- DDoS 防护：自动开启
- WAF 规则：托管 + 自定义
- Bot 管理：识别恶意机器人
- 访问控制：IP/UA/区域

规则操作：
- Block：拦截
- Challenge：质询
- Log：记录
```

### 7.2 配置速查

| 功能 | 位置 |
|:-----|:-----|
| WAF 规则 | Security → WAF |
| DDoS 配置 | Security → DDoS |
| Bot 管理 | Security → Bots |
| IP 规则 | Security → WAF → Tools |

### 7.3 推荐安全配置

```markdown
基础安全配置：
- [x] 启用托管 WAF 规则
- [x] 开启 DDoS 防护
- [x] 开启 Bot Fight Mode
- [x] 保护管理后台
- [x] 限制登录频率
```

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 8

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
Cloudflare 提供全面的安全防护，免费套餐已足够大多数网站。

## 关键要点

### 1. 安全威胁
- DDoS 攻击
- SQL 注入
- XSS 攻击
- 恶意爬虫

### 2. WAF 配置
- 托管规则：Cloudflare 预设
- 自定义规则：按需配置
- 规则操作：Block/Challenge/Log

### 3. 访问控制
- IP 访问规则
- User Agent 阻止
- 区域锁定

## 明日计划
- 学习性能优化
- 配置分析工具
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解安全威胁
- [ ] **番茄3-4**：配置 WAF 规则
- [ ] **番茄5-6**：配置访问控制
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 8 完成！

**今日成果：**
- ✅ 理解安全威胁类型
- ✅ 配置 WAF 规则
- ✅ 设置访问控制

**明天预告：** [[Day9-性能优化]] - 学习网站性能优化

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day7-GitHub联动]] - 上一天内容
