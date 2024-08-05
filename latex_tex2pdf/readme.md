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

Notice, the sample tex file won't be able to compile since included image is not presented. You can comment out figures to do so.

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

## Man

```
SYNOPSIS
    Generate a script to auto-compile LaTeX project


SYNTAX
    E:\GitHub\powershell_scripts\latex_tex2pdf\auto-compile.ps1 [-t] <Int32> [-o] <String> [[-m] <String>] [<CommonParameters>]


DESCRIPTION
    This script will automatically compile the LaTeX project, display the compiling time and the script running time.


PARAMETERS
    -t <Int32>
        The time interval between each compile. Default is 5 seconds.

        Required?                    true
        Position?                    1
        Default value                5
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -o <String>
        The output file name. Default is "report".

        Required?                    true
        Position?                    2
        Default value                report
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -m <String>
        The makefile name. Default is "Makefile".

        Required?                    false
        Position?                    3
        Default value                Makefile
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

INPUTS
    None


OUTPUTS
    None


NOTES


        File Name    : auto-compile.ps1
        Author       : belongtothenight
        Prerequisite : make and latex compile environment
        Date         : 2024-03-05
        Notice       : This script is only for Windows PowerShell
        Notice       : Running for a long time may cause memory leak
        Notice       : Require Makefile and latex compile environment
        Notice       : Loading PDF while compiling may cause error or segmentation fault
        Notice       : If this script stucks at some point, try to press ctrl+c and restart it
        Notice       : First run of this script won't number references correctly, but it will re-run automatically.

    -------------------------- EXAMPLE 1 --------------------------

    PS > .\auto-compile.ps1 -t 10 -o "report" -m "Makefile"







RELATED LINKS
    https://github.com/belongtothenight/powershell_scripts/tree/main/latex_tex2pdf
    https://tex.stackexchange.com/questions/87319/how-to-run-tex-from-the-command-line-interface-in-linux
    https://stackoverflow.com/questions/49384301/make-clean-failed-in-windows
```
