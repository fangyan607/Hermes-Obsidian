---
created: 2026-06-20
module: B
title: 材质渲染与UV烘培
pomodoros: 5
tags:
  - 教程
  - Blender
  - 材质
  - UV
  - 渲染
  - Cycles
  - EEVEE
  - 烘培
  - 番茄费曼
related:
  - "[[AI系统学习课/40番茄速通Blender教程/README.md]]"
  - "[[AI系统学习课/40番茄速通Blender教程/模块A-硬表面建模与修改器]]"
  - "[[AI系统学习课/40番茄速通Blender教程/模块C-几何节点与雕刻]]"
---

# 模块B：材质渲染与UV烘培

> **核心目标**：从零掌握 Blender 材质节点、UV展开、灯光系统、Cycles/EEVEE 渲染和 UV 烘培全流程。学完本模块，你能让任何模型拥有真实质感和专业级渲染输出。

---

## 🍅11 材质节点系统入门（25分钟）

### 费曼输入（概念解释）

**什么是节点系统？**
节点系统是一种可视化编程方式——每个"节点"代表一个操作或数据，通过"连线"定义数据和效果的流动路径。在 Blender 中，材质节点将数学运算、颜色调整、纹理贴图和最终着色连接成一个"配方"。

**着色器编辑器（Shader Editor）布局**：
- 按 `Shader Editor` 标签进入
- 顶部工具栏：节点类型筛选（材质/灯光/世界/物体）
- 主编辑区：节点画布（鼠标中键平移，滚轮缩放）
- 右侧属性面板（N键切换显示）

**Principled BSDF 节点详解**：
这是 Blender 的核心材质节点，基于物理渲染(PBR)标准，一个节点能调出90%以上的材质效果：

| 参数 | 作用 | 常见取值 |
|:-----|:-----|:---------|
| Base Color | 基础色（漫反射颜色） | RGB 色值 |
| Metallic | 金属度（0=非金属，1=金属） | 0.0 ~ 1.0 |
| Roughness | 粗糙度（0=镜面，1=粗糙） | 0.0 ~ 1.0 |
| Normal | 法线贴图输入 | 连接 Normal Map 节点 |
| Alpha | 透明通道 | 0.0=全透，1.0=不透明 |
| Emission | 自发光颜色/强度 | 颜色+强度值 |
| Transmission | 透射（透明材质） | 0.0~1.0 |
| IOR | 折射率（玻璃/水等） | 空气1.0，水1.33，玻璃1.45 |
| Clearcoat | 清漆层强度 | 0.0~1.0 |

**基础材质类型速查**：

- 纯色材质：Principled BSDF → 改 Base Color → 输出
- 金属材质：Metallic=1.0 + Roughness=0.2（+Base Color 选金属色）
- 玻璃材质：Transmission=1.0 + IOR=1.45 + Roughness=0.0
- 自发光材质：Emission Strength > 0，Base Color 变黑
- 半透明材质：Transmission=0.5 + Alpha < 1.0

### 刻意练习（具体操作步骤）

**练习1：从零创建一个木纹材质**

1. 新建一个立方体（`Shift+A → Mesh → Cube`）
2. 切换 Shader Editor 工作区
3. 选中默认的 Principled BSDF 节点
4. `Shift+A → Texture → Image Texture` 添加贴图节点
5. 在 Image Texture 中点击 Open → 选择木纹图片（或新建一个格子纹理）
6. 将 Image Texture 的 Color（黄色圆点）连接到 Principled BSDF 的 Base Color
7. 再添加一个 `Shift+A → Converter → Color Ramp`
8. 把 Image Texture Color 连到 Color Ramp 的 Fac（系数）
9. Color Ramp Color 连到 Principled BSDF 的 Roughness
10. 调整 Color Ramp 的滑块：左=暗色(粗糙)，右=亮色(光滑)
11. 在 3D 视图中按 `Z → Material Preview` 查看效果

**练习2：创建玻璃杯材质**

1. Principled BSDF：Transmission=1.0, IOR=1.45, Roughness=0.0
2. `Shift+A → Input → Layer Weight` → 把 Fresnel 连到 Fac
3. `Shift+A → Color → Mix` → 混合两种颜色增强折射效果
4. 切换到 Cycles 渲染预览查看真实玻璃效果

**常用快捷键**：
- `Ctrl+Shift+点击节点`：查看该节点的上游连接
- `Ctrl+G`：选中节点打包为组
- `Tab`：进入/退出节点组编辑
- `M`：静音节点（临时禁用）
- `Ctrl+X`：删除节点同时保持连线

