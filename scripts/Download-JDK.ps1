$JdkVersion = "11.0.1"
$FileName = "jdk-${JdkVersion}_windows-x64_bin.exe"
$Source = "http://download.oracle.com/otn-pub/java/jdk/${JdkVersion}+13/90cf5d8f270a4347a95050320eef3fb7/${FileName}"
$Destination = "$Env:USERPROFILE\Downloads\$FileName"
$Client = New-Object System.Net.WebClient
$Cookie = "oraclelicense=accept-securebackup-cookie"
$Client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Cookie)
Write-Host "Download $FileName"
$Client.DownloadFile($Source, $Destination)
