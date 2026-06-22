---
name: 番茄2-AI视频与多模态内容创作工具链
tags:
  - 费曼学习法
  - 番茄时钟
  - AI系统学习
  - 视频创作
  - 多模态
  - TTS
  - Remotion
created: 2026-06-09
updated: 2026-06-09
pomidoro: 2
---

# 🍅 番茄2：AI 视频与多模态内容创作工具链

> **学习主题**：Clippings 收录的 7 个视频/多模态 + 5 个辅助工具 GitHub 项目
> **学习方法**：番茄工作法（25min×2）+ 费曼学习法（教→学→补→简化）
> **预期掌握**：□ 了解 → ☑ 理解 → ☑ 应用 → □ 教授他人

---

## ⏱️ 番茄时钟规划

| 番茄钟 | 时长 | 阶段 | 目标 |
|--------|------|------|------|
| 🍅 1 | 25分钟 | 学习输入+核心提取 | 深度理解视频/多模态项目与辅助工具 |
| ☕ 休息 | 5分钟 | - | - |
| 🍅 2 | 25分钟 | 简化解释+复盘验收 | 费曼简化、建立流水线关联、查漏补缺 |

---

## 🎯 阶段一：学习输入 + 核心提取（🍅 番茄 1）

### 费曼精神：翻译能力

> "知道一个东西叫什么，和了解这个东西，是两回事。"

### 项目全景图

```
┌──────────────────────────────────────────────────────────────────┐
│                  AI 视频/多模态内容创作流水线                       │
│                                                                  │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────────────┐ │
│  │ 输入采集 │──▶│ 文本处理 │──▶│ 音频合成 │──▶│ 视频渲染/编辑   │ │
│  └─────────┘   └─────────┘   └─────────┘   └─────────────────┘ │
│       │             │             │               │              │
│  bili2text    MarkItDown    VoxCPM          video-podcast       │
│  MiniCPM-V    Pretext       CosyVoice       HyperFrames         │
│  Whisper                    Edge TTS        Clipify              │
│                                              Remotion组件库      │
└──────────────────────────────────────────────────────────────────┘
```

---

### Part A：视频创作工具链（4 个项目）

---

#### 1️⃣ video-podcast-maker — 4K 视频播客全自动生成

| 维度 | 内容 |
|------|------|
| **仓库** | `Agents365/ai-video-podcast-maker` |
| **一句话** | 从主题到 4K 视频，端到端自动生成专业视频播客，支持多平台发布 |

**核心功能**：
- **全流程自动化**：话题研究 → 脚本撰写 → 多引擎 TTS → Remotion 渲染 → 4K 输出
- **7 种 TTS 引擎**：Edge TTS（免费）、Azure Speech、火山引擎豆包、CosyVoice、ElevenLabs、Google Cloud TTS、OpenAI TTS
- **5 大平台适配**：B站/YouTube/小红书/抖音/微信视频号（独立脚本结构+标题策略+缩略图）
- **Remotion Studio 预览**：可视化编辑颜色/字体/排版，帧级时间线调试
- **偏好学习**：自动学习用户风格偏好，应用到未来视频

**配置方式**：
```bash
# 环境要求
Python 3.8+ / Node.js 18+ / FFmpeg 4.0+

# 创建 Remotion 项目
npx create-video@latest

# 配置 .env（按需选择 TTS 后端）
EDGE_TTS=enabled          # 免费
AZURE_SPEECH_KEY=xxx      # Azure
VOLCENGINE_TOKEN=xxx      # 火山引擎
```

**应用场景**：内容创作者批量制作知识分享视频、多平台一键分发

---

#### 2️⃣ HyperFrames — HTML 原生视频渲染框架

| 维度 | 内容 |
|------|------|
| **仓库** | `heygen-com/hyperframes` |
| **一句话** | 写 HTML 就能渲染视频，专为 AI 代理设计，Apache 2.0 开源 |

**核心功能**：
- **HTML 原生创作**：视频 = 带 data 属性的 HTML 文件，无需 React/构建步骤
- **AI 优先**：CLI 默认非交互，代理驱动工作流；Skills 教代理写组合+GSAP+Tailwind
- **确定性渲染**：相同输入 = 相同输出，适合自动化管线
- **Frame Adapter**：支持 GSAP/Anime.js/Lottie/CSS/Three.js/WAAPI 动画运行时
- **50+ 现成组件**：社交叠加、着色器转场、数据可视化、电影效果

**配置方式**：
```bash
# 安装技能
npx skills add heygen-com/hyperframes

# 手动创建项目
npx hyperframes init my-video

# 支持 Claude Code / Codex / Cursor / Claude Design
# 需要 Node.js >= 22, FFmpeg
```

