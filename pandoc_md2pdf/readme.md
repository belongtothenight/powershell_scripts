# Pandoc Script

This script is used to convert markdown files to pdf using pandoc.

## Usage

Check the help message:
```powershell
man .\generate.ps1
```

Use:
```powershell
.\generate.ps1 -i w1.md -d pdf -t pdf -o w1
```

## Man

```
SYNOPSIS
    Generate a PDF file from a Markdown file using PanDoc.


SYNTAX
    E:\GitHub\powershell_scripts\pandoc_md2pdf\md_gen_pdf.ps1 [-i] <String> [-d] <String> [-t] <String> [-o] <String> [<CommonParameters>]


DESCRIPTION
    1. Check if PanDoc is installed
    2. Create the output directory if it does not exist
    3. Remove the output file if it exists
    4. Convert markdown table format to multiline_tables
    5. Convert the markdown file to the output type
    6. Remove the temporary file
    7. Open the file


PARAMETERS
    -i <String>
        Input file

        Required?                    true
        Position?                    1
        Default value                w1.md
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -d <String>
        Output directory

        Required?                    true
        Position?                    2
        Default value                pdf
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -t <String>
        Output type

        Required?                    true
        Position?                    3
        Default value                pdf
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -o <String>
        Output file name (without extension)

        Required?                    true
        Position?                    4
        Default value                w1
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


        File Name      : md_gen_pdf.ps1
        Author         : belongtothenight
        Prerequisite   : PanDoc
        Date           : 2024-02-28
        Version        : 1.0

    -------------------------- EXAMPLE 1 --------------------------

    PS>.\md_gen_pdf.ps1 -i w1.md -d pdf -t pdf -o w1
    PS> dir
    pdf/w1.md
    pdf/w1_mt.md.tmp (deleted)
    pdf/w1.pdf






    -------------------------- EXAMPLE 2 --------------------------

    PS>.\md_gen_pdf.ps1 -i server.md -d pdf -t pdf -o server
    pdf/server.md
    pdf/server_mt.md.tmp (deleted)
    pdf/server.pdf







RELATED LINKS
    https://github.com/belongtothenight/powershell_scripts/tree/main/pandoc_md2pdf
    https://stackoverflow.com/questions/18178084/pandoc-and-foreign-characters
    https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
    https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist
    https://stackoverflow.com/questions/5237723/how-do-i-get-help-messages-to-appear-for-my-powershell-script-parameters
    https://pandoc.org/MANUAL.html#tables
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4
    https://stackoverflow.com/questions/8693675/check-if-a-command-has-run-successfully
```
