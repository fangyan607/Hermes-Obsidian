---
created: 2026-06-20
tags:
  - blender
  - tutorial
  - module-a
  - hard-surface
  - modifiers
status: draft
---

# 模块A：硬表面建模与修改器

> **预估时间**：5个番茄钟（每个25分钟）
> **目标**：掌握修改器堆栈、布尔运算、硬表面拓扑、曲线建模，完成科幻道具实战
> **前置**：完成模块0基础操作

---

## 🍅6 修改器堆栈深度解析（25分钟）

### 费曼输入（概念解释）

**修改器（Modifier）** 是 Blender 中最强大的**非破坏性编辑工具**——它不会实际修改你的几何体数据，而是在渲染/显示时"实时计算"效果。你可以随时调整参数、开关可见性、调整顺序，甚至删除修改器回到原始几何体。

**修改器堆栈（Stack）** 的概念：多个修改器从上到下**依次叠加执行**，顺序极其重要。例如：Mirror → Subdivision Surface → Solidify 和 Subdivision Surface → Mirror → Solidify 的结果完全不同。

三个最常用的修改器组合被称为**建模三件套**：Mirror（镜像） + Subdivision Surface（细分） + Solidify（实体化）。

### 刻意练习（具体操作步骤 + 代码/命令）

**Step 1：修改器面板入门**
1. 选中场景中的立方体
2. 右侧属性编辑器 → **扳手图标**（Modifiers 选项卡）
3. 点击 "Add Modifier" 下拉菜单
4. 浏览所有修改器分类：修改(Modify)/生成(Generate)/形变(Deform)/物理(Physics)

**Step 2：Mirror 镜像修改器**
1. 删除一半立方体顶点（进入 Edit Mode → `B` 框选左侧顶点 → `X` → Delete Vertices）
2. 添加 Mirror 修改器：
   - Axis：勾选 X
   - 勾选 `Bisect` + `Flip`（切分并镜像，让中间不重叠）
   - Merge 勾选，Distance 保持 0.001
3. 移动左边顶点 → 右边自动对称更新 ✅
4. 应用场景：人物/车辆/武器等对称物体的最佳选择

**Step 3：Subdivision Surface 细分表面修改器**
1. 在一个 Cube 上添加 Subdivision Surface
2. 将 Levels Viewport 设为 2（视口细分级别）
3. 观察：立方体变圆润了
4. 进入 Edit Mode → 选中一条边 → `Shift + E` → 拖动鼠标：设置 Crease（折痕）
   - 白色边 = 完全锐利
   - 黑色边 = 完全光滑
5. 应用场景：从低模出发做高模，用 Crease 控制锐利度

| 参数 | 说明 | 建议值 |
|------|------|--------|
| Levels Viewport | 视口显示的细分次数 | 1-2（性能考虑） |
| Levels Render | 渲染时的细分次数 | 2-3 |
| Quality | 细分计算精度 | 3-5 |
| Optimal Display | 是否只显示网格框 | 建议勾选 |

**Step 4：Solidify 实体化修改器**
1. 添加一个 Plane → 进入 Edit Mode → 确认是一个平面
2. 添加 Solidify 修改器
3. 调整 Thickness 参数 → 平面变立体的薄板
4. 勾选 `Fill Rim` → 边缘有封口
5. 应用场景：给衣服、外壳、墙壁等薄壳结构加厚度

**Step 5：Bevel 倒角修改器**
1. 给 Cube 添加 Bevel 修改器
2. Width 设为 0.1m，Segments 设为 2
3. 观察棱边变圆滑
4. 对比：Limit Method → Angle（按角度倒角）vs None（全部倒角）

**Step 6：Array 阵列修改器**
1. 添加一个小物体（比如 Cylinder 压扁当硬币）
2. 添加 Array 修改器：
   - **Relative Offset**：X 方向 1.1（沿 X 轴间隔复制）
   - **Count**：10（复制数量）
   - 切换查看 **Constant Offset** 和 **Object Offset**（以另一个物体的变换控制偏移）

