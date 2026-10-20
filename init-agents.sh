#!/usr/bin/env bash
set -e

TEMPLATE="${1:-default}"
DEST_FILE="AGENTS.md"

if [ -f "$DEST_FILE" ]; then
    echo "⚠️  File $DEST_FILE đã tồn tại trong thư mục hiện tại."
    printf "Bạn có muốn ghi đè không? (y/N): "
    read -r answer
    if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
        echo "❌ Đã hủy thao tác."
        exit 0
    fi
fi

BASE_URL="https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main"

if [ "$TEMPLATE" = "macos" ]; then
    URL="${BASE_URL}/templates/macos/AGENTS.macos.md"
    echo "📥 Đang tải template AGENTS.md chuyên biệt cho macOS App (SwiftUI / AppKit)..."
else
    URL="${BASE_URL}/AGENTS.md"
    echo "📥 Đang tải template AGENTS.md chuẩn Universal..."
fi
curl -sSL "$URL" -o "$DEST_FILE"

echo "✅ Đã tạo thành công file $DEST_FILE!"
echo "👉 Hãy mở $DEST_FILE và cập nhật PHẦN 2 (PROJECT-SPECIFIC RULES) phù hợp với tech stack của dự án nhé."
