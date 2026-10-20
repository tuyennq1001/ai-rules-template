# AGENTS & CODING RULES (QUY TẮC VẬN HÀNH & KỸ THUẬT CHO AI AGENT)

Tài liệu này là bộ quy tắc cốt lõi gồm 2 phần rõ rệt:
- **PHẦN 1: NGUYÊN TẮC KỸ THUẬT CHUNG (UNIVERSAL COMMON RULES)**: Bắt buộc tuân thủ trên mọi dự án phần mềm (Web, Mobile, Backend, Desktop, CLI... bất kể ngôn ngữ & framework). **Giữ nguyên 100% khi copy sang dự án mới hoặc đưa vào ChatGPT/Claude/Cursor/Antigravity/Copilot.**
- **PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (PROJECT-SPECIFIC RULES)**: Tùy biến theo từng dự án cụ thể (Tech stack, môi trường Dev/Prod, command build/test, coding convention nội bộ).

---

# ==============================================================================
# PHẦN 1: QUY TẮC KỸ THUẬT CHUNG CHO MỌI DỰ ÁN (UNIVERSAL COMMON RULES)
# (Độc lập ngôn ngữ & nền tảng — Tái sử dụng nguyên vẹn cho bất kỳ dự án nào)
# ==============================================================================

## 1. Quy trình Git Branching & Quản lý PR (Git Automation Workflow)
- **Tuyệt đối không commit trực tiếp vào nhánh chính**: Không bao giờ commit lên `main` hoặc `master`.
- **Luôn tạo nhánh riêng biệt trước khi viết code**: Tự động tạo nhánh `feature/<tên-tính-năng>` hoặc `fix/<tên-lỗi>` từ nhánh chính trước khi thực hiện bất kỳ thay đổi nào.
- **Quy trình chuẩn 4 bước**:
  1. Viết code.
  2. Chạy toàn bộ bộ kiểm thử tự động (Unit / Integration Tests) — **PHẢI PASS 100%**.
  3. Chạy build/compile dự án — **PHẢI BUILD THÀNH CÔNG**.
  4. Chờ người dùng xác nhận trải nghiệm thực tế chạy đúng mong đợi ➔ **Mới tiến hành commit**.
- **Tiêu chuẩn Commit/PR**:
  - Tiêu đề tuân theo Conventional Commits (`feat(...)`, `fix(...)`), **tối đa ≤ 72 ký tự**.
  - Nội dung mô tả (Body) **ngắn gọn ≤ 5 dòng**. Nếu cần mô tả chi tiết, ghi ra file riêng và đính kèm link.
- **Chỉ Push & Merge khi được yêu cầu**:
  - Mặc định **không tự ý push** lên remote repository. Chỉ push và tạo PR (`gh pr create`) khi người dùng yêu cầu rõ ràng.
  - Chỉ merge PR (`gh pr merge`) vào nhánh chính khi người dùng trực tiếp xác nhận "OK" hoặc "Duyệt".

---

## 2. An toàn Thực thi Terminal & Script (Terminal Safety)
- **Không viết inline script dài trong `-c`**: Bất kỳ script nào (Bash, Python, Node...) nếu dài quá ~5 dòng, **bắt buộc phải ghi ra file script tạm**, cấp quyền và thực thi file đó, sau đó xóa file tạm đi.
- **Không pipe build output qua bộ lọc chặn (blocking filter)**: Tránh dùng `| grep ...` trực tiếp trên luồng build/compile vì dễ gây treo tiến trình (hang/freeze/timeout) nếu output không khớp pattern.
- **Giới hạn độ dài dòng lệnh**: Mỗi câu lệnh CLI không vượt quá ~2000 ký tự để tránh lỗi buffer overflow và timeout.

---

## 3. Trung thực Dữ liệu & Phê duyệt Trước khi Code (Mandatory Approval)
- **Trung thực dữ liệu tuyệt đối (No Fake / Dummy Data)**: Tuyệt đối không tự ý bịa dữ liệu giả định, tên công ty giả, hoặc nhồi kết quả heuristic giả lập. Mọi dữ liệu hiển thị bắt buộc phải là dữ liệu thật 100% từ API chính thống hoặc nguồn đã kiểm chứng (trừ trường hợp kịch bản mock test được chỉ định rõ).
- **Bắt buộc chờ phê duyệt phương án trước khi sửa code**:
  1. AI phải giải thích nguyên nhân gốc rễ và trình bày phương án kỹ thuật rõ ràng.
  2. **CHỈ TIẾN HÀNH VIẾT CODE KHI NGƯỜI DÙNG XÁC NHẬN "OK" / DUYỆT TRỰC TIẾP** bằng lời nhắn trong chat.
  3. Tuyệt đối không tự động nhảy sang bước viết code / thực thi thay đổi khi người dùng chưa đồng ý.