### ✅ 完成标准

- [ ] 能说出 Principled BSDF 至少6个参数的含义和用途
- [ ] 独立完成纯色/金属/玻璃三种材质的节点搭建
- [ ] 能正确添加 Image Texture 节点并连接到材质
- [ ] 能用 Color Ramp 控制粗糙度变化（木纹材质）
- [ ] 能在 Shader Editor 中熟练操作（添加节点/连线/删除/分组）

### 📖 费曼三句话

1. 材质节点像"配方"——每个节点是一个步骤，连线是操作顺序，Principled BSDF 是最终出锅的菜品
2. Principled BSDF 一个节点能调出90%的材质效果，学会它就掌握了 Blender 材质的核心
3. Image Texture 节点是把图片贴到模型上的桥梁，Color Ramp 是调节贴图影响的调色板

---

## 🍅12 UV展开与贴图（25分钟）

### 费曼输入（概念解释）

**什么是 UV？**
UV 是把三维模型的表面"展开"成二维平面的坐标系统。U 对应水平方向，V 对应垂直方向（就像 2D 贴图的 XY）。没有 UV 展开，贴图就不知道怎么包在模型上。

**UV 编辑界面**：
- 切换编辑器为 `UV Editing` 布局（上方 UV Editor，下方 3D Viewport）
- 或在现有布局中把编辑器类型改为 `UV Editor`

**UV 展开核心流程**：
```
Edit Mode → 选面 → 标记缝合边(Mark Seam) → Unwrap → UV Editor调整
```

**缝合边（Seam）** 标记：
- 告诉 Blender "从哪里剪开"来展平表面
- 原则：藏在看不见的位置（模型背面、底部、接缝处等）
- 选中边 → `Ctrl+E → Mark Seam`（标记）/ `Clear Seam`（清除）

**五种展开方法对比**：

| 方法 | 触发 | 适用场景 | 优缺点 |
|:-----|:-----|:---------|:-------|
| Smart UV Project | `U → Smart UV Project` | 硬表面/机械模型 | 自动快速，但利用率一般 |
| Unwrap | `U → Unwrap` | 配合缝合边的精确展开 | 需要手动标记缝合边 |
| Cylinder Projection | `U → Cylinder Projection` | 柱体/瓶子 | 侧边展开，顶底分离 |
| Sphere Projection | `U → Sphere Projection` | 球体/人头 | 极点拉伸较大 |
| Follow Active Quads | `U → Follow Active Quads` | 四边面连续展开 | 保持四边形比例 |
| Minimum Stretch (SLIM) | `U → Minimum Stretch` | **Blender 5.1 新增** | 最小拉伸算法，效果更好 |

**检测 UV 拉伸**：
- 在 UV Editor 中勾选 `Display → Stretch`（显示拉伸）
- 蓝色=无拉伸，绿色=轻微，红色=严重
- 或者用棋盘格纹理（Checker Texture）直接看模型表面格子是否变形

**UV 排列原则**：
1. 充分利用 0~1 空间（UV 方块），不要浪费
2. 不同 UV 岛（Island）不重叠
3. 保持合适的纹理密度（Texel Density）——大面多占空间
4. 重要区域（面部/细节）分配更多 UV 空间

**UV 导出与外部绘制**：
- UV Editor → `UV → Export UV Layout`
- 导出为 PNG（可带黑色轮廓线）
- 在 Photoshop/Procreate/Krita 中绘制贴图
- 保存后回到 Blender Image Texture 加载

### 刻意练习（具体操作步骤）

**练习：给一个圆柱体做 UV 展开**

1. `Shift+A → Mesh → Cylinder`，16顶点
2. Tab 进入 Edit Mode，`3` 面选择模式
3. 选中顶部一圈边 → `Ctrl+E → Mark Seam`
4. 选中底部一圈边 → `Ctrl+E → Mark Seam`
5. 选中侧面一条纵向边 → `Ctrl+E → Mark Seam`
6. 按 `U → Unwrap`
7. UV Editor 中查看展开结果：顶部和底部为圆形，侧面为矩形
8. `Shift+A → Texture → Checker Texture`（或加载 UV 格子图）
9. 连接到 Principled BSDF Base Color，观察格子是否均匀

**棋盘格纹理制作方法**：
```
Shader Editor 中：
Shift+A → Texture → Checker Texture
    → Color1=白，Color2=黑，Scale=10
    → Color 输出连到 Principled BSDF Base Color
```

