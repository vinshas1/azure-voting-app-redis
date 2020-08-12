$count = 0
do {
    $count++
    Write-output "[$env:STAGE_NAME] Starting container [Attempt: $count]"

    $testStart = Invoke-WebRequest -Uri http://localhost:7000

    if ($testStart.statuscode -eq '200') {
        $started = $true
    } else {
        Start-Sleep -Seconds 1
    }

} until ($Started -or ($count -eq 3))

if (!$started) {
    exit 1
}