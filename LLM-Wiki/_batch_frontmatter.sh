#!/bin/bash
# 批量补全 YAML Frontmatter 脚本
# 为知识库中缺少 frontmatter 的 .md 文件添加元数据
# 用法: bash _batch_frontmatter.sh

add_fm_if_needed() {
    local file="$1"
    local category="$2"
    local type="$3"
    local title="$4"

    # 跳过已存在 frontmatter 的文件
    if [ "$(head -1 "$file" 2>&1)" = "---" ]; then
        return
    fi

    # 用文件名作为标题（如果未指定）
    if [ -z "$title" ]; then
        title="$(basename "$file" .md)"
    fi

    # 创建临时文件写入 frontmatter + 原内容
    {
        echo "---"
        echo "title: \"$title\""
        echo "category: $category"
        echo "type: $type"
        echo "---"
        echo ""
        cat "$file"
    } > "${file}.tmp" && mv "${file}.tmp" "$file"

    echo "  + $file"
}

echo "=========================================="
echo "开始批量补全 YAML Frontmatter"
echo "=========================================="

# ===== 1. 创造性思维 (16 files) =====
echo ""
echo "[1/5] 创造性思维..."
cd "$(dirname "$0")/创造性思维"
for f in *.md; do
    case "$f" in
        Log.md|Obsidian-LLMWIKI*) continue ;;
        *.md) add_fm_if_needed "$f" "创造性思维" "creativity" ;;
    esac
done

# ===== 2. 学习方法 (15 files) =====
echo ""
echo "[2/5] 学习方法..."
cd "$(dirname "$0")/学习方法"
for f in *.md; do
    case "$f" in
        Log.md|Obsidian-LLMWIKI*) continue ;;
        *.md) add_fm_if_needed "$f" "学习方法" "learning" ;;
    esac
done

# ===== 3. 中国法律书库 (2554 files) =====
echo ""
echo "[3/5] 中国法律书库..."
cd "$(dirname "$0")/中国法律书库"
# 按子目录分类处理
for dir in 中国法律 行政法规 司法解释; do
    echo "  - 处理 $dir/..."
    for f in "$dir"/*.md; do
        [ -f "$f" ] || continue
        add_fm_if_needed "$f" "$dir" "law"
    done
done
for f in 法律相关/*.md; do
    [ -f "$f" ] || continue
    add_fm_if_needed "$f" "法律学习书籍" "law"
done
for f in "2025年度案例"/*.md; do
    [ -f "$f" ] || continue
    add_fm_if_needed "$f" "年度案例" "law"
done

# ===== 4. 心理学书库 (123+ files) =====
echo ""
echo "[4/5] 心理学书库..."
cd "$(dirname "$0")/心理学书库"
for f in *.md; do
    case "$f" in
        Log.md|Obsidian-LLMWIKI*) continue ;;
        *.md) add_fm_if_needed "$f" "心理学" "psychology" ;;
    esac
done

# ===== 5. 中医书库 =====
echo ""
echo "[5/5] 中医书库..."
cd "$(dirname "$0")/中医书库"
for f in *.md; do
    case "$f" in
        Log.md|Obsidian-LLMWIKI*) continue ;;
        *.md) add_fm_if_needed "$f" "中医" "tcm" ;;
    esac
done

# ===== 6. 道医全集 =====
echo ""
echo "[6/6] 道医全集..."
cd "$(dirname "$0")/道医全集"
for f in *.md; do
    case "$f" in
        Log.md|Obsidian-LLMWIKI*) continue ;;
        *.md) add_fm_if_needed "$f" "道医" "tcm" ;;
    esac
done

echo ""
echo "=========================================="
echo "批量 Frontmatter 补全完成！"
echo "=========================================="