**Blender 5.1 新增 SLIM 展开体验**：
1. 选择一个复杂的模型（如 Suzanne 猴头）
2. 标记基本缝合边（耳朵后、下巴底、头顶）
3. `U → Minimum Stretch` 体验 SLIM 算法
4. 对比 Smart UV Project 和 SLIM 的拉伸情况

### ✅ 完成标准

- [ ] 理解 UV 的概念——3D 到 2D 的映射
- [ ] 能独立完成"标记缝合边 → Unwrap"的全流程
- [ ] 会用 Checker Texture 检查 UV 拉伸
- [ ] 知道至少3种展开方法及其适用场景
- [ ] 能在 UV Editor 中移动/旋转/缩放 UV 岛
- [ ] 能导出 UV Layout 到外部软件（知道流程即可）

### 📖 费曼三句话

1. UV 展开 = 给3D模型"剥皮"，把立体的表面展平成一张2D地图，为贴图做准备
2. 缝合边标记决定了展开的效果——要藏在看不见的地方（背后/底部/接缝处），就像衣服的拉链
3. 棋盘格纹理是检查 UV 拉伸的最快方法——格子变形成椭圆就说明那里拉伸了

---

## 🍅13 灯光系统与HDRI（25分钟）

### 费曼输入（概念解释）

**Blender 四种灯光类型**：

```
Point (点光源)     ● 从一点向四周发光    → 灯泡/蜡烛
Sun (太阳光)       ☀ 平行光，无衰减      → 日光/月光
Spot (聚光灯)      🔦 锥形光束           → 手电筒/舞台灯
Area (面光源)      █ 矩形面发光          → 柔光箱/窗户
```

**灯光核心参数**：
- **Power**（强度）：以瓦特为单位的物理强度
- **Color**（颜色）：光线颜色，可用色温 Blackbody 节点模拟真实光源
- **Radius/Angle**（尺寸）：越大阴影越柔和（模拟柔光箱效果）
- **Contact Shadow**（接触阴影）：物体与地面接触处的细节阴影

**三点布光法**——最快提升画面质量的技巧：

```
        Rim Light (轮廓光)
             ↑
             │
    Key Light →→→ ● ←←← Fill Light
    (主光)     物体   (补光)
             │
             ↓
           Camera
```

| 灯光 | 位置 | 强度 | 作用 |
|:-----|:-----|:----|:-----|
| **Key Light**（主光） | 相机左侧/右侧45°，略高于物体 | 最强（~1000W） | 决定画面主影调 |
| **Fill Light**（补光） | 相机另一侧 | 主光的1/4~1/2 | 补充阴影细节 |
| **Rim Light**（轮廓光） | 物体背后上方 | 与主光相近 | 勾勒边缘，分离前景背景 |

**HDRI 环境贴图**：
- HDRI = High Dynamic Range Image（高动态范围图像）
- 提供真实世界的环境光照 + 反射 + 背景
- **Poly Haven**（polyhaven.com）下载免费高质量 HDRI
- 在 World 节点中使用 Environment Texture 加载

### 刻意练习（具体操作步骤）

**练习1：四点布光产品展示**

1. 创建一个场景：桌面平面 + 中心物体（如 Suzanne 猴头）
2. 添加主光：
   - `Shift+A → Light → Area`
   - 位置：相机左侧45°，略高于物体
   - Power=300W，Size=0.3m（柔化阴影）
3. 添加补光：
   - 复制主光（`Shift+D`），移到相机另一侧
   - Power=100W（主光的1/3）
4. 添加轮廓光：
   - 复制主光移到物体背后上方
   - Power=200W
5. 添加背景光（可选）：
   - 在物体背后下方打一个低角度暖光

**练习2：HDRI 环境光照设置**

1. 切换到 Shader Editor
2. 顶部切换为 World 模式（球体图标）
3. 默认有一个 Surface 节点组
4. 删除默认节点，构建新的 World 材质：
   ```
   Shift+A → Texture → Environment Texture → Open → 选 HDRI(.hdr)
       ↓ Color 输出
   Shift+A → Shader → Background → Strength=1.0
       ↓
   World Output → Surface
   ```
5. 或在 World Properties（红色地球图标）→ Color 旁小圆点 → Environment Texture
6. 在 3D 视图按 `Z → Rendered` 查看 HDRI 效果
7. 调整 Background 节点的 Strength 控制亮度
8. 按 `N → View Tab`（视图选项卡）→ 调整 HDRI 旋转角度

