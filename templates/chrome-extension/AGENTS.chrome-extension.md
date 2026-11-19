# AGENTS & CODING RULES (QUY TẮC VẬN HÀNH & KỸ THUẬT CHO AI AGENT)

Tài liệu này là bộ quy tắc cốt lõi gồm 2 phần rõ rệt:
- **PHẦN 1: NGUYÊN TẮC KỸ THUẬT CHUNG (UNIVERSAL COMMON RULES)**: Bắt buộc tuân thủ trên mọi dự án phần mềm (Web, Mobile, Backend, Desktop, CLI... bất kể ngôn ngữ & framework). **Giữ nguyên 100% khi copy sang dự án mới hoặc đưa vào ChatGPT/Claude/Cursor/Antigravity/Copilot.**
- **PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (CHROME EXTENSION — MANIFEST V3 & CHROME WEB STORE)**: Chuẩn phát triển, đóng gói, triển khai GitHub Pages và phát hành lên Chrome Web Store.

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
- **Nhận diện Thị giác & Bảo vệ Môi trường (Visual Indicator & Update Isolation)**:
  - Bản Dev bắt buộc phải có dấu hiệu nhận diện trực quan rõ ràng (ví dụ: tiền tố/hậu tố tên `Dev`, badge `DEV`, icon khác màu hoặc banner cảnh báo) để người dùng/tester không bao giờ nhầm lẫn với bản Production.
  - Bản Dev **bắt buộc phải vô hiệu hóa tính năng Auto-Update** (dùng cờ biên dịch môi trường như `#if DEBUG` hoặc env `NODE_ENV === 'development'`). Tuyệt đối không để bản Dev tự động kiểm tra và tải bản cập nhật Production về ghi đè lên mã nguồn hoặc dữ liệu đang phát triển cục bộ.
- **Tiêu chuẩn Cập nhật Tự động Âm thầm (Silent Auto-Update Standard)**:
  - Ứng dụng Production phân phối người dùng cuối nên bật cơ chế kiểm tra định kỳ và **mặc định tải ngầm trong nền (Silent Background Download)** để không ngắt quãng luồng làm việc. Luôn cung cấp toggle trong phần Cài đặt để người dùng có thể chủ động bật/tắt.
- **Cổng Kiểm Soát Build Parity (Parity Gate)**:
  - Trước khi báo hoàn thành bất kỳ task nào, **bắt buộc phải build thành công 100% trên cả 2 môi trường (Development/Debug và Production/Release)** theo đúng command quy định tại Phần 2.
  - Tuyệt đối không được phép bàn giao khi chỉ một trong hai cấu hình biên dịch/build thành công.

---

## 8. Chuẩn Hóa Tự Động Phát Hành & Phân Phối (Release Automation & Distribution Guard)
- **Quy trình Phát hành Một Lệnh (Zero-Manual-Touch Release)**:
  - Toàn bộ các bước phát hành bản mới phải được tự động hóa hoàn toàn bằng script (ví dụ: `./release.sh <version> <build_number>`).
  - Script phải kiểm soát chặt chẽ theo luồng chuẩn: Kiểm tra môi trường (Preflight) ➔ Bump version ➔ Biên dịch bản tối ưu (Release) ➔ Kiểm thử khói (Smoke Test tự động mở app tối thiểu 3s để xác nhận không crash) ➔ Dọn dẹp dependencies ➔ Ký số bảo mật (Code-signing) ➔ Kiểm duyệt bảo mật (Notarization / Store verification) ➔ Ký số bản cập nhật (EdDSA / Checksum) ➔ Cập nhật kênh phân phối (Appcast / Feed XML) ➔ Commit, tag git và xuất bản Release (GitHub Releases / CDN).
- **Dọn dẹp Tài nguyên Phụ thuộc Trước khi Đóng gói (Dependency Clean Guard)**:
  - Trước khi ký số và đóng gói bản phát hành, phải tự động quét và loại bỏ toàn bộ các file rác, file `.zip`, script tạm hoặc helper nhị phân chưa được ký số từ các gói thư viện bên thứ ba (ví dụ: SPM helpers, unnotarized dependency bundles). Tránh tuyệt đối việc bị các hệ thống kiểm duyệt bảo mật (như Apple Notary Service hoặc Windows SmartScreen) từ chối vì file lạ nằm bên trong bundle.

---

# ==============================================================================
# PHẦN 2: QUY TẮC ĐẶC THÙ DỰ ÁN (CHROME EXTENSION — MANIFEST V3 & CHROME WEB STORE)
# Tech Stack: Chrome Extension Manifest V3, Vanilla JS / TypeScript, Web Crypto / Chrome APIs
# ==============================================================================

