---
created: 2026-06-15
tags:
  - "#AI"
  - "#教程"
  - "#视频生成"
  - "#Seedance"
  - "#Sora"
  - "#多模态"
  - "#Runway"
  - "#番茄学习法"
  - "#费曼学习法"
  - "#刻意练习"
  - "#120番茄"
aliases:
  - Day22 视频生成与多模态
  - Seedance Sora 音频
  - 120番茄Day22
---

# 🍅 Day22：视频生成与多模态——Seedance / Sora / 音频（番茄106-110）

> **PART 5：主流工具与生态——侦探的武器库**
>
> 本日完结篇。从文本到图像，从图像到视频，从无声到有声——你即将掌握 AI 内容创作的完整链条。

---

## 🕵️ 悬疑开场：从文字到电影，AI 只用了三年

**2023 年**，有人问 AI："帮我画一只穿西装的猫。"

AI 画出了一只六条腿、眼睛长在耳朵上的……生物。大家都在笑。

**2024 年**，AI 已经能画出电影级的海报。Midjourney V6 让设计师开始怀疑人生。

**2025 年**，OpenAI Sora 发布了第一批视频 demo——"一只金毛在雪地里奔跑"。画质、光影、运动连贯性，完全不像 AI 生成的。导演们沉默了。

**2026 年 6 月 15 日——今天**。

Seedance 刚刚发布了 4K 60fps 视频生成功能。Runway Gen-4 支持了多场景叙事。Sora 的"世界模拟器"模式能生成一个可交互的 3D 场景。RVC 的语音克隆已经能以假乱真。

**2026 年的今天，AI 已经能导演一部完整的短片了。**

> 本日你将学到的，不是"怎么用 AI 生成一张图"——而是 **"怎么用 AI 从零到一创作一部带有画面、声音、旁白的完整视频作品。"**

**本日核心**：理解视频生成技术原理，掌握 Seedance、Sora、Runway 等主流工具的实际用法，构建完整的"文生视频+语音旁白"创作工作流。

---

## 🍅 番茄106（T1）：视频生成技术原理——扩散模型在视频上的应用

### 1.1 从图像扩散到视频扩散

要理解 AI 视频生成，先理解它的前身——**图像扩散模型**。

```
图像扩散（如 Stable Diffusion、Midjourney）：

  训练阶段：
  一张图 → 逐步加噪（破坏） → 纯噪声
                                ↓
  生成阶段：
  纯噪声 ← 逐步去噪（学习逆向） ← 文字提示+噪声开始
  
  核心机制：模型学会了"如何从噪声恢复出清晰的图像"

视频扩散：

  不再是一张图，而是一系列图（帧）
  
  挑战：
  ├─ 空间一致性：每一帧必须清晰、有细节
  ├─ 时间一致性：相邻帧必须连贯（猫不能突然消失）
  └─ 运动合理性：物体的运动必须遵循物理规律
```

**视频扩散模型的关键创新**——时空建模：

```
图像模型（2D）：            视频模型（3D）：
只看"空间"               同时看"空间+时间"

单帧的像素分布             多帧的像素分布在时间轴上的变化

卷积核：2D（高×宽）       卷积核：3D（高×宽×时间）

你描述"一只猫跳"          你描述"一只猫跳"
→ 模型生成一张静态猫图     → 模型生成从起跳到落地的全部帧
```

### 1.2 视频生成的三种技术路线

| 路线 | 代表 | 原理 | 优点 | 缺点 |
|:-----|:-----|:------|:-----|:------|
| **T2V（Text-to-Video）** | Seedance, Sora | 从文本直接生成视频 | 零门槛，描述即得 | 控制粒度较粗 |
| **I2V（Image-to-Video）** | Runway, Pika | 从起始帧/参考图生成视频 | 构图可控，风格统一 | 需要有参考图 |
| **Video-to-Video** | Runway, Deforum | 修改/风格化已有视频 | 精准控制每一帧 | 需要源视频 |

### 1.3 视频生成的核心技术挑战

