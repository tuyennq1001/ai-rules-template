# 🤖 Universal AI Agents & Coding Rules Template

> **Bộ khung quy tắc kỹ thuật chuẩn mực cho các AI Coding Assistants** (Antigravity, Cursor, Claude Code, Windsurf, GitHub Copilot, ChatGPT...) áp dụng cho mọi dự án phần mềm.

---

## ⚡️ Sử dụng nhanh trong 1 nốt nhạc

Mở terminal tại thư mục gốc của **bất kỳ project mới nào** và chạy:

```bash
curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/init-agents.sh | bash
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
   alias init-agents='curl -sSL https://raw.githubusercontent.com/tuyennq1001/ai-rules-template/main/init-agents.sh | bash'
   ```
3. Nạp lại cấu hình:
   ```bash
   source ~/.zshrc
   ```
4. Từ giờ ở bất kỳ project mới nào, bạn chỉ cần gõ:
   ```bash
   init-agents
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
7. **Nguyên Tắc 2 Môi Trường & Cổng Build Parity (Dev vs Prod Parity Gate)**: Tách bạch Dev và Prod; bắt buộc build pass cả 2 môi trường trước khi bàn giao.

### PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (PROJECT-SPECIFIC RULES)
*Tùy biến theo từng dự án cụ thể.*
- Thông tin Tech Stack & Environment.
- Các lệnh chạy Unit Test, Build Dev và Build Prod.
- Quy ước kiến trúc & conventions riêng của dự án.

---

## 📄 License

MIT © [Terry (tuyennq.1001@gmail.com)](mailto:tuyennq.1001@gmail.com)
