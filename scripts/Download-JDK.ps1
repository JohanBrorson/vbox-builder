$FileName = "jdk-8u101-windows-x64.exe"
$Source = "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/$FileName"
$Destination = "$Env:USERPROFILE\Downloads\$FileName"
$Client = New-Object System.Net.WebClient
$Cookie = "oraclelicense=accept-securebackup-cookie"
$Client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Cookie)
Write-Host "Download $FileName"
$Client.DownloadFile($Source, $Destination)