**Step 7：理解堆栈顺序**
1. 创建一个长条 Cube
2. 添加 Bevel 修改器 → 再添加 Array 修改器
3. 观察：每个副本都有倒角
4. 调换顺序：把 Array 拖到 Bevel 上面
5. 观察：先复制再倒角，边界处出现错误倒角

**Step 8：应用修改器**
- 选中修改器 → 左侧下拉箭头 → `Apply`（或 `Ctrl + A`）
- ⚠️ 应用后不可逆，但能提升性能
- 建议：最终导出/渲染前再应用，编辑过程中保持非破坏性

### ✅ 完成标准

- [ ] 能在属性编辑器中添加和删除修改器
- [ ] 能配置 Mirror 修改器并理解 Bisect 的作用
- [ ] 能使用 Subdivision Surface + Edge Crease 控制模型光滑度
- [ ] 能用 Solidify 给平面加厚度
- [ ] 理解修改器堆栈的顺序重要性
- [ ] 能区分应用修改器与保留修改器的场景

### 📖 费曼三句话

1. 修改器是非破坏性编辑——随时可以改参数或删除，不影响原始几何体。
2. 修改器按从上到下的顺序叠加效果，调换顺序会改变最终结果。
3. 镜像 + 细分 + 实体化是建模"三件套"：Mirror 省一半工作量，Subdivision Surface 加光滑度，Solidify 加厚度。

---

## 🍅7 布尔运算与补面技巧（25分钟）

### 费曼输入（概念解释）

**布尔运算（Boolean）** 源自集合论，在 3D 中通过计算两个物体的交集/并集/差集来生成新形状。可以想象成一个"冲压机"或"模具"：

| 模式 | 效果 | 想象 |
|------|------|------|
| Difference（差集） | A 减去 B 的形状 | 在墙上凿洞 |
| Union（并集） | A 和 B 合并 | 焊接两段金属 |
| Intersect（交集） | A 和 B 重叠部分 | 只保留相交区域 |

布尔运算很方便，但常产生**坏拓扑**（三角面、重叠顶点、法线错误），需要配合**补面技巧**来修复。

### 刻意练习（具体操作步骤 + 代码/命令）

**Step 1：基础布尔操作**
1. 创建主物体：`Shift + A` → Cube（作为被操作体）
2. 创建工具物体：`Shift + A` → Cylinder（作为操作体），移动到 Cube 上方，一部分插入 Cube
3. 选中有修改器的物体，添加 Boolean 修改器：
   - Operation：Difference
   - Object：pick Cylinder（吸管选择）
4. 勾选 `Self Intersection` 和 `Hole Tolerant`（提高成功率）
5. 观察：Cube 上被 Cylinder 穿过的地方挖了一个洞 ✅

**Step 2：三种模式对比**
1. 复制三个 Cube，各配备一个 Cylinder
2. 分别设为 Difference / Union / Intersect
3. 观察区别：
   - Difference：洞或切口
   - Union：两体合为一体
   - Intersect：只保留相交部分

**Step 3：法线检查与修复**
布尔失败的第一原因就是**法线方向错误**
1. 选中物体，进入 Edit Mode
2. 打开 Overlays（右上角）→ 勾选 Face Orientation
   - 蓝色 = 法线朝外（正确）
   - 红色 = 法线朝内（错误）
3. 如果有红色面：选全部顶点 → `Shift + N`（Recalculate Normals）
4. 也可以在 Object Mode 直接：`Shift + N` 重算法线

**Step 4：布尔后的经典问题修复**
1. **网格混乱** → 添加 Remesh 修改器尝试重建拓扑
2. **多余顶点** → Edit Mode → `A` 全选 → `M` → By Distance（合并重叠顶点）
3. **坏面** → `F`（连接两个顶点/边形成面）
4. **锯齿边缘** → 布尔后加 Bevel 修改器

**Step 5：补面核心技巧**

| 快捷键 | 功能 | 使用场景 |
|--------|------|----------|
| `F` | 连接顶点/边/面 | 补洞、快速封面 |
| `J` | 连接顶点并切分面 | 把四边形分成两个三角面 |
| `Ctrl + Shift + B` | 顶点倒角 | 顶点变成小斜面 |
| `G + G` | 沿边滑动顶点 | 调整不破坏拓扑 |
| `K` | 切刀工具 | 手动补面/加线 |