**AI 视频生成至今面临三大难题**：

```
难题一：时间一致性
  问题：第1帧的猫是橘色的，第5帧就变成黑色了
  原因：模型每帧独立生成，忘了"同一只猫"
  解法：3D 注意力机制 + 时序条件注入

难题二：物理合理性
  问题：物体在空中违反重力，或者人物走路像滑冰
  原因：模型不理解物理定律
  解法：大规模真实视频训练 + 物理先验

难题三：长视频生成
  问题：生成 3 秒很好，生成 30 秒就开始"意识流"
  原因：长距离时间依赖难以建模
  解法：自回归帧生成 + 关键帧锚定
```

### 1.4 视频生成的"燃料"——数据集规模

传统 AI 模型的关系——**视频生成的数据需求远远大于文本和图像**：

| 模态 | 典型训练数据量 | 数据获取难度 |
|:-----|:--------------|:------------|
| 文本 | ~1TB（互联网文本） | 容易 |
| 图像 | ~10TB（LAION-5B, 58亿张图） | 中等 |
| 视频 | ~100TB+（YouTube 级数据） | **非常困难** |

这也是为什么视频生成起步最晚、进步最快——**壁垒不在算法，在数据**。

> ✋ **费曼自测**：用"拍照 vs 拍电影"打比方，解释为什么视频生成比图像生成难得多。

---

## 🍅 番茄107（T2）：Seedance——新兴视频生成工具

### 2.1 什么是 Seedance？

Seedance 是 2025-2026 年崛起的新兴 AI 视频生成平台，以其**高质量画面、风格多样性和易用性**快速占领市场。

**一句话定位**：**"视频生成的 Midjourney"——注重美学、上手极快、输出惊艳。**

**Seedance 的核心特点**：

| 特点 | 说明 | 为什么重要 |
|:-----|:------|:-----------|
| **4K 60fps** | 支持超高清、流畅视频输出 | 达到广播电视标准 |
| **风格控制** | 预设风格（电影、动画、写实、水墨等） | 不只有"写实"一种风格 |
| **精准提示词** | 理解复杂场景描述 | 你不需要"提示词工程" |
| **镜头控制** | 控制摄像机运动（推拉摇移跟） | 做出有"电影感"的作品 |
| **角色一致性** | 同一角色在不同场景中长相一致 | 叙事创作的基础 |

### 2.2 Seedance 的核心功能

```
Seedance 功能矩阵：

生成方式：
├─ 文生视频（Text-to-Video）—— 从描述生成完整视频
├─ 图生视频（Image-to-Video）—— 从参考图生成视频
└─ 视频编辑（Video-to-Video）—— 修改已有视频

控制能力：
├─ 提示词（Prompt）—— 描述画面内容
├─ 负面提示词（Negative Prompt）—— 排除不想要的内容
├─ 镜头语言设置—— 推/拉/摇/移/跟/升降
├─ 运动强度—— 低=静态/高=动态
├─ 风格参考—— 上传参考视频决定视觉风格

输出设置：
├─ 分辨率：720p / 1080p / 4K
├─ 帧率：24fps / 30fps / 60fps
├─ 时长：5秒 / 15秒 / 30秒 / 60秒
└─ 格式：MP4 / GIF / 帧序列
```

### 2.3 项目示例：用 Seedance 生成一段 30 秒的广告短片

**场景**：为一个新品牌咖啡——"山间晨曦"——创作一段 30 秒的产品广告。

**步骤 1：脚本构思**

```
广告脚本（30秒）：

【0-5 秒】航拍：清晨的山间，云雾缭绕，第一缕阳光照进咖啡园
【5-10 秒】特写：咖啡豆在阳光下泛着光泽，露珠滑落
【10-15 秒】转场：咖啡豆落入烘焙机，颜色从绿变棕
【15-20 秒】中景：热水冲过咖啡粉，油脂缓缓升起
【20-25 秒】特写：一杯完美的咖啡，奶泡拉花成型
【25-30 秒】产品展示：咖啡包装出现在画面中央，品牌浮现
```

