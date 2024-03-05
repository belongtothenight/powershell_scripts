<#
.SYNOPSIS
    Generate a PDF file from a Markdown file using PanDoc.
.DESCRIPTION
    1. Output directory
    2. Create the output directory if it does not exist
    3. Remove the output file if it exists
    4. Convert markdown table format to multiline_tables
    5. Convert the markdown file to the output type
    6. Remove the temporary file
    7. Open the file
.PARAMETER i
    Input file
.PARAMETER d
    Output directory
.PARAMETER t
    Output type
.PARAMETER o
    Output file name (without extension)
.EXAMPLE
    C:\PS> .\md_gen_pdf.ps1 -i w1.md -d pdf -t pdf -o w1
.NOTES
    File Name      : md_gen_pdf.ps1
    Author         : belongtothenight
    Prerequisite   : PanDoc
    Date           : 2024-02-28
    Version        : 1.0
#>

# https://stackoverflow.com/questions/18178084/pandoc-and-foreign-characters
# https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
# https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist
# https://stackoverflow.com/questions/5237723/how-do-i-get-help-messages-to-appear-for-my-powershell-script-parameters

param (
[Parameter(Mandatory=$true)][string]$i = "w1.md", # input file
[Parameter(Mandatory=$true)][string]$d = "pdf",   # output directory
[Parameter(Mandatory=$true)][string]$t = "pdf",   # output type
[Parameter(Mandatory=$true)][string]$o = "w1"     # output file name (without extension)
)
# Usage: .\generate.ps1 -i w1.md -d pdf -t pdf -o w1
$inputparams = ">> Parameters:`
input file:       {0}`
output directory: {1}`
output type:      {2}`
output file:      {3}"`
-f $i, $d, $t, $o
Write-Host $inputparams
$tempfile = '{0}_mt.md' -f $i
$outputfile = '{0}/{1}.{2}' -f $d, $o, $t

# Create the output directory if it does not exist
Write-Host ">> Creating the output directory if it does not exist"
if (!(Test-Path -Path $d)) {
  New-Item -ItemType Directory -Force -Path $d
}

# Remove the output file if it exists
Write-Host ">> Removing the output file if it exists"
if (Test-Path -Path $outputfile) {
  Remove-Item -Path $outputfile
}

# Convert markdown table format to multiline_tables
Write-Host ">> Converting markdown table format to multiline_tables"
pandoc -t markdown-pipe_tables-simple_tables-pipe_tables $i -o $tempfile

# Active PanDoc
Write-Host ">> Converting the markdown file to the output type"
pandoc `
  -f markdown-implicit_figures `
  -t $t `
  $tempfile `
  -o $outputfile `
  --pdf-engine=xelatex `
  -V CJKmainfont="Microsoft JhengHei" `
  -V geometry:margin=0.5in `
  --verbose `

# Remove the temporary file
Write-Host ">> Removing the temporary file"
Remove-Item -Path $tempfile

# Open the file
Write-Host ">> Opening the file"
. $outputfile
