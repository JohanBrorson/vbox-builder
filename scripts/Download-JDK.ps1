$JdkVersion = "8u131"
$FileName = "jdk-${JdkVersion}-windows-x64.exe"
$Source = "https://edelivery.oracle.com/otn-pub/java/jdk/${JdkVersion}-b11/d54c1d3a095b4ff2b6607d096fa80163/${FileName}"
$Destination = "$Env:USERPROFILE\Downloads\$FileName"
$Client = New-Object System.Net.WebClient
$Cookie = "oraclelicense=accept-securebackup-cookie"
$Client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Cookie)
Write-Host "Download $FileName"
$Client.DownloadFile($Source, $Destination)
