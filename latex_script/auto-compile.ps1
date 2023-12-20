$sleep_time = 5
$latex_project_name = "report"
$output_format = @{
	ForegroundColor = "blue"
	# BackgroundColor = "white"
}

Clear-Host

while (1) {
	Write-Host "Clearing screen..." @output_format
	Clear-Host
	Write-Host "Auto-compile script for LaTeX" @output_format
	Write-Host "Project name: $latex_project_name" @output_format
	# Write-Host "Clear the directory..." @output_format
	# Invoke-Expression "make clean"
	Write-Host "Compiling..." @output_format
	Invoke-Expression "make $latex_project_name.pdf -B"
	Write-Host "Available files:" @output_format
	Invoke-Expression "ls -l"
	# Write-Host "Compiling Log:" @output_format
	# Get-Content "$latex_project_name.log"
	Write-Host "You can view generated PDF in path: $(Get-Location)\$latex_project_name.pdf" @output_format
	Write-Host "If you use zathura, use shift+R to reload the PDF file." @output_format
	#Start-Sleep $sleep_time
	while ($sleep_time -gt 0) {
		Write-Host -NoNewline "`rSleeping for $sleep_time seconds..." @output_format
		Start-Sleep 1
		$sleep_time = $sleep_time - 1
	}
	$sleep_time = 5
}
