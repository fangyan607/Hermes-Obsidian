# Day 4：SSL/TLS 证书配置

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 HTTPS 配置，启用 SSL 证书
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 SSL/TLS 原理
🍅 番茄3-4：Cloudflare SSL 配置
🍅 番茄5-6：SSL 模式选择与实践
🍅 番茄7-8：证书管理 + 复习输出
```

---

## 番茄钟1：理解 SSL/TLS

### 1.1 用大白话理解 HTTPS

**HTTPS 是什么？**

想象你在**银行办理业务**：

| HTTP | HTTPS |
|:-----|:------|
| 在大厅大声说话 | 在私密房间谈话 |
| 别人能听到你的信息 | 信息被加密保护 |
| 不安全 | 安全 |

**HTTPS = HTTP + SSL/TLS 加密**

让浏览器和服务器之间的通信变成"私密对话"，别人无法偷听。

### 1.2 SSL/TLS 的作用

| 作用 | 说明 |
|:-----|:-----|
| **加密** | 数据传输加密，无法被窃听 |
| **认证** | 验证服务器身份，防止假冒 |
| **完整性** | 防止数据被篡改 |

### 1.3 证书类型

| 类型 | 验证级别 | 适用场景 | 费用 |
|:-----|:---------|:---------|:-----|
| **DV（域名验证）** | 仅验证域名所有权 | 个人网站、博客 | 免费 |
| **OV（组织验证）** | 验证组织身份 | 企业网站 | 付费 |
| **EV（扩展验证）** | 最严格的验证 | 银行、电商 | 付费 |

**Cloudflare 免费提供 DV 证书！**

> ✋ **费曼自测**：解释 HTTPS 相比 HTTP 的三个安全优势。

---

## 番茄钟2：SSL 握手原理

### 2.1 SSL 握手流程

```
浏览器                                服务器
  │                                    │
  │──── 1. Client Hello ─────────────→│
  │     （支持的加密套件）              │
  │                                    │
  │←─── 2. Server Hello ──────────────│
  │     （选择的加密套件 + 证书）       │
  │                                    │
  │──── 3. 验证证书 ──────────────────→│
  │                                    │
  │──── 4. 生成密钥 ──────────────────→│
  │     （用证书公钥加密）              │
  │                                    │
  │←─── 5. 确认 ───────────────────────│
  │                                    │
  │←═══ 加密通信开始 ══════════════════│
```

### 2.2 Cloudflare 的 SSL 架构

```
用户                Cloudflare               源站
  │                     │                     │
  │═══ HTTPS 加密 ═════│                     │
  │                     │←── HTTP 或 HTTPS ──→│
  │                     │   （可配置）         │
  │                     │                     │

Cloudflare 提供：
1. 边缘证书：用户 → Cloudflare
2. 源站证书：Cloudflare → 源站（可选）
```

### 2.3 证书链

```
根证书（DigiCert/Google Trust Services）
    ↓
中间证书
    ↓
你的域名证书（*.example.com）

浏览器信任根证书 → 信任中间证书 → 信任你的证书
```

> ✋ **费曼自测**：解释 Cloudflare 的双重 SSL 架构。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] HTTPS = HTTP + 加密
- [ ] SSL/TLS 提供加密、认证、完整性
- [ ] Cloudflare 免费提供 DV 证书

---

## 番茄钟3：Cloudflare SSL 配置

### 3.1 SSL/TLS 菜单

```
SSL/TLS → Overview

可以看到：
- SSL 状态
- 证书类型
- 加密模式
```

### 3.2 快速启用 HTTPS

**步骤：**

```
1. 进入 SSL/TLS → Overview
2. 加密模式选择 "Full" 或 "Full (strict)"
3. 等待证书签发（通常几分钟）
4. 访问 https://你的域名 验证
```

### 3.3 Always Use HTTPS

**强制跳转 HTTPS：**

```
SSL/TLS → Edge Certificates → Always Use HTTPS

开启后：
http://example.com → 自动跳转 → https://example.com
```

### 3.4 Automatic HTTPS Rewrites

**自动重写 HTTP 链接：**

```
SSL/TLS → Edge Certificates → Automatic HTTPS Rewrites

开启后：
页面中的 http:// 链接 → 自动改为 https://
```

> ✋ **费曼自测**：启用 Always Use HTTPS，验证 HTTP 自动跳转。

---

## 番茄钟4：SSL 模式详解

### 4.1 四种 SSL 模式

```
┌─────────────────────────────────────────────────────────────┐
│                    SSL 模式对比                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Off（关闭）                                                │
│  用户 ──HTTP──→ Cloudflare ──HTTP──→ 源站                   │
│  ❌ 不安全，不推荐                                           │
│                                                             │
│  Flexible（灵活）                                            │
│  用户 ══HTTPS══→ Cloudflare ──HTTP──→ 源站                   │
│  ⚠️ 用户到CF加密，CF到源站不加密                             │
│  适用于：源站无 SSL                                          │
│                                                             │
│  Full（完全）                                                │
│  用户 ══HTTPS══→ Cloudflare ══HTTPS══→ 源站                  │
│  ✅ 全程加密，但不验证源站证书                                │
│  适用于：源站有自签名证书                                     │
│                                                             │
│  Full (strict)（完全严格）                                   │
│  用户 ══HTTPS══→ Cloudflare ══HTTPS══→ 有效证书源站           │
│  ✅✅ 全程加密 + 验证源站证书                                 │
│  适用于：源站有有效证书（推荐）                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 模式选择指南

