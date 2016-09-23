$Criteria = "IsInstalled=0 and Type='Software'"

Write-Host "Search for available Microsoft updates"
$Searcher = New-Object -ComObject Microsoft.Update.Searcher
$SearchResult = $Searcher.Search($Criteria).Updates

$UpdatesCount = $SearchResult.Count
Write-Host ("There are {0} updates available" -f $UpdatesCount)
if ($UpdatesCount -eq 0) {
    exit
}

$InstallCollection = New-Object -com "Microsoft.Update.UpdateColl"

$SearchResult | ForEach-Object {
    if (($_.InstallationBehavior.CanRequestUserInput) -or ($_.EulaAccepted -eq $FALSE)) {
        Write-Host ("`tDon't install: {0}" -f $_.Title) -ForegroundColor Yellow
    } else {
        Write-Host ("`tInstall: {0}" -f $_.Title) -ForegroundColor Green
        $InstallCollection.Add($_) | Out-Null
    }
}

Write-Host "Download updates"
$Session = New-Object -ComObject Microsoft.Update.Session
$Downloader = $Session.CreateUpdateDownloader()
$Downloader.Updates = $InstallCollection
$Downloader.Download()

Write-Host "Install updates"
$Installer = $Session.CreateUpdateInstaller()
$Installer.Updates = $InstallCollection
$Result = $Installer.Install()
Write-Host ("Installation complete. Result code: {0}" -f $Result.ResultCode)

if ($Result.RebootRequired) {
    Write-Host "Reboot required, please reboot"
}
