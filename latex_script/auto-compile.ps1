$sleep_time = 5
$latex_project_name = "report"
$output_format_info = @{
	ForegroundColor = "blue"
	# BackgroundColor = "white"
}
$output_format_warn = @{
	ForegroundColor = "red"
	# BackgroundColor = "white"
}

$RunTime = [System.Diagnostics.Stopwatch]::StartNew()
Clear-Host
Write-Host "Auto-compile script for LaTeX" @output_format_info

while (1) {
	Write-Host "Clearing screen..." @output_format_info
	Clear-Host
	$SingleTime = [System.Diagnostics.Stopwatch]::StartNew()
	# Write-Host "Clear the directory..." @output_format_info
	# Invoke-Expression "make clean"
	Write-Host "Compiling..." @output_format_info
	Invoke-Expression "make $latex_project_name.pdf -B"
	Write-Host "Available files:" @output_format_info
	Invoke-Expression "ls -l"
	# Write-Host "Compiling Log:" @output_format_info
	# Get-Content "$latex_project_name.log"
	$CurrentTime = $SingleTime.Elapsed
	$ElapsedTime = $RunTime.Elapsed
	Write-Host "Compiling time:               $([string]::Format("{0:d2}:{1:d2}:{2:d2}", $CurrentTime.hours, $CurrentTime.minutes, $CurrentTime.seconds))" @output_format_info
	Write-Host "Script has been running for:  $([string]::Format("{0:d2}:{1:d2}:{2:d2}", $ElapsedTime.hours, $ElapsedTime.minutes, $ElapsedTime.seconds))" @output_format_info
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
