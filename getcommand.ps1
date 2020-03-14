$loc = ".\command.bat"
try {
    $client_process = Get-CimInstance Win32_Process -Filter "name = 'LeagueClient.exe'"
    Stop-Process $client_process.ProcessId
    $command = $client_process.CommandLine
    $command -replace("zh_TW", "en_US") | Out-File -FilePath "$loc" -Encoding ascii
}
catch {}
finally {& $loc}