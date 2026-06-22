# 复习试卷-14-Fine-tuning实操

---

## Section A：费曼学习法复习文档

### 知识点1：提示工程 vs RAG vs 微调

当模型输出错误回复时，需判断问题根源：
- **没问清楚** → 提示工程（优化 prompt）
- **缺乏背景知识** → RAG（检索增强生成）
- **能力不足** → 微调（Fine-tuning）

### 知识点2：s1 模型——50 美元复刻 R1

李飞飞团队用不到 **50 美元** 云计算费用训练出 **s1** 推理模型，数学和编码能力与 OpenAI o1、DeepSeek-R1 不相上下。

**s1K 数据集构建**：从 **难度、多样性、质量** 三个标准出发，从约 59,000 个问题中精选 **1,000 个** 样本。包含数学竞赛、物理竞赛、概率问题（s1-prob）和定量交易面试题（s1-teasers）。使用 Gemini 2.0 Flash Thinking API 生成推理路径。

**Budget Forcing（预算强制）**：一种控制测试时计算量的技术：
1. 设定最大思考 token 上限
2. 超过上限时插入结束标记强制终止
3. 若想鼓励深入探索，抑制终止标记并追加 `"Wait"` 字符串，让模型重新检查推理

**训练过程**：数据准备（s1K）→ 选择 Qwen2.5-32B-Instruct 做 SFT → 测试时应用 Budget Forcing。在 **16 个 H100 GPU** 上耗时约 **26 分钟**。

### 知识点3：Unsloth 高效微调工具

开源工具，专注于加速 LLM 微调：
- 微调速度比传统方法快 **2-5 倍**，内存减少 **50-80%**
- **7GB 显存** 可训练 1.5B 参数模型，**15GB** 可支持 15B
- 集成 **GRPO** 算法（群体相对策略优化）
- 支持 GGUF、Ollama、vLLM 等格式，支持 QLoRA/LoRA 量化
- 提供免费 Colab Notebook

### 知识点4：CASE——Qwen2.5-7B 微调（alpaca-cleaned）

**数据集**：`yahma/alpaca-cleaned`（Stanford Alpaca-52k 的清理版），每条数据包含 instruction（必填）、input（选填）、output（必填）。

**关键 API 调用流程**：
1. `FastLanguageModel.from_pretrained()` — 加载基础和分词器，支持 `load_in_4bit` 量化
2. `FastLanguageModel.get_peft_model()` — 添加 LoRA 适配器，仅更新 1-10% 参数
3. LoRA 参数：`r=16`（秩）、`lora_alpha=16`、`lora_dropout=0`、`target_modules=["q_proj","k_proj","v_proj","o_proj","gate_proj","up_proj","down_proj"]`
4. 定义 Alpaca prompt 模板，必须添加 `EOS_TOKEN` 防止无限生成
5. `SFTTrainer` — 配置训练参数：`batch_size=2`、`gradient_accumulation_steps=4`、`max_steps=60`、`learning_rate=2e-4`、`optim="adamw_8bit"`
6. 推理：`FastLanguageModel.for_inference(model)` 启用 2 倍速推理
7. 保存：`model.save_pretrained("lora_model")`

### 知识点5：CASE——训练中文医疗垂直模型

数据集：`Chinese-medical-dialogue-data`，包含 **6 个科室**（男科 94,596、内科 220,606、妇产科 183,751、肿瘤科 75,553、儿科 101,602、外科 115,991）。

**踩坑记录**：CSV 文件不是 UTF-8 编码导致 `UnicodeDecodeError` → 需在 `pd.read_csv()` 中指定正确编码。

训练参数区别：医疗垂类模型设置 `max_steps=-1` 配合 `num_train_epochs=3`，即完整遍历数据集 3 次。实际 batch_size = 2 × 4 = 8。

### 知识点6：CASE——训练自己的 R1 模型

使用 **Unsloth + GRPO** 训练推理模型：

**安装**：`pip install unsloth vllm`；导入 `FastLanguageModel` 和 `PatchFastRL("GRPO", FastLanguageModel)`

**基础模型**：`meta-llama/meta-Llama-3.1-8B-Instruct`

**数据集**：**GSM8K**（Grade School Math 8K）——小学数用题，仅含 question 和 answer 两列，**不包含 reasoning 过程**。

**GRPO 如何引导推理能力**：GRPO 不需要显式 reasoning 训练数据。模型对每个问题生成多个候选输出（`num_generations=6`），每个输出经所有奖励函数打分，高奖励输出指导模型改进。

**5 个奖励函数**：
| 函数 | 作用 |
|------|------|
| `xmlcount_reward_func` | 检查 XML 标签正确使用 |
| `soft_format_reward_func` | 检查是否包含 `<reasoning>` 和 `<answer>` 标签 |
| `strict_format_reward_func` | 严格检查格式 |
| `int_reward_func` | 检查答案是否为数字 |
| `correctness_reward_func` | 检查最终答案是否正确 |

