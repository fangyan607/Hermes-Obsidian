---
created: 2026-06-25
tags:
  - "#gstack"
  - "#browse"
  - "#QA"
  - "#浏览器自动化"
  - "#测试"
  - "#番茄学习法"
  - "#五法合一"
aliases:
  - 10番茄gstack精通
  - gstack浏览器自动化教程
---

# 🎯 10番茄精通 gstack 浏览器自动化

> **结论先行（金字塔原理）：这10个番茄钟之后，你将能用 gstack browse 对任何 Web 应用执行完整的 QA 测试——从页面导航到交互验证，从快照比对到响应式检测，全部在 CLI 中完成。**
>
> **五法合一**：番茄工作法×费曼学习法×金字塔原理×刻意练习×系统思考

---

## 🔺 金字塔总纲

```
结论层：10番茄后，你是gstack browse的QA实战者
    │
    ├── 论据一：你理解gstack的哲学底层（🍅1）
    │       └── Completeness Principle + Repo Ownership Mode
    │
    ├── 论据二：你掌握了Browse的全部基本操作（🍅2-5）
    │       ├── 导航与页面加载
    │       ├── 读取与交互（click/fill/select）
    │       ├── 快照系统（snapshot -i/-a/-D）
    │       └── 断言体系（is visible/enabled/js）
    │
    ├── 论据三：你能执行完整的QA工作流（🍅6-8）
    │       ├── 用户流程测试（登录→操作→验证）
    │       ├── 部署验证与响应式测试
    │       └── 高级功能（Chain/多标签/Cookie）
    │
    └── 论据四：你能把gstack集成到开发流程中（🍅9-10）
            ├── Contributor Mode与反馈
            └── 综合实战：构建自动化QA流水线
```

## 🧠 五法说明

| 方法 | 在本教程中的角色 |
|:-----|:----------------|
| 🍅 **番茄工作法** | 每个🍅 25分钟掌握一个gstack核心能力维度 |
| 🧠 **费曼学习法** | 每个概念后用三句话自测，确保真正理解 |
| 🔺 **金字塔原理** | 每个🍅以结论先行开场，层层展开论据 |
| 🎯 **刻意练习** | 模仿→变式→创造三级循环，每个🍅都有动手练习 |
| 🔄 **系统思考** | 每个🍅结束时连接gstack全景图，看到工具生态中的位置 |

---

# PART 1：gstack哲学与Browse基础（🍅1-5）

## 🍅 1：gstack哲学——Boil the Lake & Repo Mode

### 🔺 结论先行

> **结论：gstack不是一堆零散的工具，而是一套以"完整性"为核心的方法论。理解它的哲学，比记住命令重要十倍。**
>
> 论据一：Completeness Principle——当AI让边际成本趋近于零时，永远做完整的事
> 论据二：Repo Ownership Mode——"看到问题就说出来"，主动维护而非被动执行
> 论据三：Search Before Building——先找轮子，再造轮子，三思而后造

### 🔬 论据一：Completeness Principle（烧干湖原则）

> "当AI辅助编码使边际成本接近零时，做完整的事。"

**核心思想：**
- **湖 vs 海洋**：一个"湖"是可以烧干的——100%覆盖一个模块的测试、完整实现一个功能、处理所有边界情况。"海洋"则不可烧干——重写整个系统。
- **任务估算的双尺度**：永远同时看两个时间——纯人工时间 vs AI辅助时间：

| 任务类型 | 人工团队 | CC+gstack | 压缩比 |
|:---------|:---------|:-----------|:-------|
| 脚手架搭建 | 2天 | 15分钟 | ~100x |
| 测试编写 | 1天 | 15分钟 | ~50x |
| 功能实现 | 1周 | 30分钟 | ~30x |
| Bug修复+回归 | 4小时 | 15分钟 | ~20x |

**反模式——不要这样做：**
- ❌ "选B吧，90%的价值只用更少代码"（如果A只多70行，选A）
- ❌ "边界情况先放一放"（边界处理在CC下只需几分钟）
- ❌ "测试留到后续PR"（测试是最容易烧干的湖）

