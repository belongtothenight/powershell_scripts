<#
.SYNOPSIS
    CLI tool to execute TeXworks typesettings.
.DESCRIPTION
    Options: (ts)
        1.  pdfTeX
        2.  pdfLaTeX
        3.  pdfLaTeX+MakeIndex+BibTeX
        4.  LuaTeX
        5.  LuaLaTeX
        6.  LuaLaTeX+MakeIndex+BibTeX
        7.  XeTeX
        8.  XeLaTeX
        9.  XeLaTeX+MakeIndex+BibTeX
        10. upTeX (ptex2pdf)
        11. upLaTeX (ptex2pdf)
        12. ConTeXt (LuaTeX)
        13. ConTeXt (pdfTeX)
        14. ConTeXt (XeTeX)
        15. BibTeX
        16. Biber
        17. MakeIndex
    Obtain syntax from TeXworks main window / Edit / Preferences... / Typesetting / Processing tools / XeLaTeX+MakeIndex+BibTeX / Edit...

    Include:
        1. Man page
        2. Option value display
        3. Dependency check
        4. Error handling
.PARAMETER fn
    Main file to process, mapped to "$fullname".
    Does not require the file to be located in the same path as this script.
.PARAMETER ts
    Typesetting option from 1 to 17.
.PARAMETER so
    Mapped to "$synctexoption".
    Sometimes additional flags are required to execute certain compilation.
.INPUTS
    None
.OUTPUTS
    None
.EXAMPLE
    PS> .\process_tex.ps1 -ts 9 -fn main.tex
    PS> dir
    main.tex
    main.pdf
.EXAMPLE
    PS> .\process_tex.ps1 -fn main.tex -so "--tex-option -shell-escape"
    PS> dir
    main.tex
    main.pdf
.LINK
    https://github.com/belongtothenight/powershell_scripts/blob/main/process_tex
.NOTES
    File Name      : process_tex.ps1
    Author         : belongtothenight
    Prerequisite   : MiKTeX
    Date           : 2024-08-04
    Version        : 1.0
#>

param (
    [Parameter(Mandatory=$true)][string]$fn,
    [Parameter(Mandatory=$false)][int]$ts = 9,
    [Parameter(Mandatory=$false)][string]$so
)

#>> check dependencies
function Check-Command {
    param(
        [string]$command
    )
    $command_check = '{0} --version' -f $command | Out-Null
    if ($? -eq $false) {
        Write-Host ">> $command is not installed."
        Write-Host ">> Please install $command."
        exit 1
    }
}
Check-Command "miktex-pdftex"
Check-Command "miktex-xetex"
Check-Command "miktex-luatex"
Check-Command "miktex-luahbtex"
Check-Command "miktex-bibtex"
Check-Command "miktex-makeindex"
Check-Command "texify"
Check-Command "ptex2pdf"
Check-Command "context"
Check-Command "texexec"
Check-Command "biber"

#>> display options
$ts_min = 1
$ts_max = 17
$msg = "fn:        " + $fn; Write-Host $msg
$msg = "ts:        " + $ts; Write-Host $msg
$msg = "so:        " + $so; Write-Host $msg
$bn_fn = [io.path]::GetFileNamewithoutExtension($fn)
$bn_base = [io.path]::GetDirectoryName($fn)
# mapped to basename
if ($bn_base -eq "") {
    $bn = $bn_fn
} else {
    $bn = $bn_base + "\" + $bn_fn
}
$msg = "bn:        " + $bn; Write-Host $msg

#>> execute each case
function Execute-Handle-Error {
    param(
        [string]$opt,
        [string]$cmd
    )
    $msg = "opt:       " + $opt; Write-Host $msg
    $msg = "Executing: " + $cmd; Write-Host $msg
    Invoke-Expression $cmd
    if ($? -eq $false) {
        $msg = "Can't execute: " + $cmd; Write-Host $msg
    }
}
Switch ($ts) {
    1 {
        Execute-Handle-Error -opt "pdfTeX" -cmd "miktex-pdftex $so $fn"
    }
    2 {
        Execute-Handle-Error -opt "pdfLaTeX" -cmd "miktex-pdftex $so -undump=pdflatex $fn"
    }
    3 {
        Execute-Handle-Error -opt "pdfLaTeX+MakeIndex+BibTeX" -cmd "texify --pdf --synctex=1 --clean $so $fn"
    }
    4 {
        Execute-Handle-Error -opt "LuaTeX" -cmd "miktex-luatex $so $fn"
    }
    5 {
        Execute-Handle-Error -opt "LuaLaTeX" -cmd "miktex-luahbtex $so --fmt=lualatex $fn"
    }
    6 {
        Execute-Handle-Error -opt "LuaLaTeX+MakeIndex+BibTeX" -cmd "texify --pdf --engine=luahbtex --synctex=1 --clean $so $fn"
    }
    7 {
        Execute-Handle-Error -opt "XeTeX" -cmd "miktex-xetex $so $fn"
    }
    8 {
        Execute-Handle-Error -opt "XeLaTeX" -cmd "miktex-xetex $so -undump=xelatex $fn"
    }
    9 {
        Execute-Handle-Error -opt "XeLaTeX+MakeIndex+BibTeX" -cmd "texify --pdf --engine=xetex --synctex=1 --clean $so $fn"
    }
    10 {
        Execute-Handle-Error -opt "upTeX (ptex2pdf)" -cmd "ptex2pdf -u -ot $so $fn"
    }
    11 {
        Execute-Handle-Error -opt "upLaTeX (ptex2pdf)" -cmd "ptex2pdf -l -u -ot $so $fn"
    }
    12 {
        Execute-Handle-Error -opt "ConTeXt (LuaTeX)" -cmd "context --synctex $so $fn"
    }
    13 {
        Execute-Handle-Error -opt "ConTeXt (pdfTeX)" -cmd "texexec --synctex $so $fn"
    }
    14 {
        Execute-Handle-Error -opt "ConTeXt (XeTeX)" -cmd "texexec --synctex --xtx $so $fn"
    }
    15 {
        Execute-Handle-Error -opt "BibTeX" -cmd "miktex-bibtex $so $bn"
    }
    16 {
        Execute-Handle-Error -opt "Biber" -cmd "biber $so $bn"
    }
    17 {
        Execute-Handle-Error -opt "MakeIndex" -cmd "miktex-makeindex $so $bn"
    }
    default {
        $msg = "Invalid ts: " + $ts; Write-Host $msg
        $msg = "Should be between " + $ts_min + " and " + $ts_max; Write-Host $msg
        exit 1
    }
}
