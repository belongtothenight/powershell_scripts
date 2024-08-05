# Markdown to PDF

This script is used to convert markdown files to PDF with following features:

1. Support for complex markdown tables.
2. Support BibTex references.
3. Special characters like `"`, `'` do not break the conversion process.

## Dependencies

1. PanDoc
2. LaTex (pdflatex, bibtex)
3. GNU Awk

## Usage

1. Check for help message:
    ```pwsh
    man md_gen_pdf2.ps1
    ```
2. Convert:
    ```pwsh
    md_gen_pdf2.ps1 reference.md
    ```
Note: Reference file should be in the same directory and named the same as the markdown file.

## Man

```
SYNOPSIS
    Generate PDF from Markdown speccialized for reference support.


SYNTAX
    E:\GitHub\powershell_scripts\md2pdf\md_gen_pdf2.ps1 [-MdFile] <String> [[-BibFile] <String>] [[-OutputDir] <String>] [[-TempPath] <String>] [-NoRemoveTemp] [-NoBib] [<CommonParameters>]


DESCRIPTION
    1. Create a temporary directory.
    2. Copy the input Markdown file and the BibTeX file to the temporary directory.
    3. Generate an intermediate Markdown file for better table handling.
    4. Generate an intermediate LaTeX file.
    5. Modify the LaTeX file for references.
    6. Generate PDF with references.
    7. Copy the PDF to the output directory.
    8. Remove the temporary directory.


PARAMETERS
    -MdFile <String>
        The input Markdown file.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -BibFile <String>
        The input BibTeX file. Default is "{ProjName}.bib".

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -OutputDir <String>
        The output directory. Default is "pdf".

        Required?                    false
        Position?                    3
        Default value                pdf
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -TempPath <String>
        The temporary directory. Default is "tmp".

        Required?                    false
        Position?                    4
        Default value                tmp
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -NoRemoveTemp [<SwitchParameter>]
        Whether to remove the temporary directory. Default is false

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -NoBib [<SwitchParameter>]
        Whether to use BibTeX. Default is false.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

INPUTS

OUTPUTS

NOTES


        File Name       : md_gen_pdf2.ps1
        Author          : belongtothenight
        Prerequisite    : PanDoc, Gawk, pdflatex, bibtex
        Date            : 2024-04-01
        Version         : 1.0

    -------------------------- EXAMPLE 1 --------------------------

    PS > .\md_gen_pdf2.ps1 -MdFile "test.md"

    Generate PDF from "test.md" with default settings and a BibTeX file "test.bib" exists.
    Flag "-MdFile" is optional when the first argument is the input file.




    -------------------------- EXAMPLE 2 --------------------------

    PS > .\md_gen_pdf2.ps1 test.md -BibFile reference.bib

    Generate PDF from "test.md" with a BibTeX file "reference.bib".




    -------------------------- EXAMPLE 3 --------------------------

    PS > .\md_gen_pdf2.ps1 -MdFile "test.md" -OutputDir "pdf"

    Generate PDF from "test.md" with the output directory set to "pdf".




    -------------------------- EXAMPLE 4 --------------------------

    PS > .\md_gen_pdf2.ps1 -MdFile "test.md" -TempPath "tmp"

    Generate PDF from "test.md" with the temporary directory set to "tmp".




    -------------------------- EXAMPLE 5 --------------------------

    PS > .\md_gen_pdf2.ps1 -MdFile "test.md" -NoRemoveTemp

    Generate PDF from "test.md" and keep the temporary directory and intermediate files.




    -------------------------- EXAMPLE 6 --------------------------

    PS > .\md_gen_pdf2.ps1 -MdFile "test.md" -OutputDir "pdf" -NoBib # If there is no BibTeX file.

    Generate PDF from "test.md" without using BibTeX (if there is no BibTeX file) to skip file existence check.





RELATED LINKS
    https://github.com/belongtothenight/powershell_scripts/tree/main/md2pdf
```