> ✋ **费曼自测**：用三句话向一个同事解释"Boil the Lake"原则。第一句说它是什么，第二句说为什么重要，第三句举一个今天就能用的例子。

### 🔬 论据二：Repo Ownership Mode

```
REPO_MODE = solo | collaborative | unknown

solo → 你拥有全部代码 → 发现问题主动修复
collaborative → 多人协作 → 发现别人的问题先询问
unknown → 视为 collaborative
```

**"See Something, Say Something"——这不是口号，是工作指令。**
在任何工作流程中，如果发现异常（测试失败、废弃警告、安全告警、死代码、环境问题），必须：
- **solo模式**：修复它
- **collaborative模式**：标记它，询问归属

> ✋ **费曼自测**：你在review同事的PR时发现了一个安全问题但不在你的模块中——根据Repo Mode应该怎么做？

### 🔬 论据三：Search Before Building

三层知识搜索：
1. **Layer 1**（成熟方案）——先用已有的，不重复造轮子
2. **Layer 2**（新潮方案）——搜索确认，但保持怀疑
3. **Layer 3**（第一性原理）——最珍贵，由你对具体问题的推理产生

### 🔄 系统连接

```
gstack哲学体系：
                    Completeness Principle
                    （做事的标准）
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
    Search Before      Repo Mode      AskUserQuestion
    Building           (谁负责)       (如何决策)
    (怎么找方案)
```

gstack的哲学不是纸上谈兵——它直接决定了你接下来9个🍅中每一个操作的方式。始终保持"完整性"意识。

### 🎯 刻意练习

| 级别 | 练习 | 预期成果 |
|:-----|:-----|:---------|
| 模仿 | 通读gstack README中的哲学部分 | 能用自己的话解释Boil the Lake |
| 变式 | 找一个你最近完成的任务，用"人工时间/CC时间"双尺度重新估算 | 一张对比表 |
| 创造 | 在当前项目中识别一个"湖"（可烧干的）和一个"海洋"（不可烧干的） | 书面分析 |

---

## 🍅 2：Browse启动与导航

### 🔺 结论先行

> **结论：gstack browse 是一个持久化的 headless Chromium，通过 CLI 完全控制。理解它的"启动→导航→持久化"生命周期，是所有QA操作的前提。**
>
> 论据一：首次启动≈3秒预热，之后每命令100-200ms，30分钟空闲后自动关闭
> 论据二：浏览器状态跨命令持久的（cookies、登录、标签页均保留）
> 论据三：核心导航命令——goto/back/forward/reload

### 🔬 核心概念

**Browse的生命周期：**

```
首次 $B goto → 启动Chrome（~3s）→ 加载页面
     ↓
后续 $B 命令 → 直接使用已加载页面（100-200ms）
     ↓
30分钟无操作 → 自动关闭
```

**环境变量 `$B`：**
```bash
# $B 是 gstack browse 编译好的二进制入口
# 所有 browse 命令都通过 $B 调用
$B goto https://example.com    # 导航
$B text                        # 读页面文本
$B screenshot /tmp/page.png    # 截图
```

> ✋ **费曼自测**：gstack browse 为什么比每次启动新浏览器要快？它的持久化设计解决了什么问题？

### 🔬 核心命令组1：导航

| 命令 | 作用 | 使用场景 |
|:-----|:-----|:---------|
| `$B goto <url>` | 导航到URL | 打开待测页面 |
| `$B back` | 历史后退 | 返回上一步 |
| `$B forward` | 历史前进 | 重新进入已访问页 |
| `$B reload` | 刷新页面 | 重置状态 |
| `$B url` | 打印当前URL | 确认跳转是否正确 |

