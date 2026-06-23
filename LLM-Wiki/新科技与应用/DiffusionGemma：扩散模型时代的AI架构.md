---
title: DiffusionGemma：扩散模型时代的AI架构
category: AI架构创新
skill_tag: Skill5
level: 前沿
keywords: DiffusionGemma,扩散模型,MoE,开源,Google
type: tech
---

# DiffusionGemma：扩散模型时代的AI架构

> Google开源DiffusionGemma——26B参数的MoE扩散语言模型，4倍推理加速，彻底改变文本生成方式

## 概述

2026年，Google发布**DiffusionGemma**，这是一个26B参数的实验性MoE（混合专家）模型，采用**扩散**方式生成文本，而非传统的从左到右逐token处理。这代表了AI架构的一个重要方向转变。

## 核心技术：扩散生成

传统LLM像打字机一样从左到右逐字生成文本，而DiffusionGemma像**印刷机**一样并行"印出"整个段落：

| 特性 | 传统LLM（自回归） | DiffusionGemma（扩散） |
|------|-----------------|----------------------|
| 生成方式 | 逐token从左到右 | 并行去噪生成 |
| 类比 | 打字机 | 印刷机 |
| 推理速度 | 基准 | **4x更快** |
| 文本结构 | 适合线性文本 | 适合非线性/编辑场景 |
| 训练方式 | 下一个token预测 | 随机去噪恢复 |

## 性能特点

- **参数量**: 26B MoE（推理时仅激活3.8B）
- **显存需求**: 18GB VRAM（消费级GPU可用）
- **许可证**: Apache 2.0（完全开源）
- **适合场景**: 交互式编程、代码填充、非线性文本结构、行内编辑

## 意义

DiffusionGemma代表AI架构的多元化趋势——自回归不再是唯一选择。扩散模型在并行生成、代码填充等场景具有天然优势，将为AI应用带来更快的响应速度和更灵活的交互方式。

## 关联专题
- [[LLM-Wiki/新科技与应用/AI智能体的系统化时代|AI智能体]]
- [[LLM-Wiki/新科技与应用/世界模型：AI从语言走向物理世界|世界模型]]

## 来源
- Computerworld. (2026). Google unveils DiffusionGemma, an AI model that breaks free of left-to-right processing
