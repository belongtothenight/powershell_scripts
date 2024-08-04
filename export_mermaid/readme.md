# Export Mermaid

```
SYNOPSIS
    Use Mermaid CLI to render mermaid graphs


SYNTAX
    C:\PATH_Programs\export_mermaid.ps1 [[-filename] <String>] [[-ext] <String>] [[-width] <Int32>] [[-height] <Int32>] [[-theme] <String>] [[-dir] <String>] [-trim] [-fontT] [<CommonParame
    ters>]


DESCRIPTION
    With input file input.md to generate figure as:

    1 ``````mermaid
    2 mermaid code......
      ......
    n ``````

    Include:
        1. Sample command if no argument is provided
        2. Man page
        3. Option value display
        4. Dependency check
        5. Error handling


PARAMETERS
    -filename <String>
        Input markdown file: <filename>.md

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -ext <String>
        Output format: svg, png, pdf

        Required?                    false
        Position?                    2
        Default value                pdf
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -width <Int32>
        Integer for output width

        Required?                    false
        Position?                    3
        Default value                1920
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -height <Int32>
        Integer for output height

        Required?                    false
        Position?                    4
        Default value                1080
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -theme <String>
        Themes for rendering: default, forest, dark, neutral

        Required?                    false
        Position?                    5
        Default value                default
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -dir <String>
        Output subdirectory name

        Required?                    false
        Position?                    6
        Default value                mermaid_out
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -trim [<SwitchParameter>]
        Trim white surrounding edges or not, if specify, trim
        This option is currently only for pdf format

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -fontT [<SwitchParameter>]
        Render text as font "Times New Roman" if specify

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
    None


OUTPUTS
    None


NOTES


        File Name      : export_mermaid.ps1
        Author         : belongtothenight
        Prerequisite   : mmdc (from Mermaid CLI), #acquire by npm install -g @mermaid-js/mermaid.cli
                         awk,
                         pdfcrop (from MiKTeX)
        Date           : 2024-08-04
        Version        : 1.0

    -------------------------- EXAMPLE 1 --------------------------

    PS>.\export_mermaid.ps1 -filename markdown_contains_mermaid.md -ext pdf -width 1920 -height 1080 -theme forest -dir pdf
    PS> dir
    markdown_contains_mermaid.md
    pdf/markdown_contains_mermaid.pdf
```