**系统思考——导航的反馈回路：**
```
goto URL → 页面加载 → 检查内容（text/snapshot）
                         │
                    ┌────┴────┐
                    │         │
               符合预期    不符合预期
                    │         │
                    │    goto 正确URL
                    │    reload 重试
                    │         │
                    └────┬────┘
                         │
                    继续测试
```

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 用 `$B goto` 打开三个网站，用 `$B url` 确认URL |
| 变式 | 在一个网站内用 `$B goto` → `$B back` → `$B forward` 模拟用户导航 |
| 创造 | 写一个bash函数 `navigate_and_verify()`，接收URL参数，导航后检查页面是否加载成功 |

---

## 🍅 3：页面读取与交互

### 🔺 结论先行

> **结论：gstack browse 提供了五种读取页面状态的方式（text/html/snapshot/accessibility/js）和五种交互方式（click/fill/select/hover/type）——覆盖了QA测试95%的场景。**

### 🔬 论据一：五维页面读取

| 命令 | 读什么 | 最适合的场景 |
|:-----|:-------|:------------|
| `$B text` | 清洗后的纯文本 | 快速确认页面内容 |
| `$B html [sel]` | HTML源码 | 检查DOM结构 |
| `$B snapshot -i` | 可交互元素的ARIA树 | 发现所有可操作的UI元素 |
| `$B accessibility` | 完整无障碍树 | 辅助功能测试 |
| `$B js "<expr>"` | JavaScript表达式 | 自定义验证 |

**核心模式——先读再动：**
```bash
# 1. 导航到页面
$B goto https://app.example.com

# 2. 用snapshot发现所有可交互元素（带@e引用编号）
$B snapshot -i
# 输出：@e1 [button] "登录"  @e2 [textbox] "用户名"  ...

# 3. 用@s ref精确操作
$B fill @e2 "admin"
$B click @e1
```

### 🔬 论据二：五种交互操作

| 命令 | 作用 | 示例 |
|:-----|:-----|:------|
| `$B click <sel>` | 点击元素 | `$B click @e3` 或 `$B click "#submit-btn"` |
| `$B fill <sel> <val>` | 填入输入框 | `$B fill @e2 "admin@test.com"` |
| `$B select <sel> <val>` | 选择下拉项 | `$B select @e4 "option2"` |
| `$B hover <sel>` | 悬浮触发 | `$B hover ".tooltip-trigger"` |
| `$B type <text>` | 在当前焦点输入 | `$B type "Hello World"` |
| `$B upload <sel> <file>` | 上传文件 | `$B upload @e5 /tmp/test.pdf` |
| `$B press <key>` | 键盘操作 | `$B press Enter` / `$B press Tab` |

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 打开一个网站，用 `snapshot -i` 发现元素，点击一个链接 |
| 变式 | 找一个搜索页面，执行完整的"fill搜索词→click搜索→验证结果"流程 |
| 创造 | 设计一个"表单填写器"脚本：读取JSON配置，自动填入目标页面 |

> ✋ **费曼自测**：`snapshot -i` 输出的@e编号有什么用？为什么比手动写CSS选择器更方便？

---

## 🍅 4：快照系统与可视化测试

### 🔺 结论先行

> **结论：gstack 的快照系统（snapshot）是QA最强大的武器——它不仅告诉你"页面长什么样"，还能精确指出"每次操作后什么变了"。**
>
> 论据一：snapshot -i 输出可交互元素树（带@e refs）
> 论据二：snapshot -D 生成前后diff（精确到每行变化）
> 论据三：snapshot -a 生成带标注的截图（红框+标签，一目了然）

### 🔬 快照命令参考

```bash
# 🔍 核心用法
$B snapshot -i              # 只看可交互元素（按钮、输入框、链接）
$B snapshot -c              # 紧凑模式（去掉空节点）
$B snapshot -d 3            # 限制层级深度
$B snapshot -s ".main"      # 限定CSS选择器范围
$B snapshot -C              # 发现所有可点击元素（含div+pointer样式）

# 🔬 diff模式——QA核心武器
$B snapshot                 # 首次：建立baseline
$B click @e3                # 操作
$B snapshot -D              # diff：只显示变化部分

# 🎨 可视化模式
$B snapshot -a              # 截图+红框标注+@e编号
$B snapshot -i -a -o /tmp/annotated.png  # 保存标注截图到文件
```

