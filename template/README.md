# Template bài báo — VNUHCM Journal of Engineering and Technology

Dựng lại bố cục bản in của *Tạp chí Khoa học và Công nghệ – ĐHQG-HCM, chuyên
san Kỹ thuật & Công nghệ* theo mẫu `../Sample/Tu-4.1.pdf`.

Mọi con số (khổ giấy, lề, vị trí tiêu đề, khoảng cách mục, cỡ chữ) đều được đo
trực tiếp trên file PDF mẫu rồi chuyển thành tham số trong `vnuhcmjet.cls`.

---

## 1. Biên dịch

```bash
cd template
latexmk            # pdfLaTeX + biber, chạy lại tới khi ổn định -> main.pdf
latexmk -C         # xoá toàn bộ file phụ
```

* Cần TeX Live 2024/2025 đầy đủ (có `vntex`, `babel-vietnamese`,
  `biblatex-vancouver`, `biber`).
* **Chỉ dùng pdfLaTeX.** Template dựa vào `vntex` + bảng mã `T5` để có đúng bộ
  font tiếng Việt của tạp chí (VNR / VNBX / VNTI / VNSSBX) và dùng Computer
  Modern cho công thức — giống hệt bản in. XeLaTeX/LuaLaTeX sẽ thay font và làm
  lệch toàn bộ metric, nên class sẽ báo lỗi và dừng.
* `latexmkrc` đã đặt `$pdf_mode = 1` (pdfLaTeX), `$bibtex_use = 2` (biber) và
  `@default_files = ('main.tex')` để không build lẫn các file trong `Sections/`.

Kết quả hiện tại: 4 trang, MediaBox `610.43 × 789.04 bp` = **216 × 279 mm**.

> Lưu ý: tạp chí hiện chỉ nhận bản thảo Word/RTF/PDF, không có template LaTeX
> chính thức. Template này chỉ để soạn cho đúng bố cục trước khi nộp.

---

## 2. Cấu trúc file

| File | Nội dung |
|------|----------|
| `main.tex` | Chỉ khai báo class, `\input{metadata}`, `\addbibresource`, rồi `\jstcovervi` → `\jstbody` → các `\input{Sections/…}` → `\jstenglishcover` |
| `vnuhcmjet.cls` | Toàn bộ định dạng: hình học trang, font, header/footer, bìa, tiêu đề mục, caption, bảng, tài liệu tham khảo |
| `metadata.tex` | Tiêu đề VI/EN, tác giả + chỉ số đơn vị, đơn vị, tác giả liên hệ, tóm tắt, từ khóa, khung trích dẫn |
| `Sections/01…10-*.tex` | Nội dung từng mục — sửa trực tiếp, thêm/bớt bằng cách thêm/bớt một dòng `\input` trong `main.tex` |
| `refs.bib` | Tài liệu tham khảo (biblatex + biber, style Vancouver) |
| `Figures/` | Ảnh chèn bằng `\includegraphics` (Hình 1 hiện vẽ bằng TikZ trong `03-Ket-qua.tex`) |

### Các lệnh chính của class

| Lệnh | Việc |
|------|------|
| `\documentclass[englishcover]{vnuhcmjet}` | Mặc định in thêm bìa tiếng Anh; dùng `noenglishcover` nếu chỉ cần bìa tiếng Việt |
| `\jstcovervi` | Trang 1: bìa tiếng Việt (1 cột) |
| `\jstbody` | Chuyển sang thân bài 2 cột, lề trái 52 mm |
| `\jstenglishcover` | Bìa tiếng Anh ở cuối (tự bỏ qua nếu tắt option) |
| `\jsttitlevi`, `\jsttitleen` | Tiêu đề |
| `\jstauthorvi[1,2]{Tên}`, `\jstauthoren[1,2]{Name}` | Tác giả; số trong `[]` thành superscript, `*` = tác giả liên hệ |
| `\jstaffiliationvi{1}{…}`, `\jstaffiliationen{1}{…}` | Đơn vị (cột trái bìa, dưới đường kẻ) |
| `\jstcorrespondingvi{Tên}{Địa chỉ}{Email}` | Khối tác giả liên hệ (cả 3 tham số đều là chữ, không in nhãn) |
| `\jstabstractvi{…}`, `\jstkeywordsvi{…}` | Tóm tắt và từ khóa (bản EN tương tự) |
| `\jstcitationvi{…}`, `\jstcitationen{…}` | Nội dung ô xanh "Trích dẫn bài báo này" ở đáy bìa |

