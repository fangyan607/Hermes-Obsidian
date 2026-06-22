---
created: 2026-06-20
module: C
title: 几何节点与雕刻
pomodoros: 5
tags:
  - 教程
  - Blender
  - 几何节点
  - 程序化建模
  - 雕刻
  - Dyntopo
  - 纹理绘制
  - 番茄费曼
related:
  - "[[AI系统学习课/40番茄速通Blender教程/README.md]]"
  - "[[AI系统学习课/40番茄速通Blender教程/模块B-材质渲染与UV烘培]]"
  - "[[AI系统学习课/40番茄速通Blender教程/模块D-特效动画与插件工作流]]"
---

# 模块C：几何节点与雕刻

> **核心目标**：掌握 Blender 几何节点程序化建模和数字雕刻两大进阶技能。学完本模块，你既能用"积木块"搭建程序化生成器，也能像捏泥巴一样雕刻数字模型。

---

## 🍅16 几何节点入门（25分钟）

### 费曼输入（概念解释）

**什么是几何节点？**
几何节点（Geometry Nodes）是 Blender 内置的可视化程序化建模系统。它允许你通过连接"节点积木块"来定义几何体的生成和变换规则，而不是手动建模。Blender 5.1 的几何节点系统更加成熟，新增了多项实用节点。

**几何节点编辑器**：
1. 选中一个物体
2. `几何数据属性（绿色六边形图标）→ New` 添加几何节点修改器
3. 或在 3D Viewport 切换工作区为 Geometry Nodes
4. 双击节点组进入编辑

**核心概念图解**：

```
Group Input ──→ [操作节点 1] ──→ [操作节点 2] ──→ Group Output
(原始几何)      (变换/选择)       (生成/修改)      (结果几何)
```

- **Group Input**：从修改器面板/3D 场景输入数据
- **Group Output**：输出处理后的几何体
- **数据线（黄/灰/紫/绿）**：不同颜色代表不同类型的数据
- **Field（字段）**：最强大的概念——不是固定的值，而是"每个元素独立的计算公式"。比如"每个顶点的高度 = 其位置的 X 值 × 2"

**数据流类型**：

| 颜色 | 类型 | 说明 | 示例 |
|:-----|:-----|:-----|:-----|
| 黄色 | Geometry | 几何数据（网格/曲线/点云） | 整个模型 |
| 灰色 | Integer | 整数 | 分段数 |
| 紫色 | Float | 浮点数/小数 | 缩放值、角度 |
| 蓝色 | Vector | 三维向量 (X,Y,Z) | 位置、旋转 |
| 绿色 | Boolean | 布尔值（是/否） | 选择、开关 |
| 红色 | Color | 颜色 RGBA | 顶点颜色 |

**Blender 5.1 新增节点**：
| 节点 | 功能 |
|:-----|:------|
| Bone Info | 获取骨骼变换数据（位置/旋转/缩放） |
| String to Curves | 字符串转曲线，新增 Word 输出（逐词拆分） |
| UV Unwrap | 几何节点内直接 UV 展开，新增 Minimum Stretch (SLIM) 模式 |

### 刻意练习（具体操作步骤）

**练习：用几何节点在平面上随机分布立方体**

1. `Shift+A → Mesh → Plane`，Scale=5（地面）
2. 选中平面 → 几何数据属性（绿色图标）→ New
3. 节点编辑器中出现：Group Input → [空] → Group Output
4. 删除默认连接线
5. `Shift+A → Point → Distribute Points on Faces`：
   - Group Input Geometry → Distribute Points → Geometry
   - 参数：Density=10，Seed=0
6. `Shift+A → Instance → Instance on Points`：
   - Distribute Points 的 Geometry（点）→ Instance on Points 的 Geometry（输入）
   - Distribute Points 的 Density 等参数到 Instance on Points
7. `Shift+A → Mesh → Mesh Line` 或更简单：`Shift+A → Mesh → Cube`：
   - 拖入一个 Cube
8. 把 Cube 拖到 Instance on Points 的 Instance 插口
9. 连线完成：Group Input → Distribute on Faces → Instance on Points → Group Output
10. `Shift+A → Value → Random Value`：
    - Random Value → Float 模式，Min=0.5, Max=3.0
    - 连到 Instance on Points 的 Scale
    - 所有立方体大小随机了！