**步骤 2：逐段生成 Seedance Prompt**

```markdown
片段 1（0-5s）：
Prompt: "Aerial shot of misty mountain coffee plantation at dawn, 
         golden sunlight piercing through clouds, lush green coffee trees 
         covering the hillsides, cinematic lighting, 8K quality"
镜头：无人机航拍，缓慢下降
风格：Cinematic Realism

片段 2（5-10s）：
Prompt: "Extreme close-up of fresh coffee cherries on branch, 
         morning dew drops glistening on red surface, 
         sunlight creating rainbow prism effects, macro photography"
镜头：微距特写，极慢速推近
风格：Macro Cinematic

片段 3（10-15s）：
Prompt: "Coffee beans tumbling in roaster, color changing from green 
         to rich brown, steam rising, warm amber lighting, 
         industrial aesthetic"
镜头：中景，固定机位
风格：Warm Industrial

片段 4（15-20s）：
Prompt: "Hot water pouring over freshly ground coffee, 
         bloom forming, crema rising to surface, 
         extreme detail shot, golden hour lighting"
镜头：特写，45度角俯拍
风格：Food Cinematography

片段 5（20-25s）：
Prompt: "Perfect latte art being poured, barista hand movement, 
         white milk contrast against dark espresso, 
         elegant slow motion"
镜头：中景，低角度
风格：Elegant Slow Motion

片段 6（25-30s）：
Prompt: "Coffee product packaging on wooden table, mountain sunrise 
         on label, steam rising from cup beside it, 
         brand name 'Mountain Dawn', premium product photography"
镜头：产品展示，缓慢环绕
风格：Product Photography Premium
```

**步骤 3：视频拼接 + 配乐**

```markdown
用剪映/PR 或 Seedance 内置编辑：
1. 导入 6 段生成视频
2. 添加过渡：交叉溶解（片间）
3. 配乐：轻快的原声吉他
4. 音效：鸟鸣（0-5s）、咖啡冲泡声（15-20s）
5. 结尾：品牌 Logo + Slogan
```

**步骤 4：输出**

- 导出为 4K 30fps MP4
- 可以在社交媒体、官网、展厅大屏使用

### 2.4 Seedance 实战技巧

| 技巧 | 错误做法 | 正确做法 |
|:-----|:---------|:---------|
| **提示词** | "一杯咖啡" | "一杯冒着热气的拿铁咖啡，放在木质餐桌上，清晨阳光从窗户斜射进来" |
| **镜头控制** | 不写镜头语言 | 明确指定镜头运动："缓慢推近" / "环绕拍摄" |
| **风格** | 只用"写实" | 根据场景选择："Cinematic" / "Film Noir" / "Warm Tone" / "Minimalist" |
| **运动强度** | 全部默认 | 对话场景 = 低，动作场景 = 高 |
| **角色一致** | 每次重新描述 | 使用"角色种子"功能锁定角色外貌 |

> ✋ **费曼自测**：为什么说 Seedance 是"视频界的 Midjourney"？它们有什么相似之处？

---

## 🍅 番茄108（T3）：OpenAI Sora——世界模拟器

### 3.1 什么是 Sora？

OpenAI Sora 是 2025 年发布的**视频生成模型**——但它不仅仅是一个"视频生成器"。OpenAI 称它为 **"世界模拟器"（World Simulator）**。

**为什么叫"世界模拟器"？**

```
普通视频生成模型：             Sora：
"你说什么画面，我画什么"       "你说什么世界，我模拟什么"

输入：'一只猫在沙发'          输入：'一只橘猫从沙发跳下来，
                                   踩到了地上的乐高，
                                   疼得跳起来'
输出：一只猫在沙发上的画面     
                                 输出：猫→跳→落地→踩乐高→
                                       疼→跳起（完整的物理因果链）

不懂物理                      "理解"物理
不懂因果                      "理解"因果
单一场景                      连贯叙事
```