**练习3：混合灯光——HDRI + 三点布光**

1. 先设置 HDRI 作为环境基础光（Strength=0.3~0.5）
2. 再加三点布光增强主体表现
3. 主光用暖色（5500K），补光用冷色（6500K）制造冷暖对比
4. 观察 HDRI 在物体表面的反射效果

**Blender 5.1 灯光改进**：
- EEVEE 灯光贴图（Light Probes）性能优化
- Cycles 灯光树采样改进，减少噪点

### ✅ 完成标准

- [ ] 能说出四种灯光类型及其典型应用场景
- [ ] 独立完成三点布光设置（主光+补光+轮廓光）
- [ ] 能正确加载 HDRI 进行环境光照
- [ ] 理解灯光强度、颜色、大小对阴影的影响
- [ ] 能结合 HDRI 和手打灯光获得更好的渲染效果
- [ ] 冷暖对比布光至少体验一次

### 📖 费曼三句话

1. 灯光决定了渲染的"质感"——模型再好，灯光不行就出不了好图，这是新手和专业人士的最大差距
2. 三点布光法是最快提升画面质量的技巧：主光定调、补光柔化、轮廓光分离
3. HDRI 提供真实世界的环境光照，一键提升渲染真实感——相当于给场景拍了一张"光照快照"

---

## 🍅14 Cycles 与 EEVEE 渲染器（25分钟）

### 费曼输入（概念解释）

**两大渲染器对比**：

| 特性 | Cycles | EEVEE |
|:-----|:-------|:------|
| 原理 | 光线追踪（物理精确） | 光栅化（实时渲染） |
| 画质 | 照片级真实 | 风格化/近似真实 |
| 速度 | 慢（每帧数秒~数分钟） | 快（实时/毫秒级） |
| 适用 | 静帧/产品展示/影视 | 预览/动画/游戏风格 |
| 灯光 | 全局光照自动 | 需要 Light Probe 烘培 |
| 反射 | 物理精确 | 屏幕空间反射(SSR) |
| 比喻 | 相机拍照 | 手机屏幕 |

**Cycles 核心设置面板**（Renderer Properties - 相机图标）：

**采样（Samples）**：
- **渲染采样**：最终渲染时的采样数
- **预览采样**：视口渲染时的采样数（降低以提高交互速度）
- 采样越多噪点越少，但耗时越长
- 推荐：预览=64~128，最终=512~2048

**降噪（Denoising）**——低采样出好图的关键：
- 在 Render Properties → Sampling → Denoising
- **OptiX**（NVIDIA GPU 最佳，硬件加速）
- **OIDN**（Intel，CPU 可用，Blender 5.1 性能优化）
- 降噪器能在 128 采样下达到 2048 采样的清晰度

**光程（Light Paths）**：
- **Max Bounces**：光线最大弹射次数（默认=12）
- Diffuse Bounces / Glossy Bounces / Transmission Bounces
- 降低可加速渲染（室内场景可以降到 4~6）
- 玻璃/水面需要较高的 Transmission Bounces

**性能优化（Blender 5.1）**：
- GPU 加速提升约 10%（相比 5.0）
- CPU (Windows) 渲染提速约 20%
- AMD HIP RT 默认开启硬件光追（AMD 用户自动受益）
- 支持多 GPU 混合渲染（CPU + GPU 同时工作）

**EEVEE 核心设置**：
- **阴影**：Shadow Cubemap Size / Cascade Size
- **环境光遮蔽（AO）**：模拟间接光照接触阴影
- **屏幕空间反射（SSR）**：反射效果（仅反射可见物体）
- **次表面散射（SSS）**：皮肤/蜡质/玉器等半透明材质
- 以上都需要开启才能获得近似 Cycles 的效果

**渲染输出**：
- `F12`：渲染当前帧（弹出渲染窗口）
- `Ctrl+F12`：渲染动画序列
- `F3`：渲染完成后直接保存图像

**输出格式**：
| 格式 | 用途 | 说明 |
|:-----|:-----|:-----|
| PNG | 静帧/网络分享 | 无损或有损压缩，带 Alpha |
| EXR | 专业后期 | 32位浮点，HDR 数据，支持多层 |
| MP4/H.264 | 视频 | 直接输出动画（推荐先出 PNG 序列再合成） |
| FFmpeg Video | 自定义编码 | 可调码率/分辨率/帧率 |

### 刻意练习（具体操作步骤）

