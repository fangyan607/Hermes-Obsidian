# Day 3：CDN 加速与缓存策略

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：掌握 CDN 缓存配置，优化网站访问速度
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：理解 CDN 和缓存原理
🍅 番茄3-4：缓存配置详解
🍅 番茄5-6：页面规则实践
🍅 番茄7-8：验证优化 + 复习输出
```

---

## 番茄钟1：理解 CDN

### 1.1 用大白话理解 CDN

**CDN 是什么？**

想象你在全国各地开**连锁店**：

| 没有 CDN | 有 CDN |
|:---------|:-------|
| 只有一个仓库在北京 | 全国各地都有仓库 |
| 上海用户要等很久 | 上海用户就近取货 |
| 仓库压力大 | 压力分散到各地 |

**CDN = 内容分发网络（Content Delivery Network）**

把你的网站内容复制到全球 310+ 个节点，用户自动访问最近的节点。

### 1.2 CDN 工作原理

```
用户请求 example.com/image.jpg
        ↓
    就近边缘节点（上海）
        ↓
    缓存检查
    ├── 有缓存 → 直接返回
    └── 无缓存 → 向源站请求 → 缓存 → 返回
```

### 1.3 Cloudflare CDN 的优势

| 特性 | 说明 |
|:-----|:-----|
| **全球节点** | 310+ 数据中心 |
| **免费流量** | 免费套餐不限流量 |
| **自动缓存** | 静态资源自动缓存 |
| **智能缓存** | 支持 Cache-Control 头 |

> ✋ **费曼自测**：用连锁店的比喻解释 CDN 的工作原理。

---

## 番茄钟2：缓存策略原理

### 2.1 什么是缓存？

**缓存 = 把内容存在边缘节点，下次直接返回**

```
第一次访问：
用户 → 边缘节点（无缓存）→ 源站 → 缓存 → 用户
      耗时较长

第二次访问：
用户 → 边缘节点（有缓存）→ 用户
      耗时极短
```

### 2.2 可缓存的内容

| 内容类型 | 是否缓存 | 原因 |
|:---------|:---------|:-----|
| 静态资源（CSS/JS/图片） | ✅ 缓存 | 内容不常变化 |
| HTML 页面 | ⚠️ 视情况 | 可能有动态内容 |
| API 响应 | ⚠️ 视情况 | 通常是动态的 |
| 用户数据 | ❌ 不缓存 | 个性化内容 |

### 2.3 缓存控制方式

**HTTP 响应头控制：**

| 头部 | 作用 | 示例 |
|:-----|:-----|:-----|
| `Cache-Control` | 控制缓存行为 | `max-age=3600` |
| `ETag` | 资源版本标识 | `"abc123"` |
| `Last-Modified` | 最后修改时间 | `Wed, 21 Oct 2025 07:28:00 GMT` |
| `Expires` | 过期时间 | `Wed, 21 Oct 2026 07:28:00 GMT` |

**Cache-Control 指令：**

| 指令 | 含义 |
|:-----|:-----|
| `max-age=3600` | 缓存 1 小时 |
| `no-cache` | 每次使用前验证 |
| `no-store` | 不缓存 |
| `public` | 可被任何缓存存储 |
| `private` | 只能被浏览器缓存 |

> ✋ **费曼自测**：什么内容适合缓存？什么不适合？

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] CDN 把内容分发到全球节点
- [ ] 缓存减少源站压力，加快访问
- [ ] 通过 HTTP 头控制缓存行为

---

## 番茄钟3：Cloudflare 缓存配置

### 3.1 缓存级别

```
Caching → Configuration → Browser Cache TTL

可选值：
- Respect Existing Headers：遵循源站设置
- No Query String：忽略查询参数
- Ignore Query String：忽略查询参数缓存
- Standard：标准缓存
- Aggressive：激进缓存（所有静态资源）
```

### 3.2 浏览器缓存 TTL

**浏览器缓存时间设置：**

| TTL 设置 | 适用场景 |
|:---------|:---------|
| 4 小时 | 频繁更新的内容 |
| 1 天 | 普通网站 |
| 1 个月 | 静态资源（CSS/JS/图片） |
| 1 年 | 版本化的静态资源 |

### 3.3 开发模式

**开发模式用途：**
- 临时绕过缓存
- 测试最新更改
- 3 小时后自动关闭

```
Caching → Configuration → Development Mode

点击 "Pause Caching" 开启
```

> ✋ **费曼自测**：配置浏览器缓存 TTL 为 1 个月。

---

## 番茄钟4：页面规则详解

### 4.1 什么是页面规则？

**页面规则 = 对特定 URL 应用特殊配置**

```
可以配置：
- 缓存级别
- 缓存 TTL
- 安全级别
- SSL 模式
- 重定向
- 等等...
```

### 4.2 创建页面规则

**示例：缓存所有图片**

```
Rules → Page Rules → Create Page Rule