Mục trong thân bài dùng `\section{…}` (không đánh số, tự in hoa) và
`\subsection{…}`. Trích dẫn: `\cite{karnik2021}` → `[1]`, nhiều nguồn →
`[3, 4]`.

---

## 3. Số đo đã dùng, và những chỗ cố ý khác mẫu

### 3.1. Trang giấy và lề

Đo trong hệ toạ độ PDF (đơn vị `bp`, gốc ở góc trên-trái):

| Tham số | Giá trị | Ghi chú |
|---------|---------|---------|
| Khổ giấy | `610.43 × 789.04 bp` | = 216 × 279 mm, đúng khổ MediaBox của mẫu |
| Lề trái (thân bài) | `147.3 bp` | = 52 mm |
| Lề phải | `36.3 bp` | bề rộng vùng chữ `426.8 bp` |
| Cột | 2 cột, `columnsep 13.3 bp` | cột 1 kết thúc ở x 354.0, cột 2 bắt đầu ở x 368.0 |
| `top` / `headsep` bìa | `55.6` / `16.7 bp` | |
| `top` / `headsep` thân bài | `51.6` / `12.8 bp` | chữ thân bài cao hơn bìa 4 bp, đường kẻ 1 pt vẫn ở y 38.9 |

`\titlespacing` bị LaTeX bỏ qua ở đầu trang, nên vị trí dòng đầu của trang 2–3
do `top` + `headsep` quyết định, không phải do `\titlespacing`.

### 3.2. Đối chiếu vị trí đo được (bp, tính từ mép trên)

| Phần tử | Mẫu | Template |
|---------|-----|----------|
| Header bìa | 40.7 | 40.7 |
| Loại bài ("Bài nghiên cứu") | 66.7 | 66.7 |
| Tiêu đề (dòng 1 / dòng 2) | 92.0 / 110.0 | 92.0 / 110.0 |
| Tác giả | 134.0 | 134.0 |
| Đường kẻ đơn vị | 166.3 | 166.0 |
| Khung tóm tắt (đỉnh) | 166.3 | 166.0 |
| "TÓM TẮT" | 178.7 | 178.7 |
| Dòng tóm tắt đầu | 189.3 | 189.3 |
| Khung tóm tắt (x) | 178.6 – 574.2 | 178.6 – 573.8 |
| Khung trích dẫn (x) | 178.6 – 564.1 | 178.6 – 563.8 |
| Khung trích dẫn (đáy) | 755.3 | 754.6 |
| Header thân bài | 20.7 (x 33.3) | 20.7 (x 34.0) |
| Đường kẻ header (y) | 38.9 | 38.9 |
| Đường kẻ header (x) | 147.6 – 574.2 | 147.2 – 573.8 |
| Số trang thân bài | 776.2 | 776.5 |
| Tiêu đề mục đầu trang | 56.7 | 56.7 |
| Dòng chữ đầu tiên | 76.0 | 76.0 |
| Trang tiếp theo, dòng đầu | 54.7 | 54.7 |
| Giãn dòng thân bài | 12.0 | 12.0 |
| Khoảng cách đoạn | 14.0 | 14.0 |
| Tài liệu tham khảo: số hiệu / dòng chữ (thụt) | +4.7 / +22.7 | +4.7 / +22.7 |
| Tài liệu tham khảo: cỡ chữ / giãn dòng | 10 pt / 12.6 | 10 pt / 12.6 |
| Bìa EN: header / loại bài | 20.2 / 47.5 | 20.2 / 47.2 |
| Bìa EN: tiêu đề (dòng 1 / dòng 2) | 68.0 / 82.8 | 68.0 / 82.8 |
| Bìa EN: tác giả | 113.0 | 113.0 |
| Bìa EN: đường kẻ đơn vị | 158.8 | 158.8 |
| Bìa EN: khung tóm tắt (đỉnh) | 150.1 | 149.8 |
| Bìa EN: khung trích dẫn (đáy) | 750.6 | 750.6 |
| Bìa EN: số trang | 781.6 | 781.6 |

Khoảng trắng thực quanh tiêu đề mục (đo bằng dải mực trên ảnh 200 dpi, so với
mẫu): phía trên trung vị **9.4 / 9.4**, phía dưới **8.3 / 8.6**; tiêu đề mục
con phía dưới **6.8 / 6.8**.

