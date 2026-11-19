%% =====================================================================
%%  vnuhcmjet.cls
%%  Lớp LaTeX dựng lại định dạng bài báo của
%%  VNUHCM Journal of Engineering and Technology
%%  (Tạp chí Khoa học và Công nghệ - ĐHQG-HCM, chuyên san Kỹ thuật & Công nghệ)
%%
%%  Mẫu tham chiếu: notes/09 - Tạp chí KHCN/Sample/Tu-4.1.pdf
%%  Toàn bộ kích thước dưới đây được đo trực tiếp từ file PDF đó
%%  (đơn vị pt, hệ toạ độ PDF gốc ở góc trên - trái).
%%
%%  CHỈ BIÊN DỊCH BẰNG pdfLaTeX:
%%    - vntex cấp bộ font VNR/VNBX/VNTI/VNSS cho tiếng Việt (T5).
%%    - Công thức dùng Computer Modern, giống hệt mẫu.
%%    - XeLaTeX/LuaLaTeX sẽ ra font khác và mất metric của mẫu.
%%    Dùng:  latexmk        (latexmkrc đã đặt pdfLaTeX + biber)
%%
%%  CÁC KHỐI CHÍNH
%%    1. Kiểm tra engine, option
%%    2. Gói & font
%%    3. Hình học trang (bìa / thân bài)
%%    4. Màu, cỡ chữ dùng chung
%%    5. Header / footer
%%    6. Metadata (do metadata.tex khai báo)
%%    7. Bìa tiếng Việt + bìa tiếng Anh
%%    8. Thân bài: tiêu đề mục, caption, bảng, tài liệu tham khảo
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vnuhcmjet}[2026/11/15 v1.0 VNUHCM Journal of Engineering and Technology]

%% =====================================================================
%% 1. KIỂM TRA ENGINE + OPTION
%% =====================================================================
\RequirePackage{iftex}
\ifXeTeX
  \ClassError{vnuhcmjet}
    {Phai bien dich bang pdfLaTeX}
    {Go: latexmk main.tex -- khong dung XeLaTeX/LuaLaTeX.}
\fi
\ifLuaTeX
  \ClassError{vnuhcmjet}
    {Phai bien dich bang pdfLaTeX}
    {Go: latexmk main.tex -- khong dung XeLaTeX/LuaLaTeX.}
\fi

