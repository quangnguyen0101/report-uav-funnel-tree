# Góp ý và kiểm tra lỗi: "Lập đường trên bề mặt dẫn đường thành phố ba chiều bằng Funnel Tree và kiểm chứng mô phỏng UAV"

**Tệp được kiểm tra:** `main.pdf` (30 trang, VNUHCM Journal of Engineering and Technology)
**Phương pháp:** đọc toàn văn, tự tính lại các số liệu có thể suy ra từ bảng và công thức trong bài.

---

## 1. Tóm tắt nội dung bài

Bài cài đặt thuật toán Funnel Tree (Python) và kiểm chứng trên 9 lưới đa diện nhỏ (7–49 đỉnh). Sau đó bài áp dụng vào mô hình TP.HCM 2025 (301 490 tam giác): dựng 3 bề mặt dẫn đường (ô 5/4/3 m), lập 3 tuyến từ một nguồn đến ba đích, rồi bay mô phỏng trong Gazebo Jetty 10.5 (khối điểm 1 kg, điều khiển bù trước + PD).

---

## 2. Số liệu đã tự kiểm tra và thấy đúng

- Số Euler χ = V − E + F và quan hệ cạnh–mặt của cả 9 mesh (Bảng 7).
- V, F, E của 3 bề mặt thành phố (Bảng 10) khớp với các lưới 50×44, 60×54 và 80×72 ô.
- Tổng số đỉnh đối chiếu: 7 + 10 + 12 + 16 + 31 = 76.
- Tỉ lệ thời gian lập tuyến: 186,175 / 44,984 ≈ 4,1 lần; 1008,389 / 186,175 ≈ 5,4 lần.
- Chênh lệch độ dài tuyến lưới 3 so với lưới 4: 2,4 / 3,6 / 2,4 đơn vị.
- Bảng 15 (phân rã sai số theo phương đứng) và các công thức Hermite/Catmull–Rom, profile vận tốc thang.

---

## 3. Lỗi rõ ràng

| # | Vị trí | Vấn đề | Gợi ý sửa |
|---|--------|--------|-----------|
| 1 | Trang 2, giải thích Hình 1 | Bài viết tuyến "gãy khúc tại đỉnh có góc khuyết âm, đúng hành vi của đường trắc địa trên bề mặt lồi". Trên đa diện lồi mọi đỉnh có góc khuyết dương và đường ngắn nhất không đi qua đỉnh; góc khuyết âm chỉ có ở bề mặt không lồi. | Viết lại: tuyến cắt qua cạnh/mặt, không đi qua đỉnh (trên bề mặt lồi). |
| 2 | Bảng 9, dòng v = 3 | Ba điểm (0,0,0) → (1,−0,5,1,5) → (2,−1,3) thẳng hàng, tổng độ dài đúng bằng √14 ≈ 3,7417. Đây là một đoạn thẳng, không phải "gãy góc qua đỉnh gờ". | Sửa cột "Đặc điểm hình học": đoạn thẳng đi qua đỉnh v = 4. |
| 3 | Hình 4(a) và Bảng 8 | Đỉnh nguồn của `cube`: Hình 4 ghi s = 4, Bảng 8 ghi s = 0. | Thống nhất một giá trị. |
| 4 | Mục "Dựng world và chạy Gazebo" | Mô hình có 301 490 tam giác nhưng collision ghi "giảm từ 301 482". Chênh 8 tam giác không được giải thích. | Giải thích (ví dụ loại tam giác thoái hóa) hoặc sửa số. |
| 5 | Phân tích G2 (trang 21) | Dùng 46/59/73 waypoint (trước rút gọn) cùng lúc với tỉ lệ tiếp tuyến 7,60/3,15/3,62 (Bảng 14, tính trên tuyến đã rút gọn 25/24/38). Hai tập số khác cơ sở. | Ghi rõ dùng số waypoint sau rút gọn khi nói về r_max. |
| 6 | Giải thích sai số bằng "tỉ lệ tiếp tuyến" | Lưới 5, G3 có r_max chỉ 1,65 nhưng e_max = 0,852, cao hơn lưới 4, G1 (r_max = 2,92, e_max = 0,399). Tỉ lệ tiếp tuyến chưa giải thích được sai số. | Giảm mức khẳng định, hoặc phân tích thêm nguyên nhân khác (độ cong, độ dốc cao độ). |
| 7 | Nhận xét tổng quan (Mục Kết quả) | "Các mesh còn lại có sai số nhỏ hơn một bậc": J17 (4,8×10⁻⁶) và star (6,7×10⁻⁶) chỉ nhỏ hơn cliff (1,7×10⁻⁵) khoảng 3 lần. | Sửa thành "nhỏ hơn" hoặc nêu đúng bậc cho từng mesh. |
| 8 | Chú thích Bảng 2 | Nhắc "cách (b) và (c)" nhưng bảng chỉ có (a) và (b). | Xóa hoặc bổ sung (c). |