11. 再加一个 Random Value → Vector 模式 → 连 Rotation（X 轴旋转）
12. 观察效果——随机大小+随机旋转的立方体阵列

**节点组参数暴露**：
- 点中 Distribute Points on Faces 的 Density 左边的按钮（勾选变为图标）
- 这个参数就暴露到了修改器面板——不进入编辑器也能调整
- 同理暴露 Random Value 的 Min/Max

**常用几何节点速查**：

| 类别 | 节点 | 功能 |
|:-----|:-----|:------|
| 点 | Distribute Points on Faces | 在面上撒点 |
| 实例 | Instance on Points | 在点上放置实例 |
| 选择 | Random Selection | 按概率选择部分元素 |
| 变换 | Set Position | 修改顶点的位置 |
| 变换 | Rotate Instances | 旋转实例 |
| 变换 | Scale Instances | 缩放实例 |
| 网格 | Mesh Circle/Grid/Line | 生成基础网格 |
| 曲线 | Curve to Mesh | 曲线转网格 |
| 输出 | Viewer | 在视口中预览节点数据 |

### ✅ 完成标准

- [ ] 理解几何节点的核心概念：数据流、Field、实例化
- [ ] 独立完成随机分布立方体的节点搭建
- [ ] 能正确连接 Group Input → 操作节点 → Group Output
- [ ] 掌握 Distribute Points on Faces + Instance on Points 组合
- [ ] 会用 Random Value 控制缩放/旋转随机化
- [ ] 能将参数暴露到修改器面板便于调整

### 📖 费曼三句话

1. 几何节点 = 用"积木块"搭建的程序化建模流程——不用写代码，连线就能定义生成规则
2. 实例化(Instance)是绿色性能优化的关键——不增加实际几何体数量，却能显示成千上万的物体
3. 参数可调意味着改一个数字就能生成无数变体——几何节点的"威力"在于一次搭建，无限产出

---

## 🍅17 程序化建模实战（25分钟）

### 费曼输入（概念解释）

**程序化建模的核心思想**：
找到规律 → 用数学表达 → 用节点实现 → 参数控制

当你发现"这个楼梯每层旋转5度，升高0.2米"，这就是一个程序化规则。几何节点的作用就是把这个规则变成可视化的流程图。

**常用数学模式**：

| 模式 | 节点组合 | 效果 |
|:-----|:---------|:-----|
| 线性变化 | Map Range | 从 A 到 B 均匀变化 |
| 循环 | Math（三角函数：正弦/余弦） | 波动/波浪/螺旋 |
| 随机 | Random Value | 无序变化/自然感 |
| 分形 | Repeat Zone (Blender 4.x+) | 自相似/递归图案 |
| 选择 | Compare + Switch | 条件分支 |

**用户自定义 Group（节点组封装）**：

为什么需要 Group？
- **复用**：写一次，多处使用
- **组织**：把复杂逻辑打包，只暴露关键参数
- **协作**：别人可以方便地使用你的节点组

```
Ctrl+G → 命名 → 定义输入/输出接口
→ Group Input 上的 "+" 添加参数
→ 右键选择 "New Socket" 定义数据类型
→ 连接内部节点到 Group Output
```

**实际案例架构**：

```
案例1：螺旋楼梯
Circle(基础圆) → Distribute Points(沿圆周分布) → Set Position(逐点升高) → Instance on Points(放踏板) → Rotate Instances(逐层旋转)

案例2：城市生成器
Grid(地块) → Distribute Points(随机撒点) → Compare(区域筛选) → Instance on Points(放建筑) → Random Value(随机高度/颜色)
```

### 刻意练习（具体操作步骤）

**练习1：程序化螺旋楼梯**

1. `Shift+A → Curve → Circle`，Radius=3
2. 增加几何节点修改器 → New
3. 节点搭建：

```
Group Input (Circle曲线)
    ↓
Resample Curve(Length=0.5)  → 增加细分点
    ↓
Set Position(抬高Z轴)
    ├── 用 Index 节点 → Math(乘) → 每层高度0.2
    │
    └── 用 Index → Math(三角函数) → 旋转角度
    ↓
Instance on Points
    ├── Instance = 立方体(缩放为踏板形状 2,0.4,0.1)
    └── Scale = Random Value(0.8~1.2)
    ↓
Rotate Instances
    └── 用 Index × 旋转角度(每层=360°/踏步数)
    ↓
Group Output
```