URL 匹配：*.example.com/images/*

设置：
- Cache Level: Cache Everything
- Edge Cache TTL: 1 month
- Browser Cache TTL: 1 month

保存
```

### 4.3 常用页面规则模板

**规则1：缓存静态资源**

```
URL：*.example.com/static/*
- Cache Level: Cache Everything
- Edge Cache TTL: 1 month
```

**规则2：绕过管理后台缓存**

```
URL：example.com/admin/*
- Cache Level: Bypass
- Disable Performance
```

**规则3：API 不缓存**

```
URL：example.com/api/*
- Cache Level: Bypass
```

### 4.4 规则优先级

```
规则按顺序执行，先匹配的先生效

建议顺序：
1. 具体路径（如 /admin/*）
2. 通配路径（如 /api/*）
3. 全站默认（如 /*）
```

> ✋ **费曼自测**：创建一条规则，让 /api/* 路径绕过缓存。

---

## 🍅 番茄钟3-4结束，休息5分钟

**核心概念回顾：**
- [ ] 缓存 TTL 控制缓存时间
- [ ] 页面规则可以对特定 URL 应用特殊配置
- [ ] 规则按顺序执行

---

## 番茄钟5：缓存清除

### 5.1 为什么需要清除缓存？

**场景：**
- 更新了网站内容
- 缓存的还是旧内容
- 用户看到的是旧版本

**解决方案：清除缓存**

### 5.2 清除缓存方式

**方式1：清除所有缓存**

```
Caching → Configuration → Purge Everything

点击 "Purge Everything"

⚠️ 注意：会清除所有缓存，谨慎使用
```

**方式2：按 URL 清除**

```
Caching → Configuration → Custom Purge

输入要清除的 URL：
- https://example.com/page1.html
- https://example.com/images/logo.png

点击 "Purge"
```

**方式3：按标签清除（需要付费）**

```
Caching → Configuration → Purge by Cache-Tags

输入标签名，清除该标签下的所有内容
```

### 5.3 缓存清除最佳实践

| 场景 | 建议方式 |
|:-----|:---------|
| 更新单个页面 | 按 URL 清除 |
| 更新全站 | 清除所有缓存 |
| 频繁更新 | 降低 TTL 或使用版本化 URL |

> ✋ **费曼自测**：清除你网站的首页缓存。

---

## 番茄钟6：性能优化实践

### 6.1 Auto Minify

**自动压缩代码：**

```
Speed → Optimization → Auto Minify

勾选：
- CSS ✅
- JavaScript ✅
- HTML ✅

效果：减少文件体积 10-30%
```

### 6.2 Rocket Loader

**异步加载 JavaScript：**

```
Speed → Optimization → Rocket Loader

开启后效果：
- JavaScript 不阻塞渲染
- 页面加载更快

⚠️ 注意：可能与某些脚本冲突
```

### 6.3 图片优化

```
Speed → Optimization → Image Resizing

功能：
- 自动调整图片大小
- WebP 格式转换
- 响应式图片

⚠️ 注意：需要付费计划
```

### 6.4 刻意练习任务

```markdown
## 性能优化配置

- [ ] 开启 Auto Minify（CSS/JS/HTML）
- [ ] 尝试开启 Rocket Loader
- [ ] 测试页面加载速度
- [ ] 检查是否有脚本冲突
```

> ✋ **费曼自测**：配置并验证 Auto Minify 效果。

---

## 🍅 番茄钟5-6结束，休息5分钟

**验证清单：**
- [ ] 理解缓存清除的时机
- [ ] 完成性能优化配置
- [ ] 测试网站加载速度

---

## 番茄钟7：今日复习

### 7.1 核心概念回顾

**CDN 缓存速记：**

```
CDN = 全球连锁仓库
缓存 = 把内容存在边缘节点
TTL = 缓存多久
页面规则 = 对特定 URL 的特殊配置
清除缓存 = 强制更新内容
```

### 7.2 配置速查

| 配置项 | 位置 | 说明 |
|:-------|:-----|:-----|
| 缓存 TTL | Caching → Configuration | 浏览器缓存时间 |
| 页面规则 | Rules → Page Rules | 特定 URL 配置 |
| 清除缓存 | Caching → Configuration | Purge |
| Auto Minify | Speed → Optimization | 代码压缩 |

### 7.3 常用规则模板

```markdown
静态资源缓存：
URL: */static/*
- Cache Level: Cache Everything
- Edge Cache TTL: 1 month

API 绕过缓存：
URL: */api/*
- Cache Level: Bypass

管理后台绕过：
URL: */admin/*
- Cache Level: Bypass
```

---

## 番茄钟8：输出成果

### 8.1 学习笔记模板

```markdown
# Cloudflare 学习笔记 - Day 3

> 日期：2026-06-06
> 完成状态：✅

---

## 核心结论
CDN 通过全球节点缓存内容，大幅提升网站访问速度。

## 关键要点

### 1. 缓存原理
- 边缘节点存储内容副本
- 用户就近获取
- 减少 RTT 和源站压力

### 2. 缓存配置
- TTL 控制缓存时间
- 页面规则针对特定 URL
- 清除缓存强制更新

### 3. 性能优化
- Auto Minify 压缩代码
- Rocket Loader 异步加载
- 图片优化（付费）

## 明日计划
- 学习 SSL/TLS 证书配置
- 启用 HTTPS
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：理解 CDN 和缓存原理
- [ ] **番茄3-4**：完成缓存配置和页面规则
- [ ] **番茄5-6**：掌握缓存清除和性能优化
- [ ] **番茄7-8**：创建了学习笔记

---

## 🎉 Day 3 完成！

**今日成果：**
- ✅ 理解 CDN 缓存原理
- ✅ 配置缓存策略
- ✅ 优化网站性能

**明天预告：** [[Day4-SSL证书]] - 学习 HTTPS 配置

---

> **相关文件：**
> - [[README]] - 教程总览
> - [[Day2-DNS配置]] - 上一天内容
