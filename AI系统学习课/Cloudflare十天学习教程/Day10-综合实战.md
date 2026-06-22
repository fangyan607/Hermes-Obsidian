# Day 10：综合实战项目

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：完成一个完整的 Cloudflare 项目部署
> 🧠 教学方法：费曼学习法 × 刻意练习

---

## 今日学习路径

```
🍅 番茄1-2：项目规划与架构设计
🍅 番茄3-4：完整部署实践
🍅 番茄5-6：最佳实践总结
🍅 番茄7-8：问题排查 + 学习总结
```

---

## 番茄钟1：项目规划

### 1.1 项目目标

**创建一个完整的网站架构：**

```
┌─────────────────────────────────────────────────────────────┐
│                    完整网站架构                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  用户访问                                                    │
│      ↓                                                      │
│  Cloudflare DNS（解析域名）                                  │
│      ↓                                                      │
│  Cloudflare CDN（加速访问）                                  │
│      ↓                                                      │
│  Cloudflare WAF（安全防护）                                  │
│      ↓                                                      │
│  Cloudflare Pages（静态网站）                                │
│      ├── 前端：React/Vue/静态 HTML                          │
│      └── Functions：API 接口                                │
│      ↓                                                      │
│  Cloudflare Workers（后端服务）                              │
│      └── KV：数据存储                                       │
│                                                             │
│  GitHub Actions（自动部署）                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 技术栈选择

| 层级 | 技术 | 说明 |
|:-----|:-----|:-----|
| **前端** | React/Vue/Hugo | 静态网站框架 |
| **托管** | Cloudflare Pages | 免费静态托管 |
| **API** | Pages Functions | 边缘函数 |
| **存储** | KV | 键值存储 |
| **DNS** | Cloudflare DNS | 域名解析 |
| **CDN** | Cloudflare CDN | 全球加速 |
| **安全** | WAF + DDoS | 安全防护 |
| **CI/CD** | GitHub Actions | 自动部署 |

### 1.3 项目清单

```markdown
## 综合实战清单

### 基础配置
- [ ] 域名接入 Cloudflare
- [ ] DNS 记录配置
- [ ] SSL 证书启用

### 网站部署
- [ ] Pages 项目创建
- [ ] 自定义域名绑定
- [ ] 环境变量配置

### 安全防护
- [ ] WAF 规则配置
- [ ] DDoS 防护启用
- [ ] 访问控制设置

### 性能优化
- [ ] 缓存策略配置
- [ ] 性能功能开启
- [ ] 分析监控设置

### CI/CD
- [ ] GitHub 工作流配置
- [ ] 自动部署测试
```

> ✋ **费曼自测**：规划你的项目架构。

---

## 番茄钟2：部署检查清单

### 2.1 部署前检查

```markdown
## 部署前检查清单

### 域名准备
- [ ] 域名已购买
- [ ] 可以修改 NS 记录

### 代码准备
- [ ] 代码已推送到 GitHub
- [ ] 构建命令正确
- [ ] 输出目录正确

### 账号准备
- [ ] Cloudflare 账号
- [ ] GitHub 账号
- [ ] API Token 已创建
```

### 2.2 配置参数记录

```markdown
## 配置参数（请记录你的实际值）

域名：example.com
Account ID：_______________
Zone ID：_______________
API Token：_______________（不要分享）

