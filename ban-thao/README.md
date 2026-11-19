# Bản thảo gửi Tạp chí KHCN ĐHQG-HCM

Bản thảo dựng theo mẫu `../template` (bố cục đo từ `../Sample/Tu-4.1.pdf`).

**Nội dung** = toàn bộ báo cáo giữa kỳ (`../../07 - Báo cáo giữa kỳ/`) + một mục
mới ở cuối: *Mô phỏng Gazebo trên bề mặt dẫn đường thành phố* (phần thực thi trong
`Drone.zip`).

---

## 1. Biên dịch

```bash
cd "09 - Tạp chí KHCN/ban-thao"
latexmk          # pdfLaTeX + biber  -> main.pdf
latexmk -C       # dọn file phụ
```

Chỉ dùng **pdfLaTeX** (vntex + bảng mã T5). Cần `biber`, gói `biblatex-vancouver`,
`siunitx`, `subcaption`, `listings`, `makecell`, `adjustbox`.

Kết quả hiện tại: **31 trang**, khổ `610,43 × 789,04 bp` (216 × 279 mm).

---

## 2. Cấu trúc

| File | Nội dung |
|------|----------|
| `main.tex` | khai báo class + gói bổ sung, `\input` metadata và các mục |
| `vnuhcmjet.cls` | định dạng tạp chí (bản sao từ `../template`) |
| `metadata.tex` | tiêu đề VI/EN, tác giả, đơn vị, tóm tắt, từ khóa, khung trích dẫn |
| `Sections/01-Gioi-thieu.tex` | bối cảnh, phát biểu bài toán, bảng mục tiêu, cấu trúc |
| `Sections/02-Co-so-ly-thuyet.tex` | bề mặt đa diện, funnel, thuật toán + 3 khối mã, bảng chỉ số |
| `Sections/03-Du-lieu-EDA.tex` | nguồn dữ liệu, Data Dictionary, chất lượng dữ liệu, EDA + 6 hình |
| `Sections/04-Ket-qua.tex` | kết quả 7 lưới, case study `cliff`, Thủ tục 2, sai số, thảo luận |
| `Sections/05-Mo-phong-Gazebo.tex` | pipeline 3 stage, `data`/`plan`/`simulate`, tham số, ba cấu hình lưới 5/4/3 m, Catmull--Rom, Jetty, archive, bám tuyến |
| `Sections/06…11` | kết luận, danh mục viết tắt, xung đột, đóng góp, cảm ơn, TLTK |
| `Figures/` | 19 hình, 39 ảnh thành phần (41 lượt chèn): mesh, route_viz, 3 bề mặt, cận cảnh, tracking và 6 ảnh Gazebo |
| `Code/` | 3 đoạn mã Python + 4 trích JSON + 2 script lệnh (`pipeline`, `docker`) |
| `refs.bib` | 5 tài liệu, Vancouver (biblatex + biber) |

Số lượng: **18 bảng**, **19 hình**, **8 khối mã** (3 Python + 3 JSON + 2 bash) (tự đánh số Bảng/Hình/Mã).

---

## 3. Thông tin cần thầy xác nhận trước khi gửi

1. **Tác giả**: hiện chỉ ghi `Phan Thành An`. Nếu bài có đồng tác giả, cần điền
   đầy đủ họ tên trong `metadata.tex`, mục 3 (tạp chí không nhận "và các tác giả khác").
2. **Tác giả liên hệ**: Phan Thành An, `thanhan@hcmut.edu.vn`, IMACS – HCMUT
   (lấy theo mẫu `Tu-4.1.pdf`).
3. **Thể loại**: `Bài nghiên cứu` / `Research Article`.
4. **Tài liệu tham khảo**: 5 mục, chưa có số tập/số phát hành của bài báo này
   (đang ghi `2026.` trong khung trích dẫn) — bổ sung khi có thông tin xuất bản.

---

## 4. Những điểm đã sửa so với báo cáo giữa kỳ

- Chỉnh lại số đỉnh/mặt của `J17` (10/16) và `L` (12/20) trong bảng kết quả:
  bảng đặc trưng mesh trong báo cáo ghi 10/16 và 12/20, còn bảng kết quả ghi
  17/30 và 18/32; đếm trực tiếp từ `src/my/input/*.geom` cho kết quả 10/16 và
  12/20 (khớp số Euler), nên bảng kết quả đã dùng giá trị đúng.
- Cập nhật cột *trạng thái* trong bảng mục tiêu: mục tiêu 3 (bề mặt mở) và 5
  (trực quan hóa) nay đã hoàn thành.
- Bỏ cách gọi "Chương N" (báo cáo môn học) → "Mục N" (bài báo), giữ nguyên toàn
  bộ nội dung kỹ thuật, bảng và hình của báo cáo.
