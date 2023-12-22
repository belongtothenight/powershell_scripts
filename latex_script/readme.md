# Windows LaTeX Auto Compile Script

## Requirement

1. MikTeX: <https://miktex.org/> (v23.10.12)
2. Make: <https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows> (v4.4.1)
3. [optional] PowerShell7: <https://github.com/PowerShell/PowerShell/releases> (v7.4.0)
4. [optional] zathura: <https://askubuntu.com/questions/1197978/windows-ubuntu-and-zathura> (v0.4.9)

## File Description

1. [```auto-compile.ps1```](./auto-compile.ps1): Compilation script which recompiles PDF with MikTeX, feel free to adjust settings at the start of the script.
2. [```Makefile```](./Makefile): Making commands. Should not be edited.
3. [```readme.md```](./readme.md): This file.

## Usage

Prepare your working directory like this. Run ```./auto-compile.ps1```.

```
└── working_directory
    ├── Makefile
    ├── auto-compile.ps1
    ├── report.bib
    └── report.tex
```

## Notice

1. This script is only for Windows PowerShell
2. Running for a long time may cause memory leak
3. Require Makefile and latex compile environment
4. Loading PDF while compiling may cause error or segmentation fault
5. If this script stucks at some point, try to press ctrl+c and restart it
6. First run of this script won't number references correctly, but it will re-run automatically.
7. This script can be modify into bash for compiling in linux environment.

## Demo

1. Commit: [b2772dc07c5df5bc8585c2b61df7ef5f9ee96e9d](https://github.com/belongtothenight/powershell_scripts/tree/b2772dc07c5df5bc8585c2b61df7ef5f9ee96e9d/latex_script) -> <https://youtu.be/_9wYpF_tkdQ>

## Documentation about LaTeX

1. BibTeX: referencing -> <https://bibtex.eu/>
2. Overleaf: LaTeX syntax -> <https://www.overleaf.com/learn>
3. LaTeX mathematical symbols -> 
    1. <https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols> 
    2. <https://www.cmor-faculty.rice.edu/~heinken/latex/symbols.pdf> 
    3. <http://www.cs.put.poznan.pl/ksiek/latexmath.html>
4. Paper Referencing -> <https://research.com/research/how-to-cite-a-research-paper>
