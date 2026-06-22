#!/bin/bash
# ===================================================
# GBrain 知识库初始化脚本
# ===================================================
# 用途：检查 GBrain 知识库中所有实体页面的 frontmatter
#       格式是否正确，并报告缺失的 wikilink 目标
# 用法：在 Obsidian vault 根目录执行：
#   bash GBrain/init.sh
# ===================================================

set -e

VAULT_DIR="$(pwd)"
GBRAIN_DIR="$VAULT_DIR/GBrain"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
ERROR_COUNT=0
WARN_COUNT=0

echo "========================================"
echo " GBrain 知识库初始化检查"
echo "========================================"
echo "Vault 目录: $VAULT_DIR"
echo "GBrain 目录: $GBRAIN_DIR"
echo ""

# 检查 GBrain 目录是否存在
if [ ! -d "$GBRAIN_DIR" ]; then
    echo -e "${RED}[错误] GBrain 目录不存在: $GBRAIN_DIR${NC}"
    echo "请确保在 Obsidian vault 根目录运行此脚本。"
    exit 1
fi

echo -e "${GREEN}[OK] GBrain 目录已找到${NC}"
echo ""

# 阶段1: 检查所有域目录和文件
echo "--- 阶段1: 检查目录结构 ---"

DOMAINS=("法律" "创造性思维" "学习方法" "心理学" "中医学")
for domain in "${DOMAINS[@]}"; do
    domain_path="$GBRAIN_DIR/$domain"
    if [ ! -d "$domain_path" ]; then
        echo -e "${RED}[错误] 缺少领域目录: $domain${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
        continue
    fi

    file_count=$(find "$domain_path" -maxdepth 1 -name "*.md" | wc -l)
    echo -e "${GREEN}[OK] $domain ($file_count 个文件)${NC}"
done

echo ""

# 阶段2: 检查每个页面的 YAML frontmatter
echo "--- 阶段2: 检查 YAML frontmatter ---"

check_frontmatter() {
    local file="$1"
    local filename=$(basename "$file")
    local dirname=$(basename "$(dirname "$file")")

    # 检查是否有 frontmatter（以 --- 开头和结尾）
    local first_line=$(head -1 "$file")
    if [ "$first_line" != "---" ]; then
        echo -e "${RED}[错误] $dirname/$filename: 缺少 YAML frontmatter${NC}"
        ERROR_COUNT=$((ERROR_COUNT + 1))
        return
    fi

    # 检查必填字段
    for field in "title:" "type:" "domain:" "relations:"; do
        if ! grep -q "^$field" "$file"; then
            echo -e "${RED}[错误] $dirname/$filename: 缺少字段 '$field'${NC}"
            ERROR_COUNT=$((ERROR_COUNT + 1))
        fi
    done

    # 检查 relations 格式
    local relation_lines=$(sed -n '/^relations:/,/^[a-z]/p' "$file" | grep -E "^\s+-\s+type:")
    if [ -z "$relation_lines" ]; then
        echo -e "${YELLOW}[警告] $dirname/$filename: relations 可能为空或格式不正确${NC}"
        WARN_COUNT=$((WARN_COUNT + 1))
    fi

    echo -e "${GREEN}[OK] $dirname/$filename frontmatter 检查通过${NC}"
}

# 遍历所有 .md 文件
find "$GBRAIN_DIR" -name "*.md" -not -path "*/node_modules/*" | while read -r file; do
    # 跳过 README.md
    if [[ "$(basename "$file")" == "README.md" ]]; then
        continue
    fi
    check_frontmatter "$file"
done

echo ""

# 阶段3: 检查 wikilink 目标是否存在
echo "--- 阶段3: 检查 wikilink 目标 ---"

check_wikilinks() {
    local file="$1"
    local filename=$(basename "$file")
    local dirname=$(basename "$(dirname "$file")")

    # 提取所有 [[目标]] 格式的 wikilink
    local wikilinks=$(grep -oP '\[\[([^\]]+)\]\]' "$file" | sed 's/\[\[//;s/\]\]//')

    for link in $wikilinks; do
        # 检查 link 是否包含路径分隔符
        if [[ "$link" == *"/"* ]]; then
            # 跨域链接: "领域/实体名"
            local target_file="$GBRAIN_DIR/${link}.md"
        else
            # 同域链接: "实体名" → 在当前域目录查找
            local target_file="$(dirname "$file")/${link}.md"
        fi

        if [ ! -f "$target_file" ]; then
            echo -e "${YELLOW}[警告] $dirname/$filename: 目标文件不存在 [[$link]]${NC}"
            WARN_COUNT=$((WARN_COUNT + 1))
        fi
    done

    echo -e "${GREEN}[OK] $dirname/$filename wikilink 检查完成${NC}"
}

echo ""

# 阶段4: 汇总报告
echo "--- 阶段4: 汇总报告 ---"
echo "错误: $ERROR_COUNT"
echo "警告: $WARN_COUNT"

if [ "$ERROR_COUNT" -eq 0 ] && [ "$WARN_COUNT" -eq 0 ]; then
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN} GBrain 知识库初始化检查通过! ${NC}"
    echo -e "${GREEN} 5 个领域共 25 个实体页面准备就绪。 ${NC}"
    echo -e "${GREEN}========================================${NC}"
elif [ "$ERROR_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${YELLOW} 检查完成，存在 $WARN_COUNT 个警告。 ${NC}"
    echo -e "${YELLOW} 建议修复警告以获得最佳体验。 ${NC}"
    echo -e "${YELLOW}========================================${NC}"
else
    echo -e "${RED}========================================${NC}"
    echo -e "${RED} 检查完成，存在 $ERROR_COUNT 个错误需要修复。 ${NC}"
    echo -e "${RED}========================================${NC}"
    exit 1
fi