**应用场景**：AI 代理驱动视频创作、产品介绍视频、TikTok 短视频、PDF→视频

---

#### 3️⃣ Clipify — 长视频转社交短视频

| 维度 | 内容 |
|------|------|
| **仓库** | `louisedesadeleer/clipify` |
| **一句话** | Claude Code 技能：自动发现精彩片段 + 9:16 竖屏重裁 + opus 风格逐字字幕 |

**核心功能**：
- **自动发现片段**：Whisper 转录 + 扫描妙语/反转/尴尬停顿/音频峰值，提出 3-5 个候选
- **人脸跟踪裁切**：基于嘴部+下巴运动能量判断说话者，硬切摇摄跟随
- **Opus 风格字幕**：逐字大号粗体白色 + 黄色活跃词高亮，支持 opus/karaoke/minimal 三种样式
- **纯本地运行**：无云 API、无 OpenCV，Apple Silicon 上 20 秒剪辑约 20 秒处理
- **多格式**：9:16 / 16:9 / 1:1，16:9→9:16 可选分屏或画中画

**配置方式**：
```bash
# 克隆到 Claude Code 技能目录
git clone https://github.com/louisedesadeleer/clipify.git ~/.claude/skills/clipify

# 重启 Claude Code，/clipify 即可用
# 需要 macOS + ffmpeg + whisper + Python 3 + numpy
```

**应用场景**：播客/访谈长视频转 LinkedIn/TikTok 短片段

---

#### 4️⃣ Remotion 科技视频组件库

| 维度 | 内容 |
|------|------|
| **仓库** | `liancheng-zcy/remotion-com-skills` |
| **一句话** | 面向科技区 Up 主的 Remotion 组件库，苹果风格 + 影视飓风质感 |

**核心功能**：
- **17+ 专业组件**：HeroTitle、CodeTerminal、AnimatedList、FeatureCard、MetricCard、CausalGraph、ComparisonCards、ProcessFlow、EvolutionTree、KnowledgeWeb
- **设计系统**：纯黑背景 + 苹果蓝主色、Spring 物理动画、50+ SVG 图标（禁止 emoji）
- **5 种转场**：淡入淡出、滑动、光扫、缩放模糊、幕布揭开
- **严格动画规范**：`useCurrentFrame()` + `spring()` + `interpolate()`，禁止 CSS 动画

**配置方式**：
```bash
npm install
npm run dev           # 预览
npx remotion render   # 渲染视频
```

**应用场景**：科技类视频、产品发布视频、AI 工具介绍、数据可视化

---

### Part B：多模态 AI 模型（2 个项目）

---

#### 5️⃣ MiniCPM-V / MiniCPM-o — 端侧多模态大模型

| 维度 | 内容 |
|------|------|
| **仓库** | `OpenBMB/MiniCPM-V` |
| **一句话** | 口袋级多模态大模型：1.3B 参数在手机上跑图像理解，9B 参数全双工多模态交互 |

**两个版本对比**：

| 维度 | MiniCPM-V 4.6 | MiniCPM-o 4.5 |
|------|--------------|--------------|
| 参数 | 1.3B | 9B |
| 视觉编码 | SigLIP2-400M + Qwen3.5-0.8B | SigLip2 + Qwen3-8B |
| 语音 | ❌ | ✅ Whisper-medium + CosyVoice2 |
| 实时交互 | ❌ | ✅ 全双工流式 |
| 部署 | iOS/Android/鸿蒙 | 服务端/高端设备 |
| OCR | 优秀 | 超越 GPT-5、Gemini-3 Flash |

**配置方式**：
```bash
# 快速体验
ollama run openbmb/minicpm-v4

# Python 完整安装
pip install "transformers[torch]>=5.7.0" torchvision torchcodec

# OpenAI 兼容 API 一键部署
transformers serve
```

**应用场景**：手机端实时视觉理解、OCR 文档解析、实时视频理解、全双工多模态对话

---

#### 6️⃣ VoxCPM — 无分词器多语言语音合成

| 维度 | 内容 |
|------|------|
| **仓库** | `OpenBMB/VoxCPM` |
| **一句话** | 30 种语言 + 9 种中文方言，音色设计+声音克隆+48kHz 高保真，开源语音合成 |