**设计思维 × 金字塔原理：快照是"原型测试"的最佳工具**
- 先建立baseline → 执行操作 → 看diff → 验证预期
- 这正是设计思维中"原型→测试→迭代"的闭环

### 🔬 核心工作流：baseline-diff-verify

```bash
# ⚡ QA黄金三角
$B goto https://app.example.com/login
$B snapshot                   # Step 1: Baseline
$B fill @e2 "admin"
$B fill @e3 "password123"
$B click @e4                  # Step 2: 操作
$B snapshot -D                # Step 3: Diff——只显示"登录后什么变了"
```

> ✋ **费曼自测**：用"拍照→做动作→再拍照→对比两张照片"的类比，解释snapshot -D的工作原理。

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 打开任意网站，执行一次完整的baseline→action→diff流程 |
| 变式 | 在同一个页面上做3次不同的操作，每次都用snapshot -D观察diff |
| 创造 | 设计一个"回归测试脚本"：10个页面操作的baseline-diff序列，自动报告差异 |

---

## 🍅 5：断言与快速检验

### 🔺 结论先行

> **结论：断言（assertions）把浏览从"手动查看"升级为"自动验证"。gstack提供了7种开箱即用的状态断言和万能JS回退。**
>
> 论据一：元素状态断言——is visible/hidden/enabled/disabled/checked/editable/focused
> 论据二：内容断言——js表达式直接验证页面文本/元素计数/属性
> 论据三：控制台断言——console --errors 确保无JS错误

### 🔬 断言体系

```bash
# 🎯 元素状态断言（返回true/false）
$B is visible ".modal"              # 元素可见？
$B is hidden ".loading-spinner"     # 元素隐藏？
$B is enabled "#submit-btn"         # 按钮可用？
$B is disabled "#submit-btn"        # 按钮禁用？
$B is checked "#agree-checkbox"     # 复选框选中？
$B is editable "#name-field"        # 输入框可编辑？
$B is focused "#search-input"       # 元素获焦？

# 🧠 JS万能断言（任何你能用JS表达的条件）
$B js "document.title.includes('Dashboard')"
$B js "document.querySelectorAll('.list-item').length === 10"
$B js "localStorage.getItem('token') !== null"

# 🚨 控制台错误检查
$B console --errors                  # 只显示error/warning级别
$B console                           # 显示全部控制台输出
```

**系统思考：断言构成QA的"平衡回路"**

```
无断言时：人工查看 → 主观判断 → 容易遗漏 → 回归时重复劳动
     ↓
有断言后：自动验证 → 客观标准 → 零遗漏 → 回归时一键执行
     ↓
       这是系统思考中的"平衡回路"——用标准化反馈控制质量
```

### 🔬 完整QA单页检查清单

```bash
# gstack browse 单页QA检查（10秒完成）
$B is visible ".page-header"       # 1. 页面正常渲染
$B js "!document.querySelector('.error-message')"  # 2. 无错误提示
$B console --errors                # 3. 控制台无JS错误
$B js "performance.getEntriesByType('navigation')[0].domComplete"  # 4. 加载完成
```

> ✋ **费曼自测**：断言和人工检查的核心区别是什么？为什么断言是"可重复的"，而人工检查不是？

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 对一个登录页面写5个断言（页面加载、表单可见、按钮状态、错误提示隐藏、标题正确） |
| 变式 | 对同一个页面在"登录前"和"登录后"各执行一组断言，观察结果变化 |
| 创造 | 设计一个通用的"页面健康度检查函数"，接收URL参数，返回10项检查的pass/fail报告 |

---

# PART 2：QA工作流与高级集成（🍅6-10）

## 🍅 6：QA工作流实战——用户流程、表单、对话框

### 🔺 结论先行