---

## 4. Mâu thuẫn trong nội dung

1. **Đơn vị.** Mục dữ liệu thành phố nói khoảng cách là "đơn vị mô phỏng, chưa xác lập là mét", nhưng Tóm tắt, Kết luận, tên lưới ("5 m"), và vận tốc ("5 m/s", "3 m/s²") đều dùng mét.
2. **Thư viện.** Mục tiêu 1 và Mục "Các thuật toán sử dụng" nói chỉ dùng NumPy và thư viện chuẩn, không dùng thư viện hình học; Bảng 12 lại liệt kê Shapely 2.2.0.
3. **Phạm vi lồi.** Bài nói "giới hạn ở trường hợp polytope lồi", nhưng thực nghiệm chạy cả mesh không lồi, mesh mở, mặt xuyến và bề mặt thành phố (không lồi, chưa chứng minh tối ưu).
4. **Trải phẳng.** Bài nhấn mạnh Funnel Tree "bỏ hẳn bước trải phẳng", nhưng ở Mục "Các thuật toán sử dụng" thừa nhận polyline được tái dựng bằng cách trải phẳng dải mặt.
5. **Một nguồn – mọi đích.** Đây là lý do chọn Funnel Tree (Mục "Các thuật toán sử dụng"), nhưng phần thành phố chạy riêng từng goal (mode `per-goal`), nên không tận dụng ưu thế này.
6. **Đàn robot.** Mục tiêu tổng quát và Bảng 1 nói "đàn robot/nhiều kho – nhiều khách"; thực nghiệm chỉ có 1 UAV, 1 nguồn. Bản tiếng Anh thêm "single UAV" nhưng bản tiếng Việt không có.
7. **Tuyên bố ứng dụng chưa có bằng chứng.** "Ẩn mình dưới tầm quét radar", "tận dụng luồng gió nâng địa hình để tiết kiệm năng lượng" chưa được thực nghiệm nào hỗ trợ. Hơn nữa UAV bay trên envelope cách mái nhà 1,5 đơn vị, không phải "bám sát bề mặt công trình".
8. **Hướng phát triển.** Mục "Mô phỏng trên bản đồ chi tiết" được liệt kê như việc sẽ làm, dù bài đã làm (có ghi "đã triển khai bước đầu").
9. **A\* và Dijkstra.** Một chỗ gọi là A* với heuristic h(v) = ‖v − g‖; chỗ khác gọi là Dijkstra "dùng khoảng cách Euclid làm heuristic". Cần thống nhất tên và mô tả.
10. **Trích dẫn.** Văn bản trích "Phan, Hoai và Thinh", mục Tài liệu tham khảo ghi tác giả đầu là "An PT" (cùng một người, cần viết nhất quán).
11. **Dung sai.** Tóm tắt nói "trùng khớp tới bốn chữ số thập phân", trong khi tiêu chí thực tế là sai số tương đối ≤ 10⁻⁴. Hai điều này không đồng nghĩa.

---

## 5. Điểm yếu khoa học đáng lưu ý

### 5.1. Kiểm chứng thuật toán
- **Thủ tục 2 chưa có bằng chứng hoạt động.** Không có log sự kiện clip, mọi lần chạy chỉ ghi `clipping=true`. Chưa có thí nghiệm bật/tắt cắt tỉa để chứng minh cắt tỉa thực sự xảy ra và không làm sai kết quả. Chính JSON còn ghi `implementation_status: "experimental; validate per mesh"`.
- **Quy mô kiểm chứng nhỏ.** Chín mesh (7–49 đỉnh) chưa đủ cho các câu như "bao quát đầy đủ các dạng cấu trúc", "đáp ứng yêu cầu kiểm chứng tính đúng đắn và độ ổn định".
- **Kết quả "nhanh hơn 1–12 lần" và "10 401 nút so với 1 287 379"** là kết quả của bài gốc [1], không phải của bản Python này; cần ghi rõ để tránh hiểu nhầm.
- **Bề mặt thành phố không có bộ giải độc lập.** Bài đã thừa nhận; nên bổ sung ít nhất một đối chiếu (ví dụ Dijkstra trên đồ thị cạnh làm cận trên, hoặc một bộ giải MMP/Chen–Han) trên cùng bề mặt.