**核心功能**：
- **30 种语言 + 9 种中文方言**：无需语言标签，直接输入文本
- **音色设计**：用自然语言描述（性别/年龄/音色/情绪）凭空创建音色
- **可控声音克隆**：从参考音频克隆，可叠加风格指令
- **48kHz 高质量**：输入 16kHz → 输出 48kHz（AudioVAE V2 内置超分）
- **实时流式**：RTX 4090 上 RTF ~0.3（Nano-vLLM 加速后 ~0.13）

**配置方式**：
```bash
pip install voxcpm    # Python >= 3.10, PyTorch >= 2.5.0, CUDA >= 12.0

# 三种使用方式
voxcpm design "一个30岁女性，温柔语调"   # 音色设计
voxcpm clone --ref audio.wav "你好世界"  # 声音克隆
voxcpm batch input.txt output_dir/       # 批量合成
```

**应用场景**：多语言 TTS、有声书/播客制作、角色配音、声音克隆

---

### Part C：辅助工具链（5 个项目）

---

#### 7️⃣ MarkItDown — 微软文件转 Markdown 工具

| 维度 | 内容 |
|------|------|
| **仓库** | `microsoft/markitdown` |
| **一句话** | 将 PDF/PPT/Word/Excel/图片(OCR)/音频(转录)等格式统一转为 Markdown |

**核心功能**：
- 支持 PDF、PowerPoint、Word、Excel、图片(OCR)、音频(语音转录)、HTML、CSV/JSON/XML、ZIP、YouTube、EPub
- 保留文档结构（标题/列表/表格/链接）
- 插件机制（`--use-plugins`），如 `markitdown-ocr` 用 LLM Vision 做 OCR
- CLI / Python API / Docker 三种使用方式

**配置方式**：
```bash
pip install 'markitdown[all]'         # 全功能
pip install 'markitdown[pdf,docx]'    # 按需安装
```

**在流水线中的位置**：**内容输入层** — 任何文档→Markdown→喂给 AI

---

#### 8️⃣ bili2text — B 站视频转文字

| 维度 | 内容 |
|------|------|
| **仓库** | `lanbinleo/bili2text` |
| **一句话** | 输入 B 站链接，一键下载→提取音频→语音识别→输出文字稿 |

**核心功能**：
- 三种转写引擎：Whisper（本地）、SenseVoice（中文优化）、火山引擎（云端）
- CLI / Web / 桌面窗口三种使用方式
- 支持本地文件输入

**配置方式**：
```bash
git clone https://github.com/lanbinleo/bili2text
cd bili2text && uv sync
bili2text init   # 配置向导
```

**在流水线中的位置**：**B站内容入口** — 视频学习→文字笔记

---

#### 9️⃣ Pretext — 纯 JS 文本测量与布局

| 维度 | 内容 |
|------|------|
| **仓库** | `chenglou/pretext` |
| **一句话** | 无需 DOM 触发布局重排，精确计算文本高度和行信息的 JS 库 |

**核心功能**：
- 绕过 `getBoundingClientRect` 等昂贵 DOM 测量
- `prepare()` + `layout()` 快速获取段落高度
- 支持变宽行布局（文字环绕图片）
- 渲染到 DOM/Canvas/SVG

**配置方式**：
```bash
npm install @chenglou/pretext
```

**在流水线中的位置**：**排版引擎** — 视频字幕/组件文本精确布局

---

#### 🔟 Open Psychometrics — 虚构角色人格数据

| 维度 | 内容 |
|------|------|
| **仓库** | `tashapiro/open-psychometrics` |
| **一句话** | 890 个虚构角色 × 100 个宇宙的人格特质数据集 |

**核心功能**：
- 890 角色 × 400 人格问题评分
- Myers-Briggs 人格类型匹配
- 角色知名度、标准差、排名

**应用场景**：心理测量学数据分析、角色人格可视化、MBTI 匹配

---

#### 1️⃣1️⃣ 1gejiucity — 博客项目初始化

| 维度 | 内容 |
|------|------|
| **来源** | Clippings/init-1gejiucity.bat/.ps1 |
| **一句话** | Astro + Three.js + Cloudflare 技术栈的个人博客初始化脚本 |

**技术栈**：Astro + MDX + RSS + Tailwind + Three.js + Wrangler + Cloudflare Workers

**目录结构**：
```
src/content/{posts,news,columns}
src/components/{ui,three,ai}
src/pages/{posts,tags,chat,news}
n8n-workflows/    # 自动化工作流
persona-prompts/  # 人设提示词
database/migrations/  # 数据库迁移
api/              # API 接口
.github/workflows/    # CI/CD
```

---

### 核心概念提取