> **结论：真实世界的QA不是单页面检查，而是多步骤用户流程的端到端验证。gstack browse的持久化浏览器让多步骤流程可以像脚本一样编排。**

### 🔬 工作流一：登录流程测试

```bash
# 🚪 完整的登录→验证→登出流程
$B goto https://app.example.com/login
$B snapshot -i                          # 发现登录表单的所有元素

$B fill @e2 "testuser@example.com"      # 输入邮箱
$B fill @e3 "MyPassword123"             # 输入密码
$B click @e4                            # 点击登录按钮

# 验证：登录成功后跳转到dashboard
$B snapshot -D                          # diff显示"变化"=登录成功
$B is visible ".dashboard"              # 断言dashboard出现
$B js "localStorage.getItem('session')" # 检查session存储

# 登出
$B click "#logout-btn"
$B is visible ".login-form"            # 验证回到登录页
```

### 🔬 工作流二：表单验证测试

```bash
# 📝 表单验证"空提交→看错误→填正确→验证成功"
$B goto https://app.example.com/register
$B snapshot -i

# 空表单提交——触发验证
$B click @e5                            # 提交按钮
$B snapshot -D                          # diff显示错误信息出现
$B is visible ".error-message"          # 断言：错误提示可见

# 填入有效数据
$B fill @e2 "valid@email.com"
$B fill @e3 "StrongP@ss1"
$B fill @e4 "StrongP@ss1"
$B click @e5

# 验证成功
$B is visible ".success-toast"          # 成功提示
$B js "!document.querySelector('.error-message')"  # 无错误
```

### 🔬 工作流三：对话框处理

```bash
# ⚠️ 删除确认对话框测试
$B dialog-accept                        # 设置："遇到确认框自动接受"
$B click "#delete-item-btn"             # 触发删除→弹出确认框
                                       # (对话框被自动接受)
$B is visible ".deleted-success"        # 验证删除成功

# 另一种：对话查看模式
$B dialog-dismiss                       # 设置："遇到确认框自动拒绝"
$B click "#delete-item-btn"
$B is visible ".item-still-exists"      # 验证取消删除后项目还在
```

> ✋ **费曼自测**：用一个"ATM取款"的类比，解释用户流程测试中"前置条件→操作→验证→后置条件"的结构。

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 对一个公开网站的搜索功能执行完整的"搜索→查看结果→点击结果"流程 |
| 变式 | 对同一流程做"正向测试"（输入有效数据）和"负向测试"（输入无效数据） |
| 创造 | 设计一个"多步用户旅程"脚本：注册→登录→创建资源→编辑资源→删除资源→注销 |

---

## 🍅 7：部署验证与响应式测试

### 🔺 结论先行

> **结论：部署验证和响应式测试是QA中最容易被忽略的环节——但它们恰恰是用户第一眼看到的。gstack browse用三个命令覆盖了这两个场景。**

### 🔬 部署验证

```bash
# 🚀 部署后立即执行的验证脚本
$B goto https://yourapp.com
$B text                                # 页面渲染正常？
$B console --errors                    # 控制台无错误？
$B network                             # 网络请求全部成功？（检查有无404/500）

# 检查页面关键元素
$B is visible ".hero-section"
$B is visible ".cta-button"
$B is enabled "#get-started"

# 快速性能检查
$B perf                                # 页面加载各阶段耗时
```

### 🔬 响应式测试

```bash
# 📱 一键三屏截图
$B goto https://yourapp.com
$B responsive /tmp/layout
# 生成：/tmp/layout-mobile.png (375x812)
#       /tmp/layout-tablet.png (768x1024)
#       /tmp/layout-desktop.png (1280x720)

# 手动精确控制视口
$B viewport 375x812                     # iPhone尺寸
$B screenshot /tmp/mobile-home.png
$B viewport 1440x900                    # 桌面尺寸
$B screenshot /tmp/desktop-home.png
```

### 🔬 截图高级用法

