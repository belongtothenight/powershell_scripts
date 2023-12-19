$sleep_time = 5
$latex_project_name = "report"

Write-Host "Clearing screen..."
Clear-Host
Write-Host "Clear the directory..."
Invoke-Expression "make clean"
Write-Host "Compile for the first time..."
Invoke-Expression "make $latex_project_name.pdf -B"

while (1) {
	Write-Host "Clearing screen..."
	Clear-Host
	Write-Host "Clear the directory..."
	Invoke-Expression "make clean"
	Write-Host "Compiling..."
	Invoke-Expression "make $latex_project_name.pdf -B"
	Write-Host "Available files:"
	Invoke-Expression "ls -l"
	Write-Host "You can view generated PDF in path: $(Get-Location)\$latex_project_name.pdf"
	Write-Host "If you use zathura, use shift+R to reload the PDF file."
	#Start-Sleep $sleep_time
	while ($sleep_time -gt 0) {
		Write-Host "Sleeping for $sleep_time seconds..."
		Start-Sleep 1
		$sleep_time = $sleep_time - 1
	}
	$sleep_time = 5
}