4. 添加参数控制：
   - 暴露：踏步数、总高度、螺旋圈数
   - 用 Group Input 添加 Float 类型的输入插口
5. 再加扶手（选做）：
   - 提取内圈和外圈的点 → Curve to Mesh → 管道轮廓

**练习2：程序化城市生成器**

1. `Shift+A → Mesh → Grid`，X=10, Y=10
2. 几何节点流程：

```
Group Input (Grid)
    ↓
Distribute Points on Faces
    ├── Density=由 Noise Texture 控制(市中心密度高)
    └── Seed=可调
    ↓
Instance on Points
    ├── Instance=建筑(Cube拉伸或自定义建筑组)
    ├── Scale=Random Value(高度 1~10, 宽度 0.5~1.5)
    └── 用 Random Value(颜色) → Set Material Index → 不同颜色区域
    ↓
Group Output
```

3. 增加道路网格：
   - 用另一套 Grid → 删除内部面只留边缘（Delete Geometry → Edge/Face）
   - 或使用 Grid 的 Vertices 连接成曲线作为道路线

**练习3：封装重用节点组**

1. 选中所有节点 → `Ctrl+G`
2. 在 Group Input 上点"+" → 添加参数插口
3. 命名节点组：`Spiral_Staircase_Generator`
4. 测试：新建一个场景 → 对任意物体添加 Geometry Nodes → 选 Spiral_Staircase_Generator
5. 调整暴露的参数——它就是一个"即插即用"的生成器了

**常用的数学驱动效果**：

```python
# 将数学表达式翻译为几何节点：
# 1. Z轴波浪: Set Position → Z = sin(X × Frequency + Time) × Amplitude
#    节点: Position → Separate XYZ(X) → Math(Sine) → Multiply → Combine XYZ → Set Position
#
# 2. 径向散布: 沿圆周分布后旋转
#    节点: Points on Circle → Set Position → 用 ArcTan2 计算方向
#
# 3. 渐变缩放: 按距离中心点的距离缩放
#    节点: Position → Vector Length → Map Range → Scale Instances
```

### ✅ 完成标准

- [ ] 理解程序化建模的核心思想——规则→数学→节点→参数
- [ ] 独立完成螺旋楼梯的节点搭建并参数化
- [ ] 体验城市生成器的节点流程（至少完成基础布局）
- [ ] 掌握 Ctrl+G 创建/封装节点组的方法
- [ ] 能用参数暴露让生成器"可调"
- [ ] 理解 Repeat Zone 或三角函数在程序化建模中的作用

### 📖 费曼三句话

1. 程序化建模 = 规则的数学表达——用几何节点把规则变成可视化的流程图，一次搭建无限产出
2. 把常用逻辑封装成 Group（Ctrl+G）就像写函数——输入参数，输出结果，随处复用
3. 几何节点是"非破坏性"的——随时可以改参数生成新的变体，不像手动建模改了就回不去

---

## 🍅18 雕刻基础（25分钟）

### 费曼输入（概念解释）

**雕刻的本质**：数字捏泥巴
Blender 的雕刻系统模拟了真实雕塑的工作方式——通过笔刷推拉网格表面来塑造形状。区别在于你面对的是屏幕，而且可以撤销（Ctrl+Z）。

**Sculpting 工作区**：
- 切换工作区为 `Sculpting`
- 左侧是笔刷面板，顶部是笔刷设置
- 3D 视口就是你的"雕塑台"

**雕刻核心画笔（按使用频率排序）**：

| 笔刷 | 快捷键 | 作用 | 比喻 |
|:-----|:------|:-----|:-----|
| **Clay Strips** | `3` | 加体积，快速造型 | 黏土条 |
| **Draw** | `1` | 推拉表面，基础笔刷 | 手指按压 |
| **Smooth** | `Shift+笔刷` | 柔化表面，消除凹凸 | 打磨 |
| **Crease** | `4` | 刻线/凹陷/褶皱 | 雕刻刀 |
| **Inflate** | `5` | 局部膨胀 | 吹气 |
| **Deflate** | `6` | 局部收缩 | 漏气 |
| **Grab** | `G` | 拖动表面修改大形 | 扯黏土 |
| **Mask** | `M` | 保护不想修改的区域 | 贴胶带 |
| **Pinch** | `P` | 收紧顶点/聚拢 | 捏合 |
| **Box Trim** | `7` | 切平/切割 | 刀切 |

