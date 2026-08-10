# GBrain 自动知识库

## 自动生成的内容
- `知识图谱.json` — 完整知识图谱（节点+边）
- `向量索引.json` — 关键词倒排索引
- `_index/总索引.md` — 全局概览
- `_index/<域>.md` — 每域索引表

## 使用方式
在 Hermes 中搜索知识：
```
加载 gbrain-auto-sync 技能
python scripts/gbrain_scanner.py --search <关键词>
python scripts/gbrain_scanner.py --graph <实体名>
```

> 最后更新: 2026-08-10 23:03:35
> 文档数: 5 · 域数: 1
