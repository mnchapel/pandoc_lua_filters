---
header-includes:
  - |
    ```{=latex}
	  \usepackage{awesomebox}
		\setlength{\aweboxsignraise}{-50mm}

      \usepackage{tcolorbox, xstring}
	  \tcbuselibrary{skins}
      \newtcolorbox{simple_box}[1]{enhanced,
	  colback=red!5!white,colframe=red!75!black,fonttitle=\bfseries,title=#1
	  }

	  \definecolor{CornflowerBlue}{rgb}{0.39, 0.58, 0.93}
	  \definecolor{Tomato}{rgb}{1.0, 0.39, 0.28}
	  \definecolor{Crimson}{rgb}{0.86, 0.08, 0.24}
	  \newcommand\boxcolor{}

	  \newcommand\myboxcomplete[3]{%
		\IfStrEq{#1}{note}{\renewcommand\boxcolor{CornflowerBlue}}{
		\IfStrEq{#1}{important}{\renewcommand\boxcolor{Tomato}}{
		\IfStrEq{#1}{warning}{\renewcommand\boxcolor{Crimson}}{}}}
		\begin{tcolorbox}[enhanced,
					colback=white,
					colbacktitle=white,
					coltitle=\boxcolor,
					boxrule=0pt,
					frame hidden,
					borderline west={4pt}{0pt}{\boxcolor},
					sharp corners,
					title=\sffamily\bfseries\quad #2]
                  \sffamily #3
		\end{tcolorbox}}
    ```
---

# Doc

I am a doc to test lua filters with Pandoc.

## Admonitions

!!! warning
    This is a warning admonition.  
    This admonition is multilines.

    This is another line after a linebreak.

!!! note Title
    This is a note admonition with a title.

!!! important A Long Title
    This is an important admonition with a long title.

> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

## Sub-section

I am a subsection.
