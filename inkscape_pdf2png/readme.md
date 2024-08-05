# Inkscape PDF to PNG

## Man

```
SYNOPSIS
    Use inkspace to convert PDF to PNG.


SYNTAX
    C:\PATH_Programs\inkscape_pdf2png.ps1 [[-indir] <String>] [[-outdir] <String>] [[-bo] <Int32>] [[-dpi] <Int32>] [[-pages] <String>] [<CommonParameters>]


DESCRIPTION
    Convert all PDF files in given path to PNG.

    Include:
        1. Man page
        2. Option value display
        3. Dependency check
        4. Error handling


PARAMETERS
    -indir <String>
        Input path containing PDF files.

        Required?                    false
        Position?                    1
        Default value                ($pwd).Path
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -outdir <String>
        Output path to hold converted PNG files.

        Required?                    false
        Position?                    2
        Default value                ($pwd).Path
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -bo <Int32>
        Option mapped to "--export-background-opacity" of inkspace

        Required?                    false
        Position?                    3
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -dpi <Int32>
        Option mapped to "--export-dpi" of inkspace

        Required?                    false
        Position?                    4
        Default value                300
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -pages <String>
        Option mapped to "--pages" of inkspace

        Required?                    false
        Position?                    5
        Default value                1
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


        File Name      : inkscape_pdf2png.ps1
        Author         : belongtothenight
        Prerequisite   : inkscape
        Date           : 2024-08-04
        Version        : 1.0

    -------------------------- EXAMPLE 1 --------------------------

    PS>.\inkscape_pdf2png.ps1 -indir . -outdir png
    PS> dir
    a.pdf
    png/a.png







RELATED LINKS
    https://github.com/belongtothenight/powershell_scripts/blob/main/inkscape_pdf2png
    https://gist.github.com/chasemc/8d349af458beca7645a7b1ca28493999
```