### 3.2 Sora 的技术突破

Sora 的核心创新在于**将视频生成从"像素合成"提升到了"场景理解"**：

```
传统视频扩散模型：
文字 → 扩散过程 → 像素（pixels）
  ↑              ↑
描述画面        逐帧生成像素

Sora 的时空 Patch：
文字 → 时空 Patch → 物理世界模拟
  ↑              ↑
描述场景        建模物体、运动、光、物理
                 → 渲染为视频
```

**Sora 的独特能力**：

| 能力 | 说明 | 震撼程度 |
|:-----|:------|:---------|
| **三维一致性** | 摄像机运动时场景保持三维真实感 | ⭐⭐⭐⭐⭐ |
| **物体持久性** | 物体离开画面再回来，依然认识它 | ⭐⭐⭐⭐⭐ |
| **物理交互** | 物体间可发生真实的物理碰撞 | ⭐⭐⭐⭐ |
| **世界模拟** | 可以生成同一场景的不同视角 | ⭐⭐⭐⭐⭐ |
| **长视频生成** | 支持最长 60 秒的单次生成 | ⭐⭐⭐⭐ |
| **多模态输入** | 文本+图像+视频作为输入 | ⭐⭐⭐ |

### 3.3 项目示例：从文本描述生成电影级视频

**场景**：制作一部科幻短片的天启开场——"外星飞船降临纽约上空"。

**Step 1：场景 Prompt**

```
Prompt: 
"Alien mothership hovering over Manhattan skyline at dusk, 
massive geometric structure with organic curves, 
bioluminescent blue energy pulsing through its veins, 
smaller crafts emerging like a swarm of metallic insects, 
people on streets looking up in awe, 
Ray tracing reflections on glass buildings, 
cinematic anamorphic lens, 
vivid orange and teal color grading, 
scale feels absolutely massive"

参数：
- 时长：30秒
- 分辨率：4K
- 画面比例：16:9 宽荧幕
- 帧率：24fps（电影标准）
```

**Step 2：Sora 的"世界模拟"特性**

```
Sora 会生成一个"可探索"的场景：

1. 三维一致性：
   摄像机先俯瞰城市 → 下移到街道 → 仰拍飞船
   城市和飞船在视角变化中保持三维结构一致

2. 物体持久性：
   飞船上的发光纹路在每帧中保持一致
   小飞船从母舰飞出后持续存在，不会凭空消失

3. 物理真实性：
   飞船的阴影正确地投射在建筑物上
   反射光随着摄像机角度变化而真实变化
```

**Step 3：多次生成 + 最佳选择**

```markdown
和 ChatGPT 不同——视频生成是"概率的"。

工作流：
1. 用同一个 Prompt 生成 3-5 个版本
2. 从中选择最佳的一个
3. 对选中的版本进行扩展（Extend）：
   - 向前扩展：生成前导画面
   - 向后扩展：延续故事
4. 组合多段生成结果形成完整短片
```

### 3.4 Sora vs Seedance——怎么选？

| 对比维度 | Sora | Seedance |
|:---------|:------|:---------|
| **物理真实感** | ⭐⭐⭐⭐⭐ 领先 | ⭐⭐⭐⭐ |
| **画面美学** | ⭐⭐⭐⭐ 电影级 | ⭐⭐⭐⭐⭐ 更'好看' |
| **风格多样性** | ⭐⭐⭐ 偏写实 | ⭐⭐⭐⭐⭐ 多种风格 |
| **控制精度** | ⭐⭐⭐ 较粗 | ⭐⭐⭐⭐ 更精细 |
| **长视频能力** | ⭐⭐⭐⭐⭐ 60秒 | ⭐⭐⭐ 30秒 |
| **可访问性** | 有限开放 | 全面开放 |
| **成本** | 较高 | 中等 |

