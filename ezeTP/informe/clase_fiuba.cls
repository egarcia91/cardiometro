%******************************************************
%* Santiago Roman (FIUBA #93947)
%******************************************************
% Paquetes y definiciones
% -----------------------------------------------------

\ProvidesClass{clase_fiuba}[07/06/2015 v1.0 Clase Informe Fiuba]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[twoside,a4paper,12pt]{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish,es-tabla]{babel}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        P A Q U E T E S                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[pdftex,
	unicode=true,
	breaklinks=true,
	colorlinks=true,
	linkcolor=black,
	citecolor=black,
	urlcolor=black]{hyperref}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{cite}
\RequirePackage{float}
\RequirePackage{anysize}
\RequirePackage[hang,margin=3ex,small,bf,labelsep=endash]{caption}
\RequirePackage{subcaption}
\RequirePackage{wrapfig}
\RequirePackage{amsmath,amssymb,amsthm,amsfonts}
\RequirePackage{fancyhdr}
\RequirePackage[T1]{fontenc}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{verbatim}
\RequirePackage{booktabs}
\RequirePackage{gensymb}
\RequirePackage[colorinlistoftodos]{todonotes}
\RequirePackage{textcomp}
\RequirePackage{framed}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{courier}
\RequirePackage{caption}
\RequirePackage{pgfplots}
\RequirePackage{tikz}
\RequirePackage{tikzscale}
\RequirePackage[locale=FR]{siunitx} % Paquete para usar unidades, pongo locale FR para que los decimales esten separados por una coma en vez de un punto
%\RequirePackage[usenames,dvipsnames]{color}
\RequirePackage[european,cuteinductors,smartlabels,americanresistor,americanvoltages]{circuitikz}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   D E F I N I C I O N E S                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\pgfplotsset{compat=1.7} % Para evitar warning de pgfplot

\newcommand{\grad}{$^\circ$}

%\newcommand{\teammember}[2]{
%\noindent{\Large #1 \hfill \large #2}
%}

% \newcommand{\teammember}[2]{
% \begin{minipage}{0.5\textwidth}
% 	\begin{flushleft} \large
% 		#1
% 	\end{flushleft}
% \end{minipage}~
% \begin{minipage}{0.4\textwidth}
% 	\begin{flushright} \large
% 		#2
% 	\end{flushright}
% \end{minipage}\\
% }

\newcommand{\teammember}[3]{
\begin{minipage}{0.7\textwidth}
	\begin{flushleft} \large
		#1 \small <#3>
	\end{flushleft}
\end{minipage}~
\begin{minipage}{0.2\textwidth}
	\begin{flushright} \large
		#2
	\end{flushright}
\end{minipage}\\
}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}

% Cambio el nombre de los listing a listado", sino aparecería "listing"
\renewcommand{\lstlistingname}{Listado}

% Estilo de los listing
% Cambio el nombre de los listing a listado", sino aparecería "listing"
\renewcommand{\lstlistingname}{Listado}

% Estilo de los listing
 \lstset{
         basicstyle=\footnotesize\ttfamily,
         keywordstyle=\bfseries\color{green!40!black},
         commentstyle=\itshape\color{purple!40!black},
         identifierstyle=\color{blue},
         stringstyle=\color{orange},
         numbers=left,
         numberstyle=\tiny,
         %stepnumber=2,
         numbersep=5pt,
         tabsize=2,         
         extendedchars=true,
         breaklines=true,
         frame=b,
         showspaces=false,      
         showtabs=false,           
         xleftmargin=17pt,
         framexleftmargin=17pt,
         framexrightmargin=5pt,
         framexbottommargin=4pt,
         %backgroundcolor=\color{lightgray},
         showstringspaces=false,
         language=Matlab
 }
 \definecolor{mygreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mymauve}{rgb}{0.58,0,0.82}

\lstset{ %
  backgroundcolor=\color{white},   % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
  basicstyle=\footnotesize,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=t,                    % sets the caption-position to bottom
  commentstyle=\color{mygreen},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=single,	                   % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
  keywordstyle=\color{blue},       % keyword style
  language=Octave,                 % the language of the code
  otherkeywords={*,...},           % if you want to add more keywords to the set
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{mygray}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=2,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{mymauve},     % string literal style
  tabsize=2,	                   % sets default tabsize to 2 spaces
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}
%  \lstset{ basicstyle=\footnotesize\ttfamily,
%          keywordstyle=\bfseries\color{blue},
%          identifierstyle=\color{black},
%          stringstyle=\color{orange},
%          commentstyle=\itshape\color{green},
%          language=Octave,
% 		 }


\DeclareCaptionFont{white}{\color{white}}
\DeclareCaptionFormat{listing}{\colorbox[cmyk]{0.43, 0.35, 0.35,0.01}{\parbox{\textwidth}{\hspace{15pt}#1#2#3}}}
\captionsetup[lstlisting]{format=listing,labelfont=white,textfont=white, singlelinecheck=false, margin=0pt, font={bf,footnotesize}}

\definecolor{ggreen}{HTML}{9BBB59}
\definecolor{rred}{HTML}{C0504D}

% Cosas Circuitikz
\usetikzlibrary{calc}
\usetikzlibrary{patterns}
\ctikzset{bipoles/thickness=1}
\ctikzset{bipoles/length=0.8cm}
\ctikzset{bipoles/diode/height=.375}
\ctikzset{bipoles/diode/width=.3}
\ctikzset{tripoles/thyristor/height=.8}
\ctikzset{tripoles/thyristor/width=1}
\ctikzset{bipoles/vsourceam/height/.initial=.7}
\ctikzset{bipoles/vsourceam/width/.initial=.7}
\tikzstyle{every node}=[font=\small]
\tikzset{
	rarrow/.style={->, >=latex', shorten >=1pt,color=blue},
	varrow/.style={->, >=latex', shorten >=1pt,color=red},
}

\makeatletter
\ctikzset{lx/.code args={#1 and #2}{ 
  \pgfkeys{/tikz/circuitikz/bipole/label/name=\parbox{0.7cm}{ \centering #1  \\ #2}}
    \ctikzsetvalof{bipole/label/unit}{}
    \ifpgf@circ@siunitx 
        \pgf@circ@handleSI{#2}
        \ifpgf@circ@siunitx@res 
            \edef\pgf@temp{\pgf@circ@handleSI@val}
            \pgfkeyslet{/tikz/circuitikz/bipole/label/name}{\pgf@temp}
            \edef\pgf@temp{\pgf@circ@handleSI@unit}
            \pgfkeyslet{/tikz/circuitikz/bipole/label/unit}{\pgf@temp}
        \else
        \fi
    \else
    \fi
}}
\ctikzset{lx^/.style args={#1 and #2}{ 
    lx=#2 and #1,
    \circuitikzbasekey/bipole/label/position=90 } 
}
\ctikzset{lx_/.style args={#1 and #2}{ 
    lx=#1 and #2,
    \circuitikzbasekey/bipole/label/position=-90 } 
}
\makeatother