**Mesh → Clean Up 菜单功能介绍**：
- Merge By Distance：去重
- Split Non-Planar Faces：拆分非平面面
- Delete Loose：删除孤立点/边
- Fill Holes：自动补洞

**Step 6：实用案例——在立方体上挖圆孔**
1. `Shift + A` → Cylinder（工具体）
2. 将 Cylinder 对齐到 Cube 表面（你可能需要调整视角和位置）
3. 给 Cube 加 Boolean 修改器 → Difference → pick Cylinder
4. 隐藏 Cylinder（`H`）
5. 查看孔洞——边缘可能不平整
6. 给 Cube 加 Bevel 修改器（Width: 0.02m）→ 边缘变平滑
7. 最终效果：一个带倒角圆孔的方块 ✅

### ✅ 完成标准

- [ ] 能使用 Boolean 修改器完成 Difference / Union / Intersect 三种操作
- [ ] 知道如何检查并修正法线方向（Face Orientation + Shift+N）
- [ ] 能用 M → By Distance 合并重叠顶点
- [ ] 能用 F 和 J 补面
- [ ] 完成了"在立方体上挖圆孔"的实用案例

### 📖 费曼三句话

1. 布尔运算像"冲压机"——Difference 凿洞、Union 焊接、Intersect 取交集。
2. 布尔后常需要手动修补坏面：F 补洞、M 合并顶点、Bevel 修边。
3. 法线方向正确是布尔成功的前提——蓝色朝外，红色朝内，Shift+N 一键修复。

---

## 🍅8 硬表面拓扑原则（25分钟）

### 费曼输入（概念解释）

**拓扑（Topology）** 是网格的内部结构——顶点、边、面的连接方式。好的拓扑像精心设计的电路板：有序、高效、可预测。

硬表面模型（机械、武器、建筑、道具）对拓扑的要求是：
- **四边面（Quads）为主**：细分和变形的基础
- **环形边（Edge Loops）流畅**：选择和编辑方便
- **极点（Poles）控制**：避免在视觉重要区域出现N-gon（>4边的面）

记住：**硬表面模型不需要完美拓扑，但需要光滑后轮廓清晰**。不同于角色建模（必须全四边面），硬表面允许在平面区域有少量三角面/N-gon。

### 刻意练习（具体操作步骤 + 代码/命令）

**Step 1：认识好拓扑 vs 坏拓扑**
1. 创建一个 Cube，进入 Edit Mode
2. `Ctrl + R` 环切加循环边 → 看到流畅的四边面环
3. 用 `K` 切刀随意切几刀 → 观察出现的三角面
4. `A` 全选 → 右键 → `Face Data` → `Tris to Quads`（Alt+J）→ 尝试把三角面合并回四边面

**Step 2：环切（Ctrl+R）——保持四边面的最佳武器**
1. 选中物体 → Tab 进入 Edit Mode
2. `Ctrl + R` → 移动鼠标到要加线的位置 → 粉色线预览
3. 左键确认 → 可拖动微调位置 → 左键二次确认
4. 滚轮调整环切数量（加多排线）
5. 练习：在 Cube 的每个轴向各加 2 条环切线

**Step 3：标记锐边（Mark Sharp）**
1. 创建 Cube，添加 Subdivision Surface 修改器
2. 观察：整个立方体变圆了
3. 进入 Edit Mode，选中一条边
4. `Ctrl + E` → `Mark Sharp`（标记为锐边）
5. 在物体数据属性（绿色三角图标）→ Normals → 勾选 `Auto Smooth`
6. 观察：标记的边保持锐利，其余边光滑
7. 补充：`Clear Sharp` 清除标记

**Step 4：倒角加线技巧**
1. 选中一条边 → `Ctrl + B` 倒角
2. 滚轮增加 Segments（段数）
3. 对比：2 segments 的倒角效果 → 实际上加了两排线
4. 这种加线方式可以**自动保持四边面**

**Step 5：环形边与循环边的选择**