**雕刻设置详解**：

**Dyntopo（动态拓扑）**：
- 在笔刷设置顶部勾选 Dyntopo
- 运行时自动根据细节需要调整网格细分
- Detail Size：最小细节尺寸（越小越精细）
- Detail Method：
  - Relative Detail（按屏幕比例）：推荐，自动适配
  - Constant Detail（恒定细分）：均匀细分
  - Brush Detail（笔刷范围）：只在笔刷处细分
- 优化：Blender 5.1 的 Winter of Quality 修复多项 Dyntopo 相关 Bug

**Remesh（重网格）**：
- 手动重建均匀网格
- Voxel Size：体素大小（越小面越多越精细）
- Adaptivity：适应性（保留大形减少面数）
- Quad / Triangle：四边面/三角面选择

**对称（Symmetry）**：
- 在笔刷设置顶部（或快捷键 `X`）
- 启用 X 轴对称雕刻——改一边自动镜像另一边
- 可同时启用 X+Y 轴对称
- Feather（羽化）：对称中心过渡柔化

**雕刻操作技巧**：
| 操作 | 方式 | 说明 |
|:-----|:-----|:------|
| 调整笔刷半径 | `F` | 鼠标拖动调整 |
| 调整强度 | `Shift+F` | 鼠标拖动调整（或侧键） |
| 切换对称 | `X` | 快速开关对称 |
| 遮罩 | `M` 键切换 | 按住 Ctrl 点击反向遮罩 |
| 遮罩羽化 | 遮罩后 Shift+点击 | 柔化遮罩边缘 |
| 重置遮罩 | `Alt+M` | 清除所有遮罩 |

**雕刻流程三阶段**：
```
第一阶段：大形（Grab/Clay Strips，低细分，抓整体比例）
    ↓
第二阶段：中形（Clay Strips/Draw/Inflate，中细分，细化结构）
    ↓
第三阶段：小形+细节（Crease/Pinch，高细分，刻线/纹理）
    ↓
最后：平滑（Smooth，去除噪点/不自然凹凸）
```

### 刻意练习（具体操作步骤）

**练习1：从球体雕刻一个头像基础**

1. `Shift+A → Mesh → UV Sphere`，Segments=32，Rings=16
2. `Tab` 进入 Edit Mode → `A` 全选 → `Mesh → Transform → To Sphere=1.0`（变圆）
3. 回到 Object Mode，切换到 Sculpting 工作区
4. 勾选 Dyntopo → Detail Size=10（初始大形）
5. 按 `X` 开启 X 轴对称
6. **大形阶段**：
   - Grab 笔刷（G）：抓出下巴（球体下部向前拉）
   - Grab 笔刷（G）：抓出眉弓（球体上部两个突起）
   - Clay Strips（3）：在脸颊处加体积
7. **中形阶段**：
   - 调小 Dyntopo Detail Size=5（增加细分继续雕）
   - Draw 笔刷（1）：加深眼窝
   - Clay Strips（3）：塑造鼻子形状
   - Crease（4）：刻出嘴缝线
8. 随时 Smooth（Shift+拖动）：柔化不平整的面

**练习2：Mask 遮罩应用**

1. `M` 切换到 Mask 笔刷
2. 在模型一半画遮罩（保护已雕好的部分）
3. `Ctrl+I` 反选遮罩
4. 用 Grab/Clay Strips 修改未遮罩的部分
5. `Alt+M` 清除遮罩
6. 练习：遮住鼻子只改嘴巴部分

**练习3：Remesh 修复网格**

1. 雕刻过程中如果网格太乱
2. Object Data Properties（绿色三角）→ Remesh
3. Voxel Size=0.05，选择 Quad
4. 点击 Remesh
5. 注：Remesh 后需要重新雕刻一些细节（因为网格被重建了）

### ✅ 完成标准

- [ ] 熟悉 Sculpting 工作区布局
- [ ] 掌握 Clay Strips/Draw/Smooth/Grab/Mask 五种核心笔刷
- [ ] 理解 Dyntopo 的作用——自动细分简化
- [ ] 能启用 X 轴对称雕刻
- [ ] 会用 Mask 保护/分离雕刻区域
- [ ] 完成一次从球体到面部的雕刻练习（不需要完美，体验流程）

