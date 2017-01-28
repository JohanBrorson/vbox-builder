$JdkVersion = "8u121"
$FileName = "jdk-${JdkVersion}-windows-x64.exe"
$Source = "http://download.oracle.com/otn-pub/java/jdk/${JdkVersion}-b13/e9e7ea248e2c4826b92b3f075a80e441/${FileName}"
$Destination = "$Env:USERPROFILE\Downloads\$FileName"
$Client = New-Object System.Net.WebClient
$Cookie = "oraclelicense=accept-securebackup-cookie"
$Client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Cookie)
Write-Host "Download $FileName"
$Client.DownloadFile($Source, $Destination)