## 1. Chuẩn Manifest V3 & Nguyên Tắc Tối Giản Quyền
- **Bắt buộc Manifest V3 (`"manifest_version": 3`)**:
  - Khai báo đầy đủ `"name"`, `"version"`, `"author"`, `"homepage_url"` (trỏ về GitHub Pages), `"description"` (**tối đa ≤ 132 ký tự**, ưu tiên nêu bật giá trị & lợi ích cho người dùng thay vì thuật ngữ kỹ thuật khô cứng).
  - Khai báo đủ bộ icon `16`, `32`, `48`, `128` px trong cả `"icons"` và `"action.default_icon"`.
- **Tối giản Quyền (Least Privilege Permissions)**:
  - Chỉ xin các quyền thực sự cần thiết để phục vụ mục đích duy nhất (Single Purpose). Ví dụ: chỉ xin `["storage"]` nếu chỉ lưu settings cục bộ; không xin `clipboardWrite` nếu chỉ copy theo thao tác click trực tiếp của user trong popup; không xin `<all_urls>` hoặc `tabs` nếu không bắt buộc.
- **Zero Remote Code**:
  - Toàn bộ mã JS, CSS, font, icon phải đóng gói sẵn trong extension. Tuyệt đối không nạp JS/CSS từ CDN hoặc server bên ngoài.

---

## 2. Tiêu Chuẩn Giao Diện Popup & Thương Hiệu
- **Kích thước & Chống Tràn Popup**:
  - Popup Chrome có chiều cao tối đa `600px` trước khi xuất hiện thanh cuộn. Thiết kế gọn gàng (chiều rộng chuẩn `380px–420px`), hỗ trợ đồng bộ **Dark Mode & Light Mode** (không giật layout khi chuyển chế độ).
- **Nhận Diện Thương Hiệu & Thông Tin Tác Giả**:
  - Header hiển thị rõ ràng **Logo + Tên Extension** trên màn hình chính.
  - Tab **About** bắt buộc có: phiên bản (`vX.Y.Z`), tóm tắt tính năng & quyền riêng tư, thông tin **Tác giả (Author)** và **liên kết Website chính thức** (`target="_blank" rel="noopener noreferrer"`).

---

## 3. Cổng Kiểm Soát Chất Lượng & Kiểm Thử (Parity Gate)
Trước khi đóng gói phát hành lên Chrome Web Store, bắt buộc chạy pass 100%:
```bash
# 1. Chạy Unit / Integration Tests (nếu có)
npm test

# 2. Kiểm tra cú pháp JS & tính hợp lệ manifest.json
node --check *.js
node -e "JSON.parse(require('fs').readFileSync('manifest.json','utf8'));"

# 3. Kiểm tra độ dài description <= 132 ký tự
node -e "const m=JSON.parse(require('fs').readFileSync('manifest.json','utf8')); if(m.description.length>132) process.exit(1);"
```

---

## 4. Website Sản Phẩm & Privacy Policy trên GitHub Pages (`/docs`)
- **Cô lập thư mục `/docs`**:
  - Toàn bộ trang giới thiệu sản phẩm, Live Demo (nếu có), ảnh preview và mục **Privacy Policy (`#privacy`)** đặt trong thư mục `docs/` ở root repo (`docs/index.html`, `docs/styles.css`, `docs/logo.svg`, `docs/assets/`).
  - Mọi tài nguyên mà trang web tham chiếu **phải nằm bên trong `docs/`**, không dùng đường dẫn tương đối trỏ ra ngoài `docs/`.
- **Lưu ý triển khai GitHub Pages**:
  - Với tài khoản GitHub Free, repository **bắt buộc phải để chế độ `PUBLIC`** mới kích hoạt được GitHub Pages (`PRIVATE` sẽ trả về `HTTP 422`). Luôn hỏi xác nhận người dùng trước khi đổi visibility sang Public.
  - Bật GitHub Pages trỏ vào nhánh `main`, thư mục `/docs`:
    ```bash
    gh api -X POST repos/<user>/<repo>/pages -f "source[branch]=main" -f "source[path]=/docs"
    ```
  - Bắt buộc xác nhận build hoàn tất (`status: built`) và trang trả về `HTTP 200` trước khi gắn URL vào Store Listing / `manifest.json`:
    ```bash
    gh api repos/<user>/<repo>/pages/builds/latest --jq '{status: .status, error: .error}'
    curl -sI https://<user>.github.io/<repo>/
    ```
  - URL Privacy Policy chuẩn để khai báo trên Chrome Web Store: `https://<user>.github.io/<repo>/#privacy`.