| 命令 | 作用 | 场景 |
|:-----|:-----|:------|
| `$B screenshot /tmp/page.png` | 全页截图 | 保存证据 |
| `$B screenshot --viewport /tmp/vp.png` | 仅视口截图 | 确认首屏 |
| `$B screenshot @e3 /tmp/btn.png` | 元素截图 | 裁出按钮 |
| `$B screenshot --clip 0,0,800,600 /tmp/clip.png` | 区域截图 | 截取特定区域 |
| `$B snapshot -a -o /tmp/ann.png` | 标注截图 | 给Bug报告配图 |

**系统思考——响应式测试的杠杆点：**
在系统思考中，"移动端"和"桌面端"是用户接触你的两个杠杆点。移动端出问题 = 50%用户流失。响应式测试就是用最小的干预（一个命令）撬动最大的质量杠杆。

> ✋ **费曼自测**：部署验证的4条核心检查是什么？为什么部署验证应该在每次部署后自动执行而非人工检查？

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 对任意网站执行一次完整的部署验证检查（4条核心检查） |
| 变式 | 对同一个网站在mobile和desktop两个视口下截图，肉眼对比差异 |
| 创造 | 编写一个"一键部署验证"脚本：接收URL → 执行全部检查 → 生成HTML报告 |

---

## 🍅 8：高级功能——Cookie导入、Chain、多标签

### 🔺 结论先行

> **结论：Cookie导入解决"认证态测试"的难题，Chain命令把多步操作压缩为一次调用，多标签支持并行页面操作——这三个功能把gstack从"单页测试工具"升级为"真实世界测试平台"。**

### 🔬 Cookie导入——跳过登录，直接测试

```bash
# 🔑 从真实浏览器导入Cookie（打开交互式选择器）
$B cookie-import-browser

# 或直接导入特定域名的Cookie
$B cookie-import-browser comet --domain .github.com

# 导入后，直接访问需要认证的页面
$B goto https://github.com/settings/profile
$B snapshot -i                          # 直接看到已登录状态的页面
```

**为什么重要：** 很多QA场景不需要重复测试登录流程，直接测试"登录后"的功能更高效。

### 🔬 Chain——多步操作的原子化

```bash
# 🔗 链式命令：一次调用完成一个完整流程
echo '[
  ["goto","https://app.example.com/login"],
  ["snapshot","-i"],
  ["fill","@e2","test@test.com"],
  ["fill","@e3","password"],
  ["click","@e4"],
  ["snapshot","-D"],
  ["screenshot","/tmp/login-result.png"]
]' | $B chain
```

**优势：** 一次调用 = 7个操作的原子执行，适合写入自动化脚本。

### 🔬 多标签管理

```bash
# 📑 多标签页操作
$B tabs                                # 查看所有标签页
$B newtab https://other-app.com         # 打开新标签页
$B tab 0                                # 切回第一个标签页
$B tab 1                                # 切换到新标签
$B closetab 1                           # 关闭标签页
```

**应用场景：** 微服务架构中同时验证前端和后端管理页面。

> ✋ **费曼自测**：Cookie导入解决了QA中的什么核心痛点？Chain命令和逐条输入相比有什么优势？

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 用Chain命令重写🍅6中的登录流程（一次chain完成全部操作） |
| 变式 | 在两个标签页中分别打开不同的页面，来回切换并截图 |
| 创造 | 设计一个"认证态回归测试"：用Cookie导入登录态，执行10个需要登录的操作 |

---

## 🍅 9：贡献者模式与工作流集成

### 🔺 结论先行

> **结论：gstack不仅仅是一个工具，它是一个有反馈回路的开源生态。贡献者模式让每一个用户都能反向改进工具，工作流集成把gstack嵌入到你的日常开发中。**

### 🔬 Contributor Mode

当 `_CONTRIB = true` 时，你是gstack的用户也是改进者。

**在每个主要工作流步骤结束时：**
1. 给工具体验打分（0-10）
2. 如果不是10分，思考原因
3. 如果有可操作的改进建议→填写现场报告

