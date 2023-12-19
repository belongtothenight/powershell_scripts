$sleep_time = 5
$latex_project_name = "report"

Write-Host "Clearing screen..."
Clear-Host
Write-Host "Compile for the first time..."
Invoke-Expression "make $latex_project_name.pdf -B"
Write-Host "Open PDF..."
Invoke-Expression "start $latex_project_name.pdf"

while (1) {
	Write-Host "Clearing screen..."
	Clear-Host
	Write-Host "Compiling..."
	Invoke-Expression "make $latex_project_name.pdf -B"
	Write-Host "Available files:"
	Invoke-Expression "ls -l"
	Write-Host "Sleeping for $sleep_time seconds..."
	Start-Sleep $sleep_time
}