### 📖 费曼三句话

1. 雕刻 = 数字捏泥巴——推拉表面塑造形状，会捏橡皮泥就会雕刻，只是换成了屏幕和数位板
2. Clay Strips 是雕刻的"主力笔刷"——相当于真实雕塑加黏土，80%的造型工作靠它完成
3. DynTopo 自动在需要细节的地方加细分，不需要的地方保持简洁——不用手动控制拓扑，专注于造型本身

---

## 🍅19 Dyntopo 与细节雕刻（25分钟）

### 费曼输入（概念解释）

**Dyntopo 深度解析**：

Dyntopo（Dynamic Topology）在雕刻时动态调整网格结构：
- **需要细节的地方**（笔刷经过处）：自动细分，增加面数
- **不需要细节的地方**：保持低面数
- **网格拓扑会变化**（不是固定的四边面）

**Detail Size（细节尺寸）详解**：
- 数值越小 = 细节越精细 = 面数越多
- 推荐工作流程：从大到小（先 20 → 再 10 → 再 5 → 再 2）

```
Detail Size=20  → 粗雕，只做大形轮廓（几百面）
Detail Size=10  → 中雕，五官/结构（几千面）
Detail Size=5   → 细雕，褶皱/肌肉（几万面）
Detail Size=2   → 精雕，毛孔/纹理（几十万面）
```

**细节雕刻的层次法**（从粗到精，不可跳级）：

| 层级 | 细分 | 笔刷 | 目标 |
|:-----|:-----|:------|:-----|
| 0. 大形 | 不雕，先调基础几何 | 基础 Mesh/生成器 | 确定比例/轮廓 |
| 1. 粗大形 | Detail Size=20 | Grab/Clay Strips | 整体体积/姿态 |
| 2. 中形 | Detail Size=10 | Clay Strips/Draw | 主要结构/五官 |
| 3. 小形 | Detail Size=5 | Crease/Pinch/Inflate | 细节/皱纹/肌肉 |
| 4. 微观 | Detail Size=2 | Alpha/VDM | 毛孔/皮肤纹理 |

**Alpha 笔刷**：
- 用灰度图片定义笔刷形状
- 白色=突起，黑色=凹陷
- 应用场景：皮肤毛孔、鳞片、布料纹理
- 加载方式：Brush Settings → Texture → 加载图片