**选择指南**：
- 你需要**物理精确**（产品演示、建筑可视化）→ **Sora**
- 你需要**视觉惊艳**（广告、MV、艺术短片）→ **Seedance**
- 你要做**长篇叙事**（短片、故事）→ **Sora**
- 你要**精确控制画面**（品牌内容、电商视频）→ **Seedance**

> ✋ **费曼自测**：为什么 OpenAI 把 Sora 叫做"世界模拟器"而不是"视频生成器"？这两个名字背后的本质区别是什么？

---

## 🍅 番茄109（T4）：Runway / Pika / 音频生成——视频+音频的完整生态

### 4.1 Runway——最全能的 AI 视频工作室

Runway 是最早的 AI 视频工具之一，经过多次迭代，现在是一个**完整的 AI 视频创作工作室**。

**核心功能矩阵**：

```
Runway Gen-4 功能全景：

生成类：
├─ Text-to-Video（文生视频）
├─ Image-to-Video（图生视频）
├─ Video-to-Video（视频到视频风格迁移）
└─ Frame Interpolation（补帧，让视频更流畅）

编辑类：
├─ Inpainting（视频中移除/替换物体）
├── Background Removal └─（去除/替换视频背景）
├─ Motion Brush（用"画笔"控制运动）
├─ Camera Control（控制虚拟摄像机）
└─ Multi-Scene（多场景拼接叙事）

实用功能：
├─ 视频扩展（延长视频长度）
├─ 超分辨率（提升视频清晰度）
├─ 慢动作生成（AI 补帧实现流畅慢动作）
└─ 循环视频（生成无缝循环素材）
```

### 4.2 Pika——"视频界的 Canva"

Pika 的定位和 Runway 不同——它更像是"视频界的 Canva"：**简单、好玩、社交友好**。

| 维度 | Pika | Runway |
|:-----|:------|:-------|
| 目标用户 | 内容创作者、社交媒体运营 | 专业视频创作者、工作室 |
| 学习曲线 | 极低（5分钟上手） | 中等（需要了解视频术语） |
| 风格 | 趣味、动态、夸张 | 精致、专业、真实 |
| 特点 | 一键生成短视频、表情包、动态封面 | 精确编辑、特效合成、专业输出 |

**Pika 的杀手级功能**：

- **Modify（局部修改）**："把狗变成猫"/"换成红色背景"
- **Expand（画外扩展）**：改变视频构图，扩展画面内容
- **Animate（图片动起来）**：上传一张图 → 指定运动的区域 → 生成动态画面

### 4.3 音频生成——让视频"有声音"

视频只有画面是不够的。完整的视频创作需要**语音、音效、音乐**三个层面的音频支持。

#### 语音生成

| 工具 | 能力 | 应用场景 |
|:-----|:------|:---------|
| **ElevenLabs** | 顶级语音克隆+生成 | 旁白、角色对话、有声书 |
| **Fish Audio** | 开源语音合成 | 自定义语音、本地部署 |
| **Cosmos Voice** | 情感化语音生成 | 带情绪的旁白、广告配音 |

#### 音乐生成

| 工具 | 能力 | 应用场景 |
|:-----|:------|:---------|
| **Suno** | 完整歌曲生成（含歌词） | 广告配乐、背景音乐 |
| **Udio** | 高质量音乐生成 | 影视配乐、游戏音效 |
| **Stability Audio** | 音效+音乐生成 | 环境音效、短音频素材 |

#### RVC（Retrieval-based Voice Conversion）

RVC 是一个开源语音转换工具，可以让你用**任意人的声音说话**：

```
RVC 能做什么：
1. 上传 10 分钟的人声样本（比如你自己的声音）
2. 训练一个声音模型
3. 之后：你说任何话 → RVC 转换成你的声音

RVC 的最佳实践：
├─ 训练样本：至少 10 分钟干净的录音（无背景噪音）
├─ 采样率：48kHz（专业标准）
├─ 应用：视频旁白、配音、有声内容创作
└─ 注意：请遵守伦理规范，不要未经授权克隆他人声音
```

### 4.4 项目示例：用 Runway + RVC 实现"文生视频+语音旁白"

