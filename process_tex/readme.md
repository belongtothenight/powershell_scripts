# Process TeX

```
SYNOPSIS
    CLI tool to execute TeXworks typesettings.


SYNTAX
    C:\PATH_Programs\process_tex.ps1 [-fn] <String> [[-ts] <Int32>] [[-so] <String>] [<CommonParameters>]


DESCRIPTION
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


PARAMETERS
    -fn <String>
        Main file to process, mapped to "$fullname"
        Does not require the file to be located in the same path as this script.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ts <Int32>
        Typesetting option from 1 to 17

        Required?                    false
        Position?                    2
        Default value                9
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -so <String>
        Mapped to "$synctexoption"

        Required?                    false
        Position?                    3
        Default value
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


        File Name      : process_tex.ps1
        Author         : belongtothenight
        Prerequisite   : MiKTeX
        Date           : 2024-08-04
        Version        : 1.0

    -------------------------- EXAMPLE 1 --------------------------

    PS>.\inkscape_pdf2png.ps1 -ts 9 -fn main.tex
    PS> dir
    main.tex
    main.pdf







RELATED LINKS
    https://github.com/belongtothenight/powershell_scripts/blob/main/process_tex
```
