$sleep_time = 10
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
	Write-Host "Compiling..."
	Invoke-Expression "make $latex_project_name.pdf -B"
	Write-Host "Available files:"
	Invoke-Expression "ls -l"
	Write-Host "You can view generated PDF in path: $(Get-Location)\$latex_project_name.pdf"
	Write-Host "Sleeping for $sleep_time seconds..."
	Start-Sleep $sleep_time
}