**场景**：制作一段 60 秒的"产品介绍视频"，包含画面 + 旁白 + 背景音乐。

**完整工作流**：

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Step 1：     │    │  Step 2：     │    │  Step 3：     │
│  写脚本       │ → │  生成画面     │ → │  生成音频     │
│              │    │              │    │              │
│  ChatGPT     │    │  Runway      │    │  ElevenLabs  │
│  写视频脚本   │    │  文生视频     │    │  生成旁白    │
│  分镜头描述   │    │  每段 10 秒  │    │              │
│              │    │              │    │  Suno        │
│              │    │              │    │  生成配乐    │
└──────────────┘    └──────────────┘    └──────┬───────┘
                                                │
                                        ┌──────▼───────┐
                                        │  Step 4：     │
                                        │  后期合成     │
                                        │              │
                                        │  剪映/PR     │
                                        │  画面+旁白    │
                                        │  +配乐+字幕   │
                                        │              │
                                        │  输出：      │
                                        │  完整视频    │
                                        └──────────────┘
```

**Step 1：脚本（ChatGPT 辅助）**

```markdown
视频脚本：智能闹钟 App "WiseWake"

[00:00-00:10] 开场
画面：深夜，手机屏幕显示 2:47 AM，一个人辗转反侧
旁白："你还在被糟糕的闹钟体验折磨吗？"
配乐：舒缓、略带疲惫的钢琴

[00:10-00:25] 问题
画面：早上闹钟响起，表情痛苦地关掉
旁白："传统闹钟只管叫你起床——不管你睡得好不好"
配乐：刺耳的闹钟声效

[00:25-00:40] 解决方案
画面：WiseWake App 界面，显示睡眠周期分析
旁白："WiseWake 会分析你的睡眠周期，在浅睡眠阶段温柔唤醒"
配乐：轻快、明亮的音乐

[00:40-00:55] 功能展示
画面：App 功能切换——智能闹钟、睡眠分析、助眠音效
旁白："智能闹钟 + 睡眠分析 + AI 助眠 ——一个 App 全部搞定"
配乐：节奏感强的背景

[00:55-01:00] 结尾
画面：App 下载页面，品牌 Logo
旁白："WiseWake —— 让每一个早晨，都刚刚好"
配乐：收尾，品牌音效
```

**Step 2：Runway 生成画面**

```markdown
场景 1 Prompt：
"Nighttime bedroom, close-up of phone screen showing 2:47 AM,
person tossing in bed, dark blue lighting, cinematic mood"

场景 2 Prompt：
"Morning alarm going off, person groggily reaching for phone,
unmade bed, harsh morning light through window"

场景 3 Prompt：
"Phone screen showing sleep analysis app, colorful charts,
green indicating deep sleep, blue indicating light sleep, UI design"

场景 4 Prompt：
"Split screen showing different app features: smart alarm, 
sleep tracking, white noise, clean modern UI design"

场景 5 Prompt：
"App download page on phone, brand logo 'WiseWake',
morning sunlight, coffee cup beside phone, optimistic mood"
```

**Step 3：音频生成**

```bash
# ElevenLabs 旁白生成（API 调用）
curl -X POST "https://api.elevenlabs.io/v1/text-to-speech/{voice_id}" \
  -H "xi-api-key: $ELEVENLABS_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "你还在被糟糕的闹钟体验折磨吗？\
            传统闹钟只管叫你起床——不管你睡得好不好。\
            WiseWake 会分析你的睡眠周期...",
    "model_id": "eleven_multilingual_v2",
    "voice_settings": {
      "stability": 0.5,
      "similarity_boost": 0.8
    }
  }' > narration.mp3