---

## 4. Tiêu chuẩn Kỹ thuật Hiệu năng (Universal Performance Engineering)
*(Áp dụng cho mọi hệ thống: Frontend UI, Backend API, Mobile, Desktop, CLI)*
- **Cô lập State & Sự kiện tần số cao (State & Event Isolation)**:
  - Các sự kiện hoặc state biến động liên tục (hover chuột, con trỏ, vị trí scroll, sensors, keystrokes input...) **bắt buộc phải cô lập trong component/module con**. Tuyệt đối không đặt ở component cha vì sẽ kích hoạt re-render hoặc re-calculate toàn bộ cây view/component.
- **Cấm tính toán nặng trong Render Loop & Request Hot-Path**:
  - Không chạy sắp xếp (`sort`), lọc mảng lớn (`filter`), parse JSON nặng, hoặc các thuật toán tính toán phức tạp trực tiếp bên trong vòng lặp render giao diện hoặc hàm xử lý request chính.
  - Mọi phép tính nặng phải tính trước (pre-compute) và lưu cache bộ nhớ (in-memory cache / memoization). View/handler chỉ đóng vai trò đọc dữ liệu đã chuẩn bị.
- **Tối ưu cấp phát bộ nhớ & Giảm tải Garbage Collection (Allocation Optimization)**:
  - Tránh khởi tạo các đối tượng tốn kém tài nguyên (date formatters, regex parsers, database connections, crypto engines) lặp đi lặp lại trong vòng lặp kín hoặc từng item của danh sách. Bắt buộc tái sử dụng instance static/singleton hoặc object pool.
- **Ảo hóa & Phân trang dữ liệu lớn (Virtualization & Pagination)**:
  - Trên giao diện: Danh sách lớn bắt buộc phải dùng cơ chế ảo hóa (virtual list/lazy loading), chỉ render các phần tử thực sự nằm trong khung nhìn.
  - Dưới backend/DB: Luôn phân trang (pagination), stream hoặc chunking dữ liệu, tuyệt đối không tải hàng loạt triệu bản ghi vào RAM cùng lúc.
- **Gom cụm & Tiết chế luồng dữ liệu thời gian thực (Buffering & Throttling)**:
  - Dữ liệu từ luồng thời gian thực (WebSocket, Message Queue, Event Stream) không được bắn trực tiếp từng event đơn lẻ lên UI/Main Loop. Bắt buộc có cơ chế buffer gom batch và debounce/throttle (ví dụ: 0.5s – 1.0s) để giảm tải tần suất cập nhật.
- **Bất đồng bộ & Không chặn luồng chính (Non-blocking I/O)**:
  - Mọi thao tác I/O (đọc/ghi file, gọi network, truy vấn DB) tuyệt đối không chạy đồng bộ trên Main Thread / Event Loop chính.
  - Thao tác ghi đĩa/persistence lặp đi lặp lại phải được debounce và đẩy xuống background worker/thread.

---

## 5. Tư duy Triển khai Ngang (Horizontal Deployment Mindset)
Khi giải quyết bất kỳ lỗi hoặc phát triển tính năng nào, bắt buộc tự động rà soát đồng bộ theo 4 trục:
- **Trục Tính năng & Thành phần tương đồng (Feature Parity)**: Nếu sửa/thêm logic ở Module A, phải tự động quét toàn bộ codebase tìm các Module B, C có vai trò hoặc logic tương tự (ví dụ: danh sách chính ↔ danh sách phụ; chế độ xem bảng ↔ chi tiết modal; giỏ hàng ↔ thanh toán) để áp dụng đồng bộ.
- **Trục Đa Nền tảng / Đa Môi trường (Environment & Platform Parity)**: Đảm bảo tính năng hoạt động nhất quán trên mọi nền tảng được hỗ trợ (Desktop ↔ Mobile, Web Responsive, macOS ↔ iOS, Dark Mode ↔ Light Mode).
- **Trục Đầy đủ Trạng thái Dữ liệu (State Parity)**: Mọi thành phần hiển thị/xử lý dữ liệu phải đáp ứng trọn vẹn 4 trạng thái:
  1. `Loading`: Có skeleton/placeholder dự trù, không làm vỡ hoặc giật layout.
  2. `Empty`: Giao diện thông báo trạng thái trống thân thiện, có chỉ dẫn hành động.
  3. `Error`: Bắt lỗi lịch sự, có nút thử lại (Retry), không để crash ứng dụng.
  4. `Loaded`: Hiển thị dữ liệu chính xác.
