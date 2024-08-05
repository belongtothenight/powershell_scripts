<#
.SYNOPSIS
    Generate a script to auto-compile LaTeX project
.DESCRIPTION
    This script will automatically compile the LaTeX project, display the compiling time and the script running time.
.PARAMETER t
    The time interval between each compile. Default is 5 seconds.
.PARAMETER o
    The output file name. Default is "report".
.PARAMETER m
    The makefile name. Default is "Makefile".
.INPUTS
    None
.OUTPUTS
    None
.EXAMPLE
    .\auto-compile.ps1 -t 10 -o "report" -m "Makefile"
.NOTES
    File Name    : auto-compile.ps1
    Author       : belongtothenight
    Prerequisite : make and latex compile environment
    Date         : 2024-03-05
    Notice       : This script is only for Windows PowerShell
    Notice       : Running for a long time may cause memory leak
    Notice       : Require Makefile and latex compile environment
    Notice       : Loading PDF while compiling may cause error or segmentation fault
    Notice       : If this script stucks at some point, try to press ctrl+c and restart it
    Notice       : First run of this script won't number references correctly, but it will re-run automatically.
.LINK
    https://github.com/belongtothenight/powershell_scripts/tree/main/latex_tex2pdf
.LINK
    https://tex.stackexchange.com/questions/87319/how-to-run-tex-from-the-command-line-interface-in-linux
.LINK
    https://stackoverflow.com/questions/49384301/make-clean-failed-in-windows

#>

param (
    [Parameter(Mandatory=$true)][int]$t = 5,
    [Parameter(Mandatory=$true)][string]$o = "report",
    [Parameter(Mandatory=$false)][string]$m = "Makefile"
)

# Check if Makefile exists
if (!(Test-Path "Makefile")) {
    Write-Host "Makefile not found. Please make sure you are in the correct directory." -ForegroundColor Red
    exit
}

# Check if Make is installed
$make_check = make -v
if ($?) {
    Write-Host "Make is not installed. Please install it first." -ForegroundColor Red
    exit
}

# Check if LaTeX is installed
$latex_check = latex --version
if ($?) {
    Write-Host "LaTeX is not installed. Please install it first." -ForegroundColor Red
    exit
}

$sleep_time = $t
$latex_project_name = $o
$makefile_name = $m
$make_clean = 'make -f {0} clean' -f $makefile_name
$make_compile = 'make -f {0} {1}.pdf -B' -f $makefile_name, $latex_project_name
$output_format_info = @{
	ForegroundColor = "blue"
	# BackgroundColor = "white"
}
$output_format_warn = @{
	ForegroundColor = "red"
	# BackgroundColor = "white"
}

$RunTime = [System.Diagnostics.Stopwatch]::StartNew()
$exe_cnt = 0
Clear-Host
Write-Host "Auto-compile script for LaTeX" @output_format_info
Write-Host "Clear the directory..." @output_format_info
Invoke-Expression $make_clean

while (1) {
	Write-Host "Clearing screen..." @output_format_info
	Clear-Host
	$exe_cnt += 1
	$SingleTime = [System.Diagnostics.Stopwatch]::StartNew()
	Write-Host "Compiling..." @output_format_info
	Invoke-Expression $make_compile
	Write-Host "Available files:" @output_format_info
	Invoke-Expression "ls -l"
	# Write-Host "Compiling Log:" @output_format_info
	# Get-Content "$latex_project_name.log"
	$CurrentTime = $SingleTime.Elapsed
	$ElapsedTime = $RunTime.Elapsed
	Write-Host "Compiling time:               $([string]::Format("{0:d2}:{1:d2}:{2:d2}", $CurrentTime.hours, $CurrentTime.minutes, $CurrentTime.seconds))" @output_format_info
	Write-Host "Script has been running for:  $([string]::Format("{0:d2}:{1:d2}:{2:d2}", $ElapsedTime.hours, $ElapsedTime.minutes, $ElapsedTime.seconds))" @output_format_info
	Write-Host "Script compiled count:        $exe_cnt" @output_format_info
	Write-Host "Project name:                 $latex_project_name" @output_format_info
	Write-Host "PDF filepath:                 $(Get-Location)\$latex_project_name.pdf" @output_format_info
	Write-Host "Ref filepath:                 $(Get-Location)\$latex_project_name.bib" @output_format_info # reference filename is based on latex code
	Write-Host "Log filepath:                 $(Get-Location)\$latex_project_name.log" @output_format_info
	Write-Host "If you use zathura, use shift+R to reload the PDF file." @output_format_info
	#Start-Sleep $sleep_time
	while ($sleep_time -gt 0) {
		Write-Host -NoNewline "`rSleeping for $sleep_time seconds... (ctrl+c to stop)" @output_format_warn
		Start-Sleep 1
		$sleep_time = $sleep_time - 1
	}
	$sleep_time = 5
}