**报告模板：**
```markdown
# {标题}

**我当时想做的事：** {描述}
**实际发生了什么：** {问题描述}
**我的评分：** {0-10}

## 复现步骤
1. {步骤}

## 怎样能达到10分
{一句话：gstack应该怎样做得更好}
```

### 🔬 工作流集成——gstack在你日常中的位置

```
开发流程中的gstack：
                          ┌─────────────┐
                          │  本地开发    │
                          └──────┬──────┘
                                 │
                                 ▼
                          ┌─────────────┐
                          │  PR提交审查  │ ← gstack review
                          └──────┬──────┘
                                 │
                    ┌────────────┴────────────┐
                    │                         │
                    ▼                         ▼
             ┌────────────┐          ┌────────────┐
             │  Staging    │          │  代码审查   │
             │  QA测试     │          │            │
             │ (gstack B)  │          │ /review    │
             └──────┬─────┘          └──────┬─────┘
                    │                       │
                    └──────────┬────────────┘
                               │
                               ▼
                        ┌──────────────┐
                        │   生产部署    │
                        │ (gstack验证) │
                        └──────┬───────┘
                               │
                               ▼
                        ┌──────────────┐
                        │  生产监控     │
                        │ (反馈回路)   │
                        └──────────────┘
```

**系统思考——这是一个增强回路：**
```
更多测试 → 更少Bug → 更快的发布 → 更多时间写测试 → 更多测试...
```

> ✋ **费曼自测**：什么是"贡献者模式"的现场报告？什么样的bug值得报告，什么样的不值得？

### 🎯 刻意练习

| 级别 | 练习 |
|:-----|:-----|
| 模仿 | 使用gstack browse完成一个操作后，给自己的体验打分 |
| 变式 | 如果体验不是10分，写一份现场报告（草稿即可） |
| 创造 | 画出你自己当前项目的开发流程，标出gstack可以嵌入的环节 |

---

## 🍅 10：综合实战——构建自动化QA流水线

### 🔺 结论先行

> **结论：今天最后这个🍅，我们把之前9个🍅学到的所有知识整合为一个端到端的自动化QA流水线。这是你的"毕业设计"，也是你未来工作中可以直接使用的模板。**

### 🔬 综合案例：为你的Web应用构建QA流水线

```bash
#!/bin/bash
# ========================================
# 🚀 gstack QA 自动化流水线
# 用法: ./qa-pipeline.sh <STAGING_URL>
# ========================================
set -euo pipefail

URL="${1:-https://staging.example.com}"
REPORT_DIR="./qa-report-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$REPORT_DIR"

echo "🚀 gstack QA Pipeline - $(date)"
echo "Target: $URL"
echo "Report: $REPORT_DIR"
echo "========================================"

# ─── Step 1: 页面加载与基础检查 ───
echo "📋 Step 1: 基础健康检查"
$B goto "$URL"
$B is visible "body" || { echo "FAIL: Page did not load"; exit 1; }
$B console --errors > "$REPORT_DIR/console-errors.txt"
$B perf > "$REPORT_DIR/perf.txt"
echo "✅ 页面加载成功"
echo ""

# ─── Step 2: 响应式截图 ───
echo "📋 Step 2: 响应式截图"
$B responsive "$REPORT_DIR/screenshot"
echo "✅ 截图已保存"
echo ""

# ─── Step 3: 关键元素断言 ───
echo "📋 Step 3: 关键元素检查"
$B snapshot -i > "$REPORT_DIR/interactive-elements.txt"
echo "✅ 交互元素已记录"
echo ""

# ─── Step 4: 用户流程测试 ───
echo "📋 Step 4: 核心用户流程"
echo '[
  ["goto","'"$URL"'"],
  ["snapshot","-i"],
  ["click","@e1"],
  ["snapshot","-D"],
  ["screenshot","'"$REPORT_DIR/flow-result.png"'"]
]' | $B chain
echo "✅ 用户流程测试完成"
echo ""

# ─── Step 5: 安全头检查 ───
echo "📋 Step 5: 安全头检查"
$B network > "$REPORT_DIR/network.txt"
echo "✅ 网络请求已记录"
echo ""

# ─── Step 6: 生成报告 ───
echo "📋 Step 6: 生成汇总报告"
cat > "$REPORT_DIR/summary.md" << EOF
# QA Pipeline Report

| 项目 | 状态 |
|:-----|:-----|
| 目标URL | $URL |
| 执行时间 | $(date) |
| 页面加载 | ✅ |
| Console错误 | $(wc -l < "$REPORT_DIR/console-errors.txt") 条 |
| 响应式截图 | 3张（mobile/tablet/desktop） |
| 用户流程 | ✅ |
| 网络请求 | 已记录 |

EOF

echo "========================================"
echo "✅ QA Pipeline Complete!"
echo "📁 Report: $REPORT_DIR/summary.md"
```