### 3.3. Những chỗ cố ý khác mẫu

1. **Trang bìa tiếng Việt không in số trang** (mẫu cũng vậy — trang 1 vẫn được
   tính là trang 1, nên thân bài bắt đầu từ số 2). Bìa tiếng Anh thì có in, và
   số trang nằm thấp hơn 5.1 bp so với thân bài, đúng như mẫu.
2. **Bảng rộng hơn cột một chút** (~1 pt, xem cảnh báo Overfull bên dưới).
   Bảng của chính mẫu cũng rộng hơn cột (219.3 bp so với 206.75 bp), nên đây là
   hành vi của tạp chí chứ không phải lỗi.
3. **`refs.bib`: `journal = {Vehicles.}` có dấu chấm cuối.** `biblatex-vancouver`
   chỉ thêm dấu chấm sau tên tạp chí khi dữ liệu đã có sẵn dấu chấm (sourcemap
   của gói bỏ dấu chấm rồi thêm lại). Mẫu cũng vậy: có mục in
   "Vehicles. 2021; 3:448–68." và có mục in "Applications 2023; 227:120254."
   không có dấu chấm. Giữ nguyên quy ước này để bản in khớp mẫu.
4. **Mục "Danh mục viết tắt"** in theo dạng `ABC (Tên đầy đủ): nghĩa`, nhãn chạy
   cùng dòng, không thụt lề, không giãn cách giữa các mục — đúng như mục
   "DANH MỤC TỪ VIẾT TẮT" ở tr. 5 của mẫu.
5. **Nội dung các mục là văn bản mẫu** (in nghiêng ở phần ghi chú) để bạn thay
   bằng nội dung thật.
6. **Khung trích dẫn ở bìa cao/thấp theo độ dài câu trích dẫn**, nên đỉnh khung
   có thể lệch vài bp so với mẫu; đáy khung luôn khớp (755.3 bp ở bìa VI,
   750.6 bp ở bìa EN).

---

## 4. Cảnh báo còn lại khi build (đều vô hại)

| Cảnh báo | Nguyên nhân |
|----------|-------------|
| `Overfull \hbox (0.97pt too wide)` | Bảng `Bảng 1` rộng hơn cột ~1 pt — giống mẫu (xem 3.3.2) |
| `Underfull \hbox` trong `06-Danh-muc-viet-tat.tex` | Cột hẹp 206.75 pt + từ Latin dài; bản in của mẫu cũng giãn chữ ở đúng những dòng này |
| `Underfull \hbox` ở cột đơn vị trên bìa | Cột đơn vị rộng 126 bp, chữ nghiêng 7 pt |
| `csquotes Warning: No space factor codes for 'T5'` | `csquotes` chưa biết bảng mã T5; chỉ ảnh hưởng dấu câu thông minh, không ảnh hưởng bố cục |
| `Package biblatex Info: …` | Thông tin bình thường của biber/biblatex |

Không còn cảnh báo thay thế font (`fix-cm` đã xử lý các cỡ 15 pt / 7 pt) và
không còn cảnh báo PDF string của hyperref (tiêu đề dùng `\texorpdfstring`).

---

## 5. Thêm nội dung

```latex
% main.tex
\input{Sections/11-Ket-qua-bo-sung}
```

```latex
% Sections/11-Ket-qua-bo-sung.tex
\section{Kết quả bổ sung}
Nội dung…
```

Hình và bảng:

```latex
\begin{figure}[!htbp]
  \centering
  \includegraphics[width=\linewidth]{Figures/ten-anh}
  \caption{Chú thích hình. [Nguồn: Nhóm tác giả]}
  \label{fig:ten}
\end{figure}

\begin{table}[!htbp]
  \caption{Chú thích bảng. [Nguồn: Nhóm tác giả]}
  \label{tab:ten}
  \raggedright
  {\fontsize{7}{9.3}\selectfont
  \begin{tabular}{@{}lccc@{}}
    \toprule
    …
    \bottomrule
  \end{tabular}}
\end{table}
```

Caption hình 9 pt, lề 9.4 pt hai bên; caption bảng 9 pt đặt **trên** bảng, chữ
trong bảng 7 pt, đường kẻ booktabs 0.8 / 0.5 pt — theo đúng mẫu.
