# 🤖 Universal AI Agents & Coding Rules Template

> **Bộ khung quy tắc kỹ thuật chuẩn mực cho các AI Coding Assistants** (Antigravity, Cursor, Claude Code, Windsurf, GitHub Copilot, ChatGPT...) áp dụng cho mọi dự án phần mềm.

---

## ⚡️ Sử dụng nhanh trong 1 nốt nhạc

Mở terminal tại thư mục gốc của **bất kỳ project mới nào** và chạy:

```bash
# Template chuẩn chung (Universal cho mọi dự án: Web, Backend, Mobile, Desktop...)
curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/init-agents.sh | bash

# Hoặc template chuyên biệt cho macOS App (SwiftUI + AppKit + Sparkle 2):
curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/init-agents.sh | bash -s macos
```

Hoặc tải trực tiếp file `AGENTS.md`:

```bash
curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/AGENTS.md -o AGENTS.md
```

---

## 🛠 Cài đặt Alias vào Shell (`~/.zshrc` hoặc `~/.bashrc`)

Để mỗi lần tạo dự án mới chỉ cần gõ đúng 1 từ `init-agents`:

1. Mở file cấu hình shell:
   ```bash
   nano ~/.zshrc
   ```
2. Thêm dòng alias sau vào cuối file:
   ```bash
   alias init-agents='curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/init-agents.sh | bash -s'
   ```
3. Nạp lại cấu hình:
   ```bash
   source ~/.zshrc
   ```
4. Từ giờ ở bất kỳ project mới nào, bạn chỉ cần gõ:
   ```bash
   # Dự án chung
   init-agents

   # Dự án macOS App
   init-agents macos
   ```

---

## 💎 Cấu Trúc File `AGENTS.md`

Tài liệu được thiết kế theo mô hình **Hybrid 2 Phần**:

### PHẦN 1: NGUYÊN TẮC KỸ THUẬT CHUNG (UNIVERSAL COMMON RULES)
*Độc lập ngôn ngữ & nền tảng — Giữ nguyên 100% cho mọi dự án.*
1. **Quy trình Git Branching & Quản lý PR (Git Automation Workflow)**: Tuyệt đối không commit trực tiếp `main`/`master`, luôn tạo nhánh `feature/` hoặc `fix/`, quy chuẩn commit $\le$ 72 ký tự, chờ xác nhận trải nghiệm thực tế mới commit/push/merge.
2. **An toàn Thực thi Terminal & Script**: Cấm inline script dài trong `-c`, cấm pipe blocking filter làm treo tiến trình build, giới hạn độ dài command.
3. **Trung thực Dữ liệu & Phê duyệt Trước khi Code (Mandatory Approval)**: Cấm chế dữ liệu fake, giải thích nguyên nhân gốc rễ và bắt buộc chờ user phê duyệt phương án bằng lời nhắn mới được sửa code.
4. **Tiêu chuẩn Kỹ thuật Hiệu năng (Performance Engineering)**: Cô lập state tần số cao, cấm tính toán nặng trong render loop, tối ưu allocation & GC, ảo hóa danh sách lớn, buffer realtime streams, non-blocking I/O.
5. **Tư duy Triển khai Ngang (Horizontal Deployment Mindset)**: Feature Parity, Environment Parity, State Parity (4 trạng thái: Loading, Empty, Error, Loaded), Zero Layout Shift.
6. **An toàn Concurrency & Kiểm thử Hồi quy (Concurrency & Test Guard)**: Luồng UI vs Background, viết unit test chống tái phát lỗi.
7. **Nguyên Tắc 2 Môi Trường & Cổng Build Parity (Dev vs Prod Parity Gate)**: Tách bạch Dev và Prod; nhận diện thị giác (badge DEV, tiêu đề app dev); vô hiệu hóa auto-update trên bản Dev; bắt buộc build pass cả 2 môi trường trước khi bàn giao.
8. **Chuẩn Hóa Tự Động Phát Hành & Phân Phối (Release Automation & Distribution Guard)**: Tự động hóa phát hành một lệnh (Zero-manual-touch release) từ build, smoke test, code-signing, Apple Notarization, Sparkle EdDSA sign đến tạo GitHub Release; tự động dọn dẹp helper zip từ dependencies tránh lỗi kiểm duyệt bảo mật.

### PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (PROJECT-SPECIFIC RULES)
*Tùy biến theo từng dự án cụ thể.*
- Thông tin Tech Stack & Environment.
- Các lệnh chạy Unit Test, Build Dev và Build Prod.
- Quy ước kiến trúc & conventions riêng của dự án.

---

## 🍏 Bộ Mẫu Chuyên Biệt Cho macOS App (`templates/macos`)

Kho lưu trữ cung cấp sẵn bộ khung chuẩn mực cho phát triển và tự động phát hành macOS Desktop App (SwiftUI + AppKit):
- **`templates/macos/AGENTS.macos.md`**: Bộ quy tắc đầy đủ cấu hình sẵn cho macOS (Quản lý NSPopover Menu Bar, font chữ Unicode tiếng Việt, kênh âm thanh, Sparkle 2 silent auto-update).
- **`templates/macos/release.sh`**: Script tự động phát hành 9 bước hoàn chỉnh: Build Release ➔ Smoke test ➔ Dọn dẹp SPM helper zips ➔ Ký số Developer ID ➔ Apple Notarization (`GOX_NOTARY` / `notarytool`) & Stapling ➔ Sparkle EdDSA sign ➔ Cập nhật `appcast.xml` ➔ Git Tag & GitHub Release.
- **`templates/macos/release-notes/template.html`**: Mẫu ghi chú phát hành HTML chuẩn Sparkle.
- **`templates/macos/appcast.xml`**: Mẫu feed ban đầu cho Sparkle 2.

---

## 📄 License

MIT © [Terry (tuyennq.1001@gmail.com)](mailto:tuyennq.1001@gmail.com)