# Suno 配乐生成（Web UI）
# Prompt: "upbeat corporate background music, 60 seconds,
#           piano and light electronic, energetic but not intense"
```

**Step 4：后期合成**

```markdown
在剪映/PR 中：
1. 导入 5 段 Runway 视频
2. 导入旁白音频（对齐时间戳）
3. 添加背景音乐（音量 -20db，不压旁白）
4. 添加字幕（AI 自动生成）
5. 转场：溶解过渡
6. 色彩统一调整
7. 导出：1080p 24fps
```

**成品**：一段 60 秒、画面精美、有专业旁白和配乐的产品宣传视频。**全部由 AI 完成，零演员、零摄影、零录音棚。**

> ✋ **费曼自测**：用 RVC + ElevenLabs + Suno 的区别是什么？如果我想做一个「用我自己的声音」读稿子的视频，分别需要用到哪几个工具？

---

## 🍅 番茄110（T5）：思维导图 + 多模态 AI 全景总结

### 5.1 多模态 AI 技术栈全景思维导图

```
                        ┌─────────────────────────────┐
                        │    多模态 AI 技术栈 2026      │
                        └─────────────────────────────┘
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         │                           │                           │
    ┌────▼────┐              ┌───────▼───────┐           ┌──────▼──────┐
    │ 文字     │              │  图像/视觉     │           │  音频        │
    │ Text    │              │  Image/Vision  │           │  Audio      │
    └────┬────┘              └───────┬───────┘           └──────┬──────┘
         │                           │                          │
    ┌────┴────┐              ┌───────┴───────┐           ┌──────┴──────┐
    │ LLM     │              │ 图像生成       │           │ 语音生成    │
    │ GPT-5   │              │ Midjourney V7 │           │ ElevenLabs │
    │ Claude 4│              │ DALL-E 4      │           │ RVC        │
    │ Gemini  │              │ StableDiff-4  │           │ Cosmos     │
    └─────────┘              └───────┬───────┘           └──────┬──────┘
                                     │                          │
                            ┌────────▼────────┐         ┌───────▼──────┐
                            │   视频生成       │         │  音乐生成    │
                            │                 │         │              │
                            │  Seedance      │         │  Suno        │
                            │  Sora          │         │  Udio        │
                            │  Runway Gen-4  │         │  Stability   │
                            │  Pika          │         │  Audio       │
                            └────────┬────────┘         └──────────────┘
                                     │
                            ┌────────▼────────┐
                            │   视频编辑       │
                            │                 │
                            │  Runway Edit    │
                            │  Pika Modify    │
                            └─────────────────┘
```

### 5.2 多模态内容创作完整工作流

**从 0 到 1 的完整视频创作管线**：

```
┌─ 创意阶段 ─────────────────────────────────────┐
│ ChatGPT / Claude：写脚本、分镜头、对话文案      │
│ Midjourney / DALL-E：生成视觉参考、风格板       │
└────────────────────────────────────────────────┘
                      ↓
┌─ 视频生成阶段 ──────────────────────────────────┐
│ Seedance / Sora：生成主要视频片段                │
│ Runway：视频编辑、特效、转场                     │
│ Pika：动态封面、短视频剪辑                       │
└────────────────────────────────────────────────┘
                      ↓
┌─ 音频生成阶段 ──────────────────────────────────┐
│ ElevenLabs / RVC：旁白、角色配音                 │
│ Suno / Udio：背景音乐、主题曲                    │
│ 音效库 / AI 音效：环境音、特效音                 │
└────────────────────────────────────────────────┘
                      ↓
┌─ 后期合成阶段 ──────────────────────────────────┐
│ 剪映 / PR / DaVinci：画面+音频+字幕合成          │
│ CapCut / Canva：快速剪辑+调整+输出               │
└────────────────────────────────────────────────┘
                      ↓
                    🎬 完成作品