### 🔬 设计思维 × 金字塔原理——为什么这个流水线有效

| 设计思维阶段 | 流水线步骤 | 验证标准 |
|:------------|:-----------|:---------|
| 同理心 | 页面加载检查 | 用户第一眼看到什么？ |
| 定义 | 关键元素断言 | 核心功能是否可用？ |
| 构思 | 用户流程测试 | 用户能否完成任务？ |
| 原型 | 响应式截图 | 各种设备上表现如何？ |
| 测试 | 安全头+报告 | 是否满足非功能需求？ |

### 🧠 终极费曼：10🍅核心脉络

```
🍅1: gstack哲学——Completeness Principle + Repo Mode
     本质："做事做到完整，看到问题说出来"

🍅2: Browse启动与导航
     本质："一个持久化浏览器，用CLI完全控制"

🍅3: 页面读取与交互
     本质："5种读法+5种玩法覆盖95%的QA场景"

🍅4: 快照系统
     本质："baseline→action→diff = QA黄金三角"

🍅5: 断言体系
     本质："把'目测'升级为'自动化验证'"

🍅6: QA工作流
     本质："真实世界是多步骤的，测试也必须多步骤"

🍅7: 部署验证与响应式
     本质："用户第一眼看到的是部署后的页面"

🍅8: 高级功能
     本质："Cookie/Chain/多标签=企业级QA的标配"

🍅9: 贡献者模式
     本质："用工具的人和造工具的人之间的反馈回路"

🍅10: 综合实战
     本质："所有知识的整合=一个可运行的QA流水线"
```

---

## 📊 学习自检清单

- [ ] 🍅1: 能用三句话解释Completeness Principle和Repo Mode
- [ ] 🍅2: 能独立完成 goto→text→screenshot 的基础流程
- [ ] 🍅3: 能用snapshot -i发现元素并用click/fill操作
- [ ] 🍅4: 能用snapshot -D建立baseline-diff测试循环
- [ ] 🍅5: 能用is visible/js表达式编写自动化断言
- [ ] 🍅6: 能独立完成一个完整的用户流程测试（登录→操作→验证）
- [ ] 🍅7: 能执行部署验证4项检查和响应式3屏截图
- [ ] 🍅8: 能用Chain命令压缩多步操作，能导入Cookie
- [ ] 🍅9: 理解Contributor Mode的反馈回路
- [ ] 🍅10: 能构建一个可运行的自动化QA流水线

---

## 📚 参考知识源

| 方法 | 关联GBrain路径 |
|:-----|:--------------|
| 🍅 番茄工作法 | [[GBrain/学习方法/时间管理]] |
| 🧠 费曼学习法 | [[GBrain/学习方法/刻意练习]] |
| 🔺 金字塔原理 | [[GBrain/学习方法/金字塔原理]] |
| 🎯 刻意练习 | [[GBrain/学习方法/刻意练习]] |
| 🔄 系统思考 | [[GBrain/创造性思维/系统思考]] |
| 🎨 设计思维 | [[GBrain/创造性思维/设计思维]] |

---

> **"Boil the Lake" — 用完整性的标准要求每一个测试。**
