<#
.SYNOPSIS
    Use Mermaid CLI to render mermaid graphs
.DESCRIPTION
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
.PARAMETER filename
    Input markdown file: <filename>.md
.PARAMETER ext
    Output format: svg, png, pdf
.PARAMETER width
    Integer for output width
.PARAMETER height
    Integer for output height
.PARAMETER theme
    Themes for rendering: default, forest, dark, neutral
.PARAMETER dir
    Output subdirectory name
.PARAMETER trim
    Trim white surrounding edges or not, if specify, trim
    This option is currently only for pdf format
.PARAMETER fontT
    Render text as font "Times New Roman" if specify
.INPUTS
    None
.OUTPUTS
    None
.EXAMPLE
    PS> .\export_mermaid.ps1 -filename markdown_contains_mermaid.md -ext pdf -width 1920 -height 1080 -theme forest -dir pdf
    PS> dir
    markdown_contains_mermaid.md
    pdf/markdown_contains_mermaid.pdf
.LINK
    https://github.com/belongtothenight/powershell_scripts/blob/main/export_mermaid
.NOTES
    File Name      : export_mermaid.ps1
    Author         : belongtothenight
    Prerequisite   : mmdc (from Mermaid CLI), #acquire by npm install -g @mermaid-js/mermaid.cli
                     awk, 
                     pdfcrop (from MiKTeX)
    Date           : 2024-08-04
    Version        : 1.0
#>

param (
    [Parameter(Mandatory=$false)][string]$filename,
    [Parameter(Mandatory=$false)][string]$ext = "pdf",
    [Parameter(Mandatory=$false)][int]$width = 1920,
    [Parameter(Mandatory=$false)][int]$height = 1080,
    [Parameter(Mandatory=$false)][string]$theme = "default",
    [Parameter(Mandatory=$false)][string]$dir = "mermaid_out",
    [Parameter(Mandatory=$false)][switch]$trim,
    [Parameter(Mandatory=$false)][switch]$fontT
)

# Display simple usage if no filename is provided
if (!$filename) {
    echo "Usage:"
    echo "  .\export_mermaid.ps1 -ext pdf -width 1920 -height 1080 -theme forest-filename markdown_contains_mermaid.md"
    echo "expected input markdown file format:"
    echo "  1 ``````mermaid"
    echo "  2 mermaid code......"
    echo "    ......."
    echo "  n ``````"
    exit
}

#>> check dependencies
function Check-Command {
    param(
        [string]$command
    )
    $command_check = '{0} --version' -f $command | Out-Null
    if ($?) {
        #Write-Host "Installed: $command"
    } else {
        Write-Host ">> $command is not installed."
        Write-Host ">> Please install $command."
        exit 1
    }
}
Check-Command "mmdc"
Check-Command "awk"
Check-Command "pdfcrop"

#>> display options
$tmp_str = "filename:  " + $filename
echo $tmp_str
$tmp_str = "extension: " + $ext
echo $tmp_str
$tmp_str = "width:     " + $width
echo $tmp_str
$tmp_str = "height:    " + $height
echo $tmp_str
$tmp_str = "theme:     " + $theme
echo $tmp_str
$tmp_str = "dir:       " + $dir
echo $tmp_str
if ($trim) {
    $tmp_str = "trim:      True"
} else {
    $tmp_str = "trim:      False"
}
if ($fontT) {
    $tmp_str = "fontT:     True"
} else {
    $tmp_str = "fontT:     False"
}

#>> format output path
$filename = (Get-Item $filename).FullName
$output_fn = [io.path]::GetFileNamewithoutExtension($filename)
$output_base = [io.path]::GetDirectoryName($filename) + "\" + $dir
$mermaid = $output_base + "\" + $output_fn + ".mmd"
$mermaid_tmp = $output_base + "\" + $output_fn + "-tmp.mmd"
$output = $output_base + "\" + $output_fn + "." + $ext

#>> create output directory
New-Item -ItemType Directory -Force -Path $output_base
if ($? -eq $false) {
    $msg = "Can't create output directory"; Write-Host $msg
    exit 1
}

#>> remove line 1 and n
# mermaid in default will export all figures contained
Write-Host "Generating mermaid file"
awk '{if (NR==1) cnt=0}{pre_cnt=cnt}{if ($0 ~ /```/)  cnt=cnt+1}{if ((cnt==1)&&(pre_cnt==1)) print}' $filename > $mermaid
if ($? -eq $false) {
    $msg = "Can't generate mermaid file"; Write-Host $msg
    $msg = "Illegal path " + $filename; Write-Host $msg
    $msg = "Illegal path " + $mermaid; Write-Host $msg
    exit 1
}

#>> insert font setting on line 1
if ($fontT) {
    echo "Inserting font setting"
    awk 'NR==2{print "%%{init: {''themeVariables'':{''fontFamily'': ''Times New Roman''}}}%%"; print};NR!=2{print}' $mermaid > $mermaid_tmp
    if ($? -eq $false) {
        $msg = "Can't insert font settings"; Write-Host $msg
        $msg = "Illegal path " + $mermaid_tmp; Write-Host $msg
    }
    mv -Force $mermaid_tmp $mermaid
}

#>> render mermaid
echo "Exporting mermaid plot"
mmdc -i $mermaid -o $output -b transparent -w $width -H $height -t $theme -s 4
if ($? -eq $false) {
    $msg = "Can't export mermaid plot with mmdc"; Write-Host $msg
    exit 1
}

#>> trim pdf
if ($trim) {
    if ($ext -eq "pdf") {
        echo "Cropping generated PDF file"
        $croppdf = $output_base + "\" + $output_fn + "-crop.pdf"
        pdfcrop $output
        if ($? -eq $false) {
            $msg = "Can't crop generated PDF file"; Write-Host $msg
        }
        echo "Overwriting exported PDF file"
        mv -Force $croppdf $output
    } else {
        $msg = "Unsupported extension for trimming: " + $ext
        Write-Host $msg
    }
}

#>> remove mermaid file
echo "Removing mermaid file"
rm $mermaid
