# 🍅 20番茄 Godot 4.x 关键知识速通教程

> ⏱ **预估总时间**：20个番茄钟（25分钟×20 = 500分钟 ≈ 8.3小时）
> 🎯 **学习方式**：边读边操作，每番茄后必须动手练
> 🧠 **教学方法**：番茄工作法（节奏控制）+ 费曼学习法（深度理解）+ 刻意练习（技能固化）
> 🎮 **最终目标**：掌握核心能力，独立开发2D/极简3D小游戏
> 📌 **版本说明**：以 Godot 4.x 为主（v4.3+），关键处标注与 Godot 3.x 的差异

---

# 📋 总览图

```
基础准备 ──→ 编程核心 ──→ 2D实战 ──→ 丰富内容 ──→ 3D与进阶
番茄1-4     番茄5-8      番茄9-12    番茄13-16     番茄17-20
```

| 模块 | 番茄 | 核心内容 |
|:-----|:----:|:---------|
| **基础准备** | 1-4 | 安装介绍、编辑器界面、节点与场景、GDScript语法速通 |
| **编程核心** | 5-8 | 信号系统、生命周期、向量数学、输入系统 |
| **2D实战** | 9-12 | 角色移动/碰撞、跳跃/重力、射击/AI、关卡/状态管理 |
| **丰富内容** | 13-16 | UI系统、动画、音频、粒子与特效 |
| **3D与进阶** | 17-20 | 3D基础、极简3D实战、Shader可视化、发布与优化 |

---

## 🍅 模块一：基础准备（番茄1-4）

---

## 🍅 番茄1：Godot简介、安装与第一个项目（25分钟）

### 1.1 Godot是什么？为什么选它？

**用大白话讲：**
Godot 是一个完全免费、开源的游戏引擎。就像 Unity 或 Unreal 的"免费表弟"，但它连"免费"的"高级版"都没有——**全部功能永久免费，无版税，无分成**。你做的游戏赚了100万，Godot 开发者一分钱都不要。

**类比**：如果说 Unity 是 iPhone（功能全但苹果抽成），那 Godot 就是 Android（开源，自由，但需要自己折腾一些东西）。

**核心亮点：**
- 🆓 **完全免费**：MIT 协议，商用无限制
- 📦 **安装包极小**：~50MB（Unity 几个G，Unreal 几十G）
- 🐍 **自研脚本 GDScript**：语法像 Python，专为游戏设计
- 🎨 **节点-场景架构**：像搭乐高一样做游戏
- 🌍 **活跃社区**：2023-2024 年用户暴增

### 1.2 Godot 4.x vs Godot 3.x 关键差异

| 特性 | Godot 3.x | Godot 4.x |
|:-----|:----------|:----------|
| **渲染引擎** | OpenGL ES 3.0 | Vulkan (Forward+ / Mobile) |
| **GDScript** | 旧版语法 | 新语法（+ typed数组、lambda等） |
| **物理引擎** | GodotPhysics (旧) | GodotPhysics 4.0（重写）+ Jolt 可选 |
| **TileMap** | 旧版 | TileMapLayer + TileSet 彻底重做 |
| **粒子系统** | Particles2D（旧） | GPUParticles2D / CPUParticles2D |
| **3D光照** | 有限 | SDFGI（类似光追效果）|
| **文件系统** | .res/.tres | .res/.tres 兼容，推荐 .tscn |
| **C#支持** | Mono | .NET 6+（需手动启用）|

**💡 迁移提示**：如果你是 Godot 3 老用户，最需要适应的是：**TileMap 重做**、**GDScript 语法变化**（`is` 代替 `is` 关键词增强）、**物理层变化**。

### 1.3 安装与第一个项目