---

## 5. Quy Chuẩn Bộ Ảnh Chrome Web Store (`store-assets/`)
- Toàn bộ tài nguyên nộp Store đặt trong `store-assets/` (và **bắt buộc thêm `store-assets/` + `*.zip` vào `.gitignore`** để không làm phình lịch sử Git).
- **Bảng kích thước & định dạng màu bắt buộc**:

| Tài sản (Graphic Assets) | Trạng thái | Kích thước | Định dạng & Kênh màu | Lưu ý kỹ thuật |
| :--- | :---: | :---: | :--- | :--- |
| **Store Icon** (`ショップ アイコン`) | **Bắt buộc (`*`)** | `128 × 128 px` | PNG **`RGBA`** (có alpha/trong suốt) | Icon căn giữa (~`96×96`–`112×112`), chừa viền trong suốt `8–16px`. |
| **Screenshots** (`スクリーンショット`) | **Bắt buộc ≥ 1** (tối đa 5) | `1280 × 800 px` *(hoặc `640 × 400`)* | JPEG hoặc 24-bit PNG **`RGB`** (**không alpha**) | Tỷ lệ `16:10`. Chụp tối thiểu Dark Mode & Light Mode / tính năng chính. |
| **Small Promo Tile** (`プロモーション タイル（小）`) | Khuyên dùng | `440 × 280 px` | JPEG hoặc 24-bit PNG **`RGB`** (**không alpha**) | Hiển thị trên trang tìm kiếm/gợi ý Store. |
| **Marquee Promo Tile** (`マーキー プロモーション タイル`) | Tùy chọn | `1400 × 560 px` | JPEG hoặc 24-bit PNG **`RGB`** (**không alpha**) | Dùng khi được Store feature nổi bật. |

- **Quy tắc chống lỗi khi render ảnh tự động (Headless Chrome / Pillow)**:
  - Khi render HTML/popup bằng Chrome Headless, bắt buộc tắt CSS transition (`*,*::before,*::after{transition:none!important;animation:none!important;}`) để ảnh không bị chụp giữa chừng lúc chuyển theme hoặc bật switch.
  - Trước khi bàn giao, bắt buộc kiểm tra lại kích thước và mode màu (`RGB` cho Screenshots & Promo Tiles, `RGBA` cho Store Icon `128×128`), đồng thời mở ảnh kiểm tra trực quan để đảm bảo không bị cắt chữ hay tràn khung.
  - Đồng bộ copy các ảnh `1280×800` và `440×280` vào `docs/assets/` và gắn vào `docs/index.html` (mục Preview + thẻ `og:image`/`twitter:image`) và `README.md`.

---

## 6. Quy Trình Đóng Gói `.zip`, Khai Báo Privacy & Đồng Bộ Git
1. **Đóng gói `.zip` sạch**:
   - Chỉ nén đúng mã nguồn chạy extension (`manifest.json`, HTML/CSS/JS, `icons/...`). Tuyệt đối loại bỏ `.git/`, `docs/`, `store-assets/`, `test/`, `node_modules/`, `.DS_Store`, `README.md`, `package*.json`.
   - Luôn chạy `unzip -t` (test toàn vẹn) và `unzip -l` (kiểm tra danh sách file) sau khi tạo `.zip`.
2. **Khai báo mục Privacy Practices trên Chrome Web Store Dashboard**:
   - **Single purpose (`単一用途の説明 *`)**: 1 câu mô tả duy nhất 1 mục đích của extension (≤ 1000 ký tự).
   - **Permission justification (`権限が必要な理由`)**: Giải trình cụ thể từng quyền trong `manifest.json` (ví dụ `storage`: chỉ lưu preferences và lịch sử cục bộ qua `chrome.storage.local`, không gửi dữ liệu ra ngoài).
   - **Remote code**: Chọn **`No, I am not using Remote code`** nếu đóng gói 100% cục bộ.
   - **Data usage**: Bỏ trống các mục thu thập dữ liệu nếu extension hoạt động offline hoàn toàn; tích đủ **3 cam kết (Data usage certification)**.
   - **Privacy Policy URL**: `https://<user>.github.io/<repo>/#privacy`.
3. **Đồng bộ sau khi Submit**:
   - Cập nhật `README.md` (tiếng Anh, có ảnh preview & link GitHub Pages) và `store-assets/STORE_SUBMISSION.md`.
   - Push mã nguồn & `docs/` lên `main`, gắn Git Tag `v<version>` khớp với `"version"` trong `manifest.json` (`git tag -a v1.0.0 -m "..." && git push origin v1.0.0`).
