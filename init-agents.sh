#!/usr/bin/env bash
set -e

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

URL="https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/AGENTS.md"
echo "📥 Đang tải template AGENTS.md từ $URL..."
curl -sSL "$URL" -o "$DEST_FILE"

echo "✅ Đã tạo thành công file $DEST_FILE!"
echo "👉 Hãy mở $DEST_FILE và cập nhật PHẦN 2 (PROJECT-SPECIFIC RULES) phù hợp với tech stack của dự án nhé."