**下载安装：**
1. 访问 [godotengine.org/download](https://godotengine.org/download)
2. 选择 **Godot 4.3+**（带 `.NET` 的版本如果需要 C#）
3. 解压即用，无需安装！（绿色软件）

**创建第一个项目：**

```gdscript
# 不用急着写代码，先操作流程
# 步骤：
# 1. 打开 Godot → "New Project"
# 2. 项目名 → "MyFirstGame"
# 3. 选择保存路径
# 4. 选择 "Forward+" 渲染器（默认，支持3D）
#    - 如果做纯2D，可改为 "Mobile" 更轻量
# 5. 点击 "Create & Edit"
```

**已知坑：**
- 路径不要有中文（部分插件不兼容）
- .NET 版本需要额外安装 .NET SDK 6.0+
- 笔记本双显卡用户注意选择高性能显卡运行

> ✋ **费曼自测**：用三句话向朋友解释"Godot 是什么，凭什么值得学"。如果能说清楚，说明你理解了。

---

## 🍅 番茄2：编辑器界面详解（25分钟）

### 2.1 编辑器布局——你的"游戏工厂"

**用大白话讲：**
打开 Godot 后，你看到一个分成几块的窗口。别慌——这个布局就像一个**汽车工厂**的车间布局：

| 面板 | 叫什么 | 有什么用 |
|:-----|:-------|:---------|
| **Scene** (左) | 设计台 | 看到整个场景的节点树 |
| **Viewport** (中) | 装配车间 | 可视化拖拽摆放物体 |
| **FileSystem** (下左) | 仓库 | 所有素材文件在这里 |
| **Inspector** (右) | 属性面板 | 选中东西后看/改它的属性 |
| **Node** (右，标签) | 信号/连接板 | 节点之间的连接 |

**快捷键速记：**

| 按键 | 功能 | 记忆法 |
|:-----|:-----|:-------|
| `W` | 移动工具 | **W**alk 移动 |
| `E` | 旋转工具 | **E** rotate... 不好记，但 `E` 就在 `W` 旁边 |
| `R` | 缩放工具 | **R**esize 缩放 |
| `F` | 聚焦选中物体 | **F**ocus 聚焦 |
| `Ctrl+S` | 保存场景 | 你懂的 |
| `F6` | 运行当前场景 | |
| `F5` | 运行主场景 | |
| `Ctrl+Shift+F` | 全局搜索 | |

### 2.2 核心面板精讲

**Scene 面板（节点树）：**
- 每个游戏对象 = 一个**节点**（Node）
- 节点有父子关系（像文件夹套文件夹）
- 整个树 = 完整的游戏世界

**Inspector（属性面板）：**
- 选中节点后，这里显示它的所有属性
- 属性可以手动改，也可以在代码里改
- 右上角小锁 → 锁定当前选中，避免误点丢失

**FileSystem（文件系统）：**
- 项目的 `res://` 路径（res = resources，项目根目录）
- 所有图片、声音、脚本都在这里管理
- 右键 → "New Folder" 整理素材

**Godot 4.x 新增：**
- **底部「Debugger / Output / Audio」** 面板集成更好
- **Remote 模式**（运行中查看场景树）更直观

### 2.3 自定义布局

**操作：**
```
Layout（右上角）→ 可以选择预设布局
  - Default：全能型
  - 2D：最大化 2D 视口
  - 3D：最大化 3D 视口
  - Script：切换到代码编辑布局
```

**💡 建议**：学2D时用 `2D` 布局，写代码时切 `Script` 布局，用熟了再用 `Default`。

> ✋ **费曼自测**：闭眼说出 Godot 编辑器的 4 个主要面板名称和它们各自的功能。说不全？翻回去再看一遍。

### 🛠 番茄1-2小练习
1. 下载安装 Godot 4.3+
2. 创建项目，浏览各个面板
3. 尝试拖拽一个 Node2D 到场景中
4. 按 `W/E/R` 看看变换效果
5. 按 `F` 聚焦节点

---

### 🍅 番茄1-2结束，休息5分钟
**回顾清单：**
- ✅ Godot 是什么（免费开源游戏引擎）
- ✅ Godot 4.x vs 3.x 核心差异（Vulkan、GDScript新语法、TileMap重做）
- ✅ 安装流程（解压即用）
- ✅ 编辑器五面板（Scene/Viewport/FileSystem/Inspector/Node）
- ✅ 核心快捷键（W/E/R/F/Ctrl+S）

---

## 🍅 番茄3：节点与场景——搭乐高的艺术（25分钟）

### 3.1 节点（Node）——游戏的"原子"

**用大白话讲：**
如果你的游戏是乐高城堡，那**节点**就是每一块乐高积木。每块积木能做一件事：

- **Node2D** → 有位置/旋转/缩放的积木（2D游戏基石）
- **Sprite2D** → 能显示图片的积木
- **CollisionShape2D** → 能检测碰撞的积木
- **AudioStreamPlayer2D** → 能播放声音的积木
- **Control** → 能做按钮/菜单的积木（UI专用）

**核心思维转变：**
| 之前（传统编程） | 之后（Godot 思维） |
|:-----------------|:-------------------|
| 写一个 Player 类 | 拼一组节点组成 Player |
| 用继承复用代码 | 用**场景实例化**复用 |
| 函数之间调用来通信 | 用**信号**来通知 |

```gdscript
# 关键理解：节点不是一个"类"的实例
# 节点 = 一个有特定功能的小积木
# 你的角色 = 多个积木拼在一起
```

### 3.2 场景（Scene）——"拼好的模型"

**用大白话讲：**
场景就是你把一堆节点拼好之后**保存起来的成品**。就像你拼好了一个乐高小汽车，然后把它整个当成一个零件用在更大的城堡里。

**场景的特点：**
1. 任何节点都可以作为场景的"根"（Root）
2. 场景可以嵌套到另一个场景中（instancing）
3. `.tscn` 是场景文件格式（Godot 4 主推）

**创建 Player 场景示例：**
```
Player (Area2D)         ← 根节点，负责检测碰撞
├── Sprite2D            ← 显示角色图片
├── CollisionShape2D    ← 碰撞区域
└── AudioStreamPlayer2D ← 播放脚步声
```

```gdscript
# 关键理解：这个"Player"场景可以被反复使用
# 像印章一样，盖多少次都行
```

### 3.3 场景实例化——代码实现

```gdscript
# 加载场景（方法一：预加载，推荐）
var bullet_scene = preload("res://scenes/bullet.tscn")

# 加载场景（方法二：动态加载）
var enemy_scene = load("res://scenes/enemy.tscn")

# 实例化并添加到场景
func spawn_bullet():
    var bullet = bullet_scene.instantiate()  # 盖个印章
    add_child(bullet)                         # 装到场景中
    bullet.position = $Muzzle.global_position # 设置位置
```

**Godot 4.x 新增便利：**
- `@export` 注解：在 Inspector 中直接拖拽场景文件

```gdscript
@export var bullet_scene: PackedScene  # 直接在编辑器拖拽赋值！
```

### 3.4 节点路径与 `$` 语法

```gdscript
# $ 是 get_node() 的简写
$Sprite2D                    # 直接子节点
$"玩家/身体/Sprite2D"        # 深层路径（中文名要加引号）
get_node("玩家/身体/Sprite2D") # 完整写法

# Godot 4 推荐的 @onready 写法
@onready var sprite = $Sprite2D  # 场景加载完成后赋值
```

> ✋ **费曼自测**：用"乐高积木"的类比，向新手解释"节点"和"场景"的区别。如果你能用这个比喻说明白，你就真懂了。

---

## 🍅 番茄4：GDScript 基础语法速通（25分钟）

### 4.1 GDScript 是什么？

**用大白话讲：**
GDScript 是 Godot 自创的脚本语言，语法和 Python 很像。如果 Python 是"通用编程语言"，GDScript 就是"专为游戏定制的 Python"——少了通用功能，多了游戏专用功能。

**和 Python 的区别：**
| 特性 | Python | GDScript |
|:-----|:-------|:---------|
| 缩进 | 强制 | 强制 ✅ 一样 |
| 变量 | `x = 1` | `var x = 1` ✅ 类似 |
| 函数 | `def` | `func` |
| 类 | `class` | `class_name` + 文件名即类名 |
| 继承 | `class A(B)` | `extends B` |
| 布尔 | `True/False` | `true/false` |
| 注释 | `#` | `#` ✅ 一样 |

### 4.2 变量与类型

```gdscript
# 基本变量声明
var health = 100                     # 动态类型
var speed: float = 300.0             # 静态类型（Godot 4 推荐）
var player_name: String = "Hero"
var is_alive: bool = true

# 常用类型
var position: Vector2 = Vector2(100, 200)  # 2D位置
var direction: Vector3 = Vector3(0, 0, -1) # 3D方向
var color: Color = Color.RED               # 颜色

# 常量
const GRAVITY: float = 980.0
const MAX_SPEED: float = 500.0

# @export：在 Inspector 面板可见！
@export var jump_height: float = 10.0
@export var starting_health: int = 3
@export var item_list: Array[String] = []  # 类型化数组（Godot 4 新特性）
```

**Godot 3 vs 4 变量差异：**
```gdscript
# Godot 3 (旧)
export var speed = 300  # export 关键词

# Godot 4 (新)
@export var speed: float = 300  # @export 注解 + 类型注解
```

### 4.3 函数与控制流

```gdscript
# 函数定义
func take_damage(amount: int) -> void:
    health -= amount
    if health <= 0:
        die()

func die() -> void:
    queue_free()  # 从场景中删除自己

# 带返回值
func calculate_damage(base: int, multiplier: float = 1.0) -> int:
    return int(base * multiplier)

# 条件判断
var score := 50
if score >= 100:
    print("通关！")
elif score >= 50:
    print("继续加油")
else:
    print("再来一次")

# 循环
for i in range(10):        # 0-9
    print(i)

for child in get_children():  # 遍历子节点
    print(child.name)

var i := 0
while i < 10:
    print(i)
    i += 1

# match（Godot 4 增强版 switch）
match direction:
    "left":
        position.x -= 10
    "right":
        position.x += 10
    _:  # 默认
        pass
```

### 4.4 代码实战：简单的计数器

```gdscript
extends Node2D

@export var count: int = 0
@onready var label: Label = $Label  # 假设有个Label子节点

func _ready() -> void:
    update_label()

func increment() -> void:
    count += 1
    update_label()

func reset() -> void:
    count = 0
    update_label()

func update_label() -> void:
    label.text = "计数: " + str(count)
```

**刻意练习：**
1. 新建一个 Node2D 场景
2. 添加一个 Label 子节点
3. 把上面的代码粘贴到根节点的脚本上
4. 在运行后，观察 Inspector 面板里的 `count` 属性

> ✋ **费曼自测**：不看书，写一个函数：输入两个数，返回它们的乘积，并在函数里加一个默认参数。写不出？再读一遍 4.3 节。

### 🛠 番茄3-4小练习
1. 搭建一个"玩家"场景（Area2D + Sprite2D + CollisionShape2D）
2. 用 `@export` 暴露 `speed` 和 `health` 属性
3. 写一个 `_ready()` 函数，打印"Hello Godot!"
4. 运行场景看看效果

---

### 🍅 番茄3-4结束，休息5分钟
**回顾清单：**
- ✅ 节点 = 功能积木，场景 = 拼好的模型
- ✅ `$` = `get_node()` 简写，`@onready var` = 延迟初始化
- ✅ `@export` 曝光属性到 Inspector
- ✅ GDScript 语法：`var`/`func`/`if`/`for`/`match`
- ✅ 场景实例化 `preload()` → `.instantiate()` → `add_child()`

---

## 🍅 模块二：编程核心（番茄5-8）

---

## 🍅 番茄5：信号系统——节点间的"对讲机"（25分钟）

### 5.1 信号是什么？为什么需要它？

**用大白话讲：**
想象你在厨房做饭，烤箱"叮"的一声响了——这个"叮"就是一个**信号**。你不知道烤箱内部怎么判断时间到了，你只需要听到"叮"后去拿菜。

在 Godot 里，信号也是这么回事：
- 一个按钮被点击 → 发信号
- 两个物体碰撞 → 发信号
- 计时器到时间 → 发信号

**不用信号的问题：**
```gdscript
# ❌ 耦合严重：Button 要知道 GameManager 的存在
# Button 里面写：
func _pressed():
    get_node("/root/GameManager").start_game()
```

**用信号的好处：**
```gdscript
# ✅ 松耦合：Button 只管发信号，谁接收不知道
# Button 发 "pressed" 信号
# GameManager 在编辑器里连接这个信号

# GameManager 里：
func _on_button_pressed():
    start_game()
```

### 5.2 信号连接的三种方式

**方式一：编辑器连接（最推荐初学者）**
```
1. 选中发信号的节点（如 Button）
2. 切到 Node 标签（右侧面板）
3. 双击信号（如 "pressed()"）
4. 选择接收节点（如 Control 根节点）
5. 点击 "Connect"
```
结果：Godot 自动在接收节点生成 `func _on_button_pressed():`

**方式二：代码连接**
```gdscript
# 更灵活，适合动态创建的节点
var button = Button.new()
button.text = "点我"
add_child(button)

# 连接信号
button.pressed.connect(_on_button_pressed)

# 带参数的信号
button.toggled.connect(_on_button_toggled)

func _on_button_pressed():
    print("按钮被点击了！")

func _on_button_toggled(toggled_on: bool):
    print("开关状态:", toggled_on)
```

**方式三：单次连接（Godot 4 新特性）**
```gdscript
# 只触发一次，自动断开
button.pressed.connect(_on_button_pressed, CONNECT_ONE_SHOT)
```

### 5.3 自定义信号——"发明自己的对讲机频道"

```gdscript
extends CharacterBody2D

# 定义信号（相当于注册一个新频道）
signal health_changed(new_health: int)
signal died()
signal enemy_hit(damage: int, attacker: Node)

@export var health: int = 100

func take_damage(amount: int) -> void:
    health -= amount
    
    # 发射信号（相当于在对讲机上说话）
    health_changed.emit(health)
    
    if health <= 0:
        died.emit()

func attack_enemy() -> void:
    # 发射带多个参数信号
    enemy_hit.emit(50, self)
```

**接收自定义信号：**
```gdscript
# 在其他节点中
$Player.health_changed.connect(_on_player_health_changed)
$Player.died.connect(_on_player_died)

func _on_player_health_changed(new_health: int):
    # 更新血条UI
    $HealthBar.value = new_health

func _on_player_died():
    get_tree().change_scene_to_file("res://game_over.tscn")
```

### 5.4 信号 vs 直接调用——何时用哪个？

| 场景 | 用信号 | 直接调用 |
|:-----|:-------|:---------|
| 按钮被点击 | ✅ 标准用法 | ❌ |
| 两个系统解耦 | ✅ 完美 | ❌ |
| 子节点调用父节点 | ❌ | ✅ `parent_func()` |
| 紧急的"立刻执行" | ❌ 有微小延迟 | ✅ |
| 一个事件触发多个响应 | ✅ 天然支持 | ❌ 需要手动写循环 |

> ✋ **费曼自测**：用"厨房烤箱"的比喻解释信号的三个要素：谁发信号、信号内容是什么、谁处理信号。

### 🛠 番茄5小练习
1. 创建一个 Timer 节点（"烤箱"）
2. 连接它的 `timeout` 信号
3. 在信号处理函数里打印"叮！饭好了！"
4. 再添加一个自定义信号 `game_started`
5. 在 `_ready()` 中发射它

---

## 🍅 番茄6：生命周期函数与节点操作（25分钟）

### 6.1 核心生命周期函数

**用大白话讲：**
每个节点从出生到销毁，会经历一系列"人生阶段"。Godot 在这些阶段自动调用对应函数，你只需"填空"。

```gdscript
extends Node

# 生命周期顺序：
# _init → _enter_tree → _ready → _process/_physics_process → _exit_tree

func _init() -> void:
    # 1. 构造函数：节点刚被创建时
    # 🔴 此时场景还没加载完，不要操作其他节点！
    print("我出生了（但还没进入场景）")

func _enter_tree() -> void:
    # 2. 进入场景树：节点被加到场景中
    # 此时可以操作自身，但子节点可能还没 ready
    print("我进入场景了")

func _ready() -> void:
    # 3. ⭐ 最常用的！节点及其所有子节点已就绪
    # 90%的初始化代码写在这里
    print("我和所有孩子都准备好了！")
    # 此时可以安全操作 $ChildNode

func _process(delta: float) -> void:
    # 4. ⭐ 每帧调用（约60次/秒）
    # 💡 放"需要每一帧都更新"的代码
    # delta = 上一帧到这一帧的时间（秒）
    print("当前帧率:", 1.0 / delta)

func _physics_process(delta: float) -> void:
    # 5. ⭐ 物理帧（固定60 FPS）
    # 💡 放物理相关代码：移动、跳跃、碰撞检测
    # 比 _process 更稳定，不受帧率波动影响

func _exit_tree() -> void:
    # 6. 离开场景树：节点被移除
    # 执行清理工作
    print("我被移除了，再见！")
```

### 6.2 `_process` vs `_physics_process`——黄金选择

| | `_process(delta)` | `_physics_process(delta)` |
|:--|:------------------|:--------------------------|
| **调用频率** | 每帧，**不固定** | 固定 60 次/秒 |
| **delta 值** | 随帧率变（0.016@60fps） | **固定** 0.01667 |
| **适用场景** | UI更新、动画、非物理移动 | 物理移动、碰撞、跳跃 |
| **同步物理** | ❌ 不保证 | ✅ 与物理引擎同步 |

```gdscript
# 黄金法则（记住这句话）：
# _physics_process → 改变位置的代码
# _process → 改变外观的代码

# ✅ 正确：物理移动
func _physics_process(delta):
    velocity.y += gravity * delta
    move_and_slide()

# ✅ 正确：UI更新
func _process(delta):
    health_bar.text = "❤️ " + str(current_health)

# ❌ 错误：在 _process 里做物理移动
func _process(delta):
    position.x += 100 * delta  # 帧率波动→移动不流畅
```

### 6.3 节点增删操作

```gdscript
# 添加节点
var label = Label.new()
label.text = "动态创建的文字"
add_child(label)      # 加到当前节点下
$SomeContainer.add_child(label)  # 加到指定父节点

# 删除节点
label.queue_free()    # ⭐ 安全删除（当前帧结束后）
# label.free()        # ⚡ 立刻删除（注意：可能导致崩溃）

# 查找节点
get_node("Path/To/Node")     # 绝对路径
$Path/To/Node                # $ 简写
get_parent()                 # 父节点
get_children()               # 所有子节点（返回数组）
find_child("Sprite2D")       # 递归查找
find_children("Enemy*")      # 通配符查找

# 节点类型检查
if $SomeNode is Sprite2D:
    print("这是个精灵")
    
if $SomeNode.has_method("take_damage"):
    $SomeNode.take_damage(10)
```

### 6.4 `@onready` 的魔法

```gdscript
# 没有 @onready 时：
var health_bar  # 先声明
func _ready():
    health_bar = $HUD/HealthBar  # 再赋值

# 有 @onready 时：（推荐）
@onready var health_bar = $HUD/HealthBar
# 等价于 = 在 _ready() 开始时执行

# 高级用法：
@onready var player = $"../Player"  # 兄弟节点
@onready var timer = $Timer as Timer  # 类型转换

# Godot 4 新增：@onready + @export 组合
@export var player_path: NodePath = @"../Player"
@onready var player = get_node(player_path)
```

> ✋ **费曼自测**：说出 Godot 中 3 个核心生命周期函数的执行顺序，以及各自适合放什么代码。用"人的一生"来打比喻。

### 🛠 番茄6小练习
1. 新建场景，写 `_ready` 打印"场景就绪"
2. 写 `_process` 让一个 Label 显示当前帧率
3. 写 `_physics_process` 让一个 Sprite2D 匀速向下移动
4. 用 `@onready var` 声明 3 个节点引用

---

## 🍅 番茄7：向量与坐标系统——游戏数学速成（25分钟）

### 7.1 向量——"方向+距离"的打包盒

**用大白话讲：**
向量就是一个箭头：它告诉你**往哪个方向走多远**。

```
       ↑ Vector2(0, -1) 向上
       |
←------+------→ Vector2(1, 0) 向右
(-1,0)  |
       ↓ Vector2(0, 1) 向下
```

```gdscript
# 2D 向量
var right = Vector2.RIGHT    # (1, 0)
var left = Vector2.LEFT      # (-1, 0)
var up = Vector2.UP          # (0, -1) ⚠️ Y轴向下为正
var down = Vector2.DOWN      # (0, 1)

# 3D 向量
var forward = Vector3.FORWARD  # (0, 0, -1)
var back = Vector3.BACK        # (0, 0, 1)

# 重要：Godot 2D 中 Y 轴向下为正！
# 这是计算机图形学的惯例，和数学课上的坐标系不同
```

**费曼时刻：** 想象你在一个 2D 平面地图上。`Vector2(3, 4)` 表示"向东走 3 步，向南走 4 步"。向量就是一个打包好的"方向+距离"指令。

### 7.2 向量的核心操作

```gdscript
var a = Vector2(3, 4)
var b = Vector2(1, 2)

# 加减法
var c = a + b    # (4, 6) ← 两个位移叠加
var d = a - b    # (2, 2) ← 从 a 到 b 的位移

# 乘除（标量）
var doubled = a * 2     # (6, 8)
var half = a / 2        # (1.5, 2)

# ⭐ 长度（模）——这个箭头有多长？
var length = a.length()     # 5.0 （勾股定理：√(3²+4²)=5）
var distance = a.distance_to(b)  # 两点距离

# ⭐ 归一化——保持方向，长度变成1
var dir = a.normalized()    # (0.6, 0.8) ← 长度=1，方向不变

# ⭐ 应用：让角色以固定速度移动
var direction = Vector2(1, 0).normalized()  # (1, 0)
var velocity = direction * 300.0            # (300, 0) ——每秒向右300像素
```

### 7.3 实战：用向量控制移动

```gdscript
extends CharacterBody2D

@export var speed: float = 300.0

func get_input() -> Vector2:
    var direction = Vector2.ZERO  # (0, 0) — 不动
    
    # 输入方向累加
    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1
    
    # 归一化 + 乘以速度
    return direction.normalized() * speed

func _physics_process(delta: float) -> void:
    velocity = get_input()
    move_and_slide()  # ⭐ CharacterBody2D 专属移动函数
```

### 7.4 2D坐标系统精要

```gdscript
# 核心概念：全局坐标 vs 本地坐标

# 全局坐标（global_position）：相对于世界(0,0)
var world_pos = $Player.global_position

# 本地坐标（position）：相对于父节点
var local_pos = $Player.position  

# 坐标转换
var local_to_global(pos)     # 本地→全局
var global_to_local(pos)     # 全局→本地

# 鼠标位置
var mouse_pos = get_global_mouse_position()   # ⭐ 常用！鼠标在世界坐标的位置

# 让角色看向鼠标
$Sprite2D.look_at(get_global_mouse_position())
```

> ✋ **费曼自测**：用"地图上的箭头"比喻，解释 `Vector2(1, 0).normalized() * 500` 的含义。

### 🛠 番茄7小练习
1. 创建 CharacterBody2D，写一个 4 方向移动脚本
2. 获取鼠标位置，让 Sprite2D 的 rotation 指向鼠标（用 `look_at`）
3. 计算两个点之间的距离并打印

---

## 🍅 番茄8：输入系统——让玩家操控游戏（25分钟）

### 8.1 输入映射——"定义你的游戏操作"

**用大白话讲：**
你不需要写"如果按了 W 键"——你需要写"如果玩家按了"向上"键"。至于"向上"是 W 还是 ↑ 还是摇杆往上推，那是**输入映射**（Input Map）决定的。

**设置输入映射：**
```
Project → Project Settings → Input Map
  1. 在 "Add New Action" 输入 "move_left" → Add
  2. 点击 "move_left" 旁的 "+"
  3. 选择 Key → 按 A 键
  4. 再点 "+" → Key → 按 ← 键
  5. 同样的方式创建：
     - move_right (D / →)
     - move_up (W / ↑)
     - move_down (S / ↓)
     - jump (Space)
     - shoot (鼠标左键)
```

```gdscript
# 输入映射的好处：
# 玩家可以在设置里改键位，你一行代码都不用改！
```

### 8.2 输入检测的三种方式

```gdscript
# 1. 按住检测（每帧都检查）——用于移动
func _process(delta):
    if Input.is_action_pressed("move_right"):
        position.x += 300 * delta

# 2. ⭐ 按下瞬间检测（只触发一次）——用于跳跃/射击
func _process(delta):
    if Input.is_action_just_pressed("jump"):
        velocity.y = -500  # 跳跃

# 3. 松开瞬间检测
func _process(delta):
    if Input.is_action_just_released("shoot"):
        print("松开扳机")

# Godot 4 新增：强度检测（手柄、触控板）
var strength = Input.get_action_strength("move_right")
# 键盘返回 0 或 1，手柄摇杆返回 0.0 ~ 1.0
```

### 8.3 完整的角色控制器

```gdscript
extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0  # 负数 = 向上

# 获取重力（4.3+可以直接用 ProjectSettings）
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
    # === 水平移动 ===
    var direction = Input.get_axis("move_left", "move_right")
    # get_axis 返回 -1 ~ 1（左=负，右=正，不动=0）
    
    if direction != 0:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)  # 平滑减速
    
    # === 重力 ===
    if not is_on_floor():
        velocity.y += gravity * delta
    
    # === 跳跃 ===
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity
    
    move_and_slide()
```

**Godot 3 vs 4 输入差异：**
```gdscript
# Godot 3
Input.get_action_strength("ui_right")   # 用内置映射
# Godot 4
Input.get_axis("move_left", "move_right")  # ⭐ 推荐！新函数更简洁
```

### 8.4 多点触控与移动端输入

```gdscript
# 检测全部触摸点
for touch in Input.get_screen_touchs():
    var pos = touch.position
    var pressure = touch.pressure
    
# 虚拟摇杆（结合 Control 节点）
# 1. 创建 TouchScreenButton
# 2. 设置其 shape
# 3. 连接 pressed/released 信号
```

> ✋ **费曼自测**：解释 `Input.get_axis("left", "right")` 返回值的意义：-1、0、1 分别代表什么？为什么比分开检测两个键更好？

### 🛠 番茄8小练习
1. 创建输入映射：move_left/move_right/move_up/move_down/jump
2. 写一个完整的 CharacterBody2D 移动+跳跃脚本
3. 测试：按 WASD 移动，空格跳跃

---

### 🍅 番茄5-8结束，休息5分钟
**回顾清单：**
- ✅ 信号：松耦合通信，`signal` → `.emit()` → `.connect()`
- ✅ 生命周期：`_init` → `_enter_tree` → `_ready` → `_process` → `_exit_tree`
- ✅ 向量：`Vector2` 方向+长度，`.normalized()` 归一化
- ✅ 输入映射：`InputMap` 解耦按键和操作
- ✅ `get_axis()` 处理方向输入

---

## 🍅 模块三：2D游戏实战（番茄9-12）

---

## 🍅 番茄9：角色移动与碰撞检测（25分钟）

### 9.1 三种物理节点的选择

**用大白话讲：**
Godot 2D 物理有 3 种"身体"节点，各有各的用途：

| 节点 | 类比 | 谁控制位置？ | 用途 |
|:-----|:-----|:-------------|:-----|
| **StaticBody2D** | 墙/地面 | Godot（不动） | 地形、平台、墙壁 |
| **RigidBody2D** | 足球 | Godot（物理模拟） | 物理掉落、弹跳、撞飞 |
| **CharacterBody2D** | 人 | **你**（代码控制） | **玩家角色、敌人** |

```gdscript
# 核心选择法则：
# 角色移动 → CharacterBody2D（你说了算）
# 物理互动 → RigidBody2D（物理说了算）
# 静态障碍 → StaticBody2D（永远不动）
```

### 9.2 CharacterBody2D + move_and_slide()

```gdscript
extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 1500.0  # 加速快慢
@export var friction: float = 1000.0      # 摩擦力（减速）

func get_input() -> Vector2:
    var direction = Vector2.ZERO
    direction.x = Input.get_axis("move_left", "move_right")
    direction.y = Input.get_axis("move_up", "move_down")
    return direction.normalized()

func _physics_process(delta: float) -> void:
    var direction = get_input()
    
    if direction != Vector2.ZERO:
        # 加速到目标速度
        velocity = velocity.move_toward(direction * speed, acceleration * delta)
    else:
        # 减速到零
        velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
    
    move_and_slide()  # 执行移动+碰撞检测
```

### 9.3 碰撞检测——"碰到什么了？"

**设置碰撞：**
1. 给 CharacterBody2D 添加 CollisionShape2D 子节点
2. 设置 Shape 属性（RectangleShape2D / CircleShape2D）
3. 调整大小覆盖角色

```gdscript
# 检测碰撞结果
func _physics_process(delta):
    move_and_slide()
    
    # 方法1：获取碰撞信息
    for i in get_slide_collision_count():
        var collision = get_slide_collision(i)
        var collider = collision.get_collider()  # 碰到的节点
        var normal = collision.get_normal()      # 碰撞法线方向
        
        if collider.is_in_group("enemies"):
            take_damage()
    
    # 方法2：检测是否在地面上（CharacterBody2D 特有）
    if is_on_floor():
        print("站在地面上")
    if is_on_wall():
        print("碰到墙了")
    if is_on_ceiling():
        print("撞到天花板了")

# 在 Godot 4 中，move_and_slide() 会自动配置这些检测
# 不需要像 Godot 3 那样额外调用 move_and_collide()
```

### 9.4 Area2D——"感知区域"

**用大白话讲：**
Area2D 就像一个**看不见的感应圈**——它不推东西，但能检测到谁进入了这个范围。

```gdscript
extends Area2D

# Area2D 的典型用途：
# - 捡拾物品（玩家走进→拾取）
# - 触发机关（走进→开门）
# - 伤害区域（站里面→持续扣血）
# - 视野检测（玩家走进敌人视野→追踪）

func _ready():
    # 连接信号
    body_entered.connect(_on_body_entered)
    body_exited.connect(_on_body_exited)
    area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node2D):
    if body.is_in_group("player"):
        print("玩家进入区域！")
        queue_free()  # 金币被捡走

# 常用信号：
# body_entered   → 物理身体进入（Character/Rigid/Static）
# body_exited    → 物理身体离开
# area_entered   → 另一个Area进入
# area_exited    → 另一个Area离开
```

> ✋ **费曼自测**：用一个"房间门口"的类比，分别说明 CharacterBody2D（人）、StaticBody2D（墙）、Area2D（门口的感应器）。

### 🛠 番茄9小练习
1. 创建玩家场景：CharacterBody2D + CollisionShape2D + Sprite2D
2. 编写完整的移动脚本（加速/减速/碰撞）
3. 添加一个 StaticBody2D 作为地面
4. 添加一个 Area2D 作为金币（带 body_entered 信号）

---

## 🍅 番茄10：跳跃与重力系统（25分钟）

### 10.1 物理跳跃——让角色"感觉对"

**用大白话讲：**
好的跳跃 = 让玩家觉得"我控制了角色"，而不是"角色自己飞了"。

```gdscript
extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0  # 初速度（负=向上）
@export var coyote_time: float = 0.1       # "慈悲时间"（掉下边缘后还能跳）
@export var jump_buffer: float = 0.1       # "按键缓冲"（落地前按了跳也算）

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

func _physics_process(delta: float) -> void:
    # === 水平移动 ===
    var direction = Input.get_axis("move_left", "move_right")
    if direction != 0:
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
    
    # === 地面/空中检测 ===
    if is_on_floor():
        coyote_timer = coyote_time      # 重置"慈悲计时"
    else:
        coyote_timer -= delta           # 开始倒计时
    
    # === 跳跃缓冲 ===
    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer
    else:
        jump_buffer_timer -= delta
    
    # === 执行跳跃 ===
    if jump_buffer_timer > 0 and coyote_timer > 0:
        velocity.y = jump_velocity
        coyote_timer = 0.0              # 防止连跳
        jump_buffer_timer = 0.0
    
    # === 重力 ===
    if not is_on_floor():
        # 变量跳跃高度：按得久跳得高
        if velocity.y < 0 and not Input.is_action_pressed("jump"):
            velocity.y += gravity * delta * 2.5  # 松开→下落加速
        else:
            velocity.y += gravity * delta
        
    move_and_slide()
```

**你问为什么要做这些？**
| 技巧 | 效果 | 常见游戏 |
|:-----|:-----|:---------|
| **Coyote Time** | 走出平台边缘后还能跳 | 超级马力欧 |
| **Jump Buffer** | 落地前按了跳→落地自动跳 | 蔚蓝(Celeste) |
| **变量跳跃** | 按多久跳多高 | 大金刚 |
| **松开加速下落** | 跳跃更"脆"不拖泥带水 | 空洞骑士 |

### 10.2 状态机基础——管理角色状态

```gdscript
# 角色状态的枚举
enum State { IDLE, RUN, JUMP, FALL, ATTACK }

var current_state: State = State.IDLE

func _physics_process(delta: float) -> void:
    match current_state:
        State.IDLE:
            # 待机动画
            if direction != 0:
                change_state(State.RUN)
        State.RUN:
            # 跑步动画
            if not is_on_floor():
                change_state(State.JUMP)
        State.JUMP:
            # 跳跃动画
            if velocity.y > 0:
                change_state(State.FALL)

func change_state(new_state: State) -> void:
    # 离开旧状态
    match current_state:
        State.JUMP: jump_buffer_timer = 0  # 防止空中二段跳
    
    current_state = new_state
    
    # 进入新状态
    match current_state:
        State.ATTACK: attack_animation()
```

### 10.3 二段跳与特殊移动

```gdscript
@export var max_jumps: int = 2
var jumps_remaining: int = 2

func _physics_process(delta):
    # 落地重置跳跃次数
    if is_on_floor():
        jumps_remaining = max_jumps
    
    if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
        velocity.y = jump_velocity
        jumps_remaining -= 1
        jumps_remaining = max(jumps_remaining, 0)  # 防止负数
    
    # 冲刺（Dash）
    if Input.is_action_just_pressed("dash") and can_dash:
        var dash_dir = Vector2(direction, 0).normalized()
        velocity = dash_dir * dash_speed
        can_dash = false
        await get_tree().create_timer(dash_cooldown).timeout
        can_dash = true
```

> ✋ **费曼自测**：用"跳台阶"的比喻，解释 Coyote Time（慈悲时间）是什么，为什么它能防止玩家"明明在地面上却跳不起来"的挫败感。

### 🛠 番茄10小练习
1. 在上番茄的角色基础上，添加完整的跳跃系统
2. 实现变量跳跃（按得久跳得高）
3. 添加一个简单的 IDLE/RUN/JUMP 状态机

---

## 🍅 番茄11：射击系统与简单敌人AI（25分钟）

### 11.1 子弹系统——"发射物"

```gdscript
# bullet.tscn 的脚本
extends Area2D

@export var speed: float = 500.0
@export var lifetime: float = 2.0  # 2秒后自动销毁

func _ready():
    # 自动销毁计时
    await get_tree().create_timer(lifetime).timeout
    queue_free()

func _physics_process(delta: float) -> void:
    # 沿当前方向移动
    position += transform.x * speed * delta
    # transform.x = 节点朝向的方向向量

func _on_body_entered(body: Node2D):
    if body.is_in_group("enemies"):
        body.take_damage(10)
        queue_free()  # 命中后销毁

# 注意：记得在 Area2D 上连接 body_entered 信号！
```

### 11.2 射击实现——"发射子弹"

```gdscript
# player.gd
@export var bullet_scene: PackedScene  # 在编辑器拖拽子弹场景
@export var fire_rate: float = 0.2     # 射速间隔
var can_fire: bool = true

func _process(delta: float) -> void:
    if Input.is_action_pressed("shoot") and can_fire:
        fire_bullet()

func fire_bullet() -> void:
    can_fire = false
    
    # 创建子弹
    var bullet = bullet_scene.instantiate()
    get_parent().add_child(bullet)  # 加到场景根（不是加到玩家）
    
    # 从枪口位置发射
    bullet.global_position = $Muzzle.global_position
    bullet.rotation = global_rotation  # 继承玩家朝向
    
    # CD计时
    await get_tree().create_timer(fire_rate).timeout
    can_fire = true
```

**Godot 4 新特性：用 Marker2D 做枪口**
```
Player (CharacterBody2D)
├── Sprite2D (角色图片)
├── CollisionShape2D
├── Marker2D (名字叫 "Muzzle")  ← 标记枪口位置
└── AudioStreamPlayer2D (射击音效)
```
`Marker2D` 替代了 Godot 3 中手动算位置的麻烦——它只是一个位置标记。

### 11.3 简单敌人AI——三种模式

```gdscript
extends CharacterBody2D

enum AIState { IDLE, PATROL, CHASE, ATTACK }
var state: AIState = AIState.IDLE

@export var patrol_range: float = 100.0
@export var chase_speed: float = 150.0
@export var detect_range: float = 200.0

var start_x: float
var direction: int = 1

func _ready():
    start_x = position.x

func _physics_process(delta: float) -> void:
    match state:
        AIState.PATROL:
            # 在范围内来回走动
            velocity.x = direction * chase_speed * 0.5
            if abs(position.x - start_x) > patrol_range:
                direction *= -1  # 掉头
            
            # 检测玩家
            var player = get_tree().get_first_node_in_group("player")
            if player and global_position.distance_to(player.global_position) < detect_range:
                state = AIState.CHASE
                
        AIState.CHASE:
            # 追玩家
            var player = get_tree().get_first_node_in_group("player")
            if player:
                var dir = sign(player.global_position.x - global_position.x)
                velocity.x = dir * chase_speed
            else:
                state = AIState.PATROL
    
    move_and_slide()

# ⭐ 完善敌人
func take_damage(amount: int) -> void:
    health -= amount
    # 受伤闪烁
    modulate = Color.RED
    await get_tree().create_timer(0.1).timeout
    modulate = Color.WHITE
    
    if health <= 0:
        # 死亡效果
        queue_free()
```

### 11.4 碰撞层设置——"谁和谁碰撞？"

**用大白话讲：**
游戏里不是所有东西都要互相撞的。子弹不应该和子弹相撞，敌人不应该和敌人重叠——**碰撞层**就是解决这个的。

**设置：**
```
Project → Project Settings → Layer Names → 2D Physics
  Layer 1: "world"     (墙/地面)
  Layer 2: "player"    (玩家)
  Layer 3: "enemies"   (敌人)
  Layer 4: "bullets"   (子弹)
  Layer 5: "pickups"   (拾取物)
```

**设置各节点碰撞层：**
```
选中节点 → Inspector → Collision → Layer/Mask
  Player:    Layer = 2 (player)
             Mask = 1    (撞world) + 3 (撞enemies) + 5 (撞pickups)
             → 玩家撞墙、撞敌人、捡东西
  Bullet:    Layer = 4 (bullets)
             Mask = 3    (撞enemies)
             → 子弹打敌人，不打玩家不打墙
  Enemy:     Layer = 3 (enemies)
             Mask = 1    (撞world) + 2 (撞player)
```

> ✋ **费曼自测**：用"三张通行证"的比喻解释 Layer 和 Mask 的区别。提示：Layer = "我在哪一层"，Mask = "我能撞哪一层"。

### 🛠 番茄11小练习
1. 创建 Bullet 场景（Area2D + 移动 + 碰撞销毁）
2. 在 Player 中实现射击
3. 创建简单敌人，实现巡逻/追击行为
4. 设置碰撞层（至少 player、enemies、bullets 三层）

---

## 🅰️ 番茄12：游戏状态管理与关卡系统（25分钟）

### 12.1 单例（Autoload）——"全局工具箱"

**用大白话讲：**
单例就是一个**始终存在、谁都能访问**的全局节点。就像一个随身背包——不管你在哪个场景，背包里的东西都在。

```gdscript
# 创建单例文件：global.gd
extends Node

# 游戏全局数据
var score: int = 0
var player_health: int = 3
var current_level: String = "level_1"

# ⭐ 跨场景数据（不用单例就得在各个场景传来传去）
var unlock_skills: Array[String] = []
var settings: Dictionary = {
    "sound_volume": 1.0,
    "music_volume": 0.8,
    "difficulty": "normal"
}

# 跨场景函数
func add_score(points: int) -> void:
    score += points
    print("当前分数:", score)
```

**注册单例：**
```
Project → Project Settings → Autoload
  路径: res://global.gd
  名称: Global
```
之后任何场景/脚本都可以：
```gdscript
Global.add_score(100)
print(Global.score)
```

### 12.2 场景切换——"换关卡"

```gdscript
# 方法1：直接切换（清空当前场景）
get_tree().change_scene_to_file("res://scenes/level_2.tscn")

# 方法2：从 PackedScene 切换（更灵活）
var next_level = load("res://scenes/level_2.tscn")
get_tree().change_scene_to_packed(next_level)

# 方法3：切换并传参（通过单例）
Global.next_level_data = {"start_pos": Vector2(100, 200)}
get_tree().change_scene_to_file("res://scenes/level_2.tscn")

# ⭐ 过渡动画（推荐）
func switch_level(level_path: String):
    # 播放淡出动画
    $AnimationPlayer.play("fade_out")
    await $AnimationPlayer.animation_finished
    
    # 切换场景
    get_tree().change_scene_to_file(level_path)
    
    # 播放淡入动画
    $AnimationPlayer.play("fade_in")
```

### 12.3 游戏状态管理

```gdscript
# global.gd 中的游戏状态枚举
enum GameState { MENU, PLAYING, PAUSED, GAME_OVER, LEVEL_COMPLETE }
var game_state: GameState = GameState.MENU

func set_game_state(new_state: GameState) -> void:
    var old_state = game_state
    game_state = new_state
    
    match new_state:
        GameState.PAUSED:
            get_tree().paused = true  # ⭐ 暂停所有物理/process
        GameState.PLAYING:
            get_tree().paused = false
        GameState.GAME_OVER:
            get_tree().change_scene_to_file("res://scenes/game_over.tscn")
```

### 12.4 游戏暂停

```gdscript
# 简单暂停（按 ESC 切换）
func _input(event: InputEvent):
    if event.is_action_pressed("pause"):
        if get_tree().paused:
            get_tree().paused = false
            $PauseMenu.hide()
        else:
            get_tree().paused = true
            $PauseMenu.show()

# 注意：暂停时 _process 和 _physics_process 都停
# 但 PauseMenu 需要继续工作 → 设置它的 "Process Mode" = "When Paused"
# Inspector → Node → Process → Mode → "When Paused"
```

### 12.5 数据持久化——"保存游戏"

```gdscript
# 保存到文件
func save_game():
    var save_data = {
        "score": Global.score,
        "level": Global.current_level,
        "player_pos": $Player.position
    }
    
    var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
    file.store_var(save_data)  # Godot 4 新方法！自动序列化
    file.close()

# 读取存档
func load_game():
    if not FileAccess.file_exists("user://savegame.save"):
        return
    
    var file = FileAccess.open("user://savegame.save", FileAccess.READ)
    var data = file.get_var()
    file.close()
    
    Global.score = data["score"]
    $Player.position = data["player_pos"]

# user:// 是 Godot 自动分配的保存路径
# Windows: %APPDATA%/你的游戏名/
# 安卓: 内部存储/Android/data/你的包名/
```

> ✋ **费曼自测**：解释为什么需要单例？如果没有单例，你要怎么在两个场景之间传递玩家的分数和血量？

### 🛠 番茄12小练习
1. 创建 Global 单例，管理分数和生命值
2. 实现两个场景互相切换（Level1 → Level2）
3. 添加 ESC 暂停功能
4. 实现简单的存档/读档

---

### 🍅 番茄9-12结束，休息5分钟
**回顾清单：**
- ✅ CharacterBody2D + move_and_slide() 控制角色
- ✅ Area2D 检测进入/离开区域
- ✅ Coyote Time + Jump Buffer + 变量跳跃
- ✅ 简单状态机（IDLE/RUN/JUMP）
- ✅ 子弹射击 + 碰撞销毁
- ✅ 敌人AI（巡逻→追击）
- ✅ 碰撞层 Layer/Mask
- ✅ 单例（Autoload）实现全局数据
- ✅ 场景切换 + 暂定 + 存档

---

## 🍅 模块四：丰富游戏内容（番茄13-16）

---

## 🍅 番茄13：UI系统——Control节点家族（25分钟）

### 13.1 Control节点——"游戏里的界面"

**用大白话讲：**
游戏的 UI（血条、按钮、菜单）和游戏世界是**分开的两层**。游戏世界用 Node2D，UI 用 Control 节点。Control 节点**不关心游戏世界坐标**，它关心的是屏幕位置。

```gdscript
# Control 节点的坐标系：
# (0, 0) = 屏幕左上角
# 大小 = 屏幕像素
# 位置 = 相对于父Control或锚点
```

**常用 Control 节点：**
| 节点 | 用途 | 常用属性 |
|:-----|:-----|:---------|
| **Label** | 显示文字 | `text`, `font_size`, `horizontal_alignment` |
| **Button** | 可点击按钮 | `text`, `pressed` 信号, `disabled` |
| **TextureRect** | 显示图片 | `texture`, `stretch_mode` |
| **ColorRect** | 纯色矩形 | `color` |
| **ProgressBar** | 进度条 | `min_value`, `max_value`, `value` |
| **Panel** | 容器背景 | `color` |
| **VBoxContainer** | 垂直排列 | 自动布局子控件 |
| **HBoxContainer** | 水平排列 | 自动布局子控件 |

### 13.2 锚点与容器——"让UI自适应"

**用大白话讲：**
不同屏幕大小不一样（手机、电脑、平板）。如果你把按钮放在"第300个像素"位置，换个屏幕就偏了。**锚点**让控件说"我要固定在屏幕的哪个位置"。

```
锚点预设（在编辑器顶部工具栏）：
┌────────────┬────────────┬────────────┐
│ Top Left   │ Top Center │ Top Right  │
├────────────┼────────────┼────────────┤
│ Center Left│ Center     │ Center Right│
├────────────┼────────────┼────────────┤
│ Bottom Left│ Bottom Center│Bottom Right│
└────────────┴────────────┴────────────┘
```

**实操：**
```
选中 Control 节点 → 顶部工具栏的 Anchor Preset
  └→ 选择 "Bottom Left" → 按钮固定在左下角
     → 选择 "Full Rect" → 控件铺满整个屏幕
```

**容器自动布局：**
```
Control (根，全屏)
├── VBoxContainer (垂直排列)
│   ├── Label ("分数: 0")
│   ├── ProgressBar (血条)
│   └── HBoxContainer (水平排列)
│       ├── Button ("重试")
│       └── Button ("返回菜单")
```

### 13.3 HUD实战——血量与分数

```gdscript
# HUD.gd (CanvasLayer 或 Control)
extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var score_label: Label = $ScoreLabel
@onready var coin_label: Label = $CoinLabel

func _ready():
    # 连接玩家信号
    var player = get_tree().get_first_node_in_group("player")
    if player:
        player.health_changed.connect(update_health)
        player.score_changed.connect(update_score)

func update_health(new_health: int, max_health: int):
    health_bar.max_value = max_health
    health_bar.value = new_health
    
    # 颜色变化
    if new_health < max_health * 0.3:
        health_bar.modulate = Color.RED  # 低血量变红
    else:
        health_bar.modulate = Color.WHITE

func update_score(score: int):
    score_label.text = "分数: " + str(score)
```

### 13.4 为什么用 CanvasLayer？

```gdscript
# CanvasLayer 是 UI 的标准根节点
# 它让 UI 不随游戏摄像机移动！
# 对比：
# Control (作为游戏场景子节点) → 镜头动，UI跟着动 ❌
# CanvasLayer → 镜头动，UI不动 ✅
```

> ✋ **费曼自测**：解释"锚点"是什么。想象你把一个便利贴贴在手机上——你想让它固定在屏幕右上角，无论你怎么旋转手机。用这个类比说明锚点的作用。

### 🛠 番茄13小练习
1. 创建 CanvasLayer → Control → VBoxContainer 布局
2. 添加 Label 显示分数，ProgressBar 显示血量
3. 设置锚点让它们固定在左上角
4. 通过 Global 单例更新分数显示

---

## 🍅 番茄14：动画系统——让游戏"活"起来（25分钟）

### 14.1 三大动画方案

| 方案 | 适用场景 | 复杂度 |
|:-----|:---------|:-------|
| **AnimationPlayer** | 复杂动画、序列、过场 | ⭐⭐⭐ |
| **AnimatedSprite2D** | 角色行走/跳跃帧动画 | ⭐ |
| **Tween** | 简单的缓动（平移/淡入淡出） | ⭐⭐ |

**选择法则：**
- 角色走动/跳跃的精灵帧 → **AnimatedSprite2D**
- 开门动画、过场动画 → **AnimationPlayer**
- 按钮缓动、血量条平滑变化 → **Tween**

### 14.2 AnimatedSprite2D——帧动画

```
1. 创建 AnimatedSprite2D 作为子节点
2. 在 Inspector → SpriteFrames → 选择 "New SpriteFrames"
3. 点击下方 SpriteFrames 面板
4. 添加动画：
   - "idle"：待机帧
   - "run"：跑步帧  
   - "jump"：跳跃帧
5. 设置帧速度（FPS）：默认 5（慢）→ 建议 10-15
```

```gdscript
# 代码控制动画切换
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
    # 根据状态切换动画
    if not is_on_floor():
        anim_sprite.play("jump")
    elif direction != 0:
        anim_sprite.play("run")
    else:
        anim_sprite.play("idle")
    
    # 翻转方向
    if direction < 0:
        anim_sprite.flip_h = true
    elif direction > 0:
        anim_sprite.flip_h = false
```

### 14.3 Tween——最常用的缓动

```gdscript
# Tween = 让属性从A平滑变化到B
# 不用手动算每一帧的值

func flash_damage():
    # 创建Tween（Godot 4新语法）
    var tween = create_tween()
    tween.tween_property($Sprite2D, "modulate", Color.RED, 0.1)
    tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.1)

func move_to_position(target: Vector2):
    var tween = create_tween()
    tween.set_ease(Tween.EASE_OUT)       # 缓出效果
    tween.set_trans(Tween.TRANS_BACK)     # 回弹效果
    tween.tween_property(self, "position", target, 0.5)

func fade_out_and_delete():
    var tween = create_tween()
    tween.tween_property(self, "modulate.a", 0.0, 0.3)  # 透明度→0
    tween.tween_callback(queue_free)                     # 完成后删除

# 常用缓动类型：
# TRANS_LINEAR  → 匀速
# TRANS_SINE    → 平滑
# TRANS_BOUNCE  → 弹跳效果
# TRANS_BACK    → 过头回弹
# TRANS_ELASTIC → 橡皮筋
```

**Godot 3 vs 4 Tween 差异：**
```gdscript
# Godot 3
$Tween.interpolate_property(self, "position", from, to, 1.0)
$Tween.start()

# Godot 4
var tween = create_tween()  # ⭐ 不用手动创建Tween节点！
tween.tween_property(self, "position", to, 1.0)
```

### 14.4 AnimationPlayer——"专业动画"

```gdscript
# AnimationPlayer 是 Godot 的"动画工作室"
# 可以动画化任何节点的任何属性

@onready var anim_player: AnimationPlayer = $AnimationPlayer

# 播放动画
anim_player.play("idle")
anim_player.play("run")

# 获取动画列表
var animations = anim_player.get_animation_list()

# 动画完成检测
func _ready():
    anim_player.animation_finished.connect(_on_anim_finished)

func _on_anim_finished(anim_name: String):
    if anim_name == "death":
        queue_free()
```

**编辑器创建 AnimationPlayer 动画：**
```
1. 添加 AnimationPlayer 节点
2. 打开底部 "Animation" 面板
3. 点击 "Animation" → "New" → 命名 "walk"
4. 点击 "Add Track" → 选择节点属性（如 Sprite2D:position）
5. 在时间轴上添加关键帧（菱形按钮）
6. 拖动时间轴，修改属性值 → 自动生成关键帧
7. 点击播放查看效果
```

> ✋ **费曼自测**：比较 Tween 和 AnimationPlayer——什么时候用 Tween（简单缓动），什么时候用 AnimationPlayer（复杂序列）？

### 🛠 番茄14小练习
1. 导入一个精灵表（Sprite Sheet），配置 AnimatedSprite2D
2. 用 Tween 实现：受伤闪烁、拾取物品的放大→消失效果
3. 用 AnimationPlayer 做一个简单的心跳动画（放大缩小循环）

---

## 🍅 番茄15：音频系统——声音让游戏有灵魂（25分钟）

### 15.1 音频节点选择

| 节点 | 用途 | 特点 |
|:-----|:-----|:-----|
| **AudioStreamPlayer2D** | 2D游戏音效 | 有空间感（远近、左右） |
| **AudioStreamPlayer** | 全局音效/BGM | 无空间感，适合纯音频 |
| **AudioStreamPlayer3D** | 3D游戏音效 | 3D空间音频 |

```gdscript
# 2D 音效的"空间感"
# 音源离摄像机越远 → 声音越小
# 音源在左边 → 左声道响

# 调整参数：
audio_player.max_distance = 1000.0    # 最远能听到的距离
audio_player.attenuation = 0.5        # 衰减速度（0=不衰减）
audio_player.panning_strength = 0.8   # 左右声道分离度
```

### 15.2 播放音效

```gdscript
# 方式1：直接在节点上播放
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX

func jump():
    jump_sfx.play()  # 从开始播放

# 方式2：动态切换音频流
@onready var sfx_player: AudioStreamPlayer2D = $SFXPlayer

func play_sfx(stream: AudioStream):
    sfx_player.stream = stream  # 切换音频
    sfx_player.play()

# 方式3：随机音高（避免听觉疲劳）
func play_random_pitch():
    jump_sfx.pitch_scale = randf_range(0.8, 1.2)  # 0.8~1.2随机
    jump_sfx.play()

# 方式4：在一个节点播放完毕后播放下一个
@onready var bgm_player: AudioStreamPlayer = $BGMPlayer

func switch_bgm(new_bgm: AudioStream):
    var tween = create_tween()
    tween.tween_property(bgm_player, "volume_db", -80, 1.0)  # 渐弱
    tween.tween_callback(func(): 
        bgm_player.stream = new_bgm
        bgm_player.play()
    )
    tween.tween_property(bgm_player, "volume_db", 0, 1.0)    # 渐强
```

### 15.3 音频总线——"声音控制台"

**用大白话讲：**
音频总线就像一个**调音台**——你可以调节总音量、音乐音量、音效音量，还能加混响、回声等效果。

**设置步骤：**
```
底部 → Audio 面板 → 点击 "Master" 旁边的 +
  → 创建三个总线：
    - Master (总线0) → 总音量
    - Music (总线1) → BGM
    - SFX (总线2) → 音效
```

```gdscript
# 代码控制音量
func set_music_volume(volume: float):
    # volume: 0.0 ~ 1.0
    var db_value = linear_to_db(volume)  # 线性值→分贝
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db_value)

func set_sfx_volume(volume: float):
    var bus_idx = AudioServer.get_bus_index("SFX")
    AudioServer.set_bus_volume_db(bus_idx, linear_to_db(volume))

# 静音切换
func toggle_mute():
    var bus_idx = AudioServer.get_bus_index("Master")
    var is_muted = AudioServer.is_bus_mute(bus_idx)
    AudioServer.set_bus_mute(bus_idx, not is_muted)

# 连接音频到总线：
# AudioStreamPlayer → Inspector → Bus → 选择 "SFX" 或 "Music"
```

### 15.4 音效管理单例

```gdscript
# AudioManager.gd (Autoload 单例)
extends Node

@export var sfx_player: AudioStreamPlayer

var sfx_library: Dictionary = {
    "jump": preload("res://audio/sfx_jump.wav"),
    "shoot": preload("res://audio/sfx_shoot.wav"),
    "hit": preload("res://audio/sfx_hit.wav"),
    "coin": preload("res://audio/sfx_coin.wav"),
    "explosion": preload("res://audio/sfx_explosion.wav"),
}

func play_sfx(name: String, pitch_random: bool = true):
    if not sfx_library.has(name):
        push_warning("音效不存在:", name)
        return
    
    sfx_player.stream = sfx_library[name]
    if pitch_random:
        sfx_player.pitch_scale = randf_range(0.9, 1.1)
    sfx_player.play()
```

> ✋ **费曼自测**：用"家里的音响系统"（手机连着蓝牙音箱，电视连着回音壁）比喻解释音频总线是什么——为什么你需要 Master/Music/SFX 三条总线？

### 🛠 番茄15小练习
1. 找一个免费音效包（如 freesound.org 或 Kenney.nl）
2. 导入音频并创建 AudioStreamPlayer2D
3. 创建音频总线：Master、Music、SFX
4. 实现游戏内音量调节（用滑块控制 SFX 音量）

---

## 🍅 番茄16：粒子系统与视觉特效（25分钟）

### 16.1 GPUParticles2D——"给你的游戏撒魔法"

**用大白话讲：**
粒子系统就是**一次性生成很多小东西（粒子）**，每个小东西有自己独立的运动，整体形成一种视觉效果。

```
粒子 = 大量的小图片各自运动
├── 火焰 = 红色粒子向上飘，逐渐消失
├── 爆炸 = 粒子向四面八方飞散
├── 雪花 = 白色粒子缓慢飘落，来回摇摆
└── 星星 = 亮色粒子闪烁旋转
```

**创建粒子：**
```
1. 添加 GPUParticles2D 节点
2. 在 Inspector → Process Material → 选择 "New ParticleProcessMaterial"
3. 调整参数：
   - Emitting: On（开始发射）
   - Amount: 50（粒子数量）
   - Time: 0.5（发射持续时间）
   - Lifetime: 1.0（每个粒子存活时间）
   - 展开 Initial Velocity → Random: 100（初速度范围）
   - 展开 Gravity → Vector2(0, 100)（重力方向）
4. 在 Inspector → Texture → 选择粒子图片（圆形或星形）
```

### 16.2 粒子系统关键参数

```gdscript
# 代码控制粒子（比手动调更灵活）
@onready var particles: GPUParticles2D = $ExplosionParticles

func explode():
    particles.amount = 50        # 粒子数量
    particles.lifetime = 0.8     # 粒子存活时间
    particles.emitting = true    # 开始发射
    
    # Godot 4 新特性：一次性发射全部粒子
    particles.one_shot = true
    particles.restart()  # 重新开始
    
    # 粒子完成后自动删除
    await particles.finished  # ⭐ 等待粒子发射完成
    queue_free()

# 参数速查表：
# Direction → 粒子发射方向
# Spread → 扩散角度（180=半球，360=全方向）
# Initial Velocity → 初速度
# Gravity → 重力（平台跳跃游戏常用 Vector2(0, 200)）
# Damping → 阻尼（逐渐减速）
# Scale → 粒子大小
# Color → 粒子颜色（可渐变）
# Lifetime Randomness → 寿命随机性
```

### 16.3 CPU vs GPU 粒子

| | **CPUParticles2D** | **GPUParticles2D** |
|:--|:-------------------|:-------------------|
| 计算方式 | CPU | GPU（显卡） |
| 性能 | 少数量时好 | 大量时极好 |
| 同时粒子数 | <1000 适合 | 10000+ 也没问题 |
| 适合 | 简单特效、低端设备 | 复杂特效、PC |

**💡 建议**：默认为 GPUParticles2D，只有发现性能问题时再考虑 CPUParticles2D。

### 16.4 Shader入门——可视化编辑器

**用大白话讲：**
Shader（着色器）就是**告诉显卡怎么画每个像素**的程序。比如你想让图片发光、扭曲、波浪——不用做动画，写一行 Shader 代码就行。

**Godot 4 的 VisualShader（可视化编辑）：**
```
1. 选中 Sprite2D
2. Inspector → Material → 选择 "New ShaderMaterial"
3. Shader → 选择 "New VisualShader"
4. 打开 VisualShader 编辑器（底部面板）
5. 连接节点：
   - 添加 "Time" 节点
   - 添加 "Sine" 节点
   - 添加 "Color" 节点（设为红色）
   - 连接到输出 → 精灵会闪烁
```

**简单 Shader 代码（先看看，不用怕）：**
```gdscript
shader_type canvas_item;

// 让精灵颜色随时间变化（呼吸光效）
void fragment() {
    float intensity = sin(TIME * 2.0) * 0.5 + 0.5;
    COLOR.rgb *= vec3(1.0, 0.3 + intensity * 0.7, 0.3 + intensity * 0.7);
}

// 常用的 Shader 效果关键词：
// canvas_item → 2D shader
// spatial → 3D shader  
// TIME → 内置变量，从运行开始经过的时间
// UV → 纹理坐标（0~1）
// COLOR → 最终像素颜色
// TEXTURE → 纹理图片
```

**更实用的：波浪效果**
```gdscript
shader_type canvas_item;

uniform float wave_speed = 2.0;
uniform float wave_amount = 0.02;

void vertex() {
    VERTEX.y += sin(VERTEX.x * 10.0 + TIME * wave_speed) * wave_amount;
}
// 这个shader让精灵产生波浪效果，适合旗帜、水面
```

> ✋ **费曼自测**：用"颜料和画笔"的比喻解释 Shader 是什么？如果你不知道 Shader 是啥，就说下"粒子参数中三个最重要的设置"是什么。

### 🛠 番茄16小练习
1. 创建爆炸粒子效果（GPUParticles2D）
2. 创建火焰粒子效果（红色+橙色的向上飘散粒子）
3. 尝试 VisualShader 编辑器，让精灵颜色周期性变化
4. 把粒子放到之前的射击游戏里：命中敌人时爆炸

---

### 🍅 番茄13-16结束，休息5分钟
**回顾清单：**
- ✅ Control 节点家族（Label/Button/ProgressBar）
- ✅ 锚点 + 容器实现自适应UI
- ✅ CanvasLayer 分离UI和游戏世界
- ✅ AnimatedSprite2D 帧动画
- ✅ Tween 缓动（受伤、拾取、淡出）
- ✅ AnimationPlayer 复杂序列
- ✅ 音频总线 Master/Music/SFX
- ✅ GPUParticles2D 粒子特效
- ✅ VisualShader 可视化编辑入门

---

## 🍅 模块五：3D与高级主题（番茄17-20）

---

## 🍅 番茄17：3D基础入门（25分钟）

### 17.1 从2D到3D——观念转变

**用大白话讲：**
2D 是一个"纸片世界"——坐标只有 X（左右）和 Y（上下）。3D 加了一个 Z 轴（前后），就像从"画"变成了"立体模型"。

```gdscript
# 2D坐标
var pos2d = Vector2(x, y)

# 3D坐标
var pos3d = Vector3(x, y, z)
# 在 Godot 3D 中：Y 轴向上（和现实一样！）
# X=左右, Y=上下, Z=前后

# 核心区别：2D用像素，3D用"世界单位"
# 1单位 ≈ 1米（物理引擎按米算）
```

**2D vs 3D 关键差异表：**

| 概念 | 2D | 3D |
|:-----|:---|:---|
| 根节点 | Node2D | Node3D |
| 位置 | `Vector2` | `Vector3` |
| 旋转 | `rotation`（弧度） | `rotation`（欧拉角） |
| 显示图片 | Sprite2D | Sprite3D / MeshInstance3D |
| 碰撞 | CollisionShape2D | CollisionShape3D |
| 摄像机 | Camera2D | Camera3D |
| 光照 | 不需要 | 需要 Light3D |

### 17.2 创建你的第一个3D场景

```
1. 新建场景 → 选择 "3D Scene"（根节点自动为 Node3D）
2. 添加 MeshInstance3D 子节点
3. 在 Inspector → Mesh → "New BoxMesh"（一个立方体出现了）
4. 添加 Camera3D（当前视角）
5. 运行 → 你会看到一个立方体

添加光照：
6. 添加 DirectionalLight3D（方向光=太阳光）
   - 旋转角度让光线斜照
   - Shadow Enabled → true（开启阴影）
7. 可选：添加 WorldEnvironment（环境光）
   - 选择 "New Environment"
   - 设置 Background → Sky → 预设的渐变天空
```

### 17.3 3D 摄像机控制

```gdscript
# 简单3D摄像机（跟随玩家）
extends Camera3D

@export var target: Node3D  # 在编辑器里拖拽玩家
@export var distance: float = 5.0
@export var height: float = 3.0

func _physics_process(delta: float) -> void:
    if not target:
        return
    
    # 第三人称跟随
    var target_pos = target.global_position
    global_position = target_pos + Vector3(0, height, distance)
    look_at(target_pos)

# 第一人称摄像机（作为玩家的子节点）
# Camera3D 放在玩家位置，rotation 跟随鼠标
func _input(event: InputEvent):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        # 水平旋转玩家
        rotation.y -= event.relative.x * 0.005
        # 垂直旋转摄像机（限制范围防翻转）
        rotation.x -= event.relative.y * 0.005
        rotation.x = clamp(rotation.x, -1.5, 1.5)
```

### 17.4 3D碰撞与物理

```gdscript
extends CharacterBody3D  # ⭐ 不是 CharacterBody2D！

@export var speed: float = 5.0  # 3D用米/秒，不是像素/秒

func _physics_process(delta: float) -> void:
    # 输入
    var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    
    if direction:
        velocity.x = direction.x * speed
        velocity.z = direction.z * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)
        velocity.z = move_toward(velocity.z, 0, speed)
    
    # 重力
    if not is_on_floor():
        velocity.y -= 9.8 * delta  # 现实重力！
    
    move_and_slide()
```

**GD Tip：** `transform.basis` 是节点的方向矩阵。`transform.basis * Vector3(0, 0, -1)` = "节点朝前的方向"。

> ✋ **费曼自测**：用"从画画到玩橡皮泥"的类比，说说从 2D 到 3D 你需要改变哪些思维习惯？

### 🛠 番茄17小练习
1. 创建 3D 场景 + 地面（大型 Cube，Scale 设为 10, 0.1, 10）
2. 添加 DirectionalLight3D 和 WorldEnvironment
3. 创建 CharacterBody3D + CollisionShape3D（胶囊体）：实现 WASD 移动
4. 添加 Camera3D 第一人称视角

---

## 🍅 番茄18：极简3D游戏实战（25分钟）

### 18.1 3D玩家角色

```gdscript
# 完整的 3D 角色控制器（类似Minecraft风格）
extends CharacterBody3D

@export var walk_speed: float = 5.0
@export var sprint_speed: float = 8.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.002

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed: float

# 引用
@onready var head: Node3D = $Head  # Camera3D 的父节点，用于上下看

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # 锁定鼠标

func _input(event: InputEvent):
    if event is InputEventMouseMotion:
        # 水平旋转：旋转整个身体
        rotate_y(-event.relative.x * mouse_sensitivity)
        # 垂直旋转：只旋转头部（摄像机部分）
        head.rotate_x(-event.relative.y * mouse_sensitivity)
        head.rotation.x = clamp(head.rotation.x, -1.2, 1.2)  # 限制低头仰头范围

func _physics_process(delta: float) -> void:
    # === 输入处理 ===
    var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    
    # 速度选择
    current_speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
    
    # === 移动 ===
    if direction:
        velocity.x = direction.x * current_speed
        velocity.z = direction.z * current_speed
    else:
        velocity.x = move_toward(velocity.x, 0, current_speed)
        velocity.z = move_toward(velocity.z, 0, current_speed)
    
    # === 跳跃 ===
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity
    
    # === 重力 ===
    if not is_on_floor():
        velocity.y -= gravity * delta
    
    move_and_slide()
```

**3D角色场景结构：**
```
Player (CharacterBody3D)
├── CollisionShape3D (CapsuleShape3D)  ← 碰撞体
├── Head (Node3D)
│   └── Camera3D                       ← 主视角
├── MeshInstance3D                      ← 可见角色（用 Capsule 或导入模型）
└── AudioStreamPlayer3D                 ← 脚步/跳跃音效
```

### 18.2 简单的3D拾取系统

```gdscript
# 玩家前方射线检测（点击拾取）
extends Node3D

@export var pickup_range: float = 5.0

func _input(event: InputEvent):
    if event.is_action_pressed("interact"):
        # 从摄像机位置发射射线
        var camera = $Head/Camera3D
        var space_state = get_world_3d().direct_space_state
        
        var from = camera.global_position
        var to = from - camera.global_transform.basis.z * pickup_range
        
        var query = PhysicsRayQueryParameters3D.create(from, to)
        query.exclude = [self]  # 排除自己
        
        var result = space_state.intersect_ray(query)
        
        if result:
            var collider = result.collider
            if collider.is_in_group("pickups"):
                collider.queue_free()
                Global.add_score(10)
```

### 18.3 极简3D小游戏要点

**创建一个"收集金币"3D游戏：**
1. **玩家**：第一人称 WASD 移动
2. **金币**：金色球体（SphereMesh3D + 旋转动画），散落在地图中
3. **UI 显示**：CanvasLayer 显示分数
4. **计时器**：60秒倒计时

```gdscript
# 金币旋转动画
extends MeshInstance3D

func _process(delta: float) -> void:
    rotate_y(delta * 2.0)  # 绕 Y 轴旋转
    position.y += sin(Time.get_ticks_msec() * 0.003) * delta  # 上下浮动

# 触发拾取（Area3D 检测）
extends Area3D

func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body.is_in_group("player"):
        AudioManager.play_sfx("coin")
        Global.add_score(10)
        queue_free()
```

> ✋ **费曼自测**：3D 角色控制中，"水平旋转整身体"和"垂直旋转头部"为什么不能都旋转同一个节点？如果都旋转 Camera3D 会发生什么？

### 🛠 番茄18小练习
1. 实现完整的第一人称 3D 角色控制（移动+视角）
2. 创建 3 个"金币"（金色 SphereMesh3D + Area3D）
3. 添加计分 UI
4. 实现射线拾取检测

---

## 🍅 番茄19：Shader 与可视化编辑器（25分钟）

### 19.1 什么是 Shader——给显卡的"画画指令"

**用大白话讲：**
CPU 是个"老教授"——什么都会但画得慢。GPU 是"一万个美工学生"——只会画像素但超级快。**Shader 就是写一份"怎么画"的说明书，让一万个学生同时照着画。**

```
传统做法：CPU画10000个像素
         ↓ 慢

用 Shader：CPU发指令"把所有像素变红"
           ↓ GPU同时处理所有像素
           ↓ 超快
```

### 19.2 VisualShader 可视化节点详解

**Godot 4 的 VisualShader 编辑器：**
```
底部面板 → VisualShader 标签

核心节点类型：
┌──────────┐
│ Input    │ ← 输入（UV、Time、Color等）
├──────────┤
│ ScalarOp │ ← 数学运算（加/减/乘/除）
├──────────┤
│ VectorOp │ ← 向量运算
├──────────┤
│ SDF      │ ← 有符号距离场（高级效果）
├──────────┤
│ Output   │ ← 最终输出
└──────────┘
```

**实战：创建一个发光边缘效果（可视化）：**
```
1. 创建 ShaderMaterial → VisualShader
2. 添加节点：
   [UV] → [UV to Screen UV] → [Edge Detection] → [Output]
   [Time] → [Sine] → [Multiply(0.1)] → [Output Emission]
3. 效果：角色边缘发光，随时间呼吸
```

### 19.3 常用2D Shader 模板

**溶解效果（角色消失/出现）：**
```gdscript
shader_type canvas_item;

uniform float dissolve_amount : hint_range(0, 1) = 0.0;
uniform sampler2D noise_texture : hint_white;

void fragment() {
    vec4 noise = texture(noise_texture, UV);
    float cutoff = noise.r - dissolve_amount;
    
    if (cutoff < 0.0) {
        discard;  // 不画这个像素
    }
    
    COLOR = texture(TEXTURE, UV);
    // 边缘发光
    if (cutoff < 0.1) {
        COLOR.rgb = vec3(1.0, 0.5, 0.0);  // 橙色边缘
    }
}
```

**水下扭曲效果：**
```gdscript
shader_type canvas_item;

uniform float wave_strength = 0.02;

void fragment() {
    vec2 uv = UV;
    uv.x += sin(uv.y * 20.0 + TIME * 2.0) * wave_strength;
    COLOR = texture(TEXTURE, uv);
}
// 实际效果：精灵像在水里一样扭曲
// 参数调节：调整 wave_strength 控制扭曲程度
```

### 19.4 Shader Material 的资源管理

```gdscript
# 代码中修改 Shader 参数（实现动态效果）
@onready var sprite: Sprite2D = $Sprite2D

func start_dissolve():
    var material = sprite.material as ShaderMaterial
    var tween = create_tween()
    
    # 修改 uniform 变量
    tween.tween_method(func(val): 
        material.set_shader_parameter("dissolve_amount", val)
    , 0.0, 1.0, 1.0)
    
    await tween.finished
    queue_free()  # 溶解完成后删除

# ⭐ Godot 4 新特性：material.set_shader_parameter()
# Godot 3 旧写法：material.set_shader_param()
```

**对于初学者——到什么程度？**
| 级别 | 掌握内容 |
|:-----|:---------|
| ✅ 入门 | 知道 Shader 能做什么，会用 VisualShader 做简单效果 |
| ✅ 够用 | 能改写现成的 Shader（改颜色/参数） |
| ✅ 进阶 | 能写简单 Shader（溶解、扭曲、发光） |
| ❌ 不需要 | 自己写复杂光照模型、PBR 材质 |

**💡 建议**：初学阶段主攻 VisualShader，看到好东西去 [godotshaders.com](https://godotshaders.com) 抄作业。

> ✋ **费曼自测**：用"一万个美工学生同时画画"的比喻，向朋友解释为什么用 Shader 做特效比用 CPU 做快得多。

### 🛠 番茄19小练习
1. 创建一个 Sprite2D，添加 ShaderMaterial
2. 用 VisualShader 做一个颜色随时间变化的效果
3. 用 Shader 代码实现溶解效果，用 Tween 改变 dissolve_amount
4. 尝试 Wave（波浪）shader

---

## 🍅 番茄20：游戏发布、优化与最佳实践（25分钟）

### 20.1 游戏导出——把你的游戏发给别人

**用大白话讲：**
在编辑器里按 F5 只是"给自己看"。要让别人也能玩，需要**导出**——把游戏打包成一个可执行文件。

**导出步骤：**
```
1. Project → Export
2. 如果第一次导出，点 "Add..." 选择平台
3. 配置导出模板：
   - Windows: .exe 文件
   - Linux: .x86_64 可执行文件
   - macOS: .app 包
   - Android: .apk 或 .aab
   - Web: HTML5（用浏览器直接玩）

4. ⭐ 关键设置：
   - "Keeps" → Resources → Export Mode → 
     "Export selected resources (and dependencies)"（最推荐）
     只打包游戏需要的文件，减小体积
   
   - "Binary" → 选择 32位/64位（默认 64 位即可）

5. 点击 "Export Project" → 选择保存位置
```

**首次导出需要下载导出模板：**
```
导出时如果提示 "No Export Template"：
  编辑器 → Editor → Manage Export Templates
    → Download and Install
    → 选择 Godot 4.3 stable
```

**重要导出配置：**
```gdscript
# 导出前检查清单：
# ✅ 设置 Application → Config → Name（游戏名）
# ✅ 设置 Display → Window → Size（窗口大小）
# ✅ 设置 Input Map 提醒玩家改键位
# ✅ 小游戏设置 Display → Window → Resizable = false
# ✅ 设置 Application → Icon（游戏图标）
```

### 20.2 性能优化——让游戏跑得更顺

**用大白话讲：**
优化不是"把代码写高深"，而是**少做无用功**。就像收拾房间——不是买更多收纳盒，而是把不用的东西扔掉。

```gdscript
# 1. ⭐ 使用 VisibleOnScreenNotifier2D
# 只有物体在屏幕上时才做处理
extends CharacterBody2D

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready():
    notifier.screen_exited.connect(_offscreen)

func _offscreen():
    # 敌人离开屏幕 → 删除或停止处理
    set_process(false)  # 停止 updates
    set_physics_process(false)
    
    # 或者如果离得太远 → 直接删除
    # queue_free()
```

```gdscript
# 2. 对象池——"重复利用子弹"
# 不要反复 instantiate/queue_free，而是重用一个池子
class_name BulletPool

var pool: Array[Area2D] = []
var bullet_scene: PackedScene

func get_bullet() -> Area2D:
    # 从池中取一个
    for bullet in pool:
        if not bullet.visible:
            bullet.show()
            return bullet
    
    # 池子不够 → 新建
    var new_bullet = bullet_scene.instantiate()
    pool.append(new_bullet)
    return new_bullet

func return_bullet(bullet: Area2D):
    bullet.hide()  # 隐藏而不是删除
    bullet.position = Vector2(-1000, -1000)  # 移出屏幕
```

**Godot 4 优化要点：**
| 场景 | 怎么做 |
|:-----|:-------|
| 大量 2D 精灵 | 使用 `CanvasItemMaterial` + 合批 |
| 大量 3D 物体 | 使用 MultiMesh |
| UI 闪烁 | 用 CanvasItem.visible 代替 remove_child |
| 频繁 Object 创建 | 用对象池 |
| 代码耗时 | 把计算移到 _ready，_process 只做绘制 |

### 20.3 最佳实践清单

**✅ 应该做的：**
- 用 `@onready var` 替代 `_ready()` 中手动赋值
- 用 `Input.get_axis()` 替代两个 `is_action_pressed`
- 用场景实例化替代手写所有节点
- 用信号解耦节点通信
- 用单例（Autoload）管理全局状态
- 用 `is_in_group()` 做类型检测
- 移动代码放 `_physics_process`，视觉更新放 `_process`
- 用 `create_tween()` 替代手动动画计算
- 先做可玩的原型，再做优化

**❌ 避免做的：**
- 每帧用 `get_node()`（开销大 → 用 `@onready` 缓存）
- 在 `_process` 中创建/删除节点
- 节点嵌套超过 10 层
- 大量精灵使用单独 Sprite2D（用 TileMap）
- RigidBody2D 数量超过 100（用对象池）
- 在 `_physics_process` 里修改碰撞形状
- Godot 3 语法迁移未完成（如老的 Tween API）

### 20.4 学习资源与下一步

**推荐学习路径（20番茄后）：**
```
你现在在这里 🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅
                             ↓
1. 做一个完整小游戏（如平台跳跃）→ 巩固 20 番茄内容
   - 推荐克隆：Flappy Bird / 打砖块 / 简单平台游戏
                             ↓
2. 学习进阶主题
   - GDScript 高级特性（自定义资源、RPC、多线程）
   - 自定义资源系统（Resources）
   - TileMap 插件编辑器（Godot 4 重做）
   - 动画状态机（AnimationTree + StateMachine）
                             ↓
3. 探索专项领域（按兴趣）
   - 2D 动作游戏 → 更复杂的战斗系统、AI行为树
   - RPG → 对话系统、背包系统、任务系统
   - 极简3D → 模型导入、Blender协作
   - 工具开发 → Godot 插件编写
```

**推荐资源：**
| 资源 | 地址 | 说明 |
|:-----|:-----|:-----|
| 官方文档 | docs.godotengine.org | 最权威 |
| KidsCanCode | YouTube | 最好的 Godot 教程频道 |
| GDQuest | YouTube + 网站 | 高质量免费教程 |
| Godot 官方示范 | github.com/godotengine/godot-demo-projects | 官方案例 |
| Godot Shaders | godotshaders.com | Shader 代码库 |

### 20.5 开发工作流总结

```
构思 → 原型 → 打磨 → 发布

1. 构思：想清楚核心玩法（一句话说清）
   - 例："玩家控制小鸟，点击屏幕飞行，穿过水管"
   
2. 原型（最花时间的阶段）：
   番茄1-4: 搭建基础
   番茄5-8: 核心编程
   番茄9-12: 游戏逻辑
   
3. 打磨（让游戏"好玩"）：
   番茄13-16: UI、动画、音效、特效
   
4. 发布：
   番茄17-20: 3D拓展、Shader、导出
```

> ✋ **费曼自测**：用三句话总结"做一个 Godot 游戏"从开始到发布的完整流程。能不能用递进关系说清楚？

### 🛠 番茄20小练习
1. 把之前的 2D 游戏导出为 Windows 可执行文件
2. 设置游戏图标和窗口标题
3. 检查：哪些地方可以优化？（参考 20.2 节）
4. 写下你的"下一个游戏计划"（一个具体的想法）

---

### 🍅 番茄17-20结束，休息5分钟
**回顾清单：**
- ✅ 3D 基础（Node3D、MeshInstance3D、Camera3D）
- ✅ 3D 角色控制（第一人称移动+鼠标视角）
- ✅ 3D 射线拾取
- ✅ Shader 概念（CPU/GPU 并行）
- ✅ VisualShader 可视化编辑
- ✅ 常用 Shader（溶解、波浪、发光）
- ✅ 游戏导出（Windows/Web/Android）
- ✅ 性能优化（VisibleOnScreen、对象池）
- ✅ 最佳实践和后续学习路径

---

## 📦 附录：Godot 4 速查卡

### 快捷键速查

| 快捷键 | 功能 |
|:-------|:-----|
| `W` / `E` / `R` | 移动/旋转/缩放工具 |
| `F` | 聚焦选中节点 |
| `Ctrl+S` | 保存场景 |
| `F5` | 运行主场景 |
| `F6` | 运行当前场景 |
| `F8` | 停止运行 |
| `Ctrl+Shift+F` | 全局搜索 |
| `Ctrl+Shift+O` | 快速打开节点 |

### GDScript 速查

```gdscript
# 声明
var x: int = 10
@export var speed: float = 100.0
@onready var node = $Path/To/Node
const PI := 3.14

# 函数
func add(a: int, b: int) -> int:
    return a + b

# 信号
signal my_signal(value: int)
my_signal.emit(42)
node.my_signal.connect(_on_my_signal)

# 生命周期
func _init()
func _ready()
func _process(delta)
func _physics_process(delta)
func _input(event)

# 节点操作
add_child(node)
remove_child(node)
node.queue_free()
get_node("path")
$path

# 场景切换
get_tree().change_scene_to_file("path.tscn")

# 输入
Input.is_action_pressed("action")
Input.is_action_just_pressed("action")
Input.get_axis("left", "right")

# 物理
move_and_slide()
is_on_floor()
```

### 节点类型速查

| 节点 | 用途 |
|:-----|:-----|
| Node | 最基础节点（功能通用） |
| Node2D | 2D游戏根节点 |
| Sprite2D | 显示2D图片 |
| AnimatedSprite2D | 帧动画 |
| CharacterBody2D | 玩家角色（代码控制） |
| RigidBody2D | 物理物体（物理控制） |
| StaticBody2D | 静态障碍物 |
| Area2D | 感知区域（捡拾/触发/检测） |
| CollisionShape2D | 碰撞形状 |
| Camera2D | 2D摄像机 |
| Control | UI根节点 |
| Label | 文字 |
| Button | 按钮 |
| ProgressBar | 进度条 |
| AnimationPlayer | 动画播放器 |
| Tween | 缓动动画 |
| AudioStreamPlayer2D | 2D音频 |
| GPUParticles2D | GPU粒子系统 |
| Timer | 计时器 |
| CanvasLayer | UI分离层 |
| Marker2D | 位置标记 |
| VisibleOnScreenNotifier2D | 可见性检测 |
| Node3D | 3D根节点 |
| MeshInstance3D | 3D网格体 |
| Camera3D | 3D摄像机 |
| DirectionalLight3D | 方向光（太阳光） |

---

## 📋 学习自检清单

- [ ] **番茄1：** 能说出 Godot 是什么、为什么免费、和 Unity 的核心区别
- [ ] **番茄2：** 能闭眼说出5个面板名称和作用，记住 W/E/R/F 快捷键
- [ ] **番茄3：** 能用"乐高"比喻解释节点 vs 场景，会用 `preload()` + `.instantiate()` + `add_child()`
- [ ] **番茄4：** 能独立写出带 @export 和 @onready 的 GDScript 脚本
- [ ] **番茄5：** 能解释信号的作用，会用 `.connect()` 连接信号和自定义信号
- [ ] **番茄6：** 能画出生命周期执行顺序图，区分 `_process` 和 `_physics_process`
- [ ] **番茄7：** 理解 Vector2 概念，会算 `.normalized() * speed`
- [ ] **番茄8：** 配置过 Input Map，能用 `Input.get_axis()` 读取方向输入
- [ ] **番茄9：** 能用 CharacterBody2D + move_and_slide() 做一个可移动角色
- [ ] **番茄10：** 实现 Coyote Time + 变量跳跃，能说出为什么"手感好"
- [ ] **番茄11：** 能创建子弹场景、实现射击、写巡逻→追击的简单敌人 AI
- [ ] **番茄12：** 使用 Autoload 全局管理分数/血量，实现两个场景切换
- [ ] **番茄13：** 用 Control 节点搭建 HUD，理解锚点和 CanvasLayer
- [ ] **番茄14：** 能用 AnimatedSprite2D 做帧动画，用 Tween 做缓动
- [ ] **番茄15：** 能创建音频总线，理解 Master/Music/SFX 分层
- [ ] **番茄16：** 能用 GPUParticles2D 创建爆炸/火焰粒子
- [ ] **番茄17：** 能创建 3D 场景（MeshInstance3D + 光照 + 摄像机）
- [ ] **番茄18：** 能实现第一人称 3D 角色控制 WASD + 鼠标视角
- [ ] **番茄19：** 理解 Shader 概念，能用 VisualShader 做简单效果
- [ ] **番茄20：** 能导出 Windows 可执行文件，知道优化和最佳实践

> **完成全部 20 个番茄**：恭喜！你已经掌握了 Godot 4.x 的核心知识。建议立刻用这些知识做一个完整的微型游戏（3天以内），将"知道"变成"做到"。
>
> **下一步推荐**：[[🍅Godot实战-第一个2D平台游戏.md]] 或官方教程 "Your First 2D Game"

---

> **创建时间**：2026-06-20
> **版本**：Godot 4.3+ （部分内容适用于 4.0-4.2）
> **教学方法**：番茄工作法 + 费曼学习法 + 刻意练习法
> **记忆文件**：[[Claude_Memory/2026-06-20-Godot20番茄教程创作.md]]