```

### 5.3 工具选择速查表

| 你要做什么 | 工具 | 一句话理由 |
|:-----------|:-----|:-----------|
| **文生视频（电影级）** | Sora | 世界模拟，物理真实 |
| **文生视频（广告级）** | Seedance | 美学优先，风格多样 |
| **图生视频** | Runway | 功能最全，控制最精细 |
| **短视频/动态封面** | Pika | 一键生成，社交友好 |
| **视频编辑/特效** | Runway | 涂抹移除、背景替换 |
| **语音旁白** | ElevenLabs | 音质最佳，多语言 |
| **语音克隆** | RVC | 开源，可本地运行 |
| **背景音乐** | Suno | 歌词+旋律，一次生成 |
| **音效** | Stability Audio | 高质量短音效 |

### 5.4 PART 5 总结 —— 你的武器库已备齐

Day20 到 Day22，你完成了 **PART 5：主流工具与生态**的学习：

| Day | 核心收获 | 你的新能力 |
|:----|:---------|:-----------|
| **Day20** | 编程 Agent | 让 AI 自主写代码、修 bug、提 PR |
| **Day21** | 自动化与 MCP | 让 AI 连接一切工具，搭建工作流 |
| **Day22** | 多模态生成 | 让 AI 生成视频+配音+音乐，完整创作 |

**你的"侦探武器库"现在包含了**：

```
├─ 编程武器：Claude Code / Cursor / Codex / Aider
├─ 连接武器：MCP 协议 / n8n / OpenClaw
├─ 应用武器：Dify / Coze
├─ 视频武器：Seedance / Sora / Runway / Pika
├─ 音频武器：ElevenLabs / RVC / Suno
└─ 核心心法：Loop Engineering / Agent 架构
```

### 5.5 从"用户"到"创作者"——最后一步

2023 年的 AI 使用者，只会"问 AI 问题"。
2024 年的 AI 使用者，学会了"让 AI 画图"。
2025 年的 AI 使用者，学会了"让 AI 写代码"。
**2026 年的 AI 创作者**——你——已经学会了如何**让 AI 为你完成一整套完整的产品**。

从下一站开始 —— **Day23 和 Day24** —— 你将把它们全部结合起来，完成一次真正的"超级侦探"实战。

---

> ✋ **费曼自测**：将今天学到的多模态 AI 知识整理成一张"思维导图"，然后讲给一个非技术朋友听——"2026 年的 AI 能创作一部短片——从写剧本到生成画面到配音配乐——全部由 AI 完成。"

---

## 📌 刻意练习

### 练习1（模仿）：用 Seedance 生成一段 15 秒产品视频
1. 选择一个你熟悉的产品（手机 App、咖啡、一本书……都行）
2. 写一段 3 个镜头的视频描述
3. 用 Seedance 逐段生成
4. 拼接成完整视频

### 练习2（变式）：用 ElevenLabs + Suno 为视频配音
1. 基于练习1的视频
2. 用 ElevenLabs 生成一段 30 秒的旁白文案
3. 用 Suno 生成一段 30 秒的背景音乐
4. 在剪映中合成画面 + 旁白 + 配乐

### 练习3（创造）：对比不同视频工具的差异
选择同一个提示词，分别在 Seedance、Sora、Runway 上生成：

```markdown
提示词（通用）：
"A person walking through a futuristic city at night,
neon lights reflecting on wet pavement,
flying vehicles in the distance,
cinematic cyberpunk atmosphere"

对比维度：
1. 画面美学：哪个最好看？
2. 运动连贯性：哪个最流畅？
3. 物理真实性：哪个最合理？
4. 提示词理解：哪个最接近你想要的？

输出：一份简洁的对比报告
```

---

## 🔗 关联知识

- [[AI系统学习课/🍅120番茄从入门到精通AI/Day20-编程Agent——Claude Code-Codex-Cursor]] — 编程 Agent 是 AI 的"手"
- [[AI系统学习课/🍅120番茄从入门到精通AI/Day21-OpenClaw-n8n-MCP创意工具与自动化]] — 自动化是 AI 的"神经系统"
- [[书库/人工智能/AIGC：智能创作时代]] — AI 内容创作全景
- [[AI系统学习课/🍅番茄2-AI视频与多模态内容创作工具链]] — 视频创作工具链深度解析

---

*创建日期：2026-06-15 | 番茄数：5（106-110）| 学习方法：番茄&费曼*