- **Trục Ổn định Giao diện & Hợp đồng Dữ liệu (Contract & Layout Stability)**:
  - Trên UI: Giữ vững kích thước khung hình, triệt tiêu hiện tượng giật nhảy layout (Zero Layout Shift).
  - Trên Logic: Xử lý triệt để các trường hợp biên (`null/undefined`, chia cho 0 sinh ra `NaN/Inf`, lỗi tràn mảng `Index out of bounds`). Khi thiếu số liệu, hiển thị ký hiệu thay thế lịch sự (`-` hoặc `--`), tuyệt đối không làm crash hay hiển thị giá trị bất thường.

---

## 6. An toàn Concurrency & Kiểm thử Hồi quy (Concurrency & Test Guard)
- **Luồng UI vs Luồng Background**: Mọi cập nhật trạng thái hiển thị người dùng bắt buộc diễn ra trên Main/UI Thread. Mọi tính toán thuật toán nặng hoặc I/O bắt buộc đẩy sang Background Thread/Worker.
- **Kiểm thử hồi quy (Regression Testing Guard)**: Khi sửa đổi các hàm tính toán cốt lõi hoặc thuật toán quan trọng, bắt buộc phải chạy hoặc viết bổ sung Unit Test tương ứng để đảm bảo lỗi không bao giờ tái phát.

---

## 7. Nguyên Tắc 2 Môi Trường & Cổng Kiểm Soát Build Parity (Dev vs Prod Parity Gate)
- **Tách biệt tuyệt đối giữa Development và Production**:
  - Dữ liệu, cấu hình (Environment Variables / UserDefaults / DB / LocalStorage), bundle identifier/tên miền của bản Dev phải độc lập hoàn toàn với bản Production để tránh làm ô nhiễm hoặc mất dữ liệu người dùng thật khi debug.
- **Cổng Kiểm Soát Build Parity (Parity Gate)**:
  - Trước khi báo hoàn thành bất kỳ task nào, **bắt buộc phải build thành công 100% trên cả 2 môi trường (Development/Debug và Production/Release)** theo đúng command quy định tại Phần 2.
  - Tuyệt đối không được phép bàn giao khi chỉ một trong hai cấu hình biên dịch/build thành công.

---

# ==============================================================================
# PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (PROJECT-SPECIFIC RULES)
# (Điền thông tin và câu lệnh cụ thể cho từng dự án vào bên dưới)
# ==============================================================================

## 1. Thông Tin Công Nghệ (Tech Stack & Environment)
- **Nền tảng / Ngôn ngữ**: <!-- Ví dụ: TypeScript / Node 20+, Swift 5.9+, Go 1.22, Python 3.11 -->
- **Frameworks / Libraries chính**: <!-- Ví dụ: Next.js 14, SwiftUI, Gin, FastAPI -->
- **Cấu hình Package Manager**: <!-- Ví dụ: pnpm, SPM, go mod, poetry -->

---

## 2. Lệnh Kiểm Thử & Biên Dịch (Parity Gate Commands)
Trước khi bàn giao task hoặc commit, bắt buộc chạy thành công các lệnh sau:
```bash
# 1. Chạy Unit / Integration Tests
# npm test / cargo test / pytest / swift test

# 2. Build Development / Debug
# npm run build:dev / xcodebuild -configuration Debug ...

# 3. Build Production / Release
# npm run build / xcodebuild -configuration Release ...
```

---

## 3. Quy Ước Kiến Trúc & Thiết Kế Riêng
<!-- Ghi các lưu ý riêng của dự án, ví dụ: quy ước typography, database migrations, state management, design tokens... -->