| 操作 | 快捷键 | 说明 |
|------|--------|------|
| 选择环形边 | `Alt + 点击` 边 | 选择一个"环"（纵/横向） |
| 选择循环边 | `Ctrl + Alt + 点击` 边 | 选择一条"循环路径" |
| 选择相连 | `L` | 选中与当前顶点相连的全部 |

**Step 6：Knife 工具精讲**
1. 进入 Edit Mode，按 `K` 激活 Knife（切刀）
2. 左键：增加切割点
3. 左键拖动：画切割线
4. `C` 切换：切割时是否切到背面（Cut Through）
5. `Z` 切换：切割线是否保持平直
6. `Enter` 确认切割 / `ESC` 取消
7. 实用贴士：从边的中点切到另一边的中点，可以精准划分四边面

**Step 7：其他拓扑工具**

| 工具 | 快捷键 | 说明 |
|------|--------|------|
| 合并顶点 | `M` | 菜单选择：By Distance（去重）/ At Center（合并到中心） |
| 撕裂面 | `V` | 将选中的顶点"撕开"成独立的 |
| 沿边滑动 | `G + G` | 顶点沿所属边滑动，不破坏拓扑 |
| 断离面 | `Y` | 将选中的面分离开（Split） |
| 桥接循环边 | 面菜单 → Bridge Edge Loops | 连接两个不相连的环形边 |

### ✅ 完成标准

- [ ] 理解"好拓扑 = 四边面为主 + 环形边流畅 + 极点不显眼"
- [ ] 能用 Ctrl+R 环切保持四边面结构
- [ ] 能用 Mark Sharp + Auto Smooth 控制细分锐边
- [ ] 能用 Alt+点击快速选择环形边
- [ ] 能用 K 切刀和 M 合并顶点进行手动拓扑调整

### 📖 费曼三句话

1. 好拓扑 = 四边面为主 + 环形边流畅 + 极点不显眼，硬表面模型不需要完美但需要光滑后轮廓清晰。
2. Ctrl+R 环切是保持四边面的最佳武器——自动生成完整一圈四边面。
3. Mark Sharp + Auto Smooth 组合可以替代昂贵的 Bevel 加线：标记哪些边保持锐利即可。

---

## 🍅9 曲线建模与倒角（25分钟）

### 费曼输入（概念解释）

**曲线（Curve）** 是数学定义的"线"——不占用大量顶点，渲染时可以转成精细网格。Blender 中有三种曲线类型：

| 类型 | 特点 | 用途 |
|------|------|------|
| Bezier（贝塞尔） | 控制柄调节曲率 | 最常用，适合大多数曲线 |
| NURBS | 控制点权重调节 | 工业设计、汽车曲面 |
| Poly（多边形曲线） | 直线段组成 | 简单路径 |

曲线的核心用途：
1. **管道/线缆**：曲线 + Bevel 设置 = 快速生成管状几何体
2. **路径动画**：物体沿曲线运动
3. **轮廓线**：作为建模的参考线或挤压基础形状

### 刻意练习（具体操作步骤 + 代码/命令）

**Step 1：创建和编辑曲线**
1. `Shift + A` → Curve → Bezier（创建贝塞尔曲线）
2. 进入 Edit Mode → 看到两端的控制点和控制柄
3. **添加点**：选中一个端点 → `E`（延伸曲线）
4. **添加中间点**：选中两个端点 → `F`（连接成线段）
5. **移动控制柄**：选中控制柄端点 → `G` 拖动
6. **切换控制柄类型**：选中控制点 → `V` → 选择类型：
   - Free（自由）—— 两边独立转动
   - Aligned（对齐）—— 两边对称转动
   - Vector（矢量）—— 尖锐转角
   - Auto（自动）—— 自动计算平滑

**Step 2：曲线 Bevel 设置——快速做管道**
1. 选中曲线
2. 属性编辑器 → 绿色曲线图标（Curve Properties）
3. 在 Geometry 面板 → Bevel 部分：
   - **Round**：圆管（设置 Depth = 0.1m 试一下）
   - **Object**：以另一个物体作为截面（创建一个小 Circle 作为截面）
4. 观察：一条线变成了三维管道！

