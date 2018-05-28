$JdkVersion = "8u171"
$FileName = "jdk-${JdkVersion}-windows-x64.exe"
$Source = "http://download.oracle.com/otn-pub/java/jdk/${JdkVersion}-b11/512cd62ec5174c3487ac17c61aaa89e8/${FileName}"
$Destination = "$Env:USERPROFILE\Downloads\$FileName"
$Client = New-Object System.Net.WebClient
$Cookie = "oraclelicense=accept-securebackup-cookie"
$Client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $Cookie)
Write-Host "Download $FileName"
$Client.DownloadFile($Source, $Destination)