**练习1：Cycles 渲染配置与降噪**

1. 打开之前带材质的场景
2. 渲染器切换：Renderer Properties → Render Engine → Cycles
3. Device 选择 GPU Compute（如果可用）
4. 设置 Sampling → Render=128，Preview=64
5. 开启 Denoising → OptiX（NVIDIA）或 OIDN
6. 设置 Light Paths → Max Bounces=8（平衡质量与速度）
7. 按 `F12` 渲染预览
8. 对比：关掉降噪再渲染一次，观察噪点差异

**练习2：EEVEE 实时预览与最终效果**

1. 切换渲染器为 EEVEE
2. 按 `Z → Rendered` 进入渲染模式
3. 开启 EEVEE 特性（Renderer Properties → Ambient Occlusion / Bloom / SSR）
4. 用 `N → View → Viewport Render Animation` 预览动画效果
5. 对比 EEVEE 和 Cycles 同一场景的渲染效果

**练习3：输出设置**

1. Output Properties（打印机图标）
2. 设置分辨率：1920×1080（Full HD），或 3840×2160（4K）
3. 设置输出路径：`//renders/`（// 表示 .blend 文件同级目录）
4. 文件格式：PNG → Color Depth=16（更高色彩精度）
5. 按 `F12` 渲染，`F3` 保存

**针对不同场景的 Cycles 采样建议**：

| 场景类型 | 建议采样 | 光程 | 技巧 |
|:---------|:--------:|:----:|:-----|
| 产品展示（室内） | 256~512 | 6~8 | 开 OptiX 降噪 |
| 室外/建筑 | 128~256 | 4~6 | 可用 OIDN 降噪 |
| 玻璃/水面 | 512~1024 | 12~16 | 需要高 Transmission 弹射 |
| 动画单帧 | 64~128 | 6~8 | 降噪必备，时间有限 |
| 最终展示 | 1024~4096 | 12 | 追求极致画质 |

### ✅ 完成标准

- [ ] 理解 Cycles 和 EEVEE 的核心区别及各自适用场景
- [ ] 能配置 Cycles 渲染参数（采样/降噪/光程）
- [ ] 会使用降噪技术（OptiX/OIDN）提高渲染效率
- [ ] 能切到 EEVEE 进行实时预览
- [ ] 掌握 F12 渲染、F3 保存的完整输出流程
- [ ] 了解不同场景的采样策略

### 📖 费曼三句话

1. Cycles=相机拍照（真实但慢），EEVEE=手机屏幕（快但不够真）——各有所长，按需选择
2. 降噪技术让你可以用 128 采样达到 2048 采样的画质——这是"又好又快"的核心秘诀
3. 静帧输出 PNG 或 EXR（给后期留余地），动画先出 PNG 序列再合成 MP4——别直接出 MP4，崩了全白做

---

## 🍅15 UV烘培与PBR贴图（25分钟）

### 费曼输入（概念解释）

**什么是 UV 烘培？**
UV 烘培是把三维模型表面的材质、光照、阴影、法线等信息，"烤"（计算/采样）到二维贴图上。这是将复杂细节"固定"到贴图的关键技术。

**烘培的三大应用场景**：

| 场景 | 做什么 | 为什么 |
|:-----|:-------|:-------|
| 高模→低模法线烘培 | 把高模细节烘为法线贴图 | 低模假装自己是高模（游戏行业核心流程） |
| 灯光/阴影烘培 | 把动态光照烘为 Lightmap | 实时渲染中"预计算"光照 |
| 材质合并烘培 | 把复杂节点材质烘为一张贴图 | 减少渲染计算量/导出到其他引擎 |

**烘培全流程（高模→低模法线烘培）**：

```
Step 1: 高模(Hpoly) + 低模(Lpoly) 完美重叠
Step 2: 选中低模，展开干净 UV
Step 3: 低模上添加 Image Texture 节点（设置名称+尺寸+Alpha）
Step 4: 选低模 → Cycles 渲染器 → Render Properties → Bake
Step 5: 选 Bake Type=Normal → 勾选 Selected to Active
Step 6: 点击 Bake
```

**烘培类型详解**：

| 类型 | 用途 | 颜色通道 |
|:-----|:-----|:---------|
| Combined | 烘焙所有光照+阴影+材质 | RGB |
| Diffuse | 仅漫反射颜色 | RGB |
| Glossy | 高光/反射 | RGB |
| Transmission | 透射 | RGB |
| Normal | 法线方向信息（凸凹感） | RGB（切线空间） |
| AO (Ambient Occlusion) | 环境光遮蔽（接触阴影） | 灰度 |
| Emission | 自发光 | RGB |
| Alpha | 透明度 | 灰度 |