**训练配置**：`GRPOConfig(learning_rate=5e-6, max_steps=250, use_vllm=True)`

**输出格式**：
```
<reasonning>
...
</reasoning>
<answer>
...
</answer>
```

### 知识点7：GRPO vs PPO

| 特性 | GRPO | PPO |
|------|------|-----|
| 价值网络 | 无需，直接用组内奖励 | 依赖价值网络 |
| 奖励计算 | 组内归一化算相对优势 | GAE，依赖未来折扣总和 |
| 策略更新 | KL 散度约束 | 裁剪概率比 |
| 计算效率 | 高，内存占用低 | 低，内存占用高 |
| 稳定性 | 组内相对奖励减少方差 | 裁剪概率比保持稳定 |

### 知识点8：Qwen-VL 视觉模型微调

**场景**：车辆里程表识别——从图片提取总里程、速度、时间、温度、挡位等信息。

**LoRA 配置**：`FastVisionModel.get_peft_model()`，可控制 `finetune_vision_layers`、`finetune_language_layers`、`finetune_attention_modules`、`finetune_mlp_modules`。

**训练数据准备**：Excel 文件（id/prompt/image/response）→ `pandas.read_excel()` → `PIL.Image.open()` 加载图片 → 转换为标准 messages 格式（包含 text 和 image 类型的 content）。

**SFT 配置特殊项**：使用 `UnslothVisionDataCollator`，设置 `remove_unused_columns=False` 和 `dataset_kwargs={"skip_prepare_dataset": True}`。

### 知识点9：AI 大模型趋势

1. **小模型成为主流**（大模型蒸馏）——DeepSeek-R1-Distill-Qwen-7B 在 AIME 2024 击败 32B 模型
2. **合成数据训练成为主流**
3. **AI 模型自我迭代**：自出题→自检查→筛验证对的数据→思维链合成新训练数据（类似 AlphaGo-Zero）

### 知识点10：TRL SFTTrainer

Hugging Face TRL 库中的监督微调工具：
- 支持 PEFT（LoRA）减少内存
- 自动处理常见数据格式
- 支持 packing 技术（短序列合并，提速 5 倍）
- 保留原始 Trainer 所有功能

---

## Section B：复习试卷

### 一、选择题（每题 3 分，共 30 分）

**1.** s1 模型训练使用了多少个样本数据？
A. 59000
B. 1000
C. 52000
D. 10000

**2.** Budget Forcing 技术中，为了让模型更深入思考，会在推理路径后追加什么字符串？
A. "Continue"
B. "Think more"
C. "Wait"
D. "Recheck"

**3.** 以下哪个不是 s1K 数据集构建的挑选标准？
A. 难度
B. 多样性
C. 规模
D. 质量

**4.** Unsloth 进行模型微调时，微调速度比传统方法快多少？
A. 1-2 倍
B. 2-5 倍
C. 5-10 倍
D. 10-20 倍

**5.** 在 Qwen2.5-7B 微调案例中，LoRA 的秩（r）参数设置为多少？
A. 8
B. 16
C. 32
D. 64

**6.** 训练医疗垂直模型时遇到 `UnicodeDecodeError` 的原因是？
A. 模型不支持中文
B. CSV 文件不是 UTF-8 编码
C. GPU 显存不足
D. 数据集格式不匹配

**7.** GRPO 训练 R1 模型时，以下哪个不是奖励函数？
A. `xmlcount_reward_func`
B. `format_reward_func`
C. `correctness_reward_func`
D. `int_reward_func`

**8.** GSM8K 数据集中包含哪两列数据？
A. instruction 和 output
B. question 和 answer
C. prompt 和 response
D. reasoning 和 answer

**9.** 关于 GRPO 与 PPO 的对比，以下哪个说法正确？
A. GRPO 需要价值网络，PPO 不需要
B. GRPO 使用 KL 散度约束策略更新
C. PPO 计算效率更高
D. GRPO 计算效率更低

**10.** Qwen-VL 视觉模型微调中，训练数据转换时图片用什么库加载？
A. OpenCV
B. PIL (Pillow)
C. Matplotlib
D. TensorFlow Image

### 二、填空题（每空 2 分，共 20 分）

**1.** s1 模型的训练基础模型是 \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_。

**2.** s1 模型训练在 \_\_\_\_\_\_ 个 H100 GPU 上耗时约 \_\_\_\_\_\_ 分钟。

**3.** Unsloth 仅需 \_\_\_\_\_\_ GB 显存即可训练 1.5B 参数的模型。

**4.** Alpaca prompt 模板中，格式化数据时必须添加 \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_，否则生成会无限继续。

**5.** 医疗垂类模型训练中，`max_steps=-1` 配合 `num_train_epochs=3`，实际有效 batch size 是 \_\_\_\_\_\_。