### 5.2. Bay mô phỏng
- **Mốc 1 m chưa được biện minh.** Sai số bám đạt 1,0–1,38 trong khi dự phòng ngang chỉ r = 0,6 (lưới 3) và khoảng hở đứng δ = 1,5. Collision lại được decimate bằng vertex clustering ô 1,0. Chưa có kiểm tra va chạm dọc spline (bài thừa nhận ở phần giới hạn).
- **Ca G2 lưới 3.** Theo Bảng 15, v_z,ref đổi từ −3,57 sang +2,08 trong khoảng 0,6 s (≈ 9 m/s²), vượt giới hạn profile (3) và cả ngưỡng chặn lệnh (6). Do đó kết luận "tăng gia tốc profile là đủ" chưa chắc đúng; có thể cần làm mượt cao độ đích hoặc giảm độ dốc λ.
- **Spline.** Catmull–Rom đồng nhất tham số gây vọt lố khi khoảng cách waypoint không đều (ca lưới 5, tỉ lệ 7,6). Có thể thử Catmull–Rom centripetal/chordal hoặc chia đều waypoint.
- **Phát biểu toán học chưa chính xác.** Câu "cách chọn tiếp tuyến theo (4) bảo đảm q(0) = pᵢ và q(1) = pᵢ₊₁" sai về logic: điều này do cơ sở Hermite (h₀₀, h₀₁) bảo đảm, không phụ thuộc cách chọn tiếp tuyến.
- **Lấy mẫu telemetry 0,1 s** có thể bỏ sót đỉnh sai số; nên lấy mẫu mịn hơn hoặc ghi cực đại ở bước vật lý 1 ms.
- **Thiết kế so sánh.** Ba lưới khác nhau cả r, λ và điểm snap; mỗi cấu hình chỉ chạy một lần, không có phân tán thống kê. Bài đã tự nhận, nhưng các kết luận kiểu "4 m là lựa chọn làm việc" vẫn nên được nêu đúng phạm vi.
- **Mô hình khối điểm** không có rotor/autopilot/nhiễu; bài đã nêu rõ hạn chế này (điểm tốt).

---

## 6. Lỗi soạn thảo và trình bày

- **Tham chiếu mục bị trống:** khoảng 8–10 chỗ dạng "ở Mục .", "trong Mục .", "tại Mục ." (lỗi `\ref` trong LaTeX).
- **Còn sót văn phong nội bộ/bản nháp:** "Con số 2,4 mm của bản cũ…", "phiên bản cũ ghi riêng…", "repo không kèm bộ test…", "không phải ảnh kết quả từ repo", "hiện báo 0 failure".
- **Lặp từ/câu:** "file tham chiếu tham chiếu", "đường tham chiếu trong đường tham chiếu"; hai đoạn mở đầu về Hình 12 gần như trùng ý.
- **Phụ lục A.3:** danh sách tệp đính kèm mất tên tệp (chỉ còn dấu "•").
- **Danh mục viết tắt:** có RMSE nhưng không dùng trong bài.
- **Bảng 14 và Bảng 15:** hầu như không được dẫn trực tiếp trong văn bản.
- **Bản tiếng Anh:** dùng dấu phẩy thập phân (142,909050; 0,399–0,601); trong tiếng Anh cần dấu chấm.
- **Tác giả:** chỉ ghi "và các tác giả khác" (đầu bài và phần Đóng góp); cần nêu đủ tên theo quy định tạp chí.
- **Ký hiệu:** Bảng 8 và Bảng 9 dùng "△102", "△124" không được giải thích trong cùng chỗ.

---

## 7. Đề xuất ưu tiên sửa

1. Sửa các lỗi rõ ràng ở mục 3 (đặc biệt #1, #2, #3).
2. Thống nhất đơn vị (mét hay đơn vị mô phỏng) trong toàn bài.
3. Bổ sung thí nghiệm bật/tắt Thủ tục 2 và (nếu có thể) một đối chiếu độc lập trên bề mặt thành phố.
4. Điều chỉnh các câu khẳng định quá mức (phạm vi lồi, "bao quát đầy đủ", ứng dụng radar/gió nâng, "đàn robot").
5. Sửa lỗi `\ref`, văn phong nháp, tên tệp phụ lục, và danh sách tác giả trước khi nộp.
