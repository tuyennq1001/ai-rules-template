#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "manifest.json" ]; then
  echo "❌ Không tìm thấy manifest.json ở thư mục hiện tại."
  exit 1
fi

echo "🔎 Kiểm tra manifest.json..."
MANIFEST_INFO=$(node -e "
const fs = require('fs');
const m = JSON.parse(fs.readFileSync('manifest.json', 'utf8'));
if (m.manifest_version !== 3) {
  console.error('❌ manifest_version phải là 3');
  process.exit(1);
}
if (!m.description || m.description.length > 132) {
  console.error('❌ description thiếu hoặc vượt quá 132 ký tự:', (m.description || '').length);
  process.exit(1);
}
const slug = (m.name || 'extension').toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
console.log(slug + '|' + m.version);
")

SLUG="${MANIFEST_INFO%%|*}"
VERSION="${MANIFEST_INFO##*|}"
OUT_DIR="store-assets"
ZIP_PATH="${OUT_DIR}/${SLUG}-v${VERSION}.zip"

mkdir -p "$OUT_DIR"

if [ -f "package.json" ] && node -e "const p=require('./package.json'); process.exit(p.scripts && p.scripts.test ? 0 : 1)"; then
  echo "🧪 Chạy unit tests..."
  npm test
fi

echo "📦 Đóng gói ${ZIP_PATH}..."
rm -f "$ZIP_PATH"
zip -r -X "$ZIP_PATH" . \
  -x ".git/*" \
  -x "docs/*" \
  -x "store-assets/*" \
  -x "test/*" \
  -x "tests/*" \
  -x "node_modules/*" \
  -x "*.zip" \
  -x "*.md" \
  -x "*.sh" \
  -x "package*.json" \
  -x ".gitignore" \
  -x ".DS_Store" \
  -x "**/.DS_Store"

echo "🛡️  Kiểm tra toàn vẹn file zip..."
unzip -t "$ZIP_PATH"
unzip -l "$ZIP_PATH"

if command -v python3 >/dev/null 2>&1 && python3 -c "import PIL" >/dev/null 2>&1; then
  echo "🖼️  Kiểm tra kích thước & kênh màu ảnh trong ${OUT_DIR}/..."
  python3 -c "
import glob
from PIL import Image
for p in sorted(glob.glob('${OUT_DIR}/*.png')):
    im = Image.open(p)
    print(f'  - {p}: {im.size[0]}x{im.size[1]} ({im.mode})')
"
fi

echo "✅ Hoàn tất đóng gói: ${ZIP_PATH}"
