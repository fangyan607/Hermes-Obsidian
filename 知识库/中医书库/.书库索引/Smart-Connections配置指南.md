# Smart Connections 向量索引配置指南

> 配置Obsidian Smart Connections插件为中医书库建立向量索引

---

## 一、插件安装与基础配置

### 1. 安装插件
1. 打开 Obsidian → 设置 → 第三方插件
2. 浏览社区插件，搜索 "Smart Connections"
3. 安装并启用

### 2. 基础设置路径
```
设置 → Smart Connections
```

---

## 二、中医书库专用配置

### 1. 指定索引范围

在 Smart Connections 设置中：

```yaml
# 排除设置
Excluded Folders:
  - .obsidian
  - .trash
  - Claude_Memory

# 包含设置（推荐）
Included Folders:
  - 书库/中医书库
```

**方法**：
1. 进入 Smart Connections 设置
2. 找到 "Excluded Folders" 或 "Include Only"
3. 添加 `书库/中医书库` 到包含列表
4. 或排除其他文件夹，仅索引中医书库

### 2. 嵌入模型选择

推荐配置：
```yaml
Embedding Model:
  - 推荐: text-embedding-3-small (OpenAI)
  - 备选: local-BGE-small (本地模型，免费)
  - 高级: text-embedding-3-large (更精准，成本更高)
```

### 3. 分块设置

```yaml
Chunk Size: 800-1000 tokens
Chunk Overlap: 100-200 tokens
```

**中医书籍分块建议**：
- 方剂类：以单个方剂为一个单元
- 药材类：以单个药材为一个单元
- 病症类：以辨证分型为一个单元
- 理论类：以知识点为一个单元

### 4. 元数据增强

Smart Connections 会读取 YAML frontmatter 进行语义增强：

```yaml
---
title: 黄帝内经素问集注
category: 01-中医基础理论
skill_tag: Skill1
keywords: [阴阳五行, 脏腑, 经络, 气血]
level: 进阶
type: tcm
---
```

---

## 三、索引构建流程

### 步骤1：清空旧索引
1. 打开命令面板 (Ctrl/Cmd + P)
2. 搜索 "Smart Connections: Clear cache"
3. 执行清除缓存

### 步骤2：重建索引
1. 打开命令面板
2. 搜索 "Smart Connections: Re-index"
3. 等待索引完成（大型书库可能需要30-60分钟）

### 步骤3：验证索引
测试查询示例：
- "风寒感冒用什么方剂"
- "足三里的定位和功效"
- "气虚体质如何调理"

---

## 四、高级配置

### 1. 自定义提示词

在 Smart Connections 设置中添加系统提示词：

```
你是中医知识库助手，依据中医书库内容回答问题。
1. 识别问题类型，匹配对应的中医技能标签
2. 辨证内容严谨规范，养生内容通俗易懂
3. 方药穴位给出出处和注意事项
4. 不做医疗诊断，建议就医
```

### 2. 检索参数调优

```yaml
# 相似度阈值
Similarity Threshold: 0.7-0.8

# 返回结果数量
Top K Results: 5-10

# 混合检索（语义+关键词）
Hybrid Search: true
```

### 3. 缓存管理

```yaml
# 缓存位置
Cache Location: .smart-connections/

# 自动更新频率
Auto Update: on file change

# 手动刷新周期
Manual Refresh: 每周一次
```

---

## 五、中医书库专用功能

### 1. 按分类检索

在查询时添加分类过滤：
```
【中医基础】阴阳五行理论
【方剂】治疗风寒感冒的方剂
【针灸】足三里穴位
```

### 2. 技能标签触发

在 YAML 中定义的 `skill_tag` 可用于过滤：
- `skill_tag: Skill1` → 基础理论
- `skill_tag: Skill2` → 辨证诊断
- `skill_tag: Skill4` → 方剂配伍

### 3. 难度分层

```
level: 入门 → 养生科普内容
level: 进阶 → 专业学习内容
level: 临床实操 → 临床应用内容
```

---

## 六、常见问题解决

### Q1: 索引速度慢
- 减少并发数
- 使用更轻量的嵌入模型
- 分批索引大型丛书

### Q2: 检索结果不准确
- 调整相似度阈值
- 增加 Top K 结果数
- 检查 YAML 元数据完整性

### Q3: 内存占用高
- 清理旧缓存
- 减少索引范围
- 使用本地小型模型

---

## 七、维护建议

### 日常维护
- 新增书籍后手动刷新索引
- 定期检查元数据完整性
- 清理无效链接

### 月度维护
- 全量重建索引
- 更新提示词模板
- 优化检索参数

---

相关链接：
- [[README|中医书库索引中心]]
- [[书籍元数据索引]]
- [[技能模块索引]]
