<#
.SYNOPSIS
    Generate a PDF file from a Markdown file using PanDoc.
.DESCRIPTION
    1. Check if PanDoc is installed
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
.INPUTS
    None
.OUTPUTS
    None
.EXAMPLE
    PS> .\md_gen_pdf.ps1 -i w1.md -d pdf -t pdf -o w1
    PS> dir
    pdf/w1.md
    pdf/w1_mt.md.tmp (deleted)
    pdf/w1.pdf
.EXAMPLE
    PS> .\md_gen_pdf.ps1 -i server.md -d pdf -t pdf -o server
    pdf/server.md
    pdf/server_mt.md.tmp (deleted)
    pdf/server.pdf
.LINK
    https://github.com/belongtothenight/powershell_scripts/tree/main/pandoc_md2pdf
.LINK
    https://stackoverflow.com/questions/18178084/pandoc-and-foreign-characters
.LINK
    https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
.LINK
    https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist
.LINK
    https://stackoverflow.com/questions/5237723/how-do-i-get-help-messages-to-appear-for-my-powershell-script-parameters
.LINK
    https://pandoc.org/MANUAL.html#tables
.LINK
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.4
.LINK
    https://stackoverflow.com/questions/8693675/check-if-a-command-has-run-successfully
.NOTES
    File Name      : md_gen_pdf.ps1
    Author         : belongtothenight
    Prerequisite   : PanDoc
    Date           : 2024-02-28
    Version        : 1.0
#>

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
$tempfile = '{0}_mt.md.tmp' -f $i
$outputfile = '{0}/{1}.{2}' -f $d, $o, $t

# Check if PanDoc is installed
Write-Host ">> 1. Checking if PanDoc is installed"
$pandoc_check = pandoc -v
if ($?) {
  Write-Host ">> PanDoc is installed"
} else {
  Write-Host ">> PanDoc is not installed"
  Write-Host ">> Please install PanDoc"
  Write-Host ">> https://pandoc.org/installing.html"
  exit
}

# Create the output directory if it does not exist
Write-Host ">> 2. Creating the output directory if it does not exist"
if (!(Test-Path -Path $d)) {
  New-Item -ItemType Directory -Force -Path $d
}

# Remove the output file if it exists
Write-Host ">> 3. Removing the output file if it exists"
if (Test-Path -Path $outputfile) {
  Remove-Item -Path $outputfile
}

# Convert markdown table format to multiline_tables
Write-Host ">> 4. Converting markdown table format to multiline_tables"
pandoc -t markdown-pipe_tables-simple_tables-pipe_tables $i -o $tempfile

# Active PanDoc
Write-Host ">> 5. Converting the markdown file to the output type"
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
Write-Host ">> 6. Removing the temporary file"
Remove-Item -Path $tempfile

# Open the file
Write-Host ">> 7. Opening the file"
if (Test-Path -Path $outputfile) {
  Start-Process $outputfile
} else {
  Write-Host ">> PanDoc failed to generate the file"
  Write-Host ">> Please check the error message above"
  Write-Host ">> Make sure `" `' characters are escaped with `\"
}