Pages 项目名：_______________
Workers 项目名：_______________
KV 命名空间 ID：_______________
```

### 2.3 常见问题预防

| 问题 | 预防措施 |
|:-----|:---------|
| NS 未生效 | 等待 24 小时 |
| SSL 证书无效 | 等待自动签发 |
| 构建失败 | 检查构建命令和依赖 |
| 部署超时 | 减少构建复杂度 |

> ✋ **费曼自测**：检查你的部署前准备工作。

---

## 🍅 番茄钟1-2结束，休息5分钟

**核心概念回顾：**
- [ ] 完成项目架构规划
- [ ] 准备部署参数
- [ ] 了解常见问题预防

---

## 番茄钟3：完整部署流程

### 3.1 Step 1: DNS 配置

```
1. 添加域名到 Cloudflare
2. 修改 NS 记录
3. 等待生效（可能需要几分钟到24小时）
4. 验证：dig example.com NS
```

### 3.2 Step 2: Pages 部署

```
1. Workers & Pages → Create → Pages
2. 连接 GitHub 仓库
3. 配置构建设置
4. 部署
5. 绑定自定义域名
```

### 3.3 Step 3: SSL 配置

```
1. SSL/TLS → Overview
2. 选择 Full (strict) 模式
3. 开启 Always Use HTTPS
4. 验证 HTTPS 访问
```

### 3.4 Step 4: 安全配置

```
1. Security → WAF
2. 启用托管规则
3. 创建自定义规则（保护后台等）
4. 开启 Bot Fight Mode
```

### 3.5 Step 5: 性能配置

```
1. Speed → Optimization
2. 开启 Auto Minify
3. 开启 HTTP/3
4. 配置缓存规则
```

### 3.6 Step 6: CI/CD 配置

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-site
          directory: dist
```

> ✋ **费曼自测**：完成完整部署流程。

---

## 番茄钟4：验证与测试

### 4.1 功能验证

```markdown
## 验证清单

### 基础功能
- [ ] 域名可以访问
- [ ] HTTPS 正常
- [ ] HTTP 自动跳转

### 性能
- [ ] PageSpeed 分数 > 80
- [ ] 加载时间 < 3s
- [ ] 缓存命中率 > 80%

### 安全
- [ ] WAF 规则生效
- [ ] 后台访问受保护
- [ ] DDoS 防护开启

### CI/CD
- [ ] 推送代码自动部署
- [ ] 部署成功通知
- [ ] PR 预览链接
```

### 4.2 测试命令

```bash
# 测试 DNS
dig example.com

# 测试 SSL
curl -I https://example.com

# 测试响应时间
curl -w "@curl-format.txt" -o /dev/null -s https://example.com

# 测试缓存
curl -I https://example.com | grep -i "cf-cache-status"
```

### 4.3 性能测试

```
使用工具：
1. PageSpeed Insights
2. GTmetrix
3. WebPageTest

目标：
- Performance Score > 80
- LCP < 2.5s
- FID < 100ms
```

> ✋ **费曼自测**：完成所有验证测试。

---

## 🍅 番茄钟3-4结束，休息5分钟

**验证清单：**
- [ ] 完整部署流程完成
- [ ] 所有验证测试通过

---

## 番茄钟5：最佳实践总结

### 5.1 安全最佳实践

```markdown
## 安全配置最佳实践

1. SSL 模式
   - 使用 Full (strict)
   - 开启 Always Use HTTPS

2. WAF 配置
   - 启用托管规则
   - 保护管理后台
   - 限制登录频率

3. 访问控制
   - 后台 IP 白名单
   - 敏感路径保护
   - 国家访问控制（如需要）

4. 监控告警
   - 关注安全事件
   - 定期检查日志
```

### 5.2 性能最佳实践

```markdown
## 性能优化最佳实践

1. 缓存策略
   - 静态资源：缓存 1 个月
   - HTML：缓存 4 小时或动态
   - API：不缓存或短缓存

2. 代码优化
   - 使用 Auto Minify
   - 压缩图片
   - 延迟加载非关键资源

3. 边缘优化
   - 开启 HTTP/3
   - 使用 Early Hints
   - 利用 Workers 做边缘计算

4. 监控优化
   - 关注 Core Web Vitals
   - 定期性能测试
   - 分析慢请求
```

### 5.3 开发最佳实践

```markdown
## 开发流程最佳实践

1. 代码管理
   - 使用 Git 版本控制
   - 分支管理策略
   - 代码审查

2. CI/CD
   - 自动化测试
   - 自动化部署
   - 部署回滚机制

3. 环境管理
   - 区分开发/生产环境
   - 使用环境变量
   - 敏感信息用 Secrets

4. 文档维护
   - 记录架构设计
   - 更新部署文档
   - 维护问题排查指南
```