%% englishcover   : in thêm bìa tiếng Anh ở cuối (mặc định BẬT, như mẫu)
%% noenglishcover : chỉ in bìa tiếng Việt
\newif\ifjst@englishcover
\jst@englishcovertrue
\DeclareOption{englishcover}{\jst@englishcovertrue}
\DeclareOption{noenglishcover}{\jst@englishcoverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% 10pt  : cỡ chữ thân bài đúng mẫu
%% twocolumn : thân bài 2 cột; bìa sẽ tạm chuyển về 1 cột
\LoadClass[10pt,twocolumn]{article}

%% =====================================================================
%% 2. GÓI & FONT
%% =====================================================================
%% vntex: font VNR (roman), VNBX (bold), VNTI (italic), VNSSBX (sans bold)
%% + bảng mã T5 + inputenc UTF-8 (option utf8 của vntex nạp inputenc).
%% fix-cm: mẫu dùng cỡ chữ 15 pt / 7 pt... không nằm trong bảng cỡ chuẩn của
%% Computer Modern; fix-cm cho phép mọi cỡ để không bị thay thế 14.4/8 pt.
\RequirePackage{fix-cm}
\RequirePackage[utf8]{vntex}
%% Ngôn ngữ: tiếng Việt là chính, tiếng Anh cho bìa cuối.
%% babel-vietnamese nạp t5enc.def và mẫu gãy từ tiếng Việt.
\RequirePackage[vietnamese,english]{babel}
%% Khi chuyển sang tiếng Anh, babel đặt lại font encoding về OT1 (Computer
%% Modern) -> chữ La-tinh trên bìa tiếng Anh sẽ khác font so với phần còn
%% lại. Ép về T5 để cả hai bìa dùng chung bộ font VNR/VNSS của tạp chí.
\addto\extrasenglish{\fontencoding{T5}\selectfont}
\RequirePackage{csquotes}         % biblatex + babel cần gói này

\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage[most]{tcolorbox}
\RequirePackage{tikz}            % vẽ hình minh hoạ trong Sections/03-Ket-qua.tex
\usetikzlibrary{positioning}
\RequirePackage[font=small,labelfont=bf,labelsep=colon,
                justification=justified,singlelinecheck=false]{caption}
\RequirePackage{booktabs}
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{ragged2e}

%% =====================================================================
%% 3. HÌNH HỌC TRANG
%%    Số đo lấy từ Tu-4.1.pdf (đơn vị bp = đơn vị trong MediaBox):
%%      - khổ 610.43 x 789.04 bp
%%      - thân bài: trái 147.3  phải 36.3  -> textwidth 426.8
%%      - 2 cột, khoảng cách cột 13.3
%%      - bìa: lề 36 cả hai bên; cột affiliation rộng 126 nằm trong
%%        lề trái, khung tóm tắt rộng 395.4 đặt cạnh nó
%%    Dùng bp (= 1/72 in) để MediaBox của file xuất ra trùng khít mẫu.
%% =====================================================================
%% Hình học bìa (mặc định khi bắt đầu tài liệu)
\geometry{
  paperwidth=610.43bp,
  paperheight=789.04bp,
  left=36bp,
  right=36bp,
  top=55.6bp,
  bottom=34bp,
  headheight=23.6bp,
  headsep=16.7bp,
  footskip=28.2bp,
  columnsep=13.3bp
}

%% Hình học thân bài 2 cột (gọi trong \jstbody)
\newcommand{\jstbodygeometry}{%
  \newgeometry{
    left=147.3bp,
    right=36.3bp,
    top=51.6bp,
    bottom=34bp,
    headheight=23.6bp,
    headsep=12.8bp,
    footskip=28.2bp,
    columnsep=13.3bp
  }%
  %% \newgeometry không cập nhật \headwidth của fancyhdr, nên sau mỗi lần
  %% đổi hình học phải đặt lại, nếu không đường kẻ header và số trang sẽ
  %% dài/nhích theo bề rộng vùng chữ của trang trước đó.
  \setlength{\headwidth}{\textwidth}%
}

%% Hình học bìa (gọi lại cho bìa tiếng Anh ở cuối)
\newcommand{\jstcovergeometry}{%
  \newgeometry{
    left=36bp,
    right=36bp,
    top=55.6bp,
    bottom=34bp,
    headheight=23.6bp,
    headsep=16.7bp,
    footskip=28.2bp,
    columnsep=13.3bp
  }%
  \setlength{\headwidth}{\textwidth}%
}

%% =====================================================================
%% 4. MÀU & CỠ CHỮ DÙNG CHUNG
%% =====================================================================
\definecolor{jstblue}{RGB}{232,238,249}   % nền box tóm tắt / box trích dẫn

\newcommand{\jst@titlefont}{\fontsize{15.2}{18.2}\selectfont\sffamily\bfseries}
\newcommand{\jst@titlefonten}{\fontsize{15.2}{14.8}\selectfont\sffamily\bfseries}
\newcommand{\jst@authorfont}{\fontsize{10}{12}\selectfont\sffamily\bfseries}
\newcommand{\jst@affilfont}{\fontsize{7}{8.7}\selectfont\itshape}
\newcommand{\jst@absheadfont}{\fontsize{10}{12}\selectfont\bfseries}
\newcommand{\jst@absfont}{\fontsize{9}{12}\selectfont}
\newcommand{\jst@absfonten}{\fontsize{10}{12.6}\selectfont}
\newcommand{\jst@kwfont}{\fontsize{10}{12}\selectfont}
\newcommand{\jst@citfont}{\fontsize{7}{8}\selectfont}
\newcommand{\jst@corrlabfont}{\fontsize{7}{8}\selectfont\bfseries}
\newcommand{\jst@corrnamefont}{\fontsize{8}{9.6}\selectfont\bfseries}
\newcommand{\jst@corrfont}{\fontsize{8}{9.6}\selectfont}
\newcommand{\jst@headerfont}{\fontencoding{T5}\fontsize{12}{14}\selectfont\bfseries\itshape}
\newcommand{\jst@typefont}{\fontencoding{T5}\fontsize{10}{12}\selectfont\bfseries\itshape}
\newcommand{\jst@pagefont}{\fontsize{10}{12}\selectfont\bfseries}
\newcommand{\jst@secfont}{\fontsize{12}{14}\selectfont\sffamily\bfseries}
\newcommand{\jst@subsecfont}{\fontsize{10}{12}\selectfont\sffamily\bfseries}

%% =====================================================================
%% 5. HEADER / FOOTER
%%    Mẫu có ba kiểu header khác nhau (đo từ Tu-4.1.pdf):
%%      - trang thân : tên tạp chí ở x ~ 33 bp (lệch trái text block
%%                     114 pt) + đường kẻ 1 pt rộng đúng textwidth,
%%                     đường kẻ ở y ~ 38.9 bp.
%%      - bìa tiếng Việt : tên tạp chí một dòng, dưới đó là loại bài
%%                     canh phải và gạch chân; KHÔNG có đường kẻ ngang.
%%      - bìa tiếng Anh : header như trang thân, thêm dòng loại bài
%%                     canh phải ngay dưới đường kẻ.
%%    Toàn bộ header được đặt ở 33.3 bp tính từ mép trái giấy.
%% =====================================================================
\newcommand{\jst@headoffset}{-2.7bp}   % bìa: chữ lệch trái so với text block
\newcommand{\jst@bodyheadoffset}{-114pt}
\newcommand{\jst@headraise}{6.6bp}     % nhấc chữ header lên khỏi đường kẻ

%% Bìa tiếng Việt: mẫu KHÔNG in số trang (trang 1 vẫn tính là trang 1).
\fancypagestyle{jstcovervi}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
}

