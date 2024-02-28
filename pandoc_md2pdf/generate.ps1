# https://stackoverflow.com/questions/18178084/pandoc-and-foreign-characters
# https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
# https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist

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

# Active PanDoc
Write-Host ">> Activating PanDoc"
pandoc `
  -f markdown-implicit_figures `
  -t $t `
  $i `
  -o $outputfile `
  --pdf-engine=xelatex `
  -V CJKmainfont="Microsoft JhengHei" `
  -V geometry:margin=0.5in `

# Open the file
Write-Host ">> Opening the file"
. $outputfile