> ✋ **费曼自测**：总结你的最佳实践。

---

## 番茄钟6：问题排查指南

### 6.1 常见问题与解决

| 问题 | 排查步骤 | 解决方案 |
|:-----|:---------|:---------|
| **域名无法访问** | 1. 检查 NS 记录<br>2. 检查 DNS 记录<br>3. 检查代理状态 | 等待 NS 生效<br>添加正确的 DNS 记录 |
| **HTTPS 错误** | 1. 检查 SSL 模式<br>2. 检查源站证书 | 调整 SSL 模式<br>配置源站证书 |
| **页面空白** | 1. 检查构建输出<br>2. 检查路由配置<br>3. 检查控制台错误 | 修正构建配置<br>添加重定向规则 |
| **API 报错** | 1. 检查 Workers 代码<br>2. 检查 CORS 配置<br>3. 检查环境变量 | 修正代码<br>添加 CORS 头 |
| **缓存不生效** | 1. 检查缓存规则<br>2. 检查 Cache-Control<br>3. 检查代理状态 | 配置页面规则<br>添加缓存头 |

### 6.2 调试工具

```bash
# DNS 调试
dig example.com ANY
nslookup example.com

# 网络调试
curl -I https://example.com
curl -v https://example.com

# 查看响应头
curl -I https://example.com | grep -i "cf-"

# 检查缓存状态
# cf-cache-status: HIT = 缓存命中
# cf-cache-status: MISS = 缓存未命中
```

### 6.3 日志查看

```
Workers & Pages → 项目 → Logs

实时日志：
- 请求日志
- 错误日志
- 性能日志

Analytics → Logs
- 防火墙事件
- 安全事件
```

### 6.4 寻求帮助

| 资源 | 链接 |
|:-----|:-----|
| 官方文档 | developers.cloudflare.com |
| 社区论坛 | community.cloudflare.com |
| Discord | discord.cloudflare.com |
| 状态页面 | www.cloudflarestatus.com |

> ✋ **费曼自测**：排查一个你遇到的实际问题。

---

## 🍅 番茄钟5-6结束，休息5分钟

**核心概念回顾：**
- [ ] 掌握最佳实践
- [ ] 了解问题排查方法
- [ ] 知道如何寻求帮助

---

## 番茄钟7：十天学习总结

### 7.1 知识图谱

```
┌─────────────────────────────────────────────────────────────┐
│                    Cloudflare 知识图谱                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Day 1：基础与原理                                          │
│  ├── Cloudflare 是什么                                      │
│  ├── 边缘网络架构                                           │
│  └── 账号注册                                               │
│                                                             │
│  Day 2：DNS 配置                                            │
│  ├── DNS 记录类型                                           │
│  ├── 域名接入                                               │
│  └── 代理模式                                               │
│                                                             │
│  Day 3：CDN 加速                                            │
│  ├── 缓存原理                                               │
│  ├── 页面规则                                               │
│  └── 性能优化                                               │
│                                                             │
│  Day 4：SSL 证书                                            │
│  ├── HTTPS 原理                                             │
│  ├── SSL 模式                                               │
│  └── 证书配置                                               │
│                                                             │
│  Day 5：Pages 部署                                          │
│  ├── 静态网站托管                                           │
│  ├── 框架支持                                               │
│  └── 自定义域名                                             │
│                                                             │
│  Day 6：Workers                                             │
│  ├── 无服务器函数                                           │
│  ├── 边缘计算                                               │
│  └── KV 存储                                                │
│                                                             │
│  Day 7：GitHub 联动                                         │
│  ├── CI/CD 原理                                             │
│  ├── Actions 配置                                           │
│  └── 自动部署                                               │
│                                                             │
│  Day 8：安全防护                                            │
│  ├── WAF 配置                                               │
│  ├── DDoS 防护                                              │
│  └── 访问控制                                               │
│                                                             │
│  Day 9：性能优化                                            │
│  ├── Core Web Vitals                                        │
│  ├── 性能功能                                               │
│  └── 分析监控                                               │
│                                                             │
│  Day 10：综合实战                                           │
│  ├── 完整部署                                               │
│  ├── 最佳实践                                               │
│  └── 问题排查                                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 7.2 技能自评

| 技能 | 1-5分 | 说明 |
|:-----|:------|:-----|
| DNS 配置 | __ | |
| CDN 缓存 | __ | |
| SSL 配置 | __ | |
| Pages 部署 | __ | |
| Workers 开发 | __ | |
| CI/CD 配置 | __ | |
| 安全防护 | __ | |
| 性能优化 | __ | |

**总分 32-40：优秀 | 24-31：良好 | 16-23：及格**

### 7.3 后续学习方向

```
已掌握基础 → 进阶学习

