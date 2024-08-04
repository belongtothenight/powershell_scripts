<#
.SYNOPSIS
    Use inkspace to convert PDF to PNG.
.DESCRIPTION
    Convert all PDF files in given path to PNG.

    Include:
        1. Man page
        2. Option value display
        3. Dependency check
        4. Error handling
.PARAMETER indir
    Input path containing PDF files.
.PARAMETER outdir
    Output path to hold converted PNG files.
.PARAMETER bo
    Option mapped to "--export-background-opacity" of inkspace
.PARAMETER dpi
    Option mapped to "--export-dpi" of inkspace
.PARAMETER pages
    Option mapped to "--pages" of inkspace
.INPUTS
    None
.OUTPUTS
    None
.EXAMPLE
    PS> .\inkscape_pdf2png.ps1 -indir . -outdir png
    PS> dir
    a.pdf
    png/a.png
.LINK
    https://github.com/belongtothenight/powershell_scripts/blob/main/inkscape_pdf2png
.Link
    https://gist.github.com/chasemc/8d349af458beca7645a7b1ca28493999
.NOTES
    File Name      : inkscape_pdf2png.ps1
    Author         : belongtothenight
    Prerequisite   : inkscape
    Date           : 2024-08-04
    Version        : 1.0
#>

param (
    [Parameter(Mandatory=$false)][string]$indir = ($pwd).Path,
    [Parameter(Mandatory=$false)][string]$outdir = ($pwd).Path,
    [Parameter(Mandatory=$false)][int]$bo = 0,
    [Parameter(Mandatory=$false)][int]$dpi = 300,
    [Parameter(Mandatory=$false)][string]$pages = "1"
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
Check-Command "inkscape"

#>> Obtain full input dir path
$tmpdir = Get-Item $indir
if ($? -eq $false) {
    $msg = "Path doesn't exist: " + $indir; Write-Host $msg
    exit 1
} else {
    $indir = $tmpdir
}

#>> Obtain full output dir path
# If not exist, create it
$tmpdir = Get-Item $outdir
if ($? -eq $false) {
    $msg = "Path doesn't exist: " + $outdir; Write-Host $msg
    $outdir = ($pwd).Path + "\" + $outdir
    Write-Host $outdir
    New-Item -ItemType Directory -Force -Path $outdir
    if ($? -eq $false) {
        $msg = "Can't create path: " + $outdir; Write-Host $msg
        exit 1
    }
    $outdir = (Get-Item $outdir).FullName
} else {
    $outdir = $tmpdir
}

#>> display options
$msg = "indir:  " + $indir; Write-Host $msg
$msg = "outdir: " + $outdir; Write-Host $msg
$msg = "bo:     " + $bo; Write-Host $msg
$msg = "dpi:    " + $dpi; Write-Host $msg
$msg = "pages:  " + $pages; Write-Host $msg

$cnt = 0
Get-ChildItem $indir -Filter *.pdf |
Foreach-Object {
    $cnt = $cnt + 1
    $filename = $_.FullName
    $output_fn = [io.path]::GetFileNamewithoutExtension($filename)
    $output = $outdir + "\" + $output_fn
    $msg = "File " + $cnt.tostring() + " processing: " + $output + ".png"; Write-Host $msg
    inkscape --export-background-opacity=$bo --export-dpi=$dpi --export-type=png --pages=$pages $file -o $output
    if ($? -eq $false) {
        $msg = "Can't process: " + $file; Write-Host $msg
    }
}
if ($? -eq $false) {
    $msg = "Invalid path: " + $indir; Write-Host $msg
    exit 1
}
$msg = "Total " + $cnt.tostring() + " file is converted"; Write-Host $msg