| 你的情况 | 推荐模式 |
|:---------|:---------|
| 源站没有 SSL | Flexible |
| 源站有自签名证书 | Full |
| 源站有有效证书 | Full (strict) ⭐ 推荐 |
| 不需要 HTTPS | Off（不推荐） |

### 4.3 配置源站证书

**如果使用 Full (strict) 模式：**

**方案1：使用 Cloudflare Origin Certificate**

```
SSL/TLS → Origin Server → Create Certificate

1. 选择有效期（15年）
2. 选择主机名（*.example.com）
3. 点击创建
4. 下载证书和私钥
5. 在源站配置证书
```

**方案2：使用 Let's Encrypt**

```bash
# 在源站服务器
sudo certbot certonly --nginx -d example.com
```

> ✋ **费曼自测**：根据你的源站情况选择正确的 SSL 模式。

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] 四种 SSL 模式各有适用场景
- [ ] Full (strict) 最安全但需要源站证书
- [ ] Always Use HTTPS 强制跳转

---

## 番茄钟5：证书管理

### 5.1 边缘证书

**Cloudflare 自动管理的证书：**

```
SSL/TLS → Edge Certificates

显示：
- 证书状态（Active/Pending）
- 证书类型（Universal/Custom）
- 有效期
- 主机名
```

### 5.2 通用证书（Universal SSL）

**免费自动签发：**

```
覆盖范围：
- example.com
- *.example.com

自动续期：
- 到期前自动续期
- 无需手动操作
```

### 5.3 自定义证书（付费）

**上传自己的证书：**

```
SSL/TLS → Edge Certificates → Upload Custom SSL Certificate

适用于：
- 需要 OV/EV 证书
- 需要特定 CA 签发
- 企业合规要求
```

### 5.4 证书验证

**验证证书状态：**

```bash
# 使用 openssl 验证
openssl s_client -connect example.com:443 -servername example.com

# 或在线工具
# https://www.ssllabs.com/ssltest/
```

> ✋ **费曼自测**：使用 SSL Labs 测试你的网站 SSL 配置。

---

## 番茄钟6：SSL 最佳实践

### 6.1 推荐配置清单

```markdown
## SSL 最佳实践配置

- [ ] SSL 模式：Full (strict)
- [ ] Always Use HTTPS：开启
- [ ] Automatic HTTPS Rewrites：开启
- [ ] Minimum TLS Version：1.2
- [ ] TLS 1.3：开启
- [ ] HSTS：开启（可选）
- [ ] Certificate Transparency：开启
```

### 6.2 HSTS 配置

**HTTP Strict Transport Security：**

```
SSL/TLS → Edge Certificates → HTTP Strict Transport Security (HSTS)

作用：
- 告诉浏览器只通过 HTTPS 访问
- 防止降级攻击

⚠️ 注意：开启后需要HTTPS才能访问，确保SSL配置正确
```

### 6.3 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|:-----|:---------|:---------|
| **证书无效** | 证书未签发完成 | 等待几分钟 |
| **混合内容警告** | 页面有 HTTP 资源 | 开启 Automatic HTTPS Rewrites |
| **重定向循环** | 源站也强制 HTTPS | 使用 Full 模式 |
| **SSL 握手失败** | 模式不匹配 | 调整 SSL 模式 |

### 6.4 刻意练习任务

```markdown
## SSL 配置任务

- [ ] 设置 SSL 模式为 Full 或 Full (strict)
- [ ] 开启 Always Use HTTPS
- [ ] 开启 Automatic HTTPS Rewrites
- [ ] 验证 HTTPS 访问正常
- [ ] 测试 HTTP 自动跳转
```

> ✋ **费曼自测**：完成 SSL 配置并通过 SSL Labs 测试。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] SSL 证书状态为 Active
- [ ] HTTPS 访问正常
- [ ] HTTP 自动跳转到 HTTPS

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**SSL/TLS 速记：**

```
HTTPS = HTTP + 加密

SSL 模式：
- Off：不加密
- Flexible：用户→CF加密，CF→源站不加密
- Full：全程加密，不验证源站证书
- Full (strict)：全程加密 + 验证证书 ⭐

推荐配置：
- Always Use HTTPS：开启
- Minimum TLS：1.2+
- TLS 1.3：开启
```

### 7.2 配置速查

| 配置项 | 位置 | 推荐值 |
|:-------|:-----|:-------|
| SSL 模式 | SSL/TLS → Overview | Full (strict) |
| Always Use HTTPS | SSL/TLS → Edge Certificates | 开启 |
| TLS 1.3 | SSL/TLS → Edge Certificates | 开启 |
| HSTS | SSL/TLS → Edge Certificates | 可选开启 |

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 4

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
HTTPS 通过 SSL/TLS 加密保护数据传输，Cloudflare 免费提供证书。

## 关键要点

### 1. SSL 模式
- Flexible：仅用户→CF加密
- Full：全程加密
- Full (strict)：最安全，验证证书

### 2. 推荐配置
- Always Use HTTPS：开启
- TLS 1.3：开启
- HSTS：可选

### 3. 证书管理
- 通用证书：免费自动签发
- 源站证书：Origin Certificate

## 明日计划
- 学习 Cloudflare Pages
- 部署静态网站
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 SSL/TLS 原理
- [ ] **番茄3-4**：完成 SSL 配置
- [ ] **番茄5-6**：掌握证书管理
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 4 完成！

**今日成果：**
- ✅ 理解 SSL/TLS 原理
- ✅ 配置 HTTPS
- ✅ 网站启用 SSL 证书

**明天预告：** [[Day5-Pages部署]] - 学习 Cloudflare Pages 静态网站部署

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day3-CDN加速]] - 上一天内容