| 概念 | 定义（用自己的话） | 为什么重要 | 与什么相关 |
|------|-------------------|-----------|-----------|
| **端到端视频流水线** | 从主题到成品的完整自动化视频生产链 | 消除人工环节，批量生产 | video-podcast-maker |
| **HTML→视频** | 用 HTML 描述视频内容，框架负责渲染 | AI 代理最容易生成的格式就是 HTML | HyperFrames |
| **长转短剪辑** | 从长视频自动提取高光片段并适配竖屏 | 社交媒体消费的核心需求 | Clipify |
| **端侧多模态** | 在手机端运行图像/视频理解模型 | 隐私+低延迟+离线可用 | MiniCPM-V |
| **音色设计** | 用自然语言描述创造全新的声音 | 不需要参考音频就能定制声音 | VoxCPM |
| **Markdown 统一入口** | 任何格式文档→Markdown→AI 处理 | Markdown 是 LLM 的"母语" | MarkItDown |

---

## 💡 阶段二：简化解释 + 复盘验收（🍅 番茄 2）

### 费曼精神：教授他人

> "如果你不能简单地解释它，说明你还没真正理解。"

### 模拟教学：给视频创作者解释 AI 视频工具链

> **【开场】**：今天我要给你讲的是"AI 怎么帮你做视频"。
>
> **【它是什么】**：以前做视频你要自己写脚本、录声音、剪画面。现在 AI 可以帮你把整个流程串起来。
>
> **【怎么运作】**：就像一条视频工厂流水线：
>
> ```
> 📥 原料进来
>    │
>    ├── bili2text：把B站视频变成文字（学习素材）
>    ├── MarkItDown：把任何文档变成Markdown（知识素材）
>    └── MiniCPM-V：让AI看懂图片和视频（视觉理解）
>         │
>    📝 内容加工
>    │
>    ├── AI 写脚本（主题→大纲→文案）
>    └── Pretext：精确排版文字位置
>         │
>    🎙️ 声音合成
>    │
>    ├── VoxCPM：设计一个全新的声音
>    ├── Edge TTS：免费合成语音
>    └── 声音克隆：复制任何人的声音
>         │
>    🎬 视频渲染
>    │
>    ├── HyperFrames：写HTML就能出视频
>    ├── Remotion组件库：苹果风格科技视频
>    └── video-podcast-maker：全自动4K播客
>         │
>    ✂️ 后期剪辑
>    │
>    └── Clipify：长视频自动切短视频
>         │
>    📤 多平台发布
>    │
>    └── B站/YouTube/抖音/小红书/视频号
> ```
>
> **【举个例子】**：假设你要做一期"解读 AI Agent"的视频：
> 1. MarkItDown 把论文/PDF 转成 Markdown
> 2. AI 根据素材写脚本
> 3. VoxCPM 设计一个"科技感男声"
> 4. Remotion 组件库渲染苹果风格画面
> 5. video-podcast-maker 输出 4K 视频
> 6. Clipify 自动切出 3 个 TikTok 短片段
>
> **【小结】**：AI 视频工具链 = 原料采集 → 内容加工 → 声音合成 → 视频渲染 → 后期剪辑 → 多平台发布，每个环节都有专用工具。

### 技术架构关联图

```
┌─────────────────────────────────────────────────────────────────┐
│                    多平台输出层                                   │
│    B站 │ YouTube │ 小红书 │ 抖音 │ 微信视频号                     │
└────────────────────────┬────────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────────┐
│                    视频渲染/编辑层                                │
│  video-podcast-maker  │  HyperFrames  │  Clipify               │
│  (全流程4K播客)        │  (HTML→视频)  │  (长转短剪辑)           │
│                         │               │                        │
│        Remotion 科技视频组件库（17+ 专业组件）                    │
└────────────────────────┬────────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────────┐
│                    音频/多模态层                                  │
│  VoxCPM（30语言TTS）│ MiniCPM-V（端侧视觉）│ 多引擎 TTS           │
└────────────────────────┬────────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────────┐
│                    内容输入/处理层                                │
│  MarkItDown（文档→MD）│ bili2text（视频→文字）│ Pretext（排版）    │
└─────────────────────────────────────────────────────────────────┘
```

### 两条工具链的选择决策树

```
你要做什么类型的视频？
│
├── 🎙️ 播客/访谈/知识分享
│   └── video-podcast-maker（全流程自动）
│       └── 需要竖屏片段？→ Clipify
│
├── 🎬 产品介绍/营销视频
│   └── HyperFrames（HTML→视频，AI 代理友好）
│       └── 需要苹果风格？→ Remotion 组件库
│
├── 📱 短视频/TikTok
│   └── Clipify（从长视频裁切）
│   └── HyperFrames + 9:16 模板（从零生成）
│
└── 🤖 AI 全自动流水线
    └── video-podcast-maker + Clipify + 多平台分发
```