**6.** GRPO 训练中，模型对每个问题生成 \_\_\_\_\_\_ 个候选输出。

**7.** GRPO 的训练配置中，学习率设置为 \_\_\_\_\_\_。

**8.** Qwen-VL 微调的 SFT 训练器使用了 \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ 作为数据整理器（data collator）。

### 三、问答题（每题 15 分，共 30 分）

**1.** 请描述 s1 模型的完整训练流程（数据准备、模型选择、训练过程、测试阶段技术），并解释 Budget Forcing 的工作原理。

**2.** GRPO 算法如何在没有显式 reasoning 训练数据（如 GSM8K 只有 question 和 answer）的情况下，引导模型学会在 `<reasoning>` 标签中展示推理过程？请结合奖励函数设计说明。

### 四、代码阅读题（20 分）

请分析以下代码片段，回答问题：

```python
from unsloth import FastLanguageModel

model, tokenizer = FastLanguageModel.from_pretrained(
    model_name = "/root/autodl-tmp/models/Qwen/Qwen2___5-7B-Instruct",
    max_seq_length = max_seq_length,
    dtype = dtype,
    load_in_4bit = True,
)

model = FastLanguageModel.get_peft_model(
    model,
    r = 16,
    target_modules = ["q_proj", "k_proj", "v_proj", "o_proj",
                      "gate_proj", "up_proj", "down_proj"],
    lora_alpha = 16,
    lora_dropout = 0,
    bias = "none",
    use_gradient_checkpointing = "unsloth",
    random_state = 3407,
)
```

**问题：**
1. `load_in_4bit = True` 的作用是什么？
2. `target_modules` 参数指定了哪些模块？为什么要指定这些模块？
3. `r = 16` 和 `lora_alpha = 16` 分别代表什么含义？
4. `use_gradient_checkpointing = "unsloth"` 的优化效果是什么？

---

### 参考答案

#### 选择题答案
1. B（1000 个）
2. C（"Wait"）
3. C（规模——标准是难度、多样性、质量）
4. B（2-5 倍）
5. B（16）
6. B（CSV 文件不是 UTF-8 编码）
7. B（`format_reward_func` 不存在，实际有 soft_format 和 strict_format 两个）
8. B（question 和 answer）
9. B（GRPO 使用 KL 散度约束策略更新）
10. B（PIL）

#### 填空题答案
1. Qwen2.5-32B-Instruct
2. 16, 26
3. 7
4. EOS_TOKEN
5. 8
6. 6
7. 5e-6
8. UnslothVisionDataCollator

#### 问答题参考答案

**第 1 题要点：**
- **数据准备**：从约 59,000 个问题中精选 1,000 个（s1K），经难度/多样性/质量筛选，用 Gemini 2.0 Flash Thinking API 生成推理路径
- **模型选择**：Qwen2.5-32B-Instruct 作为基础模型
- **训练过程**：在 s1K 数据上做监督微调（SFT），16 个 H100 GPU 上约 26 分钟
- **Budget Forcing**：设定最大思考 token 上限 → 超过时插入结束标记终止 → 需要深入思考时抑制终止标记并追加 "Wait" 让模型重新检查

**第 2 题要点：**
- GRPO 不需要显式 reasoning 训练数据，通过**奖励函数**引导模型生成 reasoning
- 模型对每个问题生成 6 个候选输出，每个经所有奖励函数打分
- `soft_format_reward_func` 用正则检查是否包含 `<reasoning>...</reasoning>` 和 `<answer>...</answer>` 标签
- `strict_format_reward_func` 严格检查格式
- `xmlcount_reward_func` 检查 XML 标签使用
- 高奖励输出被用来指导模型改进生成策略
- Llama 模型本身已具备推理能力，GRPO 通过奖励机制引导模型**将内部的推理过程显式写出来**

#### 代码阅读题参考答案

1. `load_in_4bit = True`：使用 4-bit 量化加载模型，显著减少内存占用，使得在有限显存下也能加载大模型。

2. `target_modules` 指定了 Q 投影（q_proj）、K 投影（k_proj）、V 投影（v_proj）、输出投影（o_proj）以及 MLP 层的门控投影（gate_proj）、上投影（up_proj）、下投影（down_proj）。这些是 Transformer 中注意力机制和前馈网络的核心线性层，对它们应用 LoRA 可以以少量参数更新实现有效的模型微调。

3. `r = 16` 是 LoRA 的秩（rank），决定低秩矩阵的维度，控制可训练参数量；`lora_alpha = 16` 是 LoRA 的缩放因子，控制 LoRA 权重更新的缩放比例。

4. `use_gradient_checkpointing = "unsloth"` 使用 Unsloth 优化的梯度检查点技术，可减少约 30% 的显存使用，以少量计算时间换取显存空间的节省。