| 参数 | 作用 |
|------|------|
| Depth | 管径（圆管半径） |
| Resolution | 管道光滑度（默认为 4，越大越圆） |
| Fill Caps | 管道的两端是否封口 |
| Object | 自定义截面形状 |

**Step 3：实用案例——做一根水管**
1. `Shift + A` → Curve → Bezier
2. 在 Edit Mode 中 `E` 延伸几次，用控制柄调节成水管走向（可以有弯折）
3. 在 Curve Properties → Geometry → Bevel → Depth 设为 0.08m
4. Resolution 设为 6（光滑的水管）
5. 勾选 Fill Caps → 两端封口
6. ✅ 一根 3D 水管完成——只用了少量顶点！

**Step 4：曲线转网格**
1. 选中做好的水管
2. 方法A：`Object → Convert → Mesh`（或 `Alt + C`）
3. 方法B：添加 Curve to Mesh 修改器（更可控，非破坏性）
4. 转换后可以在 Edit Mode 编辑顶点

**Step 5：曲线作为路径——物体沿路径运动**
1. `Shift + A` → Curve → Bezier
2. `Shift + A` → Mesh → Cube（作为运动的物体）
3. 选中 Cube → 添加 **Curve 修改器**：
   - Curve Object：选择刚才创建的曲线
4. 沿曲线轴移动 Cube → Cube 沿着曲线"行走"
5. 这种技术在动画中常用于：摄像机路径、子弹轨迹、过山车

**Step 6：曲线做文字（额外技巧）**
1. `Shift + A` → Curve → Text
2. 在 Edit Mode 中输入文字
3. Curve Properties → Geometry → Bevel 给文字加厚度
4. 文字立刻变成 3D 立体字！

### ✅ 完成标准

- [ ] 能创建和编辑 Bezier 曲线
- [ ] 能用 V 切换控制柄类型（Free / Aligned / Vector / Auto）
- [ ] 能用曲线 + Bevel 设置做出管状物体
- [ ] 能将曲线转换为网格
- [ ] 理解曲线作为 Path 的用法

### 📖 费曼三句话

1. 曲线是数学定义的"线"，不占大量顶点——用少量控制点就能定义复杂形状。
2. 曲线的 Bevel 设置是快速制作管道/电线/边框的最佳途径：Depth 控制粗细，Object 控制截面形状。
3. 曲线可以作为物体运动的路径（Curve 修改器），是动画中摄像机轨道和物体路径的底层技术。

---

## 🍅10 硬表面综合实战（科幻道具/武器）（25分钟）

### 费曼输入（概念解释）

现在是时候把所有技能串起来了。本次实战将制作一把**科幻手枪**风格的硬表面模型。你将用到：

- **基础几何体**：Cube、Cylinder
- **修改器堆栈**：Mirror + Subdivision Surface + Bevel + Solidify + Boolean
- **拓扑控制**：Ctrl+R 环切、Mark Sharp、Edge Crease
- **曲线建模**：做线缆/管道装饰

核心思维：**硬表面建模 = 基础几何 + 修改器堆栈 + 手工调整**。先用大形状块搭轮廓（不关心细节），再逐步添加细节（布尔挖槽、倒角、加线），最后精修。

### 刻意练习（具体操作步骤 + 代码/命令）

**Step 1：搭建基础轮廓**
1. `Ctrl + N` 新建场景，删掉默认立方体（`X` → Delete）
2. **枪身主体**：`Shift + A` → Cube，`S` 缩放成扁长方体（约 2:1:0.5 比例）
3. **枪管**：`Shift + A` → Cylinder，`S` 细长，`G` 移动到枪身前方
4. **握把**：`Shift + A` → Cube，缩放成握把形状，旋转适当角度（`R`），移动到枪身后下方
5. 此时你有一个"三件套"——先不调细节，只用基础形状搭轮廓

**Step 2：Mirror 对称**
1. 选中枪身 → Tab 进入 Edit Mode
2. 在 X 轴上删掉一半顶点（框选左侧 → `X` → Delete Vertices）
3. 添加 **Mirror 修改器**：勾选 X 轴、Bisect + Flip、Merge
4. 对枪管和握把也做同样的操作
5. 现在修改一半，另一半自动同步 ✅