**PBR 贴图组**——现代渲染的标准配置：

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│ Base Color  │  │  Metallic   │  │  Roughness  │
│  (基础色)    │  │  (金属度)    │  │  (粗糙度)    │
└─────────────┘  └─────────────┘  └─────────────┘
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   Normal    │  │   Ambient   │  │   Height    │
│  (法线)      │  │ Occlusion   │  │  (高度/置换) │
└─────────────┘  │  (环境遮蔽)   │  └─────────────┘
                 └─────────────┘
```

**烘培注意事项**：
- 必须使用 **Cycles** 渲染器（EEVEE 不支持烘培）
- 低模必须有 UV 展开
- Image Texture 尺寸=2的幂（512/1024/2048/4096）
- 烘培前保存 .blend 文件
- 复杂烘培会耗时较长（耐心等待）
- 如果烘培结果是黑色/错误的 → 检查 UV 是否在 0~1 范围内

**Blender 5.1 烘培改进**：
- Cycles 烘培性能提升（受益于整体渲染加速）
- 更好的多 GPU 烘培支持

### 刻意练习（具体操作步骤）

**练习1：法线贴图烘培（高模→低模）**

> **准备**：一个高精度模型和一个低精度模型，位置完全重叠

1. 在 Outliner 中隐藏高模（只显示低模）
2. 选中低模 → Tab 进入 Edit Mode → 展开 UV
3. 回到 Object Mode
4. Shader Editor 中：
   - 低模材质中 `Shift+A → Texture → Image Texture`（新建）
   - 命名：`lowpoly_normal`，尺寸：2048×2048
   - Alpha 通道：勾选
   - 连接到 Principled BSDF 的 Normal（通过 Normal Map 节点）
5. Render Properties → Bake
   - Bake Type: Normal
   - 勾选 Selected to Active（从选中物体烘培）
   - Extrusion: 0.1（防止低模浮空导致烘培空洞）
   - Max Ray Distance: 0.1（配合 Extrusion）
   - 在 Outliner 中 Shift+点击 选高模
6. 点 Bake → 等待完成
7. 检查法线贴图：紫色色调为主，RGB 分别对应 XYZ 方向

**练习2：AO 烘培**

1. 低模新建 Image Texture：名称 `lowpoly_ao`，2048×2048
2. 连接到材质：Color Ramp → Fac → Mix Factor
3. Bake Type: Ambient Occlusion
4. Samples: 128
5. Distance: 0.3（影响范围）
6. 烘培 → 得到灰度 AO 贴图
7. 用 Color Ramp 调整对比度

**练习3：PBR 贴图检查与连接**

1. 连接完整的 PBR 贴图组到 Principled BSDF：
   ```
   Base Color → Base Color
   Metallic → Metallic
   Roughness → Roughness
   Normal(通过 Normal Map 节点) → Normal
   AO(通过 Color Ramp 调节) → 用 MixRGB 乘到 Base Color
   ```
2. 切换到 Cycles Rendered 模式查看效果
3. 对比纯节点材质 vs PBR 贴图材质的渲染差异

### ✅ 完成标准

- [ ] 理解 UV 烘培的概念——3D 信息转 2D 贴图
- [ ] 成功完成一次法线贴图烘培（高模→低模）
- [ ] 能进行 AO 烘培并优化结果
- [ ] 知道 PBR 贴图组的6种常见贴图及作用
- [ ] 能用 Cycles 正确烘培（Selected to Active 设置正确）
- [ ] 能把烘培好的贴图应用到低模上获得高模效果

### 📖 费曼三句话

1. UV烘培 = 把3D表面信息（颜色/光影/法线）转成2D贴图——"拍照"后再贴回去
2. 法线烘培是"把高模细节存到贴图上，低模假装自己很高模"——游戏行业的魔法，用几百个面模拟几百万个面的效果
3. PBR贴图组 = 颜色+金属+粗糙+法线+AO+高度，是现代游戏和影视渲染的通用语言——学会这组贴图，你就能在任意引擎间无缝切换

---

> **模块B完成！** 你现在已经掌握了材质、UV、灯光、渲染和烘培的全流程技能。接下来进入 [[AI系统学习课/40番茄速通Blender教程/模块C-几何节点与雕刻]]，学习程序化建模和数字雕刻。