进阶主题：
├── D1 数据库
├── R2 对象存储
├── Durable Objects
├── Queues
├── Streams
└── Analytics Engine

深度学习：
├── Workers 框架（Hono/IttyRouter）
├── 边缘 AI
├── 实时应用（WebSocket）
└── 复杂架构设计
```

---

## 番茄钟8：学习输出

### 8.1 完整学习笔记

```markdown
# Cloudflare 十天学习总结

> 学习日期：2026-06-06 至 2026-06-15
> 总学时：80个番茄钟（约34小时）

---

## 学习成果

### 已掌握技能
1. ✅ DNS 配置与域名管理
2. ✅ CDN 缓存策略配置
3. ✅ SSL/HTTPS 证书配置
4. ✅ Pages 静态网站部署
5. ✅ Workers 无服务器开发
6. ✅ GitHub Actions CI/CD
7. ✅ WAF 安全防护配置
8. ✅ 性能优化与分析

### 实战项目
- 项目名称：_______________
- 域名：_______________
- GitHub：_______________

---

## 核心知识点

### DNS
- A/AAAA/CNAME/MX 记录
- 代理模式（橙色云 vs 灰色云）

### CDN
- 缓存策略
- 页面规则
- TTL 配置

### SSL
- 四种 SSL 模式
- Always Use HTTPS

### Pages
- 静态网站部署
- 自定义域名
- Functions

### Workers
- 边缘计算
- KV 存储
- 路由配置

### CI/CD
- GitHub Actions
- 自动部署

### 安全
- WAF 规则
- DDoS 防护
- 访问控制

### 性能
- Core Web Vitals
- HTTP/3
- 分析监控

---

## 常用命令速查

| 命令 | 功能 |
|:-----|:-----|
| `dig example.com` | DNS 查询 |
| `curl -I URL` | 查看响应头 |
| `wrangler dev` | 本地开发 |
| `wrangler deploy` | 部署 Worker |

---

## 资源链接

- 官方文档：developers.cloudflare.com
- 本教程：[[AI系统学习课/Cloudflare十天学习教程/README]]

---

#Cloudflare #学习笔记
```

### 8.2 今日自检清单

- [ ] **番茄1-2**：完成项目规划和部署准备
- [ ] **番茄3-4**：完成完整部署
- [ ] **番茄5-6**：掌握最佳实践和问题排查
- [ ] **番茄7-8**：完成学习总结

---

## 🎉 恭喜！十天学习完成！

**你已掌握：**
- ✅ Cloudflare 核心原理
- ✅ DNS/CDN/SSL 配置
- ✅ Pages/Workers 开发
- ✅ CI/CD 自动部署
- ✅ 安全防护配置
- ✅ 性能优化方法

**下一步：**
1. 将所学应用到实际项目
2. 持续关注 Cloudflare 新功能
3. 分享你的学习经验

---

> **感谢完成本教程！**
>
> 相关文件：
> - [[README]] - 教程总览
> - [[Day9-性能优化]] - 上一天内容
