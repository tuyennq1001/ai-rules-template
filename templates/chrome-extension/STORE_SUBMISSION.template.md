# Chrome Web Store Submission Checklist (`<EXTENSION_NAME>`)

Copy-paste toàn bộ tài nguyên và nội dung dưới đây lên [Chrome Web Store Developer Dashboard](https://chrome.google.com/webstore/devconsole).

---

## 1. Tài nguyên trong `store-assets/`

| Tệp | Kích thước & Định dạng | Vị trí trên Chrome Store Dashboard |
| :--- | :--- | :--- |
| `<slug>-v<version>.zip` | Gói mã nguồn Manifest V3 sạch (đã chạy `./package.sh`) | **Package** → *Upload new package* |
| `store-icon-128x128.png` | `128 × 128 px` PNG **`RGBA`** (nền trong suốt) | **Store listing** → *Store icon* (`ショップ アイコン *`) |
| `screenshot-1-dark-1280x800.png` | `1280 × 800 px` 24-bit PNG **`RGB`** (không alpha) | **Store listing** → *Screenshots* (`スクリーンショット *`) |
| `screenshot-2-light-1280x800.png` | `1280 × 800 px` 24-bit PNG **`RGB`** (không alpha) | **Store listing** → *Screenshots* |
| `promo-small-440x280.png` | `440 × 280 px` 24-bit PNG **`RGB`** (không alpha) | **Store listing** → *Small promo tile* (`プロモーション タイル（小）`) |
| `promo-marquee-1400x560.png` | `1400 × 560 px` 24-bit PNG **`RGB`** (không alpha) | **Store listing** → *Marquee promo tile* (`マーキー プロモーション タイル`) |

---

## 2. Store Listing (`ストアの掲載情報`)

- **Title (từ `manifest.json`):** `<EXTENSION_NAME>`
- **Homepage URL:** `https://<GITHUB_USER>.github.io/<REPO_NAME>/`
- **Author:** `<AUTHOR_NAME>`
- **Summary (tối đa 132 ký tự):**
  ```text
  <SHORT_BENEFIT_DRIVEN_SUMMARY_UNDER_132_CHARS>
  ```
- **Description (Mô tả chi tiết):**
  ```text
  <ONE_PARAGRAPH_VALUE_PROPOSITION>

  KEY FEATURES
  • <Feature 1>
  • <Feature 2>
  • <Feature 3>

  100% PRIVATE & CLIENT-SIDE
  <Extension Name> makes zero network requests, sets zero tracking cookies, and collects zero analytics or telemetry.
  ```
- **Category:** `Tools` *(hoặc `Productivity`)*
- **Language:** `English`

---

## 3. Privacy Practices (`プライバシー`)

- **Single purpose description (`単一用途の説明 *` — ≤ 1,000 ký tự):**
  ```text
  <EXTENSION_NAME> serves a single purpose: <concise single purpose description>.
  ```

- **Permission justification (`権限が必要な理由` — giải trình từng quyền trong `manifest.json`):**
  ```text
  The "storage" permission (chrome.storage.local) is used solely to persist local user preferences on the user's own device. No data is ever transmitted externally.
  ```

- **Remote code:** Chọn **`No, I am not using Remote code`**

- **Data usage:**
  - Nếu extension 100% client-side/offline: **không tích** bất kỳ mục thu thập dữ liệu cá nhân nào.
  - Tích đủ **3 cam kết bảo mật (Data usage certification)**.

- **Privacy Policy URL (publish trên GitHub Pages `/docs`):**
  ```text
  https://<GITHUB_USER>.github.io/<REPO_NAME>/#privacy
  ```

---

## 4. Sau khi Submit

1. Kiểm tra mọi mục bên menu trái Dashboard đều hiện dấu tích xanh → **Save draft** → **Submit for review**.
2. Push toàn bộ code, `docs/` (GitHub Pages) và `README.md` lên `main`, sau đó gắn tag phát hành:
   ```bash
   git tag -a v<version> -m "Release v<version> (Chrome Web Store submission)"
   git push origin v<version>
   ```
