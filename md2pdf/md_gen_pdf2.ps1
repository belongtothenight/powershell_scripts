<#
.SYNOPSIS
    Generate PDF from Markdown speccialized for reference support.
.DESCRIPTION
    1. Create a temporary directory.
    2. Copy the input Markdown file and the BibTeX file to the temporary directory.
    3. Generate an intermediate Markdown file for better table handling.
    4. Generate an intermediate LaTeX file.
    5. Modify the LaTeX file for references.
    6. Generate PDF with references.
    7. Copy the PDF to the output directory.
    8. Remove the temporary directory.
.PARAMETER MdFile
    The input Markdown file.
.PARAMETER RemoveTemp
    Whether to remove the temporary directory. Default is true.
.EXAMPLE
    PS> .\md_gen_pdf2.ps1 -MdFile "test.md"
.EXAMPLE
    PS> .\md_gen_pdf2.ps1 -MdFile "test.md" -OutputDir "pdf"
.EXAMPLE
    PS> .\md_gen_pdf2.ps1 -MdFile "test.md" -OutputDir "pdf" -RemoveTemp $false
.NOTES
    File Name       : md_gen_pdf2.ps1
    Author          : belongtothenight
    Prerequisite    : PanDoc, Gawk, pdflatex, bibtex
    Date            : 2024-04-01
    Version         : 1.0
#>

# [+] Parameter Parsing
param (
    [Parameter(Mandatory=$true)][string]$MdFile,
    [string]$OutputDir = "pdf",
    [string]$TempPath = "tmp",
    [bool]$RemoveTemp = $true
)

function Check-Command {
    param(
        [string]$command
    )
    $command_check = '{0} --version' -f $command | Out-Null
    if ($?) {
        Write-Host "Installed: $command"
    } else {
        Write-Host ">> $command is not installed."
        Write-Host ">> Please install $command."
        exit 1
    }
}

function Check-Path-Create {
    param(
        [string]$Path
    )
    if (Test-Path $Path) {
        Write-Host "Existed: $Path"
    } else {
        Write-Host ">> $Path does not exist."
        Write-Host ">> Creating $Path ..."
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
    }
}

function Check-Path-Exit {
    param(
        [string]$Path
    )
    if (Test-Path -Path $Path) {
        Write-Host "Existed: $Path"
    } else {
        Write-Host ">> $Path does not exist."
        Write-Host ">> Exiting ..."
        exit 1
    }
}

function Check-File-Extension-Exit {
    param(
        [string]$Path,
        [string]$Extension
    )
    if ([io.path]::GetExtension($Path) -ne $Extension) {
        Write-Host ">> $Path is not a $Extension file."
        Write-Host ">> Exiting ..."
        exit 1
    }
}

function If-Fail-Exit {
    param(
        [string]$Command,
        [string]$Message
    )
    Invoke-Expression $Command
    if ($?) {
        Write-Host "$Message is successful."
    } else {
        Write-Host ">> $Message failed."
        exit 1
    }
}

# [+] Initialization
Write-Host ">> Initialization ..."
$RootWorkingDirectory = Get-Location
$ProjName = [io.path]::GetFileNameWithoutExtension($MdFile)
$BibFile = '{0}.bib' -f $ProjName
$tempMdFile = '{0}.tmp.md' -f $ProjName
$TexFile = '{0}.tex' -f $ProjName
$tempTexFile = '{0}.tmp.tex' -f $ProjName

# [+] Display Input Arguments
Write-Host ">> Input Arguments:"
Write-Host "MD File:`t$MdFile"
Write-Host "Output Dir:`t$OutputDir"
Write-Host "Temp Path:`t$TempPath"
Write-Host "Remove Temp:`t$RemoveTemp"

# [+] Check Installation
Write-Host ">> Checking Installation ..."
Check-Command "pandoc"
Check-Command "awk"
Check-Command "pdflatex"
Check-Command "bibtex"

# [+] Check Existence
Write-Host ">> Checking existence ..."
Check-Path-Create $OutputDir
Check-Path-Exit   $MdFile
Check-Path-Exit   $BibFile
Check-File-Extension-Exit $MdFile ".md"

# [+] Create Temporary Directory
Write-Host ">> Creating Temporary Directory ..."
New-Item -Path $TempPath -ItemType Directory -Force | Out-Null

# [+] Copy Files to Temporary Directory
Write-Host ">> Copying Files to Temporary Directory ..."
Copy-Item $MdFile -Destination $TempPath
Copy-Item $BibFile -Destination $TempPath

# [+] Change Directory to Temporary Directory
Set-Location -Path $TempPath

# [+] Generate Intermediate Markdown File for better Table Handling
Write-Host ">> Generating Intermediate Markdown File ..."
pandoc -t markdown-pipe_tables-simple_tables-pipe_tables $MdFile -o $tempMdFile
Remove-Item $MdFile -Force
mv $tempMdFile $MdFile

# [+] Generate Intermediate LaTeX File
Write-Host ">> Generating Intermediate LaTeX File ..."
pandoc `
    -s $MdFile `
    -o $TexFile `
    -V geometry:margin=0.5in `

# [+] Modify LaTeX File for References
Write-Host ">> Modifying LaTeX File for References ..."

awk '{sub(/]{article}/, "]{report}")}1' $TexFile > $tempTexFile
Remove-Item $TexFile -Force
Move-Item -Path $tempTexFile -Destination $TexFile

awk '{sub(/\\begin{document}/, "\\renewcommand{\\bibname}{References}\n\\begin{document}")}1' $TexFile > $tempTexFile
Remove-Item $TexFile -Force
Move-Item -Path $tempTexFile -Destination $TexFile

awk '{sub(/\\end{document}/, "\\bibliography{reference} % File: reference.bib\n\\bibliographystyle{unsrt}\n\\end{document}")}1' $TexFile > $tempTexFile
Remove-Item $TexFile -Force
Move-Item -Path $tempTexFile -Destination $TexFile

# [+] Generate PDF with References
Write-Host ">> Generating PDF with References ..."
If-Fail-Exit -Command "pdflatex $ProjName" -Message "1st pdflatex run"
If-Fail-Exit -Command "bibtex $ProjName"   -Message "bibtex run"
If-Fail-Exit -Command "pdflatex $ProjName" -Message "2nd pdflatex run"
If-Fail-Exit -Command "pdflatex $ProjName" -Message "3rd pdflatex run"

# [+] Copy PDF to Output Directory
Write-Host ">> Copying PDF to Output Directory ..."
If-Fail-Exit -Command "cp reference.pdf ../$OutputDir/" -Message "Copying PDF to Output Directory"

# [+] Return to Original Directory
Set-Location -Path $RootWorkingDirectory

# [+] Remove Temporary Directory
if ($RemoveTemp) {
    Write-Host ">> Removing Temporary Directory ..."
    Remove-Item $TempPath -Force -Recurse
}

Write-Host ">> Done."