\fancypagestyle{jstcoveren}{%
  \fancyhf{}%
  \fancyhead[L]{\raisebox{\jst@headraise}[0pt][0pt]{\rlap{\hspace*{\jst@headoffset}\jst@headerfont\jst@journal}}}%
  %% mẫu: bìa tiếng Anh KHÔNG có đường kẻ dưới header
  \renewcommand{\headrulewidth}{0pt}%
  %% mẫu: số trang bìa EN thấp hơn 5,1 bp so với thân bài
  \fancyfoot[R]{\raisebox{-\jst@cov@en@footdrop}{\jst@pagefont\thepage}}%
}

\fancypagestyle{jstbody}{%
  \fancyhf{}%
  %% \rlap: chữ tràn sang lề trái mà không làm rộng head box,
  %% nên đường kẻ bên dưới vẫn đúng bằng textwidth.
  \fancyhead[L]{\raisebox{\jst@headraise}[0pt][0pt]{\rlap{\hspace*{\jst@bodyheadoffset}\jst@headerfont\jst@journal}}}%
  \renewcommand{\headrulewidth}{1pt}%
  \fancyfoot[R]{\jst@pagefont\thepage}%
}

%% =====================================================================
%% 6. METADATA
%%    metadata.tex gọi các lệnh dưới đây. Mặc định để trống.
%% =====================================================================
\newcommand{\jstjournal}[1]{\gdef\jst@journal{#1}}
\jstjournal{VNUHCM Journal of Engineering and Technology}

\newcommand{\jst@typevi}{Bài nghiên cứu}
\newcommand{\jst@typeen}{Research Article}
\newcommand{\jstarticletypevi}[1]{\gdef\jst@typevi{#1}}
\newcommand{\jstarticletypeen}[1]{\gdef\jst@typeen{#1}}

\newcommand{\jst@titlevi}{}
\newcommand{\jst@titleen}{}
\newcommand{\jsttitlevi}[1]{\gdef\jst@titlevi{#1}}
\newcommand{\jsttitleen}[1]{\gdef\jst@titleen{#1}}

\newcommand{\jst@abstractvi}{}
\newcommand{\jst@abstracten}{}
\newcommand{\jstabstractvi}[1]{\gdef\jst@abstractvi{#1}}
\newcommand{\jstabstracten}[1]{\gdef\jst@abstracten{#1}}

\newcommand{\jst@keywordsvi}{}
\newcommand{\jst@keywordsen}{}
\newcommand{\jstkeywordsvi}[1]{\gdef\jst@keywordsvi{#1}}
\newcommand{\jstkeywordsen}[1]{\gdef\jst@keywordsen{#1}}

\newcommand{\jst@citationvi}{}
\newcommand{\jst@citationen}{}
\newcommand{\jstcitationvi}[1]{\gdef\jst@citationvi{#1}}
\newcommand{\jstcitationen}[1]{\gdef\jst@citationen{#1}}

%% --- Danh sách tác giả -------------------------------------------------
%% \jstauthorvi[1,2]{Hoàng Minh Anh Tú}
%% [1,2] là chỉ số affiliation, in thành superscript; bỏ trống nếu không có.
\newcommand{\jst@sup}[1]{%
  \if\relax\detokenize{#1}\relax\else\textsuperscript{#1}\fi}

\newcommand{\jst@authorsvi}{}
\newcommand{\jst@authorsen}{}
\newcommand{\jstauthorvi}[2][]{%
  \ifx\jst@authorsvi\@empty
    \gdef\jst@authorsvi{#2\jst@sup{#1}}%
  \else
    \g@addto@macro\jst@authorsvi{, #2\jst@sup{#1}}%
  \fi}
\newcommand{\jstauthoren}[2][]{%
  \ifx\jst@authorsen\@empty
    \gdef\jst@authorsen{#2\jst@sup{#1}}%
  \else
    \g@addto@macro\jst@authorsen{, #2\jst@sup{#1}}%
  \fi}

%% --- Affiliation -------------------------------------------------------
%% \jstaffiliationvi{1, 2}{Khoa ...\\ Email: ...}
%% Mỗi lệnh là một khối trong cột trái của bìa.
\newcommand{\jst@affilvi}{}
\newcommand{\jst@affilen}{}
\newcommand{\jst@affilentry}[2]{%
  \textsuperscript{#1}\,#2}
\newcommand{\jstaffiliationvi}[2]{%
  \ifx\jst@affilvi\@empty
    \gdef\jst@affilvi{\jst@affilentry{#1}{#2}}%
  \else
    \g@addto@macro\jst@affilvi{\par\vspace{5pt}\jst@affilentry{#1}{#2}}%
  \fi}
\newcommand{\jstaffiliationen}[2]{%
  \ifx\jst@affilen\@empty
    \gdef\jst@affilen{\jst@affilentry{#1}{#2}}%
  \else
    \g@addto@macro\jst@affilen{\par\vspace{5pt}\jst@affilentry{#1}{#2}}%
  \fi}

%% --- Tác giả liên hệ ---------------------------------------------------
\newcommand{\jst@corrnamevi}{}
\newcommand{\jst@corraddrvi}{}
\newcommand{\jst@corremailvi}{}
\newcommand{\jstcorrespondingvi}[3]{%
  \gdef\jst@corrnamevi{#1}\gdef\jst@corraddrvi{#2}\gdef\jst@corremailvi{#3}}
\newcommand{\jst@corrnameen}{}
\newcommand{\jst@corraddren}{}
\newcommand{\jst@corremaillen}{}
\newcommand{\jstcorrespondingen}[3]{%
  \gdef\jst@corrnameen{#1}\gdef\jst@corraddren{#2}\gdef\jst@corremaillen{#3}}

%% =====================================================================
%% 7. BÌA
%%    Bố cục dọc (đo từ mẫu, tính từ mép trên trang):
%%      header 20.7 | tiêu đề 92 | tác giả 134 | box tóm tắt 166.2
%%      box trích dẫn ~731
%%    Các khoảng \vspace bên dưới được tinh chỉnh để khớp đúng mẫu.
%% =====================================================================
\newlength{\jst@cov@headraise}    \setlength{\jst@cov@headraise}{-28.3bp}
\newlength{\jst@cov@headgap}      \setlength{\jst@cov@headgap}{12.4bp}
\newlength{\jst@cov@enheadraise}  \setlength{\jst@cov@enheadraise}{-22.9bp}
\newlength{\jst@cov@beforetitle}  \setlength{\jst@cov@beforetitle}{10.9bp}
\newlength{\jst@cov@beforeauthor} \setlength{\jst@cov@beforeauthor}{7.4bp}
\newlength{\jst@cov@beforeblock}  \setlength{\jst@cov@beforeblock}{12.8bp}
%% Bìa tiếng Anh trong mẫu có nhịp dọc riêng, nén hơn bìa tiếng Việt:
%%   header 20,2 | loại bài 47,5 | tiêu đề 68,0 (giãn dòng 14,8)
%%   tác giả 113,0 | khung tóm tắt 150,1 | đường kẻ đơn vị 158,8
%%   khung trích dẫn 730,8-750,6 | số trang 781,6
\newlength{\jst@cov@en@beforetitle} \setlength{\jst@cov@en@beforetitle}{9.7bp}
\newlength{\jst@cov@en@beforeauthor}\setlength{\jst@cov@en@beforeauthor}{16.0bp}
\newlength{\jst@cov@en@beforeblock} \setlength{\jst@cov@en@beforeblock}{16.2bp}
\newlength{\jst@cov@en@affildrop}   \setlength{\jst@cov@en@affildrop}{8.7bp}
\newlength{\jst@cov@en@citraise}    \setlength{\jst@cov@en@citraise}{4.0bp}
\newlength{\jst@cov@en@footdrop}    \setlength{\jst@cov@en@footdrop}{5.1bp}
\newlength{\jst@cov@affilwidth}   \setlength{\jst@cov@affilwidth}{126bp}
\newlength{\jst@cov@absboxwidth}  \setlength{\jst@cov@absboxwidth}{395.4bp}
\newlength{\jst@cov@blockgap}     \setlength{\jst@cov@blockgap}{16.7bp}
\newlength{\jst@cov@citwidth}     \setlength{\jst@cov@citwidth}{385.5bp}
\newlength{\jst@cov@citindent}    \setlength{\jst@cov@citindent}{142.6bp}

%% Khung tóm tắt: nền xanh nhạt, không viền, không bo góc
\newtcolorbox{jst@abstractbox}{%
  colback=jstblue, colframe=jstblue,
  boxrule=0pt, boxsep=0pt, arc=0pt, sharp corners,
  left=11.3pt, right=10.4pt, top=8.2pt, bottom=9.4pt,
  before skip=0pt, after skip=0pt,
  width=\linewidth,
  fontupper=\jst@absfontcurrent
}

%% Ba biến "hiện hành" để bìa VI và bìa EN dùng chung một bộ macro.
%% \jstcovervi / \jstcoveren đặt lại chúng trước khi in.
\newcommand{\jst@titlefontcurrent}{\jst@titlefont}
\newcommand{\jst@beforetitlecurrent}{\jst@cov@beforetitle}
\newcommand{\jst@beforeauthorcurrent}{\jst@cov@beforeauthor}
\newcommand{\jst@beforeblockcurrent}{\jst@cov@beforeblock}
\newcommand{\jst@affildropcurrent}{0pt}
\newcommand{\jst@citraisecurrent}{0pt}

%% Cỡ chữ tóm tắt hiện hành: VI 9 pt (mẫu tr. 1), EN 10 pt (mẫu tr. 7)
\newcommand{\jst@absfontcurrent}{\jst@absfont}

%% Nội dung trong khung tóm tắt (dùng chung cho VI/EN)
\newcommand{\jst@abstractcontent}[4]{%
  {\jst@absheadfont #1}\par\vspace{-2pt}%
  #2\par
  \vspace{8pt}%
  {\jst@kwfont\bfseries #3}\ {\jst@kwfont #4}%
}

%% Khối tác giả liên hệ (cột trái bìa)
\newcommand{\jst@correspondence}[4]{%
  \par\vspace{5.5pt}%
  \rule{\jst@cov@affilwidth}{0.4pt}\par\vspace{5pt}%
  {\jst@corrlabfont #1\par}%
  \vspace{3pt}%
  {\jst@corrnamefont #2\par}%
  \vspace{7pt}%
  {\jst@corrfont #3\par}%
  \vspace{9pt}%
  {\jst@corrfont Email: #4\par}%
}

%% ---------------------------------------------------------------------
%% Hai khối cạnh nhau (cột đơn vị + khung tóm tắt).
%% Dùng \vtop để căn ĐÚNG MÉP TRÊN của hai khối: minipage[t] căn theo
%% dòng cơ sở đầu tiên, mà dòng đó nằm sâu trong khung tcolorbox nên
%% hai khối sẽ lệch nhau (đã thử và sai).
%% ---------------------------------------------------------------------
\newcommand{\jst@abstractblock}[4]{%
  \begin{jst@abstractbox}%
    \jst@abstractcontent{#1}{#2}{#3}{#4}%
  \end{jst@abstractbox}}

\newsavebox{\jst@boxa}
\newsavebox{\jst@boxb}
\newcommand{\jst@coverblocks}[8]{%
  %% #1 = nhãn tác giả liên hệ, #2..#4 = tên/địa chỉ/email,
  %% #5..#8 = tiêu đề khung, nội dung tóm tắt, nhãn từ khóa, từ khóa
  %% \vspace{0pt}: chèn glue cao 0 ở đầu \vtop để \vtop neo đúng MÉP TRÊN
  %% của khối (mặc định \vtop neo theo dòng cơ sở đầu tiên, mà dòng đầu
  %% của khung tcolorbox lại nằm sâu bên trong khung).
  \setbox\jst@boxa=\vtop{\vspace{0pt}%
          \hsize=\jst@cov@affilwidth \linewidth=\jst@cov@affilwidth
          \parindent=0pt
      %% bìa EN: cột đơn vị bắt đầu thấp hơn khung tóm tắt 8,7 bp
      \vspace*{\jst@affildropcurrent}%
      \rule{\jst@cov@affilwidth}{0.4pt}\par\vspace{5pt}%
      {\jst@affilfont \jst@affilcurrent\par}%
      \jst@correspondence{#1}{#2}{#3}{#4}}%
  \setbox\jst@boxb=\vtop{\vspace{0pt}%
          \hsize=\jst@cov@absboxwidth \linewidth=\jst@cov@absboxwidth
          \parindent=0pt
      \jst@abstractblock{#5}{#6}{#7}{#8}}%
  \noindent\hbox{\usebox\jst@boxa\hspace*{\jst@cov@blockgap}\usebox\jst@boxb}\par}

%% Khung "Trích dẫn bài báo này" (ô xanh ở đáy bìa)
\newtcolorbox{jst@citebox}{%
  colback=jstblue, colframe=jstblue,
  boxrule=0pt, boxsep=0pt, arc=0pt, sharp corners,
  left=2.7pt, right=2.7pt, top=3.5pt, bottom=0.9pt,
  before skip=0pt, after skip=0pt,
  width=\jst@cov@citwidth,
  fontupper=\jst@citfont
}

\newcommand{\jst@citationbox}[2]{%
  \noindent\hspace*{\jst@cov@citindent}%
  %% \vtop (KHÔNG chèn \vspace{0pt}): khối có depth = 0 nên đáy khung nằm
  %% đúng đường đáy của vùng chữ, không thò xuống lề dưới.
  %% Phải đặt \hsize/\linewidth bằng bề rộng khung, nếu không tcolorbox sẽ
  %% kéo rộng cả dòng ra bằng \hsize và sinh cảnh báo Overfull.
  \vtop{\hsize=\jst@cov@citwidth \linewidth=\jst@cov@citwidth
    \begin{jst@citebox}%
      {\bfseries #1}\ #2%
    \end{jst@citebox}}%
  \par}

%% ---------------------------------------------------------------------
%% \jstcovervi : in bìa tiếng Việt (trang 1)
%% ---------------------------------------------------------------------
\newcommand{\jstcovervi}{%
  \onecolumn
  \selectlanguage{vietnamese}%
  \gdef\jst@currenttype{\jst@typevi}%
  \renewcommand{\jst@titlefontcurrent}{\jst@titlefont}%
  \renewcommand{\jst@absfontcurrent}{\jst@absfont}%
  \renewcommand{\jst@beforetitlecurrent}{\jst@cov@beforetitle}%
  \renewcommand{\jst@beforeauthorcurrent}{\jst@cov@beforeauthor}%
  \renewcommand{\jst@beforeblockcurrent}{\jst@cov@beforeblock}%
  \renewcommand{\jst@affildropcurrent}{0pt}%
  \renewcommand{\jst@citraisecurrent}{0pt}%
  \thispagestyle{jstcovervi}%
  \setlength{\parindent}{10pt}%
  \setlength{\parskip}{0pt}%
  %% --- Header của bìa: hai dòng, không có đường kẻ ngang ---
  \vspace*{\jst@cov@headraise}%
  \noindent\hbox to\textwidth{\hspace*{\jst@headoffset}\jst@headerfont\jst@journal\hfil}\par
  \vspace{\jst@cov@headgap}%
  \noindent\hbox to\textwidth{\hfil\jst@typefont\underline{\jst@currenttype}}\par
  %% --- Tiêu đề bài ---
  \vspace{\jst@beforetitlecurrent}%
  \noindent{\jst@titlefontcurrent \jst@titlevi\par}%
  \vspace{\jst@beforeauthorcurrent}%
  {\jst@authorfont \jst@authorsvi\par}%
  \vspace{\jst@beforeblockcurrent}%
  \def\jst@affilcurrent{\jst@affilvi}%
  \jst@coverblocks
    {Tác giả liên hệ}{\jst@corrnamevi}{\jst@corraddrvi}{\jst@corremailvi}%
    {TÓM TẮT}{\jst@abstractvi}{TỪ KHÓA:}{\jst@keywordsvi}%
  \vfill
  \jst@citationbox{Trích dẫn bài báo này:}{\jst@citationvi}%
}

%% ---------------------------------------------------------------------
%% \jstcoveren : in bìa tiếng Anh (trang cuối)
%% ---------------------------------------------------------------------
\newcommand{\jstcoveren}{%
  %% \newgeometry khôi phục @twocolumn về giá trị lúc \begin{document},
  %% nên phải gọi nó TRƯỚC \onecolumn.
  \jstcovergeometry%
  \onecolumn
  \selectlanguage{english}%
  \gdef\jst@currenttype{\jst@typeen}%
  \renewcommand{\jst@titlefontcurrent}{\jst@titlefonten}%
  \renewcommand{\jst@absfontcurrent}{\jst@absfonten}%
  \renewcommand{\jst@beforetitlecurrent}{\jst@cov@en@beforetitle}%
  \renewcommand{\jst@beforeauthorcurrent}{\jst@cov@en@beforeauthor}%
  \renewcommand{\jst@beforeblockcurrent}{\jst@cov@en@beforeblock}%
  \renewcommand{\jst@affildropcurrent}{\jst@cov@en@affildrop}%
  \renewcommand{\jst@citraisecurrent}{\jst@cov@en@citraise}%
  \thispagestyle{jstcoveren}%
  \setlength{\parindent}{10pt}%
  \setlength{\parskip}{0pt}%
  %% --- Dòng loại bài canh phải, nằm ngay dưới đường kẻ của header ---
  \vspace*{\jst@cov@enheadraise}%
  \noindent\hbox to\textwidth{\hfil\jst@typefont\underline{\jst@currenttype}}\par
  %% --- Tiêu đề bài ---
  \vspace{\jst@beforetitlecurrent}%
  \noindent{\jst@titlefontcurrent \jst@titleen\par}%
  \vspace{\jst@beforeauthorcurrent}%
  {\jst@authorfont \jst@authorsen\par}%
  \vspace{\jst@beforeblockcurrent}%
  \def\jst@affilcurrent{\jst@affilen}%
  \jst@coverblocks
    {Correspondence}{\jst@corrnameen}{\jst@corraddren}{\jst@corremaillen}%
    {ABSTRACT}{\jst@abstracten}{Key words:}{\jst@keywordsen}%
  \vfill
  \jst@citationbox{Cite this article:}{\jst@citationen}%
  %% kéo khung trích dẫn lên cho khớp mẫu (đáy 750,6 thay vì 754,6):
  %% thêm glue SAU khung thì \vfill co lại và khung nhích lên.
  \vspace*{\jst@citraisecurrent}%
}

%% ---------------------------------------------------------------------
%% \jstbody : chuyển sang thân bài 2 cột
%% ---------------------------------------------------------------------
\newcommand{\jstbody}{%
  \clearpage
  \jstbodygeometry
  \twocolumn
  \pagestyle{jstbody}%
  \thispagestyle{jstbody}%
  \setlength{\parskip}{2pt}%   % giãn cách đoạn như bản in của tạp chí
  \selectlanguage{vietnamese}%
}

%% ---------------------------------------------------------------------
%% \jstenglishcover : in bìa tiếng Anh nếu option englishcover đang bật.
%%                    main.tex gọi lệnh này ở cuối tài liệu.
%% ---------------------------------------------------------------------
\newcommand{\jstenglishcover}{%
  \ifjst@englishcover \jstcoveren \fi}

%% =====================================================================
%% 8. THÂN BÀI
%% =====================================================================
%% --- Khoảng cách đoạn ---
\setlength{\parindent}{10pt}
\setlength{\parskip}{0pt}
%% Cột hẹp + nhiều từ Latin dài: cho phép giãn thêm để bớt Underfull
\setlength{\emergencystretch}{1em}
\raggedbottom

%% --- Tiêu đề mục: không đánh số, IN HOA, sans bold 12 pt ---
\setcounter{secnumdepth}{0}
\titleformat{\section}
  {\jst@secfont}
  {}{0pt}{\MakeUppercase}
\titlespacing*{\section}{0pt}{4.5pt}{2pt}

\titleformat{\subsection}
  {\jst@subsecfont}
  {}{0pt}{}
\titlespacing*{\subsection}{0pt}{3.5pt}{1pt}

%% --- Caption ---
\renewcommand{\figurename}{Hình}
\renewcommand{\tablename}{Bảng}
\captionsetup[figure]{margin={9.4pt,9.4pt},skip=6pt}
\captionsetup[table]{skip=4pt,position=top}

%% --- Bảng kiểu booktabs như mẫu: 0.8 / 0.5 / 0.8 pt ---
\setlength{\heavyrulewidth}{0.8pt}
\setlength{\lightrulewidth}{0.5pt}
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}

%% --- Danh sách ---
%% Mẫu (mục "DANH MỤC TỪ VIẾT TẮT", tr. 5): nhãn chữ thường chạy cùng dòng,
%% phần giải thích nối ngay sau, các mục xếp liền nhau như đoạn văn.
\setlist{nosep,leftmargin=*}
\setlist[description]{style=sameline,leftmargin=0pt,labelindent=0pt,
                     labelwidth=0pt,labelsep=0.28em,itemindent=0pt,
                     parsep=0pt,itemsep=0pt,topsep=0pt,font=\normalfont}

%% =====================================================================
%% 9. TÀI LIỆU THAM KHẢO (biblatex + biber, Vancouver)
%%    - Trong bài: [1], nhiều nguồn: [3, 4]
%%    - Danh mục: "1. Tác giả. Tên bài. Tạp chí. Năm;Tập:trang. doi: ..."
%%    - Khớp định dạng mẫu Tu-4.1.pdf
%% =====================================================================
\RequirePackage[backend=biber,
                style=vancouver,
                sorting=none,
                giveninits=true,
                terseinits=true,
                maxbibnames=99,
                doi=true,
                url=true,
                isbn=false,
                language=english]{biblatex}

%% Số đo lấy từ mẫu: chữ 10 pt, giãn dòng 12,6 bp; số hiệu kết thúc ở
%% 12,7 bp tính từ lề cột (tức là bắt đầu ở ~4,7 bp với số có một chữ số),
%% dòng chữ thụt 22,7 bp, cách giữa hai tài liệu 2 bp.
\renewcommand*{\bibfont}{\fontsize{10}{12.6}\selectfont}
\setlength{\bibitemsep}{2bp}
\setlength{\bibhang}{22.7bp}
\setlength{\biblabelsep}{10bp}
%% Môi trường của numeric.bbx giãn lề theo bề rộng nhãn; ở đây đặt thẳng
%% lề trái = 22,7 bp để vị trí dòng chữ không phụ thuộc số hiệu ("9." / "10.")
\defbibenvironment{bibliography}
  {\list
     {\printtext[labelnumberwidth]{%
        \printfield{labelprefix}%
        \printfield{labelnumber}}}
     {\setlength{\labelwidth}{12.7bp}%
      \setlength{\labelsep}{\biblabelsep}%
      \setlength{\leftmargin}{\bibhang}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}%
   \renewcommand*{\makelabel}[1]{\hss##1}}
  {\endlist}
  {\item}
%% biblatex không có .lbx tiếng Việt: dùng chuỗi tiếng Anh cho khoá "và",
%% "và những người khác"... (tên tài liệu vẫn in đúng như trong refs.bib).
\DeclareLanguageMapping{vietnamese}{english}
\renewcommand*{\multicitedelim}{\addcomma\space}
%% Mẫu không dùng "and" trước tác giả cuối: "Karnik K, Sharma N, ..., Siegel JE."
\renewcommand*{\finalnamedelim}{\addcomma\space}

%% =====================================================================
%% 10. HYPERREF (nạp cuối)
%%     bookmarks=false: tránh lỗi dấu tiếng Việt trong bookmark PDF
%% =====================================================================
\RequirePackage[hidelinks,unicode,bookmarks=false]{hyperref}
%% Metadata PDF: bỏ các lệnh chỉ dùng để trình bày (\textsuperscript, $\beta$)
%% khi hyperref chuyển chuỗi sang PDF string, tránh cảnh báo "Token not
%% allowed in a PDF string".
\pdfstringdefDisableCommands{%
  \def\beta{β}%
  \def\textsuperscript#1{}%
  \def\uppercase#1{#1}%
  \def\MakeUppercase#1{#1}%
}
\AtBeginDocument{%
  \hypersetup{%
    pdftitle={\jst@titlevi},%
    pdfauthor={\jst@authorsvi},%
    pdfsubject={VNUHCM Journal of Engineering and Technology}%
  }%
}

\endinput