- Ba khối mã của báo cáo được đặt trong float riêng (`Mã 1…3`) để không bị cắt
  qua cột/trang.

---

## 5. Điểm cần lưu ý về hình

Tất cả ảnh kết quả đều lấy từ repo: 9 ảnh mesh và 2 ảnh J17 từ
`generated/data_viz/`, ảnh icosahedron routes từ `generated/routes/`, ảnh thành
phố/bề mặt từ `generated/data_viz/`, ảnh routes và sai số G2 từ
`results/runs/cell4/` và `results/runs/cell3close/`. Hai ảnh sai số
(`cell4_g2_error.png`, `cell3_g2_error.png`) là bản cắt bỏ panh mặt bằng của
`tracking.png` gốc để vừa một trang; ảnh gốc vẫn nằm trong archive. Sơ đồ phễu ở
Mục 2 là TikZ, không phải ảnh kết quả.

Khi thu về khổ cột 206,75 pt (hoặc 426,8 pt cho hình rộng) thì nhãn trục còn
khoảng 4–5 pt. Muốn bản in đẹp hơn, kết xuất lại với `font.size` lớn hơn (khoảng
14–16 pt trong matplotlib) rồi thay file trong `Figures/` — không cần sửa LaTeX.

---

## 6. Cập nhật theo repo `uav-funnel-tree-gazebo` (19/11/2026)

Phần mô phỏng được viết lại và mở rộng theo trạng thái repo tại commit `d7a4157`:

- **Ba cấu hình lưới 5/4/3 m** thay cho khảo sát ô 5/7,5/15 cũ. Bảng 10 ghi kích thước lưới, đỉnh nguồn/đích đã snap và SHA bề mặt; Bảng 11
  ghi độ dài tuyến, số waypoint, số lần lan truyền và thời gian lập tuyến của cả
  ba cấu hình.
- **Sửa sai số bám tuyến**: bản cũ báo 0,002243–0,002451, thực chất là sai số
  tái dựng route ngoại tuyến. Telemetry động trong repo cho
  `max_error` 0,365–1,381 m; 4 m đạt mốc 1 m ở cả ba đích (0,399/0,591/0,601),
  5 m và 3 m mỗi lưới trượt G2 (1,022 m và 1,381 m). Bảng 14 và các Hình 16--17 ghi đúng đại lượng này.
- **Mô hình quỹ đạo mới**: spline Catmull–Rom + một profile vận tốc thang
  $v_{\max}=5$, $a_{\max}=3$, khởi đầu chậm 2 s, không dừng ở waypoint; thay
  cho quintic dừng–đi từng đoạn. Gazebo Harmonic được thay bằng **Gazebo Jetty
  10.5**, bước vật lý 1 ms.
- **Bỏ tuyên bố MMP cho bề mặt thành phố**: repo hiện không kèm bộ giải độc
  lập; `compare.py` chỉ đối chiếu 5 mesh nhỏ và xếp `city...` vào nhóm bỏ qua.
  Mục 5.3 nói rõ điều này thay vì so với `pygeodesic`.
- **Thêm phân biệt `valid` / `passed`** (hợp lệ: hết tuyến và dừng trong 0,5 m;
  đạt mốc: thêm `max_error ≤ 1 m`) và thảo luận giới hạn: ba cấu hình không
  phải ablation thuần ô, điểm đích bị snap lại 1–2 m, mỗi cấu hình chỉ chạy một
  lần, mô hình khối điểm không có rotor/autopilot.
- **Sửa lỗi số liệu cliff**: độ dài polyline tới đỉnh $v=6$ là 4,0632 (bản cũ
  ghi 3,8421); đồng thời hạ mức tuyên bố "trùng khớp tuyệt đối" thành khớp tới
  bốn chữ số với sai số tương đối lớn nhất $1,7\times10^{-5}$.

Các tệp JSON được trích nguyên văn (trừ `waypoints`) và đính kèm bản đầy đủ
cho `funnel_physics.sdf`, `city.sim.collision.stl`, `validation_g2_cell4.json`,
`routes_cell3.json`, `manifest_cell4.json` trong `Attachments/`. Tệp visual
`city.sim.glb` (8,2 MB) không nhúng để giữ dung lượng PDF.

Các hình cũ `altitude_g*.png`, `surface_sensitivity.png`, `three_routes.png`,
`gazebo_*.png`, `funnel_geometry_cusp_borders.png`,
`funnel_tree_figure4_icosahedron_sp.png` và bốn ảnh `J17_*.png` không còn được
dùng; giữ lại để đối chiếu lịch sử. Mục 5 hiện có thêm các mục con về pipeline, cách chạy từng stage, môi trường/image Gazebo, kết luận vận hành,
stage `data`, `plan`, `simulate`, tham số, `data_viz`, `route_viz`, `compare`,
`compare_runs`, archive và container.