**VDM 笔刷**：
- VDM = Vector Displacement Map
- 预置 3D 形状笔刷（鼻子、眼睛、嘴巴、耳朵等）
- 一笔就能"贴"上一个完整的3D形状
- 从 [Blender Market](https://blendermarket.com) / [Gumroad](https://gumroad.com) 下载

**再拓扑（Retopology）**：
- 雕刻完成后，模型面数很高（几十万~几百万），拓扑混乱
- 需要重建一个面数合理、拓扑清晰的低模
- 常用方法：
  - **Shrinkwrap Modifier**：低模吸附高模
  - **Retopoflow 插件**：专业再拓扑工具
  - **Quad Remesher**（付费）：自动四边面重拓扑
  - **手动拓扑**：在 Edit Mode 用面片/网格旋转搭

**Blender 5.1 雕刻改进**：
- Winter of Quality 项目修复了多项雕刻相关的 Bug
- Dyntopo 稳定性提升
- 笔刷性能优化，减少延迟

### 刻意练习（具体操作步骤）

**练习1：分层雕刻——雕刻一个怪兽头**

1. 从 UV Sphere 开始（Segments=32, Rings=16）
2. **层1——大形（Detail Size=20）**：
   - Grab 笔刷拉出下颚、眉弓、角的基础
   - Clay Strips 塑造额头的体积
3. **层2——中形（Detail Size=8~10）**：
   - Clay Strips 塑造鼻梁、颧骨
   - Draw 笔刷加深眼窝凹陷
   - Crease 笔刷画出嘴线、眉骨
4. **层3——小形（Detail Size=4~5）**：
   - Pinch 收紧眼角、嘴角
   - Inflate 局部膨胀（嘴唇、鼻子）
   - Crease 强化皱纹线条
5. **层4——微观（Detail Size=1~2）**：
   - Alpha 笔刷加载鳞片纹理（Brush Settings → Texture → 选图片）
   - 在皮肤上画出鳞片质感
   - 或手动用 Crease 画一些伤痕/纹理

**练习2：Alpha 笔刷使用**

1. 找一张灰度纹理（鳞片/皮肤毛孔/木纹图片）
2. Brush Settings → Texture → Open → 选择图片
3. Mapping > Stencil（模板模式）
4. 在模型上拖动——纹理跟随笔刷出现
5. 调节强度控制凹凸深度
6. 如果不满意 → Ctrl+Z 撤销

**练习3：遮罩高级应用**

1. 用 Mask 笔刷在模型上画复杂的遮罩形状
2. **遮罩边缘羽化**：
   - Shift+点击遮罩区域（柔化边缘）
3. **遮罩提取**（选做）：
   - 遮罩区域 → `Shift+Ctrl+I` 反选 → 新建物体 → 提取遮罩部分
4. **遮罩膨胀/收缩**：Mask → Expand/Contract Mask

**练习4：使用对称+局部不对称**

1. 先开启 X 轴对称雕刻大形
2. 完成后关掉对称
3. 添加不对称细节（伤痕、不对称的皱纹、歪嘴）
4. 实际生物很少有完全对称的脸——适当不对称增加真实感

### ✅ 完成标准

- [ ] 理解 Dyntopo 的工作原理和 Detail Size 的影响
- [ ] 掌握分层雕刻法（大形→中形→小形→微观）
- [ ] 至少使用一次 Alpha 笔刷（纹理雕刻）
- [ ] 熟练使用 Mask + 对称的组合雕刻
- [ ] 了解再拓扑（Retopology）的概念和流程
- [ ] 能在雕刻中切换对称/不对称模式

### 📖 费曼三句话

1. Dyntopo = 根据需要自动调整网格密度——需要细节的地方密，不需要的地方简，让电脑资源花在刀刃上
2. 雕刻是从粗到精的过程：先不管拓扑只管抓大形，再逐步增加细分深入细节——绝对不能跳级
3. Alpha笔刷是批量添加微观细节的捷径——一张灰度图就能让模型表面长满鳞片或毛孔

---

## 🍅20 纹理绘制（25分钟）

### 费曼输入（概念解释）

**什么是纹理绘制？**
Texture Paint 是 Blender 内置的 3D 绘画工具——直接在模型表面上画贴图。想象在 Procreate 或 Photoshop 中画画，但画笔落在 3D 模型上，颜色会跟着模型曲面走。

**Texture Paint 工作区**：
- 切换工作区为 `Texture Paint`
- 左侧：3D 视口（绘制区域）
- 右侧：UV Editor（显示贴图展开——绘制同时展示）
- 顶部工具栏：笔刷/颜色/工具选项

**纹理绘制的前提条件（至关重要！）**：

```
模型必须有 UV 展开！
否则画笔不知道颜色应该画在哪里。
```

**纹理绘制全流程**：

```
1. 模型展开 UV（🍅12的技能）
2. 切换到 Texture Paint 工作区
3. 新建贴图：Texture Paint → New Image（设置尺寸1024/2048/4096）
4. 选择画笔，开始绘制
5. 保存：Image → Save As（PNG/JPEG/Targa）
```

**核心绘制功能**：

| 功能 | 快捷键 | 说明 |
|:-----|:------|:------|
| 画笔 | `左键拖动` | 在模型上绘制 |
| 颜色拾取 | `S`（吸管） | 从模型上取色 |
| 笔刷半径 | `F` | 调大/调小 |
| 笔刷强度 | `Shift+F` | 控制颜色透明度 |
| 模糊 | `Draw→Blur` | 柔化颜色过渡 |
| 涂抹 | `Draw→Smear` | 像素拖动/混色 |
| 克隆 | `Draw→Clone` | 从贴图另一部分复制像素 |

**高级绘制方法**：

**Stencil Mask（模板遮罩）**：
- 用一张图片作为"镂空模板"
- 只允许在模板镂空处绘制
- 应用：在模型上贴文字、Logo、图案
- 设置：Brush → Mask → Stencil

**Projection Paint（投影绘制）**：
- 从相机/特定视角把照片投射到模型上
- 应用：把真实人脸投射到3D头像上
- 操作：选好相机视角 → Projection Paint 模式 → 选择图片 → 投射

**贴图类型与连接**：

| 贴图用途 | 节点连接 | 最终用途 |
|:---------|:---------|:---------|
| Base Color | Principled BSDF → Base Color | 颜色贴图 |
| Alpha Mask | Principled BSDF → Alpha | 透明区域 |
| Roughness（灰度） | Principled BSDF → Roughness | 光滑度控制 |
| Metallic（灰度） | Principled BSDF → Metallic | 金属区域 |

**贴图保存注意事项**：
- Image → Save As → PNG（带 Alpha 选 PNG，不带选 JPEG）
- Pack Image（打包到 .blend 文件）→ Image → Pack
- 如果贴图路径丢失 → File → External Data → Find Missing Files

### 刻意练习（具体操作步骤）

**练习1：给 UV 展开的立方体绘制颜色贴图**

1. `Shift+A → Cube`，Tab 进入 Edit Mode
2. `U → Smart UV Project`（快速展开）
3. 切换到 Texture Paint 工作区
4. 在 UV Editor 面板 → `Image → New`：
   - Name：`cube_color`
   - Width：1024，Height：1024
   - 颜色：白色
   - Alpha：勾选
5. 开始绘制：
   - 选一个颜色（点击顶部色块）
   - 在模型表面画一笔——颜色跟着曲面走
   - 按 `S` 变成吸管，从模型取色
   - 换颜色继续画
6. 观察 UV Editor：右侧的 UV 方块上也在同步画——证明了 UV 和 3D 的映射关系
7. `Image → Save As → cube_color.png`

**练习2：绘制木质纹理**

1. 换成木纹颜色（棕色系）：Base=#8B5E3C, Dark=#5C3A1E
2. 用大半径笔刷（F调大）画底色
3. 用细笔刷画木纹线条：
   - 选深棕色，小半径
   - 沿 UV 方向画木纹线
   - 适当抖动/不规则
4. 换模糊笔刷（Type → Blur），柔化木纹边缘
5. 给木纹加一些节点（回到 Shader Editor）：
   ```
   Image Texture(cube_color) → Base Color
   ↓ 再加一个 Roughness 贴图
   ```

**练习3：Stencil Mask（模板绘制）**

1. 找一张黑白 Logo 图或文字图
2. Brush → Mask → Image → Open → 选择图片
3. Mask Mapping → Stencil
4. 在模型上移动/缩放模板（拖动/滚轮）
5. 在模板范围内绘制——只有镂空部分会被画上
6. 按 `Enter` 确认位置

**练习4：Projection Paint（投影绘制）——体验**

1. 下载一张人像正面照片
2. 把相机对准模型正面
3. Texture Paint 工作区 → Paint → Projection Paint
4. 选择照片 → Project
5. 照片的纹理被"投射"到模型正面
6. 注意：投影质量取决于 UV 展开和相机角度

**纹理绘制的性能提示**：
- 贴图尺寸越大，笔刷反应越慢——可以先 1024×1024 画，最后出图用 4096
- 打开 GPU 加速（Edit → Preferences → System → Cycles Render Devices）
- 如果卡顿：降低笔刷采样率（Brush → Spacing）

### ✅ 完成标准

- [ ] 理解纹理绘制的前置条件——模型必须有 UV 展开
- [ ] 成功在模型上绘制颜色并保存贴图
- [ ] 掌握颜色拾取(S)和笔刷调节(F/Shift+F)
- [ ] 体验 Stencil Mask 模板绘制
- [ ] 了解 Projection Paint 的使用场景
- [ ] 能把绘制的贴图连接到材质节点中正确使用

### 📖 费曼三句话

1. 纹理绘制 = 在3D模型上直接"画画"——所见即所得，画在模型上的每一笔都在 UV 贴图上对应
2. UV展开的质量决定了纹理绘制的精度——UV 如果拉伸严重，画出来的图案也是变形的
3. 投影绘制能把照片的纹理直接投射到模型上——相当于"拍照贴膜"，是快速为模型添加写实纹理的黑科技

---

> **模块C完成！** 你现在掌握了几何节点程序化建模和数字雕刻两大进阶技能。接下来进入 [[AI系统学习课/40番茄速通Blender教程/模块D-特效动画与插件工作流]]，学习粒子、物理、动画和插件生态。