**Step 3：布尔挖槽（散热口/细节）**
1. 创建一个小 Cylinder 作为"钻头"（工具物体）
2. 移动到枪身侧面
3. 给枪身加 Boolean 修改器 → Difference → pick Cylinder → 散热槽成型
4. 隐藏 Cylinder
5. 注意：可能产生坏拓扑，不要紧，下一步处理

**Step 4：倒角 + 细分**
1. 给枪身加 **Bevel 修改器**（Width: 0.02m, Segments: 2）
2. 给枪身加 **Subdivision Surface 修改器**（Levels: 1-2）
3. 修改器堆栈顺序：
   ```
   Boolean → Bevel → Subdivision Surface
   ```
   为什么这个顺序？布尔产生坏边 → 倒角修边 → 细分圆滑 ✅

**Step 5：曲线做线缆装饰**
1. `Shift + A` → Curve → Bezier
2. 在 Edit Mode 中调整曲线走向，让它在枪身上"缠绕"
3. Curve Properties → Geometry → Bevel → Depth 0.015m
4. 一条科技感线缆就做好了！
5. 可以用 `Shift + D` 复制几条，摆在不同位置

**Step 6：Solidify 加厚度**
1. 如果枪身某些部分（如弹匣口的薄壳）需要厚度：
   - 选中那部分面 → `P` → Selection（分离成独立物体）
   - 给分离出的物体加 **Solidify 修改器**
2. 调整 Thickness 让薄壳看起来有实际厚度

**Step 7：Edge Crease 控制锐利度**
1. 选中需要保持锐利的边（如枪管边缘）
2. `Shift + E` → 拖动鼠标 → 边变白（完全锐利）
3. 这让你可以用更高的细分级别而不丢失硬边轮廓

**Step 8：应用修改器（可选）**
1. 最终确定造型后，可以应用修改器：
   - 逐个选中修改器 → Apply（或 `Ctrl + A`）
   - ⚠️ 建议先保存备份再应用
2. 应用后成为常规网格，可以继续精细编辑

**Step 9：拓扑检查**
1. 进入 Edit Mode
2. 打开 Overlays → 勾选 Statistics
3. 查看信息：Vertices / Edges / Faces / Tris
4. 留意 N-gon 和三角面的数量
5. 用 `Alt + J` 尝试把三角面合并成四边面

**扩展思路：更多科幻道具创意**

| 道具 | 核心技巧 |
|------|----------|
| 科幻门框 | Boolean 挖槽 + Array 排列铆钉 |
| 机械臂 | Cylinder 关节 + Curve 管线 |
| 能量核心 | Sphere + Subdivision + 发光材质 |
| 头盔 | Mirror + 曲线轮廓 + Solidify |

### ✅ 完成标准

- [ ] 用基础几何体搭出了手枪的轮廓（枪身+枪管+握把）
- [ ] 正确配置了 Mirror 修改器实现对称建模
- [ ] 用 Boolean 挖出了散热槽或细节凹槽
- [ ] 修改器堆栈顺序正确：Boolean → Bevel → Subdivision Surface
- [ ] 用曲线 + Bevel 做了至少一根线缆装饰
- [ ] 用 Edge Crease (Shift+E) 控制了细分后的锐利度
- [ ] 完成了拓扑检查，能说出模型的顶点数和三角面数

### 📖 费曼三句话

1. 硬表面建模 = 基础几何 + 修改器堆栈 + 手工调整——先用大块形状搭轮廓，再逐层加细节。
2. 镜像修改器让对称建模效率翻倍——只做一半，另一半自动生成，武器、车辆、建筑皆适用。
3. 倒角是让硬表面模型从"假"变"真"的关键一步——真实世界的物体没有完全锐利的边缘，微小的倒角让模型看起来有分量感。

---

> **模块 A 完成！** 你已经掌握了修改器堆栈、布尔运算、拓扑原则、曲线建模，并完成了一个科幻道具的综合实战。接下来可以进入模块 B：材质灯光与渲染。