### 卡点检测

| 卡点 | 为什么卡住 | 缺少什么知识 | 如何解决 |
|------|-----------|-------------|---------|
| HyperFrames vs Remotion 区别 | 都是"写代码出视频" | HyperFrames = HTML原生(无React)，Remotion = React组件 | 选择依据：AI代理用HyperFrames，开发者用Remotion |
| MiniCPM-V vs 服务端大模型 | 端侧模型能力够吗？ | 1.3B参数在特定任务(OCR)已超越GPT-5 | 端侧擅长OCR/实时视觉，复杂推理仍需云端 |
| VoxCPM vs Edge TTS | 为什么要用 VoxCPM？ | Edge TTS 免费但不可控，VoxCPM 可音色设计+克隆 | 需要定制声音时用VoxCPM，快速免费用Edge TTS |

### 自我检测

| 维度 | 1分 | 2分 | 3分 | 4分 | 自评 |
|------|-----|-----|-----|-----|------|
| 能用简单话解释 | 只能背定义 | 能用自己的话 | 能打比方 | 能教会别人 | 3 |
| 能举例说明 | 无例子 | 1个例子 | 2-3个例子 | 随时举例 | 3 |
| 能回答追问 | 完全不行 | 能答浅层 | 能答深层 | 能举一反三 | 3 |
| 能应用到新场景 | 不行 | 需提示 | 能独立应用 | 能创新应用 | 2 |

**总分**：11 / 16 → ⚠️ 基本理解，工具链组合能力需加强

### 知识迁移测试

**场景一**：如何为知识库笔记制作讲解视频？
> MarkItDown(MD统一) → AI写脚本 → VoxCPM(定制声音) → Remotion组件库(科技风渲染) → 多平台发布

**场景二**：如何从 B 站学习视频制作自己的笔记？
> bili2text(视频→文字) → AI 整理笔记 → 保存到 Obsidian

**场景三**：如何在手机上实现实时 OCR 文档理解？
> MiniCPM-V 4.6 部署到手机 → 摄像头实时拍照 → 端侧 OCR 识别 → 结果展示

### 学习成果输出

**一句话总结**：AI 视频工具链 = 输入采集（文档/视频→文字）+ 音频合成（TTS/克隆）+ 视频渲染（HTML/React→4K）+ 后期剪辑（长→短）+ 多平台分发，六个环节各有专用工具，组合起来就是全自动视频工厂。

**下一步行动**：
- [ ] 实际使用 MarkItDown 将一份 PDF 转为 Markdown
- [ ] 试用 bili2text 提取一个 B 站视频的文字稿
- [ ] 用 Remotion 组件库渲染一个科技介绍视频片段
- [ ] 对比 HyperFrames 和 Remotion 的实际开发体验

---

## 📚 扩展资源

### 关联知识
- [[AI系统学习课/🍅番茄1-AI Agent生态与智能体工具链]] — Agent 工具链（上游）
- [[AI系统学习课/12-视觉大模型与多模态理解]] — 多模态原理
- [[AI系统学习课/5-RAG技术与应用]] — RAG 内容检索

### 源文件索引
- [[Clippings/Agents365-aivideo-podcast-maker Automated 4K video podcast creation for coding agents]]
- [[Clippings/heygen-comhyperframes Write HTML. Render video. Built for agents]]
- [[Clippings/louisedesadeleerclipify Claude Code skill turn long videos into social-ready clips]]
- [[Clippings/liancheng-zcyremotion-com-skills remotion 常用组件库 + 自定义skills]]
- [[Clippings/OpenBMBMiniCPM-V A Pocket-Sized MLLM for Ultra-Efficient Image and Video Understanding on Your Phone]]
- [[Clippings/OpenSQZMiniCPM-V-CookBook Cook up amazing multimodal AI applications effortlessly with MiniCPM-o]]
- [[Clippings/VoxCPMREADME_zh.md at main]]
- [[Clippings/microsoftmarkitdown Python tool for converting files and office documents to Markdown]]
- [[Clippings/lanbinleobili2text Bilibili视频转文字，一步到位，输入链接即可使用]]
- [[Clippings/chengloupretext Fast, accurate & comprehensive text measurement & layout]]
- [[Clippings/tashapiroopen-psychometrics Project collecting and analyzing data from the Open-Source Psychometrics Project]]

---

*创建日期：2026-06-09 | 番茄数：2 | 学习方法：番茄&费曼*